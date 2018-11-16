FROM cloudbees/jnlp-slave-with-java-build-tools
MAINTAINER Andre Aliaman

RUN mv go /usr/local

#setup go environment
RUN export GOROOT=/usr/local/go
RUN export GOPATH=/var/lib/jenkins
RUN export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
