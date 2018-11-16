FROM cloudbees/jnlp-slave-with-java-build-tools
MAINTAINER Andre Aliaman

RUN wget https://dl.google.com/go/go1.11.linux-amd64.tar.gz
RUN tar -xvf go1.11.linux-amd64.tar.gz && mv go /usr/local && rm -rf go1.11.linux-amd64.tar.gz

#setup go environment
RUN export GOROOT=/usr/local/go
RUN export GOPATH=/var/lib/jenkins
RUN export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
