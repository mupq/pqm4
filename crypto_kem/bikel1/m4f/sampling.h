/* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0"
 *
 * Written by Nir Drucker, Shay Gueron and Dusan Kostic,
 * AWS Cryptographic Algorithms Group.
 *
 * Modification: 2023 Till Eifert
 *
 */

#pragma once
#include "defs.h"

#if defined(USE_NIST_RAND)
 #include "randombytes.h"
#else
#  include <stdlib.h>
#endif

#include "shake_prf.h"
#include "utilities.h"

typedef enum
{
  NO_RESTRICTION = 0,
  MUST_BE_ODD    = 1
} must_be_odd_t;

void get_seeds(OUT seeds_t *seeds);

ret_t generate_sparse_rep(OUT pad_r_t *r,
                          OUT idx_t *wlist,
                          IN OUT prf_state_t *prf_state);

ret_t generate_error_vector(OUT pad_e_t *e, IN const seed_t *seed);

// When "a" is considered as part of some larger array, then a_first_pos
// is the start position of "a" in the large array.
void secure_set_bits(OUT pad_r_t *r,
                     IN size_t    first_pos,
                     IN const idx_t *wlist,
                     IN size_t       w_size);
