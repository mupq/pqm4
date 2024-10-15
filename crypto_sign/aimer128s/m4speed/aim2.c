// SPDX-License-Identifier: MIT

#include "aim2.h"
#include "field.h"
#include "hash.h"
#include "params.h"
#include <stddef.h>
#include <stdint.h>

// inverse Mersenne S-box with e1 = 49
// (2 ^ 49 - 1) ^ (-1) mod (2 ^ 128 - 1) = 0xb6b6d6d6dadb5b5b6b6b6d6dadadb5b5
// b6b6d6d 6 d a d b5 b5 b6 b6b6d6d a d a d b5 b5
void GF_exp_invmer_e_1(GF out, const GF in)
{
  size_t i;
  GF t1 = {0,}, t2 = {0,};
  GF table_5 = {0,}, table_6 = {0,};
  GF table_a = {0,}, table_b = {0,}, table_d = {0,};

  // t1 = in ^ 4
  GF_sqr_s(table_d, in);
  GF_sqr_s(t1, table_d);

  // table_5 = in ^ 5
  GF_mul_s(table_5, t1, in);
  // table_6 = in ^ 6
  GF_mul_s(table_6, table_5, in);
  // table_a = in ^ 10 = (in ^ 5) ^ 2
  GF_sqr_s(table_a, table_5);
  // table_b = in ^ 11
  GF_mul_s(table_b, table_a, in);
  // table_d = in ^ 13
  GF_mul_s(table_d, table_b, table_d);

  // table_b = in ^ (0xb6), table_5 = in ^ (0xb5)
  GF_sqr_s(t1, table_b);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(table_b, t1, table_6);
  GF_mul_s(table_5, t1, table_5);

  // t1 = in ^ (0xb6b6)
  GF_sqr_s(t1, table_b);
  for (i = 1; i < 8; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(t1, t1, table_b);

  // t1 = in ^ (0xb6b6 d)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_d);

  // t1 = in ^ (0xb6b6d 6)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_6);

  // t2 = in ^ (0xb6b6d6 d)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t2, t1, table_d);

  // t1 = in ^ (0xb6b6d6d 6)
  GF_sqr_s(t1, t2);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_6);

  // t1 = in ^ (0xb6b6d6d6 d)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_d);

  // t1 = in ^ (0xb6b6d6d6d a)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_a);

  // t1 = in ^ (0xb6b6d6d6da d)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_d);

  // t1 = in ^ (0xb6b6d6d6dad b5)
  for (i = 0; i < 8; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(t1, t1, table_5);

  // t1 = in ^ (0xb6b6d6d6dadb5 b5)
  for (i = 0; i < 8; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(t1, t1, table_5);

  // t1 = in ^ (0xb6b6d6d6dadb5b5 b6)
  for (i = 0; i < 8; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(t1, t1, table_b);

  // t1 = in ^ (0xb6b6d6d6dadb5b5b6 b6b6d6d)
  for (i = 0; i < 28; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(t1, t1, t2);

  // t1 = in ^ (0xb6b6d6d6dadb5b5b6b6b6d6d a)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_a);

  // t1 = in ^ (0xb6b6d6d6dadb5b5b6b6b6d6da d)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_d);

  // t1 = in ^ (0xb6b6d6d6dadb5b5b6b6b6d6dad a)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_a);

  // t1 = in ^ (0xb6b6d6d6dadb5b5b6b6b6d6dada d)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_d);

  // t1 = in ^ (0xb6b6d6d6dadb5b5b6b6b6d6dadad b5)
  for (i = 0; i < 8; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(t1, t1, table_5);

  // t1 = in ^ (0xb6b6d6d6dadb5b5b6b6b6d6dadadb5 b5)
  for (i = 0; i < 8; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(out, t1, table_5);
}

// inverse Mersenne S-box with e2 = 91
// (2 ^ 91 - 1) ^ (-1) mod (2 ^ 128 - 1) = 0xb6db5b6dadb6dadb6d6db6d6db6b6db5
// b6d b5 b6d a d b6d a d b6d 6 d b6d 6 d b6 b6d b5
void GF_exp_invmer_e_2(GF out, const GF in)
{
  size_t i;
  GF t1 = {0,}, t2 = {0,}, t3 = {0,};
  GF table_5 = {0,}, table_6 = {0,};
  GF table_a = {0,}, table_b = {0,}, table_d = {0,};

  // t1 = in ^ 4
  GF_sqr_s(table_d, in);
  GF_sqr_s(t1, table_d);

  // table_5 = in ^ 5
  GF_mul_s(table_5, t1, in);
  // table_6 = in ^ 6
  GF_mul_s(table_6, table_5, in);
  // table_a = in ^ 10 = (in ^ 5) ^ 2
  GF_sqr_s(table_a, table_5);
  // table_b = in ^ 11
  GF_mul_s(table_b, table_a, in);
  // table_d = in ^ 13
  GF_mul_s(table_d, table_b, table_d);

  // t3 = in ^ (0xb6), table_b = in ^ (0xb5)
  GF_sqr_s(t1, table_b);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(table_b, t1, table_5);
  GF_mul_s(t3, t1, table_6);

  // t2 = in ^ (0xb6 d)
  GF_sqr_s(t1, t3);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t2, t1, table_d);

  // t1 = in ^ (0xb6d b5)
  GF_sqr_s(t1, t2);
  for (i = 1; i < 8; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(t1, t1, table_b);

  // t1 = in ^ (0xb6db5 b6d)
  for (i = 0; i < 12; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(t1, t1, t2);

  // t1 = in ^ (0xb6db5b6d a)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_a);

  // t1 = in ^ (0xb6db5b6da d)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_d);

  // t1 = in ^ (0xb6db5b6dad b6d)
  for (i = 0; i < 12; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(t1, t1, t2);

  // t1 = in ^ (0xb6db5b6dadb6d a)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_a);

  // t1 = in ^ (0xb6db5b6dadb6da d)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_d);

  // t1 = in ^ (0xb6db5b6dadb6dad b6d)
  for (i = 0; i < 12; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(t1, t1, t2);

  // t1 = in ^ (0xb6db5b6dadb6dadb6d 6)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_6);

  // t1 = in ^ (0xb6db5b6dadb6dadb6d6 d)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_d);

  // t1 = in ^ (0xb6db5b6dadb6dadb6d6d b6d)
  for (i = 0; i < 12; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(t1, t1, t2);

  // t1 = in ^ (0xb6db5b6dadb6dadb6d6db6d 6)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_6);

  // t1 = in ^ (0xb6db5b6dadb6dadb6d6db6d6 d)
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_sqr_s(t1, t1);
  GF_mul_s(t1, t1, table_d);

  // t1 = in ^ (0xb6db5b6dadb6dadb6d6db6d6d b6)
  for (i = 0; i < 8; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(t1, t1, t3);

  // t1 = in ^ (0xb6db5b6dadb6dadb6d6db6d6db6 b6d)
  for (i = 0; i < 12; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(t1, t1, t2);

  // out = in ^ (0xb6db5b6dadb6dadb6d6db6d6db6b6d b5)
  for (i = 0; i < 8; i++)
  {
    GF_sqr_s(t1, t1);
  }
  GF_mul_s(out, t1, table_b);
}

// Mersenne exponentiation with e_star = 3
void GF_exp_mer_e_star(GF out, const GF in)
{
  GF t1 = {0,};

  // t1 = a ^ (2 ^ 2 - 1)
  GF_sqr_s(t1, in);
  GF_mul_s(t1, t1, in);

  // out = a ^ (2 ^ 3 - 1)
  GF_sqr_s(t1, t1);
  GF_mul_s(out, t1, in);
}

void generate_matrices_L_and_U(
        GF matrix_L[AIM2_NUM_INPUT_SBOX][AIM2_NUM_BITS_FIELD],
        GF matrix_U[AIM2_NUM_INPUT_SBOX][AIM2_NUM_BITS_FIELD],
        GF vector_b,
        const uint8_t iv[AIM2_IV_SIZE])
{
  uint8_t buf[AIM2_NUM_BYTES_FIELD];
  uint64_t ormask, lmask, umask;
  hash_instance ctx;
  GF temp = {0,};

  // initialize hash
  hash_init(&ctx);
  hash_update(&ctx, iv, AIM2_IV_SIZE);
  hash_final(&ctx);

  for (size_t num = 0; num < AIM2_NUM_INPUT_SBOX; num++)
  {
    for (size_t row = 0; row < AIM2_NUM_BITS_FIELD; row++)
    {
      hash_squeeze(&ctx, buf, AIM2_NUM_BYTES_FIELD);
      GF_from_bytes(temp, buf);

      ormask = ((uint64_t)1) << (row % 64);
      lmask = ((uint64_t)-1) << (row % 64);
      umask = ~lmask;

      size_t inter = row / 64;
      size_t col_word;
      for (col_word = 0; col_word < inter; col_word++)
      {
        // L is zero, U is full
        matrix_L[num][row][col_word] = 0;
        matrix_U[num][row][col_word] = temp[col_word];
      }
      matrix_L[num][row][inter] = (temp[inter] & lmask) | ormask;
      matrix_U[num][row][inter] = (temp[inter] & umask) | ormask;
      for (col_word = inter + 1; col_word < AIM2_NUM_WORDS_FIELD; col_word++)
      {
        // L is full, U is zero
        matrix_L[num][row][col_word] = temp[col_word];
        matrix_U[num][row][col_word] = 0;
      }
    }
  }

  hash_squeeze(&ctx, (uint8_t *)vector_b, AIM2_NUM_BYTES_FIELD);
  hash_ctx_release(&ctx);
}

void generate_matrix_LU(GF matrix_A[AIM2_NUM_INPUT_SBOX][AIM2_NUM_BITS_FIELD],
                        GF vector_b,
                        const uint8_t iv[AIM2_IV_SIZE])
{
  GF matrix_L[AIM2_NUM_INPUT_SBOX][AIM2_NUM_BITS_FIELD];
  GF matrix_U[AIM2_NUM_INPUT_SBOX][AIM2_NUM_BITS_FIELD];

  generate_matrices_L_and_U(matrix_L, matrix_U, vector_b, iv);

  for (size_t num = 0; num < AIM2_NUM_INPUT_SBOX; num++)
  {
    for (size_t i = 0; i < AIM2_NUM_BITS_FIELD; i++)
    {
      GF_transposed_matmul(matrix_A[num][i], matrix_U[num][i],
                           (const GF *)matrix_L[num]);
    }
  }
}

void aim2(uint8_t ct[AIM2_NUM_BYTES_FIELD],
          const uint8_t pt[AIM2_NUM_BYTES_FIELD],
          const uint8_t iv[AIM2_IV_SIZE])
{
  GF matrix_L[AIM2_NUM_INPUT_SBOX][AIM2_NUM_BITS_FIELD];
  GF matrix_U[AIM2_NUM_INPUT_SBOX][AIM2_NUM_BITS_FIELD];
  GF vector_b = {0,};

  GF state[AIM2_NUM_INPUT_SBOX];
  GF pt_GF = {0,}, ct_GF = {0,};
  GF_from_bytes(pt_GF, pt);

  // generate random matrix
  generate_matrices_L_and_U(matrix_L, matrix_U, vector_b, iv);

  // linear component: constant addition
  GF_add(state[0], pt_GF, aim2_constants[0]);
  GF_add(state[1], pt_GF, aim2_constants[1]);

  // non-linear component: inverse Mersenne S-box
  GF_exp_invmer_e_1(state[0], state[0]);
  GF_exp_invmer_e_2(state[1], state[1]);

  // linear component: affine layer
  GF_transposed_matmul(state[0], state[0], (const GF *)matrix_U[0]);
  GF_transposed_matmul(state[0], state[0], (const GF *)matrix_L[0]);

  GF_transposed_matmul(state[1], state[1], (const GF *)matrix_U[1]);
  GF_transposed_matmul(state[1], state[1], (const GF *)matrix_L[1]);

  GF_add(state[0], state[0], state[1]);
  GF_add(state[0], state[0], vector_b);

  // non-linear component: Mersenne S-box
  GF_exp_mer_e_star(state[0], state[0]);

  // linear component: feed-forward
  GF_add(ct_GF, state[0], pt_GF);

  GF_to_bytes(ct, ct_GF);
}

void aim2_sbox_outputs(GF sbox_outputs[AIM2_NUM_INPUT_SBOX], const GF pt)
{
  // linear component: constant addition
  GF_add(sbox_outputs[0], pt, aim2_constants[0]);
  GF_add(sbox_outputs[1], pt, aim2_constants[1]);

  // non-linear component: inverse Mersenne S-box
  GF_exp_invmer_e_1(sbox_outputs[0], sbox_outputs[0]);
  GF_exp_invmer_e_2(sbox_outputs[1], sbox_outputs[1]);
}
