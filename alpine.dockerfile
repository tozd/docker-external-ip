FROM alpine:3.8

RUN apk --no-cache --update add bash wget ca-certificates iptables

# pick version there https://github.com/jwilder/docker-gen/releases
ENV DOCKERGEN_VERSION=0.7.4

# DOCKERGEN_PLATFORM amd64|armhf
ENV DOCKERGEN_PLATFORM=armhf

RUN wget https://github.com/jwilder/docker-gen/releases/download/${DOCKERGEN_VERSION}/docker-gen-alpine-linux-${DOCKERGEN_PLATFORM}-${DOCKERGEN_VERSION}.tar.gz -O- | \
    tar xvz -C /usr/local/bin/ docker-gen

COPY ./dockergen /dockergen

ENTRYPOINT ["/usr/local/bin/docker-gen", "-config", "/dockergen/dockergen.conf"]
