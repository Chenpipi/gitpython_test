FROM registry:5000/tomcat_7:basic

MAINTAINER Ivan.chen "dust.chenfeng@gmail.com"

ENV REFRESHED_AT 2016.12.16

RUN mkdir -p /usr/nettv/apps/tv

ADD files/SHCK_AAA_2.16.3_UNI_build20151015.war /usr/nettv/apps/

RUN unzip -o -d /usr/nettv/apps/tv/ /usr/nettv/apps/SHCK_AAA_2.16.3_UNI_build20151015.war

RUN rm -f /usr/nettv/apps/SHCK_AAA_2.16.3_UNI_build20151015.war

RUN mkdir /usr/nettv/conf

ADD files/tv.xml /usr/nettv/tools/apache-tomcat-7.0.56/conf/Catalina/localhost/

ADD files/catalina.sh /usr/nettv/tools/apache-tomcat-7.0.56/bin/

ADD config /usr/nettv/conf/aaa

RUN tail -f /usr/nettv/tools/apache-tomcat-7.0.56/logs/catalina.out

CMD []
