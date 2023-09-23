module;

#include <iostream>
#include <source_location>

module hello;

void hello()
{
    std::source_location loc = std::source_location::current();
    std::cout << loc.file_name() << '(' << loc.line() << ')' << ':' << ' '
              << "Hello, World!" << std::endl;
}
