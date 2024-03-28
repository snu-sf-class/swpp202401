module;
#include <algorithm>
#include <concepts>
#include <expected>
#include <vector>

export module collect;

namespace collect {
export template <std::movable T, std::movable E>
std::expected<std::vector<T>, E>
collect_expected(const std::vector<std::expected<T, E>> &inputs) {
  using RetType = std::expected<std::vector<T>, E>;

  return RetType();
}

export template <std::movable T, std::movable E>
std::expected<std::vector<T>, E>
move_collect_expected(std::vector<std::expected<T, E>> &&inputs) {
  using RetType = std::expected<std::vector<T>, E>;

  return RetType();
}
} // namespace collect
