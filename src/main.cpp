#include <fmt/core.h>
#include <vector>

int main()
{
    std::vector<char> out;
    fmt::format_to(std::back_inserter(out), "The answer is {}.", 42);

    return 0;
}