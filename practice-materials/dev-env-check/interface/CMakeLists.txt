cmake_minimum_required(VERSION 3.28.0)

# Create module interface library
function(add_module name)
    add_library(${name}.mod)
    target_sources(${name}.mod
    PUBLIC
        FILE_SET CXX_MODULES FILES
        ${name}.cppm
    )
endfunction(add_module)

add_module(arith)
