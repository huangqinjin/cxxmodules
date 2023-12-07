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
    set(VCTOOLSINSTALLDIR $ENV{VCTOOLSINSTALLDIR} CACHE PATH "VC tools directory: bin, include, lib, modules, ...")
    if(NOT VCTOOLSINSTALLDIR)
        cmake_path(SET VCTOOLSINSTALLDIR NORMALIZE "${CMAKE_CXX_COMPILER}/../../../..")
    endif()
    cmake_path(APPEND VCTOOLSINSTALLDIR modules OUTPUT_VARIABLE modules)
    target_sources(${PROJECT_NAME} PUBLIC FILE_SET CXX_MODULES
        BASE_DIRS ${modules}
        FILES ${modules}/std.ixx
    )
endif()
