/*
 *  This file is part of the optimized implementation of the Picnic signature scheme.
 *  See the accompanying documentation for complete details.
 *
 *  The code is provided under the MIT license, see LICENSE for
 *  more details.
 *  SPDX-License-Identifier: MIT
 */

#ifndef PICNIC_INSTANCES_H
#define PICNIC_INSTANCES_H

#include "lowmc.h"
#include "picnic3_simulate.h"
#include "picnic.h"

#define SALT_SIZE 32
#define MAX_DIGEST_SIZE 64

typedef struct picnic_instance_t {
  lowmc_parameters_t lowmc;

  uint32_t digest_size;       /* bytes */
  uint32_t seed_size;         /* bytes */
  uint32_t num_rounds;        // T
  uint32_t num_opened_rounds; // u
  uint32_t num_MPC_parties;   // N

  uint32_t input_size;      /* bytes */
  uint32_t output_size;     /* bytes */
  uint32_t view_size;       /* bytes */
  uint32_t view_round_size; /* bits (per round) */

  uint32_t collapsed_challenge_size;       /* bytes */
  uint32_t unruh_without_input_bytes_size; /* bytes */
  uint32_t unruh_with_input_bytes_size;    /* bytes */
  uint32_t max_signature_size;             /* bytes */

  picnic_params_t params;

  struct {
    lowmc_implementation_f lowmc;
    lowmc_compute_aux_implementation_f lowmc_aux;
    lowmc_simulate_online_f lowmc_simulate_online;
  } impls;
} picnic_instance_t;

const picnic_instance_t* picnic_instance_get(picnic_params_t param);

PICNIC_EXPORT size_t PICNIC_CALLING_CONVENTION picnic_get_lowmc_block_size(picnic_params_t param);
PICNIC_EXPORT size_t PICNIC_CALLING_CONVENTION picnic_get_private_key_size(picnic_params_t param);
PICNIC_EXPORT size_t PICNIC_CALLING_CONVENTION picnic_get_public_key_size(picnic_params_t param);

#endif
