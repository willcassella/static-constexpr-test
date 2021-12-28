#if defined(BUILD_SHARED) && defined(FOO_IMPL)
#   define FOO_EXPORT __attribute__((visibility("default")))
#else
#   define FOO_EXPORT
#endif

struct FOO_EXPORT Foo {
    // New to C++17: inline contexpr non-integral variables without TU definition
    static constexpr double static_constexpr = 42.0;

    // New to C++17: inline non-constexpr non-integral variables
    static inline double static_inline = 0.0;

    // Regular old static variable
    static double regular_static;
};

// Increments 'Foo::static_inline'
void FOO_EXPORT increment();
