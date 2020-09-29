#include "indcpa.h"
#include "ntt.h"
#include "poly.h"
#include "polyvec.h"
#include "randombytes.h"
#include "symmetric.h"

#include <string.h>
#include <stdint.h>

extern void doublebasemul_asm_acc(int16_t *r, const int16_t *a, const int16_t *b, int16_t zeta);
/*************************************************
* Name:        matacc
*
* Description: Multiplies a row of A or A^T, generated on-the-fly,
*              with a vector of polynomials and accumulates into the result.
*
* Arguments:   - poly *r:                    pointer to output polynomial to accumulate in
*              - polyvec *b:                 pointer to input vector of polynomials to multiply with
*              - unsigned char i:            byte to indicate the index < KYBER_K of the row of A or A^T
*              - const unsigned char *seed:  pointer to the public seed used to generate A
*              - int transposed:             boolean indicatin whether A or A^T is generated
**************************************************/
static void matacc(poly* r, polyvec *b, unsigned char i, const unsigned char *seed, int transposed) {
  unsigned char buf[XOF_BLOCKBYTES+2];
  unsigned int buflen, off;
  xof_state state;
  unsigned int ctr, pos, k, l;
  uint16_t val0, val1;
  int16_t c[4];

  poly_zeroize(r);

  for(int j=0;j<KYBER_K;j++) {
    ctr = pos = 0;
    if (transposed)
      xof_absorb(&state, seed, i, j);
    else
      xof_absorb(&state, seed, j, i);

    xof_squeezeblocks(buf, 1, &state);
    buflen = XOF_BLOCKBYTES;

    k = 0;
    while (ctr < KYBER_N/4)
    {
      val0 = ((buf[pos+0] >> 0) | ((uint16_t)buf[pos+1] << 8)) & 0xFFF;
      val1 = ((buf[pos+1] >> 4) | ((uint16_t)buf[pos+2] << 4)) & 0xFFF;
      pos += 3;

      if (val0 < KYBER_Q) {
        c[k++] = (int16_t) val0;
        if (k == 4) {
          doublebasemul_asm_acc(&r->coeffs[4*ctr], &b->vec[j].coeffs[4*ctr], c, zetas[ctr]);
          ctr++;
          k = 0;
        }
      }

      if (val1 < KYBER_Q && ctr < KYBER_Q/4) {
        c[k++] = (int16_t) val1;
        if (k == 4) {
          doublebasemul_asm_acc(&r->coeffs[4*ctr], &b->vec[j].coeffs[4*ctr], c, zetas[ctr]);
          ctr++;
          k = 0;
        }
      }

      if (pos + 3 > buflen && ctr < KYBER_Q/4) {
        off = buflen % 3;
        for(l = 0; l < off; l++)
          buf[l] = buf[buflen - off + l];
        xof_squeezeblocks(buf + off, 1, &state);
        buflen = off + XOF_BLOCKBYTES;
        pos = 0;
      }
    }
  }
}

/*************************************************
* Name:        indcpa_keypair
*
* Description: Generates public and private key for the CPA-secure
*              public-key encryption scheme underlying Kyber
*
* Arguments:   - unsigned char *pk: pointer to output public key (of length KYBER_INDCPA_PUBLICKEYBYTES bytes)
*              - unsigned char *sk: pointer to output private key (of length KYBER_INDCPA_SECRETKEYBYTES bytes)
**************************************************/
void indcpa_keypair(unsigned char *pk, unsigned char *sk) {
    polyvec skpv;
    poly pkp;
    unsigned char buf[2 * KYBER_SYMBYTES];
    unsigned char *publicseed = buf;
    unsigned char *noiseseed = buf + KYBER_SYMBYTES;
    int i;
    unsigned char nonce = 0;

    randombytes(buf, KYBER_SYMBYTES);
    hash_g(buf, buf, KYBER_SYMBYTES);

    for (i = 0; i < KYBER_K; i++)
        poly_getnoise(skpv.vec + i, noiseseed, nonce++);

    polyvec_ntt(&skpv);

    for (i = 0; i < KYBER_K; i++) {
        matacc(&pkp, &skpv, i, publicseed, 0);
        poly_invntt(&pkp);

        poly_addnoise(&pkp, noiseseed, nonce++);
        poly_ntt(&pkp);

        poly_tobytes(pk+i*KYBER_POLYBYTES, &pkp);
    }

    polyvec_tobytes(sk, &skpv);
    memcpy(pk + KYBER_POLYVECBYTES, publicseed, KYBER_SYMBYTES); // Pack the public seed in the public key
}

/*************************************************
* Name:        indcpa_enc
*
* Description: Encryption function of the CPA-secure
*              public-key encryption scheme underlying Kyber.
*
* Arguments:   - unsigned char *c:          pointer to output ciphertext (of length KYBER_INDCPA_BYTES bytes)
*              - const unsigned char *m:    pointer to input message (of length KYBER_INDCPA_MSGBYTES bytes)
*              - const unsigned char *pk:   pointer to input public key (of length KYBER_INDCPA_PUBLICKEYBYTES bytes)
*              - const unsigned char *coin: pointer to input random coins used as seed (of length KYBER_SYMBYTES bytes)
*                                           to deterministically generate all randomness
**************************************************/
void indcpa_enc(unsigned char *c,
               const unsigned char *m,
               const unsigned char *pk,
               const unsigned char *coins) {
    polyvec sp;
    poly bp;
    poly *pkp = &bp;
    poly *k = &bp;
    poly *v = &sp.vec[0];
    const unsigned char *seed = pk+KYBER_POLYVECBYTES;
    int i;
    unsigned char nonce = 0;

    for (i = 0; i < KYBER_K; i++)
        poly_getnoise(sp.vec + i, coins, nonce++);

    polyvec_ntt(&sp);

    for (i = 0; i < KYBER_K; i++) {
        matacc(&bp, &sp, i, seed, 1);
        poly_invntt(&bp);

        poly_addnoise(&bp, coins, nonce++);
        poly_reduce(&bp);

        poly_packcompress(c, &bp, i);
    }

    poly_frombytes(pkp, pk);
    poly_basemul(v, pkp, &sp.vec[0]);
    for (i = 1; i < KYBER_K; i++) {
        poly_frombytes(pkp, pk + i*KYBER_POLYBYTES);
        poly_basemul_acc(v, pkp, &sp.vec[i]);
    }

    poly_invntt(v);

    poly_addnoise(v, coins, nonce++);

    poly_frommsg(k, m);
    poly_add(v, v, k);
    poly_reduce(v);

    poly_compress(c + KYBER_POLYVECCOMPRESSEDBYTES, v);
}

/*************************************************
* Name:        indcpa_enc_cmp
*
* Description: Re-encryption function.
*              Compares the re-encypted ciphertext with the original ciphertext byte per byte.
*              The comparison is performed in a constant time manner.
*
*
* Arguments:   - unsigned char *ct:         pointer to input ciphertext to compare the new ciphertext with (of length KYBER_INDCPA_BYTES bytes)
*              - const unsigned char *m:    pointer to input message (of length KYBER_INDCPA_MSGBYTES bytes)
*              - const unsigned char *pk:   pointer to input public key (of length KYBER_INDCPA_PUBLICKEYBYTES bytes)
*              - const unsigned char *coin: pointer to input random coins used as seed (of length KYBER_SYMBYTES bytes)
*                                           to deterministically generate all randomness
* Returns:     - boolean byte indicating that re-encrypted ciphertext is NOT equal to the original ciphertext
**************************************************/
unsigned char indcpa_enc_cmp(const unsigned char *c,
                             const unsigned char *m,
                             const unsigned char *pk,
                             const unsigned char *coins) {
    uint64_t rc = 0;
    polyvec sp;
    poly bp;
    poly *pkp = &bp;
    poly *k = &bp;
    poly *v = &sp.vec[0];
    const unsigned char *seed = pk+KYBER_POLYVECBYTES;
    int i;
    unsigned char nonce = 0;

    for (i = 0; i < KYBER_K; i++)
        poly_getnoise(sp.vec + i, coins, nonce++);

    polyvec_ntt(&sp);

    for (i = 0; i < KYBER_K; i++) {
        matacc(&bp, &sp, i, seed, 1);
        poly_invntt(&bp);

        poly_addnoise(&bp, coins, nonce++);
        poly_reduce(&bp);

        rc |= cmp_poly_packcompress(c, &bp, i);
    }

    poly_frombytes(pkp, pk);
    poly_basemul(v, pkp, &sp.vec[0]);
    for (i = 1; i < KYBER_K; i++) {
        poly_frombytes(pkp, pk + i*KYBER_POLYBYTES);
        poly_basemul_acc(v, pkp, &sp.vec[i]);
    }

    poly_invntt(v);

    poly_addnoise(v, coins, nonce++);
    poly_frommsg(k, m);
    poly_add(v, v, k);
    poly_reduce(v);

    rc |= cmp_poly_compress(c + KYBER_POLYVECCOMPRESSEDBYTES, v);

    rc = ~rc + 1;
    rc >>= 63;
    return (unsigned char)rc;
}

/*************************************************
* Name:        indcpa_dec
*
* Description: Decryption function of the CPA-secure
*              public-key encryption scheme underlying Kyber.
*
* Arguments:   - unsigned char *m:        pointer to output decrypted message (of length KYBER_INDCPA_MSGBYTES)
*              - const unsigned char *c:  pointer to input ciphertext (of length KYBER_INDCPA_BYTES)
*              - const unsigned char *sk: pointer to input secret key (of length KYBER_INDCPA_SECRETKEYBYTES)
**************************************************/
void __attribute__ ((noinline)) indcpa_dec(unsigned char *m,
                                           const unsigned char *c,
                                           const unsigned char *sk) {
    poly mp, bp;
    poly *v = &bp;

    poly_unpackdecompress(&mp, c, 0);
    poly_ntt(&mp);
    poly_frombytes_mul(&mp, sk);
    for(int i = 1; i < KYBER_K; i++) {
        poly_unpackdecompress(&bp, c, i);
        poly_ntt(&bp);
        poly_frombytes_mul(&bp, sk + i*KYBER_POLYBYTES);
        poly_add(&mp, &mp, &bp);
    }

    poly_invntt(&mp);
    poly_decompress(v, c+KYBER_POLYVECCOMPRESSEDBYTES);
    poly_sub(&mp, v, &mp);
    poly_reduce(&mp);

    poly_tomsg(m, &mp);
}
