FROM registry:5000/tomcat:7

MAINTAINER Ivan.chen "dust.chenfeng@gmail.com"

ENV PS_VERSION B2C_PS_4.3.0.5_20160720

ENV REFRESHED_AT 2016.12.23

RUN mkdir -p /usr/nettv/apps/ps

ADD files/${PS_VERSION}.war /usr/nettv/apps/

RUN unzip -o -d /usr/nettv/apps/ps/ /usr/nettv/apps/${PS_VERSION}.war

RUN rm -f /usr/nettv/apps/${PS_VERSION}.war

RUN mkdir -p /usr/nettv/conf/ps

ADD files/ps.xml /usr/nettv/tools/apache-tomcat-7.0.56/conf/Catalina/localhost/

ADD files/catalina.sh /usr/nettv/tools/apache-tomcat-7.0.56/bin/

ADD files/log4j.properties /usr/nettv/apps/ps/WEB-INF/conf/

VOLUME /usr/nettv/conf/ps /usr/nettv/logs

CMD ["catalina.sh","run"]
