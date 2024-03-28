#include <cassert>
#include <cstdint>
#include <numeric>
#include <print>
#include <random>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

import maybe_something;
import test_helper;

using MaybeSomething = maybe_something::MaybeSomething;
using namespace std::string_view_literals;
namespace ms = maybe_something;

namespace {
std::random_device rd;
std::mt19937 gen(rd());
std::uniform_int_distribution<size_t> num_objs_dist(30, 50);

size_t get_random_obj_num() { return num_objs_dist(gen); }
} // namespace

int main() {
  const size_t num_something = get_random_obj_num();
  const size_t num_nothing = get_random_obj_num();
  std::vector<MaybeSomething> maybes;
  maybes.reserve(num_something + num_nothing);

  auto random_strings = test_helper::create_random_strings(num_something);

  for (size_t i = 0; i < num_something; i++) {
    if (i < (num_something) / 2) {
      auto sth = ms::create_something_by_copying(random_strings[i]);
      maybes.push_back(std::move(sth));
    } else {
      auto sth = ms::create_something_by_moving(std::move(random_strings[i]));
      maybes.push_back(std::move(sth));
    }
  }

  for (size_t i = 0; i < num_nothing; i++) {
    maybes.push_back(ms::create_nothing());
  }

  assert(ms::count_siblings(maybes.front()) == num_something);
  assert(ms::count_siblings(maybes.back()) == num_nothing);

  auto sth1 = ms::create_something_by_copying("hello");
  auto sth2 = ms::create_something_by_copying("swpp");
  assert(ms::count_siblings(sth1) == num_something + 2);

  maybes.push_back(sth1);
  maybes.push_back(sth2);
  assert(ms::count_siblings(sth1) == num_something + 4);

  {
    auto sth3 = ms::create_something_by_copying("assn2");
    maybes.push_back(std::move(sth3));
  }
  assert(ms::count_siblings(sth1) == num_something + 5);

  auto nth1 = ms::create_nothing();
  auto nth2 = ms::create_nothing();
  assert(ms::count_siblings(nth1) == num_nothing + 2);

  maybes.push_back(nth1);
  maybes.push_back(nth2);
  assert(ms::count_siblings(nth1) == num_nothing + 4);

  {
    auto nth3 = ms::create_nothing();
    maybes.push_back(std::move(nth3));
  }
  assert(ms::count_siblings(nth1) == num_nothing + 5);

  assert(ms::view(maybes.front()) == random_strings.front());
  assert(ms::view(maybes[1]) == random_strings[1]);
  assert(ms::view(maybes.back()) == "empty"sv);

  return 0;
}