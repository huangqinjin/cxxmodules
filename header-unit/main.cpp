#define MAIN

import "hello.hpp";

#ifndef HELLO
#error "Macros must be imported from header units"
#endif

import <iostream>;

int main()
{
    std::cout << hello() << std::endl;
}
