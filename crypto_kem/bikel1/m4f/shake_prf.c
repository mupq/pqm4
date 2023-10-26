/* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0"
 *
 * This code is maintained by Nir Drucker, Shay Gueron and Dusan Kostic,
 * AWS Cryptographic Algorithms Group.
 *
 * Modification: 2023 Till Eifert
 *
 */

#include "cleanup.h"
#include "shake_prf.h"
#include "utilities.h"

ret_t init_shake256_prf_state(OUT shake256_prf_state_t *s, IN size_t max_num_invocations,
                     IN const seed_t *seed)
{
  if(0 == max_num_invocations) {
    BIKE_ERROR(E_SHAKE_PRF_INIT_FAIL);
  }

  // Initialize the SHAKE state with the given seed.
  shake256_absorb(&s->s, seed->raw, sizeof(*seed));

  // Initialize the PRF parameters.
  s->curr_pos_in_buffer = SHAKE256_RATE;
  s->rem_invocations    = max_num_invocations;

  return SUCCESS;
}

ret_t get_shake256_prf_output(OUT uint8_t *out, IN OUT shake256_prf_state_t *s,
                     IN size_t len)
{
  // Check if the maximum number of SHAKE invocations is reached.
  if (s->rem_invocations == 0)
  {
    BIKE_ERROR(E_SHAKE_OVER_USED);
  }

  // When |len| is smaller then use what's left in the buffer,
  // there is no need for additional SHAKE256 invocations.
  if((len + s->curr_pos_in_buffer) <= SHAKE256_RATE) {
    bike_memcpy(out, &s->buffer[s->curr_pos_in_buffer], len);
    s->curr_pos_in_buffer += len;

    return SUCCESS;
  }

  // Generate one block (SHAKE256_RATE bytes) of random data with SHAKE256.
  shake256_squeezeblocks(s->buffer, 1, &s->s);

  // Copy |len| bytes to the output, set the new buffer position indicator,
  // and update the remaining allowable number of SHAKE invocations.
  bike_memcpy(out, s->buffer, len);
  s->curr_pos_in_buffer = len;
  s->rem_invocations -= 1;

  return SUCCESS;
}

void clean_shake256_prf_state(IN OUT shake256_prf_state_t *s)
{
  secure_clean((uint8_t*)s, sizeof(*s));
}
