#include "config.h"
#include "sampler.h"
#include "fixpoint.h"
#include "symmetric.h"
#include "fast_sampler.h"
#include "fpa.h"
#include "fp84_76.h"
#include "fast_exp_asm.h"
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

/*************************************************
 * Name:        rej_uniform_frozen
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
unsigned int rej_uniform_frozen(uint16_t *a, unsigned int len, const uint8_t *buf,
                         unsigned int buflen) {
    unsigned int ctr, pos;
    uint16_t t;

    ctr = pos = 0;
    while (ctr < len && pos + 2 <= buflen) {
        t = buf[pos++];
        t |= (uint16_t)buf[pos++] << 8;

        if (t < Q)
            a[ctr++] = t;
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
#if ETA == 1
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
#elif ETA == 2
        uint32_t t0, t1;
        t0 = buf[pos] & 0x0F;
        t1 = buf[pos++] >> 4;
        if (t0 < 15) {
            t0 = t0 - (205 * t0 >> 10) * 5;
            a[ctr++] = 2 - t0;
        }
        if (t1 < 15 && ctr < len) {
            t1 = t1 - (205 * t1 >> 10) * 5;
            a[ctr++] = 2 - t1;
        }
#endif
    }
    return ctr;
}

static inline uint16_t read_gauss16_asm(const uint8_t src[GAUSS_RAND_BYTES]){
    uint16_t result;
    asm(
        "ldrh   %[dest], [%[ptr]]":
        [dest] "=r" (result):
        [ptr] "r" (src)
    );
    return result;
}

static fp63_48 read_rej_asm(const uint8_t src[GAUSS_RAND_BYTES]){
    uint32_t result_lo;
    uint32_t result_hi;
    asm(
        "ldrh   %[hi], [%[ptr], #6]\n\t"
        "ldr    %[lo], [%[ptr], #2]":
        [lo] "=r" (result_lo), [hi] "=r" (result_hi):
        [ptr] "r" (src)
    );
    return (fp63_48) result_hi << 32 | result_lo;
}

void read_y_typepunning(fp84_76* y, const uint8_t src[GAUSS_RAND_BYTES]){
    y->digit[0] = ((int32_t) *(&src[8])) & ((1<<28)-1);
    y->digit[1] = ((int32_t) *(&src[11])) >> 4;
    y->digit[2] = ((int32_t) *(&src[13])) >> 16;
}

/*************************************************************
 * Name:        read_y
 * Description: Read the 72 lsb bits of y from bytes 8-16
 *              of src into 28-bit digits. The nibbles of
 *              the high byte of byte 11 are shared between
 *              lo and md. No data out of bounds is being read.
 *************************************************************/
static inline void read_y(fp84_76* y, const uint8_t src[GAUSS_RAND_BYTES]){
    uint32_t result_lo;
    uint32_t result_md;
    uint32_t result_hi;

    asm(
        "ldr    %[lo], [%[ptr],  #8]\n\t"   // read bytes  8-11 
        "ldr    %[md], [%[ptr], #11]\n\t"   // read bytes 11-14
        "ldrh   %[hi], [%[ptr], #15]\n\t"   // read bytes 15-16
        "bic    %[lo], %[lo], #0xF0000000\n\t"  // clear upper nibble of byte 11
        "lsr    %[md], %[md], #4\n\t":      // lose lower nibble of byte 11
        [lo] "=r" (result_lo), [md] "=r" (result_md), [hi] "=r" (result_hi):
        [ptr] "r" (src)
    );
    y->digit[0] = (digit28) result_lo;
    y->digit[1] = (digit28) result_md;
    y->digit[2] = (digit28) result_hi;
}

static inline fp63_48 signed_clear_lsb(fp63_48 x) {
    return (fp63_48) (x ^ (x & 1));
}

/***********************************************************************
 * Description: Round y/(2**16). The result has 56-bit scaling and
 *              63-bit precision.
 ***********************************************************************/
static inline uint64_t compute_y_rnd(uint64_t bits_0_to_47, uint64_t bits_48_to_79){
    uint64_t result = 0;

    result = (bits_0_to_47 >> 15) ^ (bits_48_to_79 << 33);
    result += 1; // rounding
    result >>= 1;
    return result;
};

static inline uint64_t compute_y84_rnd(fp84_76* y){
    uint32_t lo = y->digit[0];
    uint32_t md = y->digit[1];
    uint32_t hi = y->digit[2];
    uint64_t result;

    lo += 1 << 15;
    result = lo >> 16;
    result += (uint64_t) md << (28 - 16);
    result += (uint64_t) hi << (56 - 16);
    return result;
}

/********************************************************************
 * Name:         compute_exp_in
 * Description:  Compute y(y + 2kx)/(2 sigma**2) used as an
 *               argument in exp(-x) to determine the rejection s
 *               threshold. Binomial formula yields:
 *                   (y+kx)**2 = y**2+2kxy+(kx)**2,
 *               hence: y(y + 2kx) == (y+kx)**2 - (kx)**2.
 *               We have (y+kx)**2 == [hi,md,lo]  from sqr84 
 *               in sample_gauss_sigma76(), already. lo is rounded 
 *               out of the result. Furthermore, kx == msb <<?
 *               scalings: lo 76, md 48, hi 20, msb 4, msb**2 8
 ********************************************************************/
static inline uint64_t compute_exp_in(const digit28 hi, const digit28 md, const fp8_4 msb){
    uint64_t result;
	result  = ((uint64_t) (hi - ((msb * msb) << 12)) << 27);
    result |= ((uint64_t) (md + 1) >>  1);    // incorporate rounding
    return result;
};

/********************************************************************
 * Check, whether or not the argument is zero.
 ********************************************************************/
static inline uint64_t is_zero(const uint64_t r){
    return ((r | -r) >> 63);
}

/**********************************************************************
 * Name:        sample_gauss_sigma76
 * Description: Try to sample one sample from a Gaussian distribution
 *              
 * Byte-layout of rand (packed, in order, little-endian):
 *      0 -  1:     rand_gauss16 (16 bits)
 *      2 -  7:     rand_rej     (48 bits)
 *      8 - 13:     y.limb48[0]  (48 bits)     
 *     14 - 16:     y.limb48[1]  (24 bits)  
 *********************************************************************/
int sample_gauss_sigma76(uint64_t *r, fp84_76 *sqr84, const uint8_t rand[GAUSS_RAND_BYTES]){
    fp63_48 rand_rej;  // value in [0.0, 1.0)
    fp8_4 y_msb;    // most significant bits of y, value in [0, 64] (i.e., 0x00 to 0x40)
    fp63_48 exp_in;    // value in [0.0, 0.25]
    fp84_76 y84;
    uint16_t rand_gauss16;

#ifdef ENABLE_COUNT_CALLS_TO_SAMPLE_GAUSS_SIGMA_76
    counter_calls_to_sample_gauss_sigma76 += 1;
#endif
    rand_gauss16 = read_gauss16_asm(rand);
    y_msb = haetae_fast_sample_gauss16(rand_gauss16);
    read_y(&y84, rand);
	y84.digit[2] |= (y_msb << 16);
    *r = compute_y84_rnd(&y84);
	fp84_76_square(sqr84, &y84);
    exp_in = compute_exp_in(sqr84->digit[2], sqr84->digit[1], y_msb);
#ifdef PQC_GEN_KAT_ACTIVE
    //log_error_with_int64_t("r:    ", *r);
    //log_error_with_fp84_76("y84:    ", &y84.digit[0]);
    //log_error_with_int64_t("exp_in: ", (int64_t) exp_in);
#endif
    rand_rej     = read_rej_asm(rand);
    return (
        (
            (
                signed_clear_lsb(rand_rej) // set lowest bit to zero in order to
                                            // use it for rejection if sample==0
                - (int64_t)haetae_approx_exp_asm(exp_in)
            ) >> 63 // reject with prob 1-approx_exp(exp_in)
        )
        & (is_zero(*r) | rand_rej)) 
        &  1; // if the sample is zero, clear the return value with prob 1/2
}

int sample_gauss(uint64_t *r, fp112_76 *sqsum, const uint8_t *buf, const size_t buflen, const size_t len, const int dont_write_last)
{
    const uint8_t *pos = buf;
    fp84_76 sqr84;
    size_t bytecnt = buflen, coefcnt = 0, cnt = 0;
    int accepted;
    uint64_t extra_coefficient; // used to sample the two extra coefficients
    
    while (coefcnt < len) {
        if (bytecnt < GAUSS_RAND_BYTES) {
          return coefcnt;
        }

        if (dont_write_last && coefcnt == len-1)
        {
          accepted = sample_gauss_sigma76(&extra_coefficient, &sqr84, pos);
        } else {
          accepted = sample_gauss_sigma76(&r[coefcnt], &sqr84, pos);
        }
        cnt += 1;
        coefcnt += accepted;
        pos += GAUSS_RAND_BYTES;
        bytecnt -= GAUSS_RAND_BYTES;

        conditional_accumulate_fp112_96(sqsum, &sqr84, accepted);
        normalize_fp112_96(sqsum);
    }

    return len;
}

#define POLY_HYPERBALL_BUFLEN (GAUSS_RAND_BYTES * N)
#define POLY_HYPERBALL_NBLOCKS ((POLY_HYPERBALL_BUFLEN + STREAM256_BLOCKBYTES - 1) / STREAM256_BLOCKBYTES)
void sample_gauss_N(uint64_t *r, uint8_t *signs, fp112_76 *sqsum,
                    const uint8_t seed[CRHBYTES], const uint16_t nonce,
                    const size_t len) {
    uint8_t buf[POLY_HYPERBALL_NBLOCKS * STREAM256_BLOCKBYTES];
    size_t bytecnt, coefcnt, firstflag = 1;
    stream256_state state;

    stream256_init(&state, seed, nonce);
    stream256_squeezeblocks(buf, POLY_HYPERBALL_NBLOCKS, &state);
    for (size_t i = 0; i < len / 8; i++) {
        signs[i] = buf[i];
    }
    bytecnt = POLY_HYPERBALL_NBLOCKS * STREAM256_BLOCKBYTES - len / 8;
    coefcnt = sample_gauss(r, sqsum, buf + len / 8, bytecnt, len, len%N);
    while (coefcnt < len) {
        size_t off = bytecnt % GAUSS_RAND_BYTES;
        for (size_t i = 0; i < off; i++) {
            buf[i] = buf[bytecnt + len/8*firstflag - off + i];
        }
        stream256_squeezeblocks(buf + off, 1, &state);
        bytecnt = STREAM256_BLOCKBYTES + off;

        coefcnt += sample_gauss(r + coefcnt, sqsum, buf, bytecnt, len - coefcnt, len%N);
        firstflag = 0;
    }
}
