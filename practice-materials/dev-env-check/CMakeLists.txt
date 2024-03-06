cmake_minimum_required(VERSION 3.28.0)

project(dev-env-check CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
option(BUILD_SHARED_LIBS "Build using shared libraries" ON)

add_subdirectory(impl)
add_subdirectory(interface)
