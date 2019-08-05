//  ct_util.c
//  Copyright (c) 2018, PQShield Ltd.

#include "ct_util.h"

// constant time comparison; return nonzero if not equal

uint8_t ct_memcmp(const void *a, const void *b, size_t len)
{
    const uint8_t *a8 = (const uint8_t *) a;
    const uint8_t *b8 = (const uint8_t *) b;
    uint8_t flag = 0;
    size_t i;

    for (i = 0; i < len; i++) {
        flag |= a8[i] ^ b8[i];
    }

    return flag;
}

// conditional move; overwrite d with a if flag is nonzero

void ct_cmov(void *d, const void * a, uint8_t flag, size_t len)
{
    uint8_t *d8 = (uint8_t *) d;
    const uint8_t *a8 = (const uint8_t *) a;
    size_t i;

    flag = -((flag | -flag) >> 7);          // 0x00 or 0xFF

    for (i = 0; i < len; i++) {
        d8[i] ^= flag & (d8[i] ^ a8[i]);
    }
}
