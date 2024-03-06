## Dev-Env-Check

This project is a simple program that tests the following:
* Does the compiler support C++23 language & library features?
* Do the build tools support C++ module?

### How to build
1. Install LLVM 18.1.0 with clang and libc++, CMake 3.28.0 or later, and
ninja 1.11 or later.  
You may want use the scripts provided in `scripts-linux` or `scripts-macos`.
2. Edit `build-and-run.sh` to specify the correct LLVM, CMake, and Ninja
directory in your system.
> \# Edit three variables below to match your system configuration  
MAKE_DIR=\~/cmake-3.28.3  
LLVM_DIR=\~/llvm-18.1.0  
NINJA_DIR=~/ninja-1.11.1  
3. Run `build-and-run.sh`. Your output should look like:
```bash
[12/12] Linking CXX executable hello
hello, world! 96
second result is -32!
```
4. Edit impl/arith.cpp without changing any of the function signatures.
```diff
- int32_t sub(const int32_t lhs, const int32_t rhs) noexcept { return lhs - rhs; }
+ int32_t sub(const int32_t lhs, const int32_t rhs) noexcept { return lhs * rhs; }
```
, and then re-run `build-and-run.sh`.  
Recompilation should not take more than a second.

### Adding Dynamic Linker Configuration

If the program compiles but crashes upon execution with errors like
```bash
build/hello: symbol lookup error: build/hello: undefined symbol: _ZNSt3__119__is_posix_terminalEP8_IO_FILE
```
, add a dynamic linker config file `/etc/ld.so.conf.d/libcxx-18.conf`
```bash
# you'll need sudo as /etc is owned by root
echo "<llvm-installation-directory>/lib/x86_64-unknown-linux-gnu" | sudo tee /etc/ld.so.conf.d/libcxx-18.conf
sudo ldconfig
```
