FROM registry.gitlab.com/tozd/docker/dinit:ubuntu-noble

VOLUME /var/log/dockergen

ENV DOCKER_HOST unix:///var/run/docker.sock

RUN apt-get update -q -q && \
  apt-get install wget ca-certificates iptables --yes --force-yes && \
  mkdir /dockergen && \
  wget -P /dockergen https://github.com/jwilder/docker-gen/releases/download/0.10.4/docker-gen-linux-amd64-0.10.4.tar.gz && \
  tar xf /dockergen/docker-gen-linux-amd64-0.10.4.tar.gz -C /dockergen && \
  rm -f /dockergen/docker-gen-linux-amd64-0.10.4.tar.gz && \
  apt-get purge --yes --force-yes --auto-remove wget ca-certificates && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

COPY ./etc/service/dockergen /etc/service/dockergen
COPY ./dockergen /dockergen
