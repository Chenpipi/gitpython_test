FROM registry:5000/tomcat:7

MAINTAINER Ivan.chen "chen.feng@opg.cn"

ENV EXPORT_VERSION B2C_EXPORT.4.0.0_20161123.02

ENV REFRESHED_AT 2016.12.16

RUN mkdir -p /usr/nettv/apps/export

ADD files/${EXPORT_VERSION}.war /usr/nettv/apps/

RUN unzip -o -d /usr/nettv/apps/export/ /usr/nettv/apps/${EXPORT_VERSION}.war

RUN rm -f /usr/nettv/apps/${EXPORT_VERSION}.war

RUN mkdir -p /usr/nettv/conf/export

ADD files/export.xml /usr/nettv/tools/apache-tomcat-7.0.56/conf/Catalina/localhost/

ADD files/catalina.sh /usr/nettv/tools/apache-tomcat-7.0.56/bin/

VOLUME /usr/nettv/apps/export/WEB-INF/conf /usr/nettv/logs /usr/nettv/conf/export /usr/nettv/lucene

CMD ["catalina.sh","run"]
