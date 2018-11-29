FROM ubuntu:16.04 as builder
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        wget \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /root/nvm
ENV NVM_DIR /root/nvm
ENV NODE_VERSION v10.14.0

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

FROM iilness/jenkins_jnlp_base_go1_11:v1
MAINTAINER Andre Aliaman

COPY --from=iilness/project-as-a-based:latest /usr/bin /var/lib/jenkins/bin
ADD go /usr/local
RUN mkdir -p /var/lib/jenkins/node
COPY --from=builder /root/nvm /var/lib/jenkins/node
RUN ls /var/lib/jenkins/node
ENV NVM_DIR /var/lib/jenkins/node
ENV NODE_VERSION 10.14.0
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
RUN $NVM_DIR/versions/node/v$NODE_VERSION/bin/node --version
RUN $NVM_DIR/versions/node/v$NODE_VERSION/bin/npm version
