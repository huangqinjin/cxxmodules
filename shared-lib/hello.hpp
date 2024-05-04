#pragma once

#if defined(_WIN32) || defined(__CYGWIN__)
# define EXPORT __declspec(dllexport)
# define IMPORT __declspec(dllimport)
#else
# define EXPORT __attribute__((visibility("default")))
# define IMPORT __attribute__((visibility("default")))
#endif

#if defined(IMPL)
#include <iostream>
extern "C++" EXPORT void is_direct_call_to_gmf(void(*f)())
{
    std::cout << __func__ << "? " << (f == (void(*)())&is_direct_call_to_gmf ? "Yes" : "No") << std::endl;
}
#elif defined(DECL)
IMPORT void is_direct_call_to_gmf(void(*f)());
#endif
