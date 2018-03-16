#include "poly.h"
#include "cbd.h"
#include "fips202.h"

#define MODQ(X) ((X) & (NTRU_Q-1))

/* Map {0, 1, 2} -> {0,1,q-1} */
#define ZP_TO_ZQ(C) \
    (((C) & 1) | ((-((C)>>1)) & (NTRU_Q-1)));

/* Map {0,1,2,4} -> {0,1,2^16-1,1} */
#define ZP_PROD_TO_UINT16(C) \
  (((C) | ((C)>>2)) & 1)  |  (-(((C) & 2)>>1))

uint16_t mod3(uint16_t a)
{
  uint16_t r;
  int16_t t, c;

  r = (a >> 8) + (a & 0xff); // r mod 255 == a mod 255
  r = (r >> 4) + (r & 0xf); // r' mod 15 == r mod 15
  r = (r >> 2) + (r & 0x3); // r' mod 3 == r mod 3
  r = (r >> 2) + (r & 0x3); // r' mod 3 == r mod 3

  t = r - 3;
  c = t >> 15;

  return (c&r) ^ (~c&t);
}

void poly_Rq_tobytes(unsigned char *r, const poly *a)
{
  int i,j;
  uint16_t t[8];

  for(i=0;i<NTRU_PACK_DEG/8;i++)
  {
    for(j=0;j<8;j++)
      t[j] = a->coeffs[8*i+j];

    r[13*i+ 0] =  t[0]        & 0xff;
    r[13*i+ 1] = (t[0] >>  8) | ((t[1] & 0x07) << 5);
    r[13*i+ 2] = (t[1] >>  3) & 0xff;
    r[13*i+ 3] = (t[1] >> 11) | ((t[2] & 0x3f) << 2);
    r[13*i+ 4] = (t[2] >>  6) | ((t[3] & 0x01) << 7);
    r[13*i+ 5] = (t[3] >>  1) & 0xff;
    r[13*i+ 6] = (t[3] >>  9) | ((t[4] & 0x0f) << 4);
    r[13*i+ 7] = (t[4] >>  4) & 0xff;
    r[13*i+ 8] = (t[4] >> 12) | ((t[5] & 0x7f) << 1);
    r[13*i+ 9] = (t[5] >>  7) | ((t[6] & 0x03) << 6);
    r[13*i+10] = (t[6] >>  2) & 0xff;
    r[13*i+11] = (t[6] >> 10) | ((t[7] & 0x1f) << 3);
    r[13*i+12] = (t[7] >>  5);
  }

  for(j=0;j<NTRU_PACK_DEG-8*i;j++)
    t[j] = a->coeffs[8*i+j];
  for(; j<8; j++)
    t[j] = 0;

  switch(NTRU_PACK_DEG - 8*(NTRU_PACK_DEG/8))
  {
    case 6:
      r[13*i+ 9] = (t[5] >>  7) | ((t[6] & 0x03) << 6);
      r[13*i+ 8] = (t[4] >> 12) | ((t[5] & 0x7f) << 1);
      r[13*i+ 7] = (t[4] >>  4) & 0xff;
    // fallthrough
    case 4:
      r[13*i+ 6] = (t[3] >>  9) | ((t[4] & 0x0f) << 4);
      r[13*i+ 5] = (t[3] >>  1) & 0xff;
      r[13*i+ 4] = (t[2] >>  6) | ((t[3] & 0x01) << 7);
    // fallthrough
    case 2:
      r[13*i+ 3] = (t[1] >> 11) | ((t[2] & 0x3f) << 2);
      r[13*i+ 2] = (t[1] >>  3) & 0xff;
      r[13*i+ 1] = (t[0] >>  8) | ((t[1] & 0x07) << 5);
      r[13*i+ 0] =  t[0]        & 0xff;
  }
}

void poly_Rq_frombytes(poly *r, const unsigned char *a)
{
  int i;
  for(i=0;i<NTRU_PACK_DEG/8;i++)
  {
    r->coeffs[8*i+0] =  a[13*i+ 0]       | (((uint16_t)a[13*i+ 1] & 0x1f) << 8);
    r->coeffs[8*i+1] = (a[13*i+ 1] >> 5) | (((uint16_t)a[13*i+ 2]       ) << 3) | (((uint16_t)a[13*i+ 3] & 0x03) << 11);
    r->coeffs[8*i+2] = (a[13*i+ 3] >> 2) | (((uint16_t)a[13*i+ 4] & 0x7f) << 6);
    r->coeffs[8*i+3] = (a[13*i+ 4] >> 7) | (((uint16_t)a[13*i+ 5]       ) << 1) | (((uint16_t)a[13*i+ 6] & 0x0f) <<  9);
    r->coeffs[8*i+4] = (a[13*i+ 6] >> 4) | (((uint16_t)a[13*i+ 7]       ) << 4) | (((uint16_t)a[13*i+ 8] & 0x01) << 12);
    r->coeffs[8*i+5] = (a[13*i+ 8] >> 1) | (((uint16_t)a[13*i+ 9] & 0x3f) << 7);
    r->coeffs[8*i+6] = (a[13*i+ 9] >> 6) | (((uint16_t)a[13*i+10]       ) << 2) | (((uint16_t)a[13*i+11] & 0x07) << 10);
    r->coeffs[8*i+7] = (a[13*i+11] >> 3) | (((uint16_t)a[13*i+12]       ) << 5);
  }
  switch(NTRU_PACK_DEG - 8*(NTRU_PACK_DEG/8))
  {
    case 6:
      r->coeffs[8*i+5] = (a[13*i+ 8] >> 1) | (((uint16_t)a[13*i+ 9] & 0x3f) << 7);
      r->coeffs[8*i+4] = (a[13*i+ 6] >> 4) | (((uint16_t)a[13*i+ 7]       ) << 4) | (((uint16_t)a[13*i+ 8] & 0x01) << 12);
    // fallthrough
    case 4:
      r->coeffs[8*i+3] = (a[13*i+ 4] >> 7) | (((uint16_t)a[13*i+ 5]       ) << 1) | (((uint16_t)a[13*i+ 6] & 0x0f) <<  9);
      r->coeffs[8*i+2] = (a[13*i+ 3] >> 2) | (((uint16_t)a[13*i+ 4] & 0x7f) << 6);
    // fallthrough
    case 2:
      r->coeffs[8*i+1] = (a[13*i+ 1] >> 5) | (((uint16_t)a[13*i+ 2]       ) << 3) | (((uint16_t)a[13*i+ 3] & 0x03) << 11);
      r->coeffs[8*i+0] =  a[13*i+ 0]       | (((uint16_t)a[13*i+ 1] & 0x1f) << 8);
  }
  /* Set r[n-1] so that the sum of coefficients is zero mod q */
  r->coeffs[NTRU_N-1] = 0;
  for(i=0;i<NTRU_PACK_DEG;i++)
  {
    r->coeffs[NTRU_N-1] += r->coeffs[i];
  }
  r->coeffs[NTRU_N-1] = MODQ(-(r->coeffs[NTRU_N-1]));
}

void poly_Rq_frommsg(poly *r, const unsigned char *m)
{
  poly b3;
  poly_S3_frombytes(&b3, m);
  poly_S3_to_Rq(r, &b3);
}

void poly_S3_tobytes(unsigned char msg[NTRU_OWCPA_MSGBYTES], const poly *a)
{
  int i,j;
  unsigned char c;
  for(i=0; i<NTRU_PACK_DEG/5; i++)
  {
    c =        a->coeffs[5*i+4] & 255;
    c = (3*c + a->coeffs[5*i+3]) & 255;
    c = (3*c + a->coeffs[5*i+2]) & 255;
    c = (3*c + a->coeffs[5*i+1]) & 255;
    c = (3*c + a->coeffs[5*i+0]) & 255;
    msg[i] = c;
  }
  i = NTRU_PACK_DEG/5;
  c = 0;
  for(j = NTRU_PACK_DEG - (5*i) - 1; j>=0; j--)
    c = (3*c + a->coeffs[5*i+j]) & 255;
  msg[i] = c;
}

void poly_S3_tomsg(unsigned char msg[NTRU_OWCPA_MSGBYTES], const poly *a)
{
  poly_S3_tobytes(msg, a);
}


void poly_S3_frombytes(poly *r, const unsigned char msg[NTRU_OWCPA_MSGBYTES])
{
  int i,j;
  unsigned char c;
  for(i=0; i<NTRU_PACK_DEG/5; i++)
  {
    c = msg[i];
    r->coeffs[5*i+0] = mod3(c);
    r->coeffs[5*i+1] = mod3(c * 171 >> 9);  // this is division by 3
    r->coeffs[5*i+2] = mod3(c * 57 >> 9);  // division by 3^2
    r->coeffs[5*i+3] = mod3(c * 19 >> 9);  // division by 3^3
    r->coeffs[5*i+4] = mod3(c * 203 >> 14);  // etc.
  }
  i = NTRU_PACK_DEG/5;
  c = msg[i];
  for(j=0; (5*i+j)<NTRU_PACK_DEG; j++)
  {
    r->coeffs[5*i+j] = mod3(c);
    c = c * 171 >> 9;
  }
  r->coeffs[NTRU_N-1] = 0;
}

void poly_S3_sample(poly *r, const unsigned char *seed, const unsigned char nonce)
{
  uint32_t buf[(NTRU_N+7)/8];
  unsigned char extseed[NTRU_SEEDBYTES+8];
  int i;

  for(i=0;i<NTRU_SEEDBYTES;i++)
    extseed[i] = seed[i];
  for(i=1;i<8;i++)
    extseed[NTRU_SEEDBYTES+i] = 0;
  extseed[NTRU_SEEDBYTES] = nonce;

  shake128((unsigned char *)buf, sizeof(buf), extseed, sizeof(extseed));

  cbdS3(r, buf);
}

void poly_S3_sample_plus(poly *r, const unsigned char *seed, const unsigned char nonce)
{
  /* Samples r(X) then checks sign of inner product between
   * r(X) and X*r(X). If negative, flips sign of every second
   * coefficient of r(X).
   * Assumes r(X) has coeffs in {0,1,2}.
   * Treats r(X) as {-1,0,1} vector in ZZ^n.
   */
  int i;
  uint16_t c = 0;
  uint16_t s = 0;

  poly_S3_sample(r, seed, nonce);

  for(i=0; i<NTRU_N-1; i++)
  {
    c = r->coeffs[i] * r->coeffs[i+1];
    s += ZP_PROD_TO_UINT16(c);
  }
  /* Map sign of correlation to element of Zp.     */
  s = ((s >> 15) & 1) + 1; /* s = (s >= 0) ? 1 : 2 */

  for(i=0; i<NTRU_N; i+=2)
    r->coeffs[i] = mod3(r->coeffs[i]*s);
}

void poly_Rq_getnoise(poly *r, const unsigned char *seed, const unsigned char nonce)
{
  int i;

  poly_S3_sample(r, seed, nonce);
  for(i=0; i<NTRU_N; i++)
    r->coeffs[i] = ZP_TO_ZQ(r->coeffs[i]);
}

void poly_Rq_mul(poly *r, const poly *a, const poly *b)
{
  int k,i;

  for(k=0; k<NTRU_N; k++)
  {
    r->coeffs[k] = 0;
    for(i=1; i<NTRU_N-k; i++)
      r->coeffs[k] += a->coeffs[k+i] * b->coeffs[NTRU_N-i];
    for(i=0; i<k+1; i++)
      r->coeffs[k] += a->coeffs[k-i] * b->coeffs[i];
    r->coeffs[k] = MODQ(r->coeffs[k]);
  }
}

void poly_S3_mul(poly *r, const poly *a, const poly *b)
{
  int k,i;

  for(k=0; k<NTRU_N; k++)
  {
    r->coeffs[k] = 0;
    for(i=1; i<NTRU_N-k; i++)
      r->coeffs[k] += a->coeffs[k+i] * b->coeffs[NTRU_N-i];
    for(i=0; i<k+1; i++)
      r->coeffs[k] += a->coeffs[k-i] * b->coeffs[i];
  }
  for(k=0; k<NTRU_N; k++)
    r->coeffs[k] = mod3(r->coeffs[k] + 2*r->coeffs[NTRU_N-1]);
}

void poly_Rq_mul_xm1(poly *r, const poly *a)
{
  int i;
  uint16_t last_coeff = a->coeffs[NTRU_N-1];

  for (i = NTRU_N - 1; i > 0; i--) {
    r->coeffs[i] = MODQ(a->coeffs[i-1] + (NTRU_Q - a->coeffs[i]));
  }
  r->coeffs[0] = MODQ(last_coeff + (NTRU_Q - a->coeffs[0]));
}

void poly_S3_to_Rq(poly *r, const poly *a)
{
  /* NOTE: Assumes input is in {0,1,2}^N */
  /*       Produces output in [0,Q-1]^N */
  int i;
  poly b;
  uint16_t t, zj;

  /* Define z by <z*x^i, x-1> = delta_{i,0} mod 3:      */
  /*   t      = -1/N mod p = -N mod 3                   */
  /*   z[0]   = 2 - t mod 3                             */
  /*   z[1]   = 0 mod 3                                 */
  /*   z[j]   = z[j-1] + t mod 3                        */
  /* We'll compute b = a/(x-1) mod (3, Phi) using       */
  /*   b[0] = <z, a>, b[1] = <z*x,a>, b[2] = <z*x^2,a>  */
  /*   b[i] = b[i-3] - (a[i] + a[i-1] + a[i-2])         */
  t = 3 - (NTRU_N % 3);
  b.coeffs[0] = a->coeffs[0] * (2-t) + a->coeffs[1] * 0 + a->coeffs[2] * t;
  b.coeffs[1] = a->coeffs[1] * (2-t) + a->coeffs[2] * 0;
  b.coeffs[2] = a->coeffs[2] * (2-t);

  zj = 0; /* z[1] */
  for(i=3; i<NTRU_N; i++)
  {
    b.coeffs[0] += a->coeffs[i] * (zj + 2*t);
    b.coeffs[1] += a->coeffs[i] * (zj + t);
    b.coeffs[2] += a->coeffs[i] * zj;
    zj = (zj + t) % 3;
  }
  b.coeffs[1] += a->coeffs[0] * (zj + t);
  b.coeffs[2] += a->coeffs[0] * zj;
  b.coeffs[2] += a->coeffs[1] * (zj + t);

  b.coeffs[0] = b.coeffs[0];
  b.coeffs[1] = b.coeffs[1];
  b.coeffs[2] = b.coeffs[2];
  for(i=3; i<NTRU_N; i++)
    b.coeffs[i] =
      b.coeffs[i-3] + 2*(a->coeffs[i] + a->coeffs[i-1] + a->coeffs[i-2]);

  /* Finish reduction mod Phi by subtracting Phi * b[N-1] */
  for(i=0; i<NTRU_N; i++)
    b.coeffs[i] = mod3(b.coeffs[i] + 2*b.coeffs[NTRU_N-1]);

  /* Lift to an element of Z[x]/(q, x^n - 1) */
  for(i=0; i<NTRU_N; i++)
    b.coeffs[i] = ZP_TO_ZQ(b.coeffs[i]);

  /* Multiply by (x-1) */
  poly_Rq_mul_xm1(r, &b);
}

void poly_Rq_to_S3(poly *r, const poly *a)
{
  /* NOTE: Assumes input is in [0,Q-1]^N */
  /*       Produces output in {0,1,2}^N */
  int i;

  /* Center coeffs around 3Q: [0, Q-1] -> [3Q - Q/2, 3Q + Q/2) */
  for(i=0; i<NTRU_N; i++)
  {
    r->coeffs[i] = ((a->coeffs[i] >> (NTRU_LOGQ-1)) ^ 3) << NTRU_LOGQ;
    r->coeffs[i] += a->coeffs[i];
  }
  /* Reduce mod (3, Phi) */
  r->coeffs[NTRU_N-1] = mod3(r->coeffs[NTRU_N-1]);
  for(i=0; i<NTRU_N; i++)
    r->coeffs[i] = mod3(r->coeffs[i] + 2*r->coeffs[NTRU_N-1]);
}

#define POLY_R2_ADD(I,A,B,S)        \
   for(I=0; I<NTRU_N; I++)        \
   { A.coeffs[I] ^= B.coeffs[I] * S;  }

#define POLY_S3_FMADD(I,A,B,S)                    \
   for(I=0; I<NTRU_N; I++)                            \
   { A.coeffs[I] = mod3(A.coeffs[I] + S * B.coeffs[I]); }

static void cswappoly(poly *a, poly *b, int swap)
{
  int i;
  uint16_t t;
  swap = -swap;
  for(i=0;i<NTRU_N;i++)
  {
    t = (a->coeffs[i] ^ b->coeffs[i]) & swap;
    a->coeffs[i] ^= t;
    b->coeffs[i] ^= t;
  }
}

static inline void poly_divx(poly *a, int s)
{
  int i;

  for(i=1; i<NTRU_N; i++)
    a->coeffs[i-1] = (s * a->coeffs[i]) | (!s * a->coeffs[i-1]);
  a->coeffs[NTRU_N-1] = (!s * a->coeffs[NTRU_N-1]);
}

static inline void poly_mulx(poly *a, int s)
{
  int i;

  for(i=1; i<NTRU_N; i++)
    a->coeffs[NTRU_N-i] = (s * a->coeffs[NTRU_N-i-1]) | (!s * a->coeffs[NTRU_N-i]);
  a->coeffs[0] = (!s * a->coeffs[0]);
}

static void poly_R2_inv(poly *r, const poly *a)
{
  /* Schroeppel--Orman--O'Malley--Spatscheck
   * "Almost Inverse" algorithm as described
   * by Siverman in NTRU Tech Report #14 */
  // with several modifications to make it run in constant-time
  int i, j;
  int k = 0;
  int degf = NTRU_N-1;
  int degg = NTRU_N-1;
  int sign, t, swap;
  int done = 0;
  poly b, f, g;
  poly *c = r; // save some stack space

  /* b(X) := 1 */
  for(i=1; i<NTRU_N; i++)
    b.coeffs[i] = 0;
  b.coeffs[0] = 1;

  /* c(X) := 0 */
  for(i=0; i<NTRU_N; i++)
    c->coeffs[i] = 0;

  /* f(X) := a(X) */
  for(i=0; i<NTRU_N; i++)
  {
    f.coeffs[i] = a->coeffs[i] & 1;
    if(f.coeffs[i])
      degf = i;
  }

  /* g(X) := 1 + X + X^2 + ... + X^{N-1} */
  for(i=0; i<NTRU_N; i++)
    g.coeffs[i] = 1;

  for(j=0;j<2*(NTRU_N-1)-1;j++)
  {
    sign = f.coeffs[0];
    swap = sign && !done && (degf < degg);

    cswappoly(&f, &g, swap);
    cswappoly(&b, c, swap);
    t = (degf ^ degg) & (-swap);
    degf ^= t;
    degg ^= t;

    POLY_R2_ADD(i, f, g, sign*(!done));
    POLY_R2_ADD(i, b, (*c), sign*(!done));

    poly_divx(&f, !done);
    poly_mulx(c, !done);
    degf -= !done;
    k += !done;

    done = (degf == 0);
  }

  k = k - NTRU_N*(k >= NTRU_N);
    /* Return X^{N-k} * b(X) */
  for(i=k; i<NTRU_N; i++)
    r->coeffs[i-k] = b.coeffs[i];
  for(i=0; i<k; i++)
    r->coeffs[NTRU_N-k+i] = b.coeffs[i];
}

static void poly_R2_inv_to_Rq_inv(poly *r, const poly *ai, const poly *a)
{
#if NTRU_Q <= 256 || NTRU_Q >= 65536
#error "poly_R2_inv_to_Rq_inv in poly.c assumes 256 < q < 65536"
#endif

  int i;
  poly b, c;
  poly s;

  // for 0..4
  //    ai = ai * (2 - a*ai)  mod q
  for(i=0; i<NTRU_N; i++)
    b.coeffs[i] = MODQ(NTRU_Q - a->coeffs[i]); // b = -a

  for(i=0; i<NTRU_N; i++)
    r->coeffs[i] = ai->coeffs[i];

  poly_Rq_mul(&c, r, &b);
  c.coeffs[0] += 2; // c = 2 - a*ai
  poly_Rq_mul(&s, &c, r); // s = ai*c

  poly_Rq_mul(&c, &s, &b);
  c.coeffs[0] += 2; // c = 2 - a*s
  poly_Rq_mul(r, &c, &s); // r = s*c

  poly_Rq_mul(&c, r, &b);
  c.coeffs[0] += 2; // c = 2 - a*r
  poly_Rq_mul(&s, &c, r); // s = r*c

  poly_Rq_mul(&c, &s, &b);
  c.coeffs[0] += 2; // c = 2 - a*s
  poly_Rq_mul(r, &c, &s); // r = s*c
}

void poly_Rq_inv(poly *r, const poly *a)
{
  poly ai2;
  poly_R2_inv(&ai2, a);
  poly_R2_inv_to_Rq_inv(r, &ai2, a);
}

void poly_S3_inv(poly *r, const poly *a)
{
  /* Schroeppel--Orman--O'Malley--Spatscheck
   * "Almost Inverse" algorithm as described
   * by Siverman in NTRU Tech Report #14 */
  // with several modifications to make it run in constant-time
  int i, j;
  int k = 0;
  int degf = NTRU_N-1;
  int degg = NTRU_N-1;
  int sign, fsign = 0, t, swap;
  int done = 0;
  poly b, c, f, g;

  /* b(X) := 1 */
  for(i=1; i<NTRU_N; i++)
    b.coeffs[i] = 0;
  b.coeffs[0] = 1;

  /* c(X) := 0 */
  for(i=0; i<NTRU_N; i++)
    c.coeffs[i] = 0;

  /* f(X) := a(X) */
  for(i=0; i<NTRU_N; i++)
    f.coeffs[i] = a->coeffs[i];

  /* g(X) := 1 + X + X^2 + ... + X^{N-1} */
  for(i=0; i<NTRU_N; i++)
    g.coeffs[i] = 1;

  for(j=0; j<2*(NTRU_N-1)-1; j++)
  {
    sign = mod3(2 * g.coeffs[0] * f.coeffs[0]);
    swap = sign && !done && (degf < degg);

    cswappoly(&f, &g, swap);
    cswappoly(&b, &c, swap);
    t = (degf ^ degg) & (-swap);
    degf ^= t;
    degg ^= t;

    POLY_S3_FMADD(i, f, g, sign*(!done));
    POLY_S3_FMADD(i, b, c, sign*(!done));

    poly_divx(&f, !done);
    poly_mulx(&c, !done);
    degf -= !done;
    k += !done;

    done = (degf == 0);
  }

  fsign = f.coeffs[0];
  k = k - NTRU_N*(k >= NTRU_N);

  /* Return X^{N-k} * b(X) */
  for(i=k; i<NTRU_N; i++)
    r->coeffs[i-k] = mod3(fsign*b.coeffs[i]);
  for(i=0; i<k; i++)
    r->coeffs[NTRU_N-k+i] = mod3(fsign*b.coeffs[i]);

  /* Reduce modulo Phi_n */
  for(i=0; i<NTRU_N; i++)
    r->coeffs[i] = mod3(r->coeffs[i] + 2*r->coeffs[NTRU_N-1]);
}
