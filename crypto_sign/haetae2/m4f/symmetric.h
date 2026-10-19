// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#ifndef HAETAE_SYMMETRIC_H
#define HAETAE_SYMMETRIC_H

/*
 * pqm4/mupq adaptation: the XOF and stream functions are mapped onto the
 * incremental SHAKE API of mupq/common/fips202.h (assembly Keccak on the
 * Cortex-M4) instead of the stand-alone fips202.c of the HAETAE package.
 * The byte streams are unchanged.
 */

#include "fips202.h"
#include "params.h"

#include <stddef.h>
#include <stdint.h>

typedef shake256incctx xof256_state;
typedef shake128incctx stream128_state;
typedef shake256incctx stream256_state;

#define XOF256_BLOCKBYTES SHAKE256_RATE
#define STREAM128_BLOCKBYTES SHAKE128_RATE // 168
#define STREAM256_BLOCKBYTES SHAKE256_RATE // 136

#define shake256_absorb_once_inc HAETAE_NAMESPACE(shake256_absorb_once_inc)
void shake256_absorb_once_inc(xof256_state *state, const uint8_t *in,
                              size_t inlen);
#define shake256_absorb_twice HAETAE_NAMESPACE(shake256_absorb_twice)
void shake256_absorb_twice(xof256_state *state, const uint8_t *in1,
                           size_t in1len, const uint8_t *in2, size_t in2len);
#define shake256_absorb_thrice HAETAE_NAMESPACE(shake256_absorb_thrice)
void shake256_absorb_thrice(xof256_state *state, const uint8_t *in1,
                            size_t in1len, const uint8_t *in2, size_t in2len,
                            const uint8_t *in3, size_t in3len);

#define shake128_stream_init HAETAE_NAMESPACE(shake128_stream_init)
void shake128_stream_init(stream128_state *state,
                          const uint8_t seed[HAETAE_SEEDBYTES], uint16_t nonce);
#define shake256_stream_init HAETAE_NAMESPACE(shake256_stream_init)
void shake256_stream_init(stream256_state *state,
                          const uint8_t seed[HAETAE_CRHBYTES], uint16_t nonce);

#define xof256_absorb_once(STATE, IN, IN_LEN)                                  \
  shake256_absorb_once_inc(STATE, IN, IN_LEN)
#define xof256_absorb_twice(STATE, IN, IN_LEN, IN2, IN2_LEN)                   \
  shake256_absorb_twice(STATE, IN, IN_LEN, IN2, IN2_LEN)
#define xof256_absorb_thrice(STATE, IN, IN_LEN, IN2, IN2_LEN, IN3, IN3_LEN)    \
  shake256_absorb_thrice(STATE, IN, IN_LEN, IN2, IN2_LEN, IN3, IN3_LEN)
#define xof256_squeeze(OUT, OUT_LEN, STATE)                                    \
  shake256_inc_squeeze(OUT, OUT_LEN, STATE)
#define xof256_squeezeblocks(OUT, OUTBLOCKS, STATE)                            \
  shake256_inc_squeeze(OUT, (OUTBLOCKS) * SHAKE256_RATE, STATE)

#define stream128_init(STATE, SEED, NONCE)                                     \
  shake128_stream_init(STATE, SEED, NONCE)
#define stream128_squeezeblocks(OUT, OUTBLOCKS, STATE)                         \
  shake128_inc_squeeze(OUT, (OUTBLOCKS) * SHAKE128_RATE, STATE)
#define stream256_init(STATE, SEED, NONCE)                                     \
  shake256_stream_init(STATE, SEED, NONCE)
#define stream256_squeezeblocks(OUT, OUTBLOCKS, STATE)                         \
  shake256_inc_squeeze(OUT, (OUTBLOCKS) * SHAKE256_RATE, STATE)

#endif /* !HAETAE_SYMMETRIC_H */
