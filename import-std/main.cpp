#include <version>

// https://github.com/llvm/llvm-project/issues/89579
#ifdef _LIBCPP_VERSION
#define __cpp_lib_modules 202207L
#endif

#ifdef __cpp_lib_modules
import std;
#endif

int main()
{
#ifdef __cpp_lib_modules
    std::println("{}", "Hello, World!");
#endif
}
