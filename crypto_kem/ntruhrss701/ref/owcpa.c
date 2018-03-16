#include "owcpa.h"
#include "poly.h"
#include "randombytes.h"

#define MODQ(X) ((X) & (NTRU_Q-1))

/* Map {0, 1, 2} -> {0,1,q-1} */
#define ZP_TO_ZQ(C) \
    (((C) & 1) | ((-((C)>>1)) & (NTRU_Q-1)));

static void pack_pk(unsigned char *r, const poly *pk)
{
  poly_Rq_tobytes(r, pk);
}

static void unpack_pk(poly *pk, const unsigned char *packedpk)
{
  poly_Rq_frombytes(pk, packedpk);
}

static void pack_ciphertext(unsigned char *r, const poly *c)
{
  poly_Rq_tobytes(r, c);
}

static void unpack_ciphertext(poly *c, const unsigned char *packedct)
{
  poly_Rq_frombytes(c, packedct);
}

static void pack_sk(unsigned char *r, const poly *f, const poly *finv3)
{
  poly_S3_tobytes(r, f);
  poly_S3_tobytes(r+NTRU_PACK_TRINARY_BYTES, finv3);
}

static void unpack_sk(poly *f, poly *finv3, const unsigned char *packedsk)
{
  int i;
  poly_S3_frombytes(f, packedsk);
  poly_S3_frombytes(finv3, packedsk+NTRU_PACK_TRINARY_BYTES);

  /* Lift coeffs of f from Z_p to Z_q */
  for(i=0; i<NTRU_N; i++)
    f->coeffs[i] = (f->coeffs[i] & 1) | ((-(f->coeffs[i]>>1)) & (NTRU_Q-1));
}

void owcpa_samplemsg(unsigned char msg[NTRU_OWCPA_MSGBYTES], unsigned char seed[NTRU_SEEDBYTES])
{
  poly m;
  poly_S3_sample(&m,seed,0);
  poly_S3_tobytes(msg, &m);
}

void owcpa_keypair(unsigned char *pk,
                   unsigned char *sk)
{
  int i;
  unsigned char seed[NTRU_SEEDBYTES];
  poly p1, p2, p3; // for somewhat more efficient stack usage
  poly *f = &p1, *fi3 = &p2, *fiq = &p1, *g = &p2, *h = &p3, *r1 = &p3;

  randombytes(seed, NTRU_SEEDBYTES);

  poly_S3_sample_plus(f,seed,1);

  poly_S3_inv(fi3, f);

  /* Pack sk before constructing pk */
  pack_sk(sk, f, fi3);

  /* Lift coeffs of f and g from Z_p to Z_q */
  for(i=0; i<NTRU_N; i++)
    f->coeffs[i] = ZP_TO_ZQ(f->coeffs[i]);

  poly_S3_sample_plus(g,seed,2);
  for(i=0; i<NTRU_N; i++)
    g->coeffs[i] = ZP_TO_ZQ(g->coeffs[i]);

  poly_Rq_inv(fiq, f);
  poly_Rq_mul(r1, g, fiq);
  poly_Rq_mul_xm1(h, r1);
  for(i=0; i<NTRU_N; i++)
    h->coeffs[i] = MODQ(3 * h->coeffs[i]);

  pack_pk(pk, h);
}


void owcpa_enc(unsigned char *c,
               const unsigned char *m,
               const unsigned char *pk,
               const unsigned char *coins)
{
  int i;
  poly h, b, r, ct;

  unpack_pk(&h, pk);

  poly_Rq_getnoise(&r, coins, 0);
  poly_Rq_mul(&ct, &r, &h);
  poly_Rq_frommsg(&b, m);
  for(i=0; i<NTRU_N; i++)
    ct.coeffs[i] = MODQ(ct.coeffs[i] + b.coeffs[i]);

  pack_ciphertext(c, &ct);
}


void owcpa_dec(unsigned char *m,
               const unsigned char *c,
               const unsigned char *sk)
{
  poly ct, f, finv3, r1, r2;

  unpack_ciphertext(&ct, c);
  unpack_sk(&f, &finv3, sk);

  poly_Rq_mul(&r1, &ct, &f);
  poly_Rq_to_S3(&r2, &r1);
  poly_S3_mul(&r1, &r2, &finv3);

  poly_S3_tomsg(m, &r1);
}
