cmake_minimum_required(VERSION 3.28.0)

add_executable(polygon-test polygon_test.cpp)
target_link_libraries(polygon-test PRIVATE polygon)

file(GLOB files "${CMAKE_SOURCE_DIR}/data-poly/input*.txt")
set(i 1)
foreach(filename ${files})
    add_test(NAME "polygon-test-${i}"
        COMMAND ${CMAKE_SOURCE_DIR}/polygon.sh ${CMAKE_CURRENT_BINARY_DIR}/polygon-test ${i}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
       )
    math(EXPR i "${i} + 1")
endforeach()

file(GLOB files "${CMAKE_SOURCE_DIR}/data-unreachable/input*.ll")
set(i 1)
foreach(filename ${files})
    add_test(NAME "unreachable-test-${i}"
        COMMAND ${CMAKE_SOURCE_DIR}/unreachable.sh ${LLVM_BINARY_DIR}/bin/opt $<TARGET_FILE:unreachable> ${i}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
       )
    math(EXPR i "${i} + 1")
endforeach()
