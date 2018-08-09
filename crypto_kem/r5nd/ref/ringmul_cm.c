//  ringmul_cm.c
//  2018-06-26  Markku-Juhani O. Saarinen <mjos@iki.fi>

//  This version includes cache timing attack countermeasures.

#ifdef CM_CACHE

#include <string.h>

#include "api.h"
#include "ringmul.h"
#include "xof_hash.h"

#define PROBEVEC64  ((PARAMS_ND + 63) / 64)

// Cache-resistant "occupancy probe". Tests and "occupies" a single bit at x.
// Return value zero (false) indicates the the slot was originally empty.

static int probe_cm(uint64_t *v, int x)
{
    int i;
    uint64_t a, b, c, y, z;

    // construct the selector
    y = (1llu) << (x & 0x3F);               // low bits of index

#if 0
    z = (1llu) << (x >> 6);                 // high bits of index
#else
    z = 1llu;                               // no constant-time 64-bit shift
    a = -((x >> 6) & 1);
    z = ((z << 1) & a) ^ (z & ~a);
    a = -((x >> 7) & 1);
    z = ((z << 2) & a) ^ (z & ~a);
    a = -((x >> 8) & 1);
    z = ((z << 4) & a) ^ (z & ~a);
    a = -((x >> 9) & 1);
    z = ((z << 8) & a) ^ (z & ~a);
    a = -((x >> 10) & 1);                   // can handle up to n=d=2048
    z = ((z << 16) & a) ^ (z & ~a);
#endif

    c = 0;
    for (i = 0; i < PROBEVEC64; i++) {      // always scan through all
        a = v[i];
        b = a | (y & (-(z & 1)));           // set bit
        c |= a ^ b;                         // mask for change
        v[i] = b;
        z >>= 1;
    }

    // final comparison doesn't need to be constant time
    return c == 0;                          // return true if was occupied
}

// create a sparse ternary vector from a seed

void create_spter_idx(uint16_t idx[PARAMS_H / 2][2],
                        const uint8_t *seed, const size_t seed_size)
{
    size_t i;
    uint16_t x;
    uint64_t v[PROBEVEC64];
    XOF_ctx xof;

    memset(v, 0, sizeof(v));
    XOF_absorb(&xof, seed, seed_size);      // initialize with seed

    for (i = 0; i < PARAMS_H; i++) {
        do {
            do {
                XOF_squeeze(&xof, &x, 2);
#if __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__
                x = ((x << 8) ^ (x >> 8)) & 0xFFFF;
#endif
            } while (x >= PARAMS_RS_LIM);
            x /= PARAMS_RS_DIV;
        } while (probe_cm(v, x));
        idx[i >> 1][i & 1] = x;             // addition / subtract index
    }
}

// multiplication mod q, result length n

void ringmul_q(modq_t d[PARAMS_ND + PARAMS_MUL_PAD],
    const modq_t a[PARAMS_ND], const uint16_t idx[PARAMS_H / 2][2])
{
    size_t i, j, k;
    modq_t t, p[PARAMS_ND + 1 + PARAMS_MUL_PAD];

    p[0] = -a[0];
    for (i = 1; i < PARAMS_ND; i++) {       // "lift" -- multiply by (x - 1)
        p[i] = a[i - 1] - a[i];
    }
    p[PARAMS_ND] = a[PARAMS_ND - 1];

    memset(d, 0, PARAMS_ND * sizeof(modq_t));

    for (i = 0; i < PARAMS_H / 2; i++) {

        k = idx[i][0];                      // modified to always scan
        for (j = 0; k <= PARAMS_ND;)        // the same ranges
            d[j++] += p[k++];
        for (k = 0; j < PARAMS_ND;)
            d[j++] += p[k++];

        k = idx[i][1];                      // negative coefficient
        for (j = 0; k <= PARAMS_ND;)
            d[j++] -= p[k++];
        for (k = 0; j < PARAMS_ND;)
            d[j++] -= p[k++];
    }
    t = 0;
    for (i = 0; i < PARAMS_ND; i++) {       // "unlift"
        t -= d[i];
        d[i] = t;
    }
}

// multiplication mod p, result length mu

void ringmul_p(modp_t d[PARAMS_MU + PARAMS_MUL_PAD],
    const modp_t a[PARAMS_ND], const uint16_t idx[PARAMS_H / 2][2])
{
    size_t i, j, k;
    modp_t t, p[PARAMS_ND + 1 + PARAMS_MUL_PAD],
        e[PARAMS_ND + PARAMS_MUL_PAD];

    p[0] = -a[0];
    for (i = 1; i < PARAMS_ND; i++) {       // "lift" -- multiply by (x - 1)
        p[i] = a[i - 1] - a[i];
    }
    p[PARAMS_ND] = a[PARAMS_ND - 1];

    memset(e, 0, PARAMS_ND * sizeof(modp_t));

    for (i = 0; i < PARAMS_H / 2; i++) {

        k = idx[i][0];                      // modified to always scan
        for (j = 0; k <= PARAMS_ND;)        // the same ranges
            e[j++] += p[k++];
        for (k = 0; j < PARAMS_ND;)
            e[j++] += p[k++];

        k = idx[i][1];                      // negative coefficient
        for (j = 0; k <= PARAMS_ND;)
            e[j++] -= p[k++];
        for (k = 0; j < PARAMS_ND;)
            e[j++] -= p[k++];
    }

    t = 0;
    for (i = 0; i < PARAMS_ND; i++) {       // "unlift"
        t -= e[i];
        e[i] = t;
    }

    // copy the last part to caller
    memcpy(d, &e[PARAMS_ND - PARAMS_MU], PARAMS_MU * sizeof(modp_t));
}

#endif /* CM_CACHE */

