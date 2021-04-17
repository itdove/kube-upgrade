#!/bin/bash
# Copyright Contributors to the Open Cluster Management project
# set -x
BRANCH=$1
COMMITS=$(git log main..${BRANCH} | grep commit | cut -d ' ' -f2)
for c in ${COMMITS}
do
  COMMIT=$(git show ${c} -q)
  if ! echo "${COMMIT}" | grep Signed-off-by > /dev/null
  then
     ERROR="${ERROR}commit id ${c} not signed\n"
  fi
done
if [ "${ERROR}" != "" ]
then
    echo -e "${ERROR}"
    exit 1
else
    echo "All commits signed"
fi