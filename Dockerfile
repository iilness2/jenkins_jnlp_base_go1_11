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
        unzip \
	libnss3 \
	libgconf-2-4 \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /root/nvm
ENV NVM_DIR /root/nvm
ENV NODE_VERSION v8.9.3

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

RUN wget http://chromedriver.storage.googleapis.com/2.45/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip && cp $PWD/chromedriver /usr/local/bin/chromedriver

FROM iilness/jenkins_jnlp_base_go1_11:v1
MAINTAINER Andre Aliaman

COPY --from=iilness/project-as-a-based:latest /usr/bin /var/lib/jenkins/bin
ADD go /usr/local
RUN mkdir -p /var/lib/jenkins/node
COPY --from=builder /root/nvm /var/lib/jenkins/node
COPY --from=builder /usr/local/bin/chromedriver /var/lib/jenkins/bin/chromedriver
ENV NVM_DIR /var/lib/jenkins/node
ENV NODE_VERSION 8.9.3
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV PATH      /var/lib/jenkins/bin:$PATH
