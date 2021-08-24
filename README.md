## AWS CloudFormation Guard Action for GitHub Actions

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Github Action to allow run cfn-guard (CloudFormation Guard) compliance checks against your templates.
## Usage

```yaml
- name: Run CloudFormation Guard
  uses: kidbrax/cloudformation-guard-action@main
  with:
    cfn_directory: cloudformation
```

This action, by default, will look for any file in the specified `cfn_directory` with resources inside them and try to run cfn-guard rules contained in matching files called `*.ruleset`.

Example of the expected directory structure when called with cfn_directory = 'cloudformation' :
```
.
└── cloudformation
    ├── demostack.cft
    └── demostack.ruleset
```

The extension of the template doesn't matter, but the matching ruleset must be named _{filename}.ruleset_.

## Credentials
As this action is essentially a static analysis of your CloudFormation template against a set of rules, no credentials are required.

## TODO

- allow for pulling ruleset from url so it doens't have to be stored in action repo but can still be centralized

## References

This project is not affiliated with AWS or CloudFormation Guard.  For information on that tool see the following repository:
https://github.com/aws-cloudformation/cloudformation-guard

For information on writing CloudFormation Guard rules, see the following readme:
https://github.com/aws-cloudformation/cloudformation-guard/blob/master/cfn-guard/README.md#writing-rules
