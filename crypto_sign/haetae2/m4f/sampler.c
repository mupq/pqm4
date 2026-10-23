// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#include "sampler.h"
#include "fixpoint.h"
#include "symmetric.h"

#include <stdint.h>

/*************************************************
 * Name:        rej_uniform
 *
 * Description: Sample uniformly random coefficients in [0, HAETAE_Q-1] by
 *              performing rejection sampling on array of random bytes.
 *
 * Arguments:   - int32_t *a: pointer to output array (allocated)
 *              - unsigned int len: number of coefficients to be sampled
 *              - const uint8_t *buf: array of random bytes
 *              - unsigned int buflen: length of array of random bytes
 *
 * Returns number of sampled coefficients. Can be smaller than len if not enough
 * random bytes were given.
 *
 * Specification: Implements @[Algorithm 9, RejUniform]
 **************************************************/
unsigned int rej_uniform(int32_t *a, unsigned int len, const uint8_t *buf,
                         unsigned int buflen) {
  unsigned int ctr, pos;
  uint32_t t;

  ctr = pos = 0;
  while (ctr < len && pos + 2 <= buflen) {
    t = buf[pos++];
    t |= (uint32_t)buf[pos++] << 8;

    if (t < HAETAE_Q)
      a[ctr++] = t;
  }
  return ctr;
}

/*************************************************
 * Name:        rej_eta
 *
 * Description: Sample uniformly random coefficients in [-HAETAE_ETA,
 *              HAETAE_ETA] by performing rejection sampling on array
 *              of random bytes.
 *
 * Arguments:   - int32_t *a: pointer to output array (allocated)
 *              - unsigned int len: number of coefficients to be sampled
 *              - const uint8_t *buf: array of random bytes
 *              - unsigned int buflen: length of array of random bytes
 *
 * Returns number of sampled coefficients. Can be smaller than len if not enough
 * random bytes were given.
 *
 * Specification: Implements @[Algorithm 12, RejEta]
 **************************************************/
static int32_t mod3(uint8_t t) {
  int32_t r;
  r = (t >> 4) + (t & 0xf);
  r = (r >> 2) + (r & 3);
  r = (r >> 2) + (r & 3);
  r = (r >> 2) + (r & 3);
  return r - (3 * (r >> 1));
}
static int32_t mod3_leq26(uint8_t t) {
  int32_t r;
  r = (t >> 4) + (t & 0xf);
  r = (r >> 2) + (r & 3);
  r = (r >> 2) + (r & 3);
  return r - (3 * (r >> 1));
}
static int32_t mod3_leq8(uint8_t t) {
  int32_t r;
  r = (t >> 2) + (t & 3);
  r = (r >> 2) + (r & 3);
  return r - (3 * (r >> 1));
}
unsigned int rej_eta(int32_t *a, unsigned int len, const uint8_t *buf,
                     unsigned int buflen) {
  unsigned int ctr, pos;

  ctr = pos = 0;
  while (ctr < len && pos < buflen) {
    uint32_t t = buf[pos++];
    if (t < 243) {
      // reduce mod 3
      a[ctr++] = mod3(t);

      if (ctr >= len)
        break;

      t *= 171; // 171*3 = 1 mod 256
      t >>= 9;
      a[ctr++] = mod3(t);

      if (ctr >= len)
        break;

      t *= 171;
      t >>= 9;
      a[ctr++] = mod3_leq26(t);

      if (ctr >= len)
        break;

      t *= 171;
      t >>= 9;
      a[ctr++] = mod3_leq8(t);

      if (ctr >= len)
        break;

      t *= 171;
      t >>= 9;
      a[ctr++] = (int32_t)t - (int32_t)3 * (t >> 1);
    }
  }
  return ctr;
}

/*
 * GALACTICS [Rossi23]: degree-10 polynomial P(z) for exp(-z), z = xi/2^48.
 *
 * The constant term c_0 is lifted by +1 unit (2^{-48}) to enforce the ceiling
 * condition P_c(z) ≥ exp(-z) everywhere.
 *
 * GALACTICS rational coefficients  c_k = integer * 2^{exponent}:
 *   c_0  =                1 * 2^0     (= 1 exactly)
 *   c_1  = -140737488355325 * 2^{-47}
 *   c_2  =  140737488354861 * 2^{-48}
 *   c_3  =   -5864062013275 * 2^{-45}
 *   c_4  =   93824990983603 * 2^{-51}
 *   c_5  =  -75059957176683 * 2^{-53}
 *   c_6  =   50039335827767 * 2^{-55}
 *   c_7  = -114346678051053 * 2^{-59}
 *   c_8  =   56962476261175 * 2^{-61}
 *   c_9  =  -24365119391573 * 2^{-63}
 *   c_10 =   14645656383309 * 2^{-66}
 *
 * Integer coefficients c_k^int = ceil(c_k * 2^48):
 *   c_0^int  = 281474976710657  [GALACTICS-C: 2^48+1; lifted by +1]
 *   c_1^int  =-281474976710650  [exact]
 *   c_2^int  = 140737488354861  [exact]
 *   c_3^int  = -46912496106200  [exact]
 *   c_4^int  =  11728123872951  [ceil(11728123872950.375)]
 *   c_5^int  =  -2345623661771  [ceil(-2345623661771.344)]
 *   c_6^int  =    390932311155  [ceil(390932311154.430)]
 *   c_7^int  =    -55833338892  [ceil(-55833338892.116)]
 *   c_8^int  =      6953427278  [ceil(6953427277.975)]
 *   c_9^int  =      -743564434  [ceil(-743564434.557)]
 *   c_10^int =        55868746  [ceil(55868745.359)]
 */
static uint64_t approx_exp(const uint64_t xi) {
  int64_t r = INT64_C(55868746);                 /* c_10^int */
  r = smulh48(r, xi) - INT64_C(743564434);       /* c_9^int  */
  r = smulh48(r, xi) + INT64_C(6953427278);      /* c_8^int  */
  r = smulh48(r, xi) - INT64_C(55833338892);     /* c_7^int  */
  r = smulh48(r, xi) + INT64_C(390932311155);    /* c_6^int  */
  r = smulh48(r, xi) - INT64_C(2345623661771);   /* c_5^int  */
  r = smulh48(r, xi) + INT64_C(11728123872951);  /* c_4^int  */
  r = smulh48(r, xi) - INT64_C(46912496106200);  /* c_3^int  */
  r = smulh48(r, xi) + INT64_C(140737488354861); /* c_2^int  */
  r = smulh48(r, xi) - INT64_C(281474976710650); /* c_1^int  */
  r = smulh48(r, xi) + INT64_C(281474976710657); /* c_0^int  */
  return (uint64_t)r;
}

/*************************************************
 * Name:        sample_gauss_sigma76
 *
 * Description: Sample one value of the half-Gaussian distribution with
 *              standard deviation 16 (the sign is drawn separately): x from
 *              the discrete D_{Z,16} (CDT), y = x + u with uniform u in
 *              [0, 1) (72 fractional bits), accepted with probability
 *              exp(-(y^2 - x^2) / 512); a zero is kept with probability 1/2.
 *              (The 76 refers to the fixed-point format fp96_76.)
 *
 * Arguments:   - uint64_t *r: pointer to output y (56 fractional bits)
 *              - fp96_76 *sqr: pointer to output y^2 (76 fractional bits)
 *              - const uint8_t rand[]: pointer to GAUSS_RAND_BYTES random
 *              bytes
 *
 * Returns 1 if the sample is accepted, 0 otherwise.
 *
 * Specification: Implements @[Algorithm 16, SampleGaussSigma76]
 **************************************************/
#define GAUSS_RAND (72 + 83 + 48)
#define GAUSS_RAND_BYTES ((GAUSS_RAND + 7) / 8) // 26
static inline uint32_t load16_le(const uint8_t *p) {
  return (uint32_t)p[0] | ((uint32_t)p[1] << 8);
}

static inline uint32_t load24_le(const uint8_t *p) {
  return load16_le(p) | ((uint32_t)p[2] << 16);
}

static inline uint32_t load32_le(const uint8_t *p) {
  return load24_le(p) | ((uint32_t)p[3] << 24);
}

/*
 * Same results as the reference, computed with 32-bit limbs.  With x the
 * output of SampleGauss83 and w the 72-bit noise, y = x * 2^72 + w and
 *   r      = round(y / 2^16) = floor(y / 2^16) + bit 15 of y,
 *   sqr    = floor(y^2 / 2^76), split into 48-bit limbs,
 *   exp_in = (floor(y^2 / 2^104) - x^2 * 2^40 + 1) >> 1.
 * The reference's fixpoint_square(y) computes floor(y^2 / 2^76): its two
 * truncating shifts (by 48 and 28 bits) compose to one floor division.  Its
 * exp_in = ((((sqr1 - (x^2 << 20)) << 20) | (sqr0 >> 28)) + 1) >> 1 equals
 * the expression above since sqr1 * 2^20 + (sqr0 >> 28) = floor(sqr / 2^28)
 * and sqr >= x^2 * 2^68 (y >= x * 2^72).
 */
static int sample_gauss_sigma76(uint64_t *r, fp96_76 *sqr,
                                const uint8_t rand[GAUSS_RAND_BYTES]) {
  // rand[0..10]:  83-bit CDT random (rand_gauss83)
  // rand[11..16]: 48-bit rejection random (rand_rej)
  // rand[17..25]: 72-bit y noise
  const uint64_t rand_rej =
      load32_le(rand + 11) | ((uint64_t)load16_le(rand + 15) << 32);
  const uint32_t w2 = load24_le(rand + 23); // noise bits 48..71
  uint32_t x, y0, y1, y2, z0, z1, z2, z3, z4, c;
  uint64_t t, exp_in;

  // sample x
  x = sample_gauss83_asm(load32_le(rand), load32_le(rand + 4),
                         load24_le(rand + 8) & UINT32_C(0x7FFFF));

  // y = x * 2^72 + w = y2 * 2^64 + y1 * 2^32 + y0, y2 < 2^16 (x <= 166)
  y0 = load32_le(rand + 17);
  y1 = load16_le(rand + 21) | (w2 << 16);
  y2 = (w2 >> 16) | (x << 8);

  // r := round y
  *r = (((uint64_t)y2 << 48) | ((uint64_t)y1 << 16) | (y0 >> 16)) +
       ((y0 >> 15) & 1);

  // y^2 = z4 * 2^128 + z3 * 2^96 + z2 * 2^64 + z1 * 2^32 + z0
  z0 = z1 = z2 = z3 = z4 = c = 0;
  umaal(&z0, &c, y0, y0);
  umaal(&z1, &c, y0, y1);
  umaal(&z2, &c, y0, y2);
  z3 = c;
  c = 0;
  umaal(&z1, &c, y1, y0);
  umaal(&z2, &c, y1, y1);
  umaal(&z3, &c, y1, y2);
  z4 = c;
  c = 0;
  umaal(&z2, &c, y2, y0);
  umaal(&z3, &c, y2, y1);
  z4 += y2 * y2 + c; // y^2 < 2^160

  // sqr := y*y >> 76
  t = ((uint64_t)z3 << 20) | (z2 >> 12);
  sqr->limb48[0] = t & ((UINT64_C(1) << 48) - 1);
  sqr->limb48[1] = (t >> 48) | ((uint64_t)z4 << 4);

  // exp_in := (y^2 >> 104) - x^2 * 2^40, rounded by one bit
  exp_in = (((uint64_t)z4 << 24) | (z3 >> 8)) - ((uint64_t)(x * x) << 40);
  exp_in += 1; // rounding
  exp_in >>= 1;

  return ((((int64_t)(rand_rej ^
                      (rand_rej & 1)) // set lowest bit to zero in order to
                                      // use it for rejection if sample==0
            - (int64_t)approx_exp(exp_in)) >>
           63) // reject with prob 1 - approx_exp(exp_in) / 2^48
          & (((*r | -*r) >> 63) | rand_rej)) &
         1; // if the sample is zero, clear the return value with prob 1/2
}

/*************************************************
 * Name:        sample_gauss
 *
 * Description: sample up to len values with sample_gauss_sigma76 from the
 *              random bytes in buf and add their squares to sqsum
 *
 * Arguments:   - uint64_t *r: pointer to output integer array
 *              - fp96_76 *sqsum: pointer to input/output sum of squares
 *              - const uint8_t *buf: pointer to input byte array
 *              - size_t buflen: length of input byte array
 *              - size_t len: max length of samples
 *              - int dont_write_last: if nonzero, the len-th sample is only
 *              added to sqsum and not stored in r
 *
 * Returns the number of accepted samples (less than len if buf runs out).
 *
 * Specification: Implements @[Algorithm 15, SampleGauss]
 **************************************************/
static int sample_gauss(uint64_t *r, fp96_76 *sqsum, const uint8_t *buf,
                        size_t buflen, size_t len, int dont_write_last) {
  const uint8_t *pos = buf;
  fp96_76 sqr;
  size_t bytecnt = buflen, coefcnt = 0, cnt = 0;
  int accepted;
  uint64_t dummy;

  while (coefcnt < len) {
    if (bytecnt < GAUSS_RAND_BYTES) {
      renormalize(sqsum);
      return coefcnt;
    }

    // one call site, so that sample_gauss_sigma76 is inlined
    accepted = sample_gauss_sigma76(
        (dont_write_last && coefcnt == len - 1) ? &dummy : &r[coefcnt], &sqr,
        pos);
    cnt += 1;
    coefcnt += accepted;
    pos += GAUSS_RAND_BYTES;
    bytecnt -= GAUSS_RAND_BYTES;

    sqsum->limb48[0] += sqr.limb48[0] & -(int64_t)accepted;
    sqsum->limb48[1] += sqr.limb48[1] & -(int64_t)accepted;
  }

  renormalize(sqsum);
  return len;
}

/*************************************************
 * Name:        sample_gauss_N
 *
 * Description: sample len Gaussian values from SHAKE256(seed || nonce):
 *              the first len/8 bytes are sign bits, followed by the random
 *              bytes of sample_gauss.  len is HAETAE_N or HAETAE_N + 1; in the
 *              latter case the last sample is only added to sqsum.
 *
 * Arguments:   - uint64_t *r: pointer to output array of HAETAE_N values
 *              - uint8_t *signs: pointer to output array of HAETAE_N / 8 sign
 *              bytes
 *              - fp96_76 *sqsum: pointer to input/output sum of squares
 *              - const uint8_t seed[]: pointer to input seed
 *              - uint16_t nonce: input nonce
 *              - size_t len: number of samples
 *
 * Specification: Implements @[Algorithm 14, SampleGaussN]
 **************************************************/
#define POLY_HYPERBALL_BUFLEN (GAUSS_RAND_BYTES * HAETAE_N)
#define POLY_HYPERBALL_NBLOCKS                                                 \
  ((POLY_HYPERBALL_BUFLEN + STREAM256_BLOCKBYTES - 1) / STREAM256_BLOCKBYTES)
void sample_gauss_N(uint64_t *r, uint8_t *signs, fp96_76 *sqsum,
                    const uint8_t seed[HAETAE_CRHBYTES], uint16_t nonce,
                    size_t len) {
  uint8_t buf[POLY_HYPERBALL_NBLOCKS * STREAM256_BLOCKBYTES];
  size_t bytecnt, coefcnt, firstflag = 1;
  stream256_state state;
  stream256_init(&state, seed, nonce);

  stream256_squeezeblocks(buf, POLY_HYPERBALL_NBLOCKS, &state);
  for (size_t i = 0; i < len / 8; i++) {
    signs[i] = buf[i];
  }
  bytecnt = POLY_HYPERBALL_NBLOCKS * STREAM256_BLOCKBYTES - len / 8;
  coefcnt = sample_gauss(r, sqsum, buf + len / 8, bytecnt, len, len % HAETAE_N);
  while (coefcnt < len) {
    size_t off = bytecnt % GAUSS_RAND_BYTES;
    for (size_t i = 0; i < off; i++) {
      buf[i] = buf[bytecnt + len / 8 * firstflag - off + i];
    }
    stream256_squeezeblocks(buf + off, 1, &state);
    bytecnt = STREAM256_BLOCKBYTES + off;

    coefcnt += sample_gauss(r + coefcnt, sqsum, buf, bytecnt, len - coefcnt,
                            len % HAETAE_N);
    firstflag = 0;
  }
}
