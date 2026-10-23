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
#include "packing.h"
#include "encoding.h"
#include "params.h"
#include "poly.h"
#include "polyvec.h"
#include <string.h>


void pack_pk_stream(uint8_t pk[CRYPTO_PUBLICKEYBYTES], poly *b, size_t count)
{
    pk += SEEDBYTES;
    polyq_pack(pk + count * POLYQ_PACKEDBYTES, b);
}

void pack_pk_stream_remain(uint8_t pk[CRYPTO_PUBLICKEYBYTES], const uint8_t seed[SEEDBYTES])
{
    memcpy(pk, seed, SEEDBYTES);
}


void pack_sk_stream_s1(uint8_t sk[CRYPTO_SECRETKEYBYTES], const poly *s1, const size_t count)
{
    sk += CRYPTO_PUBLICKEYBYTES;
    polyeta_pack(sk + count * POLYETA_PACKEDBYTES, s1);
}

void pack_sk_stream_s2(uint8_t sk[CRYPTO_SECRETKEYBYTES], const poly *s2, const size_t count)
{
    sk += CRYPTO_PUBLICKEYBYTES + (L - 1) * POLYETA_PACKEDBYTES;

#if D == 1
    poly2eta_pack(sk + count * POLY2ETA_PACKEDBYTES, s2);
#elif D == 0
    polyeta_pack(sk + count * POLYETA_PACKEDBYTES, s2);
#else
#error "Not yet implemented."
#endif
}

void pack_sk_stream_remain(uint8_t sk[CRYPTO_SECRETKEYBYTES],
                           const uint8_t pk[CRYPTO_PUBLICKEYBYTES],
                           const uint8_t key[SEEDBYTES])
{
    memcpy(sk, pk, CRYPTO_PUBLICKEYBYTES);

    sk += CRYPTO_PUBLICKEYBYTES + (L - 1) * POLYETA_PACKEDBYTES;

#if D == 1
    sk += K * POLY2ETA_PACKEDBYTES;
#elif D == 0
    sk += K * POLYETA_PACKEDBYTES;
#else
#error "Not yet implemented."
#endif
    memcpy(sk, key, SEEDBYTES);
}

int pack_sig_finish_hint(uint8_t sig[CRYPTO_BYTES],
                          uint16_t hbz1_size,
                          const uint8_t *h_encoded,
                          uint16_t h_enc_size) {
    uint8_t offset_enc_h, offset_enc_hb_z1;

    if (h_enc_size == 0 || h_enc_size < BASE_ENC_H) return 1;
    if ((uint16_t)(h_enc_size - BASE_ENC_H) > 255) return 1;

    /* Locate the offset bytes (right after c + LB(z1)). */
    uint8_t *off = sig + (N / 8) + (L * N);
    uint8_t *p = off + 2 + hbz1_size;

    /* Check capacity. */
    if ((size_t)(p - sig) + h_enc_size > CRYPTO_BYTES) return 1;

    /* Copy pre-encoded hint data. */
    memcpy(p, h_encoded, h_enc_size);

    offset_enc_h = (uint8_t)(h_enc_size - BASE_ENC_H);
    offset_enc_hb_z1 = (uint8_t)(hbz1_size - BASE_ENC_HB_Z1);

    /* Store offsets. */
    off[0] = offset_enc_hb_z1;
    off[1] = offset_enc_h;

    return 0;
}
