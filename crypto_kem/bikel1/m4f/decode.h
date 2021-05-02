/* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0"
 *
 * Written by Nir Drucker, Shay Gueron and Dusan Kostic,
 * AWS Cryptographic Algorithms Group.
 *
 * Modification: 2021 Ming-Shing Chen, Tung Chou, and Markus Krausz
 *
 */

#pragma once

#include "types.h"

ret_t decode(OUT e_t *e, IN const ct_t *ct, IN const sk_t *sk);

// Rotate right the first R_BITS of a syndrome.
// At input, the syndrome is stored as three R_BITS triplicate.
// (this makes rotation easier to implement)
// For the output: the output syndrome has only one R_BITS rotation, the remaining
// (2 * R_BITS) bits are undefined.
void rotate_right(OUT syndrome_t *out,
                  IN const syndrome_t *in,
                  IN uint32_t          bitscount);


// Rotate right the first R_BITS of a syndrome.
// At input, the syndrome is stored as three R_BITS triplicate.
// (this makes rotation easier to implement)
// For the output: the output syndrome has only one R_BITS rotation, the remaining
// (2 * R_BITS) bits are undefined.
void rotate_right_u32(OUT syndrome_t *out,
                  IN const syndrome_t *in,
                  IN uint32_t          bitscount);


void rotr_prepare_u32(OUT syndrome_t *out, IN const syndrome_t *in);

void rotate_right_u32_2(OUT syndrome_t *out,
                  IN const syndrome_t *in,
                  IN uint32_t          bitscount);
