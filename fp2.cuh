#include "fp.cuh"

namespace goldilocks {
    /// Degree 2 Goldilocks extension field mod x^2 - 7
    struct alignas(16) fp2 {
        alignas(16) fp data[2];

        __device__ constexpr fp2(const fp input0, const fp input1) noexcept : data { input0, input1 } {}
        __device__ constexpr fp2(const fp input) noexcept : data { input, fp::zero() } {}
        __device__ constexpr fp2() noexcept : data { fp::zero(), fp::zero() } {}

        __device__ constexpr fp2 operator*(const fp2& other) const noexcept;
        __device__ constexpr fp2 operator+(const fp2& other) const noexcept;
        __device__ constexpr fp2 operator-(const fp2& other) const noexcept;
        __device__ constexpr fp2 operator-() const noexcept;

        __device__ constexpr fp2& operator*=(const fp2& other) noexcept;
        __device__ constexpr fp2& operator+=(const fp2& other) noexcept;
        __device__ constexpr fp2& operator-=(const fp2& other) noexcept;

        __device__ constexpr bool operator==(const fp2& other) const noexcept;
        __device__ constexpr bool operator!=(const fp2& other) const noexcept;
        __device__ constexpr fp2 scalar_mul(const fp& scalar) const noexcept;

        __device__ static constexpr fp2 zero() { return fp2(); }
        __device__ static constexpr fp2 one() { return { fp::one() }; }
    };
}
