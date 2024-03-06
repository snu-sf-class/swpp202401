#!/bin/bash

LLVM_VER="18.1.0"

echo "[SCRIPT] Changing APT mirror for faster download..."
sudo apt update
sudo apt -y install ca-certificates
sudo sed -i 's|http://archive.ubuntu.com|https://ftp.kaist.ac.kr|g' /etc/apt/sources.list

echo "[SCRIPT] Installing dependencies..."
sudo apt update
sudo apt -y install git g++ cmake ninja-build python3-distutils zlib1g-dev \
libncurses-dev

echo "[SCRIPT] Cloning LLVM-$LLVM_VER source..."
LLVM_SRC_DIR=llvm-project-$LLVM_VER
git clone -b llvmorg-$LLVM_VER https://github.com/llvm/llvm-project.git --depth 1 $LLVM_SRC_DIR
cd $LLVM_SRC_DIR

echo "[SCRIPT] Creating installation directory..."
LLVM_DIR=~/llvm-$LLVM_VER # Edit this directory
mkdir $LLVM_DIR

echo "[SCRIPT] Building and installing LLVM..."
BUILD_DIR=build-$LLVM_VER
cmake -G Ninja -S llvm -B $BUILD_DIR \
    -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lldb;lld" \
    -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" \
    -DLLVM_INSTALL_UTILS=ON \
    -DLLVM_TARGETS_TO_BUILD="X86" \
    -DLLVM_ENABLE_RTTI=ON \
    -DLLVM_ENABLE_EH=ON \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_RAM_PER_COMPILE_JOB=256 \
    -DLLVM_RAM_PER_LINK_JOB=1536 \
    -DLLVM_USE_LINKER=gold \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$LLVM_DIR
cmake --build $BUILD_DIR
cmake --install $BUILD_DIR
