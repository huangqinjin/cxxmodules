cmake_minimum_required(VERSION 3.25)

unset(ARGN)
unset(PRESET)
foreach(i RANGE ${CMAKE_ARGC})
    if(NOT DEFINED ARGN)
        if (CMAKE_ARGV${i} STREQUAL --)
            set(ARGN [[]])
        endif()
    elseif(NOT DEFINED PRESET)
        set(PRESET ${CMAKE_ARGV${i}})
    else()
        list(APPEND ARGN ${CMAKE_ARGV${i}})
    endif()
endforeach()

string(TIMESTAMP UID ${PRESET}-%Y-%m-%d_%H_%M_%S)

file(CONFIGURE OUTPUT CMakeUserPresets.json CONTENT [[
{
  "version": 6,
  "buildPresets": [
    {
      "name": "@UID@",
      "hidden": true,
      "verbose": true,
      "configurePreset": "@PRESET@"
    },
    {
      "name": "Debug-@UID@",
      "inherits": "@UID@",
      "configuration": "Debug"
    },
    {
      "name": "Release-@UID@",
      "inherits": "@UID@",
      "configuration": "Release"
    }
  ],
  "testPresets": [
    {
      "name": "@UID@",
      "hidden": true,
      "configurePreset": "@PRESET@",
      "output": {
        "verbosity": "verbose"
      }
    },
    {
      "name": "Debug-@UID@",
      "inherits": "@UID@",
      "configuration": "Debug"
    },
    {
      "name": "Release-@UID@",
      "inherits": "@UID@",
      "configuration": "Release"
    }    
  ],
  "workflowPresets": [
    {
      "name": "@UID@",
      "steps": [
        {
          "type": "configure",
          "name": "@PRESET@"
        },
        {
          "type": "build",
          "name": "Debug-@UID@"
        },
        {
          "type": "build",
          "name": "Release-@UID@"
        },
        {
          "type": "test",
          "name": "Debug-@UID@"
        },
        {
          "type": "test",
          "name": "Release-@UID@"
        }
      ]
    }
  ]
}
]] @ONLY)

execute_process(COMMAND
  ${CMAKE_COMMAND} --workflow --preset ${UID} ${ARGN}
  COMMAND_ERROR_IS_FATAL ANY
)
