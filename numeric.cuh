#include <cstdint>

namespace numeric {
    using uint128_t = unsigned __int128;
    __device__ constexpr uint64_t addc(const uint64_t a, const uint64_t b, const uint64_t carry_in, uint64_t& carry_out) noexcept {
        uint64_t r = a + b;
        const uint64_t carry_temp = r < a;
        r += carry_in;
        carry_out = carry_temp + (r < carry_in);
        return r;
    }

    __device__ constexpr uint64_t sbb(const uint64_t a, const uint64_t b, const uint64_t borrow_in, uint64_t& borrow_out) noexcept {
        uint64_t t_1 = a - (borrow_in >> 63ULL);
        uint64_t borrow_temp_1 = t_1 > a;
        uint64_t t_2 = t_1 - b;
        uint64_t borrow_temp_2 = t_2 > t_1;
        borrow_out = 0ULL - (borrow_temp_1 | borrow_temp_2);
        return t_2;
    }
}
