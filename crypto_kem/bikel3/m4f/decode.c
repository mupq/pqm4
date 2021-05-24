/* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0"
 *
 * Written by Nir Drucker, Shay Gueron and Dusan Kostic,
 * AWS Cryptographic Algorithms Group.
 *
 * Modified by Ming-Shing Chen, Tung Chou and Markus Krausz.
 *
 * [1] The optimizations are based on the description developed in the paper:
 *     Drucker, Nir, and Shay Gueron. 2019. “A Toolbox for Software Optimization
 *     of QC-MDPC Code-Based Cryptosystems.” Journal of Cryptographic Engineering,
 *     January, 1–17. https://doi.org/10.1007/s13389-018-00200-4.
 *
 * [2] The decoder algorithm is the Black-Gray decoder in
 *     the early submission of CAKE (due to N. Sandrier and R Misoczki).
 *
 * [3] The analysis for the constant time implementation is given in
 *     Drucker, Nir, Shay Gueron, and Dusan Kostic. 2019.
 *     “On Constant-Time QC-MDPC Decoding with Negligible Failure Rate.”
 *     Cryptology EPrint Archive, 2019. https://eprint.iacr.org/2019/1289.
 *
 * [4] it was adapted to BGF in:
 *     Drucker, Nir, Shay Gueron, and Dusan Kostic. 2019.
 *     “QC-MDPC decoders with several shades of gray.”
 *     Cryptology EPrint Archive, 2019. To be published.
 *
 * [5] Chou, T.: QcBits: Constant-Time Small-Key Code-Based Cryptography.
 *     In: Gier-lichs, B., Poschmann, A.Y. (eds.) Cryptographic Hardware
 *     and Embedded Systems– CHES 2016. pp. 280–300. Springer Berlin Heidelberg,
 *     Berlin, Heidelberg (2016)
 *
 * [6] The rotate512_small funciton is a derivative of the code described in:
 *     Guimarães, Antonio, Diego F Aranha, and Edson Borin. 2019.
 *     “Optimized Implementation of QC-MDPC Code-Based Cryptography.”
 *     Concurrency and Computation: Practice and Experience 31 (18):
 *     e5089. https://doi.org/10.1002/cpe.5089.
 */

#include "decode.h"
#include "cleanup.h"
#include "ring_ops.h"
#include "utilities.h"

#include "run_config.h"


// Decoding (bit-flipping) parameter
#if defined(BG_DECODER)
#  if(LEVEL == 1)
#    define MAX_IT 3
#  elif(LEVEL == 3)
#    define MAX_IT 4
#  else
#    error "Level can only be 1/3"
#  endif
#elif defined(BGF_DECODER)
#  if(LEVEL == 1)
#    define MAX_IT 5
#  elif(LEVEL == 3)
#    define MAX_IT 5
#  else
#    error "Level can only be 1/3"
#  endif
#endif



#if defined(_USE_CSHIFT_)
#include "rotr_cshift.h"
#elif defined(_USE_CMOV_)
#include "rotate_cmov.h"
#else
// Duplicates the first R_BITS of the syndrome three times
// |------------------------------------------|
// |  Third copy | Second copy | first R_BITS |
// |------------------------------------------|
// This is required by the rotate functions.
_INLINE_ void dup(IN OUT syndrome_t *s)
{
  s->qw[R_QWORDS - 1] =
    (s->qw[0] << LAST_R_QWORD_LEAD) | (s->qw[R_QWORDS - 1] & LAST_R_QWORD_MASK);

  for(size_t i = 0; i < (2 * R_QWORDS) - 1; i++) {
    s->qw[R_QWORDS + i] =
      (s->qw[i] >> LAST_R_QWORD_TRAIL) | (s->qw[i + 1] << LAST_R_QWORD_LEAD);
  }
}
#endif


ret_t compute_syndrome(OUT syndrome_t *syndrome,
                       IN const pad_r_t *c0,
                       IN const mul_internal_t *th0)
{
  ring_mul_rep((pad_r_t*)syndrome->qw, c0, th0);  // use precomputed input transform of h0

#if defined(_USE_CSHIFT_)
  rotr_cshift_prepare((uint32_t*)syndrome);
#elif defined(_USE_CMOV_)
  rotate_cmov_prepare(syndrome);
#else
  dup(syndrome);
#endif

  return SUCCESS;
}


_INLINE_ ret_t recompute_syndrome(OUT syndrome_t *syndrome,
                                  IN const pad_r_t *c0,
                                  IN const mul_internal_t *th0,
                                  //IN const pad_r_t *pk,
                                  IN const mul_internal_t *pk,
                                  IN const e_t *e)
{
  DEFER_CLEANUP(pad_r_t tmp_c0 = {0}, pad_r_cleanup);
//  DEFER_CLEANUP(pad_r_t e0 = {0}, pad_r_cleanup);
//  DEFER_CLEANUP(pad_r_t e1 = {0}, pad_r_cleanup);

  //e1.val = e->val[1];
  tmp_c0.val = e->val[1];

  // tmp_c0 = pk * e1 + c0 + e0
  //ring_mul(&tmp_c0, &e1, pk);
  ring_mul_rep(&tmp_c0, &tmp_c0, pk);
  ring_add((r_t*)&tmp_c0, (r_t*)&tmp_c0, (const r_t*)c0);

  //e1.val = e->val[0];
  ring_add((r_t*)&tmp_c0, (r_t*)&e->val[0], (const r_t*)&tmp_c0);

  // Recompute the syndrome using the updated ciphertext
  GUARD(compute_syndrome(syndrome, &tmp_c0, th0));

  return SUCCESS;
}

_INLINE_ uint8_t get_threshold(IN const syndrome_t *s)
{
  bike_static_assert(sizeof(*s) >= sizeof(r_t), syndrome_is_large_enough);

  const uint32_t syndrome_weight = r_bits_vector_weight((const r_t *)s->qw);

  // The equations below are defined in BIKE's specification p. 16, Section 5.2
  uint32_t       thr  = THRESHOLD_COEFF0 + (THRESHOLD_COEFF1 * syndrome_weight);
  const uint32_t mask = secure_l32_mask(thr, THRESHOLD_MIN);
  thr = (u32_barrier(mask) & thr) | (u32_barrier(~mask) & THRESHOLD_MIN);

  DMSG("    Threshold: %d\n", thr);
  return thr;
}

// Use half-adder as described in [5].
_INLINE_ void bit_sliced_adder(OUT upc_t *upc,
                               IN OUT syndrome_t *rotated_syndrome,
                               IN const size_t    num_of_slices)
{
  // From cache-memory perspective this loop should be the outside loop
  for(size_t j = 0; j < num_of_slices; j++) {
    for(size_t i = 0; i < R_QWORDS; i++) {
      const uint64_t carry = (upc->slice[j].u.qw[i] & rotated_syndrome->qw[i]);
      upc->slice[j].u.qw[i] ^= rotated_syndrome->qw[i];
      rotated_syndrome->qw[i] = carry;
    }
  }
}

_INLINE_ void adder_size_k(OUT my_upc_t *upc,
                     IN const syndrome_t *rotated_syndrome,
                     IN const int offset,
                     IN const int k)
{
  // from cache-memory perspective this loop should be the OUTside loop
  int i, j;
  uint64_t carry, x, y, tmp;

  for(i = 0; i < R_QWORDS; i++) {
    carry = rotated_syndrome->qw[i];

    for(j = 0; j < k; j++) {
      x = upc->slice[offset + 0 + j].u.qw[i];
      y = upc->slice[offset + k + j].u.qw[i];
      tmp = x^y;
      upc->slice[offset + 0 + j].u.qw[i] = tmp ^ carry;
      carry = (tmp & carry) | (x & y);
    }

    upc->slice[offset + 0 + j].u.qw[i] = carry;
  }
}


_INLINE_ void adder_size_63(OUT my_upc_t *upc,
                          IN const syndrome_t *rotated_syndrome,
                          IN int offset, IN int bits_op2 )
{
  // from cache-memory perspective this loop should be the outside loop
  int i, j;
  uint64_t carry, x, y, tmp;

  for(i = 0; i < R_QWORDS; i++) {
    carry = rotated_syndrome->qw[i];

    for(j = 0; j < bits_op2; j++) {
      x = upc->slice[offset + 0 + j].u.qw[i];
      y = upc->slice[offset + 6 + j].u.qw[i];
      tmp = x^y;
      upc->slice[offset + 0 + j].u.qw[i] = tmp ^ carry;
      carry = (tmp & carry) | (x & y);
    }

    for(j = bits_op2; j < 6; j++) {
      x = upc->slice[offset + 0 + j].u.qw[i];
      upc->slice[offset + 0 + j].u.qw[i] = x ^ carry;
      carry &= x;
    }

    upc->slice[offset + 0 + j].u.qw[i] = carry;
  }
}


_INLINE_ void adder_size_31(OUT my_upc_t *upc,
                          IN const syndrome_t *rotated_syndrome,
                          IN int offset, IN int bits_op2 )
{
  // from cache-memory perspective this loop should be the outside loop
  int i, j;
  uint64_t carry, x, y, tmp;

  for(i = 0; i < R_QWORDS; i++) {
    carry = rotated_syndrome->qw[i];

    for(j = 0; j < bits_op2; j++) {
      x = upc->slice[offset + 0 + j].u.qw[i];
      y = upc->slice[offset + 5 + j].u.qw[i];
      tmp = x^y;
      upc->slice[offset + 0 + j].u.qw[i] = tmp ^ carry;
      carry = (tmp & carry) | (x & y);
    }

    for(j = bits_op2; j < 5; j++) {
      x = upc->slice[offset + 0 + j].u.qw[i];
      upc->slice[offset + 0 + j].u.qw[i] = x ^ carry;
      carry &= x;
    }

    upc->slice[offset + 0 + j].u.qw[i] = carry;
  }
}


#if 103 == D

static
void accumulate_unsat_syndrome(OUT my_upc_t *upc,
                               IN OUT syndrome_t *rotated_syndrome,
                               IN const idx_t *wlist_val,
                               IN const syndrome_t *syndrome)
{

//rotate_cmov_right(rotated_syndrome, syndrome,
//rotr_cshift(rotated_syndrome, syndrome,
//rotate_right(rotated_syndrome, syndrome,
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[0]);
adder_size_k(upc, rotated_syndrome, 0, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[1]);
adder_size_k(upc, rotated_syndrome, 1, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[2]);
adder_size_k(upc, rotated_syndrome, 0, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[3]);
adder_size_k(upc, rotated_syndrome, 2, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[4]);
adder_size_k(upc, rotated_syndrome, 3, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[5]);
adder_size_k(upc, rotated_syndrome, 2, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[6]);
adder_size_k(upc, rotated_syndrome, 0, 2);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[7]);
adder_size_k(upc, rotated_syndrome, 3, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[8]);
adder_size_k(upc, rotated_syndrome, 4, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[9]);
adder_size_k(upc, rotated_syndrome, 3, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[10]);
adder_size_k(upc, rotated_syndrome, 5, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[11]);
adder_size_k(upc, rotated_syndrome, 6, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[12]);
adder_size_k(upc, rotated_syndrome, 5, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[13]);
adder_size_k(upc, rotated_syndrome, 3, 2);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[14]);
adder_size_k(upc, rotated_syndrome, 0, 3);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[15]);
adder_size_k(upc, rotated_syndrome, 4, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[16]);
adder_size_k(upc, rotated_syndrome, 5, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[17]);
adder_size_k(upc, rotated_syndrome, 4, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[18]);
adder_size_k(upc, rotated_syndrome, 6, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[19]);
adder_size_k(upc, rotated_syndrome, 7, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[20]);
adder_size_k(upc, rotated_syndrome, 6, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[21]);
adder_size_k(upc, rotated_syndrome, 4, 2);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[22]);
adder_size_k(upc, rotated_syndrome, 7, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[23]);
adder_size_k(upc, rotated_syndrome, 8, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[24]);
adder_size_k(upc, rotated_syndrome, 7, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[25]);
adder_size_k(upc, rotated_syndrome, 9, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[26]);
adder_size_k(upc, rotated_syndrome, 10, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[27]);
adder_size_k(upc, rotated_syndrome, 9, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[28]);
adder_size_k(upc, rotated_syndrome, 7, 2);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[29]);
adder_size_k(upc, rotated_syndrome, 4, 3);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[30]);
adder_size_k(upc, rotated_syndrome, 0, 4);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[31]);
adder_size_k(upc, rotated_syndrome, 5, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[32]);
adder_size_k(upc, rotated_syndrome, 6, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[33]);
adder_size_k(upc, rotated_syndrome, 5, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[34]);
adder_size_k(upc, rotated_syndrome, 7, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[35]);
adder_size_k(upc, rotated_syndrome, 8, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[36]);
adder_size_k(upc, rotated_syndrome, 7, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[37]);
adder_size_k(upc, rotated_syndrome, 5, 2);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[38]);
adder_size_k(upc, rotated_syndrome, 8, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[39]);
adder_size_k(upc, rotated_syndrome, 9, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[40]);
adder_size_k(upc, rotated_syndrome, 8, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[41]);
adder_size_k(upc, rotated_syndrome, 10, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[42]);
adder_size_k(upc, rotated_syndrome, 11, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[43]);
adder_size_k(upc, rotated_syndrome, 10, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[44]);
adder_size_k(upc, rotated_syndrome, 8, 2);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[45]);
adder_size_k(upc, rotated_syndrome, 5, 3);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[46]);
adder_size_k(upc, rotated_syndrome, 9, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[47]);
adder_size_k(upc, rotated_syndrome, 10, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[48]);
adder_size_k(upc, rotated_syndrome, 9, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[49]);
adder_size_k(upc, rotated_syndrome, 11, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[50]);
adder_size_k(upc, rotated_syndrome, 12, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[51]);
adder_size_k(upc, rotated_syndrome, 11, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[52]);
adder_size_k(upc, rotated_syndrome, 9, 2);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[53]);
adder_size_k(upc, rotated_syndrome, 12, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[54]);
adder_size_k(upc, rotated_syndrome, 13, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[55]);
adder_size_k(upc, rotated_syndrome, 12, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[56]);
adder_size_k(upc, rotated_syndrome, 14, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[57]);
adder_size_k(upc, rotated_syndrome, 15, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[58]);
adder_size_k(upc, rotated_syndrome, 14, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[59]);
adder_size_k(upc, rotated_syndrome, 12, 2);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[60]);
adder_size_k(upc, rotated_syndrome, 9, 3);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[61]);
adder_size_k(upc, rotated_syndrome, 5, 4);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[62]);
adder_size_k(upc, rotated_syndrome, 0, 5);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[63]);
adder_size_k(upc, rotated_syndrome, 6, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[64]);
adder_size_k(upc, rotated_syndrome, 7, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[65]);
adder_size_k(upc, rotated_syndrome, 6, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[66]);
adder_size_k(upc, rotated_syndrome, 8, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[67]);
adder_size_k(upc, rotated_syndrome, 9, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[68]);
adder_size_k(upc, rotated_syndrome, 8, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[69]);
adder_size_k(upc, rotated_syndrome, 6, 2);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[70]);
adder_size_k(upc, rotated_syndrome, 9, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[71]);
adder_size_k(upc, rotated_syndrome, 10, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[72]);
adder_size_k(upc, rotated_syndrome, 9, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[73]);
adder_size_k(upc, rotated_syndrome, 11, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[74]);
adder_size_k(upc, rotated_syndrome, 12, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[75]);
adder_size_k(upc, rotated_syndrome, 11, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[76]);
adder_size_k(upc, rotated_syndrome, 9, 2);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[77]);
adder_size_k(upc, rotated_syndrome, 6, 3);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[78]);
adder_size_k(upc, rotated_syndrome, 10, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[79]);
adder_size_k(upc, rotated_syndrome, 11, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[80]);
adder_size_k(upc, rotated_syndrome, 10, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[81]);
adder_size_k(upc, rotated_syndrome, 12, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[82]);
adder_size_k(upc, rotated_syndrome, 13, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[83]);
adder_size_k(upc, rotated_syndrome, 12, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[84]);
adder_size_k(upc, rotated_syndrome, 10, 2);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[85]);
adder_size_k(upc, rotated_syndrome, 13, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[86]);
adder_size_k(upc, rotated_syndrome, 14, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[87]);
adder_size_k(upc, rotated_syndrome, 13, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[88]);
adder_size_k(upc, rotated_syndrome, 15, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[89]);
adder_size_k(upc, rotated_syndrome, 16, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[90]);
adder_size_k(upc, rotated_syndrome, 15, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[91]);
adder_size_k(upc, rotated_syndrome, 13, 2);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[92]);
adder_size_k(upc, rotated_syndrome, 10, 3);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[93]);
adder_size_k(upc, rotated_syndrome, 6, 4);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[94]);
adder_size_k(upc, rotated_syndrome, 11, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[95]);
adder_size_k(upc, rotated_syndrome, 12, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[96]);
adder_size_k(upc, rotated_syndrome, 11, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[97]);
adder_size_k(upc, rotated_syndrome, 13, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[98]);
adder_size_k(upc, rotated_syndrome, 14, 0);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[99]);
adder_size_k(upc, rotated_syndrome, 13, 1);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[100]);
adder_size_k(upc, rotated_syndrome, 11, 2);
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[101]);
adder_size_31(upc, rotated_syndrome, 6, 3); //31,7
rotr_cshift((uint32_t*)rotated_syndrome, (uint32_t*)syndrome, wlist_val[102]);
adder_size_63(upc, rotated_syndrome, 0, 6); //63,39

//for(int i=0;i<7;i++) { for(int j=0;j<R_QWORDS;j++) { _upc->slice[i].u.qw[j] = upc->slice[i].u.qw[j]; } }
for(int i = 0; i < R_QWORDS; i++) { upc->slice[7].u.qw[i] = 0; }
//bike_memset(upc, 0, sizeof(my_upc_t));

}

#else
error: un-supported: D
#endif



_INLINE_ void bit_slice_full_subtract(OUT upc_t *upc, IN uint8_t val)
{
  // Borrow
  uint64_t br[R_QWORDS] = {0};

  for(size_t j = 0; j < SLICES; j++) {

    const uint64_t lsb_mask = 0 - (val & 0x1);
    val >>= 1;

    // Perform a - b with c as the input/output carry
    // br = 0 0 0 0 1 1 1 1
    // a  = 0 0 1 1 0 0 1 1
    // b  = 0 1 0 1 0 1 0 1
    // -------------------
    // o  = 0 1 1 0 0 1 1 1
    // c  = 0 1 0 0 1 1 0 1
    //
    // o  = a^b^c
    //            _     __    _ _   _ _     _
    // br = abc + abc + abc + abc = abc + ((a+b))c

    for(size_t i = 0; i < R_QWORDS; i++) {
      const uint64_t a      = upc->slice[j].u.qw[i];
      const uint64_t b      = lsb_mask;
      const uint64_t tmp    = ((~a) & b & (~br[i])) | ((((~a) | b) & br[i]));
      upc->slice[j].u.qw[i] = a ^ b ^ br[i];
      br[i]                 = tmp;
    }
  }
}

// Calculate the Unsatisfied Parity Checks (UPCs) and update the errors
// vector (e) accordingly. In addition, update the black and gray errors vector
// with the relevant values.
_INLINE_ void find_err1(OUT e_t *e,
                        OUT e_t *black_e,
                        OUT e_t *gray_e,
                        IN OUT syndrome_t *          syndrome,
                        IN const compressed_idx_d_ar_t wlist,
                        IN const uint8_t               threshold)
{
  // This function uses the bit-slice-adder methodology of [5]:
  DEFER_CLEANUP(syndrome_t rotated_syndrome = {0}, syndrome_cleanup);

  //DEFER_CLEANUP(upc_t upc, upc_cleanup);
#if defined(_USE_CCM_IF_STM32F4_)
  uint8_t * ptr = 0x10000000;
  upc_t * upc = (upc_t*) ptr;
  my_upc_t * myupc = (my_upc_t*) ptr;
#else
  my_upc_t __myupc;
  upc_t *upc = (upc_t*)&__myupc;
  my_upc_t * myupc = &__myupc;
#endif

  for(uint32_t i = 0; i < N0; i++) {
    // UPC must start from zero at every iteration
    // 1) Right-rotate the syndrome for every secret key set bit index
    //    Then slice-add it to the UPC array.
    accumulate_unsat_syndrome(myupc, &rotated_syndrome, wlist[i].val , syndrome );

    // 2) Subtract the threshold from the UPC counters
    bit_slice_full_subtract(upc, threshold);

    // 3) Update the errors and the black errors vectors.
    //    The last slice of the UPC array holds the MSB of the accumulated values
    //    minus the threshold. Every zero bit indicates a potential error bit.
    //    The errors values are stored in the black array and xored with the
    //    errors Of the previous iteration.
    //const r_t *last_slice = &(upc.slice[SLICES - 1].u.r.val);
    const r_t *last_slice = &(upc->slice[SLICES - 1].u.r);
    for(size_t j = 0; j < R_BYTES; j++) {
      const uint8_t sum_msb  = (~last_slice->raw[j]);
      black_e->val[i].raw[j] = sum_msb;
      e->val[i].raw[j] ^= sum_msb;
    }

    // Ensure that the padding bits (upper bits of the last byte) are zero so
    // they will not be included in the multiplication and in the hash function.
    e->val[i].raw[R_BYTES - 1] &= LAST_R_BYTE_MASK;

    // 4) Calculate the gray error array by adding "DELTA" to the UPC array.
    //    For that we reuse the rotated_syndrome variable setting it to all "1".
    for(size_t l = 0; l < DELTA; l++) {
      bike_memset((uint8_t *)rotated_syndrome.qw, 0xff, R_BYTES);
      bit_sliced_adder(upc, &rotated_syndrome, SLICES);
    }

    // 5) Update the gray list with the relevant bits that are not
    //    set in the black list.
    for(size_t j = 0; j < R_BYTES; j++) {
      const uint8_t sum_msb = (~last_slice->raw[j]);
      gray_e->val[i].raw[j] = (~(black_e->val[i].raw[j])) & sum_msb;
    }
  }
}

// Recalculate the UPCs and update the errors vector (e) according to it
// and to the black/gray vectors.
_INLINE_ void find_err2(OUT e_t *e,
                        IN e_t * pos_e,
                        IN OUT syndrome_t *          syndrome,
                        IN const compressed_idx_d_ar_t wlist,
                        IN const uint8_t               threshold)
{
  DEFER_CLEANUP(syndrome_t rotated_syndrome = {0}, syndrome_cleanup);
  //DEFER_CLEANUP(upc_t upc, upc_cleanup);
#if defined(_USE_CCM_IF_STM32F4_)
  uint8_t * ptr = 0x10000000;
  upc_t * upc = (upc_t*) ptr;
  my_upc_t * myupc = (my_upc_t*) ptr;
#else
  my_upc_t __myupc;
  upc_t *upc = (upc_t*)&__myupc;
  my_upc_t * myupc = &__myupc;
#endif


  for(uint32_t i = 0; i < N0; i++) {
    // UPC must start from zero at every iteration
    // 1) Right-rotate the syndrome, for every index of a set bit in the secret
    // key. Then slice-add it to the UPC array.
    accumulate_unsat_syndrome(myupc, &rotated_syndrome, wlist[i].val , syndrome );

    // 2) Subtract the threshold from the UPC counters
    bit_slice_full_subtract(upc, threshold);

    // 3) Update the errors vector.
    //    The last slice of the UPC array holds the MSB of the accumulated values
    //    minus the threshold. Every zero bit indicates a potential error bit.
    //const r_t *last_slice = &(upc.slice[SLICES - 1].u.r.val);
    const r_t *last_slice = &(upc->slice[SLICES - 1].u.r);
    for(size_t j = 0; j < R_BYTES; j++) {
      const uint8_t sum_msb = (~last_slice->raw[j]);
      e->val[i].raw[j] ^= (pos_e->val[i].raw[j] & sum_msb);
    }

    // Ensure that the padding bits (upper bits of the last byte) are zero, so
    // they are not included in the multiplication, and in the hash function.
    e->val[i].raw[R_BYTES - 1] &= LAST_R_BYTE_MASK;
  }
}

ret_t decode(OUT e_t *e, IN const ct_t *ct, IN const sk_t *sk)
{
  DEFER_CLEANUP(e_t black_e = {0}, e_cleanup);
  DEFER_CLEANUP(e_t gray_e = {0}, e_cleanup);

  DEFER_CLEANUP(pad_r_t c0 = {0}, pad_r_cleanup);
  //DEFER_CLEANUP(pad_r_t h0 = {0}, pad_r_cleanup);
  DEFER_CLEANUP(mul_internal_t th0 = {0}, mul_internal_cleanup);
  //pad_r_t pk = {0};
  mul_internal_t pk = {0};

#if 0
printf("size:\n");
printf("e_t: %d\n",sizeof(e_t));
printf("pad_r_t: %d\n",sizeof(pad_r_t));
printf("mul_internal_t: %d\n",sizeof(mul_internal_t));
printf("syndrome_t: %d\n",sizeof(syndrome_t));
printf("upc_t: %d\n",sizeof(upc_t));
printf("my_upc_t: %d\n",sizeof(my_upc_t));
#endif

  // Pad ciphertext (c0), secret key (h0), and public key (h)
  c0.val = ct->c0;
  //h0.val = sk->bin[0];
  memcpy( &th0 , &sk->bin[0], sizeof(r_t) );
  //ring_mul_inputtransform( &th0 , &h0 );
  ring_mul_inputtransform( &th0 , (pad_r_t*)&th0 );
  //pk.val = sk->pk;
  memcpy( &pk , &(sk->pk) , sizeof(sk->pk) );
  ring_mul_inputtransform( &pk , (const pad_r_t *)&pk );

  DEFER_CLEANUP(syndrome_t s = {0}, syndrome_cleanup);
  DMSG("  Computing s.\n");
  GUARD(compute_syndrome(&s, &c0, &th0));
  //dup(&s);

  // Reset (init) the error because it is xored in the find_err functions.
  bike_memset(e, 0, sizeof(*e));

  for(uint32_t iter = 0; iter < MAX_IT; iter++) {
    const uint8_t threshold = get_threshold(&s);

    DMSG("    Iteration: %d\n", iter);
    DMSG("    Weight of e: %lu\n",
         r_bits_vector_weight(&e->val[0]) + r_bits_vector_weight(&e->val[1]));
    DMSG("    Weight of syndrome: %lu\n", r_bits_vector_weight((r_t *)s.qw));

    find_err1(e, &black_e, &gray_e, &s, sk->wlist, threshold);
    GUARD(recompute_syndrome(&s, &c0, &th0, &pk, e));
#if defined(BGF_DECODER)
    if(iter >= 1) {
      continue;
    }
#endif
    DMSG("    Weight of e: %lu\n",
         r_bits_vector_weight(&e->val[0]) + r_bits_vector_weight(&e->val[1]));
    DMSG("    Weight of syndrome: %lu\n", r_bits_vector_weight((r_t *)s.qw));

    find_err2(e, &black_e, &s, sk->wlist, ((D + 1) / 2) + 1);
    GUARD(recompute_syndrome(&s, &c0, &th0, &pk, e));

    DMSG("    Weight of e: %lu\n",
         r_bits_vector_weight(&e->val[0]) + r_bits_vector_weight(&e->val[1]));
    DMSG("    Weight of syndrome: %lu\n", r_bits_vector_weight((r_t *)s.qw));

    find_err2(e, &gray_e, &s, sk->wlist, ((D + 1) / 2) + 1);
    GUARD(recompute_syndrome(&s, &c0, &th0, &pk, e));
  }

  if(r_bits_vector_weight((r_t *)s.qw) > 0) {
    BIKE_ERROR(E_DECODING_FAILURE);
  }

  return SUCCESS;
}
