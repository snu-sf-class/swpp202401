#include <chrono>
#include <cstdint>
#include <expected>
#include <print>
#include <string>
#include <vector>

import collect;
import test_helper;

int main() {
  using ExpType = std::expected<std::string, size_t>;

  constexpr size_t benchmark_size = 5000000;
  const auto benchmark_words = test_helper::create_random_strings(benchmark_size);
  auto benchmark_exps = test_helper::inject_errors(
      test_helper::words_to_expecteds(benchmark_words), 100);

  const auto output_error = collect::collect_expected(benchmark_exps).error();
  if (benchmark_exps[output_error].error() != output_error) {
    std::println("Unexpected error! Expected '{}', found '{}'",
                   benchmark_exps[output_error].error(), output_error);
    return 1;
  }
  return 0;
}
