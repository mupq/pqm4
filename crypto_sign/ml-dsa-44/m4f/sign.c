#include <stdint.h>
#include "params.h"
#include "sign.h"
#include "packing.h"
#include "polyvec.h"
#include "poly.h"
#include "randombytes.h"
#include "symmetric.h"
#include "smallpoly.h"

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
  uint8_t seedbuf[2 * SEEDBYTES + CRHBYTES];
  uint8_t tr[TRBYTES];
  const uint8_t *rho, *rhoprime, *key;
  polyvecl mat[K];
  polyvecl s1, s1hat;
  polyveck s2, t1, t0;

  /* Get randomness for rho, rhoprime and key */
  randombytes(seedbuf, SEEDBYTES);
  seedbuf[SEEDBYTES + 0] = K;
  seedbuf[SEEDBYTES + 1] = L;
  shake256(seedbuf, 2 * SEEDBYTES + CRHBYTES, seedbuf, SEEDBYTES + 2);
  rho = seedbuf;
  rhoprime = rho + SEEDBYTES;
  key = rhoprime + CRHBYTES;

  /* Expand matrix */
  polyvec_matrix_expand(mat, rho);

  /* Sample short vectors s1 and s2 */
  polyvecl_uniform_eta(&s1, rhoprime, 0);
  polyveck_uniform_eta(&s2, rhoprime, L);

  /* Matrix-vector multiplication */
  s1hat = s1;
  polyvecl_ntt(&s1hat);
  polyvec_matrix_pointwise_montgomery(&t1, mat, &s1hat);
  polyveck_reduce(&t1);
  polyveck_invntt_tomont(&t1);

  /* Add error vector s2 */
  polyveck_add(&t1, &t1, &s2);

  /* Extract t1 and write public key */
  polyveck_caddq(&t1);
  polyveck_power2round(&t1, &t0, &t1);
  pack_pk(pk, rho, &t1);

  /* Compute H(rho, t1) and write secret key */
  shake256(tr, TRBYTES, pk, CRYPTO_PUBLICKEYBYTES);
  pack_sk(sk, rho, tr, key, &t0, &s1, &s2);

  return 0;
}

/*************************************************
* Name:        crypto_sign_signature
*
* Description: Computes signature.
*
* Arguments:   - uint8_t *sig:   pointer to output signature (of length CRYPTO_BYTES)
*              - size_t *siglen: pointer to output length of signature
*              - uint8_t *m:     pointer to message to be signed
*              - size_t mlen:    length of message
*              - uint8_t *ctx:   pointer to context string
*              - size_t ctxlen:  length of context string
*              - uint8_t *sk:    pointer to bit-packed secret key
*
* Returns 0 (success) or -1 (context string too long)
**************************************************/
int crypto_sign_signature_ctx(uint8_t *sig,
                          size_t *siglen,
                          const uint8_t *m,
                          size_t mlen,
                          const uint8_t *ctx,
                          size_t ctxlen,
                          const uint8_t *sk) {
  uint8_t seedbuf[2 * SEEDBYTES + TRBYTES + RNDBYTES + 2 * CRHBYTES];
  uint8_t *rho, *tr, *key, *mu, *rhoprime, *rnd;
  uint16_t nonce = 0;
  polyvecl mat[K], y, z;
  polyveck t0, w1, w0;
  poly cp;
  shake256incctx state;

  smallpoly s1_prime[L];
  smallpoly s2_prime[K];
  smallpoly cp_small;
  smallhalfpoly cp_small_prime;

  if (ctxlen > 255) {
    return -1;
  }

  rho = seedbuf;
  tr = rho + SEEDBYTES;
  key = tr + TRBYTES;
  rnd = key + SEEDBYTES;
  mu = rnd + RNDBYTES;
  rhoprime = mu + CRHBYTES;
  unpack_sk(rho, tr, key, &t0, s1_prime, s2_prime, sk);

  /* Compute mu = CRH(tr, 0, ctxlen, ctx, msg) */
  mu[0] = 0;
  mu[1] = (uint8_t)ctxlen;
  shake256_inc_init(&state);
  shake256_inc_absorb(&state, tr, TRBYTES);
  shake256_inc_absorb(&state, mu, 2);
  shake256_inc_absorb(&state, ctx, ctxlen);
  shake256_inc_absorb(&state, m, mlen);
  shake256_inc_finalize(&state);
  shake256_inc_squeeze(mu, CRHBYTES, &state);

  randombytes(rnd, RNDBYTES);
  shake256(rhoprime, CRHBYTES, key, SEEDBYTES + RNDBYTES + CRHBYTES);

  /* Expand matrix and transform vectors */
  polyvec_matrix_expand(mat, rho);
  polyvecl_small_ntt(s1_prime);
  polyveck_small_ntt(s2_prime);

  polyveck_ntt(&t0);

rej:
  /* Sample intermediate vector y */
  polyvecl_uniform_gamma1(&y, rhoprime, nonce++);

  /* Matrix-vector multiplication */
  z = y;
  polyvecl_ntt(&z);
  polyvec_matrix_pointwise_montgomery(&w1, mat, &z);
  polyveck_reduce(&w1);
  polyveck_invntt_tomont(&w1);

  /* Decompose w and call the random oracle */
  polyveck_caddq(&w1);
  polyveck_decompose(&w1, &w0, &w1);
  polyveck_pack_w1(sig, &w1);

  shake256_inc_init(&state);
  shake256_inc_absorb(&state, mu, CRHBYTES);
  shake256_inc_absorb(&state, sig, K * POLYW1_PACKEDBYTES);
  shake256_inc_finalize(&state);
  shake256_inc_squeeze(sig, CTILDEBYTES, &state);
  poly_challenge(&cp, sig);
  
  poly_small_ntt_precomp(&cp_small, &cp_small_prime, &cp);
  poly_ntt(&cp);

  /* Compute z, reject if it reveals secret */
  polyvecl_small_basemul_invntt(&z, &cp_small, &cp_small_prime, s1_prime);

  polyvecl_add(&z, &z, &y);
  polyvecl_reduce(&z);
  if(polyvecl_chknorm(&z, GAMMA1 - BETA)) {
    goto rej;
  }


  /* Write signature */
  pack_sig_z(sig, &z);
  unsigned int hint_n = 0;
  unsigned int hints_written = 0;
  /* Check that subtracting cs2 does not change high bits of w and low bits
   * do not reveal secret information */
  for(unsigned int i = 0; i < K; ++i) {
    poly *tmp = &z.vec[0];
    poly_small_basemul_invntt(tmp, &cp_small, &cp_small_prime, &s2_prime[i]);

    poly_sub(&w0.vec[i], &w0.vec[i], tmp);
    poly_reduce(&w0.vec[i]);
    if(poly_chknorm(&w0.vec[i], GAMMA2 - BETA))
      goto rej;

    /* Compute hints for w1 */
    poly_pointwise_montgomery(tmp, &cp, &t0.vec[i]);

    poly_invntt_tomont(tmp);
    poly_reduce(tmp);

    if(poly_chknorm(tmp, GAMMA2))
      goto rej;
    poly_add(&w0.vec[i], &w0.vec[i], tmp);
    hint_n += poly_make_hint(tmp, &w0.vec[i], &w1.vec[i]);
    if (hint_n > OMEGA) {
      goto rej;
    }
    pack_sig_h(sig, tmp, i, &hints_written);
  }
  pack_sig_h_zero(sig, &hints_written);
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
int crypto_sign_ctx(uint8_t *sm,
                size_t *smlen,
                const uint8_t *m,
                size_t mlen,
                const uint8_t *ctx,
                size_t ctxlen,
                const uint8_t *sk)
{
  int ret;
  size_t i;

  for(i = 0; i < mlen; ++i) {
    sm[CRYPTO_BYTES + mlen - 1 - i] = m[mlen - 1 - i];
  }
  ret = crypto_sign_signature_ctx(sm, smlen, sm + CRYPTO_BYTES, mlen, ctx, ctxlen, sk);
  *smlen += mlen;
  return ret;
}
/*************************************************
 * Name:        expand_mat_elem
 *
 * Description: Implementation of ExpandA. Generates matrix A with uniformly
 *              random coefficients a_{i,j} by performing rejection
 *              sampling on the output stream of SHAKE128(rho|i|j).
 *
 * Arguments:   - poly mat_elem: output matrix element
 *              - const unsigned char rho[]: byte array containing seed rho
 *              - k_idx: matrix row index
 *              - l_idx: matrix col index
 **************************************************/
static void expand_mat_elem(poly *mat_elem, const unsigned char rho[SEEDBYTES], size_t k_idx, size_t l_idx)
{
  poly_uniform(mat_elem, rho, (uint16_t)((k_idx << 8) + l_idx));
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
 *              - const uint8_t *ctx: pointer to context string
 *              - size_t ctxlen: length of context string
 *              - const uint8_t *pk: pointer to bit-packed public key
 *
 * Returns 0 if signature could be verified correctly and -1 otherwise
 **************************************************/
int crypto_sign_verify_ctx(const uint8_t *sig,
                       size_t siglen,
                       const uint8_t *m,
                       size_t mlen,
                       const uint8_t *ctx,
                       size_t ctxlen,
                       const uint8_t *pk)
{
  unsigned int i;
  const uint8_t *rho = pk;
  uint8_t mu[CRHBYTES];
  uint8_t c[CTILDEBYTES];
  uint8_t c2[CTILDEBYTES];
  poly cp;
  polyvecl z;
  shake256incctx state;

  poly tmp_elem, w1_elem;

  if (ctxlen > 255 || siglen != CRYPTO_BYTES) {
      return -1;
  }


  if (unpack_sig_z(&z, sig) != 0) {
    return -1;
  }
  if (polyvecl_chknorm(&z, GAMMA1 - BETA))
    return -1;

  /* Compute mu = CRH(H(rho, t1), 0, ctxlen, ctx, msg) */
  shake256(mu, TRBYTES, pk, CRYPTO_PUBLICKEYBYTES);
  shake256_inc_init(&state);
  shake256_inc_absorb(&state, mu, TRBYTES);
  mu[0] = 0;
  mu[1] = (uint8_t)ctxlen;
  shake256_inc_absorb(&state, mu, 2);
  shake256_inc_absorb(&state, ctx, ctxlen);
  shake256_inc_absorb(&state, m, mlen);
  shake256_inc_finalize(&state);
  shake256_inc_squeeze(mu, CRHBYTES, &state);

  // Hash [mu || w1'] to get c.
  shake256_inc_init(&state);
  shake256_inc_absorb(&state, mu, CRHBYTES);

  /* Matrix-vector multiplication; compute Az - c2^dt1 */
  if (unpack_sig_c(c, sig) != 0) {
    return -1;
  }
  poly_challenge(&cp, c);
  poly_ntt(&cp);
  polyvecl_ntt(&z);


  for (size_t k_idx = 0; k_idx < K; k_idx++)
  {
    // Sample the current element from A.
    expand_mat_elem(&tmp_elem, rho, k_idx, 0);
    poly_pointwise_montgomery(&w1_elem, &tmp_elem, &z.vec[0]);

    for (size_t l_idx = 1; l_idx < L; l_idx++)
    {
      // Sample the element from A.
      expand_mat_elem(&tmp_elem, rho, k_idx, l_idx);
      poly_pointwise_acc_montgomery(&w1_elem, &tmp_elem, &z.vec[l_idx]);
    }

    // Subtract c*(t1_{k_idx} * 2^d)
    unpack_pk_t1(&tmp_elem, k_idx, pk);
    poly_shiftl(&tmp_elem);
    poly_ntt(&tmp_elem);
    poly_pointwise_montgomery(&tmp_elem, &cp, &tmp_elem);
    poly_sub(&w1_elem, &w1_elem, &tmp_elem);
    poly_reduce(&w1_elem);
    poly_invntt_tomont(&w1_elem);

    // Reconstruct w1
    poly_caddq(&w1_elem);
    if (unpack_sig_h(&tmp_elem, k_idx, sig) != 0) {
      return -1;
    }
    poly_use_hint(&w1_elem, &w1_elem, &tmp_elem);
    uint8_t w1_packed[POLYW1_PACKEDBYTES];
    polyw1_pack(w1_packed, &w1_elem);
    shake256_inc_absorb(&state, w1_packed, POLYW1_PACKEDBYTES);
  }


  /* Call random oracle and verify challenge */
  shake256_inc_finalize(&state);
  shake256_inc_squeeze(c2, CTILDEBYTES, &state);
  for (i = 0; i < CTILDEBYTES; ++i) {
    if (c[i] != c2[i])
      return -1;
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
*              - const uint8_t *ctx: pointer to context tring
*              - size_t ctxlen: length of context string
*              - const uint8_t *pk: pointer to bit-packed public key
*
* Returns 0 if signed message could be verified correctly and -1 otherwise
**************************************************/
int crypto_sign_open_ctx(uint8_t *m,
                     size_t *mlen,
                     const uint8_t *sm,
                     size_t smlen,
                     const uint8_t *ctx,
                     size_t ctxlen,
                     const uint8_t *pk)
{
  size_t i;

  if(smlen < CRYPTO_BYTES)
    goto badsig;

  *mlen = smlen - CRYPTO_BYTES;
  if(crypto_sign_verify_ctx(sm, CRYPTO_BYTES, sm + CRYPTO_BYTES, *mlen, ctx, ctxlen, pk))
    goto badsig;
  else {
    /* All good, copy msg, return 0 */
    for (i = 0; i < *mlen; ++i) {
      m[i] = sm[CRYPTO_BYTES + i];
    }
    return 0;
  }

badsig:
  /* Signature verification failed */
  *mlen = 0;
  for (i = 0; i < smlen; ++i) {
    m[i] = 0;
  }

  return -1;
}
