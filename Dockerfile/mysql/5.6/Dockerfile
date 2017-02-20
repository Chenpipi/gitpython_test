FROM centos:6

MAINTAINER Ivan.chen "dust.chenfeng@gmail.com"

ENV REFRESHED_AT 2016.04.12

ADD files/mysql56.repo /etc/yum.repos.d/

RUN yum -y install mysql-community-client mysql-community-server

RUN yum clean all

VOLUME /var/lib/mysql

ADD files/jforum.sql /tmp/jforum.sql

COPY files/entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3306

CMD ["mysqld_safe"]
