#include <cstdint>
#include <iostream>
#include <print>
#include <span>
#include <utility>
#include <vector>

uint64_t area(const std::span<std::pair<int, int>> points);

int main() {
  int N, x, y;
  std::vector<std::pair<int, int>> points;

  std::cin >> N;
  for (int i = 0; i < N; ++i) {
    std::cin >> x >> y;
    points.push_back(std::make_pair(x, y));
  }
  const auto result = area(points);
  std::println("{}", result);
  return 0;
}
