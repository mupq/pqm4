#include "sign.h"
#include "packing.h"
#include "params.h"
#include "poly.h"
#include "polyfix.h"
#include "polymat.h"
#include "polyvec.h"
#include "randombytes.h"
#include "symmetric.h"
#include "decompose.h"
#include <inttypes.h>
#include <stdint.h>
#include <string.h>
#include <stdio.h>


/*************************************************
 * Name:        generate_seed_from_one_source
 *
 * Description: Use SHAKE256 to generate a seed from one byte source.
 *
 * Arguments:   - uint8_t *seed:    pointer to buffer of seed to be generated
 *              - size_t seed_len:  desired length of the seed
 *              - uint8_t *src:    pointer to source to be absorbed
 *              - size_t src_len:  length of source
 * 
 * Returns void
 **************************************************/
static void generate_seed_from_one_source(uint8_t *seed, size_t seed_len, 
                                          const uint8_t *src, size_t src_len){
    xof256_state state;
    xof256_absorb_once(&state, src, src_len);
    xof256_squeeze(seed, seed_len, &state);
    return;
}

/*************************************************
 * Name:        generate_seed_from_two_sources
 *
 * Description: Use SHAKE256 to generate a seed from two byte sources.
 *
 * Arguments:   - uint8_t *seed:    pointer to buffer of seed to be generated
 *              - size_t seed_len:  desired length of the seed
 *              - uint8_t *src1:    pointer to first source to be absorbed
 *              - size_t src1_len:  length of first source
 *              - uint8_t *src2:    pointer to second source to be absorbed
 *              - size_t src2_len:  length of second source
 * 
 * Returns void
 **************************************************/
static void generate_seed_from_two_sources(uint8_t *seed, size_t seed_len, 
                                           const uint8_t *src1, size_t src1_len, 
                                           const uint8_t *src2, size_t src2_len){
    xof256_state state;
    xof256_absorb_twice(&state, src1, src1_len, src2, src2_len);
    xof256_squeeze(seed, seed_len, &state);
    return;
}

static inline uint16_t nonce_a(const size_t row){
    return (K << 8) + M + row;
}
static inline uint16_t nonce_A_gen(const size_t row, const size_t column){
    return (row << 8) + column;
}
static inline uint16_t nonce_s_gen(const size_t nonce_offset, const size_t column){
    return nonce_offset + column;
}
static inline uint16_t nonce_e_gen(const size_t nonce_offset, const size_t row){
    return nonce_offset + M + row;
}

static void pointwise_montgomery_by_A_gen_elem_frozen(poly *dest, 
                                const uMatrixPointerM_frozen agenptr, 
                                const size_t row, const size_t column, const poly *src){
#ifdef ENABLE_KEYPAIR_MATRIX_BUFFER
    poly_pointwise_montgomery_mixed(dest, &agenptr.vec[row].vec[column], src);
#else
    poly_frozen a_gen_elem;
    poly_uniform_frozen(&a_gen_elem, agenptr.seed, nonce_A_gen(row, column));
    poly_pointwise_montgomery_mixed(dest, &a_gen_elem, src);
#endif /* ENABLE_KEYPAIR_MATRIX_BUFFER */
}

// ###################################################################
// ###################################################################
// ###################################################################
// ###################################################################

/*************************************************
 * Name:        crypto_sign_keypair
 *
 * Description: Generates public and private key.
 *
 * Arguments:   - uint8_t *pk: pointer to output public key (allocated
 *                             array of CRYPTO_PUBLICKEYBYTES bytes)
 *              - uint8_t *sk: pointer to output private key (allocated
 *                             array of CRYPTO_SECRETKEYBYTES bytes)
 *
 * Returns 0 (success)
 **************************************************/

int crypto_sign_keypair(uint8_t *pk, uint8_t *sk) {
    uint8_t seedbuf[2 * SEEDBYTES + CRHBYTES] = {0};
    uint16_t nonce = 0;
    const uint8_t *rhoprime;
    const uint8_t *sigma;
    const uint8_t *key;
    polyvecm s_gen;
    polyveck e_gen;
    polyveck b;
    poly temp_poly;

#if D > 0
    polyveck a;
#endif
#ifdef ENABLE_KEYPAIR_MATRIX_BUFFER
    polyvecm_frozen A_gen[K];
    uMatrixPointerM_frozen A_gen_ptr = { .vec = A_gen };
#else
    uMatrixPointerM_frozen A_gen_ptr = { .seed = seedbuf };
#endif

    // Get entropy \rho
    randombytes(seedbuf, SEEDBYTES);
    // Sample seeds with entropy \rho
    generate_seed_from_one_source(seedbuf, 2 * SEEDBYTES + CRHBYTES, seedbuf, SEEDBYTES);

    rhoprime = seedbuf;
    sigma = rhoprime + SEEDBYTES;
    key = sigma + CRHBYTES;

#ifdef ENABLE_KEYPAIR_MATRIX_BUFFER
    // Expand Matrix A0 and vector a
    for (size_t row = 0; row < K; ++row){
        for (size_t column = 0; column < M; ++column){
            poly_uniform_frozen(&A_gen[row].vec[column], rhoprime, nonce_A_gen(row, column));
        }
    }
#endif

#if D > 0
    /**********************************************
     * If there is rounding (D > 0), we need another polyveck a.
     * Then, b = a + A0 * s_gen + e_gen and the lower D bits are
     * rounded from b. The lower D bits are subsequently
     * subtracted from e_gen.
     **********************************************/
    for (size_t row = 0; row < K; ++row){
        poly_uniform(&a.vec[row], rhoprime, nonce_a(row));
    }

reject:
    // Sample secret vectors s_gen and e_gen
    for (size_t column = 0; column < M; column++){
        poly_uniform_eta(&s_gen.vec[column], sigma, nonce_s_gen(nonce, column));
    }
    for (size_t row = 0; row < K; row++){
        poly_uniform_eta(&e_gen.vec[row], sigma, nonce_e_gen(nonce, row));
    }
    nonce += M + K;

    // b = a + A0 * s_gen + e_gen mod q
   {
        poly s_gen_hat_elem;
      
        // column 0
        s_gen_hat_elem = s_gen.vec[0];
        poly_ntt(&s_gen_hat_elem);
        for (size_t row = 0; row < K; row++){
            pointwise_montgomery_by_A_gen_elem_frozen(&b.vec[row], A_gen_ptr, row, 0, &s_gen_hat_elem); 
        }
        // columns 1 to M-1
        for (size_t column = 1; column < M; column++){
            s_gen_hat_elem = s_gen.vec[column];
            poly_ntt(&s_gen_hat_elem);
            for (size_t row = 0; row < K; row++){
                pointwise_montgomery_by_A_gen_elem_frozen(&temp_poly, A_gen_ptr, row, column, &s_gen_hat_elem); 
                poly_add(&b.vec[row], &b.vec[row], &temp_poly);
            }
        }
    }

    for (size_t row = 0; row < K; row++){
        poly *b_elem = &b.vec[row];
        poly *e_gen_elem = &e_gen.vec[row];

        poly_invntt_tomont(b_elem);
        poly_add(b_elem, b_elem, e_gen_elem);
        poly_add(b_elem, b_elem, &a.vec[row]);
        poly_freeze(b_elem);
        // round off D bits
        poly_decompose_vk(&temp_poly, b_elem);
        poly_sub(e_gen_elem, e_gen_elem, &temp_poly);
    }

    int64_t squared_singular_value = polyvecmk_sqsing_value(&s_gen, &e_gen);
    if (squared_singular_value > GAMMA * GAMMA * N) {
        goto reject;
    }
#else
    /**********************************************
     * If there is no rounding (D == 0), we store
     * -2b directly in NTT domain into the public key.
     **********************************************/
reject:
    // Sample secret vectors s_gen and e_gen
    // Sample secret vectors s_gen and e_gen
    for (size_t column = 0; column < M; column++){
        poly_uniform_eta(&s_gen.vec[column], sigma, nonce_s_gen(nonce, column));
    }
    for (size_t row = 0; row < K; row++){
        poly_uniform_eta(&e_gen.vec[row], sigma, nonce_e_gen(nonce, row));
    }
    nonce += M + K;

    int64_t squared_singular_value = polyvecmk_sqsing_value(&s_gen, &e_gen);
    if (squared_singular_value > GAMMA * GAMMA * N) {
        goto reject;
    }

    {
        // b = A0 * s_gen
        poly s_gen_hat_elem;

        // column 0
        s_gen_hat_elem = s_gen.vec[0];
        poly_ntt(&s_gen_hat_elem);
        for (size_t row = 0; row < K; row++){
            pointwise_montgomery_by_A_gen_elem_frozen(&b.vec[row], A_gen_ptr, row, 0, &s_gen_hat_elem);
        }
        // columns 1 to M-1
        for (size_t column = 1; column < M; column++){
            s_gen_hat_elem = s_gen.vec[column];
            poly_ntt(&s_gen_hat_elem);
            for (size_t row = 0; row < K; row++){
                pointwise_montgomery_by_A_gen_elem_frozen(&temp_poly, A_gen_ptr, row, column, &s_gen_hat_elem);
                poly_add(&b.vec[row], &b.vec[row], &temp_poly);
            }
        }
    }    

    // b += e_gen mod q
    for (size_t row = 0; row < K; row++){
        poly s2hat_elem;

        s2hat_elem = e_gen.vec[row];
        poly_ntt(&s2hat_elem);
        poly_frommont(&b.vec[row]);
        poly_add(&b.vec[row], &b.vec[row], &s2hat_elem);
        poly_double_negate(&b.vec[row]);        
        poly_caddq(&b.vec[row]);        
    }

#endif

    pack_pk(pk, &b, rhoprime);
    pack_sk(sk, pk, &s_gen, &e_gen, key);

    return 0;
}


// ###################################################################
// ###################################################################
// ###################################################################
// ###################################################################

/*************************************************
 * Name:        make_hint_veck
 *
 * Description: Make hint from z2, Ay and highbits(z2)
 *
 * Arguments:   - polyveck *h:          pointer to the hint
 *              - polyfixveck *z2:      pointer to z2
 *              - polyveck *Ay:         pointer to Ay
 *              - polyveck *highbits:   highbits(z2)
 *  
 * Returns void
 **************************************************/
static void make_hint_veck(polyveck *h, const polyfixveck *z2, const polyveck *Ay, const polyveck *highbits){
    poly z2rnd;// round of z2
    poly htmp; 

    for (size_t row = 0; row < K; row ++){
        // Round z2
        polyfix_round(&z2rnd, &z2->vec[row]);
        // recover htmp == A1 * round(z1) - qcj mod 2q
        poly_double(&z2rnd);
        poly_sub(&htmp, &Ay->vec[row], &z2rnd);
        poly_freeze2q(&htmp);

        // HighBits of (A * round(z) - qcj mod 2q) and (A1 * round(z1) - qcj mod 2q)
        poly_highbits_hint(&htmp, &htmp);
        poly_sub(&h->vec[row], &highbits->vec[row], &htmp);
        poly_caddDQ2ALPHA(&h->vec[row]);
    }
}

/*************************************************
 * Name:        decompose_z1_vecl
 *
 * Description: decompose z1 into LowBits and HighBits
 *
 * Arguments:   - polyvecl *lb_z1:  pointer to LowBits(z1) 
 *              - polyvecl *hb_z1:  pointer to HighBits(z1)
 *              - polyfixvecl *z1:  pointer to z1
 *  
 * Returns void
 **************************************************/
static void decompose_z1_vecl(polyvecl *lb_z1, polyvecl *hb_z1, const polyfixvecl *z1){
    poly z1rnd; // rounded polynomial of z1

    for (size_t column = 0; column < L; column++){
        polyfix_round(&z1rnd, &z1->vec[column]);
        poly_lowbits(&lb_z1->vec[column], &z1rnd);
        poly_highbits(&hb_z1->vec[column], &z1rnd);
    }
}

/*************************************************
 * Name:        compute_z_veckl
 *
 * Description: Compute z1 and z2, where z == (z1 || z2) is a candidate
 *              for the uncompressed signature.
 *
 * Arguments:   - polyfixvecl *z1:  part of the signature candidate
 *              - polyfixveck *z2:  part of the signature candidate
 *              - poly *c:          challenge polynomial
 *              - polyvecm *s1:     part of the secret key, NTT domain
 *              - polyveck *s2:     part of the secret key, NTT domain
 *              - polyfixvecl *y1:  part of the uniform samples from the hyperball
 *              - polyfixveck *y2:  part of the uniform samples from the hyperball
 *              - uint8_t b:        a random byte for bimodal selection using byte mask 0x01
 * 
 * Returns void
 **************************************************/
static void compute_z_veckl(polyfixvecl *z1, polyfixveck *z2, const poly *c, 
                            const polyvecm *s1, const polyveck *s2, 
                            const polyfixvecl *y1, const polyfixveck *y2, const uint8_t b){
    poly t;
    poly chat;

    // t = (c * s).vec[i] = (c * (1 || s1 || s2)).vec[i]
    // z = y + (-1)^b (c * s) = z1 || z2

    chat = *c;
    poly_ntt(&chat);

    // z1[0]
    t = *c;
    poly_cneg(&t, b & 1);
    polyfix_add(&z1->vec[0], &y1->vec[0], &t);

    // z1.vec[1..L-1]
    for (size_t column = 1; column < L; ++column) {
        poly_pointwise_montgomery(&t, &chat, &s1->vec[column - 1]);
        poly_invntt_tomont(&t);
        poly_cneg(&t, b & 1);
        polyfix_add(&z1->vec[column], &y1->vec[column], &t);
    }

    // z2.vec[0..K-1]
    for (size_t row = 0; row < K; row++) {
        poly_pointwise_montgomery(&t, &s2->vec[row], &chat);
        poly_invntt_tomont(&t);
        poly_cneg(&t, b & 1);
        polyfix_add(&z2->vec[row], &y2->vec[row], &t);
    }
};

/*************************************************
 * Name:        is_norm_of_z_geq_big_b_prime
 *
 * Description: Test whether norm(z) >= B'
 *
 * Arguments:   - polyfixvecl *z1:  part of the signature candidate
 *              - polyfixveck *z2:  part of the signature candidate
 *
 * Returns 0 if the test passed, 1 if the signature needs to be rejected.
 **************************************************/
static uint64_t is_norm_of_z_geq_big_b_prime(const polyfixvecl *z1, const polyfixveck *z2){
    uint64_t reject1;

    // reject if norm(z) >= B'
    reject1 = ((uint64_t)B1SQ * LN * LN - polyfixveclk_sqnorm2(z1, z2)) >> 63;
    reject1 &= 1;  // get the sign
    return reject1;
};

/*************************************************
 * Name:        is_rejected_in_intersection
 *
 * Description: In bimodal sampling the sample may lie in the intersection of both
 *              hyperballs of radius r', in which case the sample is rejected
 *              with a probability of 50%.
 *
 * Arguments:   - polyfixvecl *z1:  part of the signature candidate
 *              - polyfixveck *z2:  part of the signature candidate
 *              - polyfixvecl *y1:  part of the uniform samples from the hyperball
 *              - polyfixveck *y2:  part of the uniform samples from the hyperball
 *              - uint8_t b:        a random byte for rejection in the overlap
 *                                  region using byte mask 0x02
 *
 * Returns 0 if the test passed, 1 if the signature needs to be rejected.
 **************************************************/
static uint64_t is_rejected_in_intersection(const polyfixvecl *z1, const polyfixveck *z2, const polyfixvecl *y1, const polyfixveck *y2, uint8_t b){
    polyfix tmp;
    uint64_t reject2;
    uint64_t sqnorm2 = - (uint64_t)B0SQ * LN * LN;

    for (size_t column = 0; column < L; column++){
        polyfix_double(&tmp, &z1->vec[column]);
        polyfix_sub(&tmp, &tmp, &y1->vec[column]);
        sqnorm2 += polyfix_sqnorm2(&tmp);
    }

    for (size_t row = 0; row < K; row++){
        polyfix_double(&tmp, &z2->vec[row]);
        polyfix_sub(&tmp, &tmp, &y2->vec[row]);
        sqnorm2 += polyfix_sqnorm2(&tmp);
    }

    // reject if norm(2z-y) < B and b' = 0
    reject2 = sqnorm2 >> 63;
    reject2 &= 1; // get the sign, 1 indicates that the sample lies in the overlap region
    reject2 &= (b & 0x2) >> 1;  // if sample is in the overlap region, reject with 50% probability
    return reject2;
}


/*************************************************
 * Name:        multiply_a1_by_rounded_y1_mod_q
 *
 * Description: Computes Ay = A1 * round(y1) mod q and a copy of round(y1)[0].
 *              Subfunction of compute_challenge_polynomial()
 *
 * Arguments:   - poly *z1rnd0:     round(y1)[0], not in Montgomery domain
 *              - polyveck *Ay:     vector mod q
 *              - polyfixvecl *y1:  part of the hyperball samples
 *              - polyvecl A1[K]:   matrix A1
 * 
 * Returns void
 **************************************************/
static void multiply_a1_by_rounded_y1_mod_q(poly *z1rnd0, 
                                            polyveck *Ay, 
                                            const polyfixvecl *y1, 
                                            uMatrixPointerL_frozen a1ptr){
    poly z1rnd;
    poly t;
#ifdef ENABLE_SIGNATURE_MATRIX_BUFFER
    const poly_frozen *a1_poly_ptr;
#else
    poly_frozen a1_poly;
    poly_frozen *a1_poly_ptr = &a1_poly;
#endif /* ENABLE_SIGNATURE_MATRIX_BUFFER */


    polyfix_round(&z1rnd, &y1->vec[0]);
    poly_clone(z1rnd0, &z1rnd);
    poly_ntt(&z1rnd);

    for (size_t row = 0; row < K; ++row) {
#ifdef ENABLE_SIGNATURE_MATRIX_BUFFER
        a1_poly_ptr = &a1ptr.vec[row].vec[0];
#else
        expand_pk_matrix_elem_frozen(a1_poly_ptr, row, 0, a1ptr.seed);
#endif /* ENABLE_SIGNATURE_MATRIX_BUFFER */
        poly_pointwise_montgomery_mixed(&Ay->vec[row], a1_poly_ptr, &z1rnd);
    }

    for (size_t column = 1; column < L; ++column) {
        polyfix_round(&z1rnd, &y1->vec[column]);
        poly_ntt(&z1rnd);
        for (size_t row = 0; row < K; ++row) {
#ifdef ENABLE_SIGNATURE_MATRIX_BUFFER
            a1_poly_ptr = &a1ptr.vec[row].vec[column];
#else
            expand_pk_matrix_elem_frozen(a1_poly_ptr, row, column, a1ptr.seed);
#endif /* ENABLE_SIGNATURE_MATRIX_BUFFER */
            poly_pointwise_montgomery_mixed(&t, a1_poly_ptr, &z1rnd);
            poly_add(&Ay->vec[row], &Ay->vec[row], &t);
        }
    }
    polyveck_invntt_tomont(Ay);
};

/*************************************************
 * Name:        accumulate_two_times_rounded_y2_mod_q
 *
 * Description: Accumulates 2 * round(y2) mod q to Ay 
 *              Subfunction of compute_challenge_polynomial()
 *
 * Arguments:   - polyveck *Ay:     vector mod q
 *              - polyfixveck *y2:  part of the hyperball samples
 *
 * Returns void
 **************************************************/
static void accumulate_two_times_rounded_y2_mod_q(polyveck *Ay, const polyfixveck *y2){
	polyveck z2rnd;
    
    // Round y2
    polyfixveck_round(&z2rnd, y2);
    
    // Ay += 2 * round(y2) mod q
    polyveck_double(&z2rnd);
    polyveck_add(Ay, Ay, &z2rnd);
}

/*************************************************
 * Name:        compute_challenge_polynomial
 *
 * Description: Computes a challenge polynomial, Ay and HighBits(hint)
 *
 * Arguments:   - poly *c:                      challenge polynomial
 *              - polyveck *Ay:                 A1 * round(y1) + 2 * round(y2) mod q
 *              - polyveck *highbits:           HighBits of hint (A * round(y) mod 2q)
 *              - const polyvecl *A1[K]:        public key matrix
 *              - const polyfixvecl *y1:        part of the hyperball samples
 *              - const polyfixveck *y2:        part of the hyperball samples
 *              - const uint8_t *mu[SEEDBYTES]: seed generated from secret key and message
 *
 * Returns 0 (success)
 **************************************************/
static void compute_challenge_polynomial(poly *c, polyveck *Ay, polyveck *highbits, 
                                   const uMatrixPointerL_frozen a1ptr, const polyfixvecl *y1, 
                                   const polyfixveck *y2, const uint8_t mu[SEEDBYTES]){
	uint8_t buf[POLYVECK_HIGHBITS_PACKEDBYTES + POLYC_PACKEDBYTES] = {0};
	poly z1rnd0;
	poly lsb;

    // A * round(y) mod q = A1 * round(y1) + 2 * round(y2) mod q
    multiply_a1_by_rounded_y1_mod_q(&z1rnd0, Ay, y1, a1ptr);
    accumulate_two_times_rounded_y2_mod_q(Ay, y2);

    // recover A * round(y) mod 2q
    polyveck_poly_fromcrt(Ay, Ay, &z1rnd0);
    polyveck_freeze2q(Ay);

    // HighBits of (A * round(y) mod 2q)
    polyveck_highbits_hint(highbits, Ay);

    // LSB(round(y_0) * j)
    poly_lsb(&lsb, &z1rnd0);

    // Pack HighBits of A * round(y) mod 2q and LSB of round(y0)
    polyveck_pack_highbits(buf, highbits);
    poly_pack_lsb(buf + POLYVECK_HIGHBITS_PACKEDBYTES, &lsb);

    // c = challenge(HighBits(A * y mod 2q), LSB(round(y0) * j), mu)
    poly_challenge(c, buf, mu);

    return;
};

/*************************************************
 * Name:        compress_and_pack_signature
 *
 * Description: Compress and pack the components of the signature
 *
 * Arguments:   - uint8_t *sig:   pointer to output signature (of length
 *                                CRYPTO_BYTES)
 *              - size_t *siglen: pointer to output length of signature
 *
 * Returns 0 (success) or 1 (fail)
 **************************************************/
static int compress_and_pack_signature(
    uint8_t *sig,
    poly *c,
    const polyfixvecl *z1,
    const polyfixveck *z2,
    const polyveck *Ay,
    const polyveck *highbits
){
    polyvecl hb_z1, lb_z1;
    polyveck h; 
    /*------------------- 4. Make a hint and decompose z1 -----------*/
    make_hint_veck(&h, z2, Ay, highbits);
    decompose_z1_vecl(&lb_z1, &hb_z1, z1);

    /*------------------ Pack signature -----------------------------*/
    if (pack_sig(sig, c, &lb_z1, &hb_z1, &h)) { // reject if signature is too big
        return 1;
    }
    return 0;
}

/*************************************************
 * Name:        crypto_sign_signature
 *
 * Description: Computes signature.
 *
 * Arguments:   - uint8_t *sig:   pointer to output signature (of length
 *                                CRYPTO_BYTES)
 *              - size_t *siglen: pointer to output length of signature
 *              - uint8_t *m:     pointer to message to be signed
 *              - size_t mlen:    length of message
 *              - uint8_t *sk:    pointer to bit-packed secret key
 *
 * Returns 0 (success)
 **************************************************/

int crypto_sign_signature(uint8_t *sig, size_t *siglen, const uint8_t *m,
                          size_t mlen, const uint8_t *sk) {

    uint8_t seedbuf[CRHBYTES] = {0}, key[SEEDBYTES] = {0};
    uint8_t mu[SEEDBYTES] = {0};
    poly c = { .coeffs = {0} }; // challenge polynomial
    uint8_t b = 0;              // some random bits
    uint16_t counter = 0;
    uint64_t reject1, reject2;

    polyvecm s1;
    polyveck s2, highbits, Ay;
    polyfixvecl y1, z1;
    polyfixveck y2, z2;

#ifdef ENABLE_SIGNATURE_MATRIX_BUFFER
    polyvecl_frozen A1[K];
    uMatrixPointerL_frozen a1ptr = { .vec = A1};
#else
    uMatrixPointerL_frozen a1ptr = { .seed = sk };
#endif /* ENABLE_SIGNATURE_MATRIX_BUFFER */

    // Unpack secret key
    unpack_sk(a1ptr.vec, &s1, &s2, key, sk);

#ifndef ENABLE_SIGNATURE_MATRIX_BUFFER
#endif /* ENABLE_SIGNATURE_MATRIX_BUFFER */
    
    generate_seed_from_two_sources(mu, SEEDBYTES, sk, CRYPTO_PUBLICKEYBYTES, m, mlen);
    generate_seed_from_two_sources(seedbuf, CRHBYTES, key, SEEDBYTES, mu, SEEDBYTES);

    polyvecm_ntt(&s1);
    polyveck_ntt(&s2);

reject:

    /*------------------ 1. Sample y1 and y2 from hyperball ------------------*/

#ifdef ENABLE_TWO_PASS_SAMPLING
    counter = polyfixveclk_two_pass_sample_hyperball(&y1, &y2, &b, seedbuf, counter);
#else
    counter = polyfixveclk_sample_hyperball(&y1, &y2, &b, seedbuf, counter);
#endif

    /*------------------- 2. Compute a challenge c --------------------------*/
    compute_challenge_polynomial(&c, &Ay, &highbits, a1ptr, &y1, &y2, mu);

    /*------------------- 3. Compute z = y + (-1)^b c * s --------------------*/
    compute_z_veckl(&z1, &z2, &c, &s1, &s2, &y1, &y2, b);

    reject1 = is_norm_of_z_geq_big_b_prime(&z1, &z2);
    reject2 = is_rejected_in_intersection(&z1, &z2, &y1, &y2, b);
    if (reject1 | reject2) {
        goto reject;
    }

    /*------------------- 4. Make a hint and decompose z1 -----------*/
    /*------------------ Pack signature -----------------------------*/
    if (0 != compress_and_pack_signature(sig, &c, &z1, &z2, &Ay, &highbits)) 
        goto reject;
    *siglen = CRYPTO_BYTES;

    return 0;
}

// ###################################################################
// ###################################################################
// ###################################################################
// ###################################################################

/*************************************************
 * Name:        crypto_sign
 *
 * Description: Compute signed message.
 *
 * Arguments:   - uint8_t *sm: pointer to output signed message (allocated
 *                             array with CRYPTO_BYTES + mlen bytes),
 *                             can be equal to m
 *              - size_t *smlen: pointer to output length of signed
 *                               message
 *              - const uint8_t *m: pointer to message to be signed
 *              - size_t mlen: length of message
 *              - const uint8_t *sk: pointer to bit-packed secret key
 *
 * Returns 0 (success)
 **************************************************/
int crypto_sign(uint8_t *sm, size_t *smlen, const uint8_t *m, size_t mlen,
                     const uint8_t *sk) {
    size_t i;

    for (i = 0; i < mlen; ++i)
        sm[CRYPTO_BYTES + mlen - 1 - i] = m[mlen - 1 - i];
    crypto_sign_signature(sm, smlen, sm + CRYPTO_BYTES, mlen, sk);
    *smlen += mlen;
    return 0;
}

// ###################################################################
// ###################################################################
// ###################################################################
// ###################################################################

static int unpack_cseed_z1_and_hint_from_sig(poly *c, polyvecl *z1, 
               polyveck *h, const uint8_t sig[CRYPTO_BYTES]){
    polyvecl highbits_z1;

    // Unpack signature and Check conditions -- low bits are stored in z1
    if (unpack_sig(c, &highbits_z1, z1, h, sig)) {
        return -1;
    }

    // Compose z1 out of HighBits(z1) and LowBits(z1)
    for (size_t row = 0; row < L; ++row) {
        poly_compose(&z1->vec[row], &z1->vec[row], &highbits_z1.vec[row]);
    }
    return 0;
}

static void poly_csubDQ2ALPHA(poly *v) {
    unsigned int j;
    for (j = 0; j < N; j++) {
        v->coeffs[j] -=
            ~((v->coeffs[j] - (DQ - 2) / ALPHA_HINT) >> 31) &
            ((DQ - 2) / ALPHA_HINT);
    }
}

static void poly_mul_alpha(poly *v, const poly *u) {
    unsigned int j;
    for (j = 0; j < N; j++) {
        v->coeffs[j] = u->coeffs[j] * ALPHA_HINT;
    }
}

static void poly_div2(poly *v) {
    unsigned j;
        for (j = 0; j < N; ++j)
            v->coeffs[j] >>= 1;
}

/*************************************************
 * Name:        crypto_sign_verify
 *
 * Description: Verifies signature.
 *
 * Arguments:   - uint8_t *m: pointer to input signature
 *              - size_t siglen: length of signature
 *              - const uint8_t *m: pointer to message
 *              - size_t mlen: length of message
 *              - const uint8_t *pk: pointer to bit-packed public key
 *
 * Returns 0 if signature could be verified correctly and -1 otherwise
 **************************************************/
int crypto_sign_verify(const uint8_t *sig, size_t siglen, const uint8_t *m,
                       size_t mlen, const uint8_t *pk) {
    unsigned int i;
    uint8_t buf[POLYVECK_HIGHBITS_PACKEDBYTES + POLYC_PACKEDBYTES] = {0};
    uint8_t rhoprime[SEEDBYTES] = {0};
    uint8_t mu[SEEDBYTES] = {0};
    uint64_t sqnorm2;
    polyvecl z1;
    polyveck b; 
    polyveck highbits; 
    polyveck h; 
    polyveck z2; 
    polyveck w;
    poly c;
    poly cprime;
    poly wprime;

    // Check signature length
    if (siglen != CRYPTO_BYTES) {
        return -1;
    }

    // Unpack public key
    unpack_pk(&b, rhoprime, pk);
    unpack_cseed_z1_and_hint_from_sig(&c, &z1, &h, sig);

    /*------------------- 2. Compute \tilde{z}_2 -----------------------------*/
    // compute  w' = lsb(z1[0] - c) and the squared norm of z1 before NTT
    sqnorm2 = polyvecl_sqnorm2(&z1);
    poly_sub(&wprime, &z1.vec[0], &c);
    poly_lsb(&wprime, &wprime);

    // A1 * round(z1) - qcj mod q
    for (size_t column = 0; column < L; column++) {
        poly_ntt(&z1.vec[column]);
    }
    // highbits = A1 * z1
    for (size_t row = 0; row < K; ++row) {
		poly t;
        poly_frozen a1_elem;  // we need A1 only once, so compute its elements on demand

        expand_pk_matrix_elem_frozen(&a1_elem, row, 0, pk);
		poly_pointwise_montgomery_mixed(&highbits.vec[row], &a1_elem, &z1.vec[0]);
		for (size_t column = 1; column < L; ++column) {
            expand_pk_matrix_elem_frozen(&a1_elem, row, column, pk);
			poly_pointwise_montgomery_mixed(&t, &a1_elem, &z1.vec[column]);
			poly_add(&highbits.vec[row], &highbits.vec[row], &t);
		}
        poly_invntt_tomont(&highbits.vec[row]);
	}

    // recover A1 * round(z1) - qcj mod 2q

    for (size_t row = 0; row < K; ++row){
        poly *highbits_elem_ptr = &highbits.vec[row];
        poly *h_elem_ptr;
        poly *w_elem_ptr;
        poly *z2_elem_ptr;

        h_elem_ptr = &h.vec[row];
        w_elem_ptr = &w.vec[row];
        z2_elem_ptr = &z2.vec[row];


        if (0 == row) {
            poly_fromcrt(highbits_elem_ptr, highbits_elem_ptr, &wprime);
        } else {
            poly_fromcrt0(highbits_elem_ptr, highbits_elem_ptr);
        }
        poly_freeze2q(highbits_elem_ptr);
        // recover w1
        poly_highbits_hint(w_elem_ptr, highbits_elem_ptr);
        poly_add(w_elem_ptr, w_elem_ptr, h_elem_ptr);
        poly_csubDQ2ALPHA(w_elem_ptr);
        // recover \tilde{z}_2 mod q
        poly_mul_alpha(z2_elem_ptr, w_elem_ptr);
        poly_sub(z2_elem_ptr, z2_elem_ptr, highbits_elem_ptr);
        if (0 == row) {
            poly_add(z2_elem_ptr, z2_elem_ptr, &wprime);
        }
        poly_reduce2q(z2_elem_ptr);
        poly_div2(z2_elem_ptr);
    }

    // check final norm of \tilde{z}
    if (sqnorm2 + polyveck_sqnorm2(&z2) > B2SQ) {
        return -1;
    }

    /*------------------- 3. Compute cprime and Compare ---------------------*/

    // Pack highBits(A * round(z) - qcj mod 2q) and h'
    polyveck_pack_highbits(buf, &w);
    poly_pack_lsb(buf + POLYVECK_HIGHBITS_PACKEDBYTES, &wprime);

    generate_seed_from_two_sources(mu, SEEDBYTES, pk, CRYPTO_PUBLICKEYBYTES, m, mlen);

    poly_challenge(&cprime, buf, mu);

    for (i = 0; i < N; ++i) {
        if (c.coeffs[i] != cprime.coeffs[i]) {
            return -1;
        }
    }
    return 0;
}

// ###################################################################
// ###################################################################
// ###################################################################
// ###################################################################

/*************************************************
 * Name:        crypto_sign_open
 *
 * Description: Verify signed message.
 *
 * Arguments:   - uint8_t *m: pointer to output message (allocated
 *                            array with smlen bytes), can be equal to sm
 *              - size_t *mlen: pointer to output length of message
 *              - const uint8_t *sm: pointer to signed message
 *              - size_t smlen: length of signed message
 *              - const uint8_t *pk: pointer to bit-packed public key
 *
 * Returns 0 if signed message could be verified correctly and -1 otherwise
 **************************************************/
int crypto_sign_open(uint8_t *m, size_t *mlen, const uint8_t *sm, size_t smlen,
                     const uint8_t *pk) {
    size_t i;

    if (smlen < CRYPTO_BYTES)
        goto badsig;

    *mlen = smlen - CRYPTO_BYTES;
    if (crypto_sign_verify(sm, CRYPTO_BYTES, sm + CRYPTO_BYTES, *mlen, pk))
        goto badsig;
    else {
        /* All good, copy msg, return 0 */
        for (i = 0; i < *mlen; ++i)
            m[i] = sm[CRYPTO_BYTES + i];
        return 0;
    }

badsig:
    /* Signature verification failed */
    *mlen = -1;
    for (i = 0; i < smlen; ++i)
        m[i] = 0;

    return -1;
}

// ###################################################################
// ###################################################################
// ###################################################################
// ###################################################################
