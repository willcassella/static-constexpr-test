#include <stdio.h>
#include "foo.h"

int main() {
    increment();
    increment();
    increment();
    printf("Foo::static_inline = %f\n", Foo::static_inline);
    printf("Foo::static_constexpr = %f\n", Foo::static_constexpr);
    printf("Foo::regular_static = %f\n", Foo::regular_static);
}
