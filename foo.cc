#include "foo.h"

double Foo::regular_static = 99.0;

void increment() {
    Foo::static_inline += 1.0;
}
