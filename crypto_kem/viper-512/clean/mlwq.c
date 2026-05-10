#include "mlwq.h"
#include "poly.h"
#include "ntt.h"
#include "xof.h"
#include "fips202.h"
#include "random.h"
#include <string.h>
#include <stdio.h>

static void derive_seed_d(uint8_t *seed_d, const uint8_t *seed_a) {
    uint8_t input[33];
    memcpy(input, seed_a, 32);
    input[32] = 0x01;
    shake128(seed_d, 32, input, sizeof(input));
}

// -------------------------------------------------------------------------
// Core Logic
// -------------------------------------------------------------------------

void ref_mlwq_keygen(mlwq_pk *pk, mlwq_sk *sk, const uint8_t *seed_A) {
    poly_matrix A;
    ref_xof_expand_matrix(&A, seed_A);
    
    // print_debug("Matrix A[0][0]", A.row[0].vec[0].coeffs, 8);

    // [CHANGE] Use CBD for secret s
    // 使用私有噪声种子，避免与公开 seed_d 绑定
    uint8_t seed_s[32];
    random_bytes(seed_s, 32);
    // We use nonces 0 to K-1 for s
    for(int i=0; i<MLWQ_K; i++) {
        ref_poly_getnoise_eta1(&sk->s.vec[i], seed_s, (uint8_t)i);
    }
    
    // Generate dither d_pk
    // Use seed_d with a domain separator (e.g., nonce = K) or just extend logic
    // Here we strictly follow the previous logic: expand uniform
    // Note: In real Kyber, e is also CBD, but M-LWQ uses uniform dither. 
    // We keep dither uniform as per M-LWQ spec.
    poly_vec d_pk;
    uint8_t d_uniform_seed[33];
    uint8_t d_seed[32];
    derive_seed_d(d_seed, seed_A);
    memcpy(d_uniform_seed, d_seed, 32);
    d_uniform_seed[32] = 0xFF; // Domain separator to avoid collision with s
    ref_xof_expand_poly_vec(&d_pk, d_uniform_seed, MLWQ_Q);
    
    // print_debug("Secret s[0]", sk->s.vec[0].coeffs, 8);

    poly_vec As;
    ref_poly_matrix_vec_mul(&As, &A, &sk->s);
    
    // print_debug("Result As[0]", As.vec[0].coeffs, 8);

    memcpy(pk->seed_A, seed_A, 32);
    memcpy(pk->seed_d, d_seed, 32);
    
    for(int i=0; i<MLWQ_K; ++i)
        ref_poly_quantize(&pk->b_q.vec[i], &As.vec[i], &d_pk.vec[i], P_PK);
}

void ref_mlwq_encrypt(mlwq_ciphertext *ct, const mlwq_pk *pk, const uint8_t *msg, const uint8_t *seed_ct) {
    poly_matrix A;
    ref_xof_expand_matrix(&A, pk->seed_A);
    
    poly_vec r;
    // [CHANGE] Use CBD for encryption noise r
    // This matches the security strength of the secret key
    for(int i=0; i<MLWQ_K; i++) {
        ref_poly_getnoise_eta_r(&r.vec[i], seed_ct, (uint8_t)i);
    }
    
    // Generate Dithers (Uniform)
    poly_vec d_u;
    poly d_v;
    uint8_t d_seed[33];
    memcpy(d_seed, seed_ct, 32); 
    
    // d_u (Nonce domain separation)
    d_seed[32] = 10; 
    ref_xof_expand_poly_vec(&d_u, d_seed, MLWQ_Q);
    
    // d_v (Single poly expansion)
    d_seed[32] = 11;
    ref_xof_expand_poly(&d_v, d_seed, MLWQ_Q);

    poly_matrix At;
    for(int i=0; i<MLWQ_K; ++i) for(int j=0; j<MLWQ_K; ++j) At.row[i].vec[j] = A.row[j].vec[i];
    
    poly_vec Atr;
    ref_poly_matrix_vec_mul(&Atr, &At, &r);
    
    poly_vec b_deq;
    for(int i=0; i<MLWQ_K; ++i) ref_poly_dequantize(&b_deq.vec[i], &pk->b_q.vec[i], P_PK);
    
    poly v_val;
    ref_poly_vec_transpose_mul(&v_val, &b_deq, &r);
    
    poly m_poly;
    ref_poly_msg_encode(&m_poly, msg);
    
    poly v_final;
    ref_poly_add(&v_final, &v_val, &m_poly);
    
    for(int i=0; i<MLWQ_K; ++i) ref_poly_quantize(&ct->u.vec[i], &Atr.vec[i], &d_u.vec[i], P_U);
    ref_poly_quantize(&ct->v, &v_final, &d_v, P_V);
    
}

void ref_mlwq_decrypt(uint8_t *msg, const mlwq_sk *sk, const mlwq_ciphertext *ct) {
    poly_vec u_deq;
    for(int i=0; i<MLWQ_K; ++i) ref_poly_dequantize(&u_deq.vec[i], &ct->u.vec[i], P_U);
    
    poly v_deq;
    ref_poly_dequantize(&v_deq, &ct->v, P_V);
    
    poly s_t_u;
    ref_poly_vec_transpose_mul(&s_t_u, &sk->s, &u_deq);
    
    poly diff;
    ref_poly_sub(&diff, &v_deq, &s_t_u);
    
    ref_poly_msg_decode(msg, &diff);
}

// -------------------------------------------------------------------------
// Wrapper code (KEM)
// -------------------------------------------------------------------------

void ref_mlwq_kem_keygen(mlwq_pk *pk, mlwq_kem_sk *sk) {
    memset(pk, 0, sizeof(mlwq_pk));
    uint8_t seed_A[32];
    random_bytes(seed_A, 32);

    // memset(seed_A,0,32);
    // memset(seed_d,0,32);

    ref_mlwq_keygen(pk, &sk->pke_sk, seed_A);
    
    sk->pk = *pk; 

    /* H(pk): hash the canonical packed representation with SHAKE128.
     * Must match what ref_mlwq_kem_encaps and crypto_kem_enc compute. */
     uint8_t pk_bytes[MLWQ_PUBLICKEYBYTES];
     for (int i = 0; i < MLWQ_K; i++)
         ref_poly_tobytes(pk_bytes + i * MLWQ_POLYBYTES, &pk->b_q.vec[i]);
     memcpy(pk_bytes + MLWQ_POLYVECBYTES, pk->seed_A, SEEDBYTES);
     shake128(sk->h_pk, HASHBYTES, pk_bytes, MLWQ_PUBLICKEYBYTES);
 
     random_bytes(sk->z, 32);
}

void ref_mlwq_kem_encaps(mlwq_ciphertext *ct, uint8_t *ss, const mlwq_pk *pk) {
    memset(ct, 0, sizeof(mlwq_ciphertext));
    uint8_t m[MU_BYTES];
    random_bytes(m, MU_BYTES);

    /* Pack pk into its canonical representation and hash with SHAKE128.
     * Consistent with ref_mlwq_kem_keygen and crypto_kem_enc. */
     uint8_t pk_bytes[MLWQ_PUBLICKEYBYTES];
     for (int i = 0; i < MLWQ_K; i++)
         ref_poly_tobytes(pk_bytes + i * MLWQ_POLYBYTES, &pk->b_q.vec[i]);
     memcpy(pk_bytes + MLWQ_POLYVECBYTES, pk->seed_A, SEEDBYTES);

    uint8_t buf[2 * MU_BYTES];
    memcpy(buf, m, MU_BYTES);
    shake128(buf + MU_BYTES, MU_BYTES, pk_bytes, MLWQ_PUBLICKEYBYTES); // H(pk)

    uint8_t kr[MLWQ_SSBYTES + SEEDBYTES];
    shake128(kr, sizeof(kr), buf, sizeof(buf));

    memcpy(ss, kr, MLWQ_SSBYTES);
    ref_mlwq_encrypt(ct, pk, m, kr + MLWQ_SSBYTES);
}

int ref_mlwq_kem_decaps(uint8_t *ss, const mlwq_kem_sk *sk, const mlwq_ciphertext *ct) {
    uint8_t m[MU_BYTES];
    ref_mlwq_decrypt(m, &sk->pke_sk, ct);

    uint8_t buf[2 * MU_BYTES];
    memcpy(buf, m, MU_BYTES);
    shake128(buf + MU_BYTES, MU_BYTES, (uint8_t*)&sk->pk, sizeof(mlwq_pk));

    uint8_t kr[MLWQ_SSBYTES + SEEDBYTES];
    shake128(kr, sizeof(kr), buf, sizeof(buf));
    
    mlwq_ciphertext ct_prime;
    memset(&ct_prime, 0, sizeof(mlwq_ciphertext));
    
    // Re-encrypt using recovered seed (kr+32)
    ref_mlwq_encrypt(&ct_prime, &sk->pk, m, kr + MLWQ_SSBYTES);
    
    // Check equality
    if(memcmp(ct, &ct_prime, sizeof(mlwq_ciphertext)) == 0) {
        memcpy(ss, kr, MLWQ_SSBYTES);
        return 1;
    } else {
        // Implicit rejection
        shake128(ss, MLWQ_SSBYTES, sk->z, SEEDBYTES); // Input z should probably absorb ct too in robust impl
        return 0;
    }
}