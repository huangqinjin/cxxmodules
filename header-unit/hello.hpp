#pragma once

#ifdef _MSC_VER
template<typename = void>
#endif
inline const char* hello()
{
    return "Hello, World!";
}
