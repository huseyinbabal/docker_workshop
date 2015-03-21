#!/bin/bash

OLD="172.17.1.226"
NEW=$1
sed -i "s/$OLD/$NEW/g" *

TAG="app"
PORT=9091
IMAGE=$(docker images | grep "$TAG" | awk '{print $3}')

if [[ -z $IMAGE ]]; then
  echo "Building image"
  docker build --no-cache -t $TAG .
fi
BIND=`ifconfig eth0 | grep "inet addr" | awk '{ print substr($2,6) }'`
CID=$(docker run -d -p $PORT --dns 127.0.0.1 $TAG)
IP=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' $CID)
echo "Service running at $IP:$PORT"

docker exec -i $CID /bin/bash -c 'echo "{\"service\": {\"name\": \"app\", \"tags\": [\"prod\"], \"port\": '$PORT'}}" >> /etc/consul.d/app.json'
docker exec -i $CID /bin/bash -c 'pidof consul | xargs kill -9'
