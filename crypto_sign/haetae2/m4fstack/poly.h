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
// clang-format off
#ifndef HAETAE_POLY_H
#define HAETAE_POLY_H

#include "params.h"
#include "reduce.h"
#include "sampler.h"
#include "symmetric.h"
#include <stdint.h>
#include <stddef.h>

typedef struct {
    int32_t coeffs[N];
} poly;

#define poly_uniform_frozen_pointwise_montgomery_set HAETAE_NAMESPACE(poly_uniform_frozen_pointwise_montgomery_set)
void poly_uniform_frozen_pointwise_montgomery_set(poly *dest, const uint8_t seed[SEEDBYTES], uint16_t nonce, const poly *src_hat);

#define poly_uniform_frozen_pointwise_montgomery_addto HAETAE_NAMESPACE(poly_uniform_frozen_pointwise_montgomery_addto)
void poly_uniform_frozen_pointwise_montgomery_addto(poly *acc, const uint8_t seed[SEEDBYTES], uint16_t nonce, const poly *src_hat);

#define poly_uniform_frozen_double_pointwise_montgomery_addto HAETAE_NAMESPACE(poly_uniform_frozen_double_pointwise_montgomery_addto)
void poly_uniform_frozen_double_pointwise_montgomery_addto(poly *acc, const uint8_t seed[SEEDBYTES], uint16_t nonce, const poly *src_hat);

#define poly_add HAETAE_NAMESPACE(poly_add)
void poly_add(poly *c, const poly *a, const poly *b);
#define poly_sub HAETAE_NAMESPACE(poly_sub)
void poly_sub(poly *c, const poly *a, const poly *b);
#define poly_frommont HAETAE_NAMESPACE(poly_frommont)
void poly_frommont(poly *a);

#define poly_double_negate HAETAE_NAMESPACE(poly_double_negate)
void poly_double_negate(poly *a);

#define poly_caddq HAETAE_NAMESPACE(poly_caddq)
void poly_caddq(poly *a);

#define poly_pointwise_montgomery HAETAE_NAMESPACE(poly_pointwise_montgomery)
void poly_pointwise_montgomery(poly *c, const poly *a, const poly *b);

#define poly_reduce2q HAETAE_NAMESPACE(poly_reduce2q)
void poly_reduce2q(poly *a);
#define poly_freeze2q HAETAE_NAMESPACE(poly_freeze2q)
void poly_freeze2q(poly *a);
#define poly_freeze HAETAE_NAMESPACE(poly_freeze)
void poly_freeze(poly *a);

#define poly_uniform HAETAE_NAMESPACE(poly_uniform)
void poly_uniform(poly *a, const uint8_t seed[SEEDBYTES], uint16_t nonce);
#define poly_uniform_eta HAETAE_NAMESPACE(poly_uniform_eta)
void poly_uniform_eta(poly *a, const uint8_t seed[CRHBYTES], uint16_t nonce);
#define poly_uniform_add HAETAE_NAMESPACE(poly_uniform_add)
void poly_uniform_add(poly *a, const uint8_t seed[SEEDBYTES], uint16_t nonce);
#define poly_challenge_from_xof HAETAE_NAMESPACE(poly_challenge_from_xof)
void poly_challenge_from_xof(poly *c, xof256_state *state);

#define poly_decomposed_pack HAETAE_NAMESPACE(poly_decomposed_pack)
void poly_decomposed_pack(uint8_t *buf, const poly *a);
#define poly_pack_highbits HAETAE_NAMESPACE(poly_pack_highbits)
void poly_pack_highbits(uint8_t *buf, const poly *a);

#define polyq_pack HAETAE_NAMESPACE(polyq_pack)
void polyq_pack(uint8_t *r, const poly *a);
#define polyq_unpack HAETAE_NAMESPACE(polyq_unpack)
void polyq_unpack(poly *r, const uint8_t *a);

#if D == 0
#define polyq_unpack_pointwise_montgomery HAETAE_NAMESPACE(polyq_unpack_pointwise_montgomery)
void polyq_unpack_pointwise_montgomery(poly *dest, const uint8_t *a, const poly *src_hat);
#endif

#define polyeta_pack HAETAE_NAMESPACE(polyeta_pack)
void polyeta_pack(uint8_t *r, const poly *a);
#define polyeta_unpack HAETAE_NAMESPACE(polyeta_unpack)
void polyeta_unpack(poly *r, const uint8_t *a);
#define poly2eta_pack HAETAE_NAMESPACE(poly2eta_pack)
void poly2eta_pack(uint8_t *r, const poly *a);
#define poly2eta_unpack HAETAE_NAMESPACE(poly2eta_unpack)
void poly2eta_unpack(poly *r, const uint8_t *a);

#define poly_fromcrt0 HAETAE_NAMESPACE(poly_fromcrt0)
void poly_fromcrt0(poly *w, const poly *u);

#define poly_ntt HAETAE_NAMESPACE(poly_ntt)
void poly_ntt(poly *a);
#define poly_invntt_tomont HAETAE_NAMESPACE(poly_invntt_tomont)
void poly_invntt_tomont(poly *a);


#define poly_decompose_stream_pack HAETAE_NAMESPACE(poly_decompose_stream_pack)
void poly_decompose_stream_pack(uint8_t pk[CRYPTO_PUBLICKEYBYTES], poly *v, size_t count);

#endif
// clang-format on
