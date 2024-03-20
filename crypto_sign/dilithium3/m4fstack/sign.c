#include <stdint.h>
#include "params.h"
#include "sign.h"
#include "packing.h"
#include "polyvec.h"
#include "poly.h"
#include "randombytes.h"
#include "symmetric.h"
#include "smallpoly.h"
#include "stack.h"

#include "smallntt.h"

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
  uint8_t seedbuf[2*SEEDBYTES + CRHBYTES];
  uint8_t tr[TRBYTES];
  const uint8_t *rho, *rhoprime, *key;
  polyvecl mat[K];
  polyvecl s1, s1hat;
  polyveck s2, t1, t0;

  /* Get randomness for rho, rhoprime and key */
  randombytes(seedbuf, SEEDBYTES);
  shake256(seedbuf, 2*SEEDBYTES + CRHBYTES, seedbuf, SEEDBYTES);
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
*              - uint8_t *sk:    pointer to bit-packed secret key
*
* Returns 0 (success)
**************************************************/
int crypto_sign_signature(uint8_t *sig,
                          size_t *siglen,
                          const uint8_t *m,
                          size_t mlen,
                          const uint8_t *sk)
{
  uint8_t buf[2 * CRHBYTES];
  uint8_t *mu, *rhoprime, *rnd;
  const uint8_t *rho, *tr, *key;
  uint16_t nonce = 0;
  unsigned int n;
  uint8_t wcomp[K][768];
  uint8_t ccomp[68];

  union {
    shake128incctx s128;
    shake256incctx s256;
  } state;

  union {
    poly full;
    struct {
      smallpoly stmp0;
      smallpoly stmp1;
    } small;
  } polybuffer;

  poly      *tmp0  = &polybuffer.full;
  smallpoly *stmp0 = &polybuffer.small.stmp0;
  smallpoly *scp   = &polybuffer.small.stmp1;

  rho = sk;
  tr = sk + SEEDBYTES*2;
  key = sk + SEEDBYTES;
  
  mu = buf;
  rnd = mu + CRHBYTES;
  rhoprime = mu + CRHBYTES;
  unpack_sk_stack(rho, tr, key, sk);

  /* Compute mu = CRH(tr, msg) */
  shake256_inc_init(&state.s256);
  shake256_inc_absorb(&state.s256, tr, TRBYTES);
  shake256_inc_absorb(&state.s256, m, mlen);
  shake256_inc_finalize(&state.s256);
  shake256_inc_squeeze(mu, CRHBYTES, &state.s256);

  // Note: RNDBYTES < CRHBYTES, so buffer has proper size
  for (n = 0; n < RNDBYTES; n++) {
     rnd[n] = 0;
  }

  shake256_inc_init(&state.s256);
  shake256_inc_absorb(&state.s256, key, SEEDBYTES);
  shake256_inc_absorb(&state.s256, rnd, RNDBYTES);
  shake256_inc_absorb(&state.s256, mu, CRHBYTES);
  shake256_inc_finalize(&state.s256);
  // rnd can be overwritten here
  shake256_inc_squeeze(rhoprime, CRHBYTES, &state.s256);

rej:  
    for (size_t k_idx = 0; k_idx < K; k_idx++) {
      for(size_t i=0;i<768;i++){
        wcomp[k_idx][i] = 0;
      }
    }

      for (size_t l_idx = 0; l_idx < L; l_idx++) {
        /* Sample intermediate vector y */
        poly_uniform_gamma1_stack(tmp0, rhoprime, L*nonce + l_idx, &state.s256);
        poly_ntt(tmp0);

        /* Matrix-vector multiplication */
        for (size_t k_idx = 0; k_idx < K; k_idx++) {
          // sampling of y and packing into wcomp inlined into the basemul
          poly_uniform_pointwise_montgomery_polywadd_stack(wcomp[k_idx], tmp0, rho, (k_idx << 8) + l_idx, &state.s128);
        }
      }
      nonce++;
      for (size_t k_idx = 0; k_idx < K; k_idx++) {
        polyw_unpack(tmp0, wcomp[k_idx]);
        poly_invntt_tomont(tmp0);
        poly_caddq(tmp0);

        polyw_pack(wcomp[k_idx], tmp0);
        poly_highbits(tmp0, tmp0);
        polyw1_pack(&sig[k_idx*POLYW1_PACKEDBYTES], tmp0);
      }

  shake256_inc_init(&state.s256);
  shake256_inc_absorb(&state.s256, mu, CRHBYTES);
  shake256_inc_absorb(&state.s256, sig, K*POLYW1_PACKEDBYTES);
  shake256_inc_finalize(&state.s256);
  shake256_inc_squeeze(sig, CTILDEBYTES, &state.s256);
  poly_challenge(tmp0, sig);

  poly_challenge_compress(ccomp, tmp0);
  
  /* Compute z, reject if it reveals secret */
    for(size_t l_idx=0;l_idx < L; l_idx++){
    if(l_idx != 0){
      poly_challenge_decompress(tmp0, ccomp);
    }
      poly_small_ntt_copy(scp, tmp0);
      unpack_sk_s1(stmp0, sk, l_idx);
      small_ntt(stmp0->coeffs);
      poly_small_basemul_invntt(tmp0, scp, stmp0);

      poly_uniform_gamma1_add_stack(tmp0, tmp0, rhoprime, L*(nonce-1) + l_idx, &state.s256);

      poly_reduce(tmp0);

      if(poly_chknorm(tmp0, GAMMA1 - BETA))
        goto rej;

      polyz_pack(sig + CTILDEBYTES + l_idx*POLYZ_PACKEDBYTES, tmp0);
  }


  /* Write signature */
  unsigned int hint_n = 0;
  unsigned int hints_written = 0;
  /* Check that subtracting cs2 does not change high bits of w and low bits
   * do not reveal secret information */
  
  for(unsigned int k_idx = 0; k_idx < K; ++k_idx) {
    poly_challenge_decompress(tmp0, ccomp);
    poly_small_ntt_copy(scp, tmp0);

    unpack_sk_s2(stmp0, sk, k_idx);
    small_ntt(stmp0->coeffs);
    poly_small_basemul_invntt(tmp0, scp, stmp0);

    polyw_sub(tmp0, wcomp[k_idx], tmp0);
    poly_reduce(tmp0);

    polyw_pack(wcomp[k_idx], tmp0);

    poly_lowbits(tmp0, tmp0);
    poly_reduce(tmp0);
    if(poly_chknorm(tmp0, GAMMA2 - BETA)){
      goto rej;
    }

    poly_schoolbook(tmp0, ccomp, sk + SEEDBYTES + TRBYTES + SEEDBYTES +
      L*POLYETA_PACKEDBYTES + K*POLYETA_PACKEDBYTES + k_idx*POLYT0_PACKEDBYTES);

    /* Compute hints for w1 */

    if(poly_chknorm(tmp0, GAMMA2)) {
      goto rej;
    }

    hint_n += poly_make_hint_stack(tmp0, tmp0, wcomp[k_idx]);

    if (hint_n > OMEGA) {
      goto rej;
    }
    pack_sig_h(sig, tmp0, k_idx, &hints_written);
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
int crypto_sign(uint8_t *sm,
                size_t *smlen,
                const uint8_t *m,
                size_t mlen,
                const uint8_t *sk)
{
  size_t i;

  for(i = 0; i < mlen; ++i)
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
int crypto_sign_verify(const uint8_t *sig,
                       size_t siglen,
                       const uint8_t *m,
                       size_t mlen,
                       const uint8_t *pk)
{
  unsigned int i;
  uint8_t w1_packed[POLYW1_PACKEDBYTES];
  uint8_t rho[SEEDBYTES];
  uint8_t mu[CRHBYTES];
  uint8_t c[CTILDEBYTES];
  uint8_t c2[CTILDEBYTES];
  poly w1, tmp0, tmp1;
  shake256incctx state;

  uint8_t wcomp[768];
  uint8_t ccomp[68];

  if(siglen != CRYPTO_BYTES)
    return -1;

  for(i = 0; i < SEEDBYTES; ++i)
    rho[i] = pk[i];

  /* Compute CRH(h(rho, t1), msg) */
  shake256(mu, TRBYTES, pk, CRYPTO_PUBLICKEYBYTES);
  shake256_inc_init(&state);
  shake256_inc_absorb(&state, mu, TRBYTES);
  shake256_inc_absorb(&state, m, mlen);
  shake256_inc_finalize(&state);
  shake256_inc_squeeze(mu, CRHBYTES, &state);

  /* Matrix-vector multiplication; compute Az - c2^dt1 */
  poly_challenge(&tmp0, sig);
  poly_challenge_compress(ccomp, &tmp0);

  shake256_inc_init(&state);
  shake256_inc_absorb(&state, mu, CRHBYTES);

  for (size_t k_idx = 0; k_idx < K; k_idx++) {
    polyz_unpack(&tmp1, sig + CTILDEBYTES);
    if(poly_chknorm(&tmp1, GAMMA1 - BETA))
      return -1;
    poly_ntt(&tmp1);
    
    poly_uniform(&tmp0, rho, (k_idx << 8) + 0);
    poly_pointwise_montgomery(&w1,  &tmp0, &tmp1);
    for (size_t l_idx = 1; l_idx < L; l_idx++) {
      polyz_unpack(&tmp1, sig + CTILDEBYTES + l_idx*POLYZ_PACKEDBYTES);
      if(poly_chknorm(&tmp1, GAMMA1 - BETA))
        return -1;
      poly_ntt(&tmp1);
      poly_uniform(&tmp0, rho, (k_idx << 8) + l_idx);
      poly_pointwise_acc_montgomery(&w1,  &tmp0, &tmp1);
    }
    
    poly_reduce(&w1);
    poly_invntt_tomont(&w1);
    
    poly_schoolbook_t1(&tmp0, ccomp, pk + SEEDBYTES + k_idx*POLYT1_PACKEDBYTES);

    poly_sub(&w1, &w1, &tmp0);
    poly_reduce(&w1);

    /* Reconstruct w1 */
    poly_caddq(&w1);

    if (unpack_sig_h(&tmp0, k_idx, sig) != 0) {
      return -1;
    };
    poly_use_hint(&w1, &w1, &tmp0);
    polyw1_pack(w1_packed, &w1);

    shake256_inc_absorb(&state, w1_packed, POLYW1_PACKEDBYTES);
  }
  /* Call random oracle and verify challenge */
  shake256_inc_finalize(&state);
  shake256_inc_squeeze(c2, CTILDEBYTES, &state);
  for(i = 0; i < CTILDEBYTES; ++i)
    if(sig[i] != c2[i])
      return -1;

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
int crypto_sign_open(uint8_t *m,
                     size_t *mlen,
                     const uint8_t *sm,
                     size_t smlen,
                     const uint8_t *pk)
{
  size_t i;

  if(smlen < CRYPTO_BYTES)
    goto badsig;

  *mlen = smlen - CRYPTO_BYTES;
  if(crypto_sign_verify(sm, CRYPTO_BYTES, sm + CRYPTO_BYTES, *mlen, pk))
    goto badsig;
  else {
    /* All good, copy msg, return 0 */
    for(i = 0; i < *mlen; ++i)
      m[i] = sm[CRYPTO_BYTES + i];
    return 0;
  }

badsig:
  /* Signature verification failed */
  *mlen = -1;
  for(i = 0; i < smlen; ++i)
    m[i] = 0;

  return -1;
}
