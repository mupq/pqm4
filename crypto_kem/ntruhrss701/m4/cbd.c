#include "cbd.h"

void cbdS3(poly *r, const uint32_t *buf)
{
#if NTRU_K != 2
#error "poly_getnoise in poly.c only supports k=2"
#endif

  uint32_t t,d, a[8], b[8];
  int i,j;
                         /* Lookup table for a-b mod 3 with a, b in {0,1,2} */
                         /*      a = 2    |    a = 1      |    a = 0        */
                         /*  b=2  b=1 b=0 |  b=2  b=1 b=0 |  b=2  b=1 b=0   */
  uint32_t L = 0x062118; /*   00   01  10 |   10   00  01 |   01   10  00   */

  for(i=0;i<=NTRU_N/8;i++)
  {
    t = buf[i];
    d = 0;
    d += t & 0x55555555;
    d += (t >> 1) & 0x55555555;

    a[0] = (d & 0x3) << 3;
    b[0] = ((d >> 2) & 0x3) << 1;
    a[1] = ((d >> 4) & 0x3) << 3;
    b[1] = ((d >> 6) & 0x3) << 1;
    a[2] = ((d >> 8) & 0x3) << 3;
    b[2] = ((d >> 10) & 0x3) << 1;
    a[3] = ((d >> 12) & 0x3) << 3;
    b[3] = ((d >> 14) & 0x3) << 1;
    a[4] = ((d >> 16) & 0x3) << 3;
    b[4] = ((d >> 18) & 0x3) << 1;
    a[5] = ((d >> 20) & 0x3) << 3;
    b[5] = ((d >> 22) & 0x3) << 1;
    a[6] = ((d >> 24) & 0x3) << 3;
    b[6] = ((d >> 26) & 0x3) << 1;
    a[7] = ((d >> 28) & 0x3) << 3;
    b[7] = ((d >> 30) & 0x3) << 1;

    for(j=0; (j<8) && ((8*i+j)<NTRU_N); j++)
      r->coeffs[8*i + j] = ((L >> a[j]) >> b[j]) & 3;
  }

  /* S3 has max degree N-1 */
  r->coeffs[NTRU_N-1] = 0;
}
