FROM centos:6.7

MAINTAINER Ivan.chen "chen.feng@opg.cn"

ENV REFRESHED_AT 2016.12.19

RUN rm -f /etc/yum.repos.d/*

ADD files/rhel-debuginfo.repo /etc/yum.repos.d/

RUN rm -f /etc/localtime && /bin/ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

CMD []
