FROM registry:5000/tomcat:7

MAINTAINER Ivan.chen "chen.feng@opg.cn"

ENV EPG_VERSION B2C_EPG.3.8.1_20160831.01

ENV REFRESHED_AT 2016.12.16

RUN mkdir -p /usr/nettv/apps/epg

ADD files/${EPG_VERSION}.war /usr/nettv/apps/

RUN unzip -o -d /usr/nettv/apps/epg/ /usr/nettv/apps/${EPG_VERSION}.war

RUN rm -f /usr/nettv/apps/${EPG_VERSION}.war

RUN mkdir -p /usr/nettv/conf/epg

ADD files/epg.xml /usr/nettv/tools/apache-tomcat-7.0.56/conf/Catalina/localhost/

ADD files/catalina.sh /usr/nettv/tools/apache-tomcat-7.0.56/bin/

VOLUME /usr/nettv/apps/epg/WEB-INF/conf /usr/nettv/logs

CMD ["catalina.sh","run"]
