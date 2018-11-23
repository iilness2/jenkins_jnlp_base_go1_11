FROM iilness/jenkins_jnlp_base_go1_11:v1
MAINTAINER Andre Aliaman

COPY --from=iilness/project-as-a-based:latest /usr/bin /usr/bin
COPY --from=iilness/project-as-a-based:latest ~/.local ~/.local
ADD go /usr/local

RUN aws version && python version
