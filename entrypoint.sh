#!/bin/sh

# validate inputs

if [ -z ${INPUT_CFN_DIRECTORY} ] ; then
  echo "Missing 'cfn_directory' parameter."
  echo "Set this to the directory where your CloudFormation Templates are located."
  exit 1
fi

# check if using default or provided rules
echo "INPUT_RULESET_FILE set to $INPUT_RULESET_FILE"

# cat $INPUT_RULESET_FILE

# find templates with resource
POSSIBLE_TEMPLATES=`grep --with-filename --recursive 'Resources' ${INPUT_CFN_DIRECTORY}/* | cut -d':' -f1 | sort -u`
for f in $POSSIBLE_TEMPLATES; do
  # TODO: check for rules file and either use that for all or look for mathcing tmeplate name
  # echo "Checking for ruleset matching template file: ${f}"
  # rules=${f%.*}.ruleset
  # ruleset_file=ruleset_file

  echo ">>>>>"
  echo "evaluating $f"
  if [ -e $INPUT_RULESET_FILE ]; then
    if [ "$f" != "$INPUT_RULESET_FILE" ] # dont scan our own ruleset file
    then
    cg_cmd="cfn-guard validate --rules $INPUT_RULESET_FILE --data ${PWD}/${f} --type CFNTemplate"
    $cg_cmd

    if [ $? -ne 0 ]
    then
      echo "CFN GUARD FAIL!"
      exit 1 # fail on first error
    fi
  fi
  else
    echo "No matching: $rules"
  fi

  echo "<<<<<"
  echo ""
done

echo "CloudFormation Guard Scan Complete"
