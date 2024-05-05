msvc: \
	named-module/msvc \
	module-partition/msvc \
	module-impl/msvc \
	header-unit/msvc \
	import-std/msvc \
	shared-lib/msvc \

clang: \
	named-module/clang \
	module-partition/clang \
	module-impl/clang \
	header-unit/clang \
	header-unit/clang-libcxx \
	import-std/clang \
	shared-lib/clang \

clang-cl: \
	named-module/clang-cl \
	module-partition/clang-cl \
	module-impl/clang-cl \
	header-unit/clang-cl \
	shared-lib/clang-cl \

clang-win32: \
	named-module/clang \
	module-partition/clang \
	module-impl/clang \
	header-unit/clang \
	shared-lib/clang-win32 \

clang-mingw: \
	named-module/clang \
	module-partition/clang \
	module-impl/clang \
	header-unit/clang-libcxx \
	import-std/clang \
	shared-lib/clang-mingw \

gcc: \
	named-module/gcc \
	module-partition/gcc \
	module-impl/gcc \
	header-unit/gcc \
	shared-lib/gcc \

TARGETS1 = \
	module-partition/msvc \
	module-partition/clang \
	module-partition/clang-cl \
	header-unit/msvc \
	header-unit/clang \
	header-unit/clang-libcxx \
	header-unit/clang-cl \
	header-unit/gcc \
	import-std/msvc \
	import-std/clang \
	shared-lib/msvc \
	shared-lib/clang \
	shared-lib/clang-win32 \
	shared-lib/clang-mingw \
	shared-lib/clang-cl \
	shared-lib/gcc \

TARGETS2 = \
	named-module/clang \
	named-module/clang-cl \
	module-partition/gcc \
	module-impl/msvc \
	module-impl/clang \
	module-impl/clang-cl \
	module-impl/gcc \

TARGETS3 = \
	named-module/msvc \
	named-module/gcc \

$(TARGETS1):
	@cd $(@D) && $(MAKE) -f Makefile.$(@F) -$(MAKEFLAGS) clean hello.exe      && $(LAUNCHER)hello.exe
	@cd $(@D) && $(MAKE) -f Makefile.$(@F) -$(MAKEFLAGS) clean

$(TARGETS2):
	@cd $(@D) && $(MAKE) -f Makefile.$(@F) -$(MAKEFLAGS) clean default        && $(LAUNCHER)hello.exe
	@cd $(@D) && $(MAKE) -f Makefile.$(@F) -$(MAKEFLAGS) clean hello.exe      && $(LAUNCHER)hello.exe
	@cd $(@D) && $(MAKE) -f Makefile.$(@F) -$(MAKEFLAGS) clean

$(TARGETS3):
	@cd $(@D) && $(MAKE) -f Makefile.$(@F) -$(MAKEFLAGS) clean default-mapper && $(LAUNCHER)hello.exe
	@cd $(@D) && $(MAKE) -f Makefile.$(@F) -$(MAKEFLAGS) clean custom-mapper  && $(LAUNCHER)hello.exe
	@cd $(@D) && $(MAKE) -f Makefile.$(@F) -$(MAKEFLAGS) clean hello.exe      && $(LAUNCHER)hello.exe
	@cd $(@D) && $(MAKE) -f Makefile.$(@F) -$(MAKEFLAGS) clean
