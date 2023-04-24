vcl 4.1;
include "devicedetect.vcl";

backend default{
    .host = "web";
    .port = "3000";
    .connect_timeout = 10s;
    .first_byte_timeout = 15s;
    .between_bytes_timeout = 60s;
    .max_connections = 800;
}

sub vcl_recv {
    unset req.http.cookie;
    call devicedetect;
}

sub vcl_backend_response {
	if (beresp.ttl <= 0s) {
	    set beresp.ttl = 120s;
	    set beresp.uncacheable = false;
	    return (deliver);
	}
  if (bereq.http.X-UA-Device) {
    if (!beresp.http.Vary) {
      set beresp.http.Vary = "X-UA-Device";
    } elsif (beresp.http.Vary !~ "X-UA-Device") {
      set beresp.http.Vary = beresp.http.Vary + ", X-UA-Device";
    }
  }
  set beresp.http.X-UA-Device = bereq.http.X-UA-Device;
	return (deliver);
}

sub vcl_deliver {
	if (obj.hits > 0) {
    set resp.http.X-Cache = "HIT";
  } else {
    set resp.http.X-Cache = "MISS";
  }

  if ((req.http.X-UA-Device) && (resp.http.Vary)) {
    set resp.http.Vary = regsub(resp.http.Vary, "X-UA-Device", "User-Agent");
  }
}