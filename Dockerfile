FROM iilness/jenkins_jnlp_base_go1_11:v1
MAINTAINER Andre Aliaman
#RUN pip install awscli --upgrade --user
ADD go /usr/local
