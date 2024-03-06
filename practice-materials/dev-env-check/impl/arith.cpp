module;
#include <cstdint>

module arith;

namespace arith {
int32_t add(const int32_t lhs, const int32_t rhs) noexcept { return lhs + rhs; }
int32_t sub(const int32_t lhs, const int32_t rhs) noexcept { return lhs - rhs; }
} // namespace arith
