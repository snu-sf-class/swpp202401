#!/bin/bash

NINJA_VER="1.11.1"

echo "[SCRIPT] Changing APT mirror for faster download..."
sudo apt update
sudo apt -y install ca-certificates
sudo sed -i 's|http://archive.ubuntu.com|https://ftp.kaist.ac.kr|g' /etc/apt/sources.list

echo "[SCRIPT] Installing dependencies..."
sudo apt update
sudo apt -y install git g++ cmake ninja-build

echo "[SCRIPT] Cloning Ninja-$NINJA_VER source..."
SRC_DIR=ninja-src-$NINJA_VER
git clone -b v$NINJA_VER https://github.com/ninja-build/ninja.git --depth 1 $SRC_DIR
cd $SRC_DIR

echo "[SCRIPT] Creating installation directory..."
NINJA_DIR=~/ninja-$NINJA_VER # Edit this directory
mkdir $NINJA_DIR

echo "[SCRIPT] Building and installing Ninja..."
BUILD_DIR=build-$NINJA_VER
cmake -G Ninja -B $BUILD_DIR \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$NINJA_DIR
cmake --build $BUILD_DIR
cmake --install $BUILD_DIR
