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
#include "fips202.h"
#include "params.h"
#include "symmetric.h"
#include <stdint.h>

void haetae_shake128_stream_init(stream128_state *state,
                                 const uint8_t seed[SEEDBYTES],
                                 uint16_t nonce) {
    uint8_t t[2];
    t[0] = nonce;
    t[1] = nonce >> 8;

    shake128_inc_init(state);
    shake128_inc_absorb(state, seed, SEEDBYTES);
    shake128_inc_absorb(state, t, 2);
    shake128_inc_finalize(state);
}

void haetae_shake256_stream_init(stream256_state *state,
                                 const uint8_t seed[CRHBYTES], uint16_t nonce) {
    uint8_t t[2];
    t[0] = nonce;
    t[1] = nonce >> 8;

    shake256_inc_init(state);
    shake256_inc_absorb(state, seed, CRHBYTES);
    shake256_inc_absorb(state, t, 2);
    shake256_inc_finalize(state);
}

void haetae_shake256_absorb_once(xof256_state *state, const uint8_t *in1,
                                  size_t in1len) {
    shake256_inc_init(state);
    shake256_inc_absorb(state, in1, in1len);
    shake256_inc_finalize(state);
}

void haetae_shake256_squeezeblocks(uint8_t *output, size_t nblocks, xof256_state *state){
    shake256_inc_squeeze(output, nblocks * XOF256_BLOCKBYTES, state);
}


void haetae_shake128_stream_squeezeblocks(uint8_t *output, size_t nblocks, stream128_state *state){
    shake128_inc_squeeze(output, nblocks * STREAM128_BLOCKBYTES, state);
}

void haetae_shake256_stream_squeezeblocks(uint8_t *output, size_t nblocks, stream256_state *state){
    shake256_inc_squeeze(output, nblocks * STREAM256_BLOCKBYTES, state);
}

