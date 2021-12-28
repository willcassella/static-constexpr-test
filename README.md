# `static (constexpr|inline)` variables in C++17

This is a test of how C++17 `static inline`/`static constexpr` variables affect code generation in static and dynamic 
linkage scenarios.

You can run the test via `make`, assuming you have `nm` and a version of `clang` supporting C++17 installed.

Sample output:
```
clang++ -std=c++17 -c main.cc -o main.o
clang++ -std=c++17 -c foo.cc -o foo.o
clang++ -std=c++17 main.o foo.o -o main
clang++ -std=c++17 -DBUILD_SHARED -DFOO_IMPL -shared -fPIC foo.cc -o libfoo.so
clang++ -std=c++17 -DBUILD_SHARED -fPIC main.cc -L./ -Wl,-rpath=./ -lfoo -o main_shared

Key: U = undefined symbol, D = symbol defined in "data", T = symbol defined in "text", V = "weak" symbol

Analysis of artifacts (static linking):

foo.o:
0000000000000000 T increment()
0000000000000000 V Foo::static_inline
0000000000000000 D Foo::regular_static

main.o:
                 U increment()
0000000000000000 V Foo::static_inline
                 U Foo::regular_static
0000000000000000 T main
                 U printf

Running 'main':
Foo::static_inline = 3.000000
Foo::static_constexpr = 42.000000
Foo::regular_static = 99.000000

Analysis of artifacts (dynamic linking):

libfoo.so:
0000000000001100 T increment()
0000000000004030 V Foo::static_inline
0000000000004020 D Foo::regular_static

main_shared:
                 U increment()
0000000000404040 V Foo::static_inline
                 U Foo::regular_static
0000000000404038 D __TMC_END__
0000000000404028 D __data_start
0000000000404030 D __dso_handle
0000000000401230 T __libc_csu_fini
00000000004011c0 T __libc_csu_init
                 U __libc_start_main@@GLIBC_2.2.5
0000000000401080 T _dl_relocate_static_pie
0000000000404038 D _edata
0000000000401238 T _fini
0000000000401000 T _init
0000000000401050 T _start
0000000000401140 T main
                 U printf@@GLIBC_2.2.5

Running 'main_shared':
Foo::static_inline = 3.000000
Foo::static_constexpr = 42.000000
Foo::regular_static = 99.000000
```
