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
#ifndef SYMMETRIC_H
#define SYMMETRIC_H

#include "config.h"
#include "fips202.h"
#include "params.h"
#include <stdint.h>

/*
 * Low-Stack HAETAE symmetric layer mapped onto the pqm4 common fips202
 * (PQClean-style split ctx / incctx API, asm KeccakF1600 backend).
 *
 * The crypto call sites use the abstraction below (stream128/256_*,
 * xof256_*), except the one-shot derivation of b in sign_passes.c, which
 * calls shake256() directly; only this header and symmetric-shake.c know
 * which Keccak backend implements it.
 */

// Cryptographic XOF function: shake256

typedef shake256incctx xof256_state;

#define haetae_shake256_absorb_once                                            \
    HAETAE_NAMESPACE(haetae_shake256_absorb_once)
void haetae_shake256_absorb_once(xof256_state *state, const uint8_t *in1,
                                 size_t in1len);

#define haetae_shake256_squeezeblocks                                          \
    HAETAE_NAMESPACE(haetae_shake256_squeezeblocks)
void haetae_shake256_squeezeblocks(uint8_t *output, size_t nblocks,
                                   xof256_state *state);

#define XOF256_BLOCKBYTES SHAKE256_RATE

/* Incremental XOF (streaming challenge hash in sign_passes.c). */
#define xof256_init(STATE)              shake256_inc_init(STATE)
#define xof256_absorb(STATE, IN, LEN)   shake256_inc_absorb(STATE, IN, LEN)
#define xof256_finalize(STATE)          shake256_inc_finalize(STATE)

#define xof256_absorb_once(STATE, IN, IN_LEN)                                  \
    haetae_shake256_absorb_once(STATE, IN, IN_LEN)
#define xof256_squeeze(OUT, OUT_LEN, STATE)                                    \
    shake256_inc_squeeze(OUT, OUT_LEN, STATE)
#define xof256_squeezeblocks(OUT, OUTBLOCKS, STATE)                            \
    haetae_shake256_squeezeblocks(OUT, OUTBLOCKS, STATE)

// Stream function: shake128 and shake256

typedef shake128incctx stream128_state;
typedef shake256incctx stream256_state;

#define haetae_shake128_stream_init                                            \
    HAETAE_NAMESPACE(haetae_shake128_stream_init)
void haetae_shake128_stream_init(stream128_state *state,
                                 const uint8_t seed[SEEDBYTES], uint16_t nonce);

#define haetae_shake128_stream_squeezeblocks                                   \
    HAETAE_NAMESPACE(haetae_shake128_stream_squeezeblocks)
void haetae_shake128_stream_squeezeblocks(uint8_t *output, size_t nblocks,
                                          stream128_state *state);

#define haetae_shake256_stream_init                                            \
    HAETAE_NAMESPACE(haetae_shake256_stream_init)
void haetae_shake256_stream_init(stream256_state *state,
                                 const uint8_t seed[CRHBYTES], uint16_t nonce);

#define haetae_shake256_stream_squeezeblocks                                   \
    HAETAE_NAMESPACE(haetae_shake256_stream_squeezeblocks)
void haetae_shake256_stream_squeezeblocks(uint8_t *output, size_t nblocks,
                                          stream256_state *state);

#define STREAM128_BLOCKBYTES SHAKE128_RATE
#define STREAM256_BLOCKBYTES SHAKE256_RATE

#define stream128_init(STATE, SEED, NONCE)                                     \
    haetae_shake128_stream_init(STATE, SEED, NONCE)
#define stream128_squeezeblocks(OUT, OUTBLOCKS, STATE)                         \
    haetae_shake128_stream_squeezeblocks(OUT, OUTBLOCKS, STATE)
#define stream256_init(STATE, SEED, NONCE)                                     \
    haetae_shake256_stream_init(STATE, SEED, NONCE)
#define stream256_squeezeblocks(OUT, OUTBLOCKS, STATE)                         \
    haetae_shake256_stream_squeezeblocks(OUT, OUTBLOCKS, STATE)

#endif // SYMMETRIC_H
