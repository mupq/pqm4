/* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0"
 *
 * Written by Nir Drucker, Shay Gueron and Dusan Kostic,
 * AWS Cryptographic Algorithms Group.
 *
 * Modified by Ming-Shing Chen, Tung Chou and Markus Krausz.
 *
 */

#include <assert.h>

#include "cleanup.h"
#include "ring_ops.h"





// c = a mod (x^r - 1)
_INLINE_ void ring_red(OUT pad_r_t *c, IN const dbl_pad_r_t *a)
{
  const uint64_t *a64 = (const uint64_t *)a;
  uint64_t *      c64 = (uint64_t *)c;

  for(size_t i = 0; i < R_QWORDS; i += REG_QWORDS) {
    REG_T vt0 = LOAD(&a64[i]);
    REG_T vt1 = LOAD(&a64[i + R_QWORDS]);
    REG_T vt2 = LOAD(&a64[i + R_QWORDS - 1]);

    vt1 = SLLI_I64(vt1, LAST_R_QWORD_TRAIL);
    vt2 = SRLI_I64(vt2, LAST_R_QWORD_LEAD);

    vt0 ^= (vt1 | vt2);

    STORE(&c64[i], vt0);
  }

  c64[R_QWORDS - 1] &= LAST_R_QWORD_MASK;

  // Clean the secrets from the upper part of c
  secure_clean((uint8_t *)&c64[R_QWORDS],
               (R_PADDED_QWORDS - R_QWORDS) * sizeof(uint64_t));
}




#if 2048 == R_PADDED_BYTES
#define LOG_POLYLEN 11

#if defined(_USE_BMUL2_)
#define bitpolymul_input_transform(ao,ai,l)  bmul2_2048_to_4096_prepare((uint32_t*)ao,ai)
#define bitpolymul_mul(c,a,b,l)              bmul2_2048_to_4096_mul(c,(const uint32_t*)a,(const uint32_t * )b)
#endif

#elif 4096 == R_PADDED_BYTES
#define LOG_POLYLEN 12

#if defined(_USE_BMUL2_)
#define bitpolymul_input_transform(ao,ai,l)  bmul2_4096_to_8192_prepare((uint32_t*)ao,ai)
#define bitpolymul_mul(c,a,b,l)              bmul2_4096_to_8192_mul(c,(const uint32_t*)a,(const uint32_t * )b)
#endif

#else
error
#endif


void ring_mul_inputtransform(OUT mul_internal_t *c, IN const pad_r_t *a)
{
  bitpolymul_input_transform( (uint16_t*)c, (const uint8_t*)a , LOG_POLYLEN );
}

void ring_mul(OUT pad_r_t *c, IN const pad_r_t *a, IN const pad_r_t *b)
{
  DEFER_CLEANUP(dbl_pad_r_t t = {0}, dbl_pad_r_cleanup);
  DEFER_CLEANUP(mul_internal_t ta = {0}, mul_internal_cleanup);
  DEFER_CLEANUP(mul_internal_t tb = {0}, mul_internal_cleanup);

  bitpolymul_input_transform( (uint16_t*)&ta, (const uint8_t*)a , LOG_POLYLEN );
  bitpolymul_input_transform( (uint16_t*)&tb, (const uint8_t*)b , LOG_POLYLEN );
  bitpolymul_mul( (uint8_t*)&t , (uint16_t *)&ta, (const uint16_t *)&tb , LOG_POLYLEN + 1 );

  ring_red(c, &t);
}


void ring_mul_2(OUT pad_r_t *c, IN const pad_r_t *a, IN const mul_internal_t *tb)
{
  DEFER_CLEANUP(mul_internal_t t = {0}, mul_internal_cleanup);
  DEFER_CLEANUP(mul_internal_t ta = {0}, mul_internal_cleanup);

  bitpolymul_input_transform( (uint16_t*)&ta, (const uint8_t*)a , LOG_POLYLEN );
  bitpolymul_mul( (uint8_t*)&t , (uint16_t *)&ta, (const uint16_t *)tb , LOG_POLYLEN + 1 );

  ring_red(c, &t);
}

void ring_mul_rep(OUT pad_r_t *c, IN const pad_r_t *a, IN const mul_internal_t *tb)
{
  DEFER_CLEANUP(mul_internal_t t = {0}, mul_internal_cleanup);
  DEFER_CLEANUP(mul_internal_t ta = {0}, mul_internal_cleanup);

  bitpolymul_input_transform( (uint16_t*)&ta, (const uint8_t*)a , LOG_POLYLEN );
  bitpolymul_mul( (uint8_t*)&t , (uint16_t *)&ta, (const uint16_t *)tb , LOG_POLYLEN + 1 );

  ring_red(c, &t);
}




////////////////////////////////////////////////////


static inline
uint64_t squ32(uint32_t a32 )
{
  static const uint32_t m16 = 0xffff0000;
  static const uint32_t m8 = 0xff00ff00;
  static const uint32_t m4 = 0xf0f0f0f0;
  static const uint32_t m2 = 0xcccccccc;
  static const uint32_t m1 = 0xaaaaaaaa;

  uint32_t c0 = a32&~m16;
  uint32_t c1 = (a32&m16)>>16;
  c0 = (c0&~m8)|((c0&m8)<<8);
  c1 = (c1&~m8)|((c1&m8)<<8);
  c0 = (c0&~m4)|((c0&m4)<<4);
  c1 = (c1&~m4)|((c1&m4)<<4);
  c0 = (c0&~m2)|((c0&m2)<<2);
  c1 = (c1&~m2)|((c1&m2)<<2);
  c0 = (c0&~m1)|((c0&m1)<<1);
  c1 = (c1&~m1)|((c1&m1)<<1);

  uint64_t r = c0;
  r |= ((uint64_t)c1)<<32;

  return r;
}

static inline
void squ64(uint64_t *r, uint64_t a64 )
{
  r[0] = squ32(a64&0xffffffff);
  r[1] = squ32((a64>>32)&0xffffffff);
}

static inline
void _bitsqu(OUT dbl_pad_r_t *c, IN const pad_r_t *a)
{
  const uint64_t *a64 = (const uint64_t *)a;
  uint64_t *      c64 = (uint64_t *)c;
  for(int i = 0; i < (R_QWORDS); i++) {
    squ64( c64+i*2 , a64[i] );
  }
}


void ring_squ(OUT pad_r_t *c, IN const pad_r_t *a )
{

  DEFER_CLEANUP(dbl_pad_r_t t = {0}, dbl_pad_r_cleanup);

  _bitsqu( &t , a );

  ring_red(c, &t);

}


