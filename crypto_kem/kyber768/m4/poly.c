#include "poly.h"

#include "cbd.h"
#include "ntt.h"
#include "params.h"
#include "symmetric.h"

#include <stdint.h>


/*************************************************
* Name:        poly_compress
*
* Description: Serialization of a polynomial and subsequent compression of a polynomial;
*
* Arguments:   - unsigned char *r: pointer to output byte array (of length KYBER_POLYCOMPRESSEDBYTES)
*              - const poly *a:    pointer to input polynomial to be serialized
*************************************************/
void poly_compress(unsigned char *r, poly *a)
{
  uint8_t t[8];
  int i,j,k=0;

#if (KYBER_POLYCOMPRESSEDBYTES == 96)
  for(i=0;i<KYBER_N;i+=8)
  {
    for(j=0;j<8;j++)
      t[j] = ((((uint32_t)a->coeffs[i+j] << 3) + KYBER_Q/2) / KYBER_Q) & 7;

    r[k]   =  t[0]       | (t[1] << 3) | (t[2] << 6);
    r[k+1] = (t[2] >> 2) | (t[3] << 1) | (t[4] << 4) | (t[5] << 7);
    r[k+2] = (t[5] >> 1) | (t[6] << 2) | (t[7] << 5);
    k += 3;
  }
#elif (KYBER_POLYCOMPRESSEDBYTES == 128)
  for(i=0;i<KYBER_N;i+=8)
  {
    for(j=0;j<8;j++)
      t[j] = ((((uint32_t)a->coeffs[i+j] << 4) + KYBER_Q/2) / KYBER_Q) & 15;

    r[k]   = t[0] | (t[1] << 4);
    r[k+1] = t[2] | (t[3] << 4);
    r[k+2] = t[4] | (t[5] << 4);
    r[k+3] = t[6] | (t[7] << 4);
    k += 4;
  }
#elif (KYBER_POLYCOMPRESSEDBYTES == 160)
  for(i=0;i<KYBER_N;i+=8)
  {
    for(j=0;j<8;j++)
      t[j] = ((((uint32_t)a->coeffs[i+j] << 5) + KYBER_Q/2) / KYBER_Q) & 31;

    r[k]   =  t[0]       | (t[1] << 5);
    r[k+1] = (t[1] >> 3) | (t[2] << 2) | (t[3] << 7);
    r[k+2] = (t[3] >> 1) | (t[4] << 4);
    r[k+3] = (t[4] >> 4) | (t[5] << 1) | (t[6] << 6);
    r[k+4] = (t[6] >> 2) | (t[7] << 3);
    k += 5;
  }
#else
#error "KYBER_POLYCOMPRESSEDBYTES needs to be in {96, 128, 160}"
#endif
}

/*************************************************
* Name:        poly_decompress
*
* Description: De-serialization and subsequent decompression of a polynomial;
*              approximate inverse of poly_compress
*
* Arguments:   - poly *r:                pointer to output polynomial
*              - const unsigned char *a: pointer to input byte array (of length KYBER_POLYCOMPRESSEDBYTES bytes)
**************************************************/
void poly_decompress(poly *r, const unsigned char *a)
{
  int i;
#if (KYBER_POLYCOMPRESSEDBYTES == 96)
  for(i=0;i<KYBER_N;i+=8)
  {
    r->coeffs[i+0] =  (((a[0] & 7) * KYBER_Q) + 4) >> 3;
    r->coeffs[i+1] = ((((a[0] >> 3) & 7) * KYBER_Q) + 4) >> 3;
    r->coeffs[i+2] = ((((a[0] >> 6) | ((a[1] << 2) & 4)) * KYBER_Q) + 4) >> 3;
    r->coeffs[i+3] = ((((a[1] >> 1) & 7) * KYBER_Q) + 4) >> 3;
    r->coeffs[i+4] = ((((a[1] >> 4) & 7) * KYBER_Q) + 4) >> 3;
    r->coeffs[i+5] = ((((a[1] >> 7) | ((a[2] << 1) & 6)) * KYBER_Q) + 4) >> 3;
    r->coeffs[i+6] = ((((a[2] >> 2) & 7) * KYBER_Q) + 4) >> 3;
    r->coeffs[i+7] = ((((a[2] >> 5)) * KYBER_Q) + 4) >> 3;
    a += 3;
  }
#elif (KYBER_POLYCOMPRESSEDBYTES == 128)
  for(i=0;i<KYBER_N;i+=8)
  {
    r->coeffs[i+0] = (((a[0] & 15) * KYBER_Q) + 8) >> 4;
    r->coeffs[i+1] = (((a[0] >> 4) * KYBER_Q) + 8) >> 4;
    r->coeffs[i+2] = (((a[1] & 15) * KYBER_Q) + 8) >> 4;
    r->coeffs[i+3] = (((a[1] >> 4) * KYBER_Q) + 8) >> 4;
    r->coeffs[i+4] = (((a[2] & 15) * KYBER_Q) + 8) >> 4;
    r->coeffs[i+5] = (((a[2] >> 4) * KYBER_Q) + 8) >> 4;
    r->coeffs[i+6] = (((a[3] & 15) * KYBER_Q) + 8) >> 4;
    r->coeffs[i+7] = (((a[3] >> 4) * KYBER_Q) + 8) >> 4;
    a += 4;
  }
#elif (KYBER_POLYCOMPRESSEDBYTES == 160)
  for(i=0;i<KYBER_N;i+=8)
  {
    r->coeffs[i+0] =  (((a[0] & 31) * KYBER_Q) + 16) >> 5;
    r->coeffs[i+1] = ((((a[0] >> 5) | ((a[1] & 3) << 3)) * KYBER_Q) + 16) >> 5;
    r->coeffs[i+2] = ((((a[1] >> 2) & 31) * KYBER_Q) + 16) >> 5;
    r->coeffs[i+3] = ((((a[1] >> 7) | ((a[2] & 15) << 1)) * KYBER_Q) + 16) >> 5;
    r->coeffs[i+4] = ((((a[2] >> 4) | ((a[3] &  1) << 4)) * KYBER_Q) + 16) >> 5;
    r->coeffs[i+5] = ((((a[3] >> 1) & 31) * KYBER_Q) + 16) >> 5;
    r->coeffs[i+6] = ((((a[3] >> 6) | ((a[4] &  7) << 2)) * KYBER_Q) + 16) >> 5;
    r->coeffs[i+7] =  (((a[4] >> 3) * KYBER_Q) + 16) >> 5;
    a += 5;
  }
#else
#error "KYBER_POLYCOMPRESSEDBYTES needs to be in {96, 128, 160}"
#endif
}

/*************************************************
* Name:        poly_packcompress
*
* Description: Serialization and subsequent compression of a polynomial of a polyvec,
*              writes to a byte string representation of the whole polyvec.
*              Used to compress a polyvec one poly at a time in a loop.
*
* Arguments:   - unsigned char *r:  pointer to output byte string representation of a polyvec (of length KYBER_POLYVECCOMPRESSEDBYTES)
*              - const poly *a:     pointer to input polynomial
*              - int i:             index of to be serialized polynomial in serialized polyec
**************************************************/
void poly_packcompress(unsigned char *r, poly *a, int i) {
    int j, k;

#if (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 352))
  uint16_t t[8];

  for(j=0;j<KYBER_N/8;j++) {
    for(k=0;k<8;k++)
      t[k] = ((((uint32_t)a->coeffs[8*j+k] << 11) + KYBER_Q/2) / KYBER_Q) & 0x7ff;

    r[352*i+11*j+ 0] =  t[0] & 0xff;
    r[352*i+11*j+ 1] = (t[0] >>  8) | ((t[1] & 0x1f) << 3);
    r[352*i+11*j+ 2] = (t[1] >>  5) | ((t[2] & 0x03) << 6);
    r[352*i+11*j+ 3] = (t[2] >>  2) & 0xff;
    r[352*i+11*j+ 4] = (t[2] >> 10) | ((t[3] & 0x7f) << 1);
    r[352*i+11*j+ 5] = (t[3] >>  7) | ((t[4] & 0x0f) << 4);
    r[352*i+11*j+ 6] = (t[4] >>  4) | ((t[5] & 0x01) << 7);
    r[352*i+11*j+ 7] = (t[5] >>  1) & 0xff;
    r[352*i+11*j+ 8] = (t[5] >>  9) | ((t[6] & 0x3f) << 2);
    r[352*i+11*j+ 9] = (t[6] >>  6) | ((t[7] & 0x07) << 5);
    r[352*i+11*j+10] = (t[7] >>  3);
  }
#elif (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 320))
    uint16_t t[4];

    for (j = 0; j < KYBER_N / 4; j++) {
        for (k = 0; k < 4; k++)
            t[k] = ((((uint32_t)a->coeffs[4 * j + k] << 10) + KYBER_Q / 2) / KYBER_Q) & 0x3ff;

        r[320*i+5*j+0] =   t[0] & 0xff;
        r[320*i+5*j+1] =  (t[0] >>  8) | ((t[1] & 0x3f) << 2);
        r[320*i+5*j+2] = ((t[1] >>  6) | ((t[2] & 0x0f) << 4)) & 0xff;
        r[320*i+5*j+3] = ((t[2] >>  4) | ((t[3] & 0x03) << 6)) & 0xff;
        r[320*i+5*j+4] =  (t[3] >>  2) & 0xff;
    }
#else
#error "KYBER_POLYVECCOMPRESSEDBYTES needs to in (KYBER_K * {352, 320})"
#endif
}

/*************************************************
* Name:        poly_unpackdecompress
*
* Description: Deserialization and subsequent compression of a polynomial of a polyvec,
*              Used to uncompress a polyvec one poly at a time in a loop.
*
* Arguments:   - const poly *r:     pointer to output polynomial
*              - unsigned char *a:  pointer to input byte string representation of a polyvec (of length KYBER_POLYVECCOMPRESSEDBYTES)
*              - int i:             index of poly in polyvec to decompress
**************************************************/
void poly_unpackdecompress(poly *r, const unsigned char *a, int i) {
  int j;
#if (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 352))
    for(j=0;j<KYBER_N/8;j++)
    {
      r->coeffs[8*j+0] =  (((a[352*i+11*j+ 0]       | (((uint32_t)a[352*i+11*j+ 1] & 0x07) << 8)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+1] = ((((a[352*i+11*j+ 1] >> 3) | (((uint32_t)a[352*i+11*j+ 2] & 0x3f) << 5)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+2] = ((((a[352*i+11*j+ 2] >> 6) | (((uint32_t)a[352*i+11*j+ 3] & 0xff) << 2) | (((uint32_t)a[352*i+11*j+4] & 0x01) << 10)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+3] = ((((a[352*i+11*j+ 4] >> 1) | (((uint32_t)a[352*i+11*j+ 5] & 0x0f) << 7)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+4] = ((((a[352*i+11*j+ 5] >> 4) | (((uint32_t)a[352*i+11*j+ 6] & 0x7f) << 4)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+5] = ((((a[352*i+11*j+ 6] >> 7) | (((uint32_t)a[352*i+11*j+ 7] & 0xff) << 1) | (((uint32_t)a[352*i+11*j+8] & 0x03) <<  9)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+6] = ((((a[352*i+11*j+ 8] >> 2) | (((uint32_t)a[352*i+11*j+ 9] & 0x1f) << 6)) * KYBER_Q) + 1024) >> 11;
      r->coeffs[8*j+7] = ((((a[352*i+11*j+ 9] >> 5) | (((uint32_t)a[352*i+11*j+10] & 0xff) << 3)) * KYBER_Q) + 1024) >> 11;
    }
#elif (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 320))
    for(j=0;j<KYBER_N/4;j++)
    {
      r->coeffs[4*j+0] =  (((a[320*i+5*j+ 0]       | (((uint32_t)a[320*i+5*j+ 1] & 0x03) << 8)) * KYBER_Q) + 512) >> 10;
      r->coeffs[4*j+1] = ((((a[320*i+5*j+ 1] >> 2) | (((uint32_t)a[320*i+5*j+ 2] & 0x0f) << 6)) * KYBER_Q) + 512) >> 10;
      r->coeffs[4*j+2] = ((((a[320*i+5*j+ 2] >> 4) | (((uint32_t)a[320*i+5*j+ 3] & 0x3f) << 4)) * KYBER_Q) + 512) >> 10;
      r->coeffs[4*j+3] = ((((a[320*i+5*j+ 3] >> 6) | (((uint32_t)a[320*i+5*j+ 4] & 0xff) << 2)) * KYBER_Q) + 512) >> 10;
    }
#else
#error "KYBER_POLYVECCOMPRESSEDBYTES needs to be in {320*KYBER_K, 352*KYBER_K}"
#endif
}


/*************************************************
* Name:        cmp_poly_compress
*
* Description: Serializes and consequently compares polynomial to a serialized polynomial
*
* Arguments:   - const unsigned char *r:    pointer to serialized polynomial to compare with
*              - poly *a:                   pointer to input polynomial to serialize and compare
* Returns:                                  boolean indicating whether the polynomials are equal
**************************************************/
int cmp_poly_compress(const unsigned char *r, poly *a) {
    unsigned char rc = 0;
    uint8_t t[8];
    int i, j, k = 0;

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
        for (j = 0; j < 8; j++)
            t[j] = ((((uint32_t)a->coeffs[i + j] << 4) + KYBER_Q / 2) / KYBER_Q) & 15;

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

/*************************************************
* Name:        cmp_poly_packcompress
*
* Description: Serializes and consequently compares poly of polyvec to a serialized polyvec
*              Should be called in a loop over all poly's of a polyvec.
*
* Arguments:   - const unsigned char *r:    pointer to serialized polyvec to compare with
*              - poly *a:                   pointer to input polynomial of polyvec to serialize and compare
*              - int i:                     index of poly in polyvec to compare with
* Returns:                                  boolean indicating whether the polyvecs are equal
**************************************************/
int cmp_poly_packcompress(const unsigned char *r, poly *a, int i) {
    unsigned char rc = 0;
    int j, k;

#if (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 352))
  uint16_t t[8];
    for(j=0;j<KYBER_N/8;j++)
    {
      for(k=0;k<8;k++)
        t[k] = ((((uint32_t)a->coeffs[8*j+k] << 11) + KYBER_Q/2) / KYBER_Q) & 0x7ff;

      rc |= r[352*i+11*j+ 0] ^ (t[0] & 0xff);
      rc |= r[352*i+11*j+ 1] ^ ((t[0] >>  8) | ((t[1] & 0x1f) << 3));
      rc |= r[352*i+11*j+ 2] ^ ((t[1] >>  5) | ((t[2] & 0x03) << 6));
      rc |= r[352*i+11*j+ 3] ^ ((t[2] >>  2) & 0xff);
      rc |= r[352*i+11*j+ 4] ^ ((t[2] >> 10) | ((t[3] & 0x7f) << 1));
      rc |= r[352*i+11*j+ 5] ^ ((t[3] >>  7) | ((t[4] & 0x0f) << 4));
      rc |= r[352*i+11*j+ 6] ^ ((t[4] >>  4) | ((t[5] & 0x01) << 7));
      rc |= r[352*i+11*j+ 7] ^ ((t[5] >>  1) & 0xff);
      rc |= r[352*i+11*j+ 8] ^ ((t[5] >>  9) | ((t[6] & 0x3f) << 2));
      rc |= r[352*i+11*j+ 9] ^ ((t[6] >>  6) | ((t[7] & 0x07) << 5));
      rc |= r[352*i+11*j+10] ^ ((t[7] >>  3));
    }
#elif (KYBER_POLYVECCOMPRESSEDBYTES == (KYBER_K * 320))
    uint16_t t[4];
        for (j = 0; j < KYBER_N / 4; j++) {
            for (k = 0; k < 4; k++)
                t[k] = ((((uint32_t)a->coeffs[4 * j + k] << 10) + KYBER_Q / 2) / KYBER_Q) & 0x3ff;

            rc |= r[320*i+5*j+0] ^ (t[0] & 0xff);
            rc |= r[320*i+5*j+1] ^ ((t[0] >>  8) | ((t[1] & 0x3f) << 2));
            rc |= r[320*i+5*j+2] ^ (((t[1] >>  6) | ((t[2] & 0x0f) << 4)) & 0xff);
            rc |= r[320*i+5*j+3] ^ (((t[2] >>  4) | ((t[3] & 0x03) << 6)) & 0xff);
            rc |= r[320*i+5*j+4] ^ ((t[3] >>  2) & 0xff);
        }
#else
#error "KYBER_POLYVECCOMPRESSEDBYTES needs to be in {320*KYBER_K, 352*KYBER_K}"
#endif
    return rc;
}

/*************************************************
* Name:        poly_tobytes
*
* Description: Serialization of a polynomial
*
* Arguments:   - unsigned char *r: pointer to output byte array (needs space for KYBER_POLYBYTES bytes)
*              - const poly *a:    pointer to input polynomial
**************************************************/
void poly_tobytes(unsigned char *r, poly *a) {
    int i;
    uint16_t t0, t1;

    poly_reduce(a);

    for (i = 0; i < KYBER_N / 2; i++) {
        t0 = a->coeffs[2 * i];
        t1 = a->coeffs[2 * i + 1];
        r[3 * i] = t0 & 0xff;
        r[3 * i + 1] = (t0 >> 8) | ((t1 & 0xf) << 4);
        r[3 * i + 2] = (t1 >> 4) & 0xff;
    }
}

/*************************************************
* Name:        poly_frombytes
*
* Description: De-serialization of a polynomial;
*              inverse of poly_tobytes
*
* Arguments:   - poly *r:                pointer to output polynomial
*              - const unsigned char *a: pointer to input byte array (of KYBER_POLYBYTES bytes)
**************************************************/
void poly_frombytes(poly *r, const unsigned char *a) {
    int i;

    for (i = 0; i < KYBER_N / 2; i++) {
        r->coeffs[2 * i]     = a[3 * i]          | ((uint16_t)a[3 * i + 1] & 0x0f) << 8;
        r->coeffs[2 * i + 1] = a[3 * i + 1] >> 4 | ((uint16_t)a[3 * i + 2] & 0xff) << 4;
    }
}


extern void doublebasemul_asm(int16_t *r, const int16_t *a, const int16_t *b, int16_t zeta);
/*************************************************
* Name:        poly_frombytes_mul
*
* Description: Multiplication of a polynomial with a de-serialization of another polynomial
*
* Arguments:   - poly *r:                pointer to output polynomial
*              - const unsigned char *a: pointer to input byte array (of KYBER_POLYBYTES bytes)
**************************************************/
void poly_frombytes_mul(poly *r, const unsigned char *a) {
    int16_t tmp[4];
    int i;

    for (i = 0; i < KYBER_N / 4; i++) {
        tmp[0] = a[6 * i]          | ((uint16_t)a[6 * i + 1] & 0x0f) << 8;
        tmp[1] = a[6 * i + 1] >> 4 | ((uint16_t)a[6 * i + 2] & 0xff) << 4;
        tmp[2] = a[6 * i + 3]      | ((uint16_t)a[6 * i + 4] & 0x0f) << 8;
        tmp[3] = a[6 * i + 4] >> 4 | ((uint16_t)a[6 * i + 5] & 0xff) << 4;

        doublebasemul_asm(&r->coeffs[4*i], &r->coeffs[4*i], tmp, zetas[i]);
    }
}

/*************************************************
* Name:        poly_getnoise
*
* Description: Sample a polynomial deterministically from a seed and a nonce,
*              with output polynomial close to centered binomial distribution
*              with parameter KYBER_ETA
*
* Arguments:   - poly *r:                   pointer to output polynomial
*              - const unsigned char *seed: pointer to input seed (pointing to array of length KYBER_SYMBYTES bytes)
*              - unsigned char nonce:       one-byte input nonce
*              - int add:                   boolean to indicate to accumulate into r
**************************************************/
void poly_noise(poly *r, const unsigned char *seed, unsigned char nonce, int add) {
    unsigned char buf[KYBER_ETA * KYBER_N / 4];

    prf(buf, KYBER_ETA * KYBER_N / 4, seed, nonce);
    cbd(r, buf, add);
}

/*************************************************
* Name:        poly_ntt
*
* Description: Computes negacyclic number-theoretic transform (NTT) of
*              a polynomial in place;
*              inputs assumed to be in normal order, output in bitreversed order
*
* Arguments:   - uint16_t *r: pointer to in/output polynomial
**************************************************/
void poly_ntt(poly *r) {
    ntt(r->coeffs);
}

/*************************************************
* Name:        poly_invntt
*
* Description: Computes inverse of negacyclic number-theoretic transform (NTT) of
*              a polynomial in place;
*              inputs assumed to be in bitreversed order, output in normal order
*
* Arguments:   - uint16_t *a: pointer to in/output polynomial
**************************************************/
void poly_invntt(poly *r) {
    invntt(r->coeffs);
}

extern void basemul_asm(int16_t *, const int16_t *, const int16_t *, const int16_t *);
/*************************************************
* Name:        poly_basemul
*
* Description: Multiplication of two polynomials in NTT domain
*
* Arguments:   - poly *r:       pointer to output polynomial
*              - const poly *a: pointer to first input polynomial
*              - const poly *b: pointer to second input polynomial
**************************************************/
void poly_basemul(poly *r, const poly *a, const poly *b) {
    basemul_asm(r->coeffs, a->coeffs, b->coeffs, zetas);
}

extern void basemul_asm_acc(int16_t *, const int16_t *, const int16_t *, const int16_t *);
/*************************************************
* Name:        poly_basemul_acc
*
* Description: Multiplication of two polynomials in NTT domain, accumulating
*
* Arguments:   - poly *r:       pointer to output polynomial
*              - const poly *a: pointer to first input polynomial
*              - const poly *b: pointer to second input polynomial
**************************************************/
void poly_basemul_acc(poly *r, const poly *a, const poly *b) {
    basemul_asm_acc(r->coeffs, a->coeffs, b->coeffs, zetas);
}

extern void asm_frommont(int16_t *r);
/*************************************************
* Name:        poly_frommont
*
* Description: Inplace conversion of all coefficients of a polynomial
*              from Montgomery domain to normal domain
*
* Arguments:   - poly *r:       pointer to input/output polynomial
**************************************************/
void poly_frommont(poly *r) {
  asm_frommont(r->coeffs);
}

extern void asm_barrett_reduce(int16_t *r);
/*************************************************
* Name:        poly_reduce
*
* Description: Applies Barrett reduction to all coefficients of a polynomial
*              for details of the Barrett reduction see comments in reduce.c
*
* Arguments:   - poly *r:       pointer to input/output polynomial
**************************************************/
void poly_reduce(poly *r) {
  asm_barrett_reduce(r->coeffs);
}

extern void pointwise_add(int16_t *, const int16_t *, const int16_t *);
/*************************************************
* Name:        poly_add
*
* Description: Add two polynomials
*
* Arguments: - poly *r:       pointer to output polynomial
*            - const poly *a: pointer to first input polynomial
*            - const poly *b: pointer to second input polynomial
**************************************************/
void poly_add(poly *r, const poly *a, const poly *b) {
    pointwise_add(r->coeffs,a->coeffs,b->coeffs);
}


extern void pointwise_sub(int16_t *, const int16_t *, const int16_t *);
/*************************************************
* Name:        poly_sub
*
* Description: Subtract two polynomials
*
* Arguments: - poly *r:       pointer to output polynomial
*            - const poly *a: pointer to first input polynomial
*            - const poly *b: pointer to second input polynomial
**************************************************/
void poly_sub(poly *r, const poly *a, const poly *b) {
    pointwise_sub(r->coeffs,a->coeffs,b->coeffs);
}

/*************************************************
* Name:        poly_frommsg
*
* Description: Convert 32-byte message to polynomial
*
* Arguments:   - poly *r:                  pointer to output polynomial
*              - const unsigned char *msg: pointer to input message
**************************************************/
void poly_frommsg(poly *r, const unsigned char msg[KYBER_SYMBYTES]) {
    int i, j;
    uint16_t mask;

    for (i = 0; i < KYBER_SYMBYTES; i++) {
        for (j = 0; j < 8; j++) {
            mask = -((msg[i] >> j) & 1);
            r->coeffs[8 * i + j] = mask & ((KYBER_Q + 1) / 2);
        }
    }
}

/*************************************************
* Name:        poly_tomsg
*
* Description: Convert polynomial to 32-byte message
*
* Arguments:   - unsigned char *msg: pointer to output message
*              - const poly *a:      pointer to input polynomial
**************************************************/
void poly_tomsg(unsigned char msg[KYBER_SYMBYTES], poly *a) {
    uint16_t t;
    int i, j;

    for (i = 0; i < KYBER_SYMBYTES; i++) {
        msg[i] = 0;
        for (j = 0; j < 8; j++) {
            t = (((a->coeffs[8 * i + j] << 1) + KYBER_Q / 2) / KYBER_Q) & 1;
            msg[i] |= t << j;
        }
    }
}

/*************************************************
* Name:        poly_zeroize
*
* Description: Zeros a polynomial
*
* Arguments:   - poly *p: pointer to polynomial
**************************************************/
void poly_zeroize(poly *p) {
  int i;
  for(i = 0; i < KYBER_N; i++)
   p->coeffs[i] = 0;
}
