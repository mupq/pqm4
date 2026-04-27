#include "mlwq.h"
#include "poly.h"
#include "ntt.h"
#include "xof.h"
#include "fips202.h"
#include "random.h"
#include <string.h>
#include <stdio.h>

// -------------------------------------------------------------------------
// CBD Logic (Centered Binomial Distribution)
// -------------------------------------------------------------------------
// Helper: Load 3 bytes into a 24-bit integer
static inline uint32_t load24_littleendian(const uint8_t x[3]) {
    return (uint32_t)x[0] | ((uint32_t)x[1] << 8) | ((uint32_t)x[2] << 16);
}

// CBD3: Eta = 3 (aligned with MLWQ_ETA1 = 3 in params.h)
// Input: 3 bytes (24 bits) -> Output: 4 coefficients
static void cbd3(poly *r, const uint8_t buf[3*MLWQ_N/4]) {
    unsigned int i, j;
    uint32_t t, d;
    int16_t a, b;

    for(i=0; i<MLWQ_N/4; i++) {
        t = load24_littleendian(buf+3*i);
        d = t & 0x00249249;
        d += (t>>1) & 0x00249249;
        d += (t>>2) & 0x00249249;

        for(j=0; j<4; j++) {
            a = (d >> (6*j+0)) & 0x7;
            b = (d >> (6*j+3)) & 0x7;
            r->coeffs[4*i+j] = a - b;
        }
    }
}

// Generate noise polynomial from seed and nonce
// Used for secret key 's' and encryption noise 'r'
static void poly_getnoise_eta1(poly *r, const uint8_t *seed, uint8_t nonce) {
    uint8_t buf[MLWQ_ETA1*MLWQ_N/4]; // 3 * 64 = 192 bytes
    uint8_t extseed[33];
    
    memcpy(extseed, seed, 32);
    extseed[32] = nonce;
    
    // Use SHAKE256 for PRF (Standard Kyber practice)
    shake128(buf, sizeof(buf), extseed, 33);
    
    cbd3(r, buf);
}

// -------------------------------------------------------------------------
// Core Logic
// -------------------------------------------------------------------------

void ref_mlwq_keygen(mlwq_pk *pk, mlwq_sk *sk, const uint8_t *seed_A, const uint8_t *seed_d) {
    poly_matrix A;
    ref_xof_expand_matrix(&A, seed_A);
    
    // print_debug("Matrix A[0][0]", A.row[0].vec[0].coeffs, 8);

    // [CHANGE] Use CBD for secret s
    // 使用私有噪声种子，避免与公开 seed_d 绑定
    uint8_t seed_s[32];
    random_bytes(seed_s, 32);
    // We use nonces 0 to K-1 for s
    for(int i=0; i<MLWQ_K; i++) {
        poly_getnoise_eta1(&sk->s.vec[i], seed_s, i);
    }
    
    // Generate dither d_pk
    // Use seed_d with a domain separator (e.g., nonce = K) or just extend logic
    // Here we strictly follow the previous logic: expand uniform
    // Note: In real Kyber, e is also CBD, but M-LWQ uses uniform dither. 
    // We keep dither uniform as per M-LWQ spec.
    poly_vec d_pk;
    uint8_t d_uniform_seed[33];
    memcpy(d_uniform_seed, seed_d, 32); 
    d_uniform_seed[32] = 0xFF; // Domain separator to avoid collision with s
    ref_xof_expand_poly_vec(&d_pk, d_uniform_seed, MLWQ_Q / P_PK);
    
    // print_debug("Secret s[0]", sk->s.vec[0].coeffs, 8);

    poly_vec As;
    ref_poly_matrix_vec_mul(&As, &A, &sk->s);
    
    // print_debug("Result As[0]", As.vec[0].coeffs, 8);

    memcpy(pk->seed_A, seed_A, 32);
    memcpy(pk->seed_d, seed_d, 32);
    
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
        poly_getnoise_eta1(&r.vec[i], seed_ct, i);
    }
    
    // Generate Dithers (Uniform)
    poly_vec d_u;
    poly d_v;
    uint8_t d_seed[33];
    memcpy(d_seed, seed_ct, 32); 
    
    // d_u (Nonce domain separation)
    d_seed[32] = 10; 
    ref_xof_expand_poly_vec(&d_u, d_seed, MLWQ_Q / P_U);
    
    // d_v (Manually expanding 1 poly)
    d_seed[32] = 11; 
    uint8_t buf[MLWQ_N*2];
    shake128(buf, sizeof(buf), d_seed, 33);
    int32_t mod_v = MLWQ_Q / P_V;
    for(int k=0; k<MLWQ_N; ++k) {
        uint16_t val = (uint16_t)buf[2*k] | ((uint16_t)buf[2*k+1]<<8);
        d_v.coeffs[k] = val % mod_v;
    }

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
    uint8_t seed_A[32], seed_d[32];
    random_bytes(seed_A, 32);
    random_bytes(seed_d, 32);

    ref_mlwq_keygen(pk, &sk->pke_sk, seed_A, seed_d);

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
    uint8_t m[32];
    random_bytes(m, 32);

    /* Pack pk into its canonical representation and hash with SHAKE128.
     * Consistent with ref_mlwq_kem_keygen and crypto_kem_enc. */
    uint8_t pk_bytes[MLWQ_PUBLICKEYBYTES];
    for (int i = 0; i < MLWQ_K; i++)
        ref_poly_tobytes(pk_bytes + i * MLWQ_POLYBYTES, &pk->b_q.vec[i]);
    memcpy(pk_bytes + MLWQ_POLYVECBYTES, pk->seed_A, SEEDBYTES);

    uint8_t buf[64]; 
    memcpy(buf, m, 32);
    shake128(buf + 32, HASHBYTES, pk_bytes, MLWQ_PUBLICKEYBYTES); /* H(pk) */
    
    uint8_t kr[64];
    shake128(kr, 64, buf, 64);
    
    memcpy(ss, kr, 32);
    // kr+32 is used as the seed for noise 'r'
    ref_mlwq_encrypt(ct, pk, m, kr+32);
}

int ref_mlwq_kem_decaps(uint8_t *ss, const mlwq_kem_sk *sk, const mlwq_ciphertext *ct) {
    uint8_t m[32];
    ref_mlwq_decrypt(m, &sk->pke_sk, ct);
    
    uint8_t buf[64];
    memcpy(buf, m, 32);
    memcpy(buf+32, sk->h_pk, 32);
    
    uint8_t kr[64];
    shake128(kr, 64, buf, 64);
    
    mlwq_ciphertext ct_prime;
    memset(&ct_prime, 0, sizeof(mlwq_ciphertext));
    
    // Re-encrypt using recovered seed (kr+32)
    ref_mlwq_encrypt(&ct_prime, &sk->pk, m, kr+32);
    
    // Check equality
    if(memcmp(ct, &ct_prime, sizeof(mlwq_ciphertext)) == 0) {
        memcpy(ss, kr, 32);
        return 1;
    } else {
        // Implicit rejection
        shake128(ss, 32, sk->z, 32); // Input z should probably absorb ct too in robust impl
        return 0;
    }
}