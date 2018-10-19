/******************************************************************************
 * NTRU Cryptography Reference Source Code submitting to NIST call for
 * proposals for post quantum cryptography
 *
 * This code is written by Zhenfei Zhang @ OnboardSecurity, with additional
 * codes from public domain.
 *
 ******************************************************************************/
/*
 * poly_algo.c
 *
 *  Created on: Aug 16, 2017
 *      Author: zhenfei
 */
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include "param.h"
#include "poly.h"
#include "randombytes.h"
#include "crypto_hash_sha512.h"

#define PAD(N) ((N + 0x000f) & 0xfff0)

extern void polymul_asm(uint16_t *r, const uint16_t *a, const uint16_t *b);

/* ntru_ring_mult_coefficients
 *
 * Multiplies ring element (polynomial) "a" by ring element (polynomial) "b"
 * to produce ring element (polynomial) "c" in (Z/qZ)[X]/(X^N - 1).
 * This is a convolution operation.
 *
 * This assumes q is 2^r where 8 < r < 16, so that overflow of the sum
 * beyond 16 bits does not matter.
 */

void
ntru_ring_mult_coefficients(
    uint16_t const *a,          /*  in - pointer to polynomial a */
    uint16_t const *b,          /*  in - pointer to polynomial b */
    PARAM_SET const*param,
    uint16_t       *tmp,        /*  in - temp buffer of 2*padN elements */
    uint16_t       *c)          /* out - address for polynomial c */
{
    uint16_t i;
    uint16_t q_mask = param->q-1;

    polymul_asm(tmp, a, b);

    for(i=0; i<param->N-1; i++)
    {
        c[i] = (tmp[i] + tmp[i+param->N]) & q_mask;
    }
    c[param->N-1] = (tmp[param->N-1]) &q_mask;
    for(i=param->N; i<param->padN; i++)
    {
        c[i] = 0;
    }
//    memset(tmp, 0, sizeof(uint16_t)*param->padN*3);
    return;
}

/* ntru_ring_lift_inv_pow2_standard
 *
 * Lifts an element of (Z/2)[x]/(x^N - 1) to (Z/q)[x]/(x^N - 1)
 * where q is a power of 2 such that 256 < q <= 65536.
 *
 * inv must be padded with zeros to the degree used by
 * ntru_ring_mult_coefficients.
 *
 * inv is assumed to be the inverse mod 2 of the trinary element f.
 * The lift is performed in place -- inv will be overwritten with the result.
 *
 * Requires scratch space for ntru_ring_mult_coefficients + one extra
 * polynomial with the same padding.
 */
uint32_t
ring_lift_inv_pow2(
    uint16_t       *inv,
    uint16_t const *f,
PARAM_SET const *param,
    uint16_t       *t)
{
    uint16_t i;
    uint16_t j;

    for (j = 0; j < 4; ++j)   /* assumes 256 < q <= 65536 */
    {
        /* f^-1 = f^-1 * (2 - f * f^-1) mod q */
        ntru_ring_mult_coefficients(f, inv, param, t, t);
        for (i = 0; i < param->N; ++i)
        {
            t[i] = -t[i];
        }
        t[0] = t[0] + 2;
        ntru_ring_mult_coefficients(inv, t,param, t+param->padN, inv);
    }
    return 0;
}




/* ntru_ring_inv
 *
 * Finds the inverse of a polynomial, a, in (Z/2Z)[X]/(X^N - 1).
  */

int
ntru_ring_inv(
    uint16_t       *a,          /*  in - pointer to polynomial a */
    uint16_t        N,          /*  in - no. of coefficients in a */
    uint16_t       *t,          /*  in - temp buffer of 2N elements */
    uint16_t       *a_inv)      /* out - address for polynomial a^-1 */
{
    uint8_t  *b = (uint8_t *)t;     /* b cannot be in a_inv since it must be
                                       rotated and copied there as a^-1 mod 2 */
    uint8_t  *c = b + N;            /* c cannot be in a_inv since it exchanges
                                       with b, and b cannot be in a_inv */
    uint8_t  *f = c + N;
    uint8_t  *g = (uint8_t *)a_inv; /* g needs N + 1 bytes */
    uint16_t  deg_b;
    uint16_t  deg_c;
    uint16_t  deg_f;
    uint16_t  deg_g;
    uint16_t  k = 0;
    uint16_t  i, j;

    if (a == NULL || t == NULL || a_inv == NULL)
    {
        return -1;
    }

    /* form a^-1 in (Z/2Z)[X]/(X^N - 1) */

    memset(b, 0, (N << 1));         /* clear to init b, c */

    /* b(X) = 1 */

    b[0] = 1;
    deg_b = 0;

    /* c(X) = 0 (cleared above) */

    deg_c = 0;

    /* f(X) = a(X) mod 2 */

    deg_f = 0;
    j = 0;
    for (i = 0; i < N; i++)
    {
        f[i] = (uint8_t)(a[i] & 1);
        j ^= f[i];
        if(f[i]) deg_f = i;
    }

    /* Parity is zero, not invertible */
    if(j == 0)
    {
      return -1;
    }

    /* g(X) = X^N - 1 */

    g[0] = 1;
    memset(g + 1, 0, N - 1);
    g[N] = 1;
    deg_g = N;

    /* until f(X) = 1 */

    while (1)
    {
        /* while f[0] = 0, f(X) /= X, c(X) *= X, k++ */

        for (i = 0; (i <= deg_f) && (f[i] == 0); ++i);
        if (i > deg_f)
            return -1;
        if (i) {
            k = k + i;

            f = f + i;
            deg_f = deg_f - i;

            memmove(c+i, c, deg_c+1);
            memset(c, 0, i);
            deg_c = deg_c + i;
        }

        /* if f(X) = 1, done */

        if (deg_f == 0)
        {
            break;
        }

        /* if deg_f < deg_g, f <-> g, b <-> c */

        if (deg_f < deg_g)
        {
            uint8_t *x;

            x = f;
            f = g;
            g = x;
            deg_f ^= deg_g;
            deg_g ^= deg_f;
            deg_f ^= deg_g;
            x = b;
            b = c;
            c = x;
            deg_b ^= deg_c;
            deg_c ^= deg_b;
            deg_b ^= deg_c;
        }

        /* f(X) += g(X)
         * might change degree of f if deg_g >= deg_f
         */
        for (i=0; i<=deg_g; i++)
        {
            f[i] ^= g[i];
        }

        if(deg_g == deg_f)
        {
            while(deg_f > 0 && f[deg_f] == 0)
            {
                --deg_f;
            }
        }

        /* b(X) += c(X) */
        for (i=0; i<=deg_c; i++)
        {
            b[i] ^= c[i];
        }

        if (deg_c >= deg_b)
        {
            deg_b = deg_c;
            while(deg_b > 0 && b[deg_b] == 0)
            {
                --deg_b;
            }
        }
    }

    /* a^-1 in (Z/2Z)[X]/(X^N - 1) = b(X) shifted left k coefficients */

    j = 0;

    if (k >= N)
    {
        k = k - N;
    }

    for (i = k; i < N; i++)
    {
        a_inv[j++] = (uint16_t)(b[i]);
    }

    for (i = 0; i < k; i++)
    {
        a_inv[j++] = (uint16_t)(b[i]);
    }

    return 0;
}



/* generate a random binary polynomial with degree less than N */

void
binary_poly_gen(
          uint64_t  *f,
    const uint16_t  N)
{
    uint16_t r;
    uint64_t i,j,index;
    for (i=0;i<=N/16;i++)
    {
        randombytes((unsigned char *)&r, sizeof(uint16_t));
        for (j=0;j<16;j++)
        {
            index = i*16+j;
            if (index<N)
                f[index] = (r & ( 1 << j)) >> j;
        }
    }
}




/* generate a trinary polynomial with fixed number of +/- 1s */
void
trinary_poly_gen(
          uint16_t  *f,
    const uint16_t  N,
    const uint16_t  d)
{
    uint64_t r;
    int16_t count,i, coeff[6];

    memset(f, 0, sizeof(uint16_t)*N);
    count = 0;
    while(count < d)
    {
        randombytes((unsigned char *)&r, sizeof(uint64_t));
        for (i =0;i<6;i++)
        {
            if (count<d)
            {
              coeff[i] = r & 0x3FF;
              r = (r - coeff[i])>>10;
              if (coeff[i]<N)
              {
                  if (f[coeff[i]]==0)
                  {
                      f[coeff[i]]=1;
                      count++;
                  }
              }
            }
        }
    }
    count = 0;
    while(count < d)
    {
        randombytes((unsigned char *)&r, sizeof(uint64_t));
        for (i =0;i<6;i++)
        {
            if (count<d)
            {
              coeff[i] = r & 0x3FF;
              r = (r - coeff[i])>>10;
              if (coeff[i]<N)
              {
                  if (f[coeff[i]]==0)
                  {
                      f[coeff[i]]=-1;
                      count++;
                  }
              }
            }
        }
    }
    return;
}


/* deterministically generate a trinary polynomial with fixed number of +/- 1s
 * using seed*/
void
trinary_poly_gen_w_seed(
          uint16_t  *f,
    const uint16_t  N,
    const uint16_t  d,
    unsigned char   *seed,
    const size_t    seed_len)
{
    uint64_t r;
    int16_t count,i, coeff[6];
    int16_t j=0;
    uint64_t *seed_ptr;
    memset(f, 0, sizeof(uint16_t)*N);

    seed_ptr = (uint64_t*) seed;

    crypto_hash_sha512(seed, seed, seed_len);



    count = 0;
    while(count < d+1)
    {
        r = seed_ptr[j];
        j++;
        if(j==8)
        {
            crypto_hash_sha512(seed, seed, LENGTH_OF_HASH);
            j = 0;
        }
        for (i =0;i<6;i++)
        {
            coeff[i] = r & 0x3FF;
            r = (r - coeff[i])>>10;
            if (coeff[i]<N)
            {
                if (f[coeff[i]]==0)
                {
                    f[coeff[i]]=1;
                    count++;
                }
            }
        }
    }
    count = 0;
    while(count < d)
    {
        r = seed_ptr[j];
        j++;
        if(j==8)
        {
            crypto_hash_sha512(seed, seed, LENGTH_OF_HASH);
            j = 0;
        }
        for (i =0;i<6;i++)
        {
            coeff[i] = r & 0x3FF;
            r = (r - coeff[i])>>10;
            if (coeff[i]<N)
            {
                if (f[coeff[i]]==0)
                {
                    f[coeff[i]]=-1;
                    count++;
                }
            }
        }
    }

    return;
}


void
rand_tri_poly_from_seed(
          uint16_t   *v,
    const int16_t    N,
    unsigned char    *seed,
    const size_t     seed_len)
{
  int16_t i, j, k;
  uint8_t tmp;

  i = 0;
  j = 0;

  crypto_hash_sha512(seed, seed, seed_len);

  while (i<N)
  {
      tmp = (uint8_t)seed[j++];
      if(j==64)
      {
          crypto_hash_sha512(seed, seed, seed_len);
          j=0;
      }
      for (k=0;k<4;k++)
      {
          if ((tmp & 0b11)!=3)
          {
              v[i++] = (tmp & 0b11) - 1;
          }
          tmp >>= 2;
      }
  }
  return;
}
