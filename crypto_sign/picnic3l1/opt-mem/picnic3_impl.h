/*! @file picnic3_impl.h
 *  @brief This is the main implementation file of the signature scheme for
 *  the Picnic3 parameter sets.
 *
 *  This file is part of the reference implementation of the Picnic signature scheme.
 *  See the accompanying documentation for complete details.
 *
 *  The code is provided under the MIT license, see LICENSE for
 *  more details.
 *  SPDX-License-Identifier: MIT
 */

#ifndef PICNIC3_IMPL_H
#define PICNIC3_IMPL_H

#include <stdint.h>
#include <stddef.h>
#include "picnic_params.h"

typedef struct proof2_t {
  uint16_t unOpenedIndex; // P[t], index of the party that is not opened.
  uint8_t
      seedInfo[PICNIC_SEED_SIZE *
               PICNIC_PARTY_TREE_MAX_REVEALED_NODES]; // Information required to compute the tree
                                                      // with seeds of of all opened parties (log)
  size_t seedInfoLen;                                 // Length of seedInfo buffer
  uint8_t aux[PICNIC_VIEW_SIZE];    // Last party's correction bits; NULL if P[t] == N-1
  uint8_t C[PICNIC_DIGEST_SIZE];    // Commitment to preprocessing step of unopened party
  uint8_t input[PICNIC_INPUT_SIZE]; // Masked input used in online execution
  uint8_t msgs[PICNIC_VIEW_SIZE];   // Broadcast messages of unopened party P[t]
} proof2_t;

typedef struct signature2_t {
  uint8_t salt[PICNIC_SALT_SIZE];
  uint8_t iSeedInfo[PICNIC_SEED_SIZE *
                    PICNIC_ROUND_TREE_MAX_REVEALED_NODES]; // Info required to recompute the
                                                           // tree of all initial seeds
  size_t iSeedInfoLen;
  uint8_t cvInfo[PICNIC_DIGEST_SIZE *
                 PICNIC_ROUND_TREE_MAX_REVEALED_NODES]; // Info required to check commitments to
                                                        // views (reconstruct Merkle tree)
  size_t cvInfoLen;
  uint8_t challenge[PICNIC_DIGEST_SIZE]; // output of HCP
  uint16_t challengeC[PICNIC_NUM_OPENED_ROUNDS];
  uint16_t challengeP[PICNIC_NUM_OPENED_ROUNDS];
  proof2_t
      proofs[PICNIC_NUM_OPENED_ROUNDS]; // One proof for each online execution the verifier checks
} signature2_t;

int impl_sign_picnic3(const uint8_t* plaintext, const uint8_t* private_key,
                      const uint8_t* public_key, const uint8_t* msg, size_t msglen, uint8_t* sig,
                      size_t* siglen);
int impl_verify_picnic3(const uint8_t* plaintext, const uint8_t* public_key, const uint8_t* msg,
                        size_t msglen, const uint8_t* signature, size_t signature_len);

#endif /* PICNIC3_IMPL_H */
