#!/bin/bash

CMAKE_VER="3.28.3"

echo "[SCRIPT] Changing APT mirror for faster download..."
sudo apt update
sudo apt -y install ca-certificates
sudo sed -i 's|http://archive.ubuntu.com|https://ftp.kaist.ac.kr|g' /etc/apt/sources.list

echo "[SCRIPT] Installing dependencies..."
sudo apt update
sudo apt -y install git g++ cmake ninja-build libssl-dev

echo "[SCRIPT] Cloning CMake-$CMAKE_VER source..."
CMAKE_SRC_DIR=cmake-src-$CMAKE_VER
git clone -b v$CMAKE_VER https://github.com/Kitware/CMake.git --depth 1 $CMAKE_SRC_DIR
cd $CMAKE_SRC_DIR

echo "[SCRIPT] Creating installation directory..."
CMAKE_DIR=~/cmake-$CMAKE_VER # Edit this directory
mkdir $CMAKE_DIR

echo "[SCRIPT] Building and installing CMake..."
BUILD_DIR=build-$CMAKE_VER
cmake -G Ninja -B $BUILD_DIR \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$CMAKE_DIR
cmake --build $BUILD_DIR
cmake --install $BUILD_DIR
