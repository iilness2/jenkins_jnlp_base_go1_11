FROM ubuntu:16.04 as builder
COPY install_node.sh /
RUN /install_node.sh
RUN nvm install v10.14.0


FROM iilness/jenkins_jnlp_base_go1_11:v1
MAINTAINER Andre Aliaman

COPY --from=iilness/project-as-a-based:latest /usr/bin /var/lib/jenkins/bin
ADD go /usr/local
COPY --from=builder /home/ubuntu/.nvm/versions/node /var/lib/jenkins/node
ENV PATH="/var/lib/jenkins/node/v10.14.0/bin:${PATH}"
