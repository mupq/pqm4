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

void GenSecretNTT(uint32_t s_NTT[SABER_L][SABER_N], uint8_t seed_s[SABER_NOISE_SEEDBYTES], int keypair)
{
    size_t i;
    uint8_t shake_out[SABER_L * SABER_POLYCOINBYTES];
    uint16_t s[SABER_N];
    uint8_t *sk = seed_s; // temporary storage

    shake128(shake_out, SABER_L * SABER_POLYCOINBYTES, seed_s, SABER_NOISE_SEEDBYTES);
    for (i = 0; i < SABER_L; i++) {
        cbd(s, &shake_out[i * SABER_POLYCOINBYTES]);
        NTT_forward(s_NTT[i], s);

        if(keypair){ // during keypair generation: sk <- s
            POLmu2BS(sk + i * SABER_POLYSECRETBYTES, s);
        }
    }
}


/* pk[0] <- Pack(Round((A^T)*s)) */
void MatrixVectorMulKeyPairNTT(uint8_t pk[SABER_INDCPA_PUBLICKEYBYTES], uint8_t sk[SABER_INDCPA_SECRETKEYBYTES])
{
    size_t i, j;
    uint32_t s_NTT[SABER_N];
    uint32_t b_NTT[SABER_L][SABER_N];
    uint16_t poly[SABER_N]; // polynomial buffer for s[i], A[i][j], b[i]

    // overlap some memory
    union {
        uint32_t poly_NTT[SABER_N];
        uint8_t buff[MAX(SABER_POLYBYTES, SABER_POLYCOINBYTES)];
    } u;

    uint32_t (*A_NTT) = u.poly_NTT; // uint32_t A_NTT[SABER_N];
    uint8_t (*shake_out) = u.buff; // uint8_t shake_out[MAX(SABER_POLYBYTES, SABER_POLYCOINBYTES)];

    uint8_t *seed_A = pk + SABER_POLYVECCOMPRESSEDBYTES;
    uint8_t *seed_s = sk;
    shake128incctx shake_A_ctx = shake128_absorb_seed(seed_A);
    shake128incctx shake_s_ctx = shake128_absorb_seed(seed_s);

    for (i = 0; i < SABER_L; i++) {

        /* Generate NTT(s[i])*/
        shake128_inc_squeeze(shake_out, SABER_POLYCOINBYTES, &shake_s_ctx);
        cbd(poly, shake_out);
        POLmu2BS(&sk[i * SABER_POLYSECRETBYTES], poly); // sk <- s
        NTT_forward(s_NTT, poly);

        for (j = 0; j < SABER_L; j++) {

            /* Generate NTT(A[i][j])*/
            shake128_inc_squeeze(shake_out, SABER_POLYBYTES, &shake_A_ctx);
            BS2POLq(shake_out, poly);
            NTT_forward(A_NTT, poly);

            if (i == 0) {
                NTT_mul(b_NTT[j], s_NTT, A_NTT);
            } else {
                NTT_mul_acc(b_NTT[j], s_NTT, A_NTT);
            }
        }
    }

    shake128_inc_ctx_release(&shake_A_ctx);
    shake128_inc_ctx_release(&shake_s_ctx);

    for (i = 0; i < SABER_L; i++) {

        NTT_inv(poly, b_NTT[i]);

        // Round
        for (j = 0; j < SABER_N; j++) {
            poly[j] = ((poly[j] + h1) >> (SABER_EQ - SABER_EP));
        }

        // Pack
        POLp2BS(&pk[i * SABER_POLYCOMPRESSEDBYTES], poly);
    }
}

/**
 *  if (compare)
 *      verify(ct[0], Pack(Round(A*s')))
 *  else
 *      ct[0] <- Pack(Round(A*s'))
 */
uint32_t MatrixVectorMulEncNTT(uint8_t ct0[SABER_POLYVECCOMPRESSEDBYTES], const uint8_t seed_A[SABER_SEEDBYTES], uint32_t sp_NTT[SABER_L][SABER_N], int compare)
{
    size_t i, j;
    uint32_t fail = 0;
    uint32_t bp_NTT[SABER_N];
    uint16_t poly[SABER_N];

    shake128incctx shake_A_ctx = shake128_absorb_seed(seed_A);

    // overlap some memory
    union {
        uint32_t poly_NTT[SABER_N];
        uint8_t buff[SABER_POLYBYTES];
    } u;
    
    uint32_t (*A_NTT) = u.poly_NTT; // uint32_t A_NTT[SABER_N];
    uint8_t (*shake_out) = u.buff; // uint8_t shake_out[SABER_POLYBYTES];

    for (i = 0; i < SABER_L; i++) {

        for (j = 0; j < SABER_L; j++) {

            shake128_inc_squeeze(shake_out, SABER_POLYBYTES, &shake_A_ctx);
            BS2POLq(shake_out, poly);

            NTT_forward(A_NTT, poly);
            if (j == 0) {
                NTT_mul(bp_NTT, sp_NTT[j], A_NTT);
            } else {
                NTT_mul_acc(bp_NTT, sp_NTT[j], A_NTT);
            }
        }

        NTT_inv(poly, bp_NTT);

        for (j = 0; j < SABER_N; j++) {
            poly[j] = ((poly[j] + h1) >> (SABER_EQ - SABER_EP));
        }

        if (compare) {
            fail |= POLp2BS_cmp(&ct0[i * SABER_POLYCOMPRESSEDBYTES], poly);
        } else {
            POLp2BS(&ct0[i * SABER_POLYCOMPRESSEDBYTES], poly);
        }
    }

    shake128_inc_ctx_release(&shake_A_ctx);
    return fail;
}


/**
 *  if (compare)
 *      verify(ct[1], Pack(Round(b*s' + m')))
 *  else
 *      ct[1] <- Pack(Round(b*s' + m'))
 */
uint32_t InnerProdEncNTT(uint8_t ct1[SABER_SCALEBYTES_KEM], const uint8_t pk[SABER_INDCPA_PUBLICKEYBYTES], uint32_t sp_NTT[SABER_L][SABER_N], const uint8_t m[SABER_KEYBYTES], int compare)
{
    size_t j;
    uint32_t fail = 0;
    uint32_t vp_NTT[SABER_N];
    uint16_t b[SABER_N];
    uint16_t (*vp) = b;

    // overlap some memory
    union {
        uint32_t poly_NTT[SABER_N];
        uint16_t poly[SABER_N];
    } u;
 
    uint32_t (*b_NTT) = u.poly_NTT; // uint32_t b_NTT[SABER_N];
    uint16_t (*mp) = u.poly;  // uint16_t mp[SABER_N];

    for (j = 0; j < SABER_L; j++) {

        BS2POLp(&pk[j * SABER_POLYCOMPRESSEDBYTES], b);
        NTT_forward(b_NTT, b);

        if (j == 0) {
            NTT_mul(vp_NTT, sp_NTT[j], b_NTT);
        } else {
            NTT_mul_acc(vp_NTT, sp_NTT[j], b_NTT);
        }
    }

    NTT_inv(vp, vp_NTT);
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
void InnerProdDecNTT(uint8_t m[SABER_KEYBYTES], const uint8_t ciphertext[SABER_BYTES_CCA_DEC], const uint8_t sk[SABER_INDCPA_SECRETKEYBYTES])
{
    size_t i;
    uint32_t v_NTT[SABER_N];
    uint16_t poly[SABER_N];
    uint32_t s_NTT[SABER_N];

    // overlap some memory
    union {
        uint32_t poly_NTT[SABER_N];
        uint16_t poly[SABER_N];
    } u;
 
    uint32_t (*bp_NTT) = u.poly_NTT; // uint32_t bp_NTT[SABER_N];
    uint16_t (*cm) = u.poly;  // uint16_t cm[SABER_N];

    for (i = 0; i < SABER_L; i++) {

        BS2POLmu(&sk[i * SABER_POLYSECRETBYTES], poly);
        NTT_forward(s_NTT, poly);

        BS2POLp(&ciphertext[i * SABER_POLYCOMPRESSEDBYTES], poly);
        NTT_forward(bp_NTT, poly);

        if (i == 0) {
            NTT_mul(v_NTT, s_NTT, bp_NTT);
        } else {
            NTT_mul_acc(v_NTT, s_NTT, bp_NTT);
        }
    }

    NTT_inv(poly, v_NTT);

    BS2POLT(ciphertext + SABER_POLYVECCOMPRESSEDBYTES, cm);

    for (i = 0; i < SABER_N; i++) {
        poly[i] = (poly[i] + h2 - (cm[i] << (SABER_EP - SABER_ET))) >> (SABER_EP - 1);
    }

    POLmsg2BS(m, poly);
}


