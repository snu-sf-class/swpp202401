#include <print>

import arith;

int main() {
    const auto add_result = arith::add(32, 64);
    const auto sub_result = arith::sub(32, 64);
    std::println("hello, world! {}", add_result);
    std::println("second result is {}!", sub_result);
    return 0;
}
