/*! @file picnic_types.h
 *  @brief Datatypes used in the Picnic3 implementation.
 *
 *  This file is part of the reference implementation of the Picnic signature scheme.
 *  See the accompanying documentation for complete details.
 *
 *  The code is provided under the MIT license, see LICENSE for
 *  more details.
 *  SPDX-License-Identifier: MIT
 */

#ifndef PICNIC_TYPES_H
#define PICNIC_TYPES_H

#include "picnic3_impl.h"
/* Type definitions */
typedef struct randomTape_t {
  uint8_t tape[PICNIC_NUM_PARTIES][PICNIC_TAPE_SIZE];
  uint8_t aux_bits[PICNIC_AUX_SIZE];
  uint8_t parity_tapes[PICNIC_TAPE_SIZE];
  uint32_t pos;
  uint32_t aux_pos;
} randomTape_t;

typedef struct party_commitments_t {
  uint8_t hashes[PICNIC_NUM_PARTIES][PICNIC_DIGEST_SIZE];
} party_commitments_t;

typedef struct round_commitments_t {
  uint8_t hashes[PICNIC_NUM_ROUNDS][PICNIC_DIGEST_SIZE];
} round_commitments_t;

typedef struct msgs_t {
  uint8_t msgs[PICNIC_NUM_PARTIES][PICNIC_VIEW_SIZE]; // One for each player
  size_t pos;
  int unopened; // Index of the unopened party, or -1 if all parties opened (when signing)
} msgs_t;

#define UNUSED_PARAMETER(x) (void)(x)

#endif /* PICNIC_TYPES_H */
