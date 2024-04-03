## SWPP Assignment 2

### 1. Implement `collect` module
Implement a simple module that takes a vector of `std::expected`, and collect them
into a single expected that holds a vector.  
That is, convert
```c++
std::vector<std::expected<T, E>>
```
into
```c++
std::expected<std::vector<T>, E>
```
If all of the input expected contains value, the function should return an
expected that holds vector of all values.  
If any of the input expected contains error, the function should return the
first error that appears in the input.  
Modify and complete the module interface `interface/collect.cppm`.

`collect_expected` takes a const reference of a vector as an argument.  
`move_collect_expected` takes an rvalue of a vector as an argument
and will try to move the elements into the return value if possible.  
If you have correctly implemented `move_collect_expected`, you'll notice
significant speedup compared to the copying version.

If your implementation passes every test, you'll get the full mark.  
Even if your `move_collect_expected` is slower than `collect_expected`,
you won't be penalized for its performance as long as it is correct.

### 2. Implement `maybe_something` module
Implement a simple module that may or may not contain a `std::string`
and keep track of number of each object.  
You'll have to implement copy and move operations for two classes
`Something` and `Nothing`, which is hidden inside the module.  
Modify and complete the module interface `interface/maybe_something.cppm`,
and write the module implementation unit `impl/maybe_something.cpp`.

Some functions in the module interface have incomplete signature.
You have to complete the function signature, and implement its definition
in the module implementation unit.  
Such functions are marked with `// [TOFIX]!!!`.

`Something` and `Nothing` are in a `VALID` state when constructed.
Moving functions may put an object in a `MOVED_FROM` state.  
You may only assign to & destroy `MOVED_FROM` object. Calling other operations
on a `MOVED_FROM` object is considered as UB.  
That is, you may implement it whichever way you prefer
(exception, exit, trap, whatever...), and we won't test such cases.

If your implementation passes every test, you'll get the full mark.
