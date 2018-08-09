//  ringmul.c
//  2018-06-26  Markku-Juhani O. Saarinen <mjos@iki.fi>

//  Fast ring arithmetic (without cache countermeasures)

#ifndef CM_CACHE

#include <string.h>

#include "api.h"
#include "ringmul.h"
#include "xof_hash.h"

// create a sparse ternary vector from a seed

void create_spter_idx(uint16_t idx[PARAMS_H / 2][2],
                        const uint8_t *seed, const size_t seed_size)
{
    size_t i;
    uint16_t x;
    uint8_t v[PARAMS_ND];
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
        } while (v[x]);
        idx[i >> 1][i & 1] = x;             // addition / subtract index
        v[x] = 1;
    }
}

// multiplication mod q, result length n

void ringmul_q(modq_t d[PARAMS_ND + PARAMS_MUL_PAD],
    const modq_t a[PARAMS_ND], const uint16_t idx[PARAMS_H / 2][2])
{
    size_t i, j;
    modq_t t;
    modq_t *qt, *rt;
    modq_t p[2 * (PARAMS_ND + 1) + PARAMS_MUL_PAD];

    p[0] = -a[0];
    for (i = 1; i < PARAMS_ND; i++) {       // "lift" -- multiply by (x - 1)
        p[i] = a[i - 1] - a[i];
    }
    p[PARAMS_ND] = a[PARAMS_ND - 1];

    memcpy(p  + (PARAMS_ND + 1), p,         // duplicate
        (PARAMS_ND + 1) * sizeof(modq_t));

    memset(d, 0, PARAMS_ND * sizeof(modq_t));

    for (i = 0; i < PARAMS_H / 2; i++) {
        qt = &p[idx[i][0]];
        rt = &p[idx[i][1]];

        for (j = 0; j < PARAMS_ND;) {       // unrolled!
            d[j] += qt[j] - rt[j];
            j++;
#if (PARAMS_MUL_PAD >= 2)
            d[j] += qt[j] - rt[j];
            j++;
#endif
#if (PARAMS_MUL_PAD >= 3)
            d[j] += qt[j] - rt[j];
            j++;
#endif
#if (PARAMS_MUL_PAD >= 4)
            d[j] += qt[j] - rt[j];
            j++;
#endif
#if (PARAMS_MUL_PAD >= 5)
            d[j] += qt[j] - rt[j];
            j++;
#endif
#if (PARAMS_MUL_PAD >= 6)
            d[j] += qt[j] - rt[j];
            j++;
#endif
#if (PARAMS_MUL_PAD >= 7)
            d[j] += qt[j] - rt[j];
            j++;
#endif
#if (PARAMS_MUL_PAD >= 8)
            d[j] += qt[j] - rt[j];
            j++;
#endif
        }
    }
    t = 0;
    for (i = 0; i < PARAMS_ND; i++) {   // "unlift"
        t -= d[i];
        d[i] = t;
    }
}

// multiplication mod p, result length mu

void ringmul_p(modp_t d[PARAMS_MU + PARAMS_MUL_PAD],
    const modp_t a[PARAMS_ND], const uint16_t idx[PARAMS_H / 2][2])
{
    int i, j;
    modp_t t;
    modp_t *pt, *qt, *rt;
    modp_t p[PARAMS_MU + 1 + (PARAMS_ND + 1) + PARAMS_MUL_PAD];

    pt = &p[PARAMS_MU];
    pt[PARAMS_ND + 1] = -a[0];
    for (i = 1; i < PARAMS_ND; i++) {       // "lift" -- multiply by (x - 1)
        pt[i] = a[i - 1] - a[i];
    }
    pt[PARAMS_ND] = a[PARAMS_ND - 1];
    memcpy(p, p + (PARAMS_ND + 1),          // duplicate at beginning
        (PARAMS_MU + 1) * sizeof(modp_t));

    memset(d, 0, PARAMS_MU * sizeof(modp_t));

    for (i = 0; i < PARAMS_H / 2; i++) {
        qt = &p[idx[i][0]];
        rt = &p[idx[i][1]];

        for (j = 0; j < PARAMS_MU;) {       // unrolled!
            d[j] += qt[j] - rt[j];
            j++;
#if (PARAMS_MUL_PAD >= 2)
            d[j] += qt[j] - rt[j];
            j++;
#endif
#if (PARAMS_MUL_PAD >= 3)
            d[j] += qt[j] - rt[j];
            j++;
#endif
#if (PARAMS_MUL_PAD >= 4)
            d[j] += qt[j] - rt[j];
            j++;
#endif
#if (PARAMS_MUL_PAD >= 5)
            d[j] += qt[j] - rt[j];
            j++;
#endif
#if (PARAMS_MUL_PAD >= 6)
            d[j] += qt[j] - rt[j];
            j++;
#endif
#if (PARAMS_MUL_PAD >= 7)
            d[j] += qt[j] - rt[j];
            j++;
#endif
#if (PARAMS_MUL_PAD >= 8)
            d[j] += qt[j] - rt[j];
            j++;
#endif
        }
    }

    t = 0;
    for (i = PARAMS_MU - 1; i >= 0; i--) {  // "unlift"
        t += d[i];
        d[i] = t;
    }
}

#endif /* CM_CACHE */

