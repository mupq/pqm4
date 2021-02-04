/* Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0"
 *
 * Written by Nir Drucker, Shay Gueron and Dusan Kostic,
 * AWS Cryptographic Algorithms Group.
 */

#pragma once
#include "defs.h"

#include "aes.h"

#include "cleanup.h"

#define MAX_AES_INVOKATION (MASK(32))

#define AES256_KEY_BYTES   (32U)
#define AES256_KEY_BITS    (AES256_KEY_BYTES * 8)
#define AES256_BLOCK_BYTES (16U)
#define AES256_ROUNDS      (14U)

typedef ALIGN(16) struct aes256_key_s {
  uint8_t raw[AES256_KEY_BYTES];
} aes256_key_t;

CLEANUP_FUNC(aes256_key, aes256_key_t)

typedef aes256ctx aes256_ks_t;


_INLINE_ ret_t aes256_key_expansion(OUT aes256_ks_t *ks, IN const aes256_key_t *key)
{
  aes256_ecb_keyexp(ks, key->raw );
  return SUCCESS;
}

_INLINE_ ret_t aes256_enc(OUT uint8_t *ct, IN const uint8_t *pt, IN const aes256_ks_t *ks)
{
  aes256_ecb( ct, pt, 1, ks );
  return SUCCESS;
}

// Empty function
_INLINE_ void aes256_free_ks(OUT BIKE_UNUSED_ATT aes256_ks_t *ks) {}

