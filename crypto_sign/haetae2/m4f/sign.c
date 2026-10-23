// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#include "api.h"
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
#include <stdio.h>
#include <string.h>

/*************************************************
 * Name:        crypto_sign_keypair_internal
 *
 * Description: Generates public and private key.
 *
 * Arguments:   - uint8_t *vk: pointer to output public key (allocated
 *              array of HAETAE_CRYPTO_PUBLICKEYBYTES bytes)
 *              - uint8_t *sk: pointer to output private key (allocated
 *              array of HAETAE_CRYPTO_SECRETKEYBYTES bytes)
 *              - uint8_t seed[]: input seed of HAETAE_SEEDBYTES bytes
 *
 * Returns 0 (success)
 *
 * Specification: Implements @[Algorithm 54, KeyGenInternal]
 **************************************************/

int crypto_sign_keypair_internal(uint8_t *vk, uint8_t *sk,
                                 uint8_t seed[HAETAE_SEEDBYTES]) {
  uint8_t seedbuf[2 * HAETAE_SEEDBYTES + HAETAE_CRHBYTES] = {0};
  uint16_t counter = 0;
  const uint8_t *rhoprime, *sigma, *key;
  polyvecm A[HAETAE_K], s1, s1hat;
  polyveck b, s2;
#if (HAETAE_MODE == HAETAE_MODE2) || (HAETAE_MODE == HAETAE_MODE3)
  polyveck a, b0;
#elif HAETAE_MODE == HAETAE_MODE5
  polyveck s2hat;
#endif
  xof256_state state;

  // Get seed_A
  memcpy(seedbuf, seed, HAETAE_SEEDBYTES);

  // Sample seeds with entropy \rho
  xof256_absorb_once(&state, seedbuf, HAETAE_SEEDBYTES);
  xof256_squeeze(seedbuf, 2 * HAETAE_SEEDBYTES + HAETAE_CRHBYTES, &state);

  rhoprime = seedbuf;
  sigma = rhoprime + HAETAE_SEEDBYTES;
  key = sigma + HAETAE_CRHBYTES;

  // Expand Matrix A0 and vector a
  polymatkm_expand_matA(A, rhoprime);

#if (HAETAE_MODE == HAETAE_MODE2) || (HAETAE_MODE == HAETAE_MODE3)
  /**********************************************
   * If there is rounding (D > 0), we need another polyveck a.
   * Then, b = a + A0 * s1 + s2 and the lower D bits are
   * rounded from b. The lower D bits are subsequently
   * subtracted from s2.
   **********************************************/
  polyveck_expand_vecA(&a, rhoprime);

reject:
  // Sample secret vectors s1 and s2
  polyvecmk_expand_S(&s1, &s2, sigma, counter);
  counter += HAETAE_M + HAETAE_K;

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

  int64_t squared_singular_value = polyvecmk_sk_singular_value(&s1, &s2);
  if (squared_singular_value > HAETAE_GAMMA * HAETAE_GAMMA * HAETAE_N) {
    goto reject;
  }
#elif HAETAE_MODE == HAETAE_MODE5
  /**********************************************
   * If there is no rounding (D == 0), we store
   * -2b directly in NTT domain into the public key.
   **********************************************/
reject:
  // Sample secret vectors s1 and s2
  polyvecmk_expand_S(&s1, &s2, sigma, counter);
  counter += HAETAE_M + HAETAE_K;
  int64_t squared_singular_value = polyvecmk_sk_singular_value(&s1, &s2);
  if (squared_singular_value > HAETAE_GAMMA * HAETAE_GAMMA * HAETAE_N) {
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

  pack_vk(vk, &b, rhoprime);
  pack_sk(sk, vk, &s1, &s2, key);

  return 0;
}

/*************************************************
 * Name:        crypto_sign_keypair
 *
 * Description: Generates public and private key.
 *
 * Arguments:   - uint8_t *pk: pointer to output public key (allocated
 *              array of HAETAE_CRYPTO_PUBLICKEYBYTES bytes)
 *              - uint8_t *sk: pointer to output private key (allocated
 *              array of HAETAE_CRYPTO_SECRETKEYBYTES bytes)
 *
 * Returns 0 (success)
 *
 * Specification: Implements @[Algorithm 51, KeyGen]
 **************************************************/
int crypto_sign_keypair(uint8_t *pk, uint8_t *sk) {
  int ret = 0;
  uint8_t seed[HAETAE_SEEDBYTES] = {0};

  randombytes(seed, HAETAE_SEEDBYTES);

  ret = crypto_sign_keypair_internal(pk, sk, seed);

  return ret;
}

/*************************************************
 * Name:        crypto_sign_signature_internal
 *
 * Description: Computes signature. Internal API.
 *
 * Arguments:   - uint8_t *sig: pointer to output signature (of length
 *              HAETAE_CRYPTO_BYTES)
 *              - size_t *siglen: pointer to output length of signature
 *              - uint8_t *m: pointer to message to be signed
 *              - size_t mlen: length of message
 *              - uint8_t *pre: pointer to prefix string
 *              - size_t prelen: length of prefix string
 *              - uint8_t *rnd: pointer to random seed
 *              - uint8_t *sk: pointer to bit-packed secret key
 *
 * Returns 0 (success)
 *
 * Specification: Implements @[Algorithm 55, SignInternal]
 **************************************************/
int crypto_sign_signature_internal(uint8_t *sig, size_t *siglen,
                                   const uint8_t *m, size_t mlen,
                                   const uint8_t *pre, size_t prelen,
                                   const uint8_t rnd[HAETAE_SEEDBYTES],
                                   const uint8_t *sk) {

  uint8_t buf[HAETAE_POLYVECK_HIGHBITS_PACKEDBYTES + HAETAE_POLYC_PACKEDBYTES] =
      {0};
  uint8_t seedbuf[HAETAE_CRHBYTES] = {0}, key[HAETAE_SEEDBYTES] = {0};
  uint8_t mu[HAETAE_CRHBYTES] = {0};
  uint8_t b = 0; // bit 0: sign (-1)^b, bit 1: second rejection test
  uint16_t counter = 0;
  uint64_t reject1, reject2;

  polyvecm s1;
  polyvecl A1[HAETAE_K];
  polyveck s2, highbits, Ay;
  polyfixvecl y1;
  polyfixveck y2;
  polyveck h;
  poly c, chat, cs, z1rnd0, lsb;

  // Buffers whose lifetimes do not overlap share memory: the hyperball
  // samples (step 1) with z and round(z) (steps 2 to 4), and z1 with
  // HighBits(z1) (step 4).
  union {
    uint64_t samples[HAETAE_HYPERBALL_SAMPLES];
    struct {
      union {
        polyfixvecl z1;
        polyvecl hb_z1;
      } z1_hb;
      polyfixveck z2;
      polyvecl z1rnd; // round of z1
      polyveck z2rnd; // round of z2
    } v;
  } ws;
  polyfixvecl *const z1 = &ws.v.z1_hb.z1;
  polyvecl *const hb_z1 = &ws.v.z1_hb.hb_z1;
  polyfixveck *const z2 = &ws.v.z2;
  polyvecl *const z1rnd = &ws.v.z1rnd;
  polyveck *const z2rnd = &ws.v.z2rnd;

  xof256_state state;

  unsigned int i;

  // Unpack secret key
  unpack_sk(A1, &s1, &s2, key, sk);

  xof256_absorb_thrice(&state, sk, HAETAE_CRYPTO_PUBLICKEYBYTES, pre, prelen, m,
                       mlen);
  xof256_squeeze(mu, HAETAE_CRHBYTES, &state);

  xof256_absorb_thrice(&state, key, HAETAE_SEEDBYTES, rnd, HAETAE_SEEDBYTES, mu,
                       HAETAE_CRHBYTES);
  xof256_squeeze(seedbuf, HAETAE_CRHBYTES, &state);

  polyvecm_ntt(&s1);
  polyveck_ntt(&s2);

reject:

  /*------------------ 1. Sample y1 and y2 from hyperball ------------------*/
  counter =
      polyfixveclk_sample_hyperball(&y1, &y2, &b, seedbuf, counter, ws.samples);

  /*------------------- 2. Compute a challenge c ---------------------------*/
  // Round y1 and y2
  polyfixvecl_round(z1rnd, &y1);
  polyfixveck_round(z2rnd, &y2);

  // A * round(y) mod q = A1 * round(y1) + 2 * round(y2) mod q
  z1rnd0 = z1rnd->vec[0];
  polyvecl_ntt(z1rnd);
  polymatkl_pointwise_montgomery(&Ay, A1, z1rnd);
  polyveck_invntt_tomont(&Ay);
  polyveck_double(z2rnd);
  polyveck_add(&Ay, &Ay, z2rnd);

  // recover A * round(y) mod 2q
  polyveck_poly_fromcrt(&Ay, &Ay, &z1rnd0);
  polyveck_freeze2q(&Ay);

  // HighBits of (A * round(y) mod 2q)
  polyveck_highbits_hint(&highbits, &Ay);

  // LSB(round(y_0) * j)
  poly_lsb(&lsb, &z1rnd0);

  // Pack HighBits of A * round(y) mod 2q and LSB of round(y0)
  pack_vec_highbits(buf, &highbits);
  pack_poly_lsb(buf + HAETAE_POLYVECK_HIGHBITS_PACKEDBYTES, &lsb);

  // c = challenge(highbits, lsb, mu)
  poly_challenge(&c, buf, mu);

  /*------------------- 3. Compute z = y + (-1)^b c * s --------------------*/
  // cs = c * s = c * (1 || s1 || s2), one polynomial at a time
  // z = (z1, z2) = y + (-1)^b cs
  chat = c;
  poly_ntt(&chat);

  for (i = 0; i < HAETAE_L; ++i) {
    if (i == 0) {
      cs = c;
    } else {
      poly_pointwise_montgomery(&cs, &chat, &s1.vec[i - 1]);
      poly_invntt_tomont(&cs);
    }
    poly_cneg(&cs, b & 1);
    polyfix_add(&z1->vec[i], &y1.vec[i], &cs);
  }
  for (i = 0; i < HAETAE_K; ++i) {
    poly_pointwise_montgomery(&cs, &s2.vec[i], &chat);
    poly_invntt_tomont(&cs);
    poly_cneg(&cs, b & 1);
    polyfix_add(&z2->vec[i], &y2.vec[i], &cs);
  }

  // reject if ||z||^2 > B1^2 (scaled by LN^2)
  reject1 = ((uint64_t)HAETAE_B1SQ * HAETAE_LN * HAETAE_LN -
             polyfixveclk_sqnorm2(z1, z2)) >>
            63;
  reject1 &= 1;

  // reject if ||2z - y||^2 < B0^2 (scaled by LN^2) and bit 1 of b is set
  reject2 = (polyfixveclk_sqnorm2_2z_minus_y(z1, &y1, z2, &y2) -
             (uint64_t)HAETAE_B0SQ * HAETAE_LN * HAETAE_LN) >>
            63;
  reject2 &= 1;
  reject2 &= (b & 0x2) >> 1;

  if (reject1 | reject2) {
    goto reject;
  }

  /*------------------- 4. Make a hint -------------------------------------*/
  // Round z1 and z2
  polyfixvecl_round(z1rnd, z1);
  polyfixveck_round(z2rnd, z2);

  // recover A1 * round(z1) - qcj mod 2q
  polyveck_double(z2rnd);
  polyveck_sub(z2rnd, &Ay, z2rnd);
  polyveck_freeze2q(z2rnd);

  // HighBits of (A * round(z) - qcj mod 2q) and (A1 * round(z1) - qcj mod 2q)
  polyveck_highbits_hint(z2rnd, z2rnd);
  polyveck_sub(&h, &highbits, z2rnd);
  polyveck_caddDQ2ALPHA(&h);

  /*------------------ Decompose(z1) and Pack signature -------------------*/
  polyvecl_highbits(hb_z1, z1rnd);
  polyvecl_lowbits(z1rnd, z1rnd); // in place: z1rnd holds LowBits(z1)

  if (pack_sig(sig, &c, z1rnd, hb_z1,
               &h)) { // reject if the signature cannot be encoded
    goto reject;
  }
  *siglen = HAETAE_CRYPTO_BYTES;

  return 0;
}

/*************************************************
 * Name:        crypto_sign_signature_ctx
 *
 * Description: Computes signature.
 *
 * Arguments:   - uint8_t *sig:   pointer to output signature (of length
 *                                HAETAE_CRYPTO_BYTES)
 *              - size_t *siglen: pointer to output length of signature
 *              - uint8_t *m:     pointer to message to be signed
 *              - size_t mlen:    length of message
 *              - uint8_t *ctx:   pointer to context string
 *              - size_t ctxlen:  length of context string
 *              - uint8_t *sk:    pointer to bit-packed secret key
 *
 * Returns 0 (success) or -1 (invalid context string: ctxlen > 255, or ctx ==
 * NULL with ctxlen > 0)
 *
 * Specification: Implements @[Algorithm 52, Sign]
 **************************************************/
int crypto_sign_signature_ctx(uint8_t *sig, size_t *siglen, const uint8_t *m,
                              size_t mlen, const uint8_t *ctx, size_t ctxlen,
                              const uint8_t *sk) {
  uint8_t pre[256];
  uint8_t rnd[HAETAE_SEEDBYTES];

  if (ctxlen > 255 || (ctx == NULL && ctxlen > 0))
    return -1;

  /* Prepare pre = (ctxlen, ctx) */
  pre[0] = ctxlen;
  if (ctxlen > 0)
    memcpy(pre + 1, ctx, ctxlen);

  randombytes(rnd, HAETAE_SEEDBYTES);

  return crypto_sign_signature_internal(sig, siglen, m, mlen, pre, 1 + ctxlen,
                                        rnd, sk);
}

/*************************************************
 * Name:        crypto_sign_ctx
 *
 * Description: Compute signed message.
 *
 * Arguments:   - uint8_t *sm: pointer to output signed message (allocated
 *                             array with HAETAE_CRYPTO_BYTES + mlen bytes),
 *                             can be equal to m
 *              - size_t *smlen: pointer to output length of signed
 *                               message
 *              - const uint8_t *m: pointer to message to be signed
 *              - size_t mlen: length of message
 *              - const uint8_t *ctx: pointer to context string
 *              - size_t ctxlen: length of context string
 *              - const uint8_t *sk: pointer to bit-packed secret key
 *
 * Returns 0 (success) or -1 (invalid context string; *smlen is set to 0)
 **************************************************/
int crypto_sign_ctx(uint8_t *sm, size_t *smlen, const uint8_t *m, size_t mlen,
                    const uint8_t *ctx, size_t ctxlen, const uint8_t *sk) {
  size_t i;

  if (ctxlen > 255 || (ctx == NULL && ctxlen > 0)) {
    *smlen = 0;
    return -1;
  }
  for (i = 0; i < mlen; ++i)
    sm[HAETAE_CRYPTO_BYTES + mlen - 1 - i] = m[mlen - 1 - i];
  int ret = crypto_sign_signature_ctx(sm, smlen, sm + HAETAE_CRYPTO_BYTES, mlen,
                                      ctx, ctxlen, sk);
  *smlen += mlen;
  return ret;
}

/*************************************************
 * Name:        crypto_sign_verify_internal
 *
 * Description: Verifies signature.
 *
 * Arguments:   - const uint8_t *sig: pointer to input signature
 *              - size_t siglen: length of signature
 *              - const uint8_t *m: pointer to message
 *              - size_t mlen: length of message
 *              - const uint8_t *pre: pointer to prefix string
 *              - size_t prelen: length of prefix string
 *              - const uint8_t *vk: pointer to bit-packed public key
 *
 * Returns 0 if signature could be verified correctly and -1 otherwise
 *
 * Specification: Implements @[Algorithm 56, VerifyInternal]
 **************************************************/
int crypto_sign_verify_internal(const uint8_t *sig, size_t siglen,
                                const uint8_t *m, size_t mlen,
                                const uint8_t *pre, size_t prelen,
                                const uint8_t *vk) {
  unsigned int i;
  uint8_t buf[HAETAE_POLYVECK_HIGHBITS_PACKEDBYTES + HAETAE_POLYC_PACKEDBYTES] =
      {0};
  uint8_t mu[HAETAE_SEEDBYTES];
  uint64_t sqnorm2;
  polyvecl A1[HAETAE_K], highz, lowz, z1;
  polyveck highbits, h, z2, w;
  poly c, cprime, wprime;

  xof256_state state;

  // Check signature length
  if (siglen != HAETAE_CRYPTO_BYTES) {
    return -1;
  }
  /*------------------- 1. Recover A1 --------------------------------------*/
  // A1 = (-2b + qj || 2 * A0)
  // Unpack public key
  unpack_vk(A1, vk);

  // Unpack signature and check its format
  if (unpack_sig(&c, &lowz, &highz, &h, sig)) {
    return -1;
  }

  // Compose z1 out of HighBits(z1) and LowBits(z1)
  for (i = 0; i < HAETAE_L; ++i) {
    poly_compose(&z1.vec[i], &highz.vec[i], &lowz.vec[i]);
  }

  /*------------------- 2. Compute \tilde{z}_2 -----------------------------*/
  // squared norm of z1 (before the NTT), and w' = LSB(z1[0] - c)
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
  if (sqnorm2 + polyveck_sqnorm2(&z2) > HAETAE_B2SQ) {
    return -1;
  }

  /*------------------- 3. Compute c' and Compare -------------------------*/

  // Pack w (the recovered highbits) and w'
  pack_vec_highbits(buf, &w);
  pack_poly_lsb(buf + HAETAE_POLYVECK_HIGHBITS_PACKEDBYTES, &wprime);

  xof256_absorb_thrice(&state, vk, HAETAE_CRYPTO_PUBLICKEYBYTES, pre, prelen, m,
                       mlen);
  xof256_squeeze(mu, HAETAE_SEEDBYTES, &state);
  // c' = H(HighBits(A * round(y) mod 2q), LSB(round(y0) * j), mu)
  poly_challenge(&cprime, buf, mu);

  for (i = 0; i < HAETAE_N; ++i) {
    if (c.coeffs[i] != cprime.coeffs[i]) {
      return -1;
    }
  }
  return 0;
}

/*************************************************
 * Name:        crypto_sign_verify_ctx
 *
 * Description: Verifies signature.
 *
 * Arguments:   - const uint8_t *sig: pointer to input signature
 *              - size_t siglen: length of signature
 *              - const uint8_t *m: pointer to message
 *              - size_t mlen: length of message
 *              - const uint8_t *ctx: pointer to context string
 *              - size_t ctxlen: length of context string
 *              - const uint8_t *vk: pointer to bit-packed public key
 *
 * Returns 0 if signature could be verified correctly and -1 otherwise
 *
 * Specification: Implements @[Algorithm 53, Verify]
 **************************************************/
int crypto_sign_verify_ctx(const uint8_t *sig, size_t siglen, const uint8_t *m,
                           size_t mlen, const uint8_t *ctx, size_t ctxlen,
                           const uint8_t *vk) {
  uint8_t pre[256];

  if (ctxlen > 255 || (ctx == NULL && ctxlen > 0))
    return -1;

  pre[0] = ctxlen;
  if (ctxlen > 0)
    memcpy(pre + 1, ctx, ctxlen);

  return crypto_sign_verify_internal(sig, siglen, m, mlen, pre, 1 + ctxlen, vk);
}

/*************************************************
 * Name:        crypto_sign_open_ctx
 *
 * Description: Verify signed message.
 *
 * Arguments:   - uint8_t *m: pointer to output message (allocated
 *                            array with smlen bytes), can be equal to sm
 *              - size_t *mlen: pointer to output length of message
 *              - const uint8_t *sm: pointer to signed message
 *              - size_t smlen: length of signed message
 *              - const uint8_t *ctx: pointer to context string
 *              - size_t ctxlen: length of context string
 *              - const uint8_t *vk: pointer to bit-packed public key
 *
 * Returns 0 if signed message could be verified correctly and -1 otherwise
 **************************************************/
int crypto_sign_open_ctx(uint8_t *m, size_t *mlen, const uint8_t *sm,
                         size_t smlen, const uint8_t *ctx, size_t ctxlen,
                         const uint8_t *vk) {
  size_t i;

  if (smlen < HAETAE_CRYPTO_BYTES)
    goto badsig;

  *mlen = smlen - HAETAE_CRYPTO_BYTES;
  if (crypto_sign_verify_ctx(sm, HAETAE_CRYPTO_BYTES, sm + HAETAE_CRYPTO_BYTES,
                             *mlen, ctx, ctxlen, vk))
    goto badsig;
  else {
    /* All good, copy msg, return 0 */
    for (i = 0; i < *mlen; ++i)
      m[i] = sm[HAETAE_CRYPTO_BYTES + i];
    return 0;
  }

badsig:
  /* Signature verification failed */
  *mlen = -1;
  for (i = 0; i < smlen; ++i)
    m[i] = 0;

  return -1;
}
