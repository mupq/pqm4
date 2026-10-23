// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#ifndef HAETAE_NTT_H
#define HAETAE_NTT_H

#include "params.h"

#include <stdint.h>

/*
 * ntt() and invntt_tomont() are implemented in ntt332.S.  ntt() returns the
 * same values as the reference C code; invntt_tomont() returns congruent
 * values in (-HAETAE_Q, HAETAE_Q), but for results near +-HAETAE_Q/2 the
 * representative can differ from the C code.  This does not change any
 * output: the callers either reduce the result (KeyGen, A*y in Sign, Verify)
 * or, for c*s in Sign, the exact result is small (|c*s| <= 2*TAU) and is the
 * only representative within the range of the final Montgomery reduction.
 */
#define ntt HAETAE_NAMESPACE(ntt)
void ntt(int32_t a[HAETAE_N]);

#define invntt_tomont HAETAE_NAMESPACE(invntt_tomont)
void invntt_tomont(int32_t a[HAETAE_N]);

#endif /* !HAETAE_NTT_H */
