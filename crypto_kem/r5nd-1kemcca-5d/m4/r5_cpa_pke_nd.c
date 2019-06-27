//  r5_cpa_pke_nd.c
//  Copyright (c) 2019, PQShield Ltd. and Koninklijke Philips N.V.

#include "r5_parameter_sets.h"

#if (PARAMS_N == PARAMS_D)

#include <string.h>

#include "little_endian.h"
#include "r5_cpa_pke.h"
#include "r5_ringmul.h"
#include "r5_xof.h"
#include "randombytes.h"
#include "xef.h"

// create a sparse ternary vector from a seed

static void r5_create_secret_vec(uint16_t idx[PARAMS_H / 2][2],
    const uint8_t seed[PARAMS_KAPPA_BYTES])
{
    size_t i;
    uint16_t x;
    uint8_t v[PARAMS_D];
    r5_xof_ctx_t ctx;

    memset(v, 0, sizeof (v));

    r5_xof_input(&ctx, seed, PARAMS_KAPPA_BYTES);

    for (i = 0; i < PARAMS_H; i++) {
        do {
            do {
                r5_xof_squeeze(&ctx, &x, sizeof(x));
                x = LITTLE_ENDIAN16(x);
            } while (x >= PARAMS_RS_LIM);
            x /= PARAMS_RS_DIV;
        } while (v[x]);
        v[x] = 1;
        idx[i >> 1][i & 1] = x;
    }
}

//  master random

static void r5_ring_a_random(modq_t *a_random,
    const uint8_t seed[PARAMS_KAPPA_BYTES])
{
    r5_xof(a_random, PARAMS_D * sizeof (modq_t), seed, PARAMS_KAPPA_BYTES);
#if __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__
    size_t i;

    for (i = 0; i < PARAMS_D; i++) {
        a_random[i] = LITTLE_ENDIAN16(a_random[i]);
    }
#endif
}

// compress ND elements of q bits into p bits and pack into a byte string

static void r5_pack_q_p(uint8_t *pv, const modq_t *vq,
    const modq_t rounding_constant)
{
#if (PARAMS_P_BITS == 8)
    size_t i;

    for (i = 0; i < PARAMS_D; i++) {
        pv[i] = (uint8_t) (((vq[i] + rounding_constant) >>
            (PARAMS_Q_BITS - PARAMS_P_BITS)) & (PARAMS_P - 1));
    }
#else
    size_t i, j;
    modp_t t;

    memset(pv, 0, PARAMS_NDP_SIZE);
    j = 0;
    for (i = 0; i < PARAMS_D; i++) {
        t = ((vq[i] + rounding_constant) >>
                (PARAMS_Q_BITS - PARAMS_P_BITS)) & (PARAMS_P - 1);
        pv[j >> 3] = (uint8_t) (pv[j >> 3] | (t << (j & 7))); // pack p bits
        if ((j & 7) + PARAMS_P_BITS > 8) {
            pv[(j >> 3) + 1] =
                (uint8_t) (pv[(j >> 3) + 1] | (t >> (8 - (j & 7))));
        }
        j += PARAMS_P_BITS;
    }
#endif
}

// unpack a byte string into ND elements of p bits

static void r5_unpack_p(modp_t *vp, const uint8_t *pv)
{
#if (PARAMS_P_BITS == 8)
    memcpy(vp, pv, PARAMS_D);
#else
    size_t i, j;
    modp_t t;

    j = 0;
    for (i = 0; i < PARAMS_D; i++) {
        t = (modp_t) (pv[j >> 3] >> (j & 7)); // unpack p bits
        if ((j & 7) + PARAMS_P_BITS > 8) {
            t = (modp_t) (t | ((modp_t) pv[(j >> 3) + 1]) << (8 - (j & 7)));
        }
        vp[i] = t & (PARAMS_P - 1);
        j += PARAMS_P_BITS;
    }
#endif
}

// generate a keypair (sigma, B)

int r5_cpa_pke_keygen(uint8_t *pk, uint8_t *sk)
{
    modq_t a[2 * (PARAMS_D + 1)];
    modq_t b[PARAMS_D];
    uint16_t s_idx[PARAMS_H / 2][2];

    randombytes(pk, PARAMS_KAPPA_BYTES); // sigma = seed of A

    // A from sigma
    r5_ring_a_random(a, pk);

    randombytes(sk, PARAMS_KAPPA_BYTES); // secret key -- Random S
    r5_create_secret_vec(s_idx, sk);

    r5_ringmul_q(b, a, s_idx); // B = A * S

    // Compress B q_bits -> p_bits, pk = sigma | B
    r5_pack_q_p(pk + PARAMS_KAPPA_BYTES, b, PARAMS_H1);

    return 0;
}

int r5_cpa_pke_encrypt(uint8_t *ct, const uint8_t *pk,
    const uint8_t *m, const uint8_t *rho)
{
    size_t i, j;
    modq_t a[2 * (PARAMS_D + 1)];
    uint16_t r_idx[PARAMS_H / 2][2];
    union {
        modq_t u_t[PARAMS_D];
        modp_t b[PARAMS_D + PARAMS_MU + 2];
    } vec;
    modp_t x[PARAMS_MU];
    uint8_t m1[BITS_TO_BYTES(PARAMS_MU * PARAMS_B_BITS)];
    modp_t t, tm;

    // A from sigma
    r5_ring_a_random(a, pk);

    memcpy(m1, m, PARAMS_KAPPA_BYTES); // add error correction code
    memset(m1 + PARAMS_KAPPA_BYTES, 0,
        BITS_TO_BYTES(PARAMS_MU * PARAMS_B_BITS) - PARAMS_KAPPA_BYTES);
#if (PARAMS_XE != 0)
    xef_compute(m1, PARAMS_KAPPA_BYTES, PARAMS_F);
#endif

    // Create R
    r5_create_secret_vec(r_idx, rho);

    r5_ringmul_q(vec.u_t, a, r_idx);        // U^T = U = A^T * R = A * R (mod q)
    r5_pack_q_p(ct, vec.u_t, PARAMS_H2);    // ct = U^T | v

    // unpack public key
    r5_unpack_p(vec.b, pk + PARAMS_KAPPA_BYTES);
    r5_ringmul_p(x, vec.b, r_idx);      // X = B * R  (mod p)

    memset(ct + PARAMS_NDP_SIZE, 0, PARAMS_MUT_SIZE);

    j = 8 * PARAMS_NDP_SIZE;
    for (i = 0; i < PARAMS_MU; i++) { // compute, pack v
        // compress p->t
        t = ((x[i] + PARAMS_H2) >> (PARAMS_P_BITS - PARAMS_T_BITS));
        // add message
        tm = (m1[(i * PARAMS_B_BITS) >> 3] >>
                ((i * PARAMS_B_BITS) & 7));
#if (8 % PARAMS_B_BITS != 0)
        if (((i * PARAMS_B_BITS) & 7) + PARAMS_B_BITS > 8) {
            /* Get spill over from next message byte */
            tm = (tm | (m1[((i * PARAMS_B_BITS) >> 3) + 1]
                    << (8 - ((i * PARAMS_B_BITS) & 7))));
        }
#endif
        t = (t + ((tm & ((1 << PARAMS_B_BITS) - 1))
            << (PARAMS_T_BITS - PARAMS_B_BITS))) & ((1 << PARAMS_T_BITS) - 1);

        ct[j >> 3] = (ct[j >> 3] | (t << (j & 7))); // pack t bits
        if ((j & 7) + PARAMS_T_BITS > 8) {
            ct[(j >> 3) + 1] = (ct[(j >> 3) + 1] | (t >> (8 - (j & 7))));
        }
        j += PARAMS_T_BITS;
    }

    return 0;
}

int r5_cpa_pke_decrypt(uint8_t *m, const uint8_t *sk, const uint8_t *ct)
{
    size_t i, j;
    uint16_t s_idx[PARAMS_H / 2][2];
    modp_t u_t[PARAMS_D + PARAMS_MU + 2];
    modp_t v[PARAMS_MU];
    modp_t t, x_prime[PARAMS_MU];
    uint8_t m1[BITS_TO_BYTES(PARAMS_MU * PARAMS_B_BITS)];

    r5_create_secret_vec(s_idx, sk);

    r5_unpack_p(u_t, ct); // ct = U^T | v

    j = 8 * PARAMS_NDP_SIZE;
    for (i = 0; i < PARAMS_MU; i++) {
        t = (modp_t) (ct[j >> 3] >> (j & 7)); // unpack t bits
        if ((j & 7) + PARAMS_T_BITS > 8) {
            t = (modp_t) (t | ct[(j >> 3) + 1] << (8 - (j & 7)));
        }
        v[i] = t & ((1 << PARAMS_T_BITS) - 1);
        j += PARAMS_T_BITS;
    }

    // X' = U * S (mod p)
    r5_ringmul_p(x_prime, u_t, s_idx);

    // X' = v - X', compressed to 1 bit
    modp_t x_p;
    memset(m1, 0, sizeof(m1));
    for (i = 0; i < PARAMS_MU; i++) {
        // v - X' as mod p value (to be able to perform the rounding!)
        x_p = ((v[i] << (PARAMS_P_BITS - PARAMS_T_BITS)) - x_prime[i]);
        x_p = (((x_p + PARAMS_H3) >> (PARAMS_P_BITS - PARAMS_B_BITS)) &
                ((1 << PARAMS_B_BITS) - 1));
        m1[(i * PARAMS_B_BITS) >> 3] = (m1[i * PARAMS_B_BITS >> 3] |
                                        (x_p << ((i * PARAMS_B_BITS) & 7)));
#if (8 % PARAMS_B_BITS != 0)
        if (((i * PARAMS_B_BITS) & 7) + PARAMS_B_BITS > 8) {
            /* Spill over to next message byte */
            m1[(i * PARAMS_B_BITS >> 3) + 1] =
                m1[((i * PARAMS_B_BITS) >> 3) + 1] |
                    (x_p >> (8 - ((i * PARAMS_B_BITS) & 7)));
        }
#endif
    }

#if (PARAMS_XE != 0)
    // Apply error correction
    xef_compute(m1, PARAMS_KAPPA_BYTES, PARAMS_F);
    xef_fixerr(m1, PARAMS_KAPPA_BYTES, PARAMS_F);
#endif
    memcpy(m, m1, PARAMS_KAPPA_BYTES);

    return 0;
}

#endif

