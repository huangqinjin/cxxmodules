#define DECL
#include "hello.hpp"

import hello;

// https://github.com/llvm/llvm-project/issues/87887
#if defined(__clang__) && defined(_WIN32) && !defined(__MINGW32__)
extern "C" decltype(gploc)& __imp_gploc;
// https://github.com/llvm/llvm-project/issues/89781
// #pragma comment(linker, "/ALTERNATENAME:__imp_gploc=__imp_?gploc@@3PEAUsource_location@std@@EA::<!hello>")
#pragma comment(linker, "/ALTERNATENAME:__imp_gploc=__imp_?gploc@@3PEAUsource_location@std@@EA")
#define gploc __imp_gploc
#endif

int main()
{
    hello();
    hello(gploc);

    Hello{}.hello();
    Hello{}.inline_hello();

    is_direct_call_to_hello(&hello);
    is_direct_call_to_gmf((void(*)())&is_direct_call_to_gmf);
}
