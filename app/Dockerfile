FROM selimekizoglu/baseimage:latest
RUN \	
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update -y && \
  apt-get install -y oracle-java8-installer && \
  apt-get install -y wget unzip dnsmasq git build-essential && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

WORKDIR /usr/bin
RUN wget https://services.gradle.org/distributions/gradle-2.1-all.zip && \
    unzip gradle-2.1-all.zip && \
    ln -s gradle-2.1 gradle && \
    rm gradle-2.1-all.zip

ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

RUN mkdir -p /var/logs

WORKDIR /opt
RUN git clone https://github.com/huseyinbabal/restful-chat-service
WORKDIR restful-chat-service
RUN gradle clean build
RUN cp build/libs/restful-chat-service-0.1.0.jar /opt/

#EXPOSE 9091

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

ADD app-runit /etc/service/app/run
RUN chmod 755 /etc/service/app/run

ENV HOME /root
ENTRYPOINT [ "/sbin/my_init" ]
