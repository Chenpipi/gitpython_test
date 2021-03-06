FROM ubuntu:16.04
ADD http://stedolan.github.io/jq/download/linux64/jq /usr/bin/
RUN chmod +x /usr/bin/jq
RUN apt-get update && apt-get install -y \
    curl \
    tcpdump \
    vim-tiny \
    openssl \
    libssl-dev \
    rsyslog \
    wget \
    software-properties-common && \
    add-apt-repository ppa:vbernat/haproxy-1.6 && \
    apt-get update && apt-get install -y haproxy && \
    rm -rf /var/lib/apt/lists

RUN mkdir -p /etc/haproxy/

COPY lb-controller /usr/bin/
COPY scripts/* /usr/bin/
COPY config/* /etc/haproxy/

RUN mkdir /var/log/haproxy
RUN touch /var/log/haproxy/traffic /var/log/haproxy/events /var/log/haproxy/errors
RUN cat /etc/haproxy/logrotate.cfg >> /etc/logrotate.d/haproxy

ENV TINI_VERSION v0.10.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ENV SSL_SCRIPT_COMMIT 98660ada3d800f653fc1f105771b5173f9d1a019
RUN wget -O /usr/bin/update-rancher-ssl https://raw.githubusercontent.com/rancher/rancher/${SSL_SCRIPT_COMMIT}/server/bin/update-rancher-ssl && \
    chmod +x /usr/bin/update-rancher-ssl

COPY lb-controller.sh /usr/bin/

ENV CATTLE_URL=http://10.50.131.133/v1
ENV CATTLE_CONFIG_URL=http://10.50.131.133/v1

# So we do not write to the COW filesystem
VOLUME /var/log/haproxy

ENTRYPOINT ["/tini", "--"]

CMD ["lb-controller.sh", "--controller", "rancher", "--provider",  "haproxy"]
