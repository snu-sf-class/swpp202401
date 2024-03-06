module;
#include <cstdint>

export module arith;

export namespace arith {
int32_t add(const int32_t lhs, const int32_t rhs) noexcept;
int32_t sub(const int32_t lhs, const int32_t rhs) noexcept;
} // namespace arith
