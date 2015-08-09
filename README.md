# docker-sinatra-example
Simple example of docker compose with sinatra and postgres.

### How to launch:
```
docker-compose build
docker-compose up -d db
docker-compose up -d --no-recreate
docker-compose ps
```

### When you need to rebuild web:
```
docker-compose build web
docker-compose stop web && docker-compose up -d --no-recreate
```
