#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "run-printdom.sh build <clang dir>"
  echo "run-printdom.sh run <clang dir>"
  echo "run-printdom.sh all <clang dir>"
  echo "ex)  ./run-printdom.sh all /<llvm-dir>/bin"
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

  $CXX $ISYSROOT $CXXFLAGS $LDFLAGS $LIBS printdom.cpp -o ./libPrintDom$EXT -shared
fi

if [[ "$1" == "run" || "$1" == "all" ]]; then
  echo "----- run input.ll -----"
  set +e
  $2/opt -load-pass-plugin=./libPrintDom$EXT \
         -passes="print-dom" input.ll -S -o -
fi
