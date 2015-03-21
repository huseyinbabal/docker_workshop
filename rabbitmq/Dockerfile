FROM selimekizoglu/baseimage:latest
RUN apt-get update -y && apt-get install -y wget unzip build-essential supervisor

RUN wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
RUN apt-key add rabbitmq-signing-key-public.asc
RUN echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list
RUN apt-get update
RUN apt-get -y -q install rabbitmq-server
RUN /usr/sbin/rabbitmq-plugins enable rabbitmq_management
RUN echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config

ADD rabbitmq-runit /etc/service/rabbitmq/run
RUN chmod 755 /etc/service/rabbitmq/run

RUN wget https://dl.bintray.com/mitchellh/consul/0.4.1_linux_amd64.zip
RUN mkdir /opt/consul
RUN unzip 0.4.1_linux_amd64.zip -d /opt/consul
RUN rm 0.4.1_linux_amd64.zip
RUN mkdir /var/consul
RUN mkdir /etc/consul.d
RUN mkdir /etc/service/consul

# Disable ssh 
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

ADD bootstrap.json /etc/consul.d/bootstrap.json
RUN chmod 644 /etc/consul.d/bootstrap.json

# Add runit configuration for consul
ADD consul-runit /etc/service/consul/run
RUN chmod 755 /etc/service/consul/run

ADD dnsmasq.conf /etc/dnsmasq.d/10-consul
RUN chmod 644 /etc/dnsmasq.d/10-consul

# Add runit configuration for dnsmasq
ADD dnsmasq-runit /etc/service/dnsmasq/run
RUN chmod 755 /etc/service/dnsmasq/run

ENV HOME /root
ENTRYPOINT [ "/sbin/my_init" ]
