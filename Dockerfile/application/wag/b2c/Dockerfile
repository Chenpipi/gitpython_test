FROM registry:5000/tomcat:7

MAINTAINER Ivan.chen "chen.feng@opg.cn"

ENV WAG_VERSION B2C_WAG_2.6.0.1_20160122

ENV REFRESHED_AT 2016.12.16

RUN mkdir -p /usr/nettv/apps/wag

ADD files/${WAG_VERSION}.war /usr/nettv/apps/

RUN unzip -o -d /usr/nettv/apps/wag/ /usr/nettv/apps/${WAG_VERSION}.war

RUN rm -f /usr/nettv/apps/${WAG_VERSION}.war

RUN mkdir -p /usr/nettv/conf/wag

ADD files/wag.xml /usr/nettv/tools/apache-tomcat-7.0.56/conf/Catalina/localhost/

ADD files/catalina.sh /usr/nettv/tools/apache-tomcat-7.0.56/bin/

VOLUME /usr/nettv/apps/wag/WEB-INF/conf /usr/nettv/logs /usr/nettv/conf/wag

CMD ["catalina.sh","run"]
