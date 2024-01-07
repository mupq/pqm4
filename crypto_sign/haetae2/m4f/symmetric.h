#ifndef SYMMETRIC_H
#define SYMMETRIC_H

#include "fips202.h"
#include "params.h"
#include <stdint.h>

// Cryptographic XOF function: shake256

typedef shake256incctx xof256_state;

#define haetae_shake256_absorb_twice                                           \
    HAETAE_NAMESPACE(haetae_shake256_absorb_twice)
void haetae_shake256_absorb_twice(xof256_state *state, const uint8_t *in1,
                                  size_t in1len, const uint8_t *in2,
                                  size_t in2len);

#define haetae_shake256_absorb_once                                           \
    HAETAE_NAMESPACE(haetae_shake256_absorb_once)
void haetae_shake256_absorb_once(xof256_state *state, const uint8_t *in1,
                                 size_t in1len);

#define haetae_shake256_squeezeblocks                                           \
    HAETAE_NAMESPACE(haetae_shake256_squeezeblocks)
void haetae_shake256_squeezeblocks(uint8_t *output, size_t nblocks, 
                                   xof256_state *state);



#define XOF256_BLOCKBYTES SHAKE256_RATE

#define xof256_absorb_once(STATE, IN, IN_LEN)                                 \
    haetae_shake256_absorb_once(STATE, IN, IN_LEN)
#define xof256_absorb_twice(STATE, IN, IN_LEN, IN2, IN2_LEN)                  \
    haetae_shake256_absorb_twice(STATE, IN, IN_LEN, IN2, IN2_LEN)
#define xof256_squeeze(OUT, OUT_LEN, STATE)                                    \
    shake256_inc_squeeze(OUT, OUT_LEN, STATE)
#define xof256_squeezeblocks(OUT, OUTBLOCKS, STATE)                            \
    haetae_shake256_squeezeblocks(OUT, OUTBLOCKS, STATE)





// Stream function: shake128|256

typedef shake128incctx stream128_state;
typedef shake256incctx stream256_state;

#define haetae_shake128_stream_init                                            \
    HAETAE_NAMESPACE(haetae_shake128_stream_init)
void haetae_shake128_stream_init(stream128_state *state,
                                 const uint8_t seed[SEEDBYTES], uint16_t nonce);

#define haetae_shake128_stream_squeezeblocks                                           \
    HAETAE_NAMESPACE(haetae_shake128_stream_squeezeblocks)
void haetae_shake128_stream_squeezeblocks(uint8_t *output, size_t nblocks, 
                                           stream128_state *state);

#define haetae_shake256_stream_init                                            \
    HAETAE_NAMESPACE(haetae_shake256_stream_init)
void haetae_shake256_stream_init(stream256_state *state,
                                 const uint8_t seed[CRHBYTES], uint16_t nonce);

#define haetae_shake256_stream_squeezeblocks                                           \
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
