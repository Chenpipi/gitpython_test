FROM registry:5000/tomcat:7

MAINTAINER Ivan.chen "chen.feng@opg.cn"

ENV AAA_VERSION B2C_AAA_3.1.2.8_20160413

ENV REFRESHED_AT 2016.12.16

RUN mkdir -p /usr/nettv/apps/tv

ADD files/${AAA_VERSION}.war /usr/nettv/apps/

RUN unzip -o -d /usr/nettv/apps/tv/ /usr/nettv/apps/${AAA_VERSION}.war

RUN rm -f /usr/nettv/apps/${AAA_VERSION}.war

RUN mkdir -p /usr/nettv/conf/aaa

ADD files/tv.xml /usr/nettv/tools/apache-tomcat-7.0.56/conf/Catalina/localhost/

ADD files/catalina.sh /usr/nettv/tools/apache-tomcat-7.0.56/bin/

ADD files/log4j.properties /usr/nettv/apps/tv/WEB-INF/conf/

VOLUME /usr/nettv/conf/aaa /usr/nettv/logs

CMD ["catalina.sh", "run"]
