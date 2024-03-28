cmake_minimum_required(VERSION 3.28.0)

add_executable(maybe_test test.cpp)
target_link_libraries(maybe_test PRIVATE maybe_something test_helper)

add_test(NAME maybe-test
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/maybe_test)
