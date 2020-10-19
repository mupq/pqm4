#include "fips202.h"
#include "packing.h"
#include "params.h"
#include "poly.h"
#include "polyvec.h"
#include "randombytes.h"
#include "sign.h"
#include "symmetric.h"
#include <stdint.h>
#include <stdbool.h>

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
static void expand_mat_elem(poly *mat_elem, const unsigned char rho[SEEDBYTES], size_t k_idx, size_t l_idx) {
    poly_uniform(mat_elem, rho, (uint16_t)((k_idx << 8) + l_idx));
}

/*************************************************
* Name:        challenge
*
* Description: Implementation of H. Samples polynomial with 60 nonzero
*              coefficients in {-1,1} using the output stream of
*              SHAKE256(mu|w1).
*
* Arguments:   - poly *c: pointer to output polynomial
*              - const unsigned char mu[]: byte array containing mu
*              - const polyveck *w1: pointer to vector w1
**************************************************/
void challenge(poly *c, const unsigned char mu[CRHBYTES], const polyveck *w1){
    unsigned int i, b, pos;
    uint64_t signs;
    unsigned char polyw1_packed[POLYW1_PACKEDBYTES];
    unsigned char outbuf[SHAKE256_RATE];
    shake256incctx state;

    shake256_inc_init(&state);
    shake256_inc_absorb(&state, mu, CRHBYTES);
    for (i = 0; i < K; ++i) {
        polyw1_pack(polyw1_packed, &w1->vec[i]);
        shake256_inc_absorb(&state, polyw1_packed, POLYW1_PACKEDBYTES);
    }
    shake256_inc_finalize(&state);
    shake256_inc_squeeze(outbuf, SHAKE256_RATE, &state);

    signs = 0;
    for (i = 0; i < 8; ++i) {
        signs |= (uint64_t)outbuf[i] << 8 * i;
    }

    pos = 8;

    for (i = 0; i < N; ++i) {
        c->coeffs[i] = 0;
    }

    for (i = 196; i < 256; ++i) {
        do {
            if (pos >= SHAKE256_RATE) {
                shake256_inc_squeeze(outbuf, SHAKE256_RATE, &state);
                pos = 0;
            }

            b = outbuf[pos++];
        } while (b > i);

        c->coeffs[i] = c->coeffs[b];
        c->coeffs[b] = 1;
        c->coeffs[b] ^= -((int32_t)signs & 1) & (1 ^ (Q - 1));
        signs >>= 1;
    }
}

/*************************************************
* Name:        challenge_from_shake256_inc
*
* Description: Implementation of H. Samples polynomial with 60 nonzero
*              coefficients in {-1,1} using the output stream of
*              SHAKE256(mu|w1).
*
* Arguments:   - poly *c: pointer to output polynomial
*              - shake256ctx *state: pointer to a finished shake256 state
**************************************************/
static void challenge_from_shake256_inc(poly *c, shake256incctx *state){
    unsigned int i, b, pos;
    uint64_t signs;
    unsigned char outbuf[SHAKE256_RATE];

    shake256_inc_squeeze(outbuf, SHAKE256_RATE, state);

    signs = 0;
    for (i = 0; i < 8; ++i) {
        signs |= (uint64_t)outbuf[i] << 8 * i;
    }

    pos = 8;

    for (i = 0; i < N; ++i) {
        c->coeffs[i] = 0;
    }

    for (i = 196; i < 256; ++i) {
        do {
            if (pos >= SHAKE256_RATE) {
                shake256_inc_squeeze(outbuf, SHAKE256_RATE, state);
                pos = 0;
            }

            b = outbuf[pos++];
        } while (b > i);

        c->coeffs[i] = c->coeffs[b];
        c->coeffs[b] = 1;
        c->coeffs[b] ^= -((int32_t)signs & 1) & (1 ^ (-1));
        signs >>= 1;
    }
}


/*************************************************
* Name:        crypto_sign_keypair
*
* Description: Generates public and private key.
*
* Arguments:   - unsigned char *pk: pointer to output public key (allocated
*                                   array of CRYPTO_PUBLICKEYBYTES bytes)
*              - unsigned char *sk: pointer to output private key (allocated
*                                   array of CRYPTO_SECRETKEYBYTES bytes)
*
* Returns 0 (success)
**************************************************/
int crypto_sign_keypair(uint8_t *pk, uint8_t *sk) {
    unsigned char seedbuf[3 * SEEDBYTES];
    unsigned char tr[CRHBYTES];
    const unsigned char *rho, *rhoprime, *key;
    uint16_t nonce = 0;
    polyvecl s1;

    /* Expand 32 bytes of randomness into rho, rhoprime and key */
    randombytes(seedbuf, 3 * SEEDBYTES);

    rho = seedbuf;
    rhoprime = seedbuf + SEEDBYTES;
    key = seedbuf + 2 * SEEDBYTES;
    pack_sk_rho(sk, rho);
    pack_sk_key(sk, key);
    pack_pk_rho(pk, rho);

    /* Sample short vector s1 and immediately store its time-domain version */
    for (size_t l_idx = 0; l_idx < L; ++l_idx) {
        poly_uniform_eta(&s1.vec[l_idx], rhoprime, nonce++);
        pack_sk_s1(sk, &s1.vec[l_idx], l_idx);
        /* Move s1 to NTT domain */
        poly_ntt(&s1.vec[l_idx]);
    }

    /* Matrix-vector multiplication */
    for (size_t k_idx = 0; k_idx < K; k_idx++) {
        poly t;
        {
            poly tmp_elem;
            // Sample the current element from A.
            expand_mat_elem(&tmp_elem, rho, k_idx, 0);
            poly_pointwise_montgomery(&t, &tmp_elem, &s1.vec[0]);
            for (size_t l_idx = 1; l_idx < L; l_idx++) {
                // Sample the element from A.
                expand_mat_elem(&tmp_elem, rho, k_idx, l_idx);
                poly_pointwise_acc_montgomery(&t, &tmp_elem, &s1.vec[l_idx]);
            }
        }
        poly_reduce(&t);
        poly_invntt_tomont(&t);

        /* Add error vector s2 */
        {
            poly s2;
             /* Sample short vector s2 */
            poly_uniform_eta(&s2, rhoprime, nonce++);
            pack_sk_s2(sk, &s2, k_idx);
            poly_add(&t, &t, &s2);
        }

        /* Compute t{0,1} */
        {
            poly t1, t0;
            poly_freeze(&t);
            poly_power2round(&t1, &t0, &t);
            pack_sk_t0(sk, &t0, k_idx);
            pack_pk_t1(pk, &t1, k_idx);
        }
    }

    /* Compute CRH(rho, t1) and write secret key */
    {
        shake256incctx state;
        shake256_inc_init(&state);
        shake256_inc_absorb(&state, pk, CRYPTO_PUBLICKEYBYTES);
        shake256_inc_finalize(&state);
        shake256_inc_squeeze(tr, CRHBYTES, &state);
        pack_sk_tr(sk, tr);
    }
    return 0;
}

#if SIGN_STACKSTRATEGY == 1

void precompute_strategy_1_sk_parts(struct strategy_1_sk_precomp *precomp, const uint8_t *sk) {
    uint8_t rho[SEEDBYTES], tr[CRHBYTES], key[SEEDBYTES];
    polyvecl s1;
    polyveck s2, t0;
    unpack_sk(rho, key, tr, &s1, &s2, &t0, sk);

    // Initialize all polynomials that can be precomputed
    precomp->s1hat = s1;
    precomp->s2hat = s2;
    precomp->t0hat = t0;
    
    polyvecl_ntt(&precomp->s1hat);
    polyveck_ntt(&precomp->s2hat);
    for(size_t i = 0; i < K; ++i) {
      poly_ntt_leaktime(&precomp->t0hat.vec[i]);
    }

    // Precompute the matrix A
    expand_mat(precomp->mat, rho);

    // Copy the other parts to the struct
    for (size_t i = 0; i < SEEDBYTES; i++) {
        precomp->key[i] = key[i];
    }
    for (size_t i = 0; i < CRHBYTES; i++) {
        precomp->tr[i] = tr[i];
    }
}

/*************************************************
* Name:        crypto_sign_signature
*
* Description: Computes signature.
*
* Arguments:   - uint8_t *sig:         pointer to output signature (of length CRYPTO_BYTES)
*              - size_t *siglen:       pointer to output length of signed message
*              - uint8_t *m:           pointer to message to be signed
*              - size_t mlen:          length of message
*              - const struct strategy_1_sk_precomp:  pointer to precomputed values-struct
*
* Returns 0 (success)
**************************************************/
int crypto_sign_signature(uint8_t *sig,
                          size_t *siglen,
                          const uint8_t *m,
                          size_t mlen,
                          const struct strategy_1_sk_precomp *sk_precomp)
{
  size_t i;
  uint8_t mu[CRHBYTES], rhoprime[CRHBYTES];
  uint16_t nonce = 0;
  polyveck w0;
  wpacked w1[K];
  shake256incctx state;

  /* Compute CRH(tr, msg) */
  shake256_inc_init(&state);
  shake256_inc_absorb(&state, sk_precomp->tr, CRHBYTES);
  shake256_inc_absorb(&state, m, mlen);
  shake256_inc_finalize(&state);
  shake256_inc_squeeze(mu, CRHBYTES, &state);

#ifdef DILITHIUM_RANDOMIZED_SIGNING
  randombytes(rhoprime, CRHBYTES);
#else
  shake256_inc_init(&state);
  shake256_inc_absorb(&state, sk_precomp->key, SEEDBYTES);
  shake256_inc_absorb(&state, mu, CRHBYTES);
  shake256_inc_finalize(&state);
  shake256_inc_squeeze(rhoprime, CRHBYTES, &state);
#endif

rej:
  shake256_inc_init(&state);
  shake256_inc_absorb(&state, mu, CRHBYTES);

  /* Sample intermediate vector y */
  polyvecl y;
  for(i = 0; i < L; ++i) {
    poly_uniform_gamma1m1(&y.vec[i], rhoprime, nonce++);
  }

  /* Matrix-vector multiplication */
  polyvecl yhat = y;
  polyvecl_ntt(&yhat);
  for(i = 0; i < K; ++i) {
    polyvecl_pointwise_acc_montgomery(&w0.vec[i], &sk_precomp->mat[i], &yhat);
    poly_reduce(&w0.vec[i]);
    poly_invntt_tomont(&w0.vec[i]);

    /* Decompose w and call the random oracle */
    poly_csubq(&w0.vec[i]);
    poly_decompose(&w1[i], &w0.vec[i], &w0.vec[i]);

    shake256_inc_absorb(&state, w1[i].packedcoeffs, POLYW1_PACKEDBYTES);
  }
  shake256_inc_finalize(&state);
  poly c;
  challenge_from_shake256_inc(&c, &state);
  pack_sig_c(sig, &c);
  // From here on, c will be stored in NTT domain
  poly_ntt_leaktime(&c);

  /* Compute z, reject if it reveals secret */
  size_t hint_n = 0;
  size_t hints_written = 0;
  for(i = 0; i < L; ++i) {
    poly z_elem;
    poly_pointwise_montgomery(&z_elem, &c, &sk_precomp->s1hat.vec[i]);
    poly_invntt_tomont(&z_elem);
    if(poly_add_freeze_chk_norm(&z_elem, &z_elem, &y.vec[i], GAMMA1 - BETA)){
      goto rej;
    }
    pack_sig_z(sig, &z_elem, i);
  }
  /* Check that subtracting cs2 does not change high bits of w and low bits
   * do not reveal secret information */
  for(i = 0; i < K; ++i) {
    poly tmp;
    // From here tmp poly is cs2_elem;
    poly_pointwise_montgomery(&tmp, &c, &sk_precomp->s2hat.vec[i]);
    poly_invntt_tomont(&tmp);
    if(poly_sub_freeze_chk_norm(&w0.vec[i], &w0.vec[i], &tmp, GAMMA2 - BETA)) {
      goto rej;
    }

    /* Compute hints for w1 */
    // From here tmp poly is ct0_elem;
    poly_pointwise_montgomery_leaktime(&tmp, &c, &sk_precomp->t0hat.vec[i]);
    poly_invntt_tomont_leaktime(&tmp);
    if(poly_csubq_chknorm(&tmp, GAMMA2)) {
      goto rej;
    }

    poly_add(&w0.vec[i], &w0.vec[i], &tmp);
    poly_csubq(&w0.vec[i]);

    // From here tmp poly is h_elem;
    hint_n += poly_make_hint(&tmp, &w0.vec[i], &w1[i]);
    if (hint_n > OMEGA) {
      goto rej;
    }
    pack_sig_h(sig, &tmp, i, &hints_written);
  }
  pack_sig_h_zero(sig, &hints_written);

  *siglen = CRYPTO_BYTES;
  return 0;
}


#elif SIGN_STACKSTRATEGY == 2
/*************************************************
* Name:        crypto_sign_signature
*
* Description: Computes signature.
*
* Arguments:   - uint8_t *sig:         pointer to output signature (of length CRYPTO_BYTES)
*              - size_t *siglen: pointer to output length of signed message
*              - uint8_t *m:           pointer to message to be signed
*              - size_t mlen:    length of message
*              - uint8_t *sk:          pointer to bit-packed secret key
*
* Returns 0 (success)
**************************************************/
int crypto_sign_signature(uint8_t *sig,
                          size_t *siglen,
                          const uint8_t *m,
                          size_t mlen,
                          const uint8_t *sk)
{
  size_t i;
  uint8_t rho[SEEDBYTES], tr[CRHBYTES], key[SEEDBYTES], mu[CRHBYTES], rhoprime[CRHBYTES];
  uint16_t nonce = 0;
  polyveck t0, s2, w0;
  wpacked w1[K];
  shake256incctx state;
  polyvecl mat[K], s1;

  unpack_sk(rho, key, tr, &s1, &s2, &t0, sk);

  /* Compute CRH(tr, msg) */
  shake256_inc_init(&state);
  shake256_inc_absorb(&state, tr, CRHBYTES);
  shake256_inc_absorb(&state, m, mlen);
  shake256_inc_finalize(&state);
  shake256_inc_squeeze(mu, CRHBYTES, &state);

#ifdef DILITHIUM_RANDOMIZED_SIGNING
  randombytes(rhoprime, CRHBYTES);
#else
  shake256_inc_init(&state);
  shake256_inc_absorb(&state, key, SEEDBYTES);
  shake256_inc_absorb(&state, mu, CRHBYTES);
  shake256_inc_finalize(&state);
  shake256_inc_squeeze(rhoprime, CRHBYTES, &state);
#endif
  expand_mat(mat, rho);
  polyvecl_ntt(&s1);
  polyveck_ntt(&s2);
  for(i = 0; i < K; ++i) {
    poly_ntt_leaktime(&t0.vec[i]);
  }

rej:
  shake256_inc_init(&state);
  shake256_inc_absorb(&state, mu, CRHBYTES);

  /* Sample intermediate vector y */
  polyvecl y;
  for(i = 0; i < L; ++i) {
    poly_uniform_gamma1m1(&y.vec[i], rhoprime, nonce++);
  }

  /* Matrix-vector multiplication */
  polyvecl yhat = y;
  polyvecl_ntt(&yhat);
  for(i = 0; i < K; ++i) {
    polyvecl_pointwise_acc_montgomery(&w0.vec[i], &mat[i], &yhat);
    poly_reduce(&w0.vec[i]);
    poly_invntt_tomont(&w0.vec[i]);

    /* Decompose w and call the random oracle */
    poly_csubq(&w0.vec[i]);
    poly_decompose(&w1[i], &w0.vec[i], &w0.vec[i]);

    shake256_inc_absorb(&state, w1[i].packedcoeffs, POLYW1_PACKEDBYTES);
  }

  shake256_inc_finalize(&state);
  poly c;
  challenge_from_shake256_inc(&c, &state);
  pack_sig_c(sig, &c);
  // From here on, c will be stored in NTT domain.
  poly_ntt_leaktime(&c);

  /* Compute z, reject if it reveals secret */
  size_t hint_n = 0;
  size_t hints_written = 0;
  for(i = 0; i < L; ++i) {
    poly z_elem;
    poly_pointwise_montgomery(&z_elem, &c, &s1.vec[i]);
    poly_invntt_tomont(&z_elem);
    if(poly_add_freeze_chk_norm(&z_elem, &z_elem, &y.vec[i], GAMMA1 - BETA)){
      goto rej;
    }
    pack_sig_z(sig, &z_elem, i);
  }
  /* Check that subtracting cs2 does not change high bits of w and low bits
   * do not reveal secret information */
  for(i = 0; i < K; ++i) {
    poly tmp;
    // From here tmp poly is cs2_elem;
    poly_pointwise_montgomery(&tmp, &c, &s2.vec[i]);
    poly_invntt_tomont(&tmp);
    if(poly_sub_freeze_chk_norm(&w0.vec[i], &w0.vec[i], &tmp, GAMMA2 - BETA)) {
      goto rej;
    }

    /* Compute hints for w1 */
    // From here tmp poly is ct0_elem;
    poly_pointwise_montgomery_leaktime(&tmp, &c, &t0.vec[i]);
    poly_invntt_tomont_leaktime(&tmp);
    if(poly_csubq_chknorm(&tmp, GAMMA2)) {
      goto rej;
    }

    poly_add(&w0.vec[i], &w0.vec[i], &tmp);
    poly_csubq(&w0.vec[i]);

    // From here tmp poly is h_elem;
    hint_n += poly_make_hint(&tmp, &w0.vec[i], &w1[i]);
    if (hint_n > OMEGA) {
      goto rej;
    }
    pack_sig_h(sig, &tmp, i, &hints_written);
  }
  pack_sig_h_zero(sig, &hints_written);

  *siglen = CRYPTO_BYTES;
  return 0;
}

#elif SIGN_STACKSTRATEGY == 3
/*************************************************
* Name:        crypto_sign_signature
*
* Description: Computes signature.
*
* Arguments:   - uint8_t *sig:         pointer to output signature (of length CRYPTO_BYTES)
*              - size_t *siglen: pointer to output length of signed message
*              - uint8_t *m:           pointer to message to be signed
*              - size_t mlen:    length of message
*              - uint8_t *sk:          pointer to bit-packed secret key
*
* Returns 0 (success)
**************************************************/
int crypto_sign_signature(uint8_t *sig,
                          size_t *siglen,
                          const uint8_t *m,
                          size_t mlen,
                          const uint8_t *sk)
{
  uint8_t mu[CRHBYTES], rhoprime[CRHBYTES];
  uint16_t nonce = 0;
  bool first_iteration = true;
  polyveck w;
  shake256incctx state;

  /* Compute CRH(tr, msg) */
  shake256_inc_init(&state);
  shake256_inc_absorb(&state, getoffset_sk_tr(sk), CRHBYTES);
  shake256_inc_absorb(&state, m, mlen);
  shake256_inc_finalize(&state);
  shake256_inc_squeeze(mu, CRHBYTES, &state);

#ifdef DILITHIUM_RANDOMIZED_SIGNING
  randombytes(rhoprime, CRHBYTES);
#else
  shake256_inc_init(&state);
  shake256_inc_absorb(&state, getoffset_sk_key(sk), SEEDBYTES);
  shake256_inc_absorb(&state, mu, CRHBYTES);
  shake256_inc_finalize(&state);
  shake256_inc_squeeze(rhoprime, CRHBYTES, &state);
#endif

rej:
  if (!first_iteration) {
    nonce += L;
  }
  first_iteration = false;

  shake256_inc_init(&state);
  shake256_inc_absorb(&state, mu, CRHBYTES);

  /* Matrix-vector multiplication */
  for (size_t k_idx = 0; k_idx < K; k_idx++) {
    union {
      wpacked w1_elem;
      poly tmp;
    } w1_tmp_elem;
    {
      poly yhat_elem;
      const uint8_t *rho = getoffset_sk_rho(sk);
      poly_uniform(&w1_tmp_elem.tmp, rho, (k_idx << 8) + 0);
      poly_uniform_gamma1m1(&yhat_elem, rhoprime, nonce + 0);
      poly_ntt(&yhat_elem);
      poly_pointwise_montgomery(&w.vec[k_idx], &w1_tmp_elem.tmp, &yhat_elem);
      for (size_t l_idx = 1; l_idx < L; l_idx++) {
        poly_uniform(&w1_tmp_elem.tmp, rho, (k_idx << 8) + l_idx);
        poly_uniform_gamma1m1(&yhat_elem, rhoprime, nonce + l_idx);
        poly_ntt(&yhat_elem);
        poly_pointwise_acc_montgomery(&w.vec[k_idx], &w1_tmp_elem.tmp, &yhat_elem);
      }
      poly_reduce(&w.vec[k_idx]);
      poly_invntt_tomont(&w.vec[k_idx]);

      /* Decompose w */
      poly_csubq(&w.vec[k_idx]);
      // yhat_elem is unused, so just use that to dump the unused w0.
      poly_decompose(&w1_tmp_elem.w1_elem, &yhat_elem, &w.vec[k_idx]);
    } // Drop tmp and yhat_elem

    shake256_inc_absorb(&state, w1_tmp_elem.w1_elem.packedcoeffs, POLYW1_PACKEDBYTES);
  }

  /* Call the random oracle */
  shake256_inc_finalize(&state);
  poly c;
  challenge_from_shake256_inc(&c, &state);
  pack_sig_c(sig, &c);
  // From here on, c will be stored in ntt domain.
  poly_ntt_leaktime(&c);

  /* Compute z, reject if it reveals secret */
  size_t hint_n = 0;
  size_t hints_written = 0;
  for(size_t l_idx = 0; l_idx < L; l_idx++) {
    poly tmp, y_elem;
    // tmp is s1 element
    unpack_sk_s1(&tmp, sk, l_idx);
    poly_ntt(&tmp);
    poly_pointwise_montgomery(&tmp, &c, &tmp);
    // From here on, tmp is z element
    poly_invntt_tomont(&tmp);
    poly_uniform_gamma1m1(&y_elem, rhoprime, nonce + l_idx);
    if(poly_add_freeze_chk_norm(&tmp, &tmp, &y_elem, GAMMA1 - BETA)){
      goto rej;
    }
    pack_sig_z(sig, &tmp, l_idx);
  }

  /* Check that subtracting cs2 does not change high bits of w and low bits
   * do not reveal secret information */
  for(size_t k_idx = 0; k_idx < K; k_idx++) {
    poly tmp, *w0_elem = &w.vec[k_idx];
    wpacked w1_elem;
    // First tmp is s2_elem, then cs2_elem
    unpack_sk_s2(&tmp, sk, k_idx);
    poly_ntt(&tmp);
    poly_pointwise_montgomery(&tmp, &c, &tmp);
    poly_invntt_tomont(&tmp);
    poly_decompose(&w1_elem, w0_elem, &w.vec[k_idx]);

    if(poly_sub_freeze_chk_norm(w0_elem, w0_elem, &tmp, GAMMA2 - BETA)) {
      goto rej;
    }

    /* Compute hints for w1 */
    // From here tmp poly is t0_elem;
    unpack_sk_t0(&tmp, sk, k_idx); 
    poly_ntt_leaktime(&tmp);
    poly_pointwise_montgomery_leaktime(&tmp, &c, &tmp);
    // From here tmp poly is ct0_elem;
    poly_invntt_tomont_leaktime(&tmp);
    if(poly_csubq_chknorm(&tmp, GAMMA2)) {
      goto rej;
    }

    poly_add(w0_elem, w0_elem, &tmp);
    poly_csubq(w0_elem);

    // From here tmp poly is h_elem;
    hint_n += poly_make_hint(&tmp, w0_elem, &w1_elem);
    if (hint_n > OMEGA) {
      goto rej;
    }
    pack_sig_h(sig, &tmp, k_idx, &hints_written);
  }
  pack_sig_h_zero(sig, &hints_written);

  *siglen = CRYPTO_BYTES;
  return 0;
}
#endif

/*************************************************
* Name:        crypto_sign
*
* Description: Compute signed message.
*
* Arguments:   - uint8_t *sm: pointer to output signed message (allocated
*                                   array with CRYPTO_BYTES + mlen bytes),
*                                   can be equal to m
*              - size_t *smlen: pointer to output length of signed
*                                           message
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
#if SIGN_STACKSTRATEGY == 1
                const struct strategy_1_sk_precomp *sk
#else
                const uint8_t *sk
#endif
) {
  size_t i;

  for(i = 0; i < mlen; ++i)
    sm[CRYPTO_BYTES + mlen - 1 - i] = m[mlen - 1 - i];
  crypto_sign_signature(sm, smlen, sm + CRYPTO_BYTES, mlen, sk);
  *smlen += mlen;
  return 0;
}

int crypto_sign_verify(
    const uint8_t *sig, size_t siglen,
    const uint8_t *m, size_t mlen,
    const uint8_t *pk
) {
    shake256incctx state;
    poly c, chat, w1_elem, tmp_elem;
    polyvecl z;

    if (siglen < CRYPTO_BYTES) {
        return -1;
    }

    const unsigned char *rho = getoffset_pk_rho(pk);

    // Compute mu
    unsigned char mu[CRHBYTES];
    shake256_inc_init(&state);
    shake256_inc_absorb(&state, pk, CRYPTO_PUBLICKEYBYTES);
    shake256_inc_finalize(&state);
    shake256_inc_squeeze(mu, CRHBYTES, &state);
    shake256_inc_init(&state);
    shake256_inc_absorb(&state, mu, CRHBYTES);
    shake256_inc_absorb(&state, m, mlen);
    shake256_inc_finalize(&state);
    shake256_inc_squeeze(mu, CRHBYTES, &state);

    // Hash [mu || w1'] to get c.
    shake256_inc_init(&state);
    shake256_inc_absorb(&state, mu, CRHBYTES);

    if (unpack_sig_c(&c, sig) != 0) {
        return -1;
    }
    chat = c;
    poly_ntt_leaktime(&chat);

    if (unpack_sig_z(&z, sig) != 0) {
        return -1;
    };
    if (polyvecl_chknorm(&z, GAMMA1 - BETA)) {
        return -1;
    }

    for (size_t l_idx = 0; l_idx < L; l_idx++) {
        poly_ntt_leaktime(&z.vec[l_idx]);
    }

    // Compute w1.
    for (size_t k_idx = 0; k_idx < K; k_idx++) {
        // Sample the current element from A.
        expand_mat_elem(&tmp_elem, rho, k_idx, 0);
        poly_pointwise_montgomery_leaktime(&w1_elem, &tmp_elem, &z.vec[0]);
        for (size_t l_idx = 1; l_idx < L; l_idx++) {
            // Sample the element from A.
            expand_mat_elem(&tmp_elem, rho, k_idx, l_idx);
            poly_pointwise_acc_montgomery_leaktime(&w1_elem, &tmp_elem, &z.vec[l_idx]);
        }

        // Subtract c*(t1_{k_idx} * 2^d)
        unpack_pk_t1(&tmp_elem, k_idx, pk);
        poly_shiftl(&tmp_elem);
        poly_ntt_leaktime(&tmp_elem);
        poly_pointwise_montgomery_leaktime(&tmp_elem, &chat, &tmp_elem);
        poly_sub(&w1_elem, &w1_elem, &tmp_elem);
        poly_reduce(&w1_elem);
        poly_invntt_tomont_leaktime(&w1_elem);

        // Reconstruct w1
        poly_csubq(&w1_elem);
        if (unpack_sig_h(&tmp_elem, k_idx, sig) != 0) {
            return -1;
        };
        poly_use_hint(&w1_elem, &w1_elem, &tmp_elem);
        uint8_t w1_packed[POLYW1_PACKEDBYTES];
        polyw1_pack(w1_packed, &w1_elem);
        shake256_inc_absorb(&state, w1_packed, POLYW1_PACKEDBYTES);
    }

    shake256_inc_finalize(&state);
    challenge_from_shake256_inc(&tmp_elem, &state);
    // tmp_elem contains c'.
    for (size_t i = 0; i < N; ++i) {
        if (c.coeffs[i] != tmp_elem.coeffs[i]) {
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
* Arguments:   - unsigned char *m: pointer to output message (allocated
*                                  array with smlen bytes), can be equal to sm
*              - unsigned long long *mlen: pointer to output length of message
*              - const unsigned char *sm: pointer to signed message
*              - unsigned long long smlen: length of signed message
*              - const unsigned char *sk: pointer to bit-packed public key
*
* Returns 0 if signed message could be verified correctly and -1 otherwise
**************************************************/
int crypto_sign_open(uint8_t *m,
        size_t *mlen,
        const uint8_t *sm,
        size_t smlen,
        const uint8_t *pk) {
    size_t i;
    if (smlen < CRYPTO_BYTES) {
        goto badsig;
    }
    *mlen = smlen - CRYPTO_BYTES;

    if (crypto_sign_verify(sm, CRYPTO_BYTES,
            sm + CRYPTO_BYTES, *mlen, pk)) {
        goto badsig;
    } else {
        /* All good, copy msg, return 0 */
        for (i = 0; i < *mlen; ++i) {
            m[i] = sm[CRYPTO_BYTES + i];
        }
        return 0;
    }

    /* Signature verification failed */
badsig:
    *mlen = (size_t) -1;
    for (i = 0; i < smlen; ++i) {
        m[i] = 0;
    }

    return -1;
}
