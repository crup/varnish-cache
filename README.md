## Varnish Cache
- Added devicedetect (https://github.com/varnishcache/varnish-devicedetect)
- Add conditional caching - WIP
- Add prod ready parameters - WIP

## Start/Rebuild the service

```
docker-compose up --build --force-recreate
```

## Test if Node app working

```
curl -o /dev/null -s -w 'Total: %{time_total}s\n'  http://localhost:3000/test\?delay\=200
```

## Test if Varnish cache is working
Hit this command twice and check the response time

```
curl -o /dev/null -s -w 'Total: %{time_total}s\n'  http://localhost/test\?delay\=200
```