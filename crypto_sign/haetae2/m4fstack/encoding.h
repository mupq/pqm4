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
#ifndef HAETAE_ENCODING_H
#define HAETAE_ENCODING_H

#include "params.h"
#include <stdint.h>
#include <stddef.h>

/*
 * Low-SRAM helper: decode h to uint16_t (all HAETAE parameter sets keep h
 * in a small non-negative range).
 */
/*
 * Low-SRAM helper: decode HB(z1) directly to int8_t symbols.
 * (HB(z1) is small, so int8_t output uses less memory than int32_t output.)
 */
/*
 * Streaming rANS decode context — allows row-by-row decoding of h and hb_z1
 * to avoid allocating full N*K or N*L buffers on the stack.
 */
typedef struct {
    uint32_t rans;          /* rANS state (== RansState) */
    const uint8_t *buf;     /* current read pointer */
    const uint8_t *buf_end; /* end of compressed data */
    const uint8_t *buf_start; /* start (for size verification) */
    uint16_t size_in;       /* total compressed size */
} rans_stream_ctx;

#define decode_h_stream_init HAETAE_NAMESPACE(decode_h_stream_init)
uint16_t decode_h_stream_init(rans_stream_ctx *ctx, const uint8_t *buf, uint16_t size_in);

#define decode_h_stream_row_u16 HAETAE_NAMESPACE(decode_h_stream_row_u16)
uint16_t decode_h_stream_row_u16(uint16_t *h_row, rans_stream_ctx *ctx);

#define decode_h_stream_finish HAETAE_NAMESPACE(decode_h_stream_finish)
uint16_t decode_h_stream_finish(rans_stream_ctx *ctx);

#define decode_hb_z1_stream_init HAETAE_NAMESPACE(decode_hb_z1_stream_init)
uint16_t decode_hb_z1_stream_init(rans_stream_ctx *ctx, const uint8_t *buf, uint16_t size_in);

#define decode_hb_z1_stream_col_i8 HAETAE_NAMESPACE(decode_hb_z1_stream_col_i8)
uint16_t decode_hb_z1_stream_col_i8(int8_t *hb_col, rans_stream_ctx *ctx);

#define decode_hb_z1_stream_finish HAETAE_NAMESPACE(decode_hb_z1_stream_finish)
uint16_t decode_hb_z1_stream_finish(rans_stream_ctx *ctx);

/*
 * Streaming rANS encode context for h — allows feeding coefficients one at a
 * time in reverse order (i=K-1..0, j=N-1..0) so that no polyveck buffer is
 * needed on the caller side.
 */
typedef struct {
    uint32_t rans;              /* RansState */
    uint8_t *base;              /* start of caller-provided buffer */
    uint8_t *ptr;               /* current write pointer (moves backwards from end) */
    size_t   cap;               /* buffer capacity */
    int      error;             /* non-zero if an encoding error occurred */
} encode_h_stream_ctx;

#define encode_h_stream_init HAETAE_NAMESPACE(encode_h_stream_init)
void encode_h_stream_init(encode_h_stream_ctx *ctx, uint8_t *buf, size_t cap);

#define encode_h_stream_put HAETAE_NAMESPACE(encode_h_stream_put)
void encode_h_stream_put(encode_h_stream_ctx *ctx, int32_t hint_value);

#define encode_h_stream_finish HAETAE_NAMESPACE(encode_h_stream_finish)
uint16_t encode_h_stream_finish(encode_h_stream_ctx *ctx);

/*
 * Streaming rANS encode for HB(z1) — same pattern as encode_h_stream.
 */
typedef struct {
    uint32_t rans;
    uint8_t  encoding[BASE_ENC_HB_Z1 + 260]; /* internal buffer; encode_hb_z1_stream_finish copies the result into sig */
    uint8_t *ptr;
    int      error;
} encode_hb_z1_stream_ctx;

#define encode_hb_z1_stream_init HAETAE_NAMESPACE(encode_hb_z1_stream_init)
void encode_hb_z1_stream_init(encode_hb_z1_stream_ctx *ctx);

#define encode_hb_z1_stream_put HAETAE_NAMESPACE(encode_hb_z1_stream_put)
void encode_hb_z1_stream_put(encode_hb_z1_stream_ctx *ctx, int8_t hb_value);

#define encode_hb_z1_stream_finish HAETAE_NAMESPACE(encode_hb_z1_stream_finish)
uint16_t encode_hb_z1_stream_finish(encode_hb_z1_stream_ctx *ctx, uint8_t *buf, size_t cap);

#endif // HAETAE_ENCODING_H
