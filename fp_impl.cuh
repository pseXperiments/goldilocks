#include "./fp.cuh"
#include "./numeric.cuh"

namespace goldilocks {
    __device__ constexpr fp fp::operator*(const fp& other) const noexcept {
        uint128_t x = static_cast<uint128_t>(data) * static_cast<uint128_t>(other.data);
        return reduce_128(x);
    }
    __device__ constexpr fp fp::operator+(const fp& other) const noexcept {
        uint64_t over = 0;
        uint64_t sum = addc(data, other.data, 0, over);
        sum = addc(sum, over * EPSILON, 0, over);
        if (over) {
            sum += EPSILON;
        }
        return { sum };
    }
    __device__ constexpr fp fp::operator-(const fp& other) const noexcept {
        uint64_t under = 0;
        uint64_t diff = sbb(data, other.data, 0, under);
        diff = sbb(diff, (under >> 63ULL) * EPSILON, 0, under);
        if (under) {
            diff -= EPSILON;
        }
        return { diff };
    }
    __device__ constexpr fp fp::operator-() const noexcept {

    }
    __device__ constexpr fp& fp::operator*=(const fp& other) noexcept {
        *this = operator*(other);
    }
    __device__ constexpr fp& fp::operator+=(const fp& other) noexcept {
        (*this) = operator+(other);
    }
    __device__ constexpr fp& fp::operator-=(const fp& other) noexcept {
        (*this) = operator-(other);
    }
    __device__ constexpr fp& fp::operator/=(const fp& other) noexcept {

    }
    __device__ constexpr bool fp::operator==(const fp& other) const noexcept {
        return (*this).to_canonical_u64() == other.to_canonical_u64();
    }
    __device__ constexpr bool fp::operator!=(const fp& other) const noexcept {

    }
    __device__ constexpr fp fp::sqr() const noexcept {

    }
    __device__ constexpr void fp::self_sqr() noexcept {

    }
    __device__ inline constexpr fp fp::reduce_128(const uint128_t x) const noexcept {
        uint64_t x_lo = x;
        uint64_t x_hi = x >> 64;
        uint64_t x_hi_hi = x_hi >> 32;
        uint64_t x_hi_lo = x_hi & EPSILON;

        uint64_t under;
        uint64_t t0 = sbb(x_lo, x_hi_hi, 0, under);
        if (under) {
            t0 -= EPSILON;
        }
        uint64_t t1 = x_hi_lo * EPSILON;
        // https://github.com/zhenfeizhang/Goldilocks/blob/872114997b82d0157e29a702992a3bd2023aa7ba/src/util.rs#L41
        return fp(t0) + fp(t1);
    }
    __device__ inline constexpr uint64_t fp::to_canonical_u64() const noexcept {
        uint64_t c = data;
        if (c >= MODULUS) {
            c -= MODULUS;
        }
        return c;
    }
}
