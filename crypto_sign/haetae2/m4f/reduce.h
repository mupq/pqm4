// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#ifndef HAETAE_REDUCE_H
#define HAETAE_REDUCE_H

#include "params.h"

#include <stdint.h>

#define MONT 14321     // 2^32 % HAETAE_Q
#define MONTSQ 4214    // 2^64 % HAETAE_Q
#define QINV 940508161 // q^(-1) mod 2^32
#define QREC 66575     // 2^32 / HAETAE_Q for Barrett
#define DQREC 33287    // 2^32 / DQ for Barrett

/*************************************************
 * Name:        montgomery_reduce
 *
 * Description: For finite field element a with -2^{31}Q < a < HAETAE_Q*2^31,
 *              compute r \equiv a*2^{-32} (mod HAETAE_Q) such that -HAETAE_Q <
 *              r < HAETAE_Q.
 *
 * Arguments:   - int64_t: finite field element a
 *
 * Returns r.
 *
 * Specification: Implements @[Algorithm 1, MontgomeryReduce]
 **************************************************/
static inline int32_t montgomery_reduce(int64_t a) {
  int32_t t;

  t = (int64_t)(int32_t)a * QINV;
  t = (a - (int64_t)t * HAETAE_Q) >> 32;
  return t;
}

/*************************************************
 * Name:        caddq
 *
 * Description: Add HAETAE_Q if input coefficient is negative.
 *
 * Arguments:   - int32_t: finite field element a
 *
 * Returns r.
 **************************************************/
static inline int32_t caddq(int32_t a) {
  a += (a >> 31) & HAETAE_Q;
  return a;
}

/*************************************************
 * Name:        freeze
 *
 * Description: For finite field element a, compute standard
 *              representative r = a mod^+ HAETAE_Q.
 *
 * Arguments:   - int32_t: finite field element a
 *
 * Returns r.
 **************************************************/
static inline int32_t freeze(int32_t a) {
  int64_t t = (int64_t)a * QREC;
  t = t >> 32;
  t = a - t * HAETAE_Q;                    // -2Q <  t < 2Q
  t += (t >> 31) & HAETAE_DQ;              //   0 <= t < 2Q
  t -= ~((t - HAETAE_Q) >> 31) & HAETAE_Q; //   0 <= t < HAETAE_Q
  return t;
}

/*************************************************
 * Name:        reduce32_2q
 *
 * Description: compute reduction with 2Q
 *
 * Arguments:   - int32_t: finite field element a
 *
 * Returns r.
 **************************************************/
static inline int32_t reduce32_2q(int32_t a) {
  int64_t t = (int64_t)a * DQREC;
  t >>= 32;
  t = a - t * HAETAE_DQ;                     // -4Q <  t < 4Q
  t += (t >> 31) & (HAETAE_DQ * 2);          //   0 <= t < 4Q
  t -= ~((t - HAETAE_DQ) >> 31) & HAETAE_DQ; //   0 <= t < 2Q
  t -= ~((t - HAETAE_Q) >> 31) & HAETAE_DQ;  // centered representation
  return (int32_t)t;
}

/*************************************************
 * Name:        freeze2q
 *
 * Description: For finite field element a, compute standard
 *              representative r = a mod^+ 2Q.
 *
 * Arguments:   - int32_t: finite field element a
 *
 * Returns r.
 **************************************************/
static inline int32_t freeze2q(int32_t a) {
  int64_t t = (int64_t)a * DQREC;
  t >>= 32;
  t = a - t * HAETAE_DQ;                     // -4Q <  t < 4Q
  t += (t >> 31) & (HAETAE_DQ * 2);          //   0 <= t < 4Q
  t -= ~((t - HAETAE_DQ) >> 31) & HAETAE_DQ; //   0 <= t < 2Q
  return (int32_t)t;
}

#endif /* !HAETAE_REDUCE_H */
