struct Foo {
    // New to C++17: inline contexpr non-integral variables without TU definition
    static constexpr double static_constexpr = 42.0;

    // New to C++17: inline non-constexpr non-integral variables
    static inline double static_inline = 0.0;

    // Regular old static variable
    static double regular_static;
};

// Increments 'Foo::static_inline'
void increment();
