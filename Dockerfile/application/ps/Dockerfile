FROM 10.50.131.32:8080/library/tomcat:7

MAINTAINER Ivan.chen "dust.chenfeng@gmail.com"

ARG APP_VERSION

ENV REFRESHED_AT 2016.12.23

RUN mkdir -p /usr/nettv/apps/ps

ADD files/${APP_VERSION}.war /usr/nettv/apps/

RUN unzip -o -d /usr/nettv/apps/ps/ /usr/nettv/apps/${APP_VERSION}.war

RUN rm -f /usr/nettv/apps/${APP_VERSION}.war

RUN mkdir -p /usr/nettv/conf/ps

ADD files/ps.xml /usr/nettv/tools/apache-tomcat-7.0.56/conf/Catalina/localhost/

ADD files/catalina.sh /usr/nettv/tools/apache-tomcat-7.0.56/bin/

ADD files/log4j.properties /usr/nettv/apps/ps/WEB-INF/conf/

VOLUME /usr/nettv/conf/ps /usr/nettv/logs

CMD ["catalina.sh","run"]
