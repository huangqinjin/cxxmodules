cmake_minimum_required(VERSION 3.28)
project(cxxmodules)

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" AND CMAKE_CXX_COMPILER_VERSION VERSION_LESS 14.0)
    string(CONCAT CMAKE_CXX_SCANDEP_SOURCE
      "clang-scan-deps"
      " -format=p1689"
      " --"
      " <CMAKE_CXX_COMPILER> <DEFINES> <INCLUDES> <FLAGS>"
      " -x c++ <SOURCE> -c -o <OBJECT>"
      " -MT <DYNDEP_FILE>"
      " -MD -MF <DEP_FILE>"
      " > <DYNDEP_FILE>.tmp"
      " && \"${CMAKE_COMMAND}\" -E rename <DYNDEP_FILE>.tmp <DYNDEP_FILE>")
    set(CMAKE_CXX_MODULE_MAP_FORMAT "gcc")
    set(CMAKE_CXX_MODULE_MAP_FLAG "-fmodules-ts -Mno-modules -fmodule-mapper=<MODULE_MAP_FILE> -x c++")
    set(CMAKE_CXX_MODULE_BMI_ONLY_FLAG "-fmodule-only")
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
