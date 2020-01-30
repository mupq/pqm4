#include <string.h>
#include "poly.h"
#include "fips202.h"

/*************************************************
* Name:        flipabs
*
* Description: Computes |(x mod q) - Q/2|
*
* Arguments:   int16_t x: input coefficient
*
* Returns |(x mod q) - Q/2|
**************************************************/
static uint16_t flipabs(int16_t x)
{
  int16_t r,m;
	x -= (x>>14)*NEWHOPE_Q;
	r = (x + ((x>>15)&NEWHOPE_Q));
  r = r - NEWHOPE_Q/2;
  m = r >> 15;
  return (r + m) ^ m;
}

/*************************************************
* Name:        poly_frombytes
*
* Description: De-serialization of a polynomial
*
* Arguments:   - poly *r:                pointer to output polynomial
*              - const unsigned char *a: pointer to input byte array
**************************************************/
void poly_frombytes(poly *r, const unsigned char *a)
{
  int i;
  for(i=0;i<NEWHOPE_N/4;i++)
  {
    r->coeffs[4*i+0] =                              a[7*i+0]        | (((int16_t)a[7*i+1] & 0x3f) << 8);
    r->coeffs[4*i+1] = (a[7*i+1] >> 6) | (((int16_t)a[7*i+2]) << 2) | (((int16_t)a[7*i+3] & 0x0f) << 10);
    r->coeffs[4*i+2] = (a[7*i+3] >> 4) | (((int16_t)a[7*i+4]) << 4) | (((int16_t)a[7*i+5] & 0x03) << 12);
    r->coeffs[4*i+3] = (a[7*i+5] >> 2) | (((int16_t)a[7*i+6]) << 6);
  }
}


extern void asm_eight_mul(int16_t *a, const int16_t *b);

/*************************************************
* Name:        poly_frombytes_mul
*
* Description: Multiplication of the de-serialization of two polynomials
*
* Arguments:   - poly *r:                pointer to output polynomial
*              - const unsigned char *a: pointer to input byte array
*              - const unsigned char *b: pointer to input byte array
**************************************************/
void poly_frombytes_mul(poly *r, const unsigned char *a, const unsigned char *b)
{
  int16_t temp[8];
  int i;

  for(i=0;i<NEWHOPE_N/8;i++)
  {
    r->coeffs[8*i+0] =                                a[14*i+0]        | (((int16_t)a[14*i+1] & 0x3f) << 8);
    r->coeffs[8*i+1] = (a[14*i+1] >> 6)  | (((int16_t)a[14*i+2]) << 2) | (((int16_t)a[14*i+3] & 0x0f) << 10);
    r->coeffs[8*i+2] = (a[14*i+3] >> 4)  | (((int16_t)a[14*i+4]) << 4) | (((int16_t)a[14*i+5] & 0x03) << 12);
    r->coeffs[8*i+3] = (a[14*i+5] >> 2)  | (((int16_t)a[14*i+6]) << 6);
    r->coeffs[8*i+4] =                                a[14*i+7]         | (((int16_t)a[14*i+8] & 0x3f) << 8);
    r->coeffs[8*i+5] = (a[14*i+8]  >> 6) | (((int16_t)a[14*i+9]) << 2)  | (((int16_t)a[14*i+10] & 0x0f) << 10);
    r->coeffs[8*i+6] = (a[14*i+10] >> 4) | (((int16_t)a[14*i+11]) << 4) | (((int16_t)a[14*i+12] & 0x03) << 12);
    r->coeffs[8*i+7] = (a[14*i+12] >> 2) | (((int16_t)a[14*i+13]) << 6);

    temp[0] =                               b[14*i+0]        | (((int16_t)b[14*i+1] & 0x3f) << 8);
    temp[1] = (b[14*i+1] >> 6) | (((int16_t)b[14*i+2]) << 2) | (((int16_t)b[14*i+3] & 0x0f) << 10);
    temp[2] = (b[14*i+3] >> 4) | (((int16_t)b[14*i+4]) << 4) | (((int16_t)b[14*i+5] & 0x03) << 12);
    temp[3] = (b[14*i+5] >> 2) | (((int16_t)b[14*i+6]) << 6);
    temp[4] =                                b[14*i+7]         | (((int16_t)b[14*i+8] & 0x3f) << 8);
    temp[5] = (b[14*i+8] >> 6)  | (((int16_t)b[14*i+9]) << 2)  | (((int16_t)b[14*i+10] & 0x0f) << 10);
    temp[6] = (b[14*i+10] >> 4) | (((int16_t)b[14*i+11]) << 4) | (((int16_t)b[14*i+12] & 0x03) << 12);
    temp[7] = (b[14*i+12] >> 2) | (((int16_t)b[14*i+13]) << 6);

    asm_eight_mul(&r->coeffs[8*i], temp);
  }
}

/*************************************************
* Name:        poly_tobytes
*
* Description: Serialization of a polynomial
*
* Arguments:   - unsigned char *r: pointer to output byte array
*              - const poly *p:    pointer to input polynomial
**************************************************/
void poly_tobytes(unsigned char *r, const poly *p)
{
  // poly_reduce(p);

  int i;
  for(i=0;i<NEWHOPE_N/4;i++)
  {
    r[7*i+0] =  (p->coeffs[4*i  ]) & 0xff;
    r[7*i+1] = ((p->coeffs[4*i  ]) >> 8) | ((p->coeffs[4*i+1]) << 6);
    r[7*i+2] = ((p->coeffs[4*i+1]) >> 2);
    r[7*i+3] = ((p->coeffs[4*i+1]) >> 10) | ((p->coeffs[4*i+2]) << 4);
    r[7*i+4] = ((p->coeffs[4*i+2]) >> 4);
    r[7*i+5] = ((p->coeffs[4*i+2]) >> 12) | ((p->coeffs[4*i+3]) << 2);
    r[7*i+6] = ((p->coeffs[4*i+3]) >> 6);
  }
}

/*************************************************
* Name:        poly_tobytes_cmp
*
* Description: TODO
*
* Arguments:   - const unsigned char *r: pointer to input byte array
*              - const poly *a:    pointer to input polynomial
*
* Returns:     integer indicating whether r and serialized a are equal
**************************************************/
int poly_tobytes_cmp(const unsigned char *r, const poly *a)
{
  // poly_reduce(p);

  unsigned char rc= 0;

  int i;
  for(i=0;i<NEWHOPE_N/4;i++)
  {
    rc |= (r[7*i+0] ^ (a->coeffs[4*i] & 0xff));
    rc |= (r[7*i+1] ^ ((a->coeffs[4*i] >> 8) | (a->coeffs[4*i+1] << 6)));
    rc |= (r[7*i+2] ^ (a->coeffs[4*i+1] >> 2));
    rc |= (r[7*i+3] ^ ((a->coeffs[4*i+1] >> 10) | (a->coeffs[4*i+2] << 4)));
    rc |= (r[7*i+4] ^ (a->coeffs[4*i+2] >> 4));
    rc |= (r[7*i+5] ^ ((a->coeffs[4*i+2] >> 12) | (a->coeffs[4*i+3] << 2)));
    rc |= (r[7*i+6] ^ (a->coeffs[4*i+3] >> 6));
  }

  return rc;
}

/*************************************************
* Name:        poly_compress
*
* Description: Compression and subsequent serialization of a polynomial
*
* Arguments:   - unsigned char *r: pointer to output byte array
*              - const poly *p:    pointer to input polynomial
**************************************************/
void poly_compress(unsigned char *r, const poly *p)
{
  unsigned int i,j,k=0;
  uint8_t t[8];

  for(i=0;i<NEWHOPE_N;i+=8)
  {
    for(j=0;j<8;j++)
      t[j] = ((((p->coeffs[i+j]) << 3) + NEWHOPE_Q/2)/NEWHOPE_Q) & 0x7;

    r[k]   =  t[0]       | (t[1] << 3) | (t[2] << 6);
    r[k+1] = (t[2] >> 2) | (t[3] << 1) | (t[4] << 4) | (t[5] << 7);
    r[k+2] = (t[5] >> 1) | (t[6] << 2) | (t[7] << 5);
    k += 3;
  }
}

/*************************************************
* Name:        poly_compress_cmp
*
* Description: Compression and subsequent serialization of a polynomial TODO
*
* Arguments:   - const unsigned char *r: pointer to input byte array
*              - const poly *p:    pointer to input polynomial
*
* Returns:     integer indicating whether r and compressed a are equal
**************************************************/
int poly_compress_cmp(const unsigned char *r, const poly *p)
{
  unsigned char rc = 0;

  unsigned int i,j,k=0;
  uint8_t t[8];

  for(i=0;i<NEWHOPE_N;i+=8)
  {
    for(j=0;j<8;j++)
      t[j] = (((p->coeffs[i+j] << 3) + NEWHOPE_Q/2)/NEWHOPE_Q) & 0x7;

    rc |= r[k]   ^ ( t[0]       | (t[1] << 3) | (t[2] << 6));
    rc |= r[k+1] ^ ((t[2] >> 2) | (t[3] << 1) | (t[4] << 4) | (t[5] << 7));
    rc |= r[k+2] ^ ((t[5] >> 1) | (t[6] << 2) | (t[7] << 5));
    k += 3;
  }

  return rc;
}

/*************************************************
* Name:        poly_decompress_sub
*
* Description: De-serialization and subsequent decompression of a polynomial
*              is substracted from another polynomial
*              Computes r=r-poly_decompress(a)
*
* Arguments:   - poly *r:                pointer to input and output polynomial
*              - const unsigned char *a: pointer to input byte array
**************************************************/
void poly_decompress_sub(poly *r, const unsigned char * a)
{
  int i;
  for(i=0;i<NEWHOPE_N;i+=8)
  {
    r->coeffs[i+0] -=  (((uint32_t)(a[0] & 7) * NEWHOPE_Q) + 4) >> 3;
    r->coeffs[i+1] -= (((uint32_t)((a[0] >> 3) & 7) * NEWHOPE_Q) + 4) >> 3;
    r->coeffs[i+2] -= (((uint32_t)((a[0] >> 6) | ((a[1] << 2) & 4)) * NEWHOPE_Q) + 4) >> 3;
    r->coeffs[i+3] -= (((uint32_t)((a[1] >> 1) & 7) * NEWHOPE_Q) + 4) >> 3;
    r->coeffs[i+4] -= (((uint32_t)((a[1] >> 4) & 7) * NEWHOPE_Q) + 4) >> 3;
    r->coeffs[i+5] -= (((uint32_t)((a[1] >> 7) | ((a[2] << 1) & 6)) * NEWHOPE_Q) + 4) >> 3;
    r->coeffs[i+6] -= (((uint32_t)((a[2] >> 2) & 7) * NEWHOPE_Q) + 4) >> 3;
    r->coeffs[i+7] -= (((uint32_t)((a[2] >> 5)) * NEWHOPE_Q) + 4) >> 3;
    a += 3;
  }
}

/*************************************************
* Name:        poly_frommsg
*
* Description: Convert 32-byte message to polynomial
*
* Arguments:   - poly *r:                  pointer to output polynomial
*              - const unsigned char *msg: pointer to input message
**************************************************/
void poly_frommsg(poly *r, const unsigned char *msg)
{
  unsigned int i,j,mask;
  for(i=0;i<NEWHOPE_SYMBYTES;i++)
  {
    for(j=0;j<8;j++)
    {
      mask = -((msg[i] >> j)&1);
      r->coeffs[8*i+j+  0] += (mask & (NEWHOPE_Q/2));
      r->coeffs[8*i+j+256] += (mask & (NEWHOPE_Q/2));
    }
  }
}

/*************************************************
* Name:        poly_tomsg
*
* Description: Convert polynomial to 32-byte message
*
* Arguments:   - unsigned char *msg: pointer to output message
*              - const poly *x:      pointer to input polynomial
**************************************************/
void poly_tomsg(unsigned char *msg, const poly *x)
{
  unsigned int i;
  uint16_t t;

  memset(msg,0,NEWHOPE_SYMBYTES);

  for(i=0;i<256;i++)
  {
    t  = flipabs(x->coeffs[i+  0]);
    t += flipabs(x->coeffs[i+256]);
    t = ((t - NEWHOPE_Q/2));

    t >>= 15;
    msg[i>>3] |= t<<(i&7);
  }
}


/*************************************************
* Name:        poly_uniform_mul_s
*
* Description: Sample a polynomial deterministically from a seed,
*              with output polynomial looking uniformly random
*
* Arguments:   - poly *a:                   pointer to output polynomial
*              - const unsigned char *seed: pointer to input seed
**************************************************/
void poly_uniform_mul_s(poly *a, const unsigned char *seed)
{
  unsigned int ctr=0;
  uint16_t val;
  shake128ctx state;
  uint8_t buf[SHAKE128_RATE];
  uint8_t extseed[NEWHOPE_SYMBYTES+1];
  int i,j, count=0;
  int16_t c[8];

  memcpy(extseed, seed, NEWHOPE_SYMBYTES);

  for(i=0;i<NEWHOPE_N;i+=64) /* generate a in blocks of 64 coefficients */
  {
    ctr = 0;
    extseed[NEWHOPE_SYMBYTES] = i/64; /* domain-separate the 16 independent calls */
    shake128_absorb(&state, extseed, NEWHOPE_SYMBYTES+1);
    while(ctr < 64) /* Very unlikely to run more than once */
    {
      shake128_squeezeblocks(buf,1,&state);
      for(j=0;j<SHAKE128_RATE && ctr < 64;j+=2)
      {
        val = (buf[j] | ((uint16_t) buf[j+1] << 8));
        if(val < 5*NEWHOPE_Q)
        {
          c[count++] = (int16_t)(val - ((val>>14)*NEWHOPE_Q));
          ctr++;
        }

        if(count == (sizeof(c) / sizeof(c[0]))) {
          asm_eight_mul(&a->coeffs[i+ctr-8], c);
          count = 0;
        }
      }
    }
  }
}

/*************************************************
* Name:        poly_sample
*
* Description: Sample a polynomial deterministically from a seed and a nonce,
*              with output polynomial close to centered binomial distribution
*              with parameter k=8
*
* Arguments:   - poly *r:                   pointer to output polynomial
*              - const unsigned char *seed: pointer to input seed
*              - unsigned char nonce:       one-byte input nonce
**************************************************/
void poly_sample(poly *r, const unsigned char *seed, unsigned char nonce, int add)
{
#if NEWHOPE_K != 8
#error "poly_sample in poly.c only supports k=8"
#endif
  unsigned char buf[128], k;
  uint32_t t, d, a, b, c;
  int i,j;

  unsigned char extseed[NEWHOPE_SYMBYTES+2];

  for(i=0;i<NEWHOPE_SYMBYTES;i++)
    extseed[i] = seed[i];
  extseed[NEWHOPE_SYMBYTES] = nonce;

  for(i=0;i<NEWHOPE_N;i+=64) /* Generate noise in blocks of 64 coefficients */
  {
    extseed[NEWHOPE_SYMBYTES+1] = i/64;
    shake256(buf,128,extseed,NEWHOPE_SYMBYTES+2);
    for(j=0;j<32;j++)
    {
      t = buf[4*j] | ((uint32_t)buf[4*j+1] << 8) | ((uint32_t)buf[4*j+2] << 16) | ((uint32_t)buf[4*j+3] << 24);
      d = 0;
      for(k=0;k<8;k++)
        d += (t >> k) & 0x01010101;
      a = d & 0xff;
      b = ((d >>  8) & 0xff);
      c = ((d >> 16) & 0xff);
      d >>= 24;
      if (!add)
      {
        r->coeffs[i+2*j]   = 0;
        r->coeffs[i+2*j+1] = 0;
      }
      r->coeffs[i+2*j]   += (a - b);
      r->coeffs[i+2*j+1] += (c - d);
    }
  }
}


extern void asm_mul_coeff(int16_t*, const int16_t*);

/*************************************************
* Name:        poly_pointwise
*
* Description: Multiply two polynomials pointwise (i.e., coefficient-wise).
*
* Arguments:   - poly *r:       pointer to output polynomial
*              - const poly *a: pointer to first input polynomial
*              - const poly *b: pointer to second input polynomial
**************************************************/
void poly_mul_pointwise(poly *r, const poly *a)
{
  asm_mul_coeff(r->coeffs, a->coeffs);
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

extern void asm_add(int16_t *r, const int16_t* a);

/*************************************************
* Name:        poly_add
*
* Description: Add two polynomials
*
* Arguments:   - poly *r:       pointer to output polynomial
*              - const poly *a: pointer to input and output polynomials
**************************************************/
void poly_add(poly *r, const poly *a)
{
  asm_add(r->coeffs, a->coeffs);
}


extern int16_t gammas_bitrev_montgomery[];
extern void asm_ntt(int16_t*, const int16_t*);
extern void bitrev(int16_t*);
/*************************************************
* Name:        poly_ntt
*
* Description: Forward NTT transform of a polynomial in place
*              Input is assumed to have coefficients in bitreversed order
*              Output has coefficients in normal order
*
* Arguments:   - poly *r: pointer to in/output polynomial
**************************************************/
void poly_ntt(poly *r)
{
  asm_ntt(r->coeffs, gammas_bitrev_montgomery);
}

void poly_bitrev(poly *r)
{
	bitrev(r->coeffs);
}
extern int16_t gammas_inv_montgomery[];
extern void asm_invntt(int16_t*, const int16_t*);

/*************************************************
* Name:        poly_invntt
*
* Description: Inverse NTT transform of a polynomial in place
*              Input is assumed to have coefficients in normal order
*              Output has coefficients in normal order
*
* Arguments:   - poly *r: pointer to in/output polynomial
**************************************************/
void poly_invntt(poly *r)
{
  asm_invntt(r->coeffs, gammas_inv_montgomery);
}
