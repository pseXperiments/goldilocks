#ifndef MY_TEMPLATE_CUH
#define MY_TEMPLATE_CUH

#include <cstdint>

namespace goldilocks {
static constexpr uint64_t MODULUS = 0xffffffff00000001;
static constexpr uint64_t EPSILON = 0xffffffff;

struct alignas(8) fp {
    alignas(8) uint64_t data;

    __device__ constexpr fp(const uint64_t input) noexcept : data { input } {}

    __device__ constexpr fp operator*(const fp& other) const noexcept;
    __device__ constexpr fp operator+(const fp& other) const noexcept;
    __device__ constexpr fp operator-(const fp& other) const noexcept;
    __device__ constexpr fp operator-() const noexcept;

    __device__ constexpr fp operator++() noexcept;
    __device__ constexpr fp operator++(int) noexcept;

    __device__ constexpr fp& operator*=(const fp& other) noexcept;
    __device__ constexpr fp& operator+=(const fp& other) noexcept;
    __device__ constexpr fp& operator-=(const fp& other) noexcept;
    __device__ constexpr fp& operator/=(const fp& other) noexcept;

    __device__ constexpr bool operator>(const fp& other) const noexcept;
    __device__ constexpr bool operator<(const fp& other) const noexcept;
    __device__ constexpr bool operator==(const fp& other) const noexcept;
    __device__ constexpr bool operator!=(const fp& other) const noexcept;

    __device__ constexpr fp to_montgomery_form() const noexcept;
    __device__ constexpr fp from_montgomery_form() const noexcept;

    __device__ constexpr fp sqr() const noexcept;
    __device__ constexpr void self_sqr() noexcept;
};
}

#endif
