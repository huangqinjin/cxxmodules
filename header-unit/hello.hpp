#pragma once

#ifdef MAIN
#error "Macros defined outside header units must be invisible"
#endif

#define HELLO

inline const char* hello()
{
    return "Hello, World!";
}
