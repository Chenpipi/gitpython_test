FROM 10.50.131.32:8080/library/tomcat:7

MAINTAINER Ivan.chen chen.feng@opg.cn

ARG APP_VERSION

ENV REFRESHED_AT 2016.12.16

RUN mkdir -p /usr/nettv/apps/wag

ADD files/${APP_VERSION}.war /usr/nettv/apps/

RUN unzip -o -d /usr/nettv/apps/wag/ /usr/nettv/apps/${APP_VERSION}.war

RUN rm -f /usr/nettv/apps/${APP_VERSION}.war

RUN mkdir -p /usr/nettv/conf/wag

ADD files/wag.xml /usr/nettv/tools/apache-tomcat-7.0.56/conf/Catalina/localhost/

ADD files/catalina.sh /usr/nettv/tools/apache-tomcat-7.0.56/bin/

VOLUME /usr/nettv/apps/wag/WEB-INF/conf /usr/nettv/logs /usr/nettv/conf/wag

CMD ["catalina.sh","run"]
