#define MAIN

import "hello.hpp";

#ifndef HELLO
#error "Macros must be imported from header units"
#endif

#if !defined(__clang__) || __has_include("iostream.pcm")
import <iostream>;

int main()
{
    std::cout << hello() << std::endl;
}
#else
#include <stdio.h>

int main()
{
    printf("NO iostream header unit: %s\n", hello());
}
#endif
