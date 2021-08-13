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

void InnerProdDecNTT_16(uint8_t m[SABER_KEYBYTES], const uint8_t ciphertext[SABER_BYTES_CCA_DEC], const uint8_t sk[SABER_INDCPA_SECRETKEYBYTES]){

    // Black magic here, don't change the order of buff1, buff2, and buff3
    uint16_t buff1[SABER_N];
    uint16_t buff2[SABER_N];
    uint16_t buff3[SABER_N];

    uint32_t acc[SABER_N];

    uint16_t *acc_16 = (uint16_t*)acc;

    uint32_t *buff1_32 = (uint32_t*)buff1;
    uint32_t *buff2_32 = (uint32_t*)buff2;
    uint32_t *buff3_32 = (uint32_t*)buff3;

    size_t i;

    for (i = 0; i < SABER_L; i++) {

        BS2POLp(ciphertext + i * SABER_POLYCOMPRESSEDBYTES, buff3);
        NTT_forward_32(buff1_32, buff3);

#ifdef SABER_COMPRESS_SECRETKEY
        BS2POLmu(sk + i * SABER_POLYSECRETBYTES, buff3);
#else
        BS2POLq(sk + i * SABER_POLYSECRETBYTES, buff3);
#endif
        NTT_forward2(buff3_32, buff3);

        if(i == 0){
            NTT_mul_32x16_2(acc + 1 * SABER_N / 2, buff1_32, buff3_32);
        }else{
            NTT_mul_32x16_2(buff3_32, buff1_32, buff3_32);
            __asm_poly_add_16(acc_16 + 1 * SABER_N, acc_16 + 1 * SABER_N, buff3);
        }

        MOD_1(buff1_32, buff1_32);

#ifdef SABER_COMPRESS_SECRETKEY
        BS2POLmu(sk + i * SABER_POLYSECRETBYTES, buff2);
#else
        BS2POLq(sk + i * SABER_POLYSECRETBYTES, buff2);
#endif
        NTT_forward1(buff2_32, buff2);

        if(i == 0){
            NTT_mul_16_1(acc + 0 * SABER_N / 2, buff1_32, buff2_32);
        }else{
            NTT_mul_16_1(buff2_32, buff1_32, buff2_32);
            __asm_poly_add_16(acc_16 + 0 * SABER_N, acc_16 + 0 * SABER_N, buff2);
        }

    }

    solv_CRT(buff2_32, acc + 0 * SABER_N / 2, acc + 1 * SABER_N / 2);
    NTT_inv_32(buff1, buff2_32);

    BS2POLT(ciphertext + SABER_POLYVECCOMPRESSEDBYTES, buff2);

    for (i = 0; i < SABER_N; i++) {
        buff1[i] = (buff1[i] + h2 - (buff2[i] << (SABER_EP - SABER_ET))) >> (SABER_EP - 1);
    }

    POLmsg2BS(m, buff1);

}

void MatrixVectorMulKeyPairNTT_16_stack2(uint8_t pk[SABER_INDCPA_PUBLICKEYBYTES], uint8_t sk[SABER_INDCPA_SECRETKEYBYTES]){

    uint8_t s_buff[SABER_N / 2];
    uint16_t acc[SABER_L * SABER_N];

    // Black magic here, don't change the order of buff1, buff2, and buff3
    uint16_t buff1[SABER_N];
    uint16_t buff2[SABER_N];;
    uint16_t buff3[MAX(SABER_N, MAX(SABER_POLYCOINBYTES, SABER_POLYBYTES) / 2)];

    uint32_t *buff1_32 = (uint32_t*)buff1;
    uint32_t *buff2_32 = (uint32_t*)buff2;
    uint32_t *buff3_32 = (uint32_t*)buff3;

    uint8_t *shake_out = (uint8_t*)buff3;

    uint8_t *seed_A = pk + SABER_POLYVECCOMPRESSEDBYTES;
    uint8_t *seed_s = sk;

    size_t i, j;

    shake128incctx shake_s_ctx = shake128_absorb_seed(seed_s);
    shake128incctx shake_A_ctx = shake128_absorb_seed(seed_A);

    for (i = 0; i < SABER_L; i++) {

        shake128_inc_squeeze(shake_out, SABER_POLYCOINBYTES, &shake_s_ctx);
        cbd(buff2, shake_out);
#ifdef SABER_COMPRESS_SECRETKEY
        POLmu2BS(sk + i * SABER_POLYSECRETBYTES, buff2); // sk <- s
#else
        POLq2BS(sk + i * SABER_POLYSECRETBYTES, buff2); // sk <- s
#endif
        POLmu2BS(s_buff, buff2);

        for (j = 0; j < SABER_L; j++) {

            shake128_inc_squeeze(shake_out, SABER_POLYBYTES, &shake_A_ctx);

            BS2POLq(shake_out, buff3);
            NTT_forward_32(buff1_32, buff3);

            BS2POLmu(s_buff, buff3);
            NTT_forward2(buff3_32, buff3);

            NTT_mul_32x16_2(buff3_32, buff1_32, buff3_32);

            MOD_1(buff1_32, buff1_32);

            BS2POLmu(s_buff, buff2);
            NTT_forward1(buff2_32, buff2);

            NTT_mul_16_1(buff2_32, buff1_32, buff2_32);

            solv_CRT(buff1_32, buff2_32, buff3_32);

            if(i == 0){
                NTT_inv_32(acc + j * SABER_N, buff1_32);
            }else{
                NTT_inv_32(buff3, buff1_32);
                __asm_poly_add_16(acc + j * SABER_N, acc + j * SABER_N, buff3);
            }

        }
    }

    shake128_inc_ctx_release(&shake_A_ctx);
    shake128_inc_ctx_release(&shake_s_ctx);

    for (i = 0; i < SABER_L; i++) {

        for (j = 0; j < SABER_N; j++) {
            acc[i * SABER_N + j] = ((acc[i * SABER_N + j] + h1) >> (SABER_EQ - SABER_EP));
        }

        POLp2BS(pk + i * SABER_POLYCOMPRESSEDBYTES, acc + i * SABER_N);
    }

}


uint32_t MatrixVectorMulEncNTT_16_stack2(uint8_t ct0[SABER_POLYVECCOMPRESSEDBYTES], uint8_t ct1[SABER_SCALEBYTES_KEM], const uint8_t seed_s[SABER_NOISE_SEEDBYTES], const uint8_t seed_A[SABER_SEEDBYTES], const uint8_t pk[SABER_INDCPA_PUBLICKEYBYTES], const uint8_t m[SABER_KEYBYTES], int compare){

    uint8_t s_buff[SABER_L * SABER_N / 2];
    uint16_t acc[SABER_N];

    uint16_t buff1[SABER_N];
    uint16_t buff2[SABER_N];
    uint16_t buff3[MAX(SABER_N, MAX(SABER_POLYBYTES, SABER_POLYCOINBYTES) / 2)];

    uint32_t *buff1_32 = (uint32_t*)buff1;
    uint32_t *buff2_32 = (uint32_t*)buff2;
    uint32_t *buff3_32 = (uint32_t*)buff3;

    uint8_t *shake_out = (uint8_t*)buff3;

    uint16_t *mp = buff1;

    size_t i, j;
    uint32_t fail = 0;

    shake128incctx shake_s_ctx = shake128_absorb_seed(seed_s);

    for(i = 0; i < SABER_L; i++){
        shake128_inc_squeeze(shake_out, SABER_POLYCOINBYTES, &shake_s_ctx);
        cbd(acc, shake_out);
        POLmu2BS(s_buff + i * SABER_N / 2, acc);
    }

    shake128_inc_ctx_release(&shake_s_ctx);

    shake128incctx shake_A_ctx = shake128_absorb_seed(seed_A);

    for (i = 0; i < SABER_L; i++) {

        for (j = 0; j < SABER_L; j++) {

            shake128_inc_squeeze(shake_out, SABER_POLYBYTES, &shake_A_ctx);

            BS2POLq(shake_out, buff3);
            NTT_forward_32(buff1_32, buff3);

            BS2POLmu(s_buff + j * SABER_N / 2, buff3);
            NTT_forward2(buff3_32, buff3);

            NTT_mul_32x16_2(buff3_32, buff1_32, buff3_32);

            MOD_1(buff1_32, buff1_32);

            BS2POLmu(s_buff + j * SABER_N / 2, buff2);
            NTT_forward1(buff2_32, buff2);

            NTT_mul_16_1(buff2_32, buff1_32, buff2_32);

            solv_CRT(buff1_32, buff2_32, buff3_32);

            if(j == 0){
                NTT_inv_32(acc, buff1_32);
            }else{
                NTT_inv_32(buff3, buff1_32);
                __asm_poly_add_16(acc, acc, buff3);
            }

        }

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

        BS2POLp(pk + j * SABER_POLYCOMPRESSEDBYTES, buff3);
        NTT_forward_32(buff1_32, buff3);

        BS2POLmu(s_buff + j * SABER_N / 2, buff3);
        NTT_forward2(buff3_32, buff3);

        NTT_mul_32x16_2(buff3_32, buff1_32, buff3_32);

        MOD_1(buff1_32, buff1_32);

        BS2POLmu(s_buff + j * SABER_N / 2, buff2);
        NTT_forward1(buff2_32, buff2);

        NTT_mul_16_1(buff2_32, buff1_32, buff2_32);

        solv_CRT(buff1_32, buff2_32, buff3_32);

        if(j == 0){
            NTT_inv_32(acc, buff1_32);
        }else{
            NTT_inv_32(buff3, buff1_32);
            __asm_poly_add_16(acc, acc, buff3);
        }

    }

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




