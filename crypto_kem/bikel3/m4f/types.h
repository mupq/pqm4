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

#include <stddef.h>
#include <stdint.h>

#include "bike_defs.h"
#include "error.h"

typedef struct uint128_s {
  union {
    uint8_t  bytes[16]; // NOLINT
    uint32_t dw[4];     // NOLINT
    uint64_t qw[2];     // NOLINT
  } u;
} uint128_t;

// Make sure no compiler optimizations.
#pragma pack(push, 1)

typedef struct seed_s {
  uint8_t raw[SEED_BYTES];
} seed_t;

typedef struct seeds_s {
  seed_t seed[NUM_OF_SEEDS];
} seeds_t;

typedef struct r_s {
  uint8_t raw[R_BYTES];
} r_t;

typedef struct m_s {
  uint8_t raw[M_BYTES];
} m_t;

typedef struct e_s {
  r_t val[N0];
} e_t;

#define E0_RAW(e) ((e)->val[0].raw)
#define E1_RAW(e) ((e)->val[1].raw)

typedef struct ct_s {
  r_t c0;
  m_t c1;
} ct_t;

typedef r_t pk_t;

typedef struct ss_st {
  uint8_t raw[SS_BYTES];
} ss_t;

typedef uint32_t idx_t;

typedef struct compressed_idx_d_s {
  idx_t val[D];
} compressed_idx_d_t;

typedef compressed_idx_d_t compressed_idx_d_ar_t[N0];

// The secret key holds both representations, to avoid
// the compression in Decaps.
typedef struct sk_s {
  compressed_idx_d_ar_t wlist;
  r_t                   bin[N0];
  pk_t                  pk;
  m_t                   sigma;
} sk_t;

typedef ALIGN(sizeof(idx_t)) sk_t aligned_sk_t;

// Pad r to the next Block
typedef struct pad_r_s {
  r_t     val;
  uint8_t pad[R_PADDED_BYTES - sizeof(r_t)];
} ALIGN(ALIGN_BYTES) pad_r_t;

// Double padded r, required for multiplication and squaring
typedef struct dbl_pad_r_s {
  uint8_t raw[2 * R_PADDED_BYTES];
} ALIGN(ALIGN_BYTES) dbl_pad_r_t;

// Quadruple padded r, required for FFT multiplication
typedef struct quad_pad_r_s {
  uint8_t raw[4 * R_PADDED_BYTES];
} ALIGN(ALIGN_BYTES) quad_pad_r_t;

typedef struct pad_e_s {
  pad_r_t val[N0];
} ALIGN(ALIGN_BYTES) pad_e_t;

#define PE0_RAW(e) ((e)->val[0].val.raw)
#define PE1_RAW(e) ((e)->val[1].val.raw)

typedef struct func_k_s {
  m_t m;
  r_t c0;
  m_t c1;
} func_k_t;


#define _USE_CSHIFT_
//#define _USE_CMOV_

#if defined(_USE_CMOV_)||defined(_USE_CSHIFT_)
#include "rotr_cshift.h"
#if 12323 == R_BITS
typedef struct syndrome_s {
  //uint64_t qw[R_QWORDS + 2*128];
  //uint64_t qw[4*128];  // 32768 bits , for transposed rotation
  uint64_t qw[R_QWORDS*2];  // rotation with cmov
  //uint64_t qw[SIZE_MEMORY_CSHIFT_12323/2];  // rotation with cshift
} ALIGN(ALIGN_BYTES) syndrome_t;
#elif 24659 == R_BITS
typedef struct syndrome_s {
  //uint64_t qw[R_QWORDS + 2*256];
  //uint64_t qw[4*256];  // 65536 bits , transposed rotation
  uint64_t qw[R_QWORDS*2];  // rotation with cmov
  //uint64_t qw[SIZE_MEMORY_CSHIFT_24659/2];  // rotation with cshift
} ALIGN(ALIGN_BYTES) syndrome_t;
#endif
#else
//error : original syndrime_t
// For a faster rotate we triplicate the syndrome (into 3 copies)
typedef struct syndrome_s {
  uint64_t qw[3 * R_QWORDS];
} ALIGN(ALIGN_BYTES) syndrome_t;
#endif


#define _UPC_SMALL_MEM_

#if defined( _UPC_SMALL_MEM_ )
typedef struct upc_slice_s {
  union {
    r_t r;
    uint64_t qw[R_QWORDS];
  } u;
} upc_slice_t;
#else
typedef struct upc_slice_s {
  union {
    pad_r_t  r;
    uint64_t qw[sizeof(pad_r_t) / sizeof(uint64_t)];
  } ALIGN(ALIGN_BYTES) u;
} ALIGN(ALIGN_BYTES) upc_slice_t;
#endif



typedef struct upc_s {
  upc_slice_t slice[SLICES];
} upc_t;


typedef struct my_upc_s {
#if 71 == D
  upc_slice_t slice[16];
#elif 103 == D
  upc_slice_t slice[19];
#else
error: un-supported D
#endif
} my_upc_t;

#pragma pack(pop)
