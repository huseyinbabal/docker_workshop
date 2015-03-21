FROM phusion/baseimage:latest
RUN apt-get update -y
RUN apt-get install wget unzip -y

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

ENV HOME /root
ENTRYPOINT [ "/sbin/my_init" ]
