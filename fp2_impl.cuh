#include "fp.cuh"
#include "fp2.cuh"

namespace goldilocks {
    __device__ constexpr fp2 fp2::operator*(const fp2& other) const noexcept {
        fp a0b0 = data[0] * other.data[0];
        fp a0b1 = data[0] * other.data[1];
        fp a1b0 = data[1] * other.data[0];
        fp a1b1 = data[1] * other.data[1];

        fp c0 = a0b0 + fp(7) * a1b1;
        fp c1 = a0b1 + a1b0;
        return fp2(c0, c1);
    }
    __device__ constexpr fp2 fp2::operator+(const fp2& other) const noexcept {
        return fp2((*this).data[0] + other.data[0], (*this).data[1] + other.data[1]);
    }
    __device__ constexpr fp2 fp2::operator-(const fp2& other) const noexcept {
        return fp2((*this).data[0] - other.data[0], (*this).data[1] - other.data[1]);
    }
    __device__ constexpr fp2 fp2::operator-() const noexcept {
        return fp2(-(*this).data[0], -(*this).data[1]);
    }
    __device__ constexpr fp2& fp2::operator*=(const fp2& other) noexcept {
        *this = operator*(other);
        return *this;
    }
    __device__ constexpr fp2& fp2::operator+=(const fp2& other) noexcept {
        *this = operator+(other);
        return *this;
    }
    __device__ constexpr fp2& fp2::operator-=(const fp2& other) noexcept {
        *this = operator-(other);
        return *this;
    }
    __device__ constexpr bool fp2::operator==(const fp2& other) const noexcept {
        return (*this).data[0] == other.data[0] && (*this).data[1] == other.data[1];
    }
    __device__ constexpr bool fp2::operator!=(const fp2& other) const noexcept {
        return !(*this).operator==(other);
    }
}
