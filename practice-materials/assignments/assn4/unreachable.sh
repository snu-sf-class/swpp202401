#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "unreachable.sh <opt path> <unreachable lib path> <test idx>"
  echo "ex)  ./unreachable.sh ~/llvm-18.1.0/bin/opt build/src/unreachable.so 3"
  exit 1
fi

OPT=$1
PASS_LIB=$2
IDX=$3

$OPT -disable-output \
  -load-pass-plugin=$PASS_LIB \
  -passes="my-unreachable" data-unreachable/input${IDX}.ll | \
  diff data-unreachable/output${IDX}.txt -
