#include <version>

#ifdef __cpp_lib_modules
import std;
#endif

int main()
{
#ifdef __cpp_lib_modules
    std::println("{}", "Hello, World!");
#endif
}
