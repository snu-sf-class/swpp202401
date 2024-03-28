module;
#include <cstdint>
#include <string>
#include <string_view>
#include <variant>

export module maybe_something;

namespace maybe_something {
class Something {
private:
  // Number of Something objects created so far
  static size_t global_num_objects;
  std::string content;

public:
  // A constructor that can accept both std::string and Cstring
  // This constructor will copy the parameter into content
  // This increases global_num_objects by 1
  // [TOFIX]!!!
    Something(???);

    // A constructor that 'takes' std::string
    // This constructor will move the parameter into content
    // This increases global_num_objects by 1
    // [TOFIX]!!!
    Something(???);

    // Copy constructor and copy assignment operator
    // Copy constructor increases global_num_objects by 1
    Something(const Something &other);
    Something &operator=(const Something &other);

    // Move constructor and move assignment operator
    // Move constructor does not increase global_num_objects
    Something(Something &&other) noexcept;
    Something &operator=(Something &&other) noexcept;

    // Destructor
    // This decreases global_num_objects by 1
    ~Something();

    // return the string_view to the content
    std::string_view view_content() const;

    // return the number of Something objects
    size_t count() const noexcept;
};

class Nothing {
  private:
    static size_t global_num_objects;

  public:
    // This increases global_num_objects by 1
    Nothing();

    // Copy constructor and copy assignment operator
    // Copy constructor increases global_num_objects by 1
    // Copy assignment does not modify global_num_objects
    Nothing(const Nothing &other);
    Nothing &operator=(const Nothing &other);

    // Move constructor and move assignment operator
    // Move constructor does not increase global_num_objects
    // Move assignment does not modify global_num_objects
    Nothing(Nothing &&other) noexcept;
    Nothing &operator=(Nothing &&other) noexcept;

    // Destructor
    // This decreases global_num_objects by 1
    ~Nothing();

    // return the number of Nothing objects
    size_t count() const noexcept;
};

// std::variant is a generalization of pair, or a type-safe union
// It may contain arbitrary kinds of types
// Accesses to the containing data is type-safe
// Note that invalid access to the variant will still crash the program!
// We say that variant is safe because invalid access throws exception,
// which is safer and predictable than UB
export using MaybeSomething = std::variant<Nothing, Something>;

// A function that can accept both std::string and Cstring
// to create Something object
// [TOFIX]!!!
export MaybeSomething create_something_by_copying(???);

// A function that 'takes' std::string and create Something object
// [TOFIX]!!!
export MaybeSomething create_something_by_moving(???);

// A function that creates Nothing object
export MaybeSomething create_nothing();

// A function that shows the content if the underlying object is Something
// and shows "empty" if the underlying object is Nothing
export std::string_view view(const MaybeSomething &thing);

// A function that counts the # of objects of the same kind
// If `thing` contains `Something`, it returns the # of `Something` objects
// and # of `Nothing` otherwise
export size_t count_siblings(const MaybeSomething &thing);
} // namespace maybe_something
