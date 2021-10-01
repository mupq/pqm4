/*
 *  This file is part of the optimized implementation of the Picnic signature scheme.
 *  See the accompanying documentation for complete details.
 *
 *  The code is provided under the MIT license, see LICENSE for
 *  more details.
 *  SPDX-License-Identifier: MIT
 */

#ifndef LOWMC_PARS_H
#define LOWMC_PARS_H

#include <stddef.h>

#include "mzd_additional.h"

typedef mzd_local_t lowmc_key_t;

#define MAX_LOWMC_BLOCK_SIZE 32
#define MAX_LOWMC_BLOCK_SIZE_BITS (MAX_LOWMC_BLOCK_SIZE * 8)
#define MAX_LOWMC_KEY_SIZE MAX_LOWMC_BLOCK_SIZE
#define MAX_LOWMC_KEY_SIZE_BITS (MAX_LOWMC_KEY_SIZE * 8)
#define MAX_LOWMC_ROUNDS 38

/**
 * LowMC parameters
 */
typedef struct {
  unsigned int m;
  unsigned int n;
  unsigned int r;
  unsigned int k;
} lowmc_parameters_t;

/**
 * LowMC round with full Sblox layer
 */
typedef struct {
  const mzd_local_t* k_matrix;
  const mzd_local_t* l_matrix;
  const mzd_local_t* li_matrix;
  const mzd_local_t* constant;
} lowmc_round_t;

/**
 * LowMC definition with full Sbox layer
 */
typedef struct {
  const mzd_local_t* k0_matrix;  // K_0
  const mzd_local_t* ki0_matrix; // inverse of K_0
  const lowmc_round_t* rounds;
} lowmc_t;

#endif
