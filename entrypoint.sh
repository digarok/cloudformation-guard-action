#!/bin/sh

# validate inputs
if [ -z "${INPUT_CFN_DIRECTORY}" ] ; then
  echo "Missing 'cfn_directory' parameter."
  echo "Set this to the directory where your CloudFormation Templates are located."
  exit 1
fi

# check if using default or provided rules
echo "INPUT_RULESET_FILE set to $INPUT_RULESET_FILE"

# find templates with 'Resources'
POSSIBLE_TEMPLATES=$(grep --with-filename --recursive 'Resources' ${INPUT_CFN_DIRECTORY}/* | cut -d':' -f1 | sort -u)

for F in $POSSIBLE_TEMPLATES; do
  echo "START evaluating $F"

  if echo "$F" | grep ruleset
  then
    echo "Skipping ruleset file"
  else
    cg_cmd="cfn-guard validate --rules $INPUT_RULESET_FILE --data ${PWD}/${F} --type CFNTemplate"
    $cg_cmd

    if [ $? -ne 0 ]
    then
      echo "CFN GUARD FAIL!"
      exit 1 # fail on first error
    fi
  fi

  echo "END"
  echo ""
done

echo "CloudFormation Guard Scan Complete"
