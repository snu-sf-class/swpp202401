cmake_minimum_required(VERSION 3.28.0)

# Add interface library to implementation library
function(add_module_impl name)
    add_library(${name} ${name}.cpp)
    target_link_libraries(${name} PUBLIC ${name}.mod)
endfunction(add_module_impl)

add_module_impl(maybe_something)
add_module_impl(test_helper)
