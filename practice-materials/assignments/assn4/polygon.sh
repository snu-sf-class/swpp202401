#!/bin/bash

if [[ "$#" -ne 2 ]] ; then
  echo "polygon.sh <polygon-test path> <test idx>"
  echo "ex)  ./polygon.sh build/test/polygon-test 3"
  exit 1
fi

TEST_DATA_DIR=data-poly
TEST_EXEC=$1
IDX=$2

$TEST_EXEC < ${TEST_DATA_DIR}/input${IDX}.txt | \
  diff ${TEST_DATA_DIR}/output${IDX}.txt -
