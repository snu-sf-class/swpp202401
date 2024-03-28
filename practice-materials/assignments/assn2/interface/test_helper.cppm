module;
#include <expected>
#include <string>
#include <vector>

export module test_helper;

namespace test_helper {
export std::vector<std::string> create_random_strings(const size_t num_strings);

export std::vector<std::expected<std::string, size_t>>
words_to_expecteds(const std::vector<std::string> &words);

export std::vector<std::expected<std::string, size_t>>
inject_errors(std::vector<std::expected<std::string, size_t>> &&exps,
              const size_t num_errors);
} // namespace test_helper
