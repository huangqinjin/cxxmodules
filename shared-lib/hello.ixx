module;

#include <source_location>
//#define IMPL
#include "hello.hpp"

export module hello;

// https://github.com/mstorsjo/llvm-mingw/issues/421
#if defined(__clang__) && defined(__MINGW32__)
# pragma comment(linker, "-export:_ZGIW5hello") //-fms-extensions
#endif

// https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105397
#if defined(__GNUC__) && !defined(__clang__)
extern "C" EXPORT void __wrap__ZGIW5hello() __attribute__((alias("_ZGIW5hello"))); //-Wl,--wrap=_ZGIW5hello
#endif

// https://developercommunity.visualstudio.com/t/10651933
export EXPORT auto gploc = new auto([] { return std::source_location::current(); }());

export EXPORT void hello(const std::source_location* ploc = nullptr);
export EXPORT void is_direct_call_to_hello(void(*f)(const std::source_location*));

export class EXPORT Hello
{
public:
    auto hello()
    {
        return inline_hello();
    }

    inline void inline_hello()
    {
    }
};
