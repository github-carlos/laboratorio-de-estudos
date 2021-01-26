# executar a application e instala imagem
docker run --name postgres -e POSTGRES_USER=carlos -e POSTGRES_PASSWORD=minhasenhasecreta -e POSTGRES_DB=heroes \
-p 5432:5432 -d postgres

# lista todos containers na maquina
docker ps

# entrar no container para rodar comandos la dentro
docker exec -it postgres /bin/bash

# instalar uma imagem que vai servir de painel adminstrativo para usar o postgres
# o `link` da permissao para a imagem linkar a imagem postgres
docker run \
--name adminer \
-p 8080:8080 \
--link postgres:postgres \
-d \
adminer

# MONGODB

docker run --name mongodb \
-p 27017:27017 \
-e MONGO_INITDB_ROOT_USERNAME=admin \
-e MONGO_INITDB_ROOT_PASSWORD=minhasenhasecreta \
-d \
mongo

# cliente para mongodb
docker run --name mongoclient \
-p 3000:3000 \
--link mongodb:mongoddb \
-d \
mongoclient/mongoclient

# interagir com a instancia
docker exec -it mongodb \
mongo --host localhost -u admin -p minhasenhasecreta --authenticationDatabase admin \
--eval "db.getSiblingDB('herois').createUser({user: 'carlos', pwd: 'minhasenhasecreta', roles: [{role: 'readWrite', db: 'herois'}]})"