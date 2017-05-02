FROM 10.50.131.32:8080/library/centos:6.7

MAINTAINER Ivan.chen chen.feng@opg.cn

ARG APP_VERSION

ENV REFRESHED_AT 2016.12.16

RUN yum -y install initscripts nginx_ly syslog-ng libdbi  syslog-ng-libdbi  vixie-cron vim wget && yum clean all

RUN mkdir -p /usr/local/nginx/lua_v2

COPY files/lua_v2 /usr/local/nginx/lua_v2

RUN chmod +x  /usr/local/nginx/lua_v2/cache.lua
RUN chmod +x  /usr/local/nginx/lua_v2/logging
RUN chmod +x  /usr/local/nginx/lua_v2/logging.lua
RUN chmod +x  /usr/local/nginx/lua_v2/resty
RUN chmod +x  /usr/local/nginx/lua_v2/rotate.sh

ADD files/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
VOLUME /etc/syslog-ng

ADD files/nginx.conf /usr/local/nginx/conf/nginx.conf

EXPOSE 80
ENTRYPOINT /etc/init.d/syslog-ng start && /etc/init.d/nginx start
