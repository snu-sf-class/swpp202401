#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "run-propinteq.sh build <clang dir>"
  echo "run-propinteq.sh run <clang dir>"
  echo "run-propinteq.sh test <clang dir>"
  echo "run-propinteq.sh all <clang dir>"
  echo "ex)  ./run-propinteq.sh all /<llvm-dir>/bin"
  exit 1
fi

if [[ ! -f "$2/FileCheck" ]]; then
  echo "Cannot find $2/FileCheck!"
  exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  EXT=".dylib"
  ISYSROOT="-isysroot `xcrun --show-sdk-path`"
  PICFLAG=""
else
  EXT=".so"
  ISYSROOT=
  PICFLAG="-fPIC"
fi

if [[ "$1" == "build" || "$1" == "all" ]]; then
  echo "----- build -----"
  LLVMCONFIG=$2/llvm-config
  CXXFLAGS=`$LLVMCONFIG --cxxflags`
  LDFLAGS=`$LLVMCONFIG --ldflags`
  LIBS=`$LLVMCONFIG --libs core irreader bitreader support --system-libs`
  INC_DIR=`$LLVMCONFIG --includedir`

  CXX=$2/clang++
  CXXFLAGS="$CXXFLAGS -std=c++17 -I\"${INC_DIR}\" $PICFLAG -g"
  set -e

  $CXX $ISYSROOT $CXXFLAGS $LDFLAGS $LIBS propinteq.cpp -o ./libPropIntEq$EXT -shared
fi

if [[ "$1" == "run" || "$1" == "all" ]]; then
  echo "----- run input.ll -----"
  set +e
  $2/opt -load-pass-plugin=./libPropIntEq$EXT \
         -passes="prop-int-eq" input.ll -S -o -
fi

if [[ "$1" == "test" || "$1" == "all" ]]; then
  echo "----- test -----"
  set +e

  SCORE=0
  TOTAL=0

  for f in `ls -1 data` ; do
    echo "== data/${f} =="
    $2/opt -load-pass-plugin=./libPropIntEq$EXT \
           -passes="prop-int-eq" data/${f} -S -o out.${f}
    $2/FileCheck data/${f} < out.${f}
    if [ "$?" -eq 0 ]; then
      SCORE=$((SCORE+10))
    fi
    TOTAL=$((TOTAL+10))
  done

  echo "Score: $SCORE / $TOTAL"

  echo "----- my checks -----"
  PASSED=0
  TOTAL=0
  for f in `ls -1 mycheck` ; do
    echo "== mycheck/${f} =="
    $2/opt -load-pass-plugin=./libPropIntEq$EXT \
           -passes="prop-int-eq" mycheck/${f} -S -o out.${f}
    $2/FileCheck mycheck/${f} < out.${f}
    if [ "$?" -eq 0 ]; then
      PASSED=$((PASSED+1))
    fi
    TOTAL=$((TOTAL+1))
  done

  echo "MyCheck passed: $PASSED / $TOTAL"
fi
