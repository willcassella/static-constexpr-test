# Test of using `static (constexpr|inline)` variables in C++17

You can run the test via `make`, assuming you have a version of Clang support C++17 installed.
Sample output:
```
clang++ -std=c++17 -c main.cc -o main.o
clang++ -std=c++17 -c foo.cc -o foo.o
clang++ -std=c++17 main.o foo.o -o main

Analysis of artifacts:
U = undefined symbol, D = symbol defined in "data", T = symbol defined in "text", V = "weak" symbol, r = read-only symbol

foo.o:
0000000000000000 r .LCPI0_0
0000000000000000 T increment()
0000000000000000 V Foo::static_inline
0000000000000000 D Foo::regular_static

main.o:
0000000000000000 r .LCPI0_0
                 U increment()
0000000000000000 V Foo::static_inline
                 U Foo::regular_static
0000000000000000 T main
                 U printf

Running 'main':
Foo::static_inline = 3.000000
Foo::static_constexpr = 42.000000
Foo::regular_static = 99.000000
```
