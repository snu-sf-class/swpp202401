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
  auto benchmark_exps = test_helper::words_to_expecteds(benchmark_words);

  const auto start_tp = std::chrono::steady_clock::now();
  const auto output_words = collect::collect_expected(benchmark_exps).value();
  const auto end_tp = std::chrono::steady_clock::now();

  const auto duration =
      std::chrono::duration_cast<std::chrono::microseconds>(end_tp - start_tp)
          .count();
  std::println("Copy collect took {} ns", duration);

  for (size_t i = 0; i < benchmark_size; i++) {
    if (benchmark_words[i] != output_words[i]) {
      std::println("Incorrect output! Expected '{}', found '{}'",
                   benchmark_words[i], output_words[i]);
      return 1;
    }
  }
  return 0;
}
