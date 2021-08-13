#include "poly.h"
#include "cbd.h"
#include "NTT.h"
#include "fips202.h"
#include "pack_unpack.h"

#define h1 (1 << (SABER_EQ - SABER_EP - 1))
#define h2 ((1 << (SABER_EP - 2)) - (1 << (SABER_EP - SABER_ET - 1)) + (1 << (SABER_EQ - SABER_EP - 1)))
#define MAX(a,b) (((a)>(b))?(a):(b))

extern void __asm_poly_add_16(uint16_t *des, uint16_t *src1, uint16_t *src2);
extern void __asm_poly_add_32(uint32_t *des, uint32_t *src1, uint32_t *src2);

static inline shake128incctx shake128_absorb_seed(const uint8_t seed[SABER_SEEDBYTES]){

    shake128incctx ctx;
    shake128_inc_init(&ctx);
    shake128_inc_absorb(&ctx, seed, SABER_SEEDBYTES);
    shake128_inc_finalize(&ctx);

    return ctx;

}

void MatrixVectorMulKeyPairNTT(uint8_t pk[SABER_INDCPA_PUBLICKEYBYTES], uint8_t sk[SABER_INDCPA_SECRETKEYBYTES]){

    uint32_t s_NTT[SABER_N];
    uint32_t acc_NTT[SABER_L * SABER_N];
    uint32_t A_NTT[SABER_N];

    uint16_t poly[SABER_N];

    uint8_t shake_out[MAX(SABER_POLYBYTES, SABER_POLYCOINBYTES)];

    uint8_t *seed_A = pk + SABER_POLYVECCOMPRESSEDBYTES;
    uint8_t *seed_s = sk;

    size_t i, j;

    shake128incctx shake_s_ctx = shake128_absorb_seed(seed_s);
    shake128incctx shake_A_ctx = shake128_absorb_seed(seed_A);

    for (i = 0; i < SABER_L; i++) {

        shake128_inc_squeeze(shake_out, SABER_POLYCOINBYTES, &shake_s_ctx);
        cbd(poly, shake_out);
#ifdef SABER_COMPRESS_SECRETKEY
        POLmu2BS(sk + i * SABER_POLYSECRETBYTES, poly); // sk <- s
#else
        POLq2BS(sk + i * SABER_POLYSECRETBYTES, poly); // sk <- s
#endif
        NTT_forward_32(s_NTT, poly);

        for (j = 0; j < SABER_L; j++) {

            shake128_inc_squeeze(shake_out, SABER_POLYBYTES, &shake_A_ctx);
            BS2POLq(shake_out, poly);

            NTT_forward_32(A_NTT, poly);

            if(i == 0){
                NTT_mul_32(acc_NTT + j * SABER_N, A_NTT, s_NTT);
            }else{
                NTT_mul_32(A_NTT, A_NTT, s_NTT);
                __asm_poly_add_32(acc_NTT + j * SABER_N, acc_NTT + j * SABER_N, A_NTT);
            }

        }
    }

    shake128_inc_ctx_release(&shake_A_ctx);
    shake128_inc_ctx_release(&shake_s_ctx);

    for (i = 0; i < SABER_L; i++) {

        NTT_inv_32(poly, acc_NTT + i * SABER_N);

        for (j = 0; j < SABER_N; j++) {
            poly[j] = ((poly[j] + h1) >> (SABER_EQ - SABER_EP));
        }

        POLp2BS(pk + i * SABER_POLYCOMPRESSEDBYTES, poly);
    }

}

uint32_t MatrixVectorMulEncNTT(uint8_t ct0[SABER_POLYVECCOMPRESSEDBYTES], uint8_t ct1[SABER_SCALEBYTES_KEM], const uint8_t seed_s[SABER_NOISE_SEEDBYTES], const uint8_t seed_A[SABER_SEEDBYTES], const uint8_t pk[SABER_INDCPA_PUBLICKEYBYTES], const uint8_t m[SABER_KEYBYTES], int compare){

    uint32_t acc_NTT[SABER_N];
    uint32_t A_NTT[SABER_N];
    uint32_t s_NTT[SABER_L * SABER_N];

    uint16_t poly[SABER_N];
    uint16_t acc[SABER_N];

    uint8_t shake_out[MAX(SABER_POLYBYTES, SABER_POLYCOINBYTES)];

    uint16_t *mp = poly;

    size_t i, j;
    uint32_t fail = 0;

    shake128incctx shake_s_ctx = shake128_absorb_seed(seed_s);

    for(i = 0; i < SABER_L; i++){
        shake128_inc_squeeze(shake_out, SABER_POLYCOINBYTES, &shake_s_ctx);
        cbd(poly, shake_out);
        NTT_forward_32(s_NTT + i * SABER_N, poly);
    }

    shake128_inc_ctx_release(&shake_s_ctx);

    shake128incctx shake_A_ctx = shake128_absorb_seed(seed_A);

    for (i = 0; i < SABER_L; i++) {

        for (j = 0; j < SABER_L; j++) {

            shake128_inc_squeeze(shake_out, SABER_POLYBYTES, &shake_A_ctx);
            BS2POLq(shake_out, poly);

            NTT_forward_32(A_NTT, poly);

            if (j == 0) {
                NTT_mul_32(acc_NTT, A_NTT, s_NTT + j * SABER_N);
            } else {
                NTT_mul_32(A_NTT, A_NTT, s_NTT + j * SABER_N);
                __asm_poly_add_32(acc_NTT, acc_NTT, A_NTT);
            }
        }

        NTT_inv_32(acc, acc_NTT);

        for (j = 0; j < SABER_N; j++) {
            acc[j] = ((acc[j] + h1) >> (SABER_EQ - SABER_EP));
        }

        if (compare) {
            fail |= POLp2BS_cmp(ct0 + i * SABER_POLYCOMPRESSEDBYTES, acc);
        } else {
            POLp2BS(ct0 + i * SABER_POLYCOMPRESSEDBYTES, acc);
        }
    }

    shake128_inc_ctx_release(&shake_A_ctx);

    for(j = 0; j < SABER_L; j++){

        BS2POLp(pk + j * SABER_POLYCOMPRESSEDBYTES, poly);

        NTT_forward_32(A_NTT, poly);

        if(j == 0){
            NTT_mul_32(acc_NTT, A_NTT, s_NTT + j * SABER_N);
        }else{
            NTT_mul_32(A_NTT, A_NTT, s_NTT + j * SABER_N);
            __asm_poly_add_32(acc_NTT, acc_NTT, A_NTT);
        }

    }

    NTT_inv_32(acc, acc_NTT);

    BS2POLmsg(m, mp);

    for(j = 0; j < SABER_N; j++){
        acc[j] = (acc[j] - (mp[j] << (SABER_EP - 1)) + h1) >> (SABER_EP - SABER_ET);
    }

    if(compare){
        fail |= POLT2BS_cmp(ct1, acc);
    }else{
        POLT2BS(ct1, acc);
    }

    return fail;

}

void InnerProdDecNTT(uint8_t m[SABER_KEYBYTES], const uint8_t ciphertext[SABER_BYTES_CCA_DEC], const uint8_t sk[SABER_INDCPA_SECRETKEYBYTES]){

    uint32_t acc_NTT[SABER_N];
    uint32_t poly_NTT[SABER_N];
    uint32_t buff_NTT[SABER_N];

    uint16_t poly[SABER_N];
    uint16_t cm[SABER_N];

    size_t i;

    for (i = 0; i < SABER_L; i++) {

#ifdef SABER_COMPRESS_SECRETKEY
        BS2POLmu(sk + i * SABER_POLYSECRETBYTES, poly);
#else
        BS2POLq(sk + i * SABER_POLYSECRETBYTES, poly);
#endif

        NTT_forward_32(poly_NTT, poly);

        BS2POLp(ciphertext + i * SABER_POLYCOMPRESSEDBYTES, poly);
        NTT_forward_32(buff_NTT, poly);

        if (i == 0) {
            NTT_mul_32(acc_NTT, poly_NTT, buff_NTT);
        } else {
            NTT_mul_32(poly_NTT, poly_NTT, buff_NTT);
            __asm_poly_add_32(acc_NTT, acc_NTT, poly_NTT);
        }
    }

    NTT_inv_32(poly, acc_NTT);

    BS2POLT(ciphertext + SABER_POLYVECCOMPRESSEDBYTES, cm);

    for (i = 0; i < SABER_N; i++) {
        poly[i] = (poly[i] + h2 - (cm[i] << (SABER_EP - SABER_ET))) >> (SABER_EP - 1);
    }

    POLmsg2BS(m, poly);

}




