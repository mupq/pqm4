//  xof_hash.h
//  2018-06-15  Markku-Juhani O. Saarinen <mjos@iki.fi>

#ifndef _XOF_HASH_H_
#define _XOF_HASH_H_

#include <stdint.h>
#include <stddef.h>

#include "fips202.h"
#include "keccakf1600.h"

typedef struct {
    uint64_t st[25];
    uint8_t byt[SHAKE256_RATE];
    size_t pt;
} XOF_ctx;

// prototypes
void XOF_absorb(XOF_ctx *ctx, const void *data, size_t len);
void XOF_squeeze(XOF_ctx *ctx, void *data, size_t len);

#define XOF_hash(output, input, input_byte_len, output_byte_len)        \
    shake256((unsigned char *) (output), (size_t) (output_byte_len),    \
            (const unsigned char *) (input), (size_t) (input_byte_len))

#endif /* _XOF_HASH_H_ */

