FROM iilness/jenkins_jnlp_base_go1_11:v1
MAINTAINER Andre Aliaman

COPY --from=iilness/project-as-a-based:latest /usr/bin /var/lib/jenkins/bin
COPY --from=iilness/project-as-a-based:latest ~/.local /var/lib/jenkins/
ADD go /usr/local

RUN /var/lib/jenkins/bin/aws version && /var/lib/jenkins/bin/python --version
