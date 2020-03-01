//  r5_cpa_pke_n1.c
//  Copyright (c) 2019, PQShield Ltd. and Koninklijke Philips N.V.

#include "r5_parameter_sets.h"

#if (PARAMS_N == 1)

#include <string.h>

#include "r5_cpa_pke.h"
#include "r5_matmul.h"
#include "r5_xof.h"
#include "randombytes.h"
#include "xef.h"
#include "little_endian.h"

// create a sparse ternary vector from a seed

static void r5_create_secret_matrix(uint16_t rs_t[][PARAMS_H / 2][2],
    const uint8_t seed[PARAMS_KAPPA_BYTES])
{
    size_t i, l;
    uint16_t x;
    uint8_t v[PARAMS_D];

    r5_xof_ctx_t ctx;

    r5_xof_input(&ctx, seed, PARAMS_KAPPA_BYTES);

    // assume PARAMS_N == PARAMS_M
    for (l = 0; l < PARAMS_N_BAR; l++) {

        memset(v, 0, sizeof(v));        // reset table
        for (i = 0; i < PARAMS_H; i++) {
            do {
                do {
                    r5_xof_squeeze(&ctx, &x, sizeof (x));
                    x = LITTLE_ENDIAN16(x);
                } while (x >= PARAMS_RS_LIM);
                x /= PARAMS_RS_DIV;
            } while (v[x]);
            v[x] = 1;
            rs_t[l][i >> 1][i & 1] = x; // addition / subtract index
        }
    }
}

//  create "matrix row" a_random

static void r5_matrow_a_random(modq_t *a_random,
    const uint8_t seed[PARAMS_KAPPA_BYTES])
{
    r5_xof(a_random, PARAM_TAU2_A_RANDOM * sizeof(modq_t),
        seed, PARAMS_KAPPA_BYTES);

#if __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__
    size_t i;

    for (i = 0; i < PARAM_TAU2_A_RANDOM; i++) {
        a_random[i] = LITTLE_ENDIAN16(a_random[i]);
    }
#endif
}

//  Get q indexes

static int r5_create_a_perm(uint16_t a_perm[PARAMS_D],
    const uint8_t sigma[PARAMS_KAPPA_BYTES])
{
    size_t i;
    uint16_t rnd;
    uint8_t v[BITS_TO_BYTES(PARAM_TAU2_A_RANDOM)];      // low ram; use bits
    r5_xof_ctx_t ctx;

    //  The DRBG customization when creating the tau=1 or tau=2 permutations.
    static const uint8_t permutation_customization[2] = {0, 1};

    memset(v, 0, sizeof(v));

    r5_xof_s_input(&ctx, sigma, PARAMS_KAPPA_BYTES,
        permutation_customization, sizeof(permutation_customization));

    for (i = 0; i < PARAMS_D; ++i) {
        do {
            r5_xof_squeeze(&ctx, &rnd, sizeof(rnd));
            rnd = (uint16_t) LITTLE_ENDIAN16(rnd);
            rnd &= (PARAM_TAU2_A_RANDOM - 1);
        } while ((v[rnd >> 3] >> (rnd & 7)) & 1);
        v[rnd >> 3] |= 1 << (rnd & 7);      // set bit
        a_perm[i] = rnd;
    }

    return 0;
}

// compress elements of q bits into p bits and pack into a byte string

static void r5_pack_q_p_round(uint8_t *pv, const modq_t *vq, size_t len,
    const modq_t rounding_constant)
{
#if (PARAMS_P_BITS == 8)
    size_t i;

    for (i = 0; i < len; i++) {
        pv[i] = ((vq[i] + rounding_constant) >>
            (PARAMS_Q_BITS - PARAMS_P_BITS)) & (PARAMS_P - 1);
    }
#else
    size_t i, j;
    modp_t t;

    memset(pv, 0, (size_t) BITS_TO_BYTES(PARAMS_P_BITS * len));
    j = 0;
    for (i = 0; i < len; i++) {
        t = ((vq[i] + rounding_constant) >>
            (PARAMS_Q_BITS - PARAMS_P_BITS)) & (PARAMS_P - 1);
        //pack p bits
        pv[j >> 3] |= (uint8_t) (t << (j & 7));
        if ((j & 7) + PARAMS_P_BITS > 8) {
            pv[(j >> 3) + 1] |= (uint8_t) (t >> (8 - (j & 7)));
            if ((j & 7) + PARAMS_P_BITS > 16) {
                pv[(j >> 3) + 2] |= (uint8_t) (t >> (16 - (j & 7)));
            }
        }
        j += PARAMS_P_BITS;
    }
#endif
}

// unpack a byte string into D*M_BAR elements of p bits

static void r5_unpack_p(modp_t *vp, size_t len, const uint8_t *pv)
{
#if (PARAMS_P_BITS == 8)
    memcpy(vp, pv, len);
#else
    size_t i, bits_done, idx, bit_idx;
    modp_t val;

    bits_done = 0;
    for (i = 0; i < len; i++) {
        idx = bits_done >> 3;
        bit_idx = bits_done & 7;
        val = (uint16_t) (pv[idx] >> bit_idx);
        if (bit_idx + PARAMS_P_BITS > 8) {
            /* Get spill over from next packed byte */
            val = (uint16_t) (val | (pv[idx + 1] << (8 - bit_idx)));
            if (bit_idx + PARAMS_P_BITS > 16) {
                /* Get spill over from next packed byte */
                val = (uint16_t) (val | (pv[idx + 2] << (16 - bit_idx)));
            }
        }
        vp[i] = val & (PARAMS_P - 1);
        bits_done += PARAMS_P_BITS;
    }
#endif
}

// generate a keypair (sigma, B)

int r5_cpa_pke_keygen(uint8_t *pk, uint8_t *sk)
{
    modq_t b[PARAMS_D][PARAMS_N_BAR];
    uint16_t s_t[PARAMS_N_BAR][PARAMS_H / 2][2];

    modq_t a_random[PARAM_TAU2_A_RANDOM + PARAMS_D];
    uint16_t a_perm[PARAMS_D];

    // sigma = seed of (permutation of) A
    randombytes(pk, PARAMS_KAPPA_BYTES);

    // A from sigma
    r5_matrow_a_random(a_random, pk);
    memcpy(a_random + PARAM_TAU2_A_RANDOM, a_random, PARAMS_D * sizeof(modq_t));

    // Permutation of a_random
    r5_create_a_perm(a_perm, pk);

    randombytes(sk, PARAMS_KAPPA_BYTES); // secret key -- Random S
    r5_create_secret_matrix(s_t, sk);

    r5_matmul_as_q(b, a_random, a_perm, s_t); // B = A * S

    // Compress B q_bits -> p_bits, pk = sigma | B
    r5_pack_q_p_round(pk + PARAMS_KAPPA_BYTES, &b[0][0],
        PARAMS_D * PARAMS_N_BAR, PARAMS_H1);

    return 0;
}

//  foundation encryption function

int r5_cpa_pke_encrypt(uint8_t *ct, const uint8_t *pk, const uint8_t *m,
    const uint8_t *rho)
{
    size_t i, j;
    uint16_t r_t[PARAMS_M_BAR][PARAMS_H / 2][2];
    uint16_t a_perm[PARAMS_D];
    modq_t a_random[PARAM_TAU2_A_RANDOM + PARAMS_D];
    union {
        modq_t u_t[PARAMS_M_BAR][PARAMS_D];
        modp_t b[PARAMS_D][PARAMS_N_BAR];
    } mat;
    modp_t x[PARAMS_MU];
    uint8_t m1[BITS_TO_BYTES(PARAMS_MU * PARAMS_B_BITS)];
    modp_t t, tm;

    //  Create R
    r5_create_secret_matrix(r_t, rho);

    //  unpack public key
    r5_unpack_p(&mat.b[0][0], PARAMS_D * PARAMS_N_BAR, pk + PARAMS_KAPPA_BYTES);

    r5_matmul_rb_p(x, mat.b, r_t); // X = R^T x B    (mod p)

    //  A from sigma
    r5_matrow_a_random(a_random, pk);
    memcpy(a_random + PARAM_TAU2_A_RANDOM, a_random,
        PARAMS_D * sizeof(modq_t));

    //  Permutation of a_random
    r5_create_a_perm(a_perm, pk);

    r5_matmul_ra_q(mat.u_t, a_random, a_perm, r_t); // U^T = (R^T x A)^T (mod q)

    r5_pack_q_p_round(ct, &mat.u_t[0][0],
        PARAMS_M_BAR * PARAMS_D, PARAMS_H2);    // ct = U^T | v

    memset(ct + PARAMS_DPU_SIZE, 0, PARAMS_MUT_SIZE);

    //  create the message
    memcpy(m1, m, PARAMS_KAPPA_BYTES);
    memset(m1 + PARAMS_KAPPA_BYTES, 0,
        BITS_TO_BYTES(PARAMS_MU * PARAMS_B_BITS) - PARAMS_KAPPA_BYTES);
#if (PARAMS_XE != 0)
    xef_compute(m1, PARAMS_KAPPA_BYTES, PARAMS_F);
#endif

    j = 8 * PARAMS_DPU_SIZE;
    for (i = 0; i < PARAMS_MU; i++) { // compute, pack v

        // compress p->t
        t = ((x[i] + PARAMS_H2) >> (PARAMS_P_BITS - PARAMS_T_BITS));

        // add message
        tm = (m1[(i * PARAMS_B_BITS) >> 3] >> ((i * PARAMS_B_BITS) & 7));
#if (8 % PARAMS_B_BITS != 0)
        if (((i * PARAMS_B_BITS) & 7) + PARAMS_B_BITS > 8) {
            /* Get spill over from next message byte */
            tm = (tm | (m1[((i * PARAMS_B_BITS) >> 3) + 1] <<
                (8 - ((i * PARAMS_B_BITS) & 7))));
        }
#endif
        t = (t + ((tm & ((1 << PARAMS_B_BITS) - 1)) <<
            (PARAMS_T_BITS - PARAMS_B_BITS))) & ((1 << PARAMS_T_BITS) - 1);

        ct[j >> 3] |= (uint8_t) (t << (j & 7)); // pack t bits
        if ((j & 7) + PARAMS_T_BITS > 8) {
            ct[(j >> 3) + 1] |= (uint8_t) (t >> (8 - (j & 7)));
            if ((j & 7) + PARAMS_T_BITS > 16) {
                ct[(j >> 3) + 2] |= (uint8_t) (t >> (16 - (j & 7)));
            }
        }
        j += PARAMS_T_BITS;
    }

    return 0;
}

int r5_cpa_pke_decrypt(uint8_t *m, const uint8_t *sk, const uint8_t *ct)
{
    size_t i, j;
    uint16_t s_t[PARAMS_N_BAR][PARAMS_H / 2][2];

    modp_t u_t[PARAMS_M_BAR][PARAMS_D];
    modp_t xp[PARAMS_MU];
    uint8_t m1[BITS_TO_BYTES(PARAMS_MU * PARAMS_B_BITS)];
    modp_t t;

    r5_create_secret_matrix(s_t, sk);

    r5_unpack_p((modp_t *) u_t, PARAMS_M_BAR *   PARAMS_D, ct);  // ct = U^T | v

    //  X' = S^T * U (mod p)
    r5_matmul_us_p(xp, u_t, s_t);

    memset(m1, 0, sizeof(m1));

    j = 8 * PARAMS_DPU_SIZE;
    for (i = 0; i < PARAMS_MU; i++) {
        t = (modp_t) (ct[j >> 3] >> (j & 7));               // unpack t bits
        if ((j & 7) + PARAMS_T_BITS > 8) {
            t |= (modp_t) (ct[(j >> 3) + 1] << (8 - (j & 7)));
            if ((j & 7) + PARAMS_T_BITS > 16) {
                t |= (modp_t) ((ct[(j >> 3) + 2]) << (16 - (j & 7)));
            }
        }
        t &= ((1 << PARAMS_T_BITS) - 1);                    // "v"
        j += PARAMS_T_BITS;

        //  X' = v - X', compressed to 1 bit
        t = (t << (PARAMS_P_BITS - PARAMS_T_BITS)) - xp[i];
        t = ((t + PARAMS_H3) >> (PARAMS_P_BITS - PARAMS_B_BITS))
            & ((1 << PARAMS_B_BITS) - 1);
        m1[(i * PARAMS_B_BITS) >> 3] |= t << ((i * PARAMS_B_BITS) & 7);
#if (8 % PARAMS_B_BITS != 0)
        if (((i * PARAMS_B_BITS) & 7) + PARAMS_B_BITS > 8) {
            /* Spill over to next message byte */
            m1[(i * PARAMS_B_BITS >> 3) + 1] |=
                    (t >> (8 - ((i * PARAMS_B_BITS) & 7)));
        }
#endif
    }

#if (PARAMS_XE != 0)
    //  Apply error correction
    xef_compute(m1, PARAMS_KAPPA_BYTES, PARAMS_F);
    xef_fixerr(m1, PARAMS_KAPPA_BYTES, PARAMS_F);
#endif
    memcpy(m, m1, PARAMS_KAPPA_BYTES);

    return 0;
}

#endif

