FROM 10.50.131.32:8080/library/centos:6.7

MAINTAINER Ivan.chen chen.feng@opg.cn

COPY files/OpenResty.repo /etc/yum.repos.d/

RUN yum -y install openresty vim tree sysstat wget initscripts && yum clean all

RUN mkdir -p /etc/{rancher-gen,confd/{conf.d,templates}}

COPY templates/nginx.tmpl /etc/rancher-gen/

COPY templates/config.toml /etc/rancher-gen/

COPY templates/lua /usr/local/openresty/

COPY templates/lib /usr/local/openresty/luajit/lib/lua/5.1

COPY templates/share /usr/local/openresty/luajit/share/lua/5.1

COPY templates/logrotate.nginx /etc/logrotate.d/nginx

COPY templates/nginx.conf /usr/local/openresty/nginx/conf/

COPY files/rancher-gen /usr/bin/

VOLUME /usr/local/openresty/nginx/conf/ /usr/local/openresty/lua/ /etc/rancher-gen/ /var/log/nginx/

ENTRYPOINT /etc/init.d/openresty start && /usr/bin/rancher-gen --config=/etc/rancher-gen/config.toml
