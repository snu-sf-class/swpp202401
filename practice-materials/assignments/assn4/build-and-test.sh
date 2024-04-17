#!/bin/bash

# Edit three variables below to match your system configuration
CMAKE_DIR=~/cmake-3.28.3
LLVM_DIR=~/llvm-18.1.0
NINJA_DIR=~/ninja-1.11.1

CMAKE=$CMAKE_DIR/bin/cmake
CTEST=$CMAKE_DIR/bin/ctest
CLANG=$LLVM_DIR/bin/clang
CLANGXX=$LLVM_DIR/bin/clang++
if [ "$(uname)" == "Darwin" ]; then
    LLD=$LLVM_DIR/bin/ld64.lld
else
    LLD=$LLVM_DIR/bin/ld.lld
fi
NINJA=$NINJA_DIR/bin/ninja

$CMAKE -G Ninja -B build \
    -DLLVM_ROOT=$LLVM_DIR \
    -DCMAKE_C_COMPILER=$CLANG \
    -DCMAKE_CXX_COMPILER=$CLANGXX \
    -DCMAKE_CXX_FLAGS="-stdlib=libc++" \
    -DCMAKE_SHARED_LINKER_FLAGS="-stdlib=libc++ -fuse-ld=$LLD" \
    -DCMAKE_EXE_LINKER_FLAGS="-stdlib=libc++ -fuse-ld=$LLD" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_MAKE_PROGRAM=$NINJA

$CMAKE --build build

$CTEST --test-dir build --output-on-failure -V