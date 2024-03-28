cmake_minimum_required(VERSION 3.28.0)

add_executable(collect_test_success test_success.cpp)
target_link_libraries(collect_test_success PRIVATE collect.mod test_helper)

add_executable(collect_test_failure test_failure.cpp)
target_link_libraries(collect_test_failure PRIVATE collect.mod test_helper)

add_executable(collect_test_move test_move.cpp)
target_link_libraries(collect_test_move PRIVATE collect.mod test_helper)

add_test(NAME collect-test-success
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/collect_test_success)
add_test(NAME collect-test-failure
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/collect_test_failure)
add_test(NAME collect-test-move
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/collect_test_move)
