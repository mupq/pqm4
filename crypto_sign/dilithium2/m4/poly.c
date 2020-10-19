#include "ntt.h"
#include "params.h"
#include "poly.h"
#include "reduce.h"
#include "rounding.h"
#include "symmetric.h"
#include <stdint.h>

/*************************************************
* Name:        poly_reduce
*
* Description: Reduce all coefficients of input polynomial to representative
*              in ]-Q,Q[.
*
* Arguments:   - poly *a: pointer to input/output polynomial
**************************************************/
void poly_reduce(poly *a) {
    poly_reduce_asm(a->coeffs);
}


/*************************************************
* Name:        poly_csubq
*
* Description: For all coefficients of input polynomial subtract Q if
*              coefficient is bigger than Q; add Q if coefficient is negative.
*
* Arguments:   - poly *a: pointer to input/output polynomial
**************************************************/
void poly_csubq(poly *a) {
    poly_csubq_asm(a->coeffs);
}

/*************************************************
* Name:        poly_freeze
*
* Description: Reduce all coefficients of the polynomial to standard
*              representatives.
*
* Arguments:   - poly *a: pointer to input/output polynomial
**************************************************/
void poly_freeze(poly *a) {
    poly_freeze_asm(a->coeffs);
}

/*************************************************
* Name:        poly_add
*
* Description: Add polynomials. No modular reduction is performed.
*
* Arguments:   - poly *c: pointer to output polynomial
*              - const poly *a: pointer to first summand
*              - const poly *b: pointer to second summand
**************************************************/
void poly_add(poly *c, const poly *a, const poly *b)  {
  unsigned int i;

  for(i = 0; i < N; i=i+8)
  {
    c->coeffs[i] = a->coeffs[i] + b->coeffs[i];
    c->coeffs[i+1] = a->coeffs[i+1] + b->coeffs[i+1];
    c->coeffs[i+2] = a->coeffs[i+2] + b->coeffs[i+2];
    c->coeffs[i+3] = a->coeffs[i+3] + b->coeffs[i+3];
    c->coeffs[i+4] = a->coeffs[i+4] + b->coeffs[i+4];
    c->coeffs[i+5] = a->coeffs[i+5] + b->coeffs[i+5];
    c->coeffs[i+6] = a->coeffs[i+6] + b->coeffs[i+6];
    c->coeffs[i+7] = a->coeffs[i+7] + b->coeffs[i+7];
  }

}

/*************************************************
* Name:        poly_sub
*
* Description: Subtract polynomials. Assumes coefficients of second input
*              polynomial to be less than 2*Q. No modular reduction is
*              performed.
*
* Arguments:   - poly *c: pointer to output polynomial
*              - const poly *a: pointer to first input polynomial
*              - const poly *b: pointer to second input polynomial to be
*                               subtraced from first input polynomial
**************************************************/
void poly_sub(poly *c, const poly *a, const poly *b) {
  unsigned int i;

  for(i = 0; i < N; i=i+8)
  {
    c->coeffs[i] = a->coeffs[i]     - b->coeffs[i];
    c->coeffs[i+1] = a->coeffs[i+1] - b->coeffs[i+1];
    c->coeffs[i+2] = a->coeffs[i+2] - b->coeffs[i+2];
    c->coeffs[i+3] = a->coeffs[i+3] - b->coeffs[i+3];
    c->coeffs[i+4] = a->coeffs[i+4] - b->coeffs[i+4];
    c->coeffs[i+5] = a->coeffs[i+5] - b->coeffs[i+5];
    c->coeffs[i+6] = a->coeffs[i+6] - b->coeffs[i+6];
    c->coeffs[i+7] = a->coeffs[i+7] - b->coeffs[i+7];
  }

}


/*************************************************
* Name:        poly_shiftl
*
* Description: Multiply polynomial by 2^D without modular reduction. Assumes
*              input coefficients to be less than 2^{32-D}.
*
* Arguments:   - poly *a: pointer to input/output polynomial
**************************************************/
void poly_shiftl(poly *a) {
  unsigned int i;

  for(i = 0; i < N; i=i+8)
  {
    a->coeffs[i] <<= D;
    a->coeffs[i+1] <<= D;
    a->coeffs[i+2] <<= D;
    a->coeffs[i+3] <<= D;
    a->coeffs[i+4] <<= D;
    a->coeffs[i+5] <<= D;
    a->coeffs[i+6] <<= D;
    a->coeffs[i+7] <<= D;
  }

}

/*************************************************
* Name:        poly_ntt
*
* Description: Forward NTT. Output coefficients can be up to 16*Q larger than
*              input coefficients.
*
* Arguments:   - poly *a: pointer to input/output polynomial
**************************************************/
void poly_ntt(poly *a) {
    #if PLATFORM == CORTEX_M4
    ntt_asm_smull(a->coeffs, zetas_interleaved_asm);
    #else
    ntt_asm_schoolbook(a->coeffs, zetas_asm);
    #endif
}


/*************************************************
* Name:        poly_ntt_leaktime
*
* Description: Forward NTT. Output coefficients can be up to 16*Q larger than
*              input coefficients.
*              Inputs need to be public, so that the implementation can use non-constant time instructions.
*
* Arguments:   - poly *a: pointer to input/output polynomial
**************************************************/
void poly_ntt_leaktime(poly *a) {
    ntt_asm_smull(a->coeffs, zetas_interleaved_asm);
}

/*************************************************
* Name:        poly_invntt_tomont
*
* Description: Inverse NTT and multiplication with 2^{32}. Input coefficients
*              need to be less than 2*Q. Output coefficients are less than 2*Q.
*
* Arguments:   - poly *a: pointer to input/output polynomial
**************************************************/
void poly_invntt_tomont(poly *a) {
    #if PLATFORM == CORTEX_M4
    inv_ntt_asm_smull(a->coeffs, zetas_interleaved_inv_asm);
    #else
    inv_ntt_asm_schoolbook(a->coeffs, zetas_inv_asm);
    #endif
}

/*************************************************
* Name:        poly_invntt_tomont_leaktime
*
* Description: Inverse NTT and multiplication with 2^{32}. Input coefficients
*              need to be less than 2*Q. Output coefficients are less than 2*Q.
*              Inputs need to be public, so that the implementation can use non-constant time instructions.
*
* Arguments:   - poly *a: pointer to input/output polynomial
**************************************************/
void poly_invntt_tomont_leaktime(poly *a) {
    inv_ntt_asm_smull(a->coeffs, zetas_interleaved_inv_asm);
}


/*************************************************
* Name:        poly_pointwise_montgomery
*
* Description: Pointwise multiplication of polynomials in NTT domain
*              representation and multiplication of resulting polynomial
*              with 2^{-32}. Output coefficients are less than 2*Q if input
*              coefficient are less than 22*Q.
*
* Arguments:   - poly *c: pointer to output polynomial
*              - const poly *a: pointer to first input polynomial
*              - const poly *b: pointer to second input polynomial
**************************************************/
void poly_pointwise_montgomery(poly *c, const poly *a, const poly *b)
{
  #if PLATFORM == CORTEX_M4
  poly_pointwise_invmontgomery_asm_smull(c->coeffs, a->coeffs, b->coeffs);
  #else
  poly_pointwise_invmontgomery_asm_mul(c->coeffs, a->coeffs, b->coeffs);
  #endif
}

void poly_pointwise_acc_montgomery(poly *c, const poly *a, const poly *b)
{
  #if PLATFORM == CORTEX_M4
  poly_pointwise_acc_invmontgomery_asm_smull(c->coeffs, a->coeffs, b->coeffs);
  #else
  poly_pointwise_acc_invmontgomery_asm_mul(c->coeffs, a->coeffs, b->coeffs);
  #endif
}


/*************************************************
* Name:        poly_pointwise_invmontgomery_leaktime
*
* Description: Pointwise multiplication of polynomials in NTT domain
*              representation and multiplication of resulting polynomial
*              with 2^{-32}. Output coefficients are less than 2*Q if input
*              coefficient are less than 22*Q.
*              Inputs must be public. 
*
* Arguments:   - poly *c: pointer to output polynomial
*              - const poly *a: pointer to first input polynomial
*              - const poly *b: pointer to second input polynomial
**************************************************/
void poly_pointwise_montgomery_leaktime(poly *c, const poly *a, const poly *b)
{
  #if PLATFORM == CORTEX_M4
  poly_pointwise_invmontgomery_asm_smull(c->coeffs, a->coeffs, b->coeffs);
  #else
  poly_pointwise_invmontgomery_asm_smull(c->coeffs, a->coeffs, b->coeffs);
  #endif
}
void poly_pointwise_acc_montgomery_leaktime(poly *c, const poly *a, const poly *b)
{
  #if PLATFORM == CORTEX_M4
  poly_pointwise_acc_invmontgomery_asm_smull(c->coeffs, a->coeffs, b->coeffs);
  #else
  poly_pointwise_acc_invmontgomery_asm_smull(c->coeffs, a->coeffs, b->coeffs);
  #endif
}

/*************************************************
* Name:        poly_power2round
*
* Description: For all coefficients c of the input polynomial,
*              compute c0, c1 such that c mod Q = c1*2^D + c0
*              with -2^{D-1} < c0 <= 2^{D-1}. Assumes coefficients to be
*              standard representatives.
*
* Arguments:   - poly *a1: pointer to output polynomial with coefficients c1
*              - poly *a0: pointer to output polynomial with coefficients Q + a0
*              - const poly *v: pointer to input polynomial
**************************************************/
void poly_power2round(poly *a1, poly *a0, const poly *a) {
  unsigned int i;
  int32_t t;

  for(i = 0; i < N; i=i+8)
  {
    // a1->coeffs[i] = power2round(a->coeffs[i], &a0->coeffs[i]);
    /* Centralized remainder mod 2^D */
    t = a->coeffs[i] & ((1U << D) - 1);
    t -= (1U << (D-1)) + 1;
    t += (t >> 31) & (1U << D);
    t -= (1U << (D-1)) - 1;
    a0->coeffs[i] = Q + t;
    a1->coeffs[i] = (a->coeffs[i] - t) >> D;

    t = a->coeffs[i+1] & ((1U << D) - 1);
    t -= (1U << (D-1)) + 1;
    t += (t >> 31) & (1U << D);
    t -= (1U << (D-1)) - 1;
    a0->coeffs[i+1] = Q + t;
    a1->coeffs[i+1] = (a->coeffs[i+1] - t) >> D;

    t = a->coeffs[i+2] & ((1U << D) - 1);
    t -= (1U << (D-1)) + 1;
    t += (t >> 31) & (1U << D);
    t -= (1U << (D-1)) - 1;
    a0->coeffs[i+2] = Q + t;
    a1->coeffs[i+2] = (a->coeffs[i+2] - t) >> D;

    t = a->coeffs[i+3] & ((1U << D) - 1);
    t -= (1U << (D-1)) + 1;
    t += (t >> 31) & (1U << D);
    t -= (1U << (D-1)) - 1;
    a0->coeffs[i+3] = Q + t;
    a1->coeffs[i+3] = (a->coeffs[i+3] - t) >> D;

    t = a->coeffs[i+4] & ((1U << D) - 1);
    t -= (1U << (D-1)) + 1;
    t += (t >> 31) & (1U << D);
    t -= (1U << (D-1)) - 1;
    a0->coeffs[i+4] = Q + t;
    a1->coeffs[i+4] = (a->coeffs[i+4] - t) >> D;

    t = a->coeffs[i+5] & ((1U << D) - 1);
    t -= (1U << (D-1)) + 1;
    t += (t >> 31) & (1U << D);
    t -= (1U << (D-1)) - 1;
    a0->coeffs[i+5] = Q + t;
    a1->coeffs[i+5] = (a->coeffs[i+5] - t) >> D;

    t = a->coeffs[i+6] & ((1U << D) - 1);
    t -= (1U << (D-1)) + 1;
    t += (t >> 31) & (1U << D);
    t -= (1U << (D-1)) - 1;
    a0->coeffs[i+6] = Q + t;
    a1->coeffs[i+6] = (a->coeffs[i+6] - t) >> D;

    t = a->coeffs[i+7] & ((1U << D) - 1);
    t -= (1U << (D-1)) + 1;
    t += (t >> 31) & (1U << D);
    t -= (1U << (D-1)) - 1;
    a0->coeffs[i+7] = Q + t;
    a1->coeffs[i+7] = (a->coeffs[i+7] - t) >> D;

  }
}

/*************************************************
* Name:        poly_decompose
*
* Description: For all coefficients c of the input polynomial,
*              compute high and low bits c0, c1 such c mod Q = c1*ALPHA + c0
*              with -ALPHA/2 < c0 <= ALPHA/2 except c1 = (Q-1)/ALPHA where we
*              set c1 = 0 and -ALPHA/2 <= c0 = c mod Q - Q < 0.
*              Assumes coefficients to be standard representatives.
*
* Arguments:   - poly *a1: pointer to output polynomial with coefficients c1
*              - poly *a0: pointer to output polynomial with coefficients Q + a0
*              - const poly *c: pointer to input polynomial
**************************************************/
void poly_decompose(wpacked *a1, poly *a0, const poly *a) {
  unsigned int i;
  int32_t t, u;
  uint32_t temp;

  #if ALPHA != (Q-1)/16
  #error "decompose assumes ALPHA == (Q-1)/16"
  #endif

  for(i = 0; i < N; i=i+8)
  {
      // /* Centralized remainder mod ALPHA */
      temp = a->coeffs[i];
      t = temp & 0x7FFFF;
      t += (temp >> 19) << 9;
      t -= ALPHA/2 + 1;
      t += (t >> 31) & ALPHA;
      t -= ALPHA/2 - 1;
      temp -= t;

      /* Divide by ALPHA (possible to avoid) */
      u = temp - 1;
      u >>= 31;
      temp = (temp >> 19) + 1;
      temp -= u & 1;

      a0->coeffs[i] = Q + t - (temp >> 4);
      a1->packedcoeffs[i >> 1] = (uint8_t)(temp & 0xF);

      // /* Centralized remainder mod ALPHA */
      temp = a->coeffs[i+1];
      t = temp & 0x7FFFF;
      t += (temp >> 19) << 9;
      t -= ALPHA/2 + 1;
      t += (t >> 31) & ALPHA;
      t -= ALPHA/2 - 1;
      temp -= t;

      /* Divide by ALPHA (possible to avoid) */
      u = temp - 1;
      u >>= 31;
      temp = (temp >> 19) + 1;
      temp -= u & 1;

      a0->coeffs[i+1] = Q + t - (temp >> 4);
      a1->packedcoeffs[i >> 1] |= (uint8_t)((temp & 0xF) << 4);

      // /* Centralized remainder mod ALPHA */
      temp = a->coeffs[i+2];
      t = temp & 0x7FFFF;
      t += (temp >> 19) << 9;
      t -= ALPHA/2 + 1;
      t += (t >> 31) & ALPHA;
      t -= ALPHA/2 - 1;
      temp -= t;

      /* Divide by ALPHA (possible to avoid) */
      u = temp - 1;
      u >>= 31;
      temp = (temp >> 19) + 1;
      temp -= u & 1;

      a0->coeffs[i+2] = Q + t - (temp >> 4);
      a1->packedcoeffs[(i >> 1) + 1] = (uint8_t)(temp & 0xF);

      // /* Centralized remainder mod ALPHA */
      temp = a->coeffs[i+3];
      t = temp & 0x7FFFF;
      t += (temp >> 19) << 9;
      t -= ALPHA/2 + 1;
      t += (t >> 31) & ALPHA;
      t -= ALPHA/2 - 1;
      temp -= t;

      /* Divide by ALPHA (possible to avoid) */
      u = temp - 1;
      u >>= 31;
      temp = (temp >> 19) + 1;
      temp -= u & 1;

      a0->coeffs[i+3] = Q + t - (temp >> 4);
      a1->packedcoeffs[(i >> 1) + 1] |= (uint8_t)((temp & 0xF) << 4);

      // /* Centralized remainder mod ALPHA */
      temp = a->coeffs[i+4];
      t = temp & 0x7FFFF;
      t += (temp >> 19) << 9;
      t -= ALPHA/2 + 1;
      t += (t >> 31) & ALPHA;
      t -= ALPHA/2 - 1;
      temp -= t;

      /* Divide by ALPHA (possible to avoid) */
      u = temp - 1;
      u >>= 31;
      temp = (temp >> 19) + 1;
      temp -= u & 1;

      a0->coeffs[i+4] = Q + t - (temp >> 4);
      a1->packedcoeffs[(i >> 1) + 2] = (uint8_t)(temp & 0xF);

      // /* Centralized remainder mod ALPHA */
      temp = a->coeffs[i+5];
      t = temp & 0x7FFFF;
      t += (temp >> 19) << 9;
      t -= ALPHA/2 + 1;
      t += (t >> 31) & ALPHA;
      t -= ALPHA/2 - 1;
      temp -= t;

      /* Divide by ALPHA (possible to avoid) */
      u = temp - 1;
      u >>= 31;
      temp = (temp >> 19) + 1;
      temp -= u & 1;

      a0->coeffs[i+5] = Q + t - (temp >> 4);
      a1->packedcoeffs[(i >> 1) + 2]  |= (uint8_t)((temp & 0xF) << 4);

      // /* Centralized remainder mod ALPHA */
      temp = a->coeffs[i+6];
      t = temp & 0x7FFFF;
      t += (temp >> 19) << 9;
      t -= ALPHA/2 + 1;
      t += (t >> 31) & ALPHA;
      t -= ALPHA/2 - 1;
      temp -= t;

      /* Divide by ALPHA (possible to avoid) */
      u = temp - 1;
      u >>= 31;
      temp = (temp >> 19) + 1;
      temp -= u & 1;

      a0->coeffs[i+6] = Q + t - (temp >> 4);
      a1->packedcoeffs[(i >> 1) + 3] = (uint8_t)(temp & 0xF);

      // /* Centralized remainder mod ALPHA */
      temp = a->coeffs[i+7];
      t = temp & 0x7FFFF;
      t += (temp >> 19) << 9;
      t -= ALPHA/2 + 1;
      t += (t >> 31) & ALPHA;
      t -= ALPHA/2 - 1;
      temp -= t;

      /* Divide by ALPHA (possible to avoid) */
      u = temp - 1;
      u >>= 31;
      temp = (temp >> 19) + 1;
      temp -= u & 1;

      a0->coeffs[i+7] = Q + t - (temp >> 4);
      a1->packedcoeffs[(i >> 1) + 3] |= (uint8_t)((temp & 0xF) << 4);
  }

}

static uint8_t lo_nibble(const uint8_t x) {
  return x & 0xF;
}

static uint8_t hi_nibble(const uint8_t x) {
  return x >> 4;
}

/*************************************************
* Name:        poly_make_hint
*
* Description: Compute hint polynomial. The coefficients of which indicate
*              whether the low bits of the corresponding coefficient of
*              the input polynomial overflow into the high bits.
*
* Arguments:   - poly *h: pointer to output hint polynomial
*              - const poly *a0: pointer to low part of input polynomial
*              - const poly *a1: pointer to high part of input polynomial
*
* Returns number of 1 bits.
**************************************************/
unsigned int poly_make_hint(poly *h, const poly *a0, const wpacked *a1)
{
  unsigned int i, s = 0;

for(i = 0; i < N; i=i+8)
{
    if (a0->coeffs[i] <= GAMMA2 || a0->coeffs[i] > Q - GAMMA2 || (a0->coeffs[i] == Q - GAMMA2 && lo_nibble(a1->packedcoeffs[i >> 1]) == 0))
    {
        h->coeffs[i] = 0;
    }
    else
    {
        h->coeffs[i] = 1;
        s += h->coeffs[i];
    }

    if (a0->coeffs[i+1] <= GAMMA2 || a0->coeffs[i+1] > Q - GAMMA2 || (a0->coeffs[i+1] == Q - GAMMA2 && hi_nibble(a1->packedcoeffs[(i+1) >> 1]) == 0))
    {
        h->coeffs[i+1] = 0;
    }
    else
    {
        h->coeffs[i+1] = 1;
        s += h->coeffs[i+1];
    }

    if (a0->coeffs[i+2] <= GAMMA2 || a0->coeffs[i+2] > Q - GAMMA2 || (a0->coeffs[i+2] == Q - GAMMA2 && lo_nibble(a1->packedcoeffs[(i+2) >> 1]) == 0))
    {
        h->coeffs[i+2] = 0;
    }
    else
    {
        h->coeffs[i+2] = 1;
        s += h->coeffs[i+2];
    }

    if (a0->coeffs[i+3] <= GAMMA2 || a0->coeffs[i+3] > Q - GAMMA2 || (a0->coeffs[i+3] == Q - GAMMA2 && hi_nibble(a1->packedcoeffs[(i+3) >> 1]) == 0))
    {
        h->coeffs[i+3] = 0;
    }
    else
    {
        h->coeffs[i+3] = 1;
        s += h->coeffs[i+3];
    }

    if (a0->coeffs[i+4] <= GAMMA2 || a0->coeffs[i+4] > Q - GAMMA2 || (a0->coeffs[i+4] == Q - GAMMA2 && lo_nibble(a1->packedcoeffs[(i >> 1) + 2]) == 0))
    {
        h->coeffs[i+4] = 0;
    }
    else
    {
        h->coeffs[i+4] = 1;
        s += h->coeffs[i+4];
    }

    if (a0->coeffs[i+5] <= GAMMA2 || a0->coeffs[i+5] > Q - GAMMA2 || (a0->coeffs[i+5] == Q - GAMMA2 && hi_nibble(a1->packedcoeffs[(i >> 1) + 2]) == 0))
    {
        h->coeffs[i+5] = 0;
    }
    else
    {
        h->coeffs[i+5] = 1;
        s += h->coeffs[i+5];
    }

    if (a0->coeffs[i+6] <= GAMMA2 || a0->coeffs[i+6] > Q - GAMMA2 || (a0->coeffs[i+6] == Q - GAMMA2 && lo_nibble(a1->packedcoeffs[(i >> 1) + 3]) == 0))
    {
        h->coeffs[i+6] = 0;
    }
    else
    {
        h->coeffs[i+6] = 1;
        s += h->coeffs[i+6];
    }

    if (a0->coeffs[i+7] <= GAMMA2 || a0->coeffs[i+7] > Q - GAMMA2 || (a0->coeffs[i+7] == Q - GAMMA2 && hi_nibble(a1->packedcoeffs[(i >> 1) + 3]) == 0))
    {
        h->coeffs[i+7] = 0;
    }
    else
    {
        h->coeffs[i+7] = 1;
        s += h->coeffs[i+7];
    }
}
  return s;
}

/*************************************************
* Name:        poly_use_hint
*
* Description: Use hint polynomial to correct the high bits of a polynomial.
*
* Arguments:   - poly *a: pointer to output polynomial with corrected high bits
*              - const poly *b: pointer to input polynomial
*              - const poly *h: pointer to input hint polynomial
**************************************************/
void poly_use_hint(poly *a, const poly *b, const poly *h) {
    unsigned int i;
    uint32_t a0, a1;
    int32_t t, u;
    uint32_t temp;

    for (i = 0; i < N; i=i+8)
    {
        // /* Centralized remainder mod ALPHA */
        temp = b->coeffs[i];
        t = temp & 0x7FFFF;
        t += (temp >> 19) << 9;
        t -= ALPHA/2 + 1;
        t += (t >> 31) & ALPHA;
        t -= ALPHA/2 - 1;
        temp -= t;

        /* Divide by ALPHA (possible to avoid) */
        u = temp - 1;
        u >>= 31;
        temp = (temp >> 19) + 1;
        temp -= u & 1;

        a0 = Q + t - (temp >> 4);
        a1 = temp & 0xF;

        if (h->coeffs[i] == 0)
        {
            a->coeffs[i] = a1;
        }
        else if (a0 > Q)
        {
            a->coeffs[i] = (a1 + 1) & 0xF;
        }
        else
        {
            a->coeffs[i] = (a1 - 1) & 0xF;
        }

        // /* Centralized remainder mod ALPHA */
        temp = b->coeffs[i+1];
        t = temp & 0x7FFFF;
        t += (temp >> 19) << 9;
        t -= ALPHA/2 + 1;
        t += (t >> 31) & ALPHA;
        t -= ALPHA/2 - 1;
        temp -= t;

        /* Divide by ALPHA (possible to avoid) */
        u = temp - 1;
        u >>= 31;
        temp = (temp >> 19) + 1;
        temp -= u & 1;

        a0 = Q + t - (temp >> 4);
        a1 = temp & 0xF;

        if (h->coeffs[i+1] == 0)
        {
            a->coeffs[i+1] = a1;
        }
        else if (a0 > Q)
        {
            a->coeffs[i+1] = (a1 + 1) & 0xF;
        }
        else
        {
            a->coeffs[i+1] = (a1 - 1) & 0xF;
        }

        // /* Centralized remainder mod ALPHA */
        temp = b->coeffs[i+2];
        t = temp & 0x7FFFF;
        t += (temp >> 19) << 9;
        t -= ALPHA/2 + 1;
        t += (t >> 31) & ALPHA;
        t -= ALPHA/2 - 1;
        temp -= t;

        /* Divide by ALPHA (possible to avoid) */
        u = temp - 1;
        u >>= 31;
        temp = (temp >> 19) + 1;
        temp -= u & 1;

        a0 = Q + t - (temp >> 4);
        a1 = temp & 0xF;

        if (h->coeffs[i+2] == 0)
        {
            a->coeffs[i+2] = a1;
        }
        else if (a0 > Q)
        {
            a->coeffs[i+2] = (a1 + 1) & 0xF;
        }
        else
        {
            a->coeffs[i+2] = (a1 - 1) & 0xF;
        }

        // /* Centralized remainder mod ALPHA */
        temp = b->coeffs[i+3];
        t = temp & 0x7FFFF;
        t += (temp >> 19) << 9;
        t -= ALPHA/2 + 1;
        t += (t >> 31) & ALPHA;
        t -= ALPHA/2 - 1;
        temp -= t;

        /* Divide by ALPHA (possible to avoid) */
        u = temp - 1;
        u >>= 31;
        temp = (temp >> 19) + 1;
        temp -= u & 1;

        a0 = Q + t - (temp >> 4);
        a1 = temp & 0xF;

        if (h->coeffs[i+3] == 0)
        {
            a->coeffs[i+3] = a1;
        }
        else if (a0 > Q)
        {
            a->coeffs[i+3] = (a1 + 1) & 0xF;
        }
        else
        {
            a->coeffs[i+3] = (a1 - 1) & 0xF;
        }

        // /* Centralized remainder mod ALPHA */
        temp = b->coeffs[i+4];
        t = temp & 0x7FFFF;
        t += (temp >> 19) << 9;
        t -= ALPHA/2 + 1;
        t += (t >> 31) & ALPHA;
        t -= ALPHA/2 - 1;
        temp -= t;

        /* Divide by ALPHA (possible to avoid) */
        u = temp - 1;
        u >>= 31;
        temp = (temp >> 19) + 1;
        temp -= u & 1;

        a0 = Q + t - (temp >> 4);
        a1 = temp & 0xF;

        if (h->coeffs[i+4] == 0)
        {
            a->coeffs[i+4] = a1;
        }
        else if (a0 > Q)
        {
            a->coeffs[i+4] = (a1 + 1) & 0xF;
        }
        else
        {
            a->coeffs[i+4] = (a1 - 1) & 0xF;
        }

        // /* Centralized remainder mod ALPHA */
        temp = b->coeffs[i+5];
        t = temp & 0x7FFFF;
        t += (temp >> 19) << 9;
        t -= ALPHA/2 + 1;
        t += (t >> 31) & ALPHA;
        t -= ALPHA/2 - 1;
        temp -= t;

        /* Divide by ALPHA (possible to avoid) */
        u = temp - 1;
        u >>= 31;
        temp = (temp >> 19) + 1;
        temp -= u & 1;

        a0 = Q + t - (temp >> 4);
        a1 = temp & 0xF;

        // a1 = decompose(b->coeffs[i], &a0);
        if (h->coeffs[i+5] == 0)
        {
            a->coeffs[i+5] = a1;
        }
        else if (a0 > Q)
        {
            a->coeffs[i+5] = (a1 + 1) & 0xF;
        }
        else
        {
            a->coeffs[i+5] = (a1 - 1) & 0xF;
        }

        // /* Centralized remainder mod ALPHA */
        temp = b->coeffs[i+6];
        t = temp & 0x7FFFF;
        t += (temp >> 19) << 9;
        t -= ALPHA/2 + 1;
        t += (t >> 31) & ALPHA;
        t -= ALPHA/2 - 1;
        temp -= t;

        /* Divide by ALPHA (possible to avoid) */
        u = temp - 1;
        u >>= 31;
        temp = (temp >> 19) + 1;
        temp -= u & 1;

        a0 = Q + t - (temp >> 4);
        a1 = temp & 0xF;

        if (h->coeffs[i+6] == 0)
        {
            a->coeffs[i+6] = a1;
        }
        else if (a0 > Q)
        {
            a->coeffs[i+6] = (a1 + 1) & 0xF;
        }
        else
        {
            a->coeffs[i+6] = (a1 - 1) & 0xF;
        }

        // /* Centralized remainder mod ALPHA */
        temp = b->coeffs[i+7];
        t = temp & 0x7FFFF;
        t += (temp >> 19) << 9;
        t -= ALPHA/2 + 1;
        t += (t >> 31) & ALPHA;
        t -= ALPHA/2 - 1;
        temp -= t;

        /* Divide by ALPHA (possible to avoid) */
        u = temp - 1;
        u >>= 31;
        temp = (temp >> 19) + 1;
        temp -= u & 1;

        a0 = Q + t - (temp >> 4);
        a1 = temp & 0xF;

        if (h->coeffs[i+7] == 0)
        {
            a->coeffs[i+7] = a1;
        }
        else if (a0 > Q)
        {
            a->coeffs[i+7] = (a1 + 1) & 0xF;
        }
        else
        {
            a->coeffs[i+7] = (a1 - 1) & 0xF;
        }
    }
}

/*************************************************
* Name:        poly_sub_freeze_chk_norm
*
* Description: Combination of subtraction, freeze and check_norm functions.
*
* Arguments:   - poly *c: pointer to output polynomial
*              - poly *a: pointer to first summand
*              - poly *b: pointer to second summand
               -
**************************************************/
int poly_sub_freeze_chk_norm(poly *c, const poly *a, const poly *b, uint32_t B)
{
  unsigned int i;
  int32_t t;
  int32_t temp;
  int32_t temp2;

    for(i = 0; i < N; i=i+8)
    {

        temp2 = a->coeffs[i] - b->coeffs[i];
        temp = temp2 & 0x7FFFFF;
        temp2 >>= 23;
        temp2 = temp + (temp2 << 13) - temp2;
        temp2 -= Q;
        temp2 = temp2 + ((temp2 >> 31) & Q);
        temp2 = temp2 + ((temp2 >> 31) & Q);

        /* Absolute value of centralized representative */
        t = (Q-1)/2 - temp2;
        t ^= (t >> 31);
        t = (Q-1)/2 - t;

        c->coeffs[i] = temp2;

        if((uint32_t)t >= B)
        {
          return 1;
        }

        temp2 = a->coeffs[i+1] - b->coeffs[i+1];
        temp = temp2 & 0x7FFFFF;
        temp2 >>= 23;
        temp2 = temp + (temp2 << 13) - temp2;
        temp2 -= Q;
        temp2 = temp2 + ((temp2 >> 31) & Q);
        temp2 = temp2 + ((temp2 >> 31) & Q);

        /* Absolute value of centralized representative */
        t = (Q-1)/2 - temp2;
        t ^= (t >> 31);
        t = (Q-1)/2 - t;

        c->coeffs[i+1] = temp2;

        if((uint32_t)t >= B)
        {
          return 1;
        }

        temp2 = a->coeffs[i+2] - b->coeffs[i+2];
        temp = temp2 & 0x7FFFFF;
        temp2 >>= 23;
        temp2 = temp + (temp2 << 13) - temp2;
        temp2 -= Q;
        temp2 = temp2 + ((temp2 >> 31) & Q);
        temp2 = temp2 + ((temp2 >> 31) & Q);

        /* Absolute value of centralized representative */
        t = (Q-1)/2 - temp2;
        t ^= (t >> 31);
        t = (Q-1)/2 - t;

        c->coeffs[i+2] = temp2;

        if((uint32_t)t >= B)
        {
          return 1;
        }

        temp2 = a->coeffs[i+3] - b->coeffs[i+3];
        temp = temp2 & 0x7FFFFF;
        temp2 >>= 23;
        temp2 = temp + (temp2 << 13) - temp2;
        temp2 -= Q;
        temp2 = temp2 + ((temp2 >> 31) & Q);
        temp2 = temp2 + ((temp2 >> 31) & Q);

        /* Absolute value of centralized representative */
        t = (Q-1)/2 - temp2;
        t ^= (t >> 31);
        t = (Q-1)/2 - t;

        c->coeffs[i+3] = temp2;

        if((uint32_t)t >= B)
        {
          return 1;
        }

        temp2 = a->coeffs[i+4] - b->coeffs[i+4];
        temp = temp2 & 0x7FFFFF;
        temp2 >>= 23;
        temp2 = temp + (temp2 << 13) - temp2;
        temp2 -= Q;
        temp2 = temp2 + ((temp2 >> 31) & Q);
        temp2 = temp2 + ((temp2 >> 31) & Q);

        /* Absolute value of centralized representative */
        t = (Q-1)/2 - temp2;
        t ^= (t >> 31);
        t = (Q-1)/2 - t;

        c->coeffs[i+4] = temp2;

        if((uint32_t)t >= B)
        {
          return 1;
        }

        temp2 = a->coeffs[i+5] - b->coeffs[i+5];
        temp = temp2 & 0x7FFFFF;
        temp2 >>= 23;
        temp2 = temp + (temp2 << 13) - temp2;
        temp2 -= Q;
        temp2 = temp2 + ((temp2 >> 31) & Q);
        temp2 = temp2 + ((temp2 >> 31) & Q);

        /* Absolute value of centralized representative */
        t = (Q-1)/2 - temp2;
        t ^= (t >> 31);
        t = (Q-1)/2 - t;

        c->coeffs[i+5] = temp2;

        if((uint32_t)t >= B)
        {
          return 1;
        }

        temp2 = a->coeffs[i+6] - b->coeffs[i+6];
        temp = temp2 & 0x7FFFFF;
        temp2 >>= 23;
        temp2 = temp + (temp2 << 13) - temp2;
        temp2 -= Q;
        temp2 = temp2 + ((temp2 >> 31) & Q);
        temp2 = temp2 + ((temp2 >> 31) & Q);

        /* Absolute value of centralized representative */
        t = (Q-1)/2 - temp2;
        t ^= (t >> 31);
        t = (Q-1)/2 - t;

        c->coeffs[i+6] = temp2;

        if((uint32_t)t >= B)
        {
          return 1;
        }

        temp2 = a->coeffs[i+7] - b->coeffs[i+7];
        temp = temp2 & 0x7FFFFF;
        temp2 >>= 23;
        temp2 = temp + (temp2 << 13) - temp2;
        temp2 -= Q;
        temp2 = temp2 + ((temp2 >> 31) & Q);
        temp2 = temp2 + ((temp2 >> 31) & Q);

        /* Absolute value of centralized representative */
        t = (Q-1)/2 - temp2;
        t ^= (t >> 31);
        t = (Q-1)/2 - t;

        c->coeffs[i+7] = temp2;

        if((uint32_t)t >= B)
        {
          return 1;
        }

    }

  return 0;
  /* It is ok to leak which coefficient violates the bound since
     the probability for each coefficient is independent of secret
     data but we must not leak the sign of the centralized representative. */
}

/*************************************************
* Name:        poly_add_freeze_chk_norm
*
* Description: Combination of Addition, freeze and check_norm functions.
*
* Arguments:   - poly *c: pointer to output polynomial
*              - poly *a: pointer to first summand
*              - poly *b: pointer to second summand
               - uint32_t B: norm bound
**************************************************/
int poly_add_freeze_chk_norm(poly *c, const poly *a, const poly *b, uint32_t B)
{
  unsigned int i;
  int32_t t;
  int32_t temp;

  for(i = 0; i < N; i=i+8)
  {
    // c->coeffs[i] = freeze(a->coeffs[i] + b->coeffs[i]);

    c->coeffs[i] = a->coeffs[i] + b->coeffs[i];
    temp = c->coeffs[i] & 0x7FFFFF;
    c->coeffs[i] >>= 23;
    c->coeffs[i] = temp + (c->coeffs[i] << 13) - c->coeffs[i];
    c->coeffs[i] -= Q;
    c->coeffs[i] += (c->coeffs[i] >> 31) & Q;
    c->coeffs[i] += (c->coeffs[i] >> 31) & Q;
    /* Absolute value of centralized representative */
    t = (Q-1)/2 - c->coeffs[i];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    {
      return 1;
    }

    c->coeffs[i+1] = a->coeffs[i+1] + b->coeffs[i+1];
    temp = c->coeffs[i+1] & 0x7FFFFF;
    c->coeffs[i+1] >>= 23;
    c->coeffs[i+1] = temp + (c->coeffs[i+1] << 13) - c->coeffs[i+1];
    c->coeffs[i+1] -= Q;
    c->coeffs[i+1] += (c->coeffs[i+1] >> 31) & Q;
    c->coeffs[i+1] += (c->coeffs[i+1] >> 31) & Q;
    /* Absolute value of centralized representative */
    t = (Q-1)/2 - c->coeffs[i+1];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    {
      return 1;
    }

    c->coeffs[i+2] = a->coeffs[i+2] + b->coeffs[i+2];
    temp = c->coeffs[i+2] & 0x7FFFFF;
    c->coeffs[i+2] >>= 23;
    c->coeffs[i+2] = temp + (c->coeffs[i+2] << 13) - c->coeffs[i+2];
    c->coeffs[i+2] -= Q;
    c->coeffs[i+2] += (c->coeffs[i+2] >> 31) & Q;
    c->coeffs[i+2] += (c->coeffs[i+2] >> 31) & Q;
    /* Absolute value of centralized representative */
    t = (Q-1)/2 - c->coeffs[i+2];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    {
      return 1;
    }

    c->coeffs[i+3] = a->coeffs[i+3] + b->coeffs[i+3];
    temp = c->coeffs[i+3] & 0x7FFFFF;
    c->coeffs[i+3] >>= 23;
    c->coeffs[i+3] = temp + (c->coeffs[i+3] << 13) - c->coeffs[i+3];
    c->coeffs[i+3] -= Q;
    c->coeffs[i+3] += (c->coeffs[i+3] >> 31) & Q;
    c->coeffs[i+3] += (c->coeffs[i+3] >> 31) & Q;
    /* Absolute value of centralized representative */
    t = (Q-1)/2 - c->coeffs[i+3];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    {
      return 1;
    }

    c->coeffs[i+4] = a->coeffs[i+4] + b->coeffs[i+4];
    temp = c->coeffs[i+4] & 0x7FFFFF;
    c->coeffs[i+4] >>= 23;
    c->coeffs[i+4] = temp + (c->coeffs[i+4] << 13) - c->coeffs[i+4];
    c->coeffs[i+4] -= Q;
    c->coeffs[i+4] += (c->coeffs[i+4] >> 31) & Q;
    c->coeffs[i+4] += (c->coeffs[i+4] >> 31) & Q;
    /* Absolute value of centralized representative */
    t = (Q-1)/2 - c->coeffs[i+4];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    {
      return 1;
    }

    c->coeffs[i+5] = a->coeffs[i+5] + b->coeffs[i+5];
    temp = c->coeffs[i+5] & 0x7FFFFF;
    c->coeffs[i+5] >>= 23;
    c->coeffs[i+5] = temp + (c->coeffs[i+5] << 13) - c->coeffs[i+5];
    c->coeffs[i+5] -= Q;
    c->coeffs[i+5] += (c->coeffs[i+5] >> 31) & Q;
    c->coeffs[i+5] += (c->coeffs[i+5] >> 31) & Q;
    /* Absolute value of centralized representative */
    t = (Q-1)/2 - c->coeffs[i+5];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    {
      return 1;
    }

    c->coeffs[i+6] = a->coeffs[i+6] + b->coeffs[i+6];
    temp = c->coeffs[i+6] & 0x7FFFFF;
    c->coeffs[i+6] >>= 23;
    c->coeffs[i+6] = temp + (c->coeffs[i+6] << 13) - c->coeffs[i+6];
    c->coeffs[i+6] -= Q;
    c->coeffs[i+6] += (c->coeffs[i+6] >> 31) & Q;
    c->coeffs[i+6] += (c->coeffs[i+6] >> 31) & Q;
    /* Absolute value of centralized representative */
    t = (Q-1)/2 - c->coeffs[i+6];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    {
      return 1;
    }

    c->coeffs[i+7] = a->coeffs[i+7] + b->coeffs[i+7];
    temp = c->coeffs[i+7] & 0x7FFFFF;
    c->coeffs[i+7] >>= 23;
    c->coeffs[i+7] = temp + (c->coeffs[i+7] << 13) - c->coeffs[i+7];
    c->coeffs[i+7] -= Q;
    c->coeffs[i+7] += (c->coeffs[i+7] >> 31) & Q;
    c->coeffs[i+7] += (c->coeffs[i+7] >> 31) & Q;
    /* Absolute value of centralized representative */
    t = (Q-1)/2 - c->coeffs[i+7];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    {
      return 1;
    }
  }
  return 0;
  /* It is ok to leak which coefficient violates the bound since
     the probability for each coefficient is independent of secret
     data but we must not leak the sign of the centralized representative. */

}

/*************************************************
* Name:        poly_csubq_chknorm
*
* Description: Combination of csubq and checknorm functions...
*
* Arguments:   - poly *a: pointer to input/output polynomial
                uint32_t B: norm bound
**************************************************/
int poly_csubq_chknorm(poly *a, uint32_t B) {
  unsigned int i;
  int32_t t;

  for(i = 0; i < N; i=i+8)
  {
    a->coeffs[i] -= Q;
    a->coeffs[i] += (a->coeffs[i] >> 31) & Q;
    a->coeffs[i] += (a->coeffs[i] >> 31) & Q;
    t = (Q-1)/2 - a->coeffs[i];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
      return 1;

    a->coeffs[i+1] -= Q;
    a->coeffs[i+1] += (a->coeffs[i+1] >> 31) & Q;
    a->coeffs[i+1] += (a->coeffs[i+1] >> 31) & Q;
    t = (Q-1)/2 - a->coeffs[i+1];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    return 1;

    a->coeffs[i+2] -= Q;
    a->coeffs[i+2] += (a->coeffs[i+2] >> 31) & Q;
    a->coeffs[i+2] += (a->coeffs[i+2] >> 31) & Q;
    t = (Q-1)/2 - a->coeffs[i+2];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    return 1;

    a->coeffs[i+3] -= Q;
    a->coeffs[i+3] += (a->coeffs[i+3] >> 31) & Q;
    a->coeffs[i+3] += (a->coeffs[i+3] >> 31) & Q;
    t = (Q-1)/2 - a->coeffs[i+3];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    return 1;
    a->coeffs[i+4] -= Q;
    a->coeffs[i+4] += (a->coeffs[i+4] >> 31) & Q;
    a->coeffs[i+4] += (a->coeffs[i+4] >> 31) & Q;
    t = (Q-1)/2 - a->coeffs[i+4];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    return 1;

    a->coeffs[i+5] -= Q;
    a->coeffs[i+5] += (a->coeffs[i+5] >> 31) & Q;
    a->coeffs[i+5] += (a->coeffs[i+5] >> 31) & Q;
    t = (Q-1)/2 - a->coeffs[i+5];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    return 1;

    a->coeffs[i+6] -= Q;
    a->coeffs[i+6] += (a->coeffs[i+6] >> 31) & Q;
    a->coeffs[i+6] += (a->coeffs[i+6] >> 31) & Q;
    t = (Q-1)/2 - a->coeffs[i+6];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    return 1;

    a->coeffs[i+7] -= Q;
    a->coeffs[i+7] += (a->coeffs[i+7] >> 31) & Q;
    a->coeffs[i+7] += (a->coeffs[i+7] >> 31) & Q;
    t = (Q-1)/2 - a->coeffs[i+7];
    t ^= (t >> 31);
    t = (Q-1)/2 - t;

    if((uint32_t)t >= B)
    return 1;
  }
  return 0;
}

/*************************************************
* Name:        poly_chknorm
*
* Description: Check infinity norm of polynomial against given bound.
*              Assumes input coefficients to be standard representatives.
*
* Arguments:   - const poly *a: pointer to polynomial
*              - uint32_t B: norm bound
*
* Returns 0 if norm is strictly smaller than B and 1 otherwise.
**************************************************/
int poly_chknorm(const poly *a, uint32_t B) {
    unsigned int i;
    int32_t t;

    /* It is ok to leak which coefficient violates the bound since
       the probability for each coefficient is independent of secret
       data but we must not leak the sign of the centralized representative. */
    for (i = 0; i < N; ++i) {
        t = (int32_t) a->coeffs[i];

        if (t >= (int32_t)B || t <= - (int32_t)B) {
            return 1;
        }
    }

    return 0;
}

/*************************************************
* Name:        rej_uniform
*
* Description: Sample uniformly random coefficients in [0, Q-1] by
*              performing rejection sampling using array of random bytes.
*
* Arguments:   - uint32_t *a: pointer to output array (allocated)
*              - unsigned int len: number of coefficients to be sampled
*              - const unsigned char *buf: array of random bytes
*              - unsigned int buflen: length of array of random bytes
*
* Returns number of sampled coefficients. Can be smaller than len if not enough
* random bytes were given.
**************************************************/
// moved to assembly
//static unsigned int rej_uniform(int32_t *a,
//                                unsigned int len,
//                                const unsigned char *buf,
//                                unsigned int buflen) {
//    unsigned int ctr, pos;
//    int32_t t;
//
//    ctr = pos = 0;
//    while (ctr < len && pos + 3 <= buflen) {
//        t  = buf[pos++];
//        t |= (int32_t)buf[pos++] << 8;
//        t |= (int32_t)buf[pos++] << 16;
//        t &= 0x7FFFFF;
//
//        if (t < Q) {
//            a[ctr++] = t;
//        }
//    }
//
//    return ctr;
//}

/*************************************************
* Name:        poly_uniform
*
* Description: Sample polynomial with uniformly random coefficients
*              in [0,Q-1] by performing rejection sampling using the
*              output stream from SHAKE256(seed|nonce).
*
* Arguments:   - poly *a: pointer to output polynomial
*              - const unsigned char seed[]: byte array with seed of length
*                                            SEEDBYTES
*              - uint16_t nonce: 2-byte nonce
**************************************************/
#define POLY_UNIFORM_NBLOCKS ((769 + STREAM128_BLOCKBYTES)/STREAM128_BLOCKBYTES)
#define POLY_UNIFORM_BUFLEN  (POLY_UNIFORM_NBLOCKS * STREAM128_BLOCKBYTES)
void poly_uniform(poly *a,
        const unsigned char seed[SEEDBYTES],
        uint16_t nonce) {
    unsigned int i, ctr, off;
    unsigned int buflen = POLY_UNIFORM_BUFLEN;
    unsigned char buf[POLY_UNIFORM_BUFLEN + 2];
    shake128incctx state;

    stream128_init(&state, seed, nonce);
    stream128_squeezeblocks(buf, POLY_UNIFORM_NBLOCKS, &state);

    ctr = rej_uniform_asm(a->coeffs, N, buf, buflen);

    while (ctr < N) {
        off = buflen % 3;
        for (i = 0; i < off; ++i) {
            buf[i] = buf[buflen - off + i];
        }

        buflen = STREAM128_BLOCKBYTES + off;
        stream128_squeezeblocks(buf + off, 1, &state);
        ctr += rej_uniform_asm(a->coeffs + ctr, N - ctr, buf, buflen);
    }
}



/*************************************************
* Name:        rej_eta
*
* Description: Sample uniformly random coefficients in [-ETA, ETA] by
*              performing rejection sampling using array of random bytes.
*
* Arguments:   - uint32_t *a: pointer to output array (allocated)
*              - unsigned int len: number of coefficients to be sampled
*              - const unsigned char *buf: array of random bytes
*              - unsigned int buflen: length of array of random bytes
*
* Returns number of sampled coefficients. Can be smaller than len if not enough
* random bytes were given.
**************************************************/
static unsigned int rej_eta(int32_t *a,
                            unsigned int len,
                            const unsigned char *buf,
                            unsigned int buflen) {
    unsigned int ctr, pos;
    uint32_t t0, t1;

    ctr = pos = 0;
    while (ctr < len && pos < buflen) {
        #if ETA <= 3
        t0 = buf[pos] & 0x07;
        t1 = buf[pos++] >> 5;
        #else
        t0 = buf[pos] & 0x0F;
        t1 = buf[pos++] >> 4;
        #endif

        if (t0 <= 2 * ETA) {
            a[ctr++] = ETA - t0;
        }
        if (t1 <= 2 * ETA && ctr < len) {
            a[ctr++] = ETA - t1;
        }
    }

    return ctr;
}

/*************************************************
* Name:        poly_uniform_eta
*
* Description: Sample polynomial with uniformly random coefficients
*              in [-ETA,ETA] by performing rejection sampling using the
*              output stream from SHAKE256(seed|nonce).
*
* Arguments:   - poly *a: pointer to output polynomial
*              - const unsigned char seed[]: byte array with seed of length
*                                            SEEDBYTES
*              - uint16_t nonce: 2-byte nonce
**************************************************/
#define POLY_UNIFORM_ETA_NBLOCKS ((192 + STREAM128_BLOCKBYTES - 1) \
                                  /STREAM128_BLOCKBYTES)
#define POLY_UNIFORM_ETA_BUFLEN (POLY_UNIFORM_ETA_NBLOCKS*STREAM128_BLOCKBYTES)
void poly_uniform_eta(poly *a,
        const unsigned char seed[SEEDBYTES],
        uint16_t nonce) {
    unsigned int ctr;
    unsigned char buf[POLY_UNIFORM_ETA_BUFLEN];
    shake128incctx state;

    stream128_init(&state, seed, nonce);
    stream128_squeezeblocks(buf, POLY_UNIFORM_ETA_NBLOCKS, &state);

    ctr = rej_eta(a->coeffs, N, buf, POLY_UNIFORM_ETA_BUFLEN);

    while (ctr < N) {
        stream128_squeezeblocks(buf, 1, &state);
        ctr += rej_eta(a->coeffs + ctr, N - ctr, buf, STREAM128_BLOCKBYTES);
    }
}

/*************************************************
* Name:        rej_gamma1m1
*
* Description: Sample uniformly random coefficients
*              in [-(GAMMA1 - 1), GAMMA1 - 1] by performing rejection sampling
*              using array of random bytes.
*
* Arguments:   - int32_t *a: pointer to output array (allocated)
*              - unsigned int len: number of coefficients to be sampled
*              - const unsigned char *buf: array of random bytes
*              - unsigned int buflen: length of array of random bytes
*
* Returns number of sampled coefficients. Can be smaller than len if not enough
* random bytes were given.
**************************************************/

static unsigned int rej_gamma1m1(int32_t *a,
                                 unsigned int len,
                                 const unsigned char *buf,
                                 unsigned int buflen) {
    unsigned int ctr, pos;
    uint32_t t0, t1;

    ctr = pos = 0;
    while (ctr < len && pos + 5 <= buflen) {
        t0  = buf[pos];
        t0 |= (uint32_t)buf[pos + 1] << 8;
        t0 |= (uint32_t)buf[pos + 2] << 16;
        t0 &= 0xFFFFF;

        t1  = buf[pos + 2] >> 4;
        t1 |= (uint32_t)buf[pos + 3] << 4;
        t1 |= (uint32_t)buf[pos + 4] << 12;

        pos += 5;

        if (t0 <= 2 * GAMMA1 - 2) {
            a[ctr++] = GAMMA1 - 1 - t0;
        }
        if (t1 <= 2 * GAMMA1 - 2 && ctr < len) {
            a[ctr++] = GAMMA1 - 1 - t1;
        }
    }

    return ctr;
}


/*************************************************
* Name:        poly_uniform_gamma1m1
*
* Description: Sample polynomial with uniformly random coefficients
*              in [-(GAMMA1 - 1), GAMMA1 - 1] by performing rejection
*              sampling on output stream of SHAKE256(seed|nonce).
*
* Arguments:   - poly *a: pointer to output polynomial
*              - const unsigned char seed[]: byte array with seed of length
*                                            CRHBYTES
*              - uint16_t nonce: 16-bit nonce
**************************************************/
#define POLY_UNIFORM_GAMMA1M1_NBLOCKS ((641 + STREAM256_BLOCKBYTES) / STREAM256_BLOCKBYTES)
#define POLY_UNIFORM_GAMMA1M1_BUFLEN (POLY_UNIFORM_GAMMA1M1_NBLOCKS * STREAM256_BLOCKBYTES)
void poly_uniform_gamma1m1(poly *a,
        const unsigned char seed[CRHBYTES],
        uint16_t nonce) {
    unsigned int i, ctr, off;
    unsigned int buflen = POLY_UNIFORM_GAMMA1M1_BUFLEN;
    unsigned char buf[POLY_UNIFORM_GAMMA1M1_BUFLEN + 4];
    shake256incctx state;

    stream256_init(&state, seed, nonce);
    stream256_squeezeblocks(buf, POLY_UNIFORM_GAMMA1M1_NBLOCKS, &state);

    ctr = rej_gamma1m1(a->coeffs, N, buf, buflen);

    while (ctr < N) {
        off = buflen % 5;
        for (i = 0; i < off; ++i) {
            buf[i] = buf[buflen - off + i];
        }

        buflen = STREAM256_BLOCKBYTES + off;
        stream256_squeezeblocks(buf + off, 1, &state);
        ctr += rej_gamma1m1(a->coeffs + ctr, N - ctr, buf, buflen);
    }
}

/*************************************************
* Name:        polyeta_pack
*
* Description: Bit-pack polynomial with coefficients in [-ETA,ETA].
*              Input coefficients are assumed to lie in [Q-ETA,Q+ETA].
*
* Arguments:   - unsigned char *r: pointer to output byte array with at least
*                                  POLETA_SIZE_PACKED bytes
*              - const poly *a: pointer to input polynomial
**************************************************/

void polyeta_pack(unsigned char *r, const poly *a) {
    unsigned int i;
    unsigned char t[8];

    #if 2*ETA <= 7
    for(i = 0; i < N/8; ++i) {
        t[0] = ETA - a->coeffs[8*i+0];
        t[1] = ETA - a->coeffs[8*i+1];
        t[2] = ETA - a->coeffs[8*i+2];
        t[3] = ETA - a->coeffs[8*i+3];
        t[4] = ETA - a->coeffs[8*i+4];
        t[5] = ETA - a->coeffs[8*i+5];
        t[6] = ETA - a->coeffs[8*i+6];
        t[7] = ETA - a->coeffs[8*i+7];

        r[3*i+0]  = (t[0] >> 0) | (t[1] << 3) | (t[2] << 6);
        r[3*i+1]  = (t[2] >> 2) | (t[3] << 1) | (t[4] << 4) | (t[5] << 7);
        r[3*i+2]  = (t[5] >> 1) | (t[6] << 2) | (t[7] << 5);
    }
    #else
    for(i = 0; i < N/2; ++i) {
        t[0] = ETA - a->coeffs[2*i+0];
        t[1] = ETA - a->coeffs[2*i+1];
        r[i] = t[0] | (t[1] << 4);
    }
    #endif
}


/*************************************************
* Name:        polyeta_unpack
*
* Description: Unpack polynomial with coefficients in [-ETA,ETA].
*              Output coefficients lie in [Q-ETA,Q+ETA].
*
* Arguments:   - poly *r: pointer to output polynomial
*              - const unsigned char *a: byte array with bit-packed polynomial
**************************************************/
void polyeta_unpack(poly *r, const unsigned char *a) {
    unsigned int i;
    #if ETA <= 3
    for(i = 0; i < N/8; ++i) {
        r->coeffs[8*i+0] = a[3*i+0] & 0x07;
        r->coeffs[8*i+1] = (a[3*i+0] >> 3) & 0x07;
        r->coeffs[8*i+2] = ((a[3*i+0] >> 6) | (a[3*i+1] << 2)) & 0x07;
        r->coeffs[8*i+3] = (a[3*i+1] >> 1) & 0x07;
        r->coeffs[8*i+4] = (a[3*i+1] >> 4) & 0x07;
        r->coeffs[8*i+5] = ((a[3*i+1] >> 7) | (a[3*i+2] << 1)) & 0x07;
        r->coeffs[8*i+6] = (a[3*i+2] >> 2) & 0x07;
        r->coeffs[8*i+7] = (a[3*i+2] >> 5) & 0x07;

        r->coeffs[8*i+0] = Q + ETA - r->coeffs[8*i+0];
        r->coeffs[8*i+1] = Q + ETA - r->coeffs[8*i+1];
        r->coeffs[8*i+2] = Q + ETA - r->coeffs[8*i+2];
        r->coeffs[8*i+3] = Q + ETA - r->coeffs[8*i+3];
        r->coeffs[8*i+4] = Q + ETA - r->coeffs[8*i+4];
        r->coeffs[8*i+5] = Q + ETA - r->coeffs[8*i+5];
        r->coeffs[8*i+6] = Q + ETA - r->coeffs[8*i+6];
        r->coeffs[8*i+7] = Q + ETA - r->coeffs[8*i+7];
    }
    #else
    for(i = 0; i < N/2; ++i) {
        r->coeffs[2*i+0] = a[i] & 0x0F;
        r->coeffs[2*i+1] = a[i] >> 4;
        r->coeffs[2*i+0] = Q + ETA - r->coeffs[2*i+0];
        r->coeffs[2*i+1] = Q + ETA - r->coeffs[2*i+1];
    }
    #endif
}

/*************************************************
* Name:        polyt1_pack
*
* Description: Bit-pack polynomial t1 with coefficients fitting in 9 bits.
*              Input coefficients are assumed to be standard representatives.
*
* Arguments:   - unsigned char *r: pointer to output byte array with at least
*                                  POLT1_SIZE_PACKED bytes
*              - const poly *a: pointer to input polynomial
**************************************************/
void polyt1_pack(unsigned char *r, const poly *a) {
    unsigned int i;

    for (i = 0; i < N / 8; ++i) {
        r[9 * i + 0]  = (uint8_t) ((a->coeffs[8 * i + 0] >> 0));
        r[9 * i + 1]  = (uint8_t) ((a->coeffs[8 * i + 0] >> 8) | (a->coeffs[8 * i + 1] << 1));
        r[9 * i + 2]  = (uint8_t) ((a->coeffs[8 * i + 1] >> 7) | (a->coeffs[8 * i + 2] << 2));
        r[9 * i + 3]  = (uint8_t) ((a->coeffs[8 * i + 2] >> 6) | (a->coeffs[8 * i + 3] << 3));
        r[9 * i + 4]  = (uint8_t) ((a->coeffs[8 * i + 3] >> 5) | (a->coeffs[8 * i + 4] << 4));
        r[9 * i + 5]  = (uint8_t) ((a->coeffs[8 * i + 4] >> 4) | (a->coeffs[8 * i + 5] << 5));
        r[9 * i + 6]  = (uint8_t) ((a->coeffs[8 * i + 5] >> 3) | (a->coeffs[8 * i + 6] << 6));
        r[9 * i + 7]  = (uint8_t) ((a->coeffs[8 * i + 6] >> 2) | (a->coeffs[8 * i + 7] << 7));
        r[9 * i + 8]  = (uint8_t) ((a->coeffs[8 * i + 7] >> 1));
    }

}

/*************************************************
* Name:        polyt1_unpack
*
* Description: Unpack polynomial t1 with 9-bit coefficients.
*              Output coefficients are standard representatives.
*
* Arguments:   - poly *r: pointer to output polynomial
*              - const unsigned char *a: byte array with bit-packed polynomial
**************************************************/
void polyt1_unpack(poly *r, const unsigned char *a) {
    unsigned int i;

    for (i = 0; i < N / 8; ++i) {
        r->coeffs[8 * i + 0] = ((a[9 * i + 0]     ) | ((uint32_t)a[9 * i + 1] << 8)) & 0x1FF;
        r->coeffs[8 * i + 1] = ((a[9 * i + 1] >> 1) | ((uint32_t)a[9 * i + 2] << 7)) & 0x1FF;
        r->coeffs[8 * i + 2] = ((a[9 * i + 2] >> 2) | ((uint32_t)a[9 * i + 3] << 6)) & 0x1FF;
        r->coeffs[8 * i + 3] = ((a[9 * i + 3] >> 3) | ((uint32_t)a[9 * i + 4] << 5)) & 0x1FF;
        r->coeffs[8 * i + 4] = ((a[9 * i + 4] >> 4) | ((uint32_t)a[9 * i + 5] << 4)) & 0x1FF;
        r->coeffs[8 * i + 5] = ((a[9 * i + 5] >> 5) | ((uint32_t)a[9 * i + 6] << 3)) & 0x1FF;
        r->coeffs[8 * i + 6] = ((a[9 * i + 6] >> 6) | ((uint32_t)a[9 * i + 7] << 2)) & 0x1FF;
        r->coeffs[8 * i + 7] = ((a[9 * i + 7] >> 7) | ((uint32_t)a[9 * i + 8] << 1)) & 0x1FF;
    }

}

/*************************************************
* Name:        polyt0_pack
*
* Description: Bit-pack polynomial t0 with coefficients in ]-2^{D-1}, 2^{D-1}].
*              Input coefficients are assumed to lie in ]Q-2^{D-1}, Q+2^{D-1}].
*
* Arguments:   - unsigned char *r: pointer to output byte array with at least
*                                  POLT0_SIZE_PACKED bytes
*              - const poly *a: pointer to input polynomial
**************************************************/
void polyt0_pack(unsigned char *r, const poly *a) {
    unsigned int i;
    uint32_t t[4];

    for (i = 0; i < N / 4; ++i) {
        t[0] = Q + (1U << (D - 1)) - a->coeffs[4 * i + 0];
        t[1] = Q + (1U << (D - 1)) - a->coeffs[4 * i + 1];
        t[2] = Q + (1U << (D - 1)) - a->coeffs[4 * i + 2];
        t[3] = Q + (1U << (D - 1)) - a->coeffs[4 * i + 3];

        r[7 * i + 0]  = (uint8_t) (t[0]);
        r[7 * i + 1]  = (uint8_t) (t[0] >> 8);
        r[7 * i + 1] |= (uint8_t) (t[1] << 6);
        r[7 * i + 2]  = (uint8_t) (t[1] >> 2);
        r[7 * i + 3]  = (uint8_t) (t[1] >> 10);
        r[7 * i + 3] |= (uint8_t) (t[2] << 4);
        r[7 * i + 4]  = (uint8_t) (t[2] >> 4);
        r[7 * i + 5]  = (uint8_t) (t[2] >> 12);
        r[7 * i + 5] |= (uint8_t) (t[3] << 2);
        r[7 * i + 6]  = (uint8_t) (t[3] >> 6);
    }

}

/*************************************************
* Name:        polyt0_unpack
*
* Description: Unpack polynomial t0 with coefficients in ]-2^{D-1}, 2^{D-1}].
*              Output coefficients lie in ]Q-2^{D-1},Q+2^{D-1}].
*
* Arguments:   - poly *r: pointer to output polynomial
*              - const unsigned char *a: byte array with bit-packed polynomial
**************************************************/
void polyt0_unpack(poly *r, const unsigned char *a) {
    unsigned int i;

    for (i = 0; i < N / 4; ++i) {
        r->coeffs[4 * i + 0]  = a[7 * i + 0];
        r->coeffs[4 * i + 0] |= (uint32_t)(a[7 * i + 1] & 0x3F) << 8;

        r->coeffs[4 * i + 1]  = a[7 * i + 1] >> 6;
        r->coeffs[4 * i + 1] |= (uint32_t)a[7 * i + 2] << 2;
        r->coeffs[4 * i + 1] |= (uint32_t)(a[7 * i + 3] & 0x0F) << 10;

        r->coeffs[4 * i + 2]  = a[7 * i + 3] >> 4;
        r->coeffs[4 * i + 2] |= (uint32_t)a[7 * i + 4] << 4;
        r->coeffs[4 * i + 2] |= (uint32_t)(a[7 * i + 5] & 0x03) << 12;

        r->coeffs[4 * i + 3]  = a[7 * i + 5] >> 2;
        r->coeffs[4 * i + 3] |= (uint32_t)a[7 * i + 6] << 6;

        r->coeffs[4 * i + 0] = Q + (1U << (D - 1)) - r->coeffs[4 * i + 0];
        r->coeffs[4 * i + 1] = Q + (1U << (D - 1)) - r->coeffs[4 * i + 1];
        r->coeffs[4 * i + 2] = Q + (1U << (D - 1)) - r->coeffs[4 * i + 2];
        r->coeffs[4 * i + 3] = Q + (1U << (D - 1)) - r->coeffs[4 * i + 3];
    }

}

/*************************************************
* Name:        polyz_pack
*
* Description: Bit-pack polynomial z with coefficients
*              in [-(GAMMA1 - 1), GAMMA1 - 1].
*              Input coefficients are assumed to be standard representatives.
*
* Arguments:   - unsigned char *r: pointer to output byte array with at least
*                                  POLZ_SIZE_PACKED bytes
*              - const poly *a: pointer to input polynomial
**************************************************/
void polyz_pack(unsigned char *r, const poly *a) {
    unsigned int i;
    uint32_t t[2];

    for (i = 0; i < N / 2; ++i) {
        /* Map to {0,...,2*GAMMA1 - 2} */
        t[0] = GAMMA1 - 1 - a->coeffs[2 * i + 0];
        t[0] += ((int32_t)t[0] >> 31) & Q;
        t[1] = GAMMA1 - 1 - a->coeffs[2 * i + 1];
        t[1] += ((int32_t)t[1] >> 31) & Q;

        r[5 * i + 0]  = (uint8_t) (t[0]);
        r[5 * i + 1]  = (uint8_t) (t[0] >> 8);
        r[5 * i + 2]  = (uint8_t) (t[0] >> 16);
        r[5 * i + 2] |= (uint8_t) (t[1] << 4);
        r[5 * i + 3]  = (uint8_t) (t[1] >> 4);
        r[5 * i + 4]  = (uint8_t) (t[1] >> 12);
    }

}

/*************************************************
* Name:        polyz_unpack
*
* Description: Unpack polynomial z with coefficients
*              in [-(GAMMA1 - 1), GAMMA1 - 1].
*              Output coefficients are standard representatives.
*
* Arguments:   - poly *r: pointer to output polynomial
*              - const unsigned char *a: byte array with bit-packed polynomial
**************************************************/
void polyz_unpack(poly *r, const unsigned char *a) {
    unsigned int i;

    for (i = 0; i < N / 2; ++i) {
        r->coeffs[2 * i + 0]  = a[5 * i + 0];
        r->coeffs[2 * i + 0] |= (uint32_t)a[5 * i + 1] << 8;
        r->coeffs[2 * i + 0] |= (uint32_t)(a[5 * i + 2] & 0x0F) << 16;

        r->coeffs[2 * i + 1]  = a[5 * i + 2] >> 4;
        r->coeffs[2 * i + 1] |= (uint32_t)a[5 * i + 3] << 4;
        r->coeffs[2 * i + 1] |= (uint32_t)a[5 * i + 4] << 12;

        r->coeffs[2 * i + 0] = GAMMA1 - 1 - r->coeffs[2 * i + 0];
        r->coeffs[2 * i + 1] = GAMMA1 - 1 - r->coeffs[2 * i + 1];
    }

}

/*************************************************
* Name:        polyw1_pack
*
* Description: Bit-pack polynomial w1 with coefficients in [0, 15].
*              Input coefficients are assumed to be standard representatives.
*
* Arguments:   - unsigned char *r: pointer to output byte array with at least
*                                  POLW1_SIZE_PACKED bytes
*              - const poly *a: pointer to input polynomial
**************************************************/
void polyw1_pack(unsigned char *r, const poly *a) {
    unsigned int i;

    for (i = 0; i < N / 2; ++i) {
        r[i] = (uint8_t) (a->coeffs[2 * i + 0] | (a->coeffs[2 * i + 1] << 4));
    }

}


