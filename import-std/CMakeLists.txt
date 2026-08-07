cmake_minimum_required(VERSION 3.28)
project(import-std)

set(CMAKE_CXX_STANDARD 23)

add_executable(${PROJECT_NAME} main.cpp)
add_test(NAME ${PROJECT_NAME} COMMAND ${PROJECT_NAME})

if(CMAKE_GENERATOR MATCHES "Ninja")
    target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_23)
    set_target_properties(${PROJECT_NAME} PROPERTIES
        CXX_SCAN_FOR_MODULES ON
    )
elseif(CMAKE_GENERATOR MATCHES "Visual Studio")
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
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    target_compile_options(${PROJECT_NAME} PUBLIC
        -Wno-include-angled-in-module-purview
        -Wno-reserved-module-identifier
    )
endif()

# https://gcc.gnu.org/gcc-14/changes.html#libstdcxx
if(MINGW)
    include(CheckCXXSymbolExists)
    check_cxx_symbol_exists(__GLIBCXX__ version libstdcxx)
    if(libstdcxx)
        target_link_libraries(${PROJECT_NAME} PRIVATE stdc++exp)
    endif()
endif()
