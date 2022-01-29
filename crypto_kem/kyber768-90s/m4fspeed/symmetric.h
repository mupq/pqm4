#ifndef SYMMETRIC_H
#define SYMMETRIC_H

#include "params.h"


#include "aes256ctr.h"
#include "sha2.h"

#if (KYBER_SSBYTES != 32)
#error "90s variant of Kyber can only generate keys of length 256 bits"
#endif

#define hash_h(OUT, IN, INBYTES) sha256(OUT, IN, INBYTES)
#define hash_g(OUT, IN, INBYTES) sha512(OUT, IN, INBYTES)
#define xof_absorb(STATE, IN, X, Y) aes256xof_absorb(STATE, IN, X, Y)
#define xof_squeezeblocks(OUT, OUTBLOCKS, STATE) aes256xof_squeezeblocks(OUT, OUTBLOCKS, STATE)
#define prf(OUT, OUTBYTES, KEY, NONCE) aes256_prf(OUT, OUTBYTES, KEY, NONCE)
#define kdf(OUT, IN, INBYTES) sha256(OUT, IN, INBYTES)

#define XOF_BLOCKBYTES 64

typedef aes256xof_ctx xof_state;

#endif /* SYMMETRIC_H */
