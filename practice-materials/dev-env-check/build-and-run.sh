#!/bin/bash

# Edit three variables below to match your system configuration
CMAKE_DIR=~/cmake-3.28.3
LLVM_DIR=~/llvm-18.1.0
NINJA_DIR=~/ninja-1.11.1

CMAKE=$CMAKE_DIR/bin/cmake
CLANG=$LLVM_DIR/bin/clang
CLANGXX=$LLVM_DIR/bin/clang++
LLD=$LLVM_DIR/bin/ld.lld
NINJA=$NINJA_DIR/bin/ninja

$CMAKE -G Ninja -B build \
    -DCMAKE_CXX_COMPILER=$CLANGXX \
    -DCMAKE_CXX_FLAGS="-stdlib=libc++" \
    -DCMAKE_EXE_LINKER_FLAGS="-stdlib=libc++ -fuse-ld=$LLD" \
    -DCMAKE_MAKE_PROGRAM=$NINJA

$CMAKE --build build

build/hello
