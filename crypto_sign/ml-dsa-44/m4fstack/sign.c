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
  unsigned int i, j;
  uint8_t seedbuf[2*SEEDBYTES + CRHBYTES];
  const uint8_t *rho, *rhoprime, *key;

  poly tA, tB;

  union {
    uint8_t tr[TRBYTES];
    shake256incctx s256;
    poly tC;
  } data;

  shake256incctx *s256 = &data.s256;
  uint8_t *tr          = &data.tr[0];
  poly *tC             = &data.tC;

  /* Get randomness for rho, rhoprime and key */
  randombytes(seedbuf, SEEDBYTES);
  seedbuf[SEEDBYTES + 0] = K;
  seedbuf[SEEDBYTES + 1] = L;
  shake256_inc_init(s256);
  shake256_inc_absorb(s256, seedbuf, SEEDBYTES + 2);
  shake256_inc_finalize(s256);
  shake256_inc_squeeze(seedbuf, 2*SEEDBYTES + CRHBYTES, s256);

  rho = seedbuf;
  rhoprime = rho + SEEDBYTES;
  key = rhoprime + CRHBYTES;

  pack_sk_rho(sk, rho);
  pack_sk_key(sk, key);
  pack_pk_rho(pk, rho);

  /* Matrix-vector multiplication */
  for (i = 0; i < K; i++)
  {
    /* Expand part of s1 */
    poly_uniform_eta(tC, rhoprime, 0);
    if (i == 0)
    {
      pack_sk_s1(sk, tC, 0);
    }
    poly_ntt(tC);
    /* expand part of the matrix */
    poly_uniform(&tB, rho, (i << 8) + 0);
    /* partial matrix-vector multiplication */
    poly_pointwise_montgomery(&tA, &tB, tC);
    for(j = 1; j < L; j++)
    {
      /* Expand part of s1 */
      poly_uniform_eta(tC, rhoprime, j);
      if (i == 0)
      {
        pack_sk_s1(sk, tC, j);
      }
      poly_ntt(tC);
      poly_uniform(&tB, rho, (i << 8) + j);
      poly_pointwise_acc_montgomery(&tA, &tB, tC);
    }

    poly_reduce(&tA);
    poly_invntt_tomont(&tA);

    /* Add error vector s2 */
    /* Sample short vector s2 */
    poly_uniform_eta(&tB, rhoprime, L + i);
    pack_sk_s2(sk, &tB, i);
    poly_add(&tA, &tA, &tB);

    /* Compute t{0,1} */
    poly_caddq(&tA);
    poly_power2round(tC, &tB, &tA);
    pack_sk_t0(sk, &tB, i);
    pack_pk_t1(pk, tC, i);

  }

  /* Compute H(rho, t1) and write secret key */
  shake256(tr, TRBYTES, pk, CRYPTO_PUBLICKEYBYTES);
  pack_sk_tr(sk, tr);

  return 0;
}


typedef union {
  shake128incctx s128;
  shake256incctx s256;
} sign_state;

typedef union {
  poly full;
  struct {
    smallpoly stmp0;
    smallpoly stmp1;
  } small;
} sign_polybuffer;

/* w = A*y in the 24-bit packed wcomp. Each packed mask y[l] is kept in its z slot of sig, so that ExpandMask runs
 * once per y[l] in an attempt; sig therefore cannot hold w1, which is packed in place and absorbed into H(mu || w1) row by row. */
static void sign_compute_w(uint8_t *sig,
                           uint8_t wcomp[K][768],
                           uint16_t nonce,
                           const uint8_t *rho,
                           const uint8_t *rhoprime,
                           const uint8_t *mu,
                           sign_polybuffer *polybuffer,
                           sign_state *state) {
  poly *tmp0 = &polybuffer->full;

  for (size_t k_idx = 0; k_idx < K; k_idx++) {
    for(size_t i=0;i<768;i++){
      wcomp[k_idx][i] = 0;
    }
  }

  for (size_t l_idx = 0; l_idx < L; l_idx++) {
    /* Sample intermediate vector y */
    poly_uniform_gamma1_keep(tmp0, sig + CTILDEBYTES + l_idx*POLYZ_PACKEDBYTES, rhoprime, L*nonce + l_idx, &state->s256);
    poly_ntt(tmp0);

    /* Matrix-vector multiplication */
    for (size_t k_idx = 0; k_idx < K; k_idx++) {
      // sampling of a and packing into wcomp inlined into the basemul
      poly_uniform_pointwise_montgomery_polywadd_block(wcomp[k_idx], tmp0, rho, (k_idx << 8) + l_idx, &state->s128);
    }
  }

  shake256_inc_init(&state->s256);
  shake256_inc_absorb(&state->s256, mu, CRHBYTES);
  for (size_t k_idx = 0; k_idx < K; k_idx++) {
    polyw_unpack(tmp0, wcomp[k_idx]);
    poly_invntt_tomont(tmp0);

    polyw_pack_w1(wcomp[k_idx], (uint8_t *)tmp0, tmp0);
    shake256_inc_absorb(&state->s256, (uint8_t *)tmp0, POLYW1_PACKEDBYTES);
  }
}

/* Challenge, then z = y + c*s1 (in place in sig) and r0 = LowBits(w - c*s2) row by row; both checks stop at the
 * first coefficient that violates the bound. The products c*t0 are deferred to sign_compute_hints.
 * Returns -1 if the attempt is rejected. */
static int sign_compute_z_r0(uint8_t *sig,
                             uint8_t ccomp[68],
                             uint8_t wcomp[K][768],
                             const uint8_t *sk,
                             sign_polybuffer *polybuffer,
                             sign_state *state) {
  poly      *tmp0  = &polybuffer->full;
  smallpoly *stmp0 = &polybuffer->small.stmp0;
  smallpoly *scp   = &polybuffer->small.stmp1;

  shake256_inc_finalize(&state->s256);
  shake256_inc_squeeze(sig, CTILDEBYTES, &state->s256);
  /* the hash state and ccomp are unused here */
  poly_challenge_extbuf(tmp0, sig, &state->s256, ccomp);
  poly_challenge_compress(ccomp, tmp0);

  /* NTT_769(c) is written to the upper half of the buffer (poly_small_ntt_copy copies backwards, so reading the
   * 32-bit c from the same buffer is safe) and stays there for all rows; the 16-bit products live in the lower half */
  poly_small_ntt_copy(scp, tmp0);

  /* Compute z, reject if it reveals secret */
  for (unsigned int i = 0; i < L; i++) {
    unpack_sk_s1(stmp0, sk, i);
    poly_small_ntt_basemul_invntt(stmp0, scp);

    if (polyz_add_reduce_check_inplace(sig + CTILDEBYTES + i*POLYZ_PACKEDBYTES, stmp0, GAMMA1 - BETA) < 0) {
      return -1;
    }
  }

  /* Check that subtracting cs2 does not change high bits of w and low bits
   * do not reveal secret information. All of z has been accepted at this point. */
  for (unsigned int i = 0; i < K; i++) {
    unpack_sk_s2(stmp0, sk, i);
    poly_small_ntt_basemul_invntt(stmp0, scp);

    if (polyw_sub_cs2_check_r0(wcomp[i], stmp0, GAMMA2 - BETA) < 0) {
      return -1;
    }
  }
  return 0;
}

/* c*t0 and the hints, only for attempts that passed all z and r0 checks. Row 0 uses the schoolbook product; its
 * slot of wcomp is free afterwards and holds NTT(c) in 24-bit packed form for the NTT products of the other rows.
 * Returns -1 if the attempt is rejected. */
static int sign_compute_hints(uint8_t *sig,
                              const uint8_t ccomp[68],
                              uint8_t wcomp[K][768],
                              const uint8_t *sk,
                              sign_polybuffer *polybuffer) {
  poly *tmp0 = &polybuffer->full;
  unsigned int hints_written = 0;
  const uint8_t *t0 = sk + SEEDBYTES + TRBYTES + SEEDBYTES + L*POLYETA_PACKEDBYTES + K*POLYETA_PACKEDBYTES;

  for (unsigned int k_idx = 0; k_idx < K; ++k_idx) {
    if (k_idx == 0) {
      poly_schoolbook(tmp0, ccomp, t0);
    } else {
      if (k_idx == 1) {
        poly_challenge_decompress(tmp0, ccomp);
        poly_ntt(tmp0);
        polyw_pack(wcomp[0], tmp0);
      }
      polyt0_unpack(tmp0, t0 + k_idx*POLYT0_PACKEDBYTES);
      poly_ntt(tmp0);
      poly_pointwise_montgomery_polyw(tmp0, wcomp[0]);
      poly_invntt_tomont(tmp0);
      poly_reduce(tmp0);
    }

    /* Compute hints for w1 */
    if (poly_chknorm(tmp0, GAMMA2)) {
      return -1;
    }

    if (poly_make_hint_pack_stack(sig, k_idx, &hints_written, tmp0, wcomp[k_idx]) < 0) {
      return -1;
    }
  }
  pack_sig_h_zero(sig, &hints_written);
  return 0;
}

/*************************************************
* Name:        crypto_sign_signature
*
* Description: Computes signature.
*
* Arguments:   - uint8_t *sig:   pointer to output signature (of length CRYPTO_BYTES).
*                                The buffer must remain private to the signer until the
*                                call returns because it temporarily holds the secret mask.
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
  uint8_t buf[2 * CRHBYTES];
  uint8_t *mu, *rhoprime, *rnd;
  const uint8_t *rho, *tr, *key;
  uint16_t nonce = 0;
  uint8_t wcomp[K][768];
  uint8_t ccomp[68];

  sign_state state;
  sign_polybuffer polybuffer;

  rho = sk;
  tr = sk + SEEDBYTES*2;
  key = sk + SEEDBYTES;
  
  mu = buf;
  rnd = mu + CRHBYTES;
  rhoprime = mu + CRHBYTES;

  if (ctxlen > 255) {
    return -1;
  }

  /* Compute mu = CRH(tr, 0, ctxlen, ctx, msg) */
  mu[0] = 0;
  mu[1] = (uint8_t)ctxlen;
  shake256_inc_init(&state.s256);
  shake256_inc_absorb(&state.s256, tr, TRBYTES);
  shake256_inc_absorb(&state.s256, mu, 2);
  shake256_inc_absorb(&state.s256, ctx, ctxlen);
  shake256_inc_absorb(&state.s256, m, mlen);
  shake256_inc_finalize(&state.s256);
  shake256_inc_squeeze(mu, CRHBYTES, &state.s256);

  randombytes(rnd, RNDBYTES);

  shake256_inc_init(&state.s256);
  shake256_inc_absorb(&state.s256, key, SEEDBYTES);
  shake256_inc_absorb(&state.s256, rnd, RNDBYTES);
  shake256_inc_absorb(&state.s256, mu, CRHBYTES);
  shake256_inc_finalize(&state.s256);
  // rnd can be overwritten here
  shake256_inc_squeeze(rhoprime, CRHBYTES, &state.s256);

  for (;;) {
    sign_compute_w(sig, wcomp, nonce, rho, rhoprime, mu, &polybuffer, &state);
    nonce++;

    if (sign_compute_z_r0(sig, ccomp, wcomp, sk, &polybuffer, &state) < 0) {
      continue;
    }

    if (sign_compute_hints(sig, ccomp, wcomp, sk, &polybuffer) < 0) {
      continue;
    }

    break;
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
*                             can be equal to m. The signature part of
*                             the buffer must remain private to the signer
*                             until the call returns because it temporarily
*                             holds the secret mask.
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
  
  poly p;

  union {
    uint8_t w1_packed[POLYW1_PACKEDBYTES];
    uint8_t wcomp[768];
  } w1_packed_comp;
  uint8_t *w1_packed = &w1_packed_comp.w1_packed[0];
  uint8_t *wcomp  = &w1_packed_comp.wcomp[0];

  union {
    uint8_t ccomp[68];
    uint8_t mu[CRHBYTES];
  } ccomp_mu;
  uint8_t *ccomp = &ccomp_mu.ccomp[0];
  uint8_t *mu  = &ccomp_mu.mu[0];

  shake256incctx s256;

  union {
    uint8_t hint_ones[OMEGA];
    shake128incctx s128;
    uint8_t c2[CTILDEBYTES];
  } shake_hint;

  uint8_t *hint_ones   = &shake_hint.hint_ones[0];
  shake128incctx *s128 = &shake_hint.s128;
  uint8_t *c2          = &shake_hint.c2[0];

  if (ctxlen > 255 || siglen != CRYPTO_BYTES) {
      return -1;
  }

  /* Compute mu = CRH(H(rho, t1), 0, ctxlen, ctx, msg) */
  shake256_inc_init(&s256);
  shake256_inc_absorb(&s256, pk, CRYPTO_PUBLICKEYBYTES);
  shake256_inc_finalize(&s256);
  shake256_inc_squeeze(mu, CRHBYTES, &s256);
  shake256_inc_init(&s256);
  shake256_inc_absorb(&s256, mu, TRBYTES);
  mu[0] = 0;
  mu[1] = (uint8_t)ctxlen;
  shake256_inc_absorb(&s256, mu, 2);
  shake256_inc_absorb(&s256, ctx, ctxlen);
  shake256_inc_absorb(&s256, m, mlen);
  shake256_inc_finalize(&s256);
  shake256_inc_squeeze(mu, CRHBYTES, &s256);

  /* The challenge is sampled while the hash state and wcomp are unused,
   * so that neither a second state nor a buffer goes on the stack */
  poly_challenge_extbuf(&p, sig, &s256, wcomp);

  shake256_inc_init(&s256);
  shake256_inc_absorb(&s256, mu, CRHBYTES);

  /* Matrix-vector multiplication; compute Az - c2^dt1 */
  poly_challenge_compress(ccomp, &p); // overwrites mu

  for (size_t k_idx = 0; k_idx < K; k_idx++) {
    for(size_t widx=0;widx<768;widx++){
        wcomp[widx] = 0;
    }

    polyz_unpack(&p, sig + CTILDEBYTES);
    if(k_idx == 0 && poly_chknorm(&p, GAMMA1 - BETA))
      return -1;
    poly_ntt(&p);
    
    poly_uniform_pointwise_montgomery_polywadd_stack(wcomp, &p, pk, (k_idx << 8) + 0, s128);

    for (size_t l_idx = 1; l_idx < L; l_idx++) {
      polyz_unpack(&p, sig + CTILDEBYTES + l_idx*POLYZ_PACKEDBYTES);
      if(k_idx == 0 && poly_chknorm(&p, GAMMA1 - BETA))
        return -1;
      poly_ntt(&p);
      poly_uniform_pointwise_montgomery_polywadd_stack(wcomp, &p, pk, (k_idx << 8) + l_idx, s128);
    }
    polyw_unpack(&p, wcomp);
    poly_reduce(&p);
    poly_invntt_tomont(&p);
    polyw_pack(wcomp, &p);
    
    poly_schoolbook_t1(&p, ccomp, pk + SEEDBYTES + k_idx*POLYT1_PACKEDBYTES);

    polyw_sub(&p, wcomp, &p);
    poly_reduce(&p);

    /* Reconstruct w1 */
    poly_caddq(&p);

    if (unpack_sig_h_indices(hint_ones, &i, k_idx, sig) != 0)
    {
      return -1;
    }
    poly_use_hint_stack(&p, &p, hint_ones, i);

    polyw1_pack(w1_packed, &p);

    shake256_inc_absorb(&s256, w1_packed, POLYW1_PACKEDBYTES);
  }
  /* Call random oracle and verify challenge */
  shake256_inc_finalize(&s256);
  shake256_inc_squeeze(c2, CTILDEBYTES, &s256);
  for (i = 0; i < CTILDEBYTES; ++i) {
    if (sig[i] != c2[i])
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
