cmake_minimum_required(VERSION 3.27)
project(cxxmodules)

set(CMAKE_EXPERIMENTAL_CXX_MODULE_CMAKE_API aa1f7df0-828a-4fcd-9afc-2dc80491aca7)

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    string(CONCAT CMAKE_EXPERIMENTAL_CXX_SCANDEP_SOURCE
      "clang-scan-deps"
      " -format=p1689"
      " --"
      " <CMAKE_CXX_COMPILER> <DEFINES> <INCLUDES> <FLAGS>"
      " -x c++ <SOURCE> -c -o <OBJECT>"
      " -MT <DYNDEP_FILE>"
      " -MD -MF <DEP_FILE>"
      " > <DYNDEP_FILE>")
    set(CMAKE_EXPERIMENTAL_CXX_MODULE_MAP_FORMAT "gcc")
    set(CMAKE_EXPERIMENTAL_CXX_MODULE_MAP_FLAG "-fmodules-ts -Mno-modules -fmodule-mapper=<MODULE_MAP_FILE> -x c++")
endif()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

enable_testing()
add_subdirectory(named-module)
add_subdirectory(module-partition)
add_subdirectory(module-impl)
# add_subdirectory(header-unit)
add_subdirectory(import-std)
