#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "run-passes build <clang dir>"
  echo "run-passes run <clang dir>"
  echo "run-passes all <clang dir>"
  echo "ex) ./run-passes.sh all ~/llvm-18.1.0/bin"
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

if [ "$1" != "run" ]; then
  LLVMCONFIG=$2/llvm-config
  CXXFLAGS=`$LLVMCONFIG --cxxflags`
  LDFLAGS=`$LLVMCONFIG --ldflags`
  LIBS=`$LLVMCONFIG --libs core irreader bitreader support --system-libs`

  CXX=$2/clang++
  CXXFLAGS="$CXXFLAGS $PICFLAG -std=c++17"
  set -e

  $CXX $ISYSROOT $CXXFLAGS $LDFLAGS $LIBS hello.cpp -o ./libHello$EXT -shared
  $CXX $ISYSROOT $CXXFLAGS $LDFLAGS $LIBS dump.cpp -o ./libDump$EXT -shared

fi

if [ "$1" != "build" ]; then
  $2/opt -disable-output \
      -load-pass-plugin=./libHello$EXT \
      -load-pass-plugin=./libDump$EXT \
      -passes="hello,dump" foo.ll
fi
