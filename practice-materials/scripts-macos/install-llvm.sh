#!/bin/bash

LLVM_VER="18.1.0"

echo "[SCRIPT] Installing dependencies..."
brew update
brew upgrade
brew install git cmake ninja zlib ncurses

echo "[SCRIPT] Cloning LLVM-$LLVM_VER source..."
git clone -b llvmorg-$LLVM_VER https://github.com/llvm/llvm-project.git --depth 1
cd llvm-project

echo "[SCRIPT] Creating installation directory..."
LLVM_DIR=~/llvm-$LLVM_VER # Edit this directory
mkdir $LLVM_DIR

echo "[SCRIPT] Building and installing LLVM..."
# Intel Mac users should use X86 instead of AArch64
BUILD_DIR=build-$LLVM_VER
cmake -G Ninja -S llvm -B $BUILD_DIR \
    -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lldb;lld" \
    -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" \
    -DLLVM_INSTALL_UTILS=ON \
    -DLLVM_TARGETS_TO_BUILD="AArch64" \
    -DLLVM_ENABLE_RTTI=ON \
    -DLLVM_ENABLE_EH=ON \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLDB_USE_SYSTEM_DEBUGSERVER=ON \
    -DLLVM_RAM_PER_COMPILE_JOB=256 \
    -DLLVM_RAM_PER_LINK_JOB=1536 \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$LLVM_DIR
cmake --build $BUILD_DIR
cmake --install $BUILD_DIR
