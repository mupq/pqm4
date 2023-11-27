#ifndef FP__H
#define FP__H

#include "config.h"
#include <stdint.h>
#include <stdlib.h>

#ifdef __SIZEOF_INT128__
__extension__ typedef __int128 int128;
__extension__ typedef unsigned __int128 uint128;
#endif

typedef struct {
    uint64_t limb48[2];
} fp96_76;

#define fixpoint_square HAETAE_NAMESPACE(fixpoint_square)
void fixpoint_square(fp96_76 *sqx, const fp96_76 *x);

#define fixpoint_newton_invsqrt HAETAE_NAMESPACE(fixpoint_newton_invsqrt)
void fixpoint_newton_invsqrt(fp96_76 *invsqrtx, const fp96_76 *xhalf);

#define fixpoint_mul_rnd13 HAETAE_NAMESPACE(fixpoint_mul_rnd13)
int32_t fixpoint_mul_rnd13(const uint64_t x, const fp96_76 *y,
                           const uint8_t sign);

#define fixpoint_add HAETAE_NAMESPACE(fixpoint_add)
void fixpoint_add(fp96_76 *xy, const fp96_76 *x, const fp96_76 *y);

static inline void renormalize(fp96_76 *x) {
    x->limb48[1] += x->limb48[0] >> 48;
    x->limb48[0] &= (1ULL << 48) - 1;
}

static inline int64_t smulh48(int64_t a, uint64_t b) {
#ifndef __SIZEOF_INT128__
    int64_t ah = a >> 24;
    int64_t al = a - (ah << 24);
    int64_t bl = b & ((1<<24)-1);
    int64_t bh = b >> 24;

    int64_t res = (al*bl) >> 24;
    res += al * bh  +  ah * bl  +  (1 << 23); // rounding
    res >>= 24;
    return res + (ah * bh);
#else
    return ((int128)a * (int128)b + (1ULL << 47)) >> 48; // rounding
#endif
}

static inline void mul64(uint64_t r[2], const uint64_t b, const uint64_t a) {
#ifndef __SIZEOF_INT128__
    uint64_t al = a & ((1ULL << 32) - 1), bl = b & ((1ULL << 32) - 1),
             ah = a >> 32, bh = b >> 32;
    r[0] = a * b;
    r[1] = ah * bl + al * bh + ((al * bl) >> 32);
    r[1] >>= 32;
    r[1] += ah * bh;
#else
    uint128 res = ((uint128)a * (uint128)b);
    r[0] = res;
    r[1] = res >> 64;
#endif
}

static inline void sq64(uint64_t r[2], const uint64_t a) {
#ifndef __SIZEOF_INT128__
    uint64_t al = a & ((1ULL << 32) - 1), ah = a >> 32;
    r[0] = a * a;
    r[1] = ah * al * 2;
    r[1] >>= 32;
    r[1] += ah * ah;
#else
    uint128 res = ((uint128)a * (uint128)a);
    r[0] = res;
    r[1] = res >> 64;
#endif
}

static inline void mul48(uint64_t r[2], const uint64_t b, const uint64_t a) {
    mul64(r, b, a);
    r[1] <<= 16;
    r[1] ^= r[0] >> 48;
    r[0] &= (1ULL << 48) - 1;
}

static inline void mulacc48(uint64_t r[2], const uint64_t b, const uint64_t a) {
    uint64_t tmp[2];
    mul48(tmp, b, a);
    r[0] += tmp[0];
    r[1] += tmp[1];
}

// (a0 + a1*2^32)^2 = a0^2 + 2^33*a0*a1 + 2^64*a1^2
static inline void sq48(uint64_t r[2], const uint64_t a) {
    uint64_t al = a & ((1ULL << 32) - 1), ah = a >> 32;
    r[0] = a * a;
    r[1] = al * ah << 1;
    r[1] >>= 32;
    r[1] += ah * ah;

    r[1] <<= 16;
    r[1] ^= r[0] >> 48;
    r[0] &= (1ULL << 48) - 1;
}

static inline void fixpoint_mul_high(fp96_76 *xy, const fp96_76 *x,
                                     const uint64_t y) {
    uint64_t tmp[2];
    mul48(&xy->limb48[0], x->limb48[0], y); // implicitly shifted right by 48

    mul48(tmp, x->limb48[1], y);
    xy->limb48[1] += tmp[0];

    // shift right by 28, rounding
    xy->limb48[0] += 1UL << 27;
    xy->limb48[0] >>= 28;
    xy->limb48[0] += (xy->limb48[1] << 20) & ((1ULL << 48) - 1);
    xy->limb48[1] >>= 28;

    xy->limb48[1] += tmp[1] << 20;

    renormalize(xy);
}

#endif
