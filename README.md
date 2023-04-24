## Start/Rebuild the service

```
docker-compose up --build --force-recreate
```

## Test if it's working

```
curl -o /dev/null -s -w 'Total: %{time_total}s\n'  http://localhost:3000/test\?delay\=200
```