cmake_minimum_required(VERSION 3.28.0)

project(assignment-2 CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

enable_testing()

add_subdirectory(interface)
add_subdirectory(impl)
add_subdirectory(test)
