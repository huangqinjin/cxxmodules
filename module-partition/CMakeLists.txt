cmake_minimum_required(VERSION 3.26)
project(module-partition)

set(CMAKE_CXX_STANDARD 20)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME}
  PRIVATE
    main.cpp
  PRIVATE FILE_SET CXX_MODULES FILES
    hello.ixx
    interface.cppm
    internal.cppm
)

add_test(NAME ${PROJECT_NAME} COMMAND ${PROJECT_NAME})
