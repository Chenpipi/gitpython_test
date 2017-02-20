FROM centos:6

MAINTAINER Ivan.chen "dust.chenfeng@gmail.com"

ADD files/atomic.repo /etc/yum.repos.d/

RUN yum -y install redis

RUN yum clean all

VOLUME ["/var/lib/redis","/var/log/redis/"]

EXPOSE 6379

CMD []
