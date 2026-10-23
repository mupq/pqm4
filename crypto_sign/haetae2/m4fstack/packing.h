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
#ifndef HAETAE_PACKING_H
#define HAETAE_PACKING_H

#include "params.h"
#include "polyvec.h"
#include <stdint.h>
#include <stddef.h>

/* Streamed public-key packing for the low-stack KeyGen: pack_pk_stream packs
 * row count of b (mode 5; modes 2 and 3 pack the decomposed b with
 * poly_decompose_stream_pack), pack_pk_stream_remain writes the seed. */
#define pack_pk_stream HAETAE_NAMESPACE(pack_pk_stream)
void pack_pk_stream(uint8_t pk[CRYPTO_PUBLICKEYBYTES], poly *b, size_t count);

#define pack_pk_stream_remain HAETAE_NAMESPACE(pack_pk_stream_remain)
void pack_pk_stream_remain(uint8_t pk[CRYPTO_PUBLICKEYBYTES], const uint8_t seed[SEEDBYTES]);

/* Streamed secret-key packing for the low-stack KeyGen (all modes): s1[count],
 * s2[count], then the public key and key. */
#define pack_sk_stream_s1 HAETAE_NAMESPACE(pack_sk_stream_s1)
void pack_sk_stream_s1(uint8_t sk[CRYPTO_SECRETKEYBYTES], const poly *s1, const size_t count);

#define pack_sk_stream_s2 HAETAE_NAMESPACE(pack_sk_stream_s2)
void pack_sk_stream_s2(uint8_t sk[CRYPTO_SECRETKEYBYTES], const poly *s2, const size_t count);

#define pack_sk_stream_remain HAETAE_NAMESPACE(pack_sk_stream_remain)
void pack_sk_stream_remain(uint8_t sk[CRYPTO_SECRETKEYBYTES],
                           const uint8_t pk[CRYPTO_PUBLICKEYBYTES],
                           const uint8_t key[SEEDBYTES]);

/*
 * Completes a signature sig = (c, LB(z1), two size bytes, Enc(HB(z1)), Enc(h))
 * in which c, LB(z1) and the hbz1_size bytes of Enc(HB(z1)) are already
 * written: copies the already encoded hint h_encoded (h_enc_size bytes) after
 * Enc(HB(z1)) and stores the size bytes hbz1_size - BASE_ENC_HB_Z1 and
 * h_enc_size - BASE_ENC_H (the caller checks that the first fits in a byte).
 *
 * Returns 0, or 1 if h_enc_size - BASE_ENC_H is not in [0, 255] or the
 * signature would exceed CRYPTO_BYTES.
 */
#define pack_sig_finish_hint HAETAE_NAMESPACE(pack_sig_finish_hint)
int pack_sig_finish_hint(uint8_t sig[CRYPTO_BYTES],
                          uint16_t hbz1_size,
                          const uint8_t *h_encoded,
                          uint16_t h_enc_size);

#endif //HAETAE_PACKING_H
// clang-format on
