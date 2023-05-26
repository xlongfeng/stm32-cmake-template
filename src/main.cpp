#include <fmt/core.h>

template<typename T> class queue
{
  public:
    using value_type = T;
    using size_type = std::size_t;
    using difference_type = std::ptrdiff_t;
    using pointer = value_type *;
    using const_pointer = const value_type *;
    using reference = value_type &;
    using const_reference = const value_type &;
    queue() = default;
    void push_back(const T &value) {}
};

int main()
{
    queue<char> out;
    fmt::format_to(std::back_inserter(out), "The answer is {}.", 42);

    return 0;
}