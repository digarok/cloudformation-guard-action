FROM alpine:latest

ARG cfn_guard_version=1.0.0

LABEL "maintainer"="Dagen Brock <dagenbrock@gmail.com>" \
      "com.github.actions.name"="CloudFormation Guard Action" \
      "com.github.actions.description"="CloudFormation Guard action using cfn-guard" \
      "com.github.actions.icon"="check-circle" \
      "com.github.actions.color"="green"

RUN wget https://github.com/aws-cloudformation/cloudformation-guard/releases/download/${cfn_guard_version}/cfn-guard-linux-${cfn_guard_version}.tar.gz
RUN tar -xvf cfn-guard-linux-${cfn_guard_version}.tar.gz
RUN cp ./cfn-guard-linux/cfn-guard  /usr/bin
RUN cfn-guard

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
