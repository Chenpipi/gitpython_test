FROM centos:6

MAINTAINER Ivan.chen "dust.chenfeng@gmail.com"

ENV REFRESHED_AT 2016.04.12

ADD files/mysql56.repo /etc/yum.repos.d/

RUN yum -y install mysql-community-client

RUN yum clean all

VOLUME /tmp

ENTRYPOINT ["mysql"]
