/* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0"
 *
 * Written by Nir Drucker, Shay Gueron and Dusan Kostic,
 * AWS Cryptographic Algorithms Group.
 */

#include <assert.h>

#include "sampling.h"

void get_seeds(OUT seeds_t *seeds)
{
#if defined(USE_NIST_RAND)
  randombytes((uint8_t *)seeds, NUM_OF_SEEDS * sizeof(seed_t));
#else
  for(uint32_t i = 0; i < NUM_OF_SEEDS; ++i) {
    for(uint32_t j = 0; j < sizeof(seed_t); ++j) {
      seeds->seed[i].raw[j] = rand();
    }
  }
#endif
  for(uint32_t i = 0; i < NUM_OF_SEEDS; ++i) {
    print("s: ", (uint64_t *)&seeds->seed[i], SIZEOF_BITS(seed_t));
  }
}

// BSR returns ceil(log2(val))
_INLINE_ uint8_t bit_scan_reverse_vartime(IN uint64_t val)
{
  // index is always smaller than 64
  uint8_t index = 0;

  while(val != 0) {
    val >>= 1;
    index++;
  }

  return index;
}

_INLINE_ ret_t get_rand_mod_len(OUT uint32_t *    rand_pos,
                                IN const uint32_t len,
                                IN OUT aes_ctr_prf_state_t *prf_state)
{
  const uint64_t mask = MASK(bit_scan_reverse_vartime(len));

  do {
    // Generate a 32 bits (pseudo) random value.
    // This can be optimized to take only 16 bits.
    GUARD(aes_ctr_prf((uint8_t *)rand_pos, prf_state, sizeof(*rand_pos)));

    // Mask relevant bits only
    (*rand_pos) &= mask;

    // Break if a number that is smaller than len is found
    if((*rand_pos) < len) {
      break;
    }

  } while(1 == 1);

  return SUCCESS;
}

_INLINE_ void make_odd_weight(IN OUT r_t *r)
{
  if(((r_bits_vector_weight(r) % 2) == 1)) {
    // Already odd
    return;
  }

  r->raw[0] ^= 1;
}

// Returns an array of r pseudorandom bits.
// No restrictions exist for the top or bottom bits.
// If the generation requires an odd number, then set must_be_odd=1.
// The function uses the provided prf context.
ret_t sample_uniform_r_bits_with_fixed_prf_context(
  OUT r_t *r,
  IN OUT aes_ctr_prf_state_t *prf_state,
  IN const must_be_odd_t      must_be_odd)
{
  // Generate random data
  GUARD(aes_ctr_prf(r->raw, prf_state, R_BYTES));

  // Mask upper bits of the MSByte
  r->raw[R_BYTES - 1] &= MASK(R_BITS + 8 - (R_BYTES * 8));

  if(must_be_odd == MUST_BE_ODD) {
    make_odd_weight(r);
  }

  return SUCCESS;
}

_INLINE_ int is_new(IN const idx_t *wlist, IN const size_t ctr)
{
  for(size_t i = 0; i < ctr; i++) {
    if(wlist[i] == wlist[ctr]) {
      return 0;
    }
  }

  return 1;
}

ret_t generate_indices_mod_z(OUT idx_t *     out,
                             IN const size_t num_indices,
                             IN const size_t z,
                             IN OUT aes_ctr_prf_state_t *prf_state)
{
  size_t ctr = 0;

  // Generate num_indices unique (pseudo) random numbers modulo z
  do {
    GUARD(get_rand_mod_len(&out[ctr], z, prf_state));
    ctr += is_new(out, ctr);
  } while(ctr < num_indices);

  return SUCCESS;
}

// Returns an array of r pseudorandom bits.
// No restrictions exist for the top or bottom bits.
// If the generation requires an odd number, then set must_be_odd = MUST_BE_ODD
ret_t sample_uniform_r_bits(OUT r_t *r,
                            IN const seed_t *      seed,
                            IN const must_be_odd_t must_be_odd)
{
  // For the seedexpander
  DEFER_CLEANUP(aes_ctr_prf_state_t prf_state = {0}, aes_ctr_prf_state_cleanup);

  GUARD(init_aes_ctr_prf_state(&prf_state, MAX_AES_INVOKATION, seed));

  GUARD(sample_uniform_r_bits_with_fixed_prf_context(r, &prf_state, must_be_odd));

  return SUCCESS;
}

ret_t generate_sparse_rep(OUT pad_r_t *r,
                          OUT idx_t *wlist,
                          IN OUT aes_ctr_prf_state_t *prf_state)
{

  GUARD(generate_indices_mod_z(wlist, D, R_BITS, prf_state));

  secure_set_bits(r, 0, wlist, D);

  return SUCCESS;
}

ret_t generate_error_vector(OUT pad_e_t *e, IN const seed_t *seed)
{
  DEFER_CLEANUP(aes_ctr_prf_state_t prf_state = {0}, aes_ctr_prf_state_cleanup);

  GUARD(init_aes_ctr_prf_state(&prf_state, MAX_AES_INVOKATION, seed));

  idx_t wlist[T];
  GUARD(generate_indices_mod_z(wlist, T, N_BITS, &prf_state));

  // (e0, e1) hold bits 0..R_BITS-1 and R_BITS..2*R_BITS-1 of the error, resp.
  secure_set_bits(&e->val[0], 0, wlist, T);
  secure_set_bits(&e->val[1], R_BITS, wlist, T);

  // Clean the padding of the elements
  PE0_RAW(e)[R_BYTES - 1] &= LAST_R_BYTE_MASK;
  PE1_RAW(e)[R_BYTES - 1] &= LAST_R_BYTE_MASK;
  bike_memset(&PE0_RAW(e)[R_BYTES], 0, R_PADDED_BYTES - R_BYTES);
  bike_memset(&PE1_RAW(e)[R_BYTES], 0, R_PADDED_BYTES - R_BYTES);

  return SUCCESS;
}
