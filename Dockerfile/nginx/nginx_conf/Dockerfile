FROM janeczku/rancher-gen:latest
COPY files/config.toml /etc/rancher-gen/
COPY files/nginx.tmpl /etc/rancher-gen/
VOLUME /usr/local/nginx/conf
CMD ["--config", "/etc/rancher-gen/config.toml"]
