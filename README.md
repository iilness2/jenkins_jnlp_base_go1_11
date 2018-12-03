The docker can access and pull at here: https://hub.docker.com/r/iilness/jenkins_jnlp_base_go1_11/

This is modified Docker jenkins slave to works with go v1.11, node v10.14.0 and awscli.

## compatible:
```tested at Jenkins ver. 2.138.1, Amazon EC2 Container Service Plugin ver. 1.16,1.17, 1.18```

## Mandatory:
```1. change the permission /var/run/docker.sock so can access inside the container
   2. Mount /var/run/docker.sock from host to container
```

## additional information:
```1. try to create the home directory is /var/lib/jenkins
   2. Try to mount additional needed to build the application
```
