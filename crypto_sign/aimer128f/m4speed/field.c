// SPDX-License-Identifier: MIT

#include "field.h"
#include <stddef.h>
#include <stdint.h>

#define mask_64     0x00000000ffffffff
#define mask_final  0x000000000000ffff

#define mask0_64    0x000000ff000000ff
#define mask0       0x000000ff

#define mask1_64    0x000f000f000f000f
#define mask1       0x000f000f

#define mask2_64    0x0303030303030303
#define mask2       0x03030303

#define mask3_64    0x1111111111111111
#define mask3       0x11111111

#define zero_padding(x0, mask1, mask2, mask3) \
        x0 = (x0 | (x0 << 12)) & mask1; \
        x0 = (x0 | (x0 << 6 )) & mask2; \
        x0 = (x0 | (x0 << 3 )) & mask3;

#define inv_zero_padding(x0, mask0, mask1, mask2, mask_final) \
        x0 = (x0 | (x0 >> 3 )) & mask2; \
        x0 = (x0 | (x0 >> 6 )) & mask1; \
        x0 = (x0 | (x0 >> 12)) & mask0; \
        x0 = (x0 | (x0 >> 24)) & mask_final;

void GF_mul(GF c, const GF a, const GF b)
{
  uint64_t t[2] = {0,};
  uint64_t temp[4] = {0,};
  uint64_t sub[2] = {0,};

  sub[0] = a[0] ^ a[1];
  sub[1] = b[0] ^ b[1];

  poly64_mul(&a[1], &b[1], &temp[3], &temp[2]);
  poly64_mul(&a[0], &b[0], &temp[1], &temp[0]);

  poly64_mul(&sub[0], &sub[1], &t[1], &t[0]);
  temp[1] ^= t[0] ^ temp[0] ^ temp[2];
  temp[2] = t[0] ^ t[1] ^ temp[0] ^ temp[1] ^ temp[3];

  t[0] = temp[2] ^ ((temp[3] >> 57) ^ (temp[3] >> 62) ^ (temp[3] >> 63));

  c[1] = temp[1] ^ temp[3];
  c[1] ^= (temp[3] << 7) | (t[0] >> 57);
  c[1] ^= (temp[3] << 2) | (t[0] >> 62);
  c[1] ^= (temp[3] << 1) | (t[0] >> 63);

  c[0] = temp[0] ^ t[0];
  c[0] ^= (t[0] << 7);
  c[0] ^= (t[0] << 2);
  c[0] ^= (t[0] << 1);
}

void GF_mul_add(GF c, const GF a, const GF b)
{
  uint64_t t[2] = {0,};
  uint64_t temp[4] = {0,};
  uint64_t sub[2] = {0,};

  sub[0] = a[0] ^ a[1];
  sub[1] = b[0] ^ b[1];

  poly64_mul(&a[1], &b[1], &temp[3], &temp[2]);
  poly64_mul(&a[0], &b[0], &temp[1], &temp[0]);

  poly64_mul(&sub[0], &sub[1], &t[1], &t[0]);
  temp[1] ^= t[0] ^ temp[0] ^ temp[2];
  temp[2] = t[0] ^ t[1] ^ temp[0] ^ temp[1] ^ temp[3];

  t[0] = temp[2] ^ ((temp[3] >> 57) ^ (temp[3] >> 62) ^ (temp[3] >> 63));

  c[1] ^= temp[1] ^ temp[3];
  c[1] ^= (temp[3] << 7) | (t[0] >> 57);
  c[1] ^= (temp[3] << 2) | (t[0] >> 62);
  c[1] ^= (temp[3] << 1) | (t[0] >> 63);

  c[0] ^= temp[0] ^ t[0];
  c[0] ^= (t[0] << 7);
  c[0] ^= (t[0] << 2);
  c[0] ^= (t[0] << 1);
}

void GF_transposed_matmul(GF c, const GF a, const GF b[AIM2_NUM_BITS_FIELD])
{
  const uint64_t *a_ptr = a;
  const GF *b_ptr = b;

  uint64_t temp_c0 = 0;
  uint64_t temp_c1 = 0;
  uint64_t mask;
  for (size_t i = AIM2_NUM_WORDS_FIELD; i; --i, ++a_ptr)
  {
    uint64_t index = *a_ptr;
    for (size_t j = AIM2_NUM_BITS_WORD; j; j -= 8, index >>= 8, b_ptr += 8)
    {
      mask = -(index & 1);
      temp_c0 ^= (b_ptr[0][0] & mask);
      temp_c1 ^= (b_ptr[0][1] & mask);

      mask = -((index >> 1) & 1);
      temp_c0 ^= (b_ptr[1][0] & mask);
      temp_c1 ^= (b_ptr[1][1] & mask);

      mask = -((index >> 2) & 1);
      temp_c0 ^= (b_ptr[2][0] & mask);
      temp_c1 ^= (b_ptr[2][1] & mask);

      mask = -((index >> 3) & 1);
      temp_c0 ^= (b_ptr[3][0] & mask);
      temp_c1 ^= (b_ptr[3][1] & mask);

      mask = -((index >> 4) & 1);
      temp_c0 ^= (b_ptr[4][0] & mask);
      temp_c1 ^= (b_ptr[4][1] & mask);

      mask = -((index >> 5) & 1);
      temp_c0 ^= (b_ptr[5][0] & mask);
      temp_c1 ^= (b_ptr[5][1] & mask);

      mask = -((index >> 6) & 1);
      temp_c0 ^= (b_ptr[6][0] & mask);
      temp_c1 ^= (b_ptr[6][1] & mask);

      mask = -((index >> 7) & 1);
      temp_c0 ^= (b_ptr[7][0] & mask);
      temp_c1 ^= (b_ptr[7][1] & mask);
    }
  }
  c[0] = temp_c0;
  c[1] = temp_c1;
}

void GF_transposed_matmul_add(GF c, const GF a, const GF b[AIM2_NUM_BITS_FIELD])
{
  const uint64_t *a_ptr = a;
  const GF *b_ptr = b;

  uint64_t temp_c0 = 0;
  uint64_t temp_c1 = 0;
  uint64_t mask;
  for (size_t i = AIM2_NUM_WORDS_FIELD; i; --i, ++a_ptr)
  {
    uint64_t index = *a_ptr;
    for (size_t j = AIM2_NUM_BITS_WORD; j; j -= 8, index >>= 8, b_ptr += 8)
    {
      mask = -(index & 1);
      temp_c0 ^= (b_ptr[0][0] & mask);
      temp_c1 ^= (b_ptr[0][1] & mask);

      mask = -((index >> 1) & 1);
      temp_c0 ^= (b_ptr[1][0] & mask);
      temp_c1 ^= (b_ptr[1][1] & mask);

      mask = -((index >> 2) & 1);
      temp_c0 ^= (b_ptr[2][0] & mask);
      temp_c1 ^= (b_ptr[2][1] & mask);

      mask = -((index >> 3) & 1);
      temp_c0 ^= (b_ptr[3][0] & mask);
      temp_c1 ^= (b_ptr[3][1] & mask);

      mask = -((index >> 4) & 1);
      temp_c0 ^= (b_ptr[4][0] & mask);
      temp_c1 ^= (b_ptr[4][1] & mask);

      mask = -((index >> 5) & 1);
      temp_c0 ^= (b_ptr[5][0] & mask);
      temp_c1 ^= (b_ptr[5][1] & mask);

      mask = -((index >> 6) & 1);
      temp_c0 ^= (b_ptr[6][0] & mask);
      temp_c1 ^= (b_ptr[6][1] & mask);

      mask = -((index >> 7) & 1);
      temp_c0 ^= (b_ptr[7][0] & mask);
      temp_c1 ^= (b_ptr[7][1] & mask);
    }
  }
  c[0] ^= temp_c0;
  c[1] ^= temp_c1;
}

static void poly64_mul_s(uint64_t *z1, uint64_t *z0, uint64_t x, uint64_t y)
{
  // x_low
  uint32_t x4 = x >> 32;

  uint32_t x0 = x & mask_64;
  uint32_t x1 = (x0 >> 8) & mask0;
  uint32_t x2 = (x0 >> 16) & mask0;
  uint32_t x3 = (x0 >> 24) & mask0;
  x0 &= mask0;

  // x_high
  uint32_t x5 = (x4 >> 8) & mask0;
  uint32_t x6 = (x4 >> 16) & mask0;
  uint32_t x7 = (x4 >> 24) & mask0;
  x4 &= mask0;

  // y_low
  uint32_t y4 = y >> 32;

  uint32_t y0 = y & mask_64;
  uint32_t y1 = (y0 >> 8) & mask0;
  uint32_t y2 = (y0 >> 16) & mask0;
  uint32_t y3 = (y0 >> 24) & mask0;
  y0 &= mask0;

  // y_high
  uint32_t y5 = (y4 >> 8) & mask0;
  uint32_t y6 = (y4 >> 16) & mask0;
  uint32_t y7 = (y4 >> 24) & mask0;
  y4 &= mask0;

  // x padding
  zero_padding(x0, mask1, mask2, mask3);
  zero_padding(x1, mask1, mask2, mask3);
  zero_padding(x2, mask1, mask2, mask3);
  zero_padding(x3, mask1, mask2, mask3);
  zero_padding(x4, mask1, mask2, mask3);
  zero_padding(x5, mask1, mask2, mask3);
  zero_padding(x6, mask1, mask2, mask3);
  zero_padding(x7, mask1, mask2, mask3);

  // y padding
  zero_padding(y0, mask1, mask2, mask3);
  zero_padding(y1, mask1, mask2, mask3);
  zero_padding(y2, mask1, mask2, mask3);
  zero_padding(y3, mask1, mask2, mask3);
  zero_padding(y4, mask1, mask2, mask3);
  zero_padding(y5, mask1, mask2, mask3);
  zero_padding(y6, mask1, mask2, mask3);
  zero_padding(y7, mask1, mask2, mask3);

  //x0-3 * y0-3
  uint64_t a0 = ((uint64_t)x0 * (uint64_t)y0) & mask3_64;
  uint64_t a1 = ((((uint64_t)x0 * (uint64_t)y1) & mask3_64) ^
                 (((uint64_t)x1 * (uint64_t)y0) & mask3_64));
  a0 ^= (a1 << 32);
  a1 = a1 >> 32;
  a1 ^= ((((uint64_t)x0 * (uint64_t)y2) & mask3_64) ^
         (((uint64_t)x1 * (uint64_t)y1) & mask3_64) ^
         (((uint64_t)x2 * (uint64_t)y0) & mask3_64));

  uint64_t a2 = ((((uint64_t)x0 * (uint64_t)y3) & mask3_64) ^
                 (((uint64_t)x1 * (uint64_t)y2) & mask3_64) ^
                 (((uint64_t)x2 * (uint64_t)y1) & mask3_64) ^
                 (((uint64_t)x3 * (uint64_t)y0) & mask3_64));
  a1 ^= (a2 << 32);
  a2 = a2 >> 32;
  a2 ^= ((((uint64_t)x1 * (uint64_t)y3) & mask3_64) ^
         (((uint64_t)x2 * (uint64_t)y2) & mask3_64) ^
         (((uint64_t)x3 * (uint64_t)y1) & mask3_64));

  uint64_t a3 = ((((uint64_t)x2 * (uint64_t)y3) & mask3_64) ^
                 (((uint64_t)x3 * (uint64_t)y2) & mask3_64));
  a2 ^= (a3 << 32);
  a3 = a3 >> 32;

  a3 ^= ((uint64_t)x3 * (uint64_t)y3) & mask3_64;

  //x4-7 * y4-7
  uint64_t b0 = ((uint64_t)x4 * (uint64_t)y4) & mask3_64;
  uint64_t b1 = ((((uint64_t)x4 * (uint64_t)y5) & mask3_64) ^
                 (((uint64_t)x5 * (uint64_t)y4) & mask3_64));
  b0 ^= (b1 << 32);
  b1 = b1 >> 32;
  b1 ^= ((((uint64_t)x4 * (uint64_t)y6) & mask3_64) ^
         (((uint64_t)x5 * (uint64_t)y5) & mask3_64) ^
         (((uint64_t)x6 * (uint64_t)y4) & mask3_64));

  uint64_t b2 = ((((uint64_t)x4 * (uint64_t)y7) & mask3_64) ^
                 (((uint64_t)x5 * (uint64_t)y6) & mask3_64) ^
                 (((uint64_t)x6 * (uint64_t)y5) & mask3_64) ^
                 (((uint64_t)x7 * (uint64_t)y4) & mask3_64));
  b1 ^= (b2 << 32);
  b2 = b2 >> 32;
  b2 ^= ((((uint64_t)x5 * (uint64_t)y7) & mask3_64) ^
         (((uint64_t)x6 * (uint64_t)y6) & mask3_64) ^
         (((uint64_t)x7 * (uint64_t)y5) & mask3_64));

  uint64_t b3 = ((((uint64_t)x6 * (uint64_t)y7) & mask3_64) ^
                 (((uint64_t)x7 * (uint64_t)y6) & mask3_64));
  b2 ^= (b3 << 32);
  b3 = b3 >> 32;

  b3 ^= ((uint64_t)x7 * (uint64_t)y7) & mask3_64;

  //middle part
  x0 ^= x4;
  x1 ^= x5;
  x2 ^= x6;
  x3 ^= x7;

  y0 ^= y4;
  y1 ^= y5;
  y2 ^= y6;
  y3 ^= y7;

  uint64_t c0 = ((uint64_t)x0 * (uint64_t)y0) & mask3_64;
  uint64_t c1 = ((((uint64_t)x0 * (uint64_t)y1) & mask3_64) ^
                 (((uint64_t)x1 * (uint64_t)y0) & mask3_64));
  c0 ^= (c1 << 32);
  c1 = c1 >> 32;
  c1 ^= ((((uint64_t)x0 * (uint64_t)y2) & mask3_64) ^
         (((uint64_t)x1 * (uint64_t)y1) & mask3_64) ^
         (((uint64_t)x2 * (uint64_t)y0) & mask3_64));

  uint64_t c2 = ((((uint64_t)x0 * (uint64_t)y3) & mask3_64) ^
                 (((uint64_t)x1 * (uint64_t)y2) & mask3_64) ^
                 (((uint64_t)x2 * (uint64_t)y1) & mask3_64) ^
                 (((uint64_t)x3 * (uint64_t)y0) & mask3_64));
  c1 ^= (c2 << 32);
  c2 = c2 >> 32;
  c2 ^= ((((uint64_t)x1 * (uint64_t)y3) & mask3_64) ^
         (((uint64_t)x2 * (uint64_t)y2) & mask3_64) ^
         (((uint64_t)x3 * (uint64_t)y1) & mask3_64));

  uint64_t c3 = ((((uint64_t)x2 * (uint64_t)y3) & mask3_64) ^
                 (((uint64_t)x3 * (uint64_t)y2) & mask3_64));
  c2 ^= (c3 << 32);
  c3 = c3 >> 32;

  c3 ^= ((uint64_t)x3 * (uint64_t)y3) & mask3_64;

  c0 = c0 ^ a0 ^ b0;
  c1 = c1 ^ a1 ^ b1;
  c2 = c2 ^ a2 ^ b2;
  c3 = c3 ^ a3 ^ b3;

  a2 ^= c0;
  a3 ^= c1;
  b0 ^= c2;
  b1 ^= c3;

  // result inv_padding
  inv_zero_padding(a0, mask0_64, mask1_64, mask2_64, mask_final);
  inv_zero_padding(a1, mask0_64, mask1_64, mask2_64, mask_final);
  inv_zero_padding(a2, mask0_64, mask1_64, mask2_64, mask_final);
  inv_zero_padding(a3, mask0_64, mask1_64, mask2_64, mask_final);
  inv_zero_padding(b0, mask0_64, mask1_64, mask2_64, mask_final);
  inv_zero_padding(b1, mask0_64, mask1_64, mask2_64, mask_final);
  inv_zero_padding(b2, mask0_64, mask1_64, mask2_64, mask_final);
  inv_zero_padding(b3, mask0_64, mask1_64, mask2_64, mask_final);

  *z0 = a0 | (a1 << 16) | (a2 << 32) | (a3 << 48);
  *z1 = b0 | (b1 << 16) | (b2 << 32) | (b3 << 48);
}

void GF_mul_s(GF c, const GF a, const GF b)
{
  uint64_t t[2] = {0,};
  uint64_t temp[4] = {0,};

  poly64_mul_s(&temp[3], &temp[2], a[1], b[1]);
  poly64_mul_s(&temp[1], &temp[0], a[0], b[0]);

  poly64_mul_s(&t[1], &t[0], (a[0] ^ a[1]), (b[0] ^ b[1]));
  temp[1] ^= t[0] ^ temp[0] ^ temp[2];
  temp[2] = t[0] ^ t[1] ^ temp[0] ^ temp[1] ^ temp[3];

  t[0] = temp[2] ^ ((temp[3] >> 57) ^ (temp[3] >> 62) ^ (temp[3] >> 63));

  c[1] = temp[1] ^ temp[3];
  c[1] ^= (temp[3] << 7) | (t[0] >> 57);
  c[1] ^= (temp[3] << 2) | (t[0] >> 62);
  c[1] ^= (temp[3] << 1) | (t[0] >> 63);

  c[0] = temp[0] ^ t[0];
  c[0] ^= (t[0] << 7);
  c[0] ^= (t[0] << 2);
  c[0] ^= (t[0] << 1);
}

void GF_mul_add_s(GF c, const GF a, const GF b)
{
  uint64_t t[2] = {0,};
  uint64_t temp[4] = {0,};

  poly64_mul_s(&temp[3], &temp[2], a[1], b[1]);
  poly64_mul_s(&temp[1], &temp[0], a[0], b[0]);

  poly64_mul_s(&t[1], &t[0], (a[0] ^ a[1]), (b[0] ^ b[1]));
  temp[1] ^= t[0] ^ temp[0] ^ temp[2];
  temp[2] = t[0] ^ t[1] ^ temp[0] ^ temp[1] ^ temp[3];

  t[0] = temp[2] ^ ((temp[3] >> 57) ^ (temp[3] >> 62) ^ (temp[3] >> 63));

  c[1] ^= temp[1] ^ temp[3];
  c[1] ^= (temp[3] << 7) | (t[0] >> 57);
  c[1] ^= (temp[3] << 2) | (t[0] >> 62);
  c[1] ^= (temp[3] << 1) | (t[0] >> 63);

  c[0] ^= temp[0] ^ t[0];
  c[0] ^= (t[0] << 7);
  c[0] ^= (t[0] << 2);
  c[0] ^= (t[0] << 1);
}
