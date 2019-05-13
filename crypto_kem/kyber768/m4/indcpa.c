#include "indcpa.h"

#include "ntt.h"
#include "poly.h"
#include "polyvec.h"
#include "randombytes.h"
#include "symmetric.h"
#include "reduce.h"

#include <string.h>
#include <stdint.h>

/*************************************************
* Name:        indcpa_keypair
*
* Description: Generates public and private key for the CPA-secure
*              public-key encryption scheme underlying Kyber
*
* Arguments:   - unsigned char *pk: pointer to output public key (of length KYBER_INDCPA_PUBLICKEYBYTES bytes)
*              - unsigned char *sk: pointer to output private key (of length KYBER_INDCPA_SECRETKEYBYTES bytes)
**************************************************/

extern void doublebasemul_asm(int16_t *r, const int16_t *a, const int16_t *b, int16_t zeta);
static void matacc(poly* r, polyvec *b, unsigned char i, const unsigned char *seed, int transposed){

  unsigned char buf[XOF_BLOCKBYTES+1];
  xof_state state;
  int16_t f[4], t1[4];
  int ctr, pos, k;
  uint16_t val;
  poly_zeroize(r);
  for(int j=0;j<KYBER_K;j++){
    if (transposed) {
      xof_absorb(&state, seed, i, j);
    } else {
      xof_absorb(&state, seed, j, i);
    }
    xof_squeezeblocks(buf, 1, &state);
    ctr = pos = 0;
    while (ctr < KYBER_N/4)
    {
      k = 0;
      while(k<4){
        val = buf[pos] | ((uint16_t)buf[pos + 1] << 8);
        if (val < 19 * KYBER_Q) {
          val -= (val >> 12) * KYBER_Q; // Barrett reduction
          f[k++] = (int16_t) val;
        }
        pos += 2;
        if (pos + 2 > XOF_BLOCKBYTES) { // ran r of randombytes
          xof_squeezeblocks(buf, 1, &state);
          pos = 0;
        }
      }

      doublebasemul_asm(t1, &b->vec[j].coeffs[4*ctr], f, zetas[64+ctr]);
      //basemul(t1, &b->vec[j].coeffs[4*ctr], f, zetas[64+ctr]);
      //basemul(t1+2, &b->vec[j].coeffs[4*ctr+2], f+2, -zetas[64+ctr]);

      r->coeffs[4*ctr]   += t1[0];
      r->coeffs[4*ctr+1] += t1[1];
      r->coeffs[4*ctr+2] += t1[2];
      r->coeffs[4*ctr+3] += t1[3];
      ctr++;
    }
    poly_reduce(r);
  }
}

void indcpa_keypair(unsigned char *pk, unsigned char *sk) {

    polyvec skpv;
    poly e, pkp;
    unsigned char buf[2 * KYBER_SYMBYTES];
    unsigned char *publicseed = buf;
    unsigned char *noiseseed = buf + KYBER_SYMBYTES;
    int i;
    unsigned char nonce = 0;

    randombytes(buf, KYBER_SYMBYTES);
    hash_g(buf, buf, KYBER_SYMBYTES);

    for (i = 0; i < KYBER_K; i++) {
        poly_getnoise(skpv.vec + i, noiseseed, nonce++, 0);
    }

    polyvec_ntt(&skpv);

    for (i = 0; i < KYBER_K; i++) {
        matacc(&pkp, &skpv,i, publicseed, 0);
        poly_frommont(&pkp);
        poly_getnoise(&e, noiseseed, nonce++, 0);
        poly_ntt(&e);

        poly_add(&pkp, &pkp, &e);

        poly_reduce(&pkp);
        poly_tobytes(pk+i*KYBER_POLYBYTES, &pkp);
    }

    polyvec_tobytes(sk, &skpv);
    memcpy(pk + KYBER_POLYVECBYTES, publicseed, KYBER_SYMBYTES);
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
static void poly_packcompress(unsigned char *r, poly *a) {
    int j, k;

    poly_csubq(a);

#if (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 352))
  uint16_t t[8];
  for(j=0;j<KYBER_N/8;j++)
  {
    for(k=0;k<8;k++)
      t[k] = ((((uint32_t)a->coeffs[8*j+k] << 11) + KYBER_Q/2) / KYBER_Q) & 0x7ff;

    r[11*j+ 0] =  t[0] & 0xff;
    r[11*j+ 1] = (t[0] >>  8) | ((t[1] & 0x1f) << 3);
    r[11*j+ 2] = (t[1] >>  5) | ((t[2] & 0x03) << 6);
    r[11*j+ 3] = (t[2] >>  2) & 0xff;
    r[11*j+ 4] = (t[2] >> 10) | ((t[3] & 0x7f) << 1);
    r[11*j+ 5] = (t[3] >>  7) | ((t[4] & 0x0f) << 4);
    r[11*j+ 6] = (t[4] >>  4) | ((t[5] & 0x01) << 7);
    r[11*j+ 7] = (t[5] >>  1) & 0xff;
    r[11*j+ 8] = (t[5] >>  9) | ((t[6] & 0x3f) << 2);
    r[11*j+ 9] = (t[6] >>  6) | ((t[7] & 0x07) << 5);
    r[11*j+10] = (t[7] >>  3);
  }
#elif (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 320))
    uint16_t t[4];
        for (j = 0; j < KYBER_N / 4; j++) {
            for (k = 0; k < 4; k++) {
                t[k] = ((((uint32_t)a->coeffs[4 * j + k] << 10) + KYBER_Q / 2) / KYBER_Q) & 0x3ff;
            }

            r[5 * j + 0] =  t[0] & 0xff;
            r[5 * j + 1] = (t[0] >>  8) | ((t[1] & 0x3f) << 2);
            r[5 * j + 2] = ((t[1] >>  6) | ((t[2] & 0x0f) << 4)) & 0xff;
            r[5 * j + 3] = ((t[2] >>  4) | ((t[3] & 0x03) << 6)) & 0xff;
            r[5 * j + 4] = (t[3] >>  2) & 0xff;
        }
#else
#error "not implemented"
#endif
}
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

    for (i = 0; i < KYBER_K; i++) {
        poly_getnoise(sp.vec + i, coins, nonce++, 0);
    }

    polyvec_ntt(&sp);

    // matrix-vector multiplication
    for (i = 0; i < KYBER_K; i++) {

        matacc(&bp, &sp, i, seed, 1);
        poly_invntt(&bp);

        poly_getnoise(&bp, coins, nonce++, 1);
        poly_reduce(&bp);

        #if (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 352))
        poly_packcompress(c + i*352, &bp);
        #elif (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 320))
        poly_packcompress(c + i*320, &bp);
        #else
        #error "KYBER_POLYVECCOMPRESSEDBYTES needs to be in {320*KYBER_K, 352*KYBER_K}"
        #endif
    }

    poly_frombytes(pkp, pk);
    poly_basemul(v, pkp, &sp.vec[0]);
    for (i = 1; i < KYBER_K; i++) {
        poly_frombytes(pkp, pk + i*KYBER_POLYBYTES);
        poly_basemul_acc(v, pkp, &sp.vec[i]);
    }

    poly_invntt(v);

    poly_getnoise(v, coins, nonce++, 1);
    poly_frommsg(k, m);
    poly_add(v, v, k);
    poly_reduce(v);

    poly_compress(c + KYBER_POLYVECCOMPRESSEDBYTES, v);
}

static int cmp_poly_compress(const unsigned char *r, poly *a) {
    unsigned char rc = 0;
    uint8_t t[8];
    int i, j, k = 0;

    poly_csubq(a);

    #if (KYBER_POLYCOMPRESSEDBYTES == 96)
    for(i=0;i<KYBER_N;i+=8)
    {
      for(j=0;j<8;j++)
        t[j] = ((((uint32_t)a->coeffs[i+j] << 3) + KYBER_Q/2) / KYBER_Q) & 7;

      rc |= r[k]   ^ (t[0]       | (t[1] << 3) | (t[2] << 6));
      rc |= r[k+1] ^ ((t[2] >> 2) | (t[3] << 1) | (t[4] << 4) | (t[5] << 7));
      rc |= r[k+2] ^ ((t[5] >> 1) | (t[6] << 2) | (t[7] << 5));
      k += 3;
    }
    #elif (KYBER_POLYCOMPRESSEDBYTES == 128)
    for (i = 0; i < KYBER_N; i += 8) {
        for (j = 0; j < 8; j++) {
            t[j] = ((((uint32_t)a->coeffs[i + j] << 4) + KYBER_Q / 2) / KYBER_Q) & 15;
        }

        rc |= r[k]      ^ (t[0] | (t[1] << 4));
        rc |= r[k + 1]  ^ (t[2] | (t[3] << 4));
        rc |= r[k + 2]  ^ (t[4] | (t[5] << 4));
        rc |= r[k + 3]  ^ (t[6] | (t[7] << 4));
        k += 4;
    }
    #elif (KYBER_POLYCOMPRESSEDBYTES == 160)
    for(i=0;i<KYBER_N;i+=8)
    {
      for(j=0;j<8;j++)
        t[j] = ((((uint32_t)a->coeffs[i+j] << 5) + KYBER_Q/2) / KYBER_Q) & 31;

      rc |= r[k]   ^ (t[0]       | (t[1] << 5));
      rc |= r[k+1] ^ ((t[1] >> 3) | (t[2] << 2) | (t[3] << 7));
      rc |= r[k+2] ^ ((t[3] >> 1) | (t[4] << 4));
      rc |= r[k+3] ^ ((t[4] >> 4) | (t[5] << 1) | (t[6] << 6));
      rc |= r[k+4] ^ ((t[6] >> 2) | (t[7] << 3));
      k += 5;
    }
    #else
    #error "KYBER_POLYCOMPRESSEDBYTES needs to be in {96, 128, 160}"
    #endif
    return rc;
}
static int cmp_poly_packcompress(const unsigned char *r, poly *a) {
    unsigned char rc = 0;
    int j, k;

    poly_csubq(a);

#if (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 352))
  uint16_t t[8];
    for(j=0;j<KYBER_N/8;j++)
    {
      for(k=0;k<8;k++)
        t[k] = ((((uint32_t)a->coeffs[8*j+k] << 11) + KYBER_Q/2) / KYBER_Q) & 0x7ff;

      rc |= r[11*j+ 0] ^ (t[0] & 0xff);
      rc |= r[11*j+ 1] ^ ((t[0] >>  8) | ((t[1] & 0x1f) << 3));
      rc |= r[11*j+ 2] ^ ((t[1] >>  5) | ((t[2] & 0x03) << 6));
      rc |= r[11*j+ 3] ^ ((t[2] >>  2) & 0xff);
      rc |= r[11*j+ 4] ^ ((t[2] >> 10) | ((t[3] & 0x7f) << 1));
      rc |= r[11*j+ 5] ^ ((t[3] >>  7) | ((t[4] & 0x0f) << 4));
      rc |= r[11*j+ 6] ^ ((t[4] >>  4) | ((t[5] & 0x01) << 7));
      rc |= r[11*j+ 7] ^ ((t[5] >>  1) & 0xff);
      rc |= r[11*j+ 8] ^ ((t[5] >>  9) | ((t[6] & 0x3f) << 2));
      rc |= r[11*j+ 9] ^ ((t[6] >>  6) | ((t[7] & 0x07) << 5));
      rc |= r[11*j+10] ^ ((t[7] >>  3));
    }
#elif (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 320))
    uint16_t t[4];
        for (j = 0; j < KYBER_N / 4; j++) {
            for (k = 0; k < 4; k++) {
                t[k] = ((((uint32_t)a->coeffs[4 * j + k] << 10) + KYBER_Q / 2) / KYBER_Q) & 0x3ff;
            }

            rc |= r[5 * j + 0] ^ (t[0] & 0xff);
            rc |= r[5 * j + 1] ^ ((t[0] >>  8) | ((t[1] & 0x3f) << 2));
            rc |= r[5 * j + 2] ^ (((t[1] >>  6) | ((t[2] & 0x0f) << 4)) & 0xff);
            rc |= r[5 * j + 3] ^ (((t[2] >>  4) | ((t[3] & 0x03) << 6)) & 0xff);
            rc |= r[5 * j + 4] ^ ((t[3] >>  2) & 0xff);
        }
#else
#error "KYBER_POLYVECCOMPRESSEDBYTES needs to be in {320*KYBER_K, 352*KYBER_K}"
#endif
    return rc;
}

int indcpa_enc_cmp(const unsigned char *c,
                                       const unsigned char *m,
                                       const unsigned char *pk,
                                       const unsigned char *coins) {
    unsigned char rc = 0;
    polyvec sp;
    poly bp;
    poly *pkp = &bp;
    poly *k = &bp;
    poly *v = &sp.vec[0];
    const unsigned char *seed = pk+KYBER_POLYVECBYTES;
    int i;
    unsigned char nonce = 0;

    for (i = 0; i < KYBER_K; i++) {
        poly_getnoise(sp.vec + i, coins, nonce++, 0);
    }

    polyvec_ntt(&sp);

    // matrix-vector multiplication
    for (i = 0; i < KYBER_K; i++) {

        matacc(&bp, &sp, i, seed, 1);
        poly_invntt(&bp);

        poly_getnoise(&bp, coins, nonce++, 1);
        poly_reduce(&bp);

        #if (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 352))
        rc |= cmp_poly_packcompress(c + i*352, &bp);
        #elif (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 320))
        rc |= cmp_poly_packcompress(c + i*320, &bp);
        #else
        #error "KYBER_POLYVECCOMPRESSEDBYTES needs to be in {320*KYBER_K, 352*KYBER_K}"
        #endif

    }

    poly_frombytes(pkp, pk);
    poly_basemul(v, pkp, &sp.vec[0]);
    for (i = 1; i < KYBER_K; i++) {
        poly_frombytes(pkp, pk + i*KYBER_POLYBYTES);
        poly_basemul_acc(v, pkp, &sp.vec[i]);
    }

    poly_invntt(v);

    poly_getnoise(v, coins, nonce++, 1);
    poly_frommsg(k, m);
    poly_add(v, v, k);
    poly_reduce(v);

    rc |= cmp_poly_compress(c + KYBER_POLYVECCOMPRESSEDBYTES, v);

    return rc;
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
static void poly_unpackdecompress(poly *r, const unsigned char *a)
{
  int j;
#if (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 352))
    for(j=0;j<KYBER_N/8;j++)
    {
      r->coeffs[8*j+0] =  (((a[11*j+ 0]       | (((uint32_t)a[11*j+ 1] & 0x07) << 8)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+1] = ((((a[11*j+ 1] >> 3) | (((uint32_t)a[11*j+ 2] & 0x3f) << 5)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+2] = ((((a[11*j+ 2] >> 6) | (((uint32_t)a[11*j+ 3] & 0xff) << 2) | (((uint32_t)a[11*j+ 4] & 0x01) << 10)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+3] = ((((a[11*j+ 4] >> 1) | (((uint32_t)a[11*j+ 5] & 0x0f) << 7)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+4] = ((((a[11*j+ 5] >> 4) | (((uint32_t)a[11*j+ 6] & 0x7f) << 4)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+5] = ((((a[11*j+ 6] >> 7) | (((uint32_t)a[11*j+ 7] & 0xff) << 1) | (((uint32_t)a[11*j+ 8] & 0x03) <<  9)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+6] = ((((a[11*j+ 8] >> 2) | (((uint32_t)a[11*j+ 9] & 0x1f) << 6)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+7] = ((((a[11*j+ 9] >> 5) | (((uint32_t)a[11*j+10] & 0xff) << 3)) * KYBER_Q) + 1024) >> 11;
    }
#elif (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 320))
    for(j=0;j<KYBER_N/4;j++)
    {
      r->coeffs[4*j+0] =  (((a[5*j+ 0]       | (((uint32_t)a[5*j+ 1] & 0x03) << 8)) * KYBER_Q) + 512) >> 10;
      r->coeffs[4*j+1] = ((((a[5*j+ 1] >> 2) | (((uint32_t)a[5*j+ 2] & 0x0f) << 6)) * KYBER_Q) + 512) >> 10;
      r->coeffs[4*j+2] = ((((a[5*j+ 2] >> 4) | (((uint32_t)a[5*j+ 3] & 0x3f) << 4)) * KYBER_Q) + 512) >> 10;
      r->coeffs[4*j+3] = ((((a[5*j+ 3] >> 6) | (((uint32_t)a[5*j+ 4] & 0xff) << 2)) * KYBER_Q) + 512) >> 10;
    }
#else
#error "KYBER_POLYVECCOMPRESSEDBYTES needs to be in {320*KYBER_K, 352*KYBER_K}"
#endif
}
void __attribute__ ((noinline)) indcpa_dec(unsigned char *m,
                                       const unsigned char *c,
                                       const unsigned char *sk) {
    poly mp, skp, bp;
    poly *v = &skp;

    poly_frombytes(&skp, sk);
    poly_unpackdecompress(&bp, c);
    poly_ntt(&bp);
    poly_basemul(&mp, &skp, &bp);
    for(int i=1;i<KYBER_K;i++){
        poly_frombytes(&skp, sk + i*KYBER_POLYBYTES);
        #if (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 352))
        poly_unpackdecompress(&bp, c+i*352);
        #elif (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 320))
        poly_unpackdecompress(&bp, c+i*320);
        #else
        #error "KYBER_POLYVECCOMPRESSEDBYTES needs to be in {320*KYBER_K, 352*KYBER_K}"
        #endif
        poly_ntt(&bp);
        poly_basemul_acc(&mp, &skp, &bp);
    }

    poly_invntt(&mp);
    poly_decompress(v, c+KYBER_POLYVECCOMPRESSEDBYTES);
    poly_sub(&mp, v, &mp);
    poly_reduce(&mp);

    poly_tomsg(m, &mp);
}
