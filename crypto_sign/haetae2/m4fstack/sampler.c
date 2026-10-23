/*
 * Copyright 2026 YoungBeom Kim, Christine van Vredendaal, Gustavo Banegas, and Seog Chung Seo
 *
 * Derived from the HAETAE reference implementation, Copyright (c) 2026
 * Team HAETAE, MIT License (see LICENSE).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include "sampler.h"
#include "fixpoint.h"
#include "symmetric.h"
#include <stdint.h>
#include <string.h>

/*************************************************
 * Name:        rej_uniform
 *
 * Description: Sample uniformly random coefficients in [0, Q-1] by
 *              performing rejection sampling on array of random bytes.
 *
 * Arguments:   - int32_t *a: pointer to output array (allocated)
 *              - unsigned int len: number of coefficients to be sampled
 *              - const uint8_t *buf: array of random bytes
 *              - unsigned int buflen: length of array of random bytes
 *
 * Returns number of sampled coefficients. Can be smaller than len if not enough
 * random bytes were given.
 **************************************************/
unsigned int rej_uniform(int32_t *a, unsigned int len, const uint8_t *buf,
                         unsigned int buflen) {
    unsigned int ctr, pos;
    uint32_t t;

    ctr = pos = 0;
    while (ctr < len && pos + 2 <= buflen) {
        t = buf[pos++];
        t |= (uint32_t)buf[pos++] << 8;

        if (t < Q)
            a[ctr++] = t;
    }
    return ctr;
}
unsigned int rej_uniform_add(int32_t *a, unsigned int len, const uint8_t *buf,
                         unsigned int buflen) {
    unsigned int ctr, pos;
    uint32_t t;

    ctr = pos = 0;
    while (ctr < len && pos + 2 <= buflen) {
        t = buf[pos++];
        t |= (uint32_t)buf[pos++] << 8;

        if (t < Q)
            a[ctr++] += t;
    }
    return ctr;
}




/*************************************************
 * Name:        rej_eta
 *
 * Description: Sample uniformly random coefficients in [-ETA, ETA] by
 *              performing rejection sampling on array of random bytes.
 *
 * Arguments:   - int32_t *a: pointer to output array (allocated)
 *              - unsigned int len: number of coefficients to be sampled
 *              - const uint8_t *buf: array of random bytes
 *              - unsigned int buflen: length of array of random bytes
 *
 * Returns number of sampled coefficients. Can be smaller than len if not enough
 * random bytes were given.
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
static int sample_gauss_sigma76(uint64_t *r, fp96_76 *sqr,
                                const uint8_t rand[GAUSS_RAND_BYTES]) {
  // rand[0..10]:  83-bit CDT random (rand_gauss83)
  // rand[11..16]: 48-bit rejection random (rand_rej)
  // rand[17..25]: 72-bit y noise
  const uint64_t rand_gauss83_lo =
      rand[0] | (((uint64_t)rand[1]) << 8) | (((uint64_t)rand[2]) << 16) |
      (((uint64_t)rand[3]) << 24) | (((uint64_t)rand[4]) << 32) |
      (((uint64_t)rand[5]) << 40) | (((uint64_t)rand[6]) << 48) |
      (((uint64_t)rand[7]) << 56);
  const uint32_t rand_gauss83_hi =
      (rand[8] | (((uint32_t)rand[9]) << 8) | (((uint32_t)rand[10]) << 16)) &
      UINT32_C(0x7FFFF); // mask to 19 bits
  const uint64_t rand_rej =
      rand[11] | (((uint64_t)rand[12]) << 8) | (((uint64_t)rand[13]) << 16) |
      (((uint64_t)rand[14]) << 24) | (((uint64_t)rand[15]) << 32) |
      (((uint64_t)rand[16]) << 40);
  uint64_t x, exp_in;
  fp96_76 y;

  // sample x (SampleGauss83, constant-time assembly: sample_gauss83.S)
  x = sample_gauss83_asm((uint32_t)rand_gauss83_lo,
                         (uint32_t)(rand_gauss83_lo >> 32), rand_gauss83_hi);

  // y := append x to y
  // leave 16 bit for carries
  y.limb48[0] = rand[17] | ((uint64_t)rand[18] << 8) |
                ((uint64_t)rand[19] << 16) | ((uint64_t)rand[20] << 24) |
                ((uint64_t)rand[21] << 32) | ((uint64_t)rand[22] << 40);
  y.limb48[1] = rand[23] | ((uint64_t)rand[24] << 8) |
                ((uint64_t)rand[25] << 16) | (x << 24);

  // r := round y
  // x <= 166 (the CDT has 166 entries), so y.limb48[1] < 167*2^24 < 2^32,
  // and << 33 would overflow uint64_t for x >= 128.  Split: lower bits round
  // separately, then add upper bits via << 32 (safe since
  // y.limb48[1] * 2^32 < 167*2^56 < 2^64).
  *r = ((y.limb48[0] >> 15) + 1) >> 1;
  *r += y.limb48[1] << 32;

  // sqr := y*y
  fixpoint_square(sqr, &y);

  // sqr[1] = y^2 >> (76+48)                // 35 bit
  // sqr[0] = (y^2 >> 76) & ((UINT64_C(1)<<48)-1)   // 48 bit
  // exp_in := sqr - ((x*x) << 68)
  exp_in = sqr->limb48[1] - ((x * x) << (68 - 48));
  exp_in <<= 20;
  exp_in |= sqr->limb48[0] >> 28;
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

/*
 * ============================================================
 * Streaming Gaussian sampler (one sample at a time)
 * ============================================================
 *
 * Consumes the stream256(seed, nonce) bytes in exactly the order of the
 * reference SampleGaussN (len/8 sign bytes, then GAUSS_RAND_BYTES per
 * attempt), so the samples are bit-identical while only one sample is kept.
 */

/* Squeeze outlen bytes from the context's block buffer. */
static void gauss_ctx_squeeze(gauss_stream_ctx *ctx,
                               uint8_t *out, size_t outlen) {
    while (outlen > 0) {
        if (ctx->block_idx >= STREAM256_BLOCKBYTES) {
            stream256_squeezeblocks(ctx->block, 1, &ctx->shake_st);
            ctx->block_idx = 0;
        }
        size_t take = STREAM256_BLOCKBYTES - ctx->block_idx;
        if (take > outlen)
            take = outlen;
        memcpy(out, ctx->block + ctx->block_idx, take);
        ctx->block_idx += take;
        out += take;
        outlen -= take;
    }
}

void gauss_stream_init(gauss_stream_ctx *ctx,
                       const uint8_t seed[CRHBYTES],
                       uint16_t nonce, size_t len) {
    stream256_init(&ctx->shake_st, seed, nonce);
    ctx->block_idx = STREAM256_BLOCKBYTES; /* mark as empty */
    ctx->total_len = len;
    ctx->coefcnt = 0;
    ctx->dont_write_last = (len % N);

    /* Squeeze the sign bits first (same order as SampleGaussN). */
    const size_t sign_bytes = len / 8;
    if (sign_bytes > 0)
        gauss_ctx_squeeze(ctx, ctx->signs, sign_bytes);
}

void gauss_stream_sample(gauss_stream_ctx *ctx,
                         uint64_t *sample_out,
                         fp96_76 *sqr_out) {
    uint8_t rand_bytes[GAUSS_RAND_BYTES];
    uint64_t dummy;
    int accepted;

    for (;;) {
        gauss_ctx_squeeze(ctx, rand_bytes, GAUSS_RAND_BYTES);

        if (ctx->dont_write_last &&
            ctx->coefcnt == ctx->total_len - 1) {
            accepted = sample_gauss_sigma76(&dummy, sqr_out, rand_bytes);
        } else {
            accepted = sample_gauss_sigma76(sample_out, sqr_out, rand_bytes);
        }

        if (accepted)
            break;
    }
    ctx->coefcnt++;
}
