#!/bin/sh

# validate inputs

if [ -z ${INPUT_CFN_DIRECTORY} ] ; then
    echo "Missing 'cfn_directory' parameter."
    echo "Set this to the directory where your CloudFormation Templates are located."
    exit 1
fi

# find templates with resource
grep --with-filename -r 'Resources' ${INPUT_CFN_SUBDIRECTORY}/* |cut -d':' -f1 

