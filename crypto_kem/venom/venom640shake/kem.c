/********************************************************************************************
* FrodoKEM: Learning with Errors Key Encapsulation
*
* Abstract: Key Encapsulation Mechanism (KEM) based on Frodo
*********************************************************************************************/

#include <stdint.h>
#include <string.h>

#include "fips202.h"
#include "randombytes.h"

#include "api.h"
#include "common.h"
#include "params.h"

#define DITHER_DOMAIN_PK 0xA1
#define DITHER_DOMAIN_U  0xB1
#define DITHER_DOMAIN_V  0xC1
#define DITHER_BLOCK_WORDS 128

#define PK_PACKED_BYTES ((PARAMS_PK_LOGP * PARAMS_N * PARAMS_NBAR) / 8)
#define CT_C1_PACKED_BYTES ((PARAMS_U_LOGP * PARAMS_N * PARAMS_NBAR) / 8)
#define CT_C2_PACKED_BYTES ((PARAMS_V_LOGP * PARAMS_NBAR * PARAMS_NBAR) / 8)

static inline uint16_t q_mask_local(void)
{
    return (uint16_t)((1u << PARAMS_LOGQ) - 1u);
}

static inline uint16_t p_mask_local(unsigned int logp)
{
    return (uint16_t)((1u << logp) - 1u);
}

static inline uint16_t reconstruct_local(uint16_t x, unsigned int logp)
{
    return (uint16_t)((x & p_mask_local(logp)) << (PARAMS_LOGQ - logp));
}

static inline uint16_t quantize_local(uint16_t x, uint16_t d, unsigned int logp)
{
    const unsigned int shift = PARAMS_LOGQ - logp;
    uint32_t z = ((uint32_t)x & q_mask_local()) + ((uint32_t)d & ((1u << shift) - 1u));

    z &= q_mask_local();
    z = (z + (1u << (shift - 1))) >> shift;
    return (uint16_t)(z & p_mask_local(logp));
}

static void dither_init_stream(shake128incctx *state, const uint8_t *seed, size_t seedlen, uint8_t domain)
{
    uint8_t in[1 + BYTES_SEED_A + BYTES_SALT] = {0};

    in[0] = domain;
    memcpy(&in[1], seed, seedlen);
    shake128_inc_init(state);
    shake128_inc_absorb(state, in, 1 + seedlen);
    shake128_inc_finalize(state);
    clear_bytes(in, sizeof(in));
}

static void quantize_dithered_local(uint16_t *out, const uint16_t *in, size_t n, const uint8_t *seed, size_t seedlen, uint8_t domain, unsigned int logp)
{
    const unsigned int shift = PARAMS_LOGQ - logp;
    const uint16_t mask = (uint16_t)((1u << shift) - 1u);
    uint16_t d[DITHER_BLOCK_WORDS] = {0};
    shake128incctx state;
    size_t offset = 0;

    dither_init_stream(&state, seed, seedlen, domain);
    while (offset < n) {
        size_t take = n - offset;
        if (take > DITHER_BLOCK_WORDS) {
            take = DITHER_BLOCK_WORDS;
        }

        shake128_inc_squeeze((uint8_t *)d, take * sizeof(uint16_t), &state);
        for (size_t i = 0; i < take; i++) {
            uint16_t di = LE_TO_UINT16(d[i]) & mask;
            out[offset + i] = quantize_local(in[offset + i], di, logp);
        }
        offset += take;
    }

    clear_bytes((uint8_t *)d, sizeof(d));
    clear_bytes((uint8_t *)&state, sizeof(state));
}

static void reconstruct_dithered_local(uint16_t *normal, const uint16_t *split, size_t n, const uint8_t *seed, size_t seedlen, uint8_t domain, unsigned int logp)
{
    const unsigned int shift = PARAMS_LOGQ - logp;
    const uint16_t mask = (uint16_t)((1u << shift) - 1u);
    uint16_t d[DITHER_BLOCK_WORDS] = {0};
    shake128incctx state;
    size_t offset = 0;

    dither_init_stream(&state, seed, seedlen, domain);
    while (offset < n) {
        size_t take = n - offset;
        if (take > DITHER_BLOCK_WORDS) {
            take = DITHER_BLOCK_WORDS;
        }

        shake128_inc_squeeze((uint8_t *)d, take * sizeof(uint16_t), &state);
        for (size_t i = 0; i < take; i++) {
            uint16_t di = LE_TO_UINT16(d[i]) & mask;
            normal[offset + i] = (uint16_t)((reconstruct_local(split[offset + i], logp) - di) & q_mask_local());
        }
        offset += take;
    }

    clear_bytes((uint8_t *)d, sizeof(d));
    clear_bytes((uint8_t *)&state, sizeof(state));
}


int crypto_kem_keypair(uint8_t *pk, uint8_t *sk) {
    // Venom key generation based on Frodo flow
    uint8_t *pk_seedA = &pk[0];
    uint8_t *pk_b = &pk[BYTES_SEED_A];
    uint8_t *sk_s = &sk[0];
    uint8_t *sk_pk = &sk[CRYPTO_BYTES];
    uint8_t *sk_S = &sk[CRYPTO_BYTES + CRYPTO_PUBLICKEYBYTES];
    uint8_t *sk_pkh = &sk[CRYPTO_BYTES + CRYPTO_PUBLICKEYBYTES + 2 * PARAMS_N * PARAMS_NBAR];
    uint16_t B[PARAMS_N * PARAMS_NBAR] = {0};
    uint16_t S[PARAMS_N * PARAMS_NBAR] = {0};            // contains secret data
    uint8_t randomness[CRYPTO_BYTES + BYTES_SEED_SE + BYTES_SEED_A]; // contains secret data via randomness_s and randomness_seedSE
    uint8_t *randomness_s = &randomness[0];              // contains secret data
    uint8_t *randomness_seedSE = &randomness[CRYPTO_BYTES]; // contains secret data
    uint8_t *randomness_z = &randomness[CRYPTO_BYTES + BYTES_SEED_SE];
    uint8_t shake_input_seedSE[1 + BYTES_SEED_SE];       // contains secret data

    if (randombytes(randomness, sizeof(randomness)) != 0) {
        return 1;
    }
    shake(pk_seedA, BYTES_SEED_A, randomness_z, BYTES_SEED_A);

    shake_input_seedSE[0] = 0x5F;
    memcpy(&shake_input_seedSE[1], randomness_seedSE, BYTES_SEED_SE);

    shake128incctx state;
    shake128_inc_init(&state);
    shake128_inc_absorb(&state, shake_input_seedSE, 1 + BYTES_SEED_SE);
    shake128_inc_finalize(&state);
    shake128_inc_squeeze((uint8_t *)S, PARAMS_N * PARAMS_NBAR * sizeof(uint16_t), &state);

    sample_n(S, PARAMS_N * PARAMS_NBAR);
    memset(B, 0, sizeof(B));
    mul_add_as_plus_e(B, S, pk_seedA);
    quantize_dithered_local(B, B, PARAMS_N * PARAMS_NBAR, pk_seedA, BYTES_SEED_A, DITHER_DOMAIN_PK, PARAMS_PK_LOGP);

    pack(pk_b, PK_PACKED_BYTES, B, PARAMS_N * PARAMS_NBAR, PARAMS_PK_LOGP);

    memcpy(sk_s, randomness_s, CRYPTO_BYTES);
    memcpy(sk_pk, pk, CRYPTO_PUBLICKEYBYTES);
    for (size_t i = 0; i < PARAMS_N * PARAMS_NBAR; i++) {
        S[i] = UINT16_TO_LE(S[i]);
    }
    memcpy(sk_S, S, 2 * PARAMS_N * PARAMS_NBAR);

    shake(sk_pkh, BYTES_PKHASH, pk, CRYPTO_PUBLICKEYBYTES);

    // Cleanup:
    clear_bytes((uint8_t *)B, sizeof(B));
    clear_bytes((uint8_t *)S, sizeof(S));
    clear_bytes(randomness, CRYPTO_BYTES + BYTES_SEED_SE);
    clear_bytes(shake_input_seedSE, sizeof(shake_input_seedSE));
    clear_bytes((uint8_t *)&state, sizeof(state));
    return 0;
}


int crypto_kem_enc(uint8_t *ct, uint8_t *ss, const uint8_t *pk) {
    // Venom key encapsulation based on Frodo flow
    const uint8_t *pk_seedA = &pk[0];
    const uint8_t *pk_b = &pk[BYTES_SEED_A];
    uint8_t *ct_c1 = &ct[0];
    uint8_t *ct_c2 = &ct[CT_C1_PACKED_BYTES];
    uint16_t B[PARAMS_N * PARAMS_NBAR] = {0};
    uint16_t V[PARAMS_NBAR * PARAMS_NBAR] = {0};               // contains secret data
    uint16_t C[PARAMS_NBAR * PARAMS_NBAR] = {0};
    uint16_t Bp[PARAMS_N * PARAMS_NBAR] = {0};                 // contains secret data
    uint16_t Sp[PARAMS_N * PARAMS_NBAR] = {0};                 // contains secret data
    uint8_t G2in[BYTES_PKHASH + BYTES_MU + BYTES_SALT];        // contains secret data via mu
    uint8_t *pkh = &G2in[0];
    uint8_t *mu = &G2in[BYTES_PKHASH];                         // contains secret data
    uint8_t *salt = &G2in[BYTES_PKHASH + BYTES_MU];
    uint8_t G2out[BYTES_SEED_SE + CRYPTO_BYTES];               // contains secret data
    uint8_t *seedSE = &G2out[0];                               // contains secret data
    uint8_t *k = &G2out[BYTES_SEED_SE];                        // contains secret data
    uint8_t Fin[CRYPTO_CIPHERTEXTBYTES + CRYPTO_BYTES];        // contains secret data via Fin_k
    uint8_t *Fin_ct = &Fin[0];
    uint8_t *Fin_k = &Fin[CRYPTO_CIPHERTEXTBYTES];             // contains secret data
    uint8_t shake_input_seedSE[1 + BYTES_SEED_SE];             // contains secret data

    shake(pkh, BYTES_PKHASH, pk, CRYPTO_PUBLICKEYBYTES);
    if (randombytes(mu, BYTES_MU + BYTES_SALT) != 0) {
        return 1;
    }
    shake(G2out, BYTES_SEED_SE + CRYPTO_BYTES, G2in, BYTES_PKHASH + BYTES_MU + BYTES_SALT);

    shake_input_seedSE[0] = 0x96;
    memcpy(&shake_input_seedSE[1], seedSE, BYTES_SEED_SE);

    shake128incctx state;
    shake128_inc_init(&state);
    shake128_inc_absorb(&state, shake_input_seedSE, 1 + BYTES_SEED_SE);
    shake128_inc_finalize(&state);
    shake128_inc_squeeze((uint8_t *)Sp, PARAMS_N * PARAMS_NBAR * sizeof(uint16_t), &state);

    sample_n(Sp, PARAMS_N * PARAMS_NBAR);
    memset(Bp, 0, sizeof(Bp));
    mul_add_sa_plus_e(Bp, Sp, pk_seedA);
    for (size_t i = 0; i < PARAMS_N * PARAMS_NBAR; i++) {
        Bp[i] &= q_mask_local();
    }
    quantize_dithered_local(Bp, Bp, PARAMS_N * PARAMS_NBAR, salt, BYTES_SALT, DITHER_DOMAIN_U, PARAMS_U_LOGP);
    pack(ct_c1, CT_C1_PACKED_BYTES, Bp, PARAMS_N * PARAMS_NBAR, PARAMS_U_LOGP);

    unpack(B, PARAMS_N * PARAMS_NBAR, pk_b, PK_PACKED_BYTES, PARAMS_PK_LOGP);
    reconstruct_dithered_local(B, B, PARAMS_N * PARAMS_NBAR, pk_seedA, BYTES_SEED_A, DITHER_DOMAIN_PK, PARAMS_PK_LOGP);
    memset(V, 0, sizeof(V));
    mul_add_sb_plus_e(V, B, Sp);

    key_encode(C, (uint16_t *)mu);
    add(C, V, C);
    quantize_dithered_local(C, C, PARAMS_NBAR * PARAMS_NBAR, salt, BYTES_SALT, DITHER_DOMAIN_V, PARAMS_V_LOGP);
    pack(ct_c2, CT_C2_PACKED_BYTES, C, PARAMS_NBAR * PARAMS_NBAR, PARAMS_V_LOGP);

    memcpy(&ct[CRYPTO_CIPHERTEXTBYTES - BYTES_SALT], salt, BYTES_SALT);

    memcpy(Fin_ct, ct, CRYPTO_CIPHERTEXTBYTES);
    memcpy(Fin_k, k, CRYPTO_BYTES);
    shake(ss, CRYPTO_BYTES, Fin, CRYPTO_CIPHERTEXTBYTES + CRYPTO_BYTES);

    // Cleanup:
    clear_bytes((uint8_t *)V, sizeof(V));
    clear_bytes((uint8_t *)Sp, sizeof(Sp));
    clear_bytes(mu, BYTES_MU);
    clear_bytes(G2out, sizeof(G2out));
    clear_bytes(Fin_k, CRYPTO_BYTES);
    clear_bytes(shake_input_seedSE, sizeof(shake_input_seedSE));
    clear_bytes((uint8_t *)&state, sizeof(state));
    clear_bytes((uint8_t *)B, sizeof(B));
    clear_bytes((uint8_t *)C, sizeof(C));
    clear_bytes((uint8_t *)Bp, sizeof(Bp));
    return 0;
}


int crypto_kem_dec(uint8_t *ss, const uint8_t *ct, const uint8_t *sk) {
    // Venom key decapsulation based on Frodo flow
    uint16_t B[PARAMS_N * PARAMS_NBAR] = {0};
    uint16_t Bp[PARAMS_N * PARAMS_NBAR] = {0};
    uint16_t W[PARAMS_NBAR * PARAMS_NBAR] = {0};               // contains secret data
    uint16_t C[PARAMS_NBAR * PARAMS_NBAR] = {0};
    uint16_t C_check[PARAMS_NBAR * PARAMS_NBAR] = {0};
    uint16_t Bp_check[PARAMS_N * PARAMS_NBAR] = {0};
    uint16_t Sp[PARAMS_N * PARAMS_NBAR] = {0};                 // contains secret data
    const uint8_t *ct_c1 = &ct[0];
    const uint8_t *ct_c2 = &ct[CT_C1_PACKED_BYTES];
    const uint8_t *ct_salt = &ct[CRYPTO_CIPHERTEXTBYTES - BYTES_SALT];
    const uint8_t *sk_s = &sk[0];
    const uint8_t *sk_pk = &sk[CRYPTO_BYTES];
    const uint16_t *sk_S = (uint16_t *) &sk[CRYPTO_BYTES + CRYPTO_PUBLICKEYBYTES];
    uint16_t S[PARAMS_N * PARAMS_NBAR];                        // contains secret data
    const uint8_t *sk_pkh = &sk[CRYPTO_BYTES + CRYPTO_PUBLICKEYBYTES + 2 * PARAMS_N * PARAMS_NBAR];
    const uint8_t *pk_seedA = &sk_pk[0];
    const uint8_t *pk_b = &sk_pk[BYTES_SEED_A];
    uint8_t G2in[BYTES_PKHASH + BYTES_MU + BYTES_SALT];        // contains secret data via muprime
    uint8_t *pkh = &G2in[0];
    uint8_t *muprime = &G2in[BYTES_PKHASH];                    // contains secret data
    uint8_t *G2in_salt = &G2in[BYTES_PKHASH + BYTES_MU];
    uint8_t G2out[BYTES_SEED_SE + CRYPTO_BYTES];               // contains secret data
    uint8_t *seedSEprime = &G2out[0];                          // contains secret data
    uint8_t *kprime = &G2out[BYTES_SEED_SE];                   // contains secret data
    uint8_t Fin[CRYPTO_CIPHERTEXTBYTES + CRYPTO_BYTES];        // contains secret data via Fin_k
    uint8_t *Fin_ct = &Fin[0];
    uint8_t *Fin_k = &Fin[CRYPTO_CIPHERTEXTBYTES];             // contains secret data
    uint8_t shake_input_seedSEprime[1 + BYTES_SEED_SE];        // contains secret data

    for (size_t i = 0; i < PARAMS_N * PARAMS_NBAR; i++) {
        S[i] = LE_TO_UINT16(sk_S[i]);
    }

    // Compute W = C - Bp*S (mod q), and decode mu'
    unpack(Bp, PARAMS_N * PARAMS_NBAR, ct_c1, CT_C1_PACKED_BYTES, PARAMS_U_LOGP);
    unpack(C, PARAMS_NBAR * PARAMS_NBAR, ct_c2, CT_C2_PACKED_BYTES, PARAMS_V_LOGP);
    reconstruct_dithered_local(Bp_check, Bp, PARAMS_N * PARAMS_NBAR, ct_salt, BYTES_SALT, DITHER_DOMAIN_U, PARAMS_U_LOGP);
    reconstruct_dithered_local(C_check, C, PARAMS_NBAR * PARAMS_NBAR, ct_salt, BYTES_SALT, DITHER_DOMAIN_V, PARAMS_V_LOGP);
    mul_bs(W, Bp_check, S);
    sub(W, C_check, W);
    key_decode((uint16_t *)muprime, W);

    // Generate (seedSE' || k') = G_2(pkh || mu' || salt)
    memcpy(pkh, sk_pkh, BYTES_PKHASH);
    memcpy(G2in_salt, ct_salt, BYTES_SALT);
    shake(G2out, BYTES_SEED_SE + CRYPTO_BYTES, G2in, BYTES_PKHASH + BYTES_MU + BYTES_SALT);

    // Recompute Bp and C in split domain
    shake_input_seedSEprime[0] = 0x96;
    memcpy(&shake_input_seedSEprime[1], seedSEprime, BYTES_SEED_SE);

    shake128incctx state;
    shake128_inc_init(&state);
    shake128_inc_absorb(&state, shake_input_seedSEprime, 1 + BYTES_SEED_SE);
    shake128_inc_finalize(&state);
    shake128_inc_squeeze((uint8_t *)Sp, PARAMS_N * PARAMS_NBAR * sizeof(uint16_t), &state);

    sample_n(Sp, PARAMS_N * PARAMS_NBAR);
    memset(Bp_check, 0, sizeof(Bp_check));
    mul_add_sa_plus_e(Bp_check, Sp, pk_seedA);
    for (size_t i = 0; i < PARAMS_N * PARAMS_NBAR; i++) {
        Bp_check[i] &= q_mask_local();
    }
    quantize_dithered_local(Bp_check, Bp_check, PARAMS_N * PARAMS_NBAR, ct_salt, BYTES_SALT, DITHER_DOMAIN_U, PARAMS_U_LOGP);

    memset(C_check, 0, sizeof(C_check));
    unpack(B, PARAMS_N * PARAMS_NBAR, pk_b, PK_PACKED_BYTES, PARAMS_PK_LOGP);
    reconstruct_dithered_local(B, B, PARAMS_N * PARAMS_NBAR, pk_seedA, BYTES_SEED_A, DITHER_DOMAIN_PK, PARAMS_PK_LOGP);
    mul_add_sb_plus_e(C_check, B, Sp);
    key_encode(W, (uint16_t *)muprime);
    add(C_check, C_check, W);
    quantize_dithered_local(C_check, C_check, PARAMS_NBAR * PARAMS_NBAR, ct_salt, BYTES_SALT, DITHER_DOMAIN_V, PARAMS_V_LOGP);

    // Compute ss
    memcpy(Fin_ct, ct, CRYPTO_CIPHERTEXTBYTES);
    int8_t selector = ct_verify(Bp, Bp_check, PARAMS_N * PARAMS_NBAR) | ct_verify(C, C_check, PARAMS_NBAR * PARAMS_NBAR);
    ct_select((uint8_t *)Fin_k, (uint8_t *)kprime, (uint8_t *)sk_s, CRYPTO_BYTES, selector);
    shake(ss, CRYPTO_BYTES, Fin, CRYPTO_CIPHERTEXTBYTES + CRYPTO_BYTES);

    // Cleanup:
    clear_bytes((uint8_t *)W, sizeof(W));
    clear_bytes((uint8_t *)Sp, sizeof(Sp));
    clear_bytes((uint8_t *)S, sizeof(S));
    clear_bytes(muprime, BYTES_MU);
    clear_bytes(G2out, sizeof(G2out));
    clear_bytes(Fin_k, CRYPTO_BYTES);
    clear_bytes(shake_input_seedSEprime, sizeof(shake_input_seedSEprime));
    clear_bytes((uint8_t *)&state, sizeof(state));
    clear_bytes((uint8_t *)B, sizeof(B));
    clear_bytes((uint8_t *)Bp, sizeof(Bp));
    clear_bytes((uint8_t *)C, sizeof(C));
    clear_bytes((uint8_t *)C_check, sizeof(C_check));
    clear_bytes((uint8_t *)Bp_check, sizeof(Bp_check));
    return 0;
}