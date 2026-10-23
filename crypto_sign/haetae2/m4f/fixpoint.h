// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#ifndef HAETAE_FIXPOINT_H
#define HAETAE_FIXPOINT_H

#include "params.h"

#include <stdint.h>
#include <stdlib.h>

#ifdef __SIZEOF_INT128__
__extension__ typedef unsigned __int128 uint128;
#endif

typedef struct {
  uint64_t limb48[2];
} fp96_76;

#define fixpoint_square HAETAE_NAMESPACE(fixpoint_square)
void fixpoint_square(fp96_76 *sqx, const fp96_76 *x);

#define fixpoint_newton_invsqrt HAETAE_NAMESPACE(fixpoint_newton_invsqrt)
void fixpoint_newton_invsqrt(fp96_76 *invsqrtx, const fp96_76 *xhalf);

#define fixpoint_add HAETAE_NAMESPACE(fixpoint_add)
void fixpoint_add(fp96_76 *xy, const fp96_76 *x, const fp96_76 *y);

static inline void renormalize(fp96_76 *x) {
  x->limb48[1] += x->limb48[0] >> 48;
  x->limb48[0] &= (UINT64_C(1) << 48) - 1;
}

/*
 * (*hi, *lo) = a * b + *lo + *hi (cannot overflow 64 bits): UMAAL on Thumb-2
 * targets with the DSP extension (e.g. Cortex-M4), C elsewhere.
 */
static inline void umaal(uint32_t *lo, uint32_t *hi, uint32_t a, uint32_t b) {
#if defined(__thumb2__) && defined(__ARM_FEATURE_DSP)
  __asm__("umaal %0, %1, %2, %3" : "+r"(*lo), "+r"(*hi) : "r"(a), "r"(b));
#else
  uint64_t t = (uint64_t)a * b + *lo + *hi;
  *lo = (uint32_t)t;
  *hi = (uint32_t)(t >> 32);
#endif
}

/*
 * smulh48(a, b) = ceil(a * b / 2^48) mod 2^64, i.e. the 128-bit expression
 * (((int128)a * b) + 2^48 - 1) >> 48 of the reference, for all a and b.
 * Computed with 32-bit limbs (32x32->64 multiply-accumulates, UMULL/UMAAL on
 * the Cortex-M4): a is multiplied as an unsigned number and the product is
 * corrected by -b * 2^64 if a < 0.
 */
static inline int64_t smulh48(int64_t a, uint64_t b) {
  const uint32_t a0 = (uint32_t)a, a1 = (uint32_t)((uint64_t)a >> 32);
  const uint32_t b0 = (uint32_t)b, b1 = (uint32_t)(b >> 32);
  uint32_t w0 = UINT32_C(0xffffffff), w1 = UINT32_C(0xffff), w2 = 0, w3 = 0;
  uint64_t hi;

  // (a mod 2^64) * b + 2^48 - 1; words 1 to 3
  umaal(&w0, &w2, a0, b0); // w2 = carry into word 1
  umaal(&w1, &w2, a0, b1); // w1 = partial word 1, w2 = carry into word 2
  umaal(&w1, &w3, a1, b0); // w1 = word 1, w3 = carry into word 2
  umaal(&w2, &w3, a1, b1); // (w3, w2) = words 3 and 2
  hi = (((uint64_t)w3 << 32) | w2) - (b & (uint64_t)(a >> 63)); // a < 0

  return (int64_t)((hi << 16) | (w1 >> 16));
}

/* r = a * b (128 bits); without __int128 the cross products are added in 64
 * bits, which is exact for a, b < 2^62 (the fixed-point values used here are
 * far smaller) */
static inline void mul64(uint64_t r[2], const uint64_t b, const uint64_t a) {
#ifndef __SIZEOF_INT128__
  uint64_t al = a & ((UINT64_C(1) << 32) - 1),
           bl = b & ((UINT64_C(1) << 32) - 1), ah = a >> 32, bh = b >> 32;
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

/* r = a^2 (128 bits); without __int128 exact for a < 2^62 */
static inline void sq64(uint64_t r[2], const uint64_t a) {
#ifndef __SIZEOF_INT128__
  uint64_t al = a & ((UINT64_C(1) << 32) - 1), ah = a >> 32;
  r[0] = a * a;
  r[1] = ah * al * 2 + ((al * al) >> 32);
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
  r[0] &= (UINT64_C(1) << 48) - 1;
}

static inline void mulacc48(uint64_t r[2], const uint64_t b, const uint64_t a) {
  uint64_t tmp[2];
  mul48(tmp, b, a);
  r[0] += tmp[0];
  r[1] += tmp[1];
}

// (a0 + a1*2^32)^2 = a0^2 + 2^33*a0*a1 + 2^64*a1^2
static inline void sq48(uint64_t r[2], const uint64_t a) {
  sq64(r, a);

  r[1] <<= 16;
  r[1] ^= r[0] >> 48;
  r[0] &= (UINT64_C(1) << 48) - 1;
}

static inline void fixpoint_mul_high(fp96_76 *xy, const fp96_76 *x,
                                     const uint64_t y) {
  uint64_t tmp[2];
  mul48(&xy->limb48[0], x->limb48[0], y); // x0*y as two 48-bit limbs

  mul48(tmp, x->limb48[1], y);
  xy->limb48[1] += tmp[0];

  // shift right by 28, rounding
  xy->limb48[0] += UINT64_C(1) << 27;
  xy->limb48[0] >>= 28;
  xy->limb48[0] += (xy->limb48[1] << 20) & ((UINT64_C(1) << 48) - 1);
  xy->limb48[1] >>= 28;

  xy->limb48[1] += tmp[1] << 20;

  renormalize(xy);
}

/*
 * fixpoint_mul_rnd13(x, y, sign) = (-1)^sign * floor((x * Y + 2^122 + 2^59 +
 * 2^31) / 2^123) mod 2^32 with Y = y1 * 2^48 + y0, (y0, y1) = y->limb48,
 * for y0 < 2^48 (y normalized) and sign in {0, 1}.
 *
 * This is the result of the reference, which computes the same product with
 * three roundings: with xx = x * 2^16 = x1 * 2^48 + x0 (x0 = (x mod 2^32) <<
 * 16, x1 = x >> 32), fixpoint_mul(xx, y) is
 *   A = floor((x0*y0 + 2^47) / 2^48)
 *   B = floor((A + x0*y1 + x1*y0 + 2^27) / 2^28)
 *   V = B + x1*y1 * 2^20 = floor((xx*Y + 2^47 + 2^75) / 2^76)
 * and fixpoint_mul_rnd13 returns floor((floor(V / 2^48) + 2^14) / 2^15) =
 * floor((xx*Y + 2^47 + 2^75 + 2^138) / 2^139); dividing by 2^16 gives the
 * expression above (nested floors of integer divisions compose).  The
 * reference keeps floor(V / 2^48) modulo 2^64, which changes its result only
 * by multiples of 2^49, so the int32_t return values agree for all x and y1.
 */
static inline int32_t fixpoint_mul_rnd13(const uint64_t x, const fp96_76 *y,
                                         const uint8_t sign) {
  const uint64_t ylo = y->limb48[0] + (y->limb48[1] << 48);
  const uint64_t yhi = (y->limb48[1] >> 16) + (ylo < y->limb48[0]);
  const uint32_t w0 = (uint32_t)ylo, w1 = (uint32_t)(ylo >> 32);
  const uint32_t w2 = (uint32_t)yhi, w3 = (uint32_t)(yhi >> 32);
  const uint32_t x0 = (uint32_t)x, x1 = (uint32_t)(x >> 32);
  uint32_t p0 = UINT32_C(0x80000000), p1 = UINT32_C(0x08000000), p2 = 0;
  uint32_t p3 = UINT32_C(0x04000000), p4 = 0, p5 = 0, c = 0;
  uint64_t res;

  // x * Y + 2^122 + 2^59 + 2^31; words 3 to 5
  umaal(&p0, &c, x0, w0);
  umaal(&p1, &c, x0, w1);
  umaal(&p2, &c, x0, w2);
  umaal(&p3, &c, x0, w3);
  p4 = c;
  c = 0;
  umaal(&p1, &c, x1, w0);
  umaal(&p2, &c, x1, w1);
  umaal(&p3, &c, x1, w2);
  umaal(&p4, &c, x1, w3);
  p5 = c;

  res = (p3 >> 27) | ((uint64_t)p4 << 5) | ((uint64_t)p5 << 37);
  return (1 - 2 * (int32_t)sign) * (int64_t)res;
}

#endif /* !HAETAE_FIXPOINT_H */
