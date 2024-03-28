module;
#include <algorithm>
#include <expected>
#include <iterator>
#include <numeric>
#include <random>
#include <string>
#include <utility>
#include <vector>

module test_helper;

namespace test_helper {
std::vector<std::string> create_random_strings(const size_t num_strings) {
  std::vector<std::string> words;
  words.reserve(num_strings);

  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_int_distribution<unsigned int> char_dist('0', 'z');
  std::uniform_int_distribution<size_t> len_dist(0, 50);

  for (size_t benchmark_index = 0; benchmark_index < num_strings;
       benchmark_index++) {
    const size_t len = len_dist(gen);
    std::string word;
    word.reserve(len);
    for (size_t char_idx = 0; char_idx < len; char_idx++) {
      word.push_back(static_cast<char>(char_dist(gen)));
    }

    words.push_back(std::move(word));
  }

  return words;
}

std::vector<std::expected<std::string, size_t>>
words_to_expecteds(const std::vector<std::string> &words) {
  using ExpType = std::expected<std::string, size_t>;

  std::vector<ExpType> exps;
  exps.reserve(words.size());

  std::transform(words.begin(), words.end(), std::back_inserter(exps),
                 [](const auto &word) { return ExpType(word); });
  return exps;
}

std::vector<std::expected<std::string, size_t>>
inject_errors(std::vector<std::expected<std::string, size_t>> &&exps,
              const size_t num_errors) {
  using ExpType = std::expected<std::string, size_t>;

  std::vector<size_t> err_indices;
  err_indices.reserve(exps.size());
  for (size_t i = 0; i < exps.size(); i++) {
    err_indices.push_back(i);
  }
  auto rd = std::random_device{};
  auto rng = std::default_random_engine{rd()};
  std::shuffle(err_indices.begin(), err_indices.end(), rng);

  for (size_t i = 0; i < num_errors; i++) {
    const auto err_index = err_indices[i];
    exps[err_index] = std::unexpected(err_index);
  }

  return exps;
}
} // namespace test_helper
