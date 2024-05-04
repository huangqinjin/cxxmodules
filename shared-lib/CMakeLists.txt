cmake_minimum_required(VERSION 3.28)
project(shared-lib)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_BUILD_RPATH_USE_ORIGIN ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)
set(CMAKE_C_VISIBILITY_PRESET hidden)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)

# https://gitlab.kitware.com/cmake/cmake/-/issues/25875
if(CMAKE_VISIBILITY_INLINES_HIDDEN AND CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND WIN32)
  if(CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")
    add_compile_options(/Zc:dllexportInlines-)
  else()
    add_compile_options(-Xclang=-fno-dllexport-inlines)
  endif()
endif()

add_library(hello SHARED)
target_sources(hello
  PRIVATE
    impl.cpp
  PUBLIC FILE_SET HEADERS FILES
    hello.hpp
  PUBLIC FILE_SET CXX_MODULES FILES
    hello.ixx
)

# https://github.com/mstorsjo/llvm-mingw/issues/421
if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND MINGW)
  # -fms-extensions is disabled by default for MinGW
  target_link_options(hello PRIVATE LINKER:-Xlink=-export:_ZGIW5hello)
endif()

# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105397
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  target_link_options(hello INTERFACE LINKER:--wrap=_ZGIW5hello)
endif()

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME}
  PRIVATE
    main.cpp
)
target_link_libraries(${PROJECT_NAME} PUBLIC hello)

add_test(NAME ${PROJECT_NAME} COMMAND ${PROJECT_NAME})
