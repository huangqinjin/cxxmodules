module;

#if defined(__clang__)
#define __cpp_consteval 201811L
#endif

#include <iostream>
#include <source_location>

export module hello;

export void hello();

#if defined(_MSC_VER) || defined(__clang__)
module :private;
#endif

void hello()
{
    std::source_location loc = std::source_location::current();
    std::cout << loc.file_name() << '(' << loc.line() << ')' << ':' << ' '
              << "Hello, World!" << std::endl;
}
