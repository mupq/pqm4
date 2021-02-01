#ifndef _RING_OPS_H_
#define _RING_OPS_H_

#include "types.h"

// c = a+b mod (x^r - 1)
_INLINE_ void
ring_add(OUT r_t *c, IN const r_t *a, IN const r_t *b)
{
#if 1
  const uint64_t *a_qwords = (const uint64_t *)a;
  const uint64_t *b_qwords = (const uint64_t *)b;
  uint64_t *      c_qwords = (uint64_t *)c;

  for(size_t i = 0; i < R_QWORDS-1; i ++) {
    c_qwords[i] = a_qwords[i]^b_qwords[i];
  }

  const uint8_t *a_bytes = (const uint8_t *)a;
  const uint8_t *b_bytes = (const uint8_t *)b;
  uint8_t *      c_bytes = (uint8_t *)c;

  for(size_t i=(R_QWORDS-1)*8; i<R_BYTES;i++) {
    c_bytes[i] = a_bytes[i]^b_bytes[i];
  }
#else
  REG_T           va, vb;
  const uint64_t *a_qwords = (const uint64_t *)a;
  const uint64_t *b_qwords = (const uint64_t *)b;
  uint64_t *      c_qwords = (uint64_t *)c;

  for(size_t i = 0; i < R_PADDED_QWORDS; i += REG_QWORDS) {
    va = LOAD(&a_qwords[i]);
    vb = LOAD(&b_qwords[i]);

    STORE(&c_qwords[i], va ^ vb);
  }
#endif
}


#define _USE_BMUL2_

#if defined(_USE_BMUL2_)

#include "bmul2.h"
#define mul_internal_t        dbl_pad_r_t
#define mul_internal_cleanup  dbl_pad_r_cleanup

#else

#include "bitpolymul.h"
#define mul_internal_t        quad_pad_r_t
#define mul_internal_cleanup  quad_pad_r_cleanup

#endif


// c = a*b mod (x^r - 1)
void ring_mul(OUT pad_r_t *c, IN const pad_r_t *a, IN const pad_r_t *b);

void ring_mul_2(OUT pad_r_t *c, IN const pad_r_t *a, IN const mul_internal_t *b_fft);

void ring_mul_inputtransform(OUT mul_internal_t *ta, IN const pad_r_t *a);

void ring_mul_rep(OUT pad_r_t *c, IN const pad_r_t *a, IN const mul_internal_t *tb);


///////


// c = a^2 mod (x^r - 1)
void ring_squ(OUT pad_r_t *c, IN const pad_r_t *a);

#endif
