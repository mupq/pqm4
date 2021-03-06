#ifndef AES256CTR_H
#define AES256CTR_H

#include "aes-publicinputs.h"

#include <stddef.h>
#include <stdint.h>

typedef struct {
    aes256ctx_publicinputs sk_exp;
    uint8_t iv[12];
    uint32_t ctr;
} aes256xof_ctx;

void aes256_prf(uint8_t *output, size_t outlen, const uint8_t *key, uint8_t nonce);
void aes256xof_absorb(aes256xof_ctx *s, const uint8_t *key, uint8_t x, uint8_t y);
void aes256xof_squeezeblocks(uint8_t *out, size_t nblocks, aes256xof_ctx *s);

#endif
