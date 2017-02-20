FROM registry:5000/centos:6.7

MAINTAINER Ivan.chen "chen.feng@opg.cn"

ENV REFRESHED_AT 2016.12.14

RUN mkdir -p /usr/nettv/{tools,apps,logs}

RUN yum -y install tomcat7_jre7 unzip && yum clean all

RUN mkdir -p /usr/nettv/tools/apache-tomcat-7.0.56/conf/Catalina/localhost

RUN ln -s /usr/nettv/tools/apache-tomcat-7.0.56/bin/catalina.sh /usr/bin/catalina.sh

COPY files/server.xml /usr/nettv/tools/apache-tomcat-7.0.56/conf/

RUN chown tomcat.tomcat /usr/nettv/tools/apache-tomcat-7.0.56/conf/server.xml && chmod 600 /usr/nettv/tools/apache-tomcat-7.0.56/conf/server.xml

EXPOSE 8080

CMD []
