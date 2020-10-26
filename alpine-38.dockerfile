FROM tozd/runit:alpine-38

VOLUME /var/log/dockergen

ENV DOCKER_HOST unix:///var/run/docker.sock

RUN apk add --no-cache wget ca-certificates iptables && \
 mkdir /dockergen && \
 wget -P /dockergen https://github.com/jwilder/docker-gen/releases/download/0.7.4/docker-gen-linux-amd64-0.7.4.tar.gz && \
 tar xf /dockergen/docker-gen-linux-amd64-0.7.4.tar.gz -C /dockergen

COPY ./etc /etc
COPY ./dockergen /dockergen
