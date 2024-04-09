#include <cstdint>
#include <span>
#include <utility>

uint64_t area(const std::span<std::pair<int, int>> points) {
  // This code has signed overflows. :)
  // Please fix this so it evaluates the area correctly ..!
  int64_t total = 0;
  size_t n = points.size();

  for (unsigned i = 0; i < n; i++) {
    unsigned j = (i + 1) % n;
    int x_i = points[i].first;
    int y_i = points[i].second;
    int x_j = points[j].first;
    int y_j = points[j].second;
    total += (x_i * (y_j - y_i) - y_i * (x_j - x_i));
  }

  total /= 2;
  return total;
}