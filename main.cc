#include <stdio.h>
#include "foo.h"

int main() {
    increment();
    increment();
    increment();
    printf("Foo::foo = %f\n", Foo::foo);
    printf("Foo::bar = %f\n", Foo::bar);
}
