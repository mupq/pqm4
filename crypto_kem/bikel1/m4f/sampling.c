/* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0"
 *
 * Written by Nir Drucker, Shay Gueron and Dusan Kostic,
 * AWS Cryptographic Algorithms Group.
 *
 * Modification: 2023 Till Eifert
 *
 */

#include <assert.h>

#include "sampling.h"
#include "cleanup.h"

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

ret_t sample_indices_fisher_yates(OUT idx_t *out,
                             IN  size_t num_indices,
                             IN  idx_t max_idx_val,
                             IN OUT prf_state_t *prf_state)
{
    for (size_t i = num_indices; i-- > 0;) {
#define CWW_RAND_BYTES 4
        uint64_t rand = 0ULL;
        GUARD(get_shake256_prf_output((uint8_t *)&rand, prf_state, CWW_RAND_BYTES));
        rand *= (max_idx_val - i);

		// new index l is such that i <= l < max_idx_val
        uint32_t l = i + (uint32_t)(rand >> (CWW_RAND_BYTES * 8));

		// Loop over (the end of) the output array to determine if l is a duplicate
        uint32_t is_dup = 0;
        for (size_t j = i + 1; j < num_indices; ++j) {
            is_dup |= secure_cmp32(l, out[j]);
        }

		// if l is a duplicate out[i] gets i else out[i] gets l
		// mask is all 1 if l is a duplicate, all 0 else
        uint32_t mask = -is_dup;
        out[i] = (mask & i) ^ (~mask & l);
    }

    return SUCCESS;
}

ret_t generate_sparse_rep(OUT pad_r_t *r,
                          OUT idx_t *wlist,
                          IN OUT prf_state_t *prf_state)
{

  GUARD(sample_indices_fisher_yates(wlist, D, R_BITS, prf_state));

  secure_set_bits(r, 0, wlist, D);

  return SUCCESS;
}

ret_t generate_error_vector(OUT pad_e_t *e, IN const seed_t *seed)
{
  DEFER_CLEANUP(prf_state_t prf_state = {0}, clean_shake256_prf_state);

  GUARD(init_shake256_prf_state(&prf_state, MAX_PRF_INVOCATION, seed));

  idx_t wlist[T];
  GUARD(sample_indices_fisher_yates(wlist, T, N_BITS, &prf_state));

  // (e0, e1) hold bits 0..R_BITS-1 and R_BITS..2*R_BITS-1 of the error, resp.
  secure_set_bits(&e->val[0], 0, wlist, T);
  secure_set_bits(&e->val[1], R_BITS, wlist, T);

  // Clean the padding of the elements
  PE0_RAW(e)[R_BYTES - 1] &= LAST_R_BYTE_MASK;
  PE1_RAW(e)[R_BYTES - 1] &= LAST_R_BYTE_MASK;
  bike_memset(&PE0_RAW(e)[R_BYTES], 0, R_PADDED_BYTES - R_BYTES);
  bike_memset(&PE1_RAW(e)[R_BYTES], 0, R_PADDED_BYTES - R_BYTES);

  secure_clean((uint8_t *)wlist, sizeof(*wlist));

  return SUCCESS;
}
