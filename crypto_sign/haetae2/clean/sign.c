#include "sign.h"
#include "packing.h"
#include "params.h"
#include "poly.h"
#include "polyfix.h"
#include "polymat.h"
#include "polyvec.h"
#include "randombytes.h"
#include "symmetric.h"
#include <inttypes.h>
#include <stdint.h>
#include <string.h>
#include <stdio.h>

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
    const uint8_t *rhoprime, *sigma, *key;
    polyvecm A[K], s1, s1hat;
    polyveck b, s2;
#if D > 0
    polyveck a, b0;
#else
    polyveck s2hat;
#endif
    xof256_state state;

    // Get entropy \rho
    randombytes(seedbuf, SEEDBYTES);

    // Sample seeds with entropy \rho
    xof256_absorbe_once(&state, seedbuf, SEEDBYTES);
    xof256_squeeze(seedbuf, 2 * SEEDBYTES + CRHBYTES, &state);

    rhoprime = seedbuf;
    sigma = rhoprime + SEEDBYTES;
    key = sigma + CRHBYTES;

    // Expand Matrix A0 and vector a
    polymatkm_expand(A, rhoprime);

#if D > 0
    /**********************************************
     * If there is rounding (D > 0), we need another polyveck a.
     * Then, b = a + A0 * s1 + s2 and the lower D bits are
     * rounded from b. The lower D bits are subsequently
     * subtracted from s2.
     **********************************************/
    polyveck_expand(&a, rhoprime);

reject:
    // Sample secret vectors s1 and s2
    polyvecmk_uniform_eta(&s1, &s2, sigma, nonce);
    nonce += M + K;

    // b = a + A0 * s1 + s2 mod q
    s1hat = s1;
    polyvecm_ntt(&s1hat);
    polymatkm_pointwise_montgomery(&b, A, &s1hat);
    polyveck_invntt_tomont(&b);
    polyveck_add(&b, &b, &s2);
    polyveck_add(&b, &b, &a);
    polyveck_freeze(&b);

    // round off D bits
    polyveck_decompose_vk(&b0, &b);
    polyveck_sub(&s2, &s2, &b0);

    int64_t squared_singular_value = polyvecmk_sqsing_value(&s1, &s2);
    if (squared_singular_value > GAMMA * GAMMA * N) {
        goto reject;
    }
#else
    /**********************************************
     * If there is no rounding (D == 0), we store
     * -2b directly in NTT domain into the public key.
     **********************************************/
reject:
    // Sample secret vectors s1 and s2
    polyvecmk_uniform_eta(&s1, &s2, sigma, nonce);
    nonce += M + K;
    int64_t squared_singular_value = polyvecmk_sqsing_value(&s1, &s2);
    if (squared_singular_value > GAMMA * GAMMA * N) {
        goto reject;
    }

    // b = A0 * s1 + s2 mod q
    s1hat = s1;
    s2hat = s2;
    polyvecm_ntt(&s1hat);
    polyveck_ntt(&s2hat);
    polymatkm_pointwise_montgomery(&b, A, &s1hat);
    polyveck_frommont(&b);
    polyveck_add(&b, &b, &s2hat);
    polyveck_double_negate(&b);
    polyveck_caddq(&b); // directly compute and store NTT(-2b)
#endif

    pack_pk(pk, &b, rhoprime);
    pack_sk(sk, pk, &s1, &s2, key);

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

    uint8_t buf[POLYVECK_HIGHBITS_PACKEDBYTES + POLYC_PACKEDBYTES] = {0};
    uint8_t seedbuf[CRHBYTES] = {0}, key[SEEDBYTES] = {0};
    uint8_t mu[SEEDBYTES] = {0};
    uint8_t cseed[SEEDBYTES] = {0}; // seed of a challenge polynomial c
    uint8_t b = 0;                  // one bit
    uint16_t counter = 0;
    uint64_t reject1, reject2;

    polyvecm s1;
    polyvecl A1[K], cs1;
    polyveck s2, cs2, highbits, Ay;
    polyfixvecl y1, z1, z1tmp;
    polyfixveck y2, z2, z2tmp;
    polyvecl z1rnd; // round of z1
    polyvecl hb_z1, lb_z1;
    polyveck z2rnd, h, htmp; // round of z2
    poly c, z1rnd0, lsb;

    xof256_state state;

    unsigned int i;

    // Unpack secret key
    unpack_sk(A1, &s1, &s2, key, sk);

    xof256_absorbe_twice(&state, sk, CRYPTO_PUBLICKEYBYTES, m, mlen);
    xof256_squeeze(mu, SEEDBYTES, &state);
    xof256_absorbe_twice(&state, key, SEEDBYTES, mu, SEEDBYTES);
    xof256_squeeze(seedbuf, CRHBYTES, &state);

    polyvecm_ntt(&s1);
    polyveck_ntt(&s2);

reject:

    /*------------------ 1. Sample y1 and y2 from hyperball ------------------*/
    randombytes(&b, sizeof(uint8_t));
    counter = polyfixveclk_sample_hyperball(&y1, &y2, seedbuf, counter);

    /*------------------- 2. Compute a chanllenge c --------------------------*/
    // Round y1 and y2
    polyfixvecl_round(&z1rnd, &y1);
    polyfixveck_round(&z2rnd, &y2);

    // A * round(y) mod q = A1 * round(y1) + 2 * round(y2) mod q
    z1rnd0 = z1rnd.vec[0];
    polyvecl_ntt(&z1rnd);
    polymatkl_pointwise_montgomery(&Ay, A1, &z1rnd);
    polyveck_invntt_tomont(&Ay);
    polyveck_double(&z2rnd);
    polyveck_add(&Ay, &Ay, &z2rnd);

    // recover A * round(y) mod 2q
    polyveck_poly_fromcrt(&Ay, &Ay, &z1rnd0);
    polyveck_freeze2q(&Ay);

    // HighBits of (A * round(y) mod 2q)
    polyveck_highbits_hint(&highbits, &Ay);

    // LSB(round(y_0) * j)
    poly_lsb(&lsb, &z1rnd0);

    // Pack HighBits of A * round(y) mod 2q and LSB of round(y0)
    polyveck_pack_highbits(buf, &highbits);
    poly_pack_lsb(buf + POLYVECK_HIGHBITS_PACKEDBYTES, &lsb);

    // c_seed = H(HighBits(A * y mod 2q), LSB(round(y0) * j), M)
    xof256_absorbe_twice(&state, buf,
                         POLYVECK_HIGHBITS_PACKEDBYTES + POLYC_PACKEDBYTES, mu,
                         SEEDBYTES);
    xof256_squeeze(cseed, SEEDBYTES, &state);

    // c = challenge(c_seed)
    poly_challenge(&c, cseed);

    /*------------------- 3. Compute z = y + (-1)^b c * s --------------------*/
    // cs = c * s = c * (si1 || s2)
    cs1.vec[0] = c;
    poly_ntt(&c);

    for (i = 1; i < L; ++i) {
        poly_pointwise_montgomery(&cs1.vec[i], &c, &s1.vec[i - 1]);
        poly_invntt_tomont(&cs1.vec[i]);
    }
    polyveck_poly_pointwise_montgomery(&cs2, &s2, &c);
    polyveck_invntt_tomont(&cs2);

    // z = y + (-1)^b cs = z1 + z2
    polyvecl_cneg(&cs1, b & 1);
    polyveck_cneg(&cs2, b & 1);
    polyfixvecl_add(&z1, &y1, &cs1);
    polyfixveck_add(&z2, &y2, &cs2);

    // reject if norm(z) >= B'
    reject1 = ((uint64_t)B1SQ * LN * LN - polyfixveclk_sqnorm2(&z1, &z2)) >> 63;
    reject1 &= 1;

    polyfixvecl_double(&z1tmp, &z1);
    polyfixveck_double(&z2tmp, &z2);

    polyfixfixvecl_sub(&z1tmp, &z1tmp, &y1);
    polyfixfixveck_sub(&z2tmp, &z2tmp, &y2);

    // reject if norm(2z-y) < B and b' = 0
    reject2 =
        (polyfixveclk_sqnorm2(&z1tmp, &z2tmp) - (uint64_t)B0SQ * LN * LN) >> 63;
    reject2 &= 1;
    reject2 &= (b & 0x2) >> 1;

    if (reject1 | reject2) {
        goto reject;
    }

    /*------------------- 4. Make a hint -------------------------------------*/
    // Round z1 and z2
    polyfixvecl_round(&z1rnd, &z1);
    polyfixveck_round(&z2rnd, &z2);

    // recover A1 * round(z1) - qcj mod 2q
    polyveck_double(&z2rnd);
    polyveck_sub(&htmp, &Ay, &z2rnd);
    polyveck_freeze2q(&htmp);

    // HighBits of (A * round(z) - qcj mod 2q) and (A1 * round(z1) - qcj mod 2q)
    polyveck_highbits_hint(&htmp, &htmp);
    polyveck_sub(&h, &highbits, &htmp);
    polyveck_caddDQ2ALPHA(&h);

    /*------------------ Decompose(z1) and Pack signature -------------------*/
    polyvecl_lowbits(&lb_z1, &z1rnd); // TODO do this in one function together!
    polyvecl_highbits(&hb_z1, &z1rnd);

    if (pack_sig(sig, cseed, &lb_z1, &hb_z1,
                 &h)) { // reject if signature is too big
        goto reject;
    }
    *siglen = CRYPTO_BYTES;

    return 0;
}

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
    uint8_t c_seed[SEEDBYTES] = {0}, c_seed2[SEEDBYTES] = {0};
    uint8_t rhoprime[SEEDBYTES] = {0};
    uint64_t sqnorm2;
    polyvecl A1[K], z1;
    polyveck b, highbits, h, z2, w;
#if D > 0
    polyveck a;
#endif
    poly c, wprime;

    xof256_state state;

    // Check signature length
    if (siglen != CRYPTO_BYTES) {
        return -1;
    }

    // Unpack public key
    unpack_pk(&b, rhoprime, pk);

    // Unpack signature and Check conditions -- A1 is used only as intermediate
    // buffer for the low bits
    if (unpack_sig(c_seed, A1, &z1, &h, sig)) {
        return -1;
    }

    // Compose z1 out of HighBits(z1) and LowBits(z1)
    for (i = 0; i < L; ++i) {
        poly_compose(&z1.vec[i], &z1.vec[i], &A1[0].vec[i]);
    }

    /*------------------- 1. Recover A1 --------------------------------------*/
    // A1 = (-2b + qj || 2 * A0)
    polymatkl_expand(A1, rhoprime);
    polymatkl_double(A1);
#if D == 1
    polyveck_expand(&a, rhoprime);
    polyveck_double(&b);
    polyveck_sub(&b, &a, &b);
    polyveck_double(&b);
    polyveck_ntt(&b);
#elif D == 0
                        // no action required as b already contains -2b in NTT domain
#else
#error "Not yet implemented."
#endif

    for (i = 0; i < K; ++i) {
        A1[i].vec[0] = b.vec[i];
    }

    /*------------------- 2. Compute \tilde{z}_2 -----------------------------*/
    // c = challenge(c_seed)
    poly_challenge(&c, c_seed);

    // compute squared norm of z1 and w' before NTT
    sqnorm2 = polyvecl_sqnorm2(&z1);
    poly_sub(&wprime, &z1.vec[0], &c);
    poly_lsb(&wprime, &wprime);

    // A1 * round(z1) - qcj mod q
    polyvecl_ntt(&z1);
    polymatkl_pointwise_montgomery(&highbits, A1, &z1);
    polyveck_invntt_tomont(&highbits);

    // recover A1 * round(z1) - qcj mod 2q
    polyveck_poly_fromcrt(&highbits, &highbits, &wprime);
    polyveck_freeze2q(&highbits);

    // recover w1
    polyveck_highbits_hint(&w, &highbits);
    polyveck_add(&w, &w, &h);
    polyveck_csubDQ2ALPHA(&w);

    // recover \tilde{z}_2 mod q
    polyveck_mul_alpha(&z2, &w);
    polyveck_sub(&z2, &z2, &highbits);
    poly_add(&z2.vec[0], &z2.vec[0], &wprime);
    polyveck_reduce2q(&z2);
    polyveck_div2(&z2);

    // check final norm of \tilde{z}
    if (sqnorm2 + polyveck_sqnorm2(&z2) > B2SQ) {
        return -1;
    }

    /*------------------- 3. Compute c_seed' and Compare ---------------------*/

    // Pack highBits(A * round(z) - qcj mod 2q) and h'
    polyveck_pack_highbits(buf, &w);
    poly_pack_lsb(buf + POLYVECK_HIGHBITS_PACKEDBYTES, &wprime);

    xof256_absorbe_twice(&state, pk, CRYPTO_PUBLICKEYBYTES, m, mlen);
    xof256_squeeze(c_seed2, SEEDBYTES, &state);

    // c_seed = H(HighBits(A * y mod 2q), LSB(round(y0) * j), M)
    xof256_absorbe_twice(&state, buf,
                         POLYVECK_HIGHBITS_PACKEDBYTES + POLYC_PACKEDBYTES,
                         c_seed2, SEEDBYTES);
    xof256_squeeze(c_seed2, SEEDBYTES, &state);

    for (i = 0; i < SEEDBYTES; ++i) {
        if (c_seed[i] != c_seed2[i]) {
            return -1;
        }
    }
    return 0;
}

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
