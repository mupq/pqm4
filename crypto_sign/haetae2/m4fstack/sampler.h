/*
 * Copyright 2026 YoungBeom Kim, Christine van Vredendaal, Gustavo Banegas, and Seog Chung Seo
 *
 * Derived from the HAETAE reference implementation, Copyright (c) 2026
 * Team HAETAE, MIT License (see LICENSE).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#ifndef HAETAE_SAMPLER_H
#define HAETAE_SAMPLER_H

#include "fixpoint.h"
#include "params.h"
#include "reduce.h"
#include "symmetric.h"
#include <stdint.h>
#include <stddef.h>

#define rej_uniform HAETAE_NAMESPACE(rej_uniform)
unsigned int rej_uniform(int32_t *a, unsigned int len, const uint8_t *buf,
                         unsigned int buflen);

#define rej_uniform_add HAETAE_NAMESPACE(rej_uniform_add)
unsigned int rej_uniform_add(int32_t *a, unsigned int len, const uint8_t *buf,
                             unsigned int buflen);

#define rej_eta HAETAE_NAMESPACE(rej_eta)
unsigned int rej_eta(int32_t *a, unsigned int len, const uint8_t *buf,
                     unsigned int buflen);

/*
 * SampleGauss83 of HAETAE 1.2.0 (sample_gauss83.S): number of entries of the
 * 83-bit CDT that are smaller than rnd = hi*2^64 + lo1*2^32 + lo0, hi < 2^19.
 */
#define sample_gauss83_asm HAETAE_NAMESPACE(sample_gauss83_asm)
uint32_t sample_gauss83_asm(uint32_t lo0, uint32_t lo1, uint32_t hi);

/*
 * Streaming Gaussian sampler context.
 * Produces one accepted sample at a time from the same SHAKE byte stream
 * as the reference SampleGaussN, so outputs are bit-identical for the same
 * seed/nonce.
 */
typedef struct {
    stream256_state shake_st;
    uint8_t block[STREAM256_BLOCKBYTES];
    size_t  block_idx;   /* next unused byte in block[] */
    uint8_t signs[(N + 1 + 7) / 8]; /* pre-squeezed sign bits (max 33B) */
    size_t  total_len;   /* total samples to produce */
    size_t  coefcnt;     /* samples produced so far */
    int     dont_write_last;
} gauss_stream_ctx;

/*
 * Start a stream of len samples, len = N or N + 1.  As in SampleGaussN, the
 * len/8 sign bytes are squeezed first; with len = N + 1 the last sample is
 * used only for the norm and has no sign bit.
 */
#define gauss_stream_init HAETAE_NAMESPACE(gauss_stream_init)
void gauss_stream_init(gauss_stream_ctx *ctx,
                       const uint8_t seed[CRHBYTES],
                       uint16_t nonce, size_t len);

/*
 * Generate the next accepted Gaussian sample.
 * Returns the sample magnitude in *sample_out and the squared
 * contribution in *sqr_out.  The sign bit for this sample is at
 *   (ctx->signs[ctx->coefcnt_before / 8] >> (ctx->coefcnt_before % 8)) & 1
 * where coefcnt_before = coefcnt value before the call.
 * Exception: for the last sample of a stream with len = N + 1 only *sqr_out
 * is written (*sample_out is left unchanged and there is no sign bit).
 * After the call, ctx->coefcnt is incremented by 1.
 */
#define gauss_stream_sample HAETAE_NAMESPACE(gauss_stream_sample)
void gauss_stream_sample(gauss_stream_ctx *ctx,
                         uint64_t *sample_out,
                         fp96_76 *sqr_out);

#endif
