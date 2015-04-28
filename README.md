# docker_workshop

> Great thanks to [Selim Ekizoglu](https://github.com/selimekizoglu) for helping me to integrate consul with Docker, and make me learn lots of things about devops best practices

Istanbul Coders Workshop for Scalable Systems with Docker and Consul. You can access presentation [here](https://docs.google.com/presentation/d/1Y0ESRVkZhS87CTHzTEdBL86jUsfvYPydEf2-uBLmFSU/edit?usp=sharing)

## Running all the system
### Consul
Go to consul folder and execute `./run.sh` . After successfull run, you will get an IP within a result like 
**Successfully built ce71c193fcc0
172.17.0.15**

### RabbitMQ
Go to rabbitmq folder and execute `./run.sh <consul_ip>` (You get above)

### MongoDB
Go to mongodb folder and execute `./run.sh <consul_ip>`

### App
Go to app folder and execute `./run.sh <consul_ip>`

### HAProxy
Go to haproxy folder and execute `./run.sh <consul_ip>`

When you have successfully run all the containers, you can see them by `docker ps` .

### See which instances regsitered it self to consul server

`curl http://172.17.0.15:8500/v1/catalog/services?pretty=1`

## Note: You need to use vm ip instead of the ip above. For example, if you are using boot2docker, get the ip first by using command `boot2docker ip` and than use that ip to list consul catalog
