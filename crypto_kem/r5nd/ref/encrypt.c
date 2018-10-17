// encrypt.c
// 2018-06-17  Markku-Juhani O. Saarinen <mjos@iki.fi>

#include <string.h>

#include "api.h"
#include "encrypt.h"
#include "xof_hash.h"
#include "randombytes.h"
#include "xecc.h"
#include "ringmul.h"

// flip a vector of 16-byte values (in case big endian)

#if __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__
static void flip16vec(uint16_t *v, size_t len)
{
    uint16_t x;
    size_t i;

    for (i = 0; i < len; i++) {
        x = v[i];
        x = ((x << 8) ^ (x >> 8)) & 0xFFFF;
        v[i] = x;
    }
}
#endif

// compress q->p and pack nd values of p bits

static void compress_q_pack_ndp(uint8_t *pv, const modq_t *vq)
{
#if (PARAMS_P_BITS == 8)
    size_t i;

    for (i = 0; i < PARAMS_ND; i++) {
        pv[i] = ((vq[i] + (1 << (PARAMS_Q_BITS - PARAMS_P_BITS - 1))) >>
                (PARAMS_Q_BITS - PARAMS_P_BITS)) & ((1 << PARAMS_P_BITS) - 1);
    }
#else
    size_t i, j;
    modp_t t;

    memset(pv, 0, PARAMS_NDP_SIZE);
    j = 0;
    for (i = 0; i < PARAMS_ND; i++) {
        t = ((vq[i] + (1 << (PARAMS_Q_BITS - PARAMS_P_BITS - 1))) >>
            (PARAMS_Q_BITS - PARAMS_P_BITS)) & ((1 << PARAMS_P_BITS) - 1);
        pv[j >> 3] |= t << (j & 7);         // pack p bits
        if ((j & 7) + PARAMS_P_BITS > 8) {
            pv[(j >> 3) + 1] |= t >> (8 - (j & 7));
        }
        j += PARAMS_P_BITS;
    }
#endif
}

// unpack a vector

static void unpack_ndp(modp_t *vp, const uint8_t *pv)
{
#if (PARAMS_P_BITS == 8)
    memcpy(vp, pv, PARAMS_ND);
#else
    size_t i, j;
    modp_t t;

    j = 0;
    for (i = 0; i < PARAMS_ND; i++) {
        t = pv[j >> 3] >> (j & 7);          // unpack p bits
        if ((j & 7) + PARAMS_P_BITS > 8) {
            t |= ((modp_t) pv[(j >> 3) + 1]) << (8 - (j & 7));
        }
        vp[i] = t;
        j += PARAMS_P_BITS;
    }
#endif
}

// generate a keypair (sigma, B)

int generate_keypair(uint8_t *pk, uint8_t *sk)
{
    modq_t A[PARAMS_ND];
    modq_t B[PARAMS_ND + PARAMS_MUL_PAD];

    uint16_t S_idx[PARAMS_H / 2][2];

    randombytes(pk, PARAMS_SS_SIZE);        // sigma = seed of A
    XOF_hash(A, pk, PARAMS_SS_SIZE, PARAMS_ND * sizeof(modq_t));
#if __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__
    flip16vec(A, PARAMS_ND);
#endif
    randombytes(sk, PARAMS_SK_SIZE);        // secret key -- Random S
    create_spter_idx(S_idx, sk, PARAMS_SK_SIZE);

    ringmul_q(B, A, S_idx);                 // B = A * S

    // Compress B q_bits -> p_bits, pk = sigma | B
    compress_q_pack_ndp(pk + PARAMS_SS_SIZE, B);

    return 0;
}

int encrypt_rho(uint8_t *ct, const uint8_t *m,
   const uint8_t *rho, const uint8_t *pk)
{
    size_t i, j;
    modq_t A[PARAMS_ND];
    uint16_t R_idx[PARAMS_H / 2][2];
    modq_t U[PARAMS_ND + PARAMS_MUL_PAD];
    modp_t B[PARAMS_ND];
    modp_t X[PARAMS_MU + PARAMS_MUL_PAD];
    uint8_t mm[PARAMS_SS_SIZE + PARAMS_XE_SIZE];
    uint8_t t;

    // unpack public key
    unpack_ndp(B, pk + PARAMS_SS_SIZE);

    // A from sigma
    XOF_hash(A, pk, PARAMS_SS_SIZE, PARAMS_ND * sizeof(*A));
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
    flip16vec(A, PARAMS_ND);
#endif

    memcpy(mm, m, PARAMS_SS_SIZE);          // add error correction code
    memset(mm + PARAMS_SS_SIZE, 0, PARAMS_XE_SIZE);
    xe_compute(mm);

    // Create R
    create_spter_idx(R_idx, rho, PARAMS_SS_SIZE);

    ringmul_q(U, A, R_idx);                 // U = A * R  (mod q)
    ringmul_p(X, B, R_idx);                 // X = B * R  (mod p)

    compress_q_pack_ndp(ct, U);             // ct = U | v

    memset(ct + PARAMS_NDP_SIZE, 0, PARAMS_MUT_SIZE);
    j = 8 * PARAMS_NDP_SIZE;

    for (i = 0; i < PARAMS_MU; i++) {       // compute, pack v
        // compress p->t
        t = ((X[i] + (1 << (PARAMS_P_BITS - PARAMS_T_BITS - 1))) >>
               (PARAMS_P_BITS - PARAMS_T_BITS));
        // add message
        t = (t + (((mm[i >> 3] >> (i & 7)) & 1) <<
               (PARAMS_T_BITS - 1))) & ((1 << PARAMS_T_BITS) - 1);

        ct[j >> 3] |= t << (j & 7);         // pack t bits
        if ((j & 7) + PARAMS_T_BITS > 8) {
            ct[(j >> 3) + 1] |= t >> (8 - (j & 7));
        }
        j += PARAMS_T_BITS;
    }

    return 0;
}

int decrypt(uint8_t *m, const uint8_t *ct, const uint8_t *sk)
{
    size_t i, j;
    uint16_t S_idx[PARAMS_H / 2][2];
    modp_t U[PARAMS_ND];
    modp_t v[PARAMS_MU];
    modp_t t, tmp[PARAMS_MU + PARAMS_MUL_PAD];
    uint8_t mm[PARAMS_SS_SIZE + PARAMS_XE_SIZE];

    create_spter_idx(S_idx, sk, PARAMS_SK_SIZE);

    unpack_ndp(U, ct);                      // ct = U | v

    j = 8 * PARAMS_NDP_SIZE;
    for (i = 0; i < PARAMS_MU; i++) {
        t = ct[j >> 3] >> (j & 7);          // unpack t bits
        if ((j & 7) + PARAMS_T_BITS > 8) {
            t |= ct[(j >> 3) + 1] << (8 - (j & 7));
        }
        v[i] = t & ((1 << PARAMS_T_BITS) - 1);
        j += PARAMS_T_BITS;
    }

    ringmul_p(tmp, U, S_idx);               // v - U * S (mod p)
    for (i = 0; i < PARAMS_MU; i++)
        tmp[i] = (v[i] << (PARAMS_P_BITS - PARAMS_T_BITS)) - tmp[i];

    memset(mm, 0, sizeof(mm));
    for (i = 0; i < PARAMS_MU; ++i) {       // reconstruct message
        t = ((tmp[i] + (1 << (PARAMS_P_BITS - 1 - 1))) >>
               (PARAMS_P_BITS - 1)) & 1;
        mm[i >> 3] |= t << (i & 7);
    }

    xe_fixerr(mm);                          // apply error correction
    memcpy(m, mm, PARAMS_SS_SIZE);

    return 0;
}

