#ifndef MY_TEMPLATE_CUH
#define MY_TEMPLATE_CUH

#include <cstdint>
#include "numeric.hpp"

namespace goldilocks {
using namespace numeric;
static constexpr uint64_t MODULUS = 0xffffffff00000001;
static constexpr uint64_t EPSILON = 0xffffffff;

struct alignas(8) fp {
    alignas(8) uint64_t data;

    __device__ constexpr fp(const uint64_t input) noexcept : data { input } {}

    __device__ constexpr fp operator*(const fp& other) const noexcept;
    __device__ constexpr fp operator+(const fp& other) const noexcept;
    __device__ constexpr fp operator-(const fp& other) const noexcept;
    __device__ constexpr fp operator-() const noexcept;

    __device__ constexpr fp& operator*=(const fp& other) noexcept;
    __device__ constexpr fp& operator+=(const fp& other) noexcept;
    __device__ constexpr fp& operator-=(const fp& other) noexcept;
    __device__ constexpr fp& operator/=(const fp& other) noexcept;

    __device__ constexpr bool operator==(const fp& other) const noexcept;
    __device__ constexpr bool operator!=(const fp& other) const noexcept;

    __device__ constexpr fp sqr() const noexcept;
    __device__ constexpr void self_sqr() noexcept;
    __device__ inline constexpr fp reduce_128(const uint128_t x) const noexcept;
    __device__ inline constexpr uint64_t to_canonical_u64() const noexcept;

    __device__ static constexpr fp zero() { return { 0 }; }
    __device__ static constexpr fp one() { return { 1 }; }

    constexpr fp& operator=(const fp& other) noexcept = default;
    constexpr fp& operator=(fp&& other) noexcept = default;
    constexpr fp(const fp& other) noexcept = default;
    constexpr fp(fp&& other) noexcept = default;
};
}

#endif
