cmake_minimum_required(VERSION 3.28.0)

project(assignment-4 C CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(LLVM REQUIRED CONFIG)
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVM in: ${LLVM_BINARY_DIR}")
if(APPLE)
    link_directories(BEFORE ${LLVM_BINARY_DIR}/lib)
elseif(LINUX)
    add_compile_options(-stdlib=libc++)
    add_link_options(-stdlib=libc++)
else()
    message(FATAL "Unsupported system! Aborting CMake configuration...")
endif()

enable_testing()

add_subdirectory(src)
add_subdirectory(test)
