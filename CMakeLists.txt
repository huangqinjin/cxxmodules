cmake_minimum_required(VERSION 3.25)
project(cxxmodules)

set(CMAKE_EXPERIMENTAL_CXX_MODULE_CMAKE_API 3c375311-a3c9-4396-a187-3227ef642046)
set(CMAKE_EXPERIMENTAL_CXX_MODULE_DYNDEP 1)


enable_testing()
add_subdirectory(named-module)
add_subdirectory(module-partition)
add_subdirectory(module-impl)
add_subdirectory(header-unit)
