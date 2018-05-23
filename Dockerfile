FROM jenkins:latest

USER root

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    docker
