// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#ifndef HAETAE_SAMPLER_H
#define HAETAE_SAMPLER_H

#include "fixpoint.h"
#include "params.h"

#include <stdint.h>

#define rej_uniform HAETAE_NAMESPACE(rej_uniform)
unsigned int rej_uniform(int32_t *a, unsigned int len, const uint8_t *buf,
                         unsigned int buflen);
#define rej_eta HAETAE_NAMESPACE(rej_eta)
unsigned int rej_eta(int32_t *a, unsigned int len, const uint8_t *buf,
                     unsigned int buflen);

/*
 * SampleGauss83 (sample_gauss83.S): number of entries of the 83-bit CDT that
 * are smaller than rnd = hi*2^64 + lo1*2^32 + lo0, hi < 2^19.
 */
#define sample_gauss83_asm HAETAE_NAMESPACE(sample_gauss83_asm)
uint32_t sample_gauss83_asm(uint32_t lo0, uint32_t lo1, uint32_t hi);

#define sample_gauss_N HAETAE_NAMESPACE(sample_gauss_N)
void sample_gauss_N(uint64_t *r, uint8_t *signs, fp96_76 *sqsum,
                    const uint8_t seed[HAETAE_CRHBYTES], uint16_t nonce,
                    size_t len);

#endif /* !HAETAE_SAMPLER_H */
