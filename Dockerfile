FROM iilness/jenkins_jnlp_base_go1_11:v1
MAINTAINER Andre Aliaman

COPY --from=iilness/project-as-a-based /usr/bin/python2.7 /usr/bin/python
COPY --from=iilness/project-as-a-based /usr/bin/aws /usr/bin/aws
ADD go /usr/local
