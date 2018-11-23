FROM iilness/jenkins_jnlp_base_go1_11:v1
MAINTAINER Andre Aliaman

COPY bin /usr/bin
ADD go /usr/local
