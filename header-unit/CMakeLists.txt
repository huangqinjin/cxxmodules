cmake_minimum_required(VERSION 3.26)
project(header-unit)

set(CMAKE_CXX_STANDARD 20)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME}
  PRIVATE
    main.cpp
  PUBLIC FILE_SET CXX_MODULE_HEADER_UNITS FILES
    "hello.hpp"
    #<iostream>
)

add_test(NAME ${PROJECT_NAME} COMMAND ${PROJECT_NAME})
