#include "poly.h"
#include "cbd.h"
#include "NTT.h"
#include "fips202.h"
#include "pack_unpack.h"

#define h1 (1 << (SABER_EQ - SABER_EP - 1))
#define h2 ((1 << (SABER_EP - 2)) - (1 << (SABER_EP - SABER_ET - 1)) + (1 << (SABER_EQ - SABER_EP - 1)))
#define MAX(a,b) (((a)>(b))?(a):(b))

static inline shake128incctx shake128_absorb_seed(const uint8_t seed[SABER_SEEDBYTES])
{
    shake128incctx ctx;
    shake128_inc_init(&ctx);
    shake128_inc_absorb(&ctx, seed, SABER_SEEDBYTES);
    shake128_inc_finalize(&ctx);
    return ctx;
}

void __attribute__((noinline)) GenNTTMatrix(uint32_t A_NTT[SABER_L][SABER_L][SABER_N], const uint8_t seed_A[SABER_SEEDBYTES])
{
    size_t i;
    shake128incctx shake_A_ctx = shake128_absorb_seed(seed_A);
    uint8_t shake_out[SABER_POLYVECBYTES];
    uint16_t A_row[SABER_L][SABER_N];

    for (i = 0; i < SABER_L; i++) { // generate row-by-row to limit stack usage
        shake128_inc_squeeze(shake_out, SABER_POLYVECBYTES, &shake_A_ctx);
        BS2POLVECq(shake_out, A_row);
        NTT_forward(A_row, A_NTT[i]);
    }

    shake128_inc_ctx_release(&shake_A_ctx);
}

void __attribute__((noinline)) GenNTTSecret(uint32_t s_NTT[SABER_L][SABER_N], uint8_t seed_s[SABER_NOISE_SEEDBYTES], int keypair)
{
    size_t i;
    uint8_t shake_out[SABER_L * SABER_POLYCOINBYTES];
    uint16_t s[SABER_L][SABER_N];
    uint8_t *sk = seed_s; // temporary storage

    shake128(shake_out, SABER_L * SABER_POLYCOINBYTES, seed_s, SABER_NOISE_SEEDBYTES);
    for (i = 0; i < SABER_L; i++) {
        cbd(s[i], &shake_out[i * SABER_POLYCOINBYTES]);
    }

    if (keypair) { // during keypair generation, sk <- s
        POLVEC42BS(sk, s);
    }

    NTT_forward(s, s_NTT);
}

/* pk[0] <- Pack(Round((A^T)*s)) */
static void __attribute__((noinline)) _MatrixVectorMulKeyPair(uint8_t pk[SABER_INDCPA_PUBLICKEYBYTES], uint32_t A_NTT[SABER_L][SABER_L][SABER_N], uint32_t s_NTT[SABER_L][SABER_N])
{
    size_t i, j;
    uint32_t b_NTT[SABER_L][SABER_N];
    uint16_t b[SABER_L][SABER_N];

    // (A^T)*s
    for (j = 0; j < SABER_L; j++) {
        NTT_matrix_mul_transpose(s_NTT, A_NTT, b_NTT, j);
    }

    NTT_inv(b_NTT, b);

    // Round
    for (i = 0; i < SABER_L; i++) {
        for (j = 0; j < SABER_N; j++) {
            b[i][j] = ((b[i][j] + h1) >> (SABER_EQ - SABER_EP));
        }
    }

    // Pack
    POLVECp2BS(pk, b);
}

/* pk[0] <- Pack(Round((A^T)*s)) */
void MatrixVectorMulKeyPairJIT(uint8_t pk[SABER_INDCPA_PUBLICKEYBYTES], uint8_t sk[SABER_INDCPA_SECRETKEYBYTES])
{
    uint8_t *seed_A = pk + SABER_POLYVECCOMPRESSEDBYTES;
    uint8_t *seed_s = sk;

#ifndef SABER_MEMORY_EFFICIENT
    uint32_t A_NTT[SABER_L][SABER_L][SABER_N];
    uint32_t s_NTT[SABER_L][SABER_N];

    GenNTTMatrix(A_NTT, seed_A);
    GenNTTSecret(s_NTT, seed_s, 1); // sk <- s
    _MatrixVectorMulKeyPair(pk, A_NTT, s_NTT);
#else
    size_t i, j;
    uint32_t A_NTT[SABER_N];
    uint32_t s_NTT[SABER_N];
    uint32_t b_NTT[SABER_L][SABER_N];
    uint16_t poly[SABER_N]; // polynomial buffer for s[i], A[i][j], b[i]
    uint8_t shake_out[MAX(SABER_POLYBYTES, SABER_POLYCOINBYTES)];
    shake128incctx shake_A_ctx = shake128_absorb_seed(seed_A);
    shake128incctx shake_s_ctx = shake128_absorb_seed(seed_s);

    for (i = 0; i < SABER_L; i++) {

        /* Generate NTT(s[i])*/
        shake128_inc_squeeze(shake_out, SABER_POLYCOINBYTES, &shake_s_ctx);
        cbd(poly, shake_out);
        POL42BS(&sk[i * SABER_N / 2], poly); // sk <- s
        NTT_forward_inner(poly, s_NTT);

        for (j = 0; j < SABER_L; j++) {

            /* Generate NTT(A[i][j])*/
            shake128_inc_squeeze(shake_out, SABER_POLYBYTES, &shake_A_ctx);
            BS2POLq(shake_out, poly);
            NTT_forward_inner(poly, A_NTT);

            if (i == 0) {
                NTT_mul(s_NTT, A_NTT, b_NTT[j]);
            } else {
                NTT_mul_acc(s_NTT, A_NTT, b_NTT[j]);
            }
        }
    }

    shake128_inc_ctx_release(&shake_A_ctx);
    shake128_inc_ctx_release(&shake_s_ctx);

    for (i = 0; i < SABER_L; i++) {

        NTT_inv_inner(b_NTT[i], poly);

        // Round
        for (j = 0; j < SABER_N; j++) {
            poly[j] = ((poly[j] + h1) >> (SABER_EQ - SABER_EP));
        }

        // Pack
        POLp2BS(&pk[i * (SABER_EP * SABER_N / 8)], poly);
    }

#endif
}

/* if (compare)
        verify(ct[0], Pack(Round(A*s')))
   else
        ct[0] <- Pack(Round(A*s')) */
uint32_t MatrixVectorMulEnc(uint8_t ct0[SABER_POLYVECCOMPRESSEDBYTES], const uint8_t seed_A[SABER_SEEDBYTES], uint32_t sp_NTT[SABER_L][SABER_N], int compare)
{
    uint32_t fail = 0;
    size_t i, j;
    shake128incctx shake_A_ctx = shake128_absorb_seed(seed_A);
    uint8_t shake_out[SABER_POLYVECBYTES];

#ifndef SABER_MEMORY_EFFICIENT
    uint32_t A_row_NTT[SABER_L][SABER_N];
    uint32_t bp_NTT[SABER_L][SABER_N];
    uint16_t polyvec[SABER_L][SABER_N];

    for (i = 0; i < SABER_L; i++) {
        shake128_inc_squeeze(shake_out, SABER_POLYVECBYTES, &shake_A_ctx);
        BS2POLVECq(shake_out, polyvec);
        NTT_forward(polyvec, A_row_NTT);
        NTT_vector_mul(sp_NTT, A_row_NTT, bp_NTT[i]);
    }

    shake128_inc_ctx_release(&shake_A_ctx);

    NTT_inv(bp_NTT, polyvec);

    for (i = 0; i < SABER_L; i++) {
        for (j = 0; j < SABER_N; j++) {
            polyvec[i][j] = ((polyvec[i][j] + h1) >> (SABER_EQ - SABER_EP));
        }
    }

    if (compare) {
        fail |= POLVECp2BS_cmp(ct0, polyvec);
    } else {
        POLVECp2BS(ct0, polyvec);
    }

#else
    uint32_t A_NTT[SABER_N];
    uint32_t bp_NTT[SABER_N];
    uint16_t poly[SABER_N];

    for (i = 0; i < SABER_L; i++) {

        for (j = 0; j < SABER_L; j++) {

            shake128_inc_squeeze(shake_out, SABER_POLYBYTES, &shake_A_ctx);
            BS2POLq(shake_out, poly);
            NTT_forward_inner(poly, A_NTT);

            if (j == 0) {
                NTT_mul(sp_NTT[j], A_NTT, bp_NTT);
            } else {
                NTT_mul_acc(sp_NTT[j], A_NTT, bp_NTT);
            }
        }

        NTT_inv_inner(bp_NTT, poly);

        for (j = 0; j < SABER_N; j++) {
            poly[j] = ((poly[j] + h1) >> (SABER_EQ - SABER_EP));
        }

        if (compare) {
            fail |= POLp2BS_cmp(&ct0[i * SABER_POLYCOMPRESSEDBYTES], poly);
        } else {
            POLp2BS(&ct0[i * SABER_POLYCOMPRESSEDBYTES], poly);
        }
    }

#endif

    shake128_inc_ctx_release(&shake_A_ctx);
    return fail;

}

/* if (compare)
        verify(ct[1], Pack(Round(b*s' + m')))
   else
        ct[1] <- Pack(Round(b*s' + m')) */
uint32_t InnerProdEnc(uint8_t ct1[SABER_SCALEBYTES_KEM], const uint8_t pk[SABER_INDCPA_PUBLICKEYBYTES], uint32_t sp_NTT[SABER_L][SABER_N], const uint8_t m[SABER_KEYBYTES], int compare)
{
    uint32_t fail = 0;
    size_t j;
    uint16_t mp[SABER_N]; //TODO
    uint32_t vp_NTT[SABER_N];

#ifndef SABER_MEMORY_EFFICIENT
    uint16_t b[SABER_L][SABER_N];
    uint32_t b_NTT[SABER_L][SABER_N];
    uint16_t (*vp) = b[0];

    BS2POLVECp(pk, b);
    NTT_forward(b, b_NTT);
    NTT_vector_mul(sp_NTT, b_NTT, vp_NTT);
#else
    uint16_t b[SABER_N];
    uint32_t b_NTT[SABER_N];
    uint16_t (*vp) = b;

    for (j = 0; j < SABER_L; j++) {

        BS2POLp(&pk[j * SABER_POLYCOMPRESSEDBYTES], b);
        NTT_forward_inner(b, b_NTT);

        if (j == 0) {
            NTT_mul(sp_NTT[j], b_NTT, vp_NTT);
        } else {
            NTT_mul_acc(sp_NTT[j], b_NTT, vp_NTT);
        }
    }
#endif

    NTT_inv_inner(vp_NTT, vp);
    BS2POLmsg(m, mp);

    for (j = 0; j < SABER_N; j++) {
        vp[j] = (vp[j] - (mp[j] << (SABER_EP - 1)) + h1) >> (SABER_EP - SABER_ET);
    }

    if (compare) {
        fail |= POLT2BS_cmp(ct1, vp);
    } else {
        POLT2BS(ct1, vp);
    }

    return fail;
}

/* m <- Pack(Round(b'*s - cm)) */
void InnerProdDec(uint8_t m[SABER_KEYBYTES], const uint8_t ciphertext[SABER_BYTES_CCA_DEC], const uint8_t sk[SABER_INDCPA_SECRETKEYBYTES])
{
    size_t i;
    uint16_t cm[SABER_N];
    uint32_t v_NTT[SABER_N];

#ifndef SABER_MEMORY_EFFICIENT
    uint16_t polyvec[SABER_L][SABER_N];
    uint16_t (*poly) = polyvec[0];
    uint32_t s_NTT[SABER_L][SABER_N];
    uint32_t bp_NTT[SABER_L][SABER_N];

    BS2POLVEC4(sk, polyvec);
    NTT_forward(polyvec, s_NTT);
    BS2POLVECp(ciphertext, polyvec);
    NTT_forward(polyvec, bp_NTT);
    NTT_vector_mul(s_NTT, bp_NTT, v_NTT);
#else
    uint16_t poly[SABER_N];
    uint32_t s_NTT[SABER_N];
    uint32_t bp_NTT[SABER_N];

    for (i = 0; i < SABER_L; i++) {

        BS2POL4(&sk[i * (SABER_N / 2)], poly);
        NTT_forward_inner(poly, s_NTT);

        BS2POLp(&ciphertext[i * SABER_POLYCOMPRESSEDBYTES], poly);
        NTT_forward_inner(poly, bp_NTT);

        if (i == 0) {
            NTT_mul(s_NTT, bp_NTT, v_NTT);
        } else {
            NTT_mul_acc(s_NTT, bp_NTT, v_NTT);
        }
    }
#endif

    NTT_inv_inner(v_NTT, poly);

    BS2POLT(ciphertext + SABER_POLYVECCOMPRESSEDBYTES, cm);

    for (i = 0; i < SABER_N; i++) {
        poly[i] = (poly[i] + h2 - (cm[i] << (SABER_EP - SABER_ET))) >> (SABER_EP - 1);
    }

    POLmsg2BS(m, poly);
}