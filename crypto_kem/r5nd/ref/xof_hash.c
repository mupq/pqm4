//  xof_hash.c
//  2018-06-15  Markku-Juhani O. Saarinen <mjos@iki.fi>

#include "xof_hash.h"

void XOF_absorb(XOF_ctx *ctx, const void *data, size_t len)
{
    shake256_absorb(ctx->st, data, len);
    ctx->pt = SHAKE256_RATE;
}

void XOF_squeeze(XOF_ctx *ctx, void *data, size_t len)
{
    size_t i, j;

    i = ctx->pt;
    for (j = 0; j < len; j++) {
        if (i >= SHAKE256_RATE) {
            shake256_squeezeblocks(ctx->byt, 1, ctx->st);
            i = 0;
        }
        ((uint8_t *) data)[j] = ctx->byt[i++];
    }
    ctx->pt = i;
}

