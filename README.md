## AWS CloudFormation Guard Action for GitHub Actions

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Github Action to allow run cfn-guard (CloudFormation Guard) compliance checks against your templates.
## Usage

```yaml
- name: Run CloudFormation Guard
  uses: digarok/cloudformation-guard-action@master
  with:
    cfn_directory: cloudformation
```

This action, by default, will look for any file in the specified `cfn_directory` with resources inside them and try to run cfn-guard rules contained in matching files called `*.ruleset`.

## Credentials
As this action is essentially a static analysis of your CloudFormation template agains a set of rules, no credentials are required. 

