#include <cstdint>

namespace numeric {
    using uint128_t = unsigned __int128;
    constexpr uint64_t addc(const uint64_t a, const uint64_t b, const uint64_t carry_in, uint64_t& carry_out) noexcept {
        uint128_t res = static_cast<uint128_t>(a) + static_cast<uint128_t>(b) + static_cast<uint128_t>(carry_in);
        carry_out = static_cast<uint64_t>(res >> 64);
        return static_cast<uint64_t>(res);
    }

    constexpr uint64_t sbb(const uint64_t a, const uint64_t b, const uint64_t borrow_in, uint64_t& borrow_out) noexcept {
        uint128_t res = static_cast<uint128_t>(a) - (static_cast<uint128_t>(b) + static_cast<uint128_t>(borrow_in >> 63));
        borrow_out = static_cast<uint64_t>(res >> 64);
        return static_cast<uint64_t>(res);
    }
}
