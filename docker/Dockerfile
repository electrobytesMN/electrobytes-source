FROM debian:stretch
LABEL maintainer="electrobytes Developers <dev@electrobytes.org>"
LABEL description="Dockerised electrobytesCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
