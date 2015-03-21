FROM selimekizoglu/baseimage:latest
RUN apt-get update -y
RUN apt-get install wget unzip haproxy dnsmasq tar -y

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

# Add runit configuration for haproxy
ADD haproxy-runit /etc/service/haproxy/run
RUN chmod 755 /etc/service/haproxy/run

ADD haproxy.ctmpl /tmp/ 
RUN chmod 644 /tmp/haproxy.ctmpl

ADD dnsmasq.conf /etc/dnsmasq.d/10-consul
RUN chmod 644 /etc/dnsmasq.d/10-consul

# Add runit configuration for dnsmasq
ADD dnsmasq-runit /etc/service/dnsmasq/run
RUN chmod 755 /etc/service/dnsmasq/run

RUN wget https://github.com/hashicorp/consul-template/releases/download/v0.7.0/consul-template_0.7.0_linux_amd64.tar.gz
RUN tar -xvzf consul-template_0.7.0_linux_amd64.tar.gz -C /opt/consul/ && mv /opt/consul/consul-template_0.7.0_linux_amd64 /opt/consul/consul-template
RUN rm consul-template_0.7.0_linux_amd64.tar.gz

# Add runit configuration for consul-template
ADD consul-template-runit /etc/service/consul-template/run
RUN chmod 755 /etc/service/consul-template/run

ENV HOME /root
ENTRYPOINT [ "/sbin/my_init" ]
