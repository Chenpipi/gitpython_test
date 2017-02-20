FROM registry:5000/tomcat:7

MAINTAINER Ivan.chen "dust.chenfeng@gmail.com"

ENV SEARCH_VERSION B2C_SEARCH.4.0.1_20161229.01

ENV REFRESHED_AT 2016.12.16

RUN mkdir -p /usr/nettv/apps/search

ADD files/${SEARCH_VERSION}.war /usr/nettv/apps/

RUN unzip -o -d /usr/nettv/apps/search/ /usr/nettv/apps/${SEARCH_VERSION}.war

RUN rm -f /usr/nettv/apps/${SEARCH_VERSION}.war

RUN mkdir -p /usr/nettv/conf/search

ADD files/search.xml /usr/nettv/tools/apache-tomcat-7.0.56/conf/Catalina/localhost/

ADD files/catalina.sh /usr/nettv/tools/apache-tomcat-7.0.56/bin/

VOLUME /usr/nettv/lucene /usr/nettv/logs /usr/nettv/apps/search/WEB-INF/conf

CMD ["catalina.sh","run"]
