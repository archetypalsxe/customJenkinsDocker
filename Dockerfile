FROM jenkins:latest

USER root

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    apt-transport-https \
    ca-certificates \
    wget \
    software-properties-common

RUN wget https://download.docker.com/linux/debian/gpg && apt-key add gpg && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee -a /etc/apt/sources.list.d/docker.list

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    docker-ce
