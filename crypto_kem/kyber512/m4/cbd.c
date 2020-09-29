#include "cbd.h"
#include "params.h"

#include <stdint.h>

/*************************************************
* Name:        load32_littleendian
*
* Description: load bytes into a 32-bit integer
*              in little-endian order
*
* Arguments:   - const unsigned char *x: pointer to input byte array
*
* Returns 32-bit unsigned integer loaded from x
**************************************************/
static uint32_t load32_littleendian(const unsigned char *x) {
    uint32_t r;
    r  = (uint32_t)x[0];
    r |= (uint32_t)x[1] << 8;
    r |= (uint32_t)x[2] << 16;
    r |= (uint32_t)x[3] << 24;
    return r;
}

/*************************************************
* Name:        load24_littleendian
*
* Description: load 3 bytes into a 32-bit integer
*              in little-endian order
*              This function is only needed for Kyber-512
*
* Arguments:   - const uint8_t *x: pointer to input byte array
*
* Returns 32-bit unsigned integer loaded from x (most significant byte is zero)
**************************************************/
static uint32_t load24_littleendian(const uint8_t x[3])
{
  uint32_t r;
  r  = (uint32_t)x[0];
  r |= (uint32_t)x[1] << 8;
  r |= (uint32_t)x[2] << 16;
  return r;
}



/*************************************************
* Name:        cbd_eta1
*
* Description: Given an array of uniformly random bytes, compute
*              polynomial with coefficients distributed according to
*              a centered binomial distribution with parameter KYBER_ETA1
*              specialized for KYBER_ETA1=3
*
* Arguments:   - poly *r:                  pointer to output polynomial
*              - const unsigned char *buf: pointer to input byte array
*              - int add:                  boolean to indicate to accumulate into r
**************************************************/
void cbd_eta1(poly *r, const unsigned char *buf, int add) {
  unsigned int i,j;
  uint32_t t,d;
  int16_t a,b;

  for(i=0;i<KYBER_N/4;i++) {
    t  = load24_littleendian(buf+3*i);
    d  = t & 0x00249249;
    d += (t>>1) & 0x00249249;
    d += (t>>2) & 0x00249249;

    for(j=0;j<4;j++) {
      a = (d >> (6*j+0)) & 0x7;
      b = (d >> (6*j+3)) & 0x7;
      if (!add)
        r->coeffs[4 * i + j] = 0;
      r->coeffs[4 * i + j] = r->coeffs[4 * i + j] + (a - b);
    }
  }
}

/*************************************************
* Name:        cbd_eta2
*
* Description: Given an array of uniformly random bytes, compute
*              polynomial with coefficients distributed according to
*              a centered binomial distribution with parameter KYBER_ETA2
*              specialized for KYBER_ETA2=2
*
* Arguments:   - poly *r:                  pointer to output polynomial
*              - const unsigned char *buf: pointer to input byte array
*              - int add:                  boolean to indicate to accumulate into r
**************************************************/
void cbd_eta2(poly *r, const unsigned char *buf, int add) {
    uint32_t d, t;
    int16_t a, b;
    int i, j;

    for (i = 0; i < KYBER_N / 8; i++) {
        t = load32_littleendian(buf + 4 * i);
        d  = t & 0x55555555;
        d += (t >> 1) & 0x55555555;

        for (j = 0; j < 8; j++) {
            a = (d >>  4 * j)    & 0x3;
            b = (d >> (4 * j + 2)) & 0x3;
            if (!add)
              r->coeffs[8 * i + j] = 0;
            r->coeffs[8 * i + j] = r->coeffs[8 * i + j] + (a - b);
        }
    }
}


