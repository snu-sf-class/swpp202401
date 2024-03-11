#!/bin/bash

LLVM_VER="18.1.0"
# Edit this directory
LLVM_DIR=~/llvm-$LLVM_VER
# Intel Mac users should use X86 instead of AArch64
ARCH=AArch64

echo "[SCRIPT] Installing dependencies..."
brew update
brew upgrade
brew install git cmake ninja zlib ncurses

echo "[SCRIPT] Cloning LLVM-$LLVM_VER source..."
git clone -b llvmorg-$LLVM_VER https://github.com/llvm/llvm-project.git --depth 1
cd llvm-project

echo "[SCRIPT] Creating installation directory..."
mkdir $LLVM_DIR

echo "[SCRIPT] Building and installing libc++..."
BSTRP_BUILD_DIR=build-$LLVM_VER-tmp
cmake -G Ninja -S llvm -B $BSTRP_BUILD_DIR \
    -DLLVM_ENABLE_PROJECTS="clang;lld" \
    -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" \
    -DLLVM_TARGETS_TO_BUILD="$ARCH" \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_RAM_PER_COMPILE_JOB=256 \
    -DLLVM_RAM_PER_LINK_JOB=1024 \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$LLVM_DIR
cmake --build $BSTRP_BUILD_DIR
cmake --install $BSTRP_BUILD_DIR

echo "[SCRIPT] Building and installing LLVM..."
sleep 2
BUILD_DIR=build-$LLVM_VER
CLANG=$LLVM_DIR/bin/clang
CLANGXX=$LLVM_DIR/bin/clang++
LLD=$LLVM_DIR/bin/ld64.lld
cmake -G Ninja -S llvm -B $BUILD_DIR \
    -DCMAKE_C_COMPILER=$CLANG \
    -DCMAKE_CXX_COMPILER=$CLANGXX \
    -DCMAKE_EXE_LINKER_FLAGS="-L$LLVM_DIR/lib" \
    -DCMAKE_SHARED_LINKER_FLAGS="-L$LLVM_DIR/lib" \
    -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lldb;lld" \
    -DLLVM_INSTALL_UTILS=ON \
    -DLLVM_TARGETS_TO_BUILD="$ARCH" \
    -DLLVM_ENABLE_RTTI=ON \
    -DLLVM_ENABLE_EH=ON \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_RAM_PER_COMPILE_JOB=256 \
    -DLLVM_RAM_PER_LINK_JOB=1024 \
    -DLLVM_ENABLE_LIBCXX=ON \
    -DLLVM_USE_LINKER=$LLD \
    -DLLDB_USE_SYSTEM_DEBUGSERVER=ON \
    -DLLDB_INCLUDE_TESTS=OFF \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$LLVM_DIR
cmake --build $BUILD_DIR
cmake --install $BUILD_DIR
