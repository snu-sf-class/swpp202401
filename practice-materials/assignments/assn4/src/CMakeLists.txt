cmake_minimum_required(VERSION 3.28.0)

add_library(polygon polygon.cpp)
target_compile_options(polygon PUBLIC "-fsanitize=undefined")
target_link_options(polygon PUBLIC "-fsanitize=undefined")

add_library(unreachable unreachable.cpp)
target_compile_options(unreachable PRIVATE "-Wno-deprecated")
target_include_directories(unreachable PRIVATE ${LLVM_INCLUDE_DIRS})
llvm_map_components_to_libnames(unreachable_llvm_libs bitreader core irreader support)
target_link_libraries(unreachable PRIVATE ${unreachable_llvm_libs})
