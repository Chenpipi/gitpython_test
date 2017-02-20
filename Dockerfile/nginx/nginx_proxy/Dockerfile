FROM registry:5000/centos:6.7

MAINTAINER Ivan.chen "chen.feng@opg.cn"

RUN yum -y install nginx ca-certificates wget && yum clean all

RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
  && sed -i 's/^http {/&\n    server_names_hash_bucket_size 128;/g' /etc/nginx/nginx.conf


ADD files/forego /usr/local/bin/forego
RUN chmod u+x /usr/local/bin/forego

# install docker-gen
ADD files/docker-gen-linux-amd64-0.7.3.tar.gz /usr/local/bin/

COPY config /app
WORKDIR /app/

ENV DOCKER_HOST unix:///tmp/docker.sock

VOLUME ["/etc/nginx/certs"]

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]
