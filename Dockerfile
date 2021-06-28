FROM ubuntu:latest

ARG cfn_guard_version=1.0.0

LABEL "maintainer"="Dagen Brock <dagenbrock@gmail.com>" \
      "com.github.actions.name"="CloudFormation Guard Action" \
      "com.github.actions.description"="CloudFormation Guard action using cfn-guard" \
      "com.github.actions.icon"="check-circle" \
      "com.github.actions.color"="green"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# RUN apt-get update && apt-get install -yy \
#  curl

# RUN wget https://github.com/aws-cloudformation/cloudformation-guard/releases/download/${cfn_guard_version}/cfn-guard-linux-${cfn_guard_version}.tar.gz \
#  && tar -xvf cfn-guard-linux-${cfn_guard_version}.tar.gz \
#  && mv cfn-guard-linux/cfn-guard /usr/bin/ \
#  && chmod 0755 /usr/bin/cfn-guard \
#  && rm *.tar.gz

RUN curl \
  --proto '=https' \
  --tlsv1.2 \
  -sSf https://raw.githubusercontent.com/aws-cloudformation/cloudformation-guard/main/install-guard.sh \
  | sh


# COPY cfn-guard-linux/cfn-guard /usr/bin
RUN cfn-guard -h
#
# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
