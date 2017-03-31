FROM 10.50.131.32:8080/library/centos:6.7

MAINTAINER Ivan.chen "chen.feng@opg.cn"

RUN yum -y install initscripts nginx_ly vixie-cron vim wget && yum clean all

RUN mkdir -p /etc/confd/{conf.d,templates}

RUN mkdir -p /etc/rancher-gen/

COPY templates/nginx.tmpl /etc/rancher-gen/

COPY templates/config.toml /etc/rancher-gen/

COPY templates/lua /usr/local/nginx/lua

COPY templates/logrotate.nginx /etc/logrotate.d/nginx

COPY templates/nginx.conf /usr/local/nginx/conf/

COPY files/rancher-gen /usr/bin/

VOLUME /usr/local/nginx/conf/ /usr/local/nginx/lua/ /etc/rancher-gen/ /var/log/nginx/

ENTRYPOINT /etc/init.d/nginx start
