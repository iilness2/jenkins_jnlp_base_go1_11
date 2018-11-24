FROM iilness/jenkins_jnlp_base_go1_11:v1
MAINTAINER Andre Aliaman

COPY --from=iilness/project-as-a-based:latest /usr/bin /var/lib/jenkins/bin
ADD go /usr/local
