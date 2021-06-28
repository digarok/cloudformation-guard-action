#!/bin/sh

# validate inputs

if [ -z ${INPUT_CFN_DIRECTORY} ] ; then
    echo "Missing 'cfn_directory' parameter."
    echo "Set this to the directory where your CloudFormation Templates are located."
    exit 1
fi

# find templates with resource
POSSIBLE_TEMPLATES=`grep \\
  --with-filename \\
  --recursive 'Resources' ${INPUT_CFN_DIRECTORY}/* \\
  | cut -d':' -f1 \\
  | sort -u`

for f in $POSSIBLE_TEMPLATES; do
    # echo "Checking for ruleset matching template file: ${f}"

    # rules=${f%.*}.ruleset
    # ruleset_file=ruleset_file
    if [ -e $INPUT_RULESET_FILE ]; then
        echo "                                      Found: $rules"
        cg_cmd="cfn-guard check --strict-checks --rule_set $INPUT_RULESET_FILE  --template ${PWD}/${f}"
        echo "Running command:"
        echo "$ $cg_cmd"
        $cg_cmd
        if [ $? -ne 0 ]; then
            echo "CFN GUARD FAIL!"
            exit 1
        fi
    else
        echo "No matching: $rules"
    fi
done

echo "CloudFormation Guard Scan Complete"
