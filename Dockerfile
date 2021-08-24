FROM ubuntu:latest

ARG CFN_GUARD_VERSION=2.0.3

LABEL "maintainer"="Dagen Brock <dagenbrock@gmail.com>" \
      "com.github.actions.name"="CloudFormation Guard Action" \
      "com.github.actions.description"="CloudFormation Guard action using cfn-guard" \
      "com.github.actions.icon"="check-circle" \
      "com.github.actions.color"="green"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ADD cfn-guard.ruleset /cfn-guard.ruleset

RUN apt-get update && apt-get install -yy wget

RUN wget https://github.com/aws-cloudformation/cloudformation-guard/releases/download/$CFN_GUARD_VERSION/cfn-guard-v2-ubuntu-latest.tar.gz \
  && tar -xzf cfn-guard-v2-ubuntu-latest.tar.gz \
  && mv cfn-guard-v2-ubuntu-latest/cfn-guard /usr/local/bin/ \
  && rm -rf cfn-guard-v2-ubuntu-latest* \
  && cfn-guard -h

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
