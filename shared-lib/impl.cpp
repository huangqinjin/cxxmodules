module;

#include <iostream>
#include <source_location>

#define IMPL
#include "hello.hpp"

module hello;

void hello(const std::source_location* ploc)
{
    // https://developercommunity.visualstudio.com/t/10651933
    const auto& loc = ploc ? *ploc : [] { return std::source_location::current(); }();
    std::cout << loc.file_name() << '(' << loc.line() << ')' << ':' << ' '
              << "Hello, World!" << std::endl;
}

void is_direct_call_to_hello(void(*f)(const std::source_location*))
{
    std::cout << __func__ << "? " << (f == &hello ? "Yes" : "No") << std::endl;
}
