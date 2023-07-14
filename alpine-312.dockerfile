FROM registry.gitlab.com/tozd/docker/dinit:alpine-312

VOLUME /var/log/dockergen

ENV DOCKER_HOST unix:///var/run/docker.sock

RUN apk add --no-cache wget ca-certificates iptables && \
  mkdir /dockergen && \
  wget -P /dockergen https://github.com/jwilder/docker-gen/releases/download/0.10.4/docker-gen-linux-amd64-0.10.4.tar.gz && \
  tar xf /dockergen/docker-gen-linux-amd64-0.10.4.tar.gz -C /dockergen && \
  rm -f /dockergen/docker-gen-linux-amd64-0.10.4.tar.gz

COPY ./etc/service/dockergen /etc/service/dockergen
COPY ./dockergen /dockergen
