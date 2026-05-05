/********************************************************************************************
* FrodoKEM: Learning with Errors Key Encapsulation
*
* Abstract: Key Encapsulation Mechanism (KEM) based on Frodo
*********************************************************************************************/

#include "api.h"
//kem函数命名正确不变
#include <stdlib.h>
#include <string.h>
#include "fips202.h"
// 检查shake是否需要改变
// 方案void shake128(unsigned char *output, unsigned long long outlen, const unsigned char *input,  unsigned long long inlen);
// 框架void shake128(uint8_t *output, size_t outlen,const uint8_t *input, size_t inlen);
// 应用中为"shake"后在venom*.c中宏定义
#include "random.h"
// randombytes应该不变
#ifdef DO_VALGRIND_CHECK
#include <valgrind/memcheck.h>
#endif

#define DITHER_DOMAIN_PK 0xA1
#define DITHER_DOMAIN_U  0xB1
#define DITHER_DOMAIN_V  0xC1

#define PK_PACKED_BYTES ((PARAMS_PK_LOGP * PARAMS_N * PARAMS_NBAR) / 8)
#define CT_C1_PACKED_BYTES ((PARAMS_U_LOGP * PARAMS_N * PARAMS_NBAR) / 8)
#define CT_C2_PACKED_BYTES ((PARAMS_V_LOGP * PARAMS_NBAR * PARAMS_NBAR) / 8)

static inline uint16_t frodo_q_mask_local(void)
{
    return (uint16_t)((1u << PARAMS_LOGQ) - 1u);
}

static inline uint16_t frodo_p_mask_local(unsigned int logp)
{
    return (uint16_t)((1u << logp) - 1u);
}

static inline uint16_t frodo_reconstruct_local(uint16_t x, unsigned int logp)
{
    return (uint16_t)((x & frodo_p_mask_local(logp)) << (PARAMS_LOGQ - logp));
}

static inline uint16_t frodo_quantize_local(uint16_t x, uint16_t d, unsigned int logp)
{
    const unsigned int shift = PARAMS_LOGQ - logp;
    const uint32_t qmask = frodo_q_mask_local();
    uint32_t z = ((uint32_t)x & qmask) + ((uint32_t)d & ((1u << shift) - 1u));
    z &= qmask;
    z = (z + (1u << (shift - 1))) >> shift;
    return (uint16_t)(z & frodo_p_mask_local(logp));
}

static int frodo_expand_dither_local(uint16_t *d, size_t n, const uint8_t *seed, size_t seedlen, uint8_t domain, unsigned int logp)
{
    const unsigned int shift = PARAMS_LOGQ - logp;
    const uint16_t mask = (uint16_t)((1u << shift) - 1u);
    uint8_t in[1 + BYTES_SEED_A + BYTES_SALT] = {0};

    in[0] = domain;
    memcpy(&in[1], seed, seedlen);
    shake((uint8_t *)d, n * sizeof(uint16_t), in, 1 + seedlen);
    for (size_t i = 0; i < n; i++) {
        d[i] = LE_TO_UINT16(d[i]) & mask;
    }
    return 0;
}

static int frodo_quantize_dithered_local(uint16_t *out, const uint16_t *in, size_t n, const uint8_t *seed, size_t seedlen, uint8_t domain, unsigned int logp)
{
    uint16_t *d = (uint16_t *)malloc(n * sizeof(uint16_t));

    if (d == NULL) {
        return 1;
    }
    if (frodo_expand_dither_local(d, n, seed, seedlen, domain, logp) != 0) {
        clear_bytes((uint8_t *)d, n * sizeof(uint16_t));
        free(d);
        return 1;
    }
    for (size_t i = 0; i < n; i++) {
        out[i] = frodo_quantize_local(in[i], d[i], logp);
    }
    clear_bytes((uint8_t *)d, n * sizeof(uint16_t));
    free(d);
    return 0;
}

static int frodo_reconstruct_dithered_local(uint16_t *normal, const uint16_t *split, size_t n, const uint8_t *seed, size_t seedlen, uint8_t domain, unsigned int logp)
{
    uint16_t *d = (uint16_t *)malloc(n * sizeof(uint16_t));

    if (d == NULL) {
        return 1;
    }
    if (frodo_expand_dither_local(d, n, seed, seedlen, domain, logp) != 0) {
        clear_bytes((uint8_t *)d, n * sizeof(uint16_t));
        free(d);
        return 1;
    }
    for (size_t i = 0; i < n; i++) {
        normal[i] = (uint16_t)((frodo_reconstruct_local(split[i], logp) - d[i]) & frodo_q_mask_local());
    }
    clear_bytes((uint8_t *)d, n * sizeof(uint16_t));
    free(d);
    return 0;
}

int crypto_kem_keypair(unsigned char* pk, unsigned char* sk)
{ // FrodoKEM's key generation with public dithered quantization
    uint8_t *pk_seedA = &pk[0];
    uint8_t *pk_b = &pk[BYTES_SEED_A];
    uint8_t *sk_s = &sk[0];
    uint8_t *sk_pk = &sk[CRYPTO_BYTES];
    uint8_t *sk_S = &sk[CRYPTO_BYTES + CRYPTO_PUBLICKEYBYTES];
    uint8_t *sk_pkh = &sk[CRYPTO_BYTES + CRYPTO_PUBLICKEYBYTES + 2*PARAMS_N*PARAMS_NBAR];
    uint16_t B_raw[PARAMS_N*PARAMS_NBAR] = {0};
    uint16_t B_split[PARAMS_N*PARAMS_NBAR] = {0};
    uint16_t S[PARAMS_N*PARAMS_NBAR] = {0};                          // contains secret data
    uint16_t E_zero[PARAMS_N*PARAMS_NBAR] = {0};
    uint8_t randomness[CRYPTO_BYTES + BYTES_SEED_SE + BYTES_SEED_A]; // contains secret data via randomness_s and randomness_seedSE
    uint8_t *randomness_s = &randomness[0];                          // contains secret data
    uint8_t *randomness_seedSE = &randomness[CRYPTO_BYTES];          // contains secret data
    uint8_t *randomness_z = &randomness[CRYPTO_BYTES + BYTES_SEED_SE];
    uint8_t shake_input_seedSE[1 + BYTES_SEED_SE];                   // contains secret data

    if (randombytes(randomness, CRYPTO_BYTES + BYTES_SEED_SE + BYTES_SEED_A) != 0)
        return 1;
#ifdef DO_VALGRIND_CHECK
    VALGRIND_MAKE_MEM_UNDEFINED(randomness, CRYPTO_BYTES + BYTES_SEED_SE + BYTES_SEED_A);
#endif
    shake(pk_seedA, BYTES_SEED_A, randomness_z, BYTES_SEED_A);

    shake_input_seedSE[0] = 0x5F;
    memcpy(&shake_input_seedSE[1], randomness_seedSE, BYTES_SEED_SE);
    shake((uint8_t*)S, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t), shake_input_seedSE, 1 + BYTES_SEED_SE);
    for (size_t i = 0; i < PARAMS_N * PARAMS_NBAR; i++) {
        S[i] = LE_TO_UINT16(S[i]);
    }
    frodo_sample_n(S, PARAMS_N*PARAMS_NBAR);
    frodo_mul_add_as_plus_e(B_raw, S, E_zero, pk_seedA);
    if (frodo_quantize_dithered_local(B_split, B_raw, PARAMS_N*PARAMS_NBAR, pk_seedA, BYTES_SEED_A, DITHER_DOMAIN_PK, PARAMS_PK_LOGP) != 0) {
        clear_bytes((uint8_t *)B_raw, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
        clear_bytes((uint8_t *)B_split, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
        clear_bytes((uint8_t *)S, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
        clear_bytes(randomness, CRYPTO_BYTES + BYTES_SEED_SE + BYTES_SEED_A);
        clear_bytes(shake_input_seedSE, 1 + BYTES_SEED_SE);
        return 1;
    }

    frodo_pack(pk_b, PK_PACKED_BYTES, B_split, PARAMS_N*PARAMS_NBAR, PARAMS_PK_LOGP);

    memcpy(sk_s, randomness_s, CRYPTO_BYTES);
    memcpy(sk_pk, pk, CRYPTO_PUBLICKEYBYTES);
    for (size_t i = 0; i < PARAMS_N * PARAMS_NBAR; i++) {
        S[i] = UINT16_TO_LE(S[i]);
    }
    memcpy(sk_S, S, 2*PARAMS_N*PARAMS_NBAR);

    shake(sk_pkh, BYTES_PKHASH, pk, CRYPTO_PUBLICKEYBYTES);

    clear_bytes((uint8_t *)B_raw, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)B_split, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)S, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes(randomness, CRYPTO_BYTES + BYTES_SEED_SE);
    clear_bytes(shake_input_seedSE, 1 + BYTES_SEED_SE);
#ifdef DO_VALGRIND_CHECK
    VALGRIND_MAKE_MEM_DEFINED(randomness, CRYPTO_BYTES + BYTES_SEED_SE + BYTES_SEED_A);
#endif
    return 0;
}


int crypto_kem_enc(unsigned char *ct, unsigned char *ss, const unsigned char *pk)
{ // FrodoKEM's key encapsulation with public dithered quantization
    const uint8_t *pk_seedA = &pk[0];
    const uint8_t *pk_b = &pk[BYTES_SEED_A];
    uint8_t *ct_c1 = &ct[0];
    uint8_t *ct_c2 = &ct[CT_C1_PACKED_BYTES];
    uint16_t B_split[PARAMS_N*PARAMS_NBAR] = {0};
    uint16_t B_norm[PARAMS_N*PARAMS_NBAR] = {0};
    uint16_t Bp_raw[PARAMS_N*PARAMS_NBAR] = {0};                     // contains secret data
    uint16_t Bp_split[PARAMS_N*PARAMS_NBAR] = {0};                   // contains secret data
    uint16_t V_raw[PARAMS_NBAR*PARAMS_NBAR] = {0};                   // contains secret data
    uint16_t C_split[PARAMS_NBAR*PARAMS_NBAR] = {0};                 // contains secret data
    uint16_t C_enc[PARAMS_NBAR*PARAMS_NBAR] = {0};                   // contains secret data
    uint16_t E_zero_nbar[PARAMS_NBAR*PARAMS_NBAR] = {0};
    ALIGN_HEADER(32) uint16_t Sp[PARAMS_N*PARAMS_NBAR] ALIGN_FOOTER(32) = {0};  // contains secret data
    uint16_t E_zero[PARAMS_N*PARAMS_NBAR] = {0};
    uint8_t G2in[BYTES_PKHASH + BYTES_MU + BYTES_SALT];              // contains secret data via mu
    uint8_t *pkh = &G2in[0];
    uint8_t *mu = &G2in[BYTES_PKHASH];                               // contains secret data
    uint8_t *salt = &G2in[BYTES_PKHASH + BYTES_MU];
    uint8_t G2out[BYTES_SEED_SE + CRYPTO_BYTES];                     // contains secret data
    uint8_t *seedSE = &G2out[0];                                     // contains secret data
    uint8_t *k = &G2out[BYTES_SEED_SE];                              // contains secret data
    uint8_t Fin[CRYPTO_CIPHERTEXTBYTES + CRYPTO_BYTES];              // contains secret data via Fin_k
    uint8_t *Fin_ct = &Fin[0];
    uint8_t *Fin_k = &Fin[CRYPTO_CIPHERTEXTBYTES];                   // contains secret data
    uint8_t shake_input_seedSE[1 + BYTES_SEED_SE];                   // contains secret data

    shake(pkh, BYTES_PKHASH, pk, CRYPTO_PUBLICKEYBYTES);
    if (randombytes(mu, BYTES_MU + BYTES_SALT) != 0)
        return 1;
#ifdef DO_VALGRIND_CHECK
    VALGRIND_MAKE_MEM_UNDEFINED(mu, BYTES_MU + BYTES_SALT);
    VALGRIND_MAKE_MEM_UNDEFINED(pk, CRYPTO_PUBLICKEYBYTES);
#endif
    shake(G2out, BYTES_SEED_SE + CRYPTO_BYTES, G2in, BYTES_PKHASH + BYTES_MU + BYTES_SALT);

    shake_input_seedSE[0] = 0x96;
    memcpy(&shake_input_seedSE[1], seedSE, BYTES_SEED_SE);
    shake((uint8_t*)Sp, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t), shake_input_seedSE, 1 + BYTES_SEED_SE);
    for (size_t i = 0; i < PARAMS_N * PARAMS_NBAR; i++) {
        Sp[i] = LE_TO_UINT16(Sp[i]);
    }
    frodo_sample_n(Sp, PARAMS_N*PARAMS_NBAR);
    frodo_mul_add_sa_plus_e(Bp_raw, Sp, E_zero, pk_seedA);
    for (size_t i = 0; i < PARAMS_N * PARAMS_NBAR; i++) {
        Bp_raw[i] &= frodo_q_mask_local();
    }
    if (frodo_quantize_dithered_local(Bp_split, Bp_raw, PARAMS_N*PARAMS_NBAR, salt, BYTES_SALT, DITHER_DOMAIN_U, PARAMS_U_LOGP) != 0) {
        return 1;
    }
    frodo_pack(ct_c1, CT_C1_PACKED_BYTES, Bp_split, PARAMS_N*PARAMS_NBAR, PARAMS_U_LOGP);

    frodo_unpack(B_split, PARAMS_N*PARAMS_NBAR, pk_b, PK_PACKED_BYTES, PARAMS_PK_LOGP);
    if (frodo_reconstruct_dithered_local(B_norm, B_split, PARAMS_N*PARAMS_NBAR, pk_seedA, BYTES_SEED_A, DITHER_DOMAIN_PK, PARAMS_PK_LOGP) != 0) {
        return 1;
    }
    frodo_mul_add_sb_plus_e(V_raw, B_norm, Sp, E_zero_nbar);

    frodo_key_encode(C_enc, (uint16_t*)mu);
    frodo_add(C_enc, V_raw, C_enc);
    if (frodo_quantize_dithered_local(C_split, C_enc, PARAMS_NBAR*PARAMS_NBAR, salt, BYTES_SALT, DITHER_DOMAIN_V, PARAMS_V_LOGP) != 0) {
        return 1;
    }
    frodo_pack(ct_c2, CT_C2_PACKED_BYTES, C_split, PARAMS_NBAR*PARAMS_NBAR, PARAMS_V_LOGP);

    memcpy(&ct[CRYPTO_CIPHERTEXTBYTES - BYTES_SALT], salt, BYTES_SALT);
    memcpy(Fin_ct, ct, CRYPTO_CIPHERTEXTBYTES);
    memcpy(Fin_k, k, CRYPTO_BYTES);
    shake(ss, CRYPTO_BYTES, Fin, CRYPTO_CIPHERTEXTBYTES + CRYPTO_BYTES);

    clear_bytes((uint8_t *)B_norm, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)Bp_raw, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)Bp_split, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)V_raw, PARAMS_NBAR*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)C_split, PARAMS_NBAR*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)C_enc, PARAMS_NBAR*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)Sp, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes(mu, BYTES_MU);
    clear_bytes(G2out, BYTES_SEED_SE + CRYPTO_BYTES);
    clear_bytes(Fin_k, CRYPTO_BYTES);
    clear_bytes(shake_input_seedSE, 1 + BYTES_SEED_SE);
#ifdef DO_VALGRIND_CHECK
    VALGRIND_MAKE_MEM_DEFINED(mu, BYTES_MU);
    VALGRIND_MAKE_MEM_DEFINED(pk, CRYPTO_PUBLICKEYBYTES);
#endif
    return 0;
}


int crypto_kem_dec(unsigned char *ss, const unsigned char *ct, const unsigned char *sk)
{ // FrodoKEM's key decapsulation with public dithered quantization
    uint16_t B_split[PARAMS_N*PARAMS_NBAR] = {0};
    uint16_t B_norm[PARAMS_N*PARAMS_NBAR] = {0};
    uint16_t Bp_split[PARAMS_N*PARAMS_NBAR] = {0};
    uint16_t Bp_norm[PARAMS_N*PARAMS_NBAR] = {0};
    uint16_t BBp_raw[PARAMS_N*PARAMS_NBAR] = {0};                     // contains secret data
    uint16_t BBp_split[PARAMS_N*PARAMS_NBAR] = {0};                   // contains secret data
    uint16_t W[PARAMS_NBAR*PARAMS_NBAR] = {0};                        // contains secret data
    uint16_t C_split[PARAMS_NBAR*PARAMS_NBAR] = {0};
    uint16_t C_norm[PARAMS_NBAR*PARAMS_NBAR] = {0};                   // contains secret data
    uint16_t CC[PARAMS_NBAR*PARAMS_NBAR] = {0};                       // contains secret data
    uint16_t CC_split[PARAMS_NBAR*PARAMS_NBAR] = {0};                 // contains secret data
    uint16_t E_zero[PARAMS_N*PARAMS_NBAR] = {0};
    uint16_t E_zero_nbar[PARAMS_NBAR*PARAMS_NBAR] = {0};
    const uint8_t *ct_c1 = &ct[0];
    const uint8_t *ct_c2 = &ct[CT_C1_PACKED_BYTES];
    const uint8_t *salt = &ct[CRYPTO_CIPHERTEXTBYTES - BYTES_SALT];
    const uint8_t *sk_s = &sk[0];
    const uint8_t *sk_pk = &sk[CRYPTO_BYTES];
    const uint16_t *sk_S = (uint16_t *) &sk[CRYPTO_BYTES + CRYPTO_PUBLICKEYBYTES];
    uint16_t S[PARAMS_N * PARAMS_NBAR];                               // contains secret data
    const uint8_t *sk_pkh = &sk[CRYPTO_BYTES + CRYPTO_PUBLICKEYBYTES + 2*PARAMS_N*PARAMS_NBAR];
    const uint8_t *pk_seedA = &sk_pk[0];
    const uint8_t *pk_b = &sk_pk[BYTES_SEED_A];
    uint8_t G2in[BYTES_PKHASH + BYTES_MU + BYTES_SALT];               // contains secret data via muprime
    uint8_t *pkh = &G2in[0];
    uint8_t *muprime = &G2in[BYTES_PKHASH];                           // contains secret data
    uint8_t *G2in_salt = &G2in[BYTES_PKHASH + BYTES_MU];
    uint8_t G2out[BYTES_SEED_SE + CRYPTO_BYTES];                      // contains secret data
    uint8_t *seedSEprime = &G2out[0];                                 // contains secret data
    uint8_t *kprime = &G2out[BYTES_SEED_SE];                          // contains secret data
    uint8_t Fin[CRYPTO_CIPHERTEXTBYTES + CRYPTO_BYTES];               // contains secret data via Fin_k
    uint8_t *Fin_ct = &Fin[0];
    uint8_t *Fin_k = &Fin[CRYPTO_CIPHERTEXTBYTES];                    // contains secret data
    uint8_t shake_input_seedSEprime[1 + BYTES_SEED_SE];               // contains secret data
    ALIGN_HEADER(32) uint16_t Sp[PARAMS_N*PARAMS_NBAR] ALIGN_FOOTER(32) = {0};  // contains secret data

#ifdef DO_VALGRIND_CHECK
    VALGRIND_MAKE_MEM_UNDEFINED(sk, CRYPTO_SECRETKEYBYTES);
    VALGRIND_MAKE_MEM_UNDEFINED(ct, CRYPTO_CIPHERTEXTBYTES);
#endif

    for (size_t i = 0; i < PARAMS_N * PARAMS_NBAR; i++) {
        S[i] = LE_TO_UINT16(sk_S[i]);
    }

    frodo_unpack(Bp_split, PARAMS_N*PARAMS_NBAR, ct_c1, CT_C1_PACKED_BYTES, PARAMS_U_LOGP);
    frodo_unpack(C_split, PARAMS_NBAR*PARAMS_NBAR, ct_c2, CT_C2_PACKED_BYTES, PARAMS_V_LOGP);
    if (frodo_reconstruct_dithered_local(Bp_norm, Bp_split, PARAMS_N*PARAMS_NBAR, salt, BYTES_SALT, DITHER_DOMAIN_U, PARAMS_U_LOGP) != 0 ||
        frodo_reconstruct_dithered_local(C_norm, C_split, PARAMS_NBAR*PARAMS_NBAR, salt, BYTES_SALT, DITHER_DOMAIN_V, PARAMS_V_LOGP) != 0) {
        return 1;
    }
    frodo_mul_bs(W, Bp_norm, S);
    frodo_sub(W, C_norm, W);
    frodo_key_decode((uint16_t*)muprime, W);

    memcpy(pkh, sk_pkh, BYTES_PKHASH);
    memcpy(G2in_salt, salt, BYTES_SALT);
    shake(G2out, BYTES_SEED_SE + CRYPTO_BYTES, G2in, BYTES_PKHASH + BYTES_MU + BYTES_SALT);

    shake_input_seedSEprime[0] = 0x96;
    memcpy(&shake_input_seedSEprime[1], seedSEprime, BYTES_SEED_SE);
    shake((uint8_t*)Sp, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t), shake_input_seedSEprime, 1 + BYTES_SEED_SE);
    for (size_t i = 0; i < PARAMS_N * PARAMS_NBAR; i++) {
        Sp[i] = LE_TO_UINT16(Sp[i]);
    }
    frodo_sample_n(Sp, PARAMS_N*PARAMS_NBAR);
    frodo_mul_add_sa_plus_e(BBp_raw, Sp, E_zero, pk_seedA);
    for (size_t i = 0; i < PARAMS_N * PARAMS_NBAR; i++) {
        BBp_raw[i] &= frodo_q_mask_local();
    }
    if (frodo_quantize_dithered_local(BBp_split, BBp_raw, PARAMS_N*PARAMS_NBAR, salt, BYTES_SALT, DITHER_DOMAIN_U, PARAMS_U_LOGP) != 0) {
        return 1;
    }

    frodo_unpack(B_split, PARAMS_N*PARAMS_NBAR, pk_b, PK_PACKED_BYTES, PARAMS_PK_LOGP);
    if (frodo_reconstruct_dithered_local(B_norm, B_split, PARAMS_N*PARAMS_NBAR, pk_seedA, BYTES_SEED_A, DITHER_DOMAIN_PK, PARAMS_PK_LOGP) != 0) {
        return 1;
    }
    frodo_mul_add_sb_plus_e(CC, B_norm, Sp, E_zero_nbar);
    frodo_key_encode(W, (uint16_t*)muprime);
    frodo_add(CC, CC, W);
    if (frodo_quantize_dithered_local(CC_split, CC, PARAMS_NBAR*PARAMS_NBAR, salt, BYTES_SALT, DITHER_DOMAIN_V, PARAMS_V_LOGP) != 0) {
        return 1;
    }

    memcpy(Fin_ct, ct, CRYPTO_CIPHERTEXTBYTES);

    int8_t selector = ct_verify(Bp_split, BBp_split, PARAMS_N*PARAMS_NBAR) | ct_verify(C_split, CC_split, PARAMS_NBAR*PARAMS_NBAR);
    ct_select((uint8_t*)Fin_k, (uint8_t*)kprime, (uint8_t*)sk_s, CRYPTO_BYTES, selector);
    shake(ss, CRYPTO_BYTES, Fin, CRYPTO_CIPHERTEXTBYTES + CRYPTO_BYTES);

    clear_bytes((uint8_t *)B_norm, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)Bp_norm, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)BBp_raw, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)BBp_split, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)W, PARAMS_NBAR*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)C_norm, PARAMS_NBAR*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)CC, PARAMS_NBAR*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)CC_split, PARAMS_NBAR*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)Sp, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes((uint8_t *)S, PARAMS_N*PARAMS_NBAR*sizeof(uint16_t));
    clear_bytes(muprime, BYTES_MU);
    clear_bytes(G2out, BYTES_SEED_SE + CRYPTO_BYTES);
    clear_bytes(Fin_k, CRYPTO_BYTES);
    clear_bytes(shake_input_seedSEprime, 1 + BYTES_SEED_SE);
#ifdef DO_VALGRIND_CHECK
    VALGRIND_MAKE_MEM_DEFINED(sk, CRYPTO_SECRETKEYBYTES);
    VALGRIND_MAKE_MEM_DEFINED(ct, CRYPTO_CIPHERTEXTBYTES);
#endif
    return 0;
}
