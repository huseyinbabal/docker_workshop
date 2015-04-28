#!/bin/bash

OLD="172.17.1.226"
NEW=$1
sed -i "s/$OLD/$NEW/g" *

TAG="mongodb"
IMAGE=$(docker images | grep "$TAG" | awk '{print $3}')

if [[ -z $IMAGE ]]; then
  echo "Building image"
  docker build --no-cache -t $TAG .
fi
CID=$(docker run -d -p 27017:27017 --dns 127.0.0.1 $TAG)
IP=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' $CID)
PORT=$(docker inspect -f '{{range $p, $conf := .NetworkSettings.Ports}}{{(index $conf 0).HostPort}}{{end}}' $CID)
echo "MongoDB running at $IP:$PORT"

docker exec -i $CID /bin/bash -c 'echo "{\"service\": {\"name\": \"mongo\", \"tags\": [\"prod\"], \"port\": '$PORT'}}" >> /etc/consul.d/mongo.json'
docker exec -i $CID /bin/bash -c 'pidof consul | xargs kill -9'
