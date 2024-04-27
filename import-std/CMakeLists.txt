cmake_minimum_required(VERSION 3.28)
project(import-std)

set(CMAKE_CXX_STANDARD 23)

add_executable(${PROJECT_NAME} main.cpp)
add_test(NAME ${PROJECT_NAME} COMMAND ${PROJECT_NAME})

if(CMAKE_GENERATOR MATCHES "Visual Studio")
    # https://gitlab.kitware.com/cmake/cmake/-/issues/24922
    file(CONFIGURE OUTPUT Directory.Build.props CONTENT [[
      <Project>
        <ItemDefinitionGroup>
          <ClCompile>
            <BuildStlModules>true</BuildStlModules>
          </ClCompile>
        </ItemDefinitionGroup>
      </Project>
    ]] @ONLY)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    find_path(modules REQUIRED
        NAMES
          std.ixx
        PATH_SUFFIXES
          modules
        HINTS
          ENV VCTOOLSINSTALLDIR
          ENV VCToolsInstallDir
        PATHS
          "${CMAKE_CXX_COMPILER}/../../../.." # VCToolsInstallDir layout
          "${CMAKE_CXX_COMPILER}/../../.."    # msvc-wine layout
        NO_DEFAULT_PATH
    )
    target_sources(${PROJECT_NAME} PUBLIC FILE_SET CXX_MODULES
        BASE_DIRS ${modules}
        FILES ${modules}/std.ixx
    )
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    include(CheckCXXSymbolExists)
    check_cxx_symbol_exists(_LIBCPP_VERSION version libcxx)
    if(libcxx)
        find_path(modules REQUIRED
            NAMES
              std.cppm
            PATH_SUFFIXES
              share/libc++/v1
            PATHS
              "${CMAKE_CXX_COMPILER}/../.."
            NO_DEFAULT_PATH
        )
        target_sources(${PROJECT_NAME} PUBLIC FILE_SET CXX_MODULES
            BASE_DIRS ${modules}
            FILES ${modules}/std.cppm
        )
        target_compile_options(${PROJECT_NAME} PRIVATE -Wno-reserved-module-identifier)
    endif()
endif()
