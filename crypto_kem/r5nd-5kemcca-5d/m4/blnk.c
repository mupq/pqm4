//  blnk.c
//  2019-02-20  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (C) 2019, PQShield Ltd. Please see LICENSE.

//  The BLNK2 "core" state manipulation functions.

#include "round5_variant_setting.h"

#ifdef BLNK2

#include "blnk.h"

//  Initialize with given rate and number of rounds

void blnk_clr(blnk_t *ctx, size_t rate, uint8_t rounds)
{
    size_t i;

    for (i = 0; i < BLNK_BLOCK; i++)
        ctx->st.u8[i] = 0;

    ctx->pos = 0;
    ctx->rate = rate;
    ctx->rounds = rounds;
}

//  End a data element (compulsory between different domain types)

void blnk_fin(blnk_t *ctx, blnk_dom_t dom)
{
    const uint8_t pad[1] = { 0x01 };

    blnk_put(ctx, dom, pad, 1);                         // padding bit
    if ((dom & BLNK_FULL) == 0) {                       // not full-state ?
        ctx->st.u8[ctx->rate - 1] ^= 0x80;              // indicate capacity
    }

    BLNK_PI(&ctx->st, dom | BLNK_LAST, ctx->rounds);    // finalize

    ctx->pos = 0;
}

//  Absorb data

void blnk_put(blnk_t *ctx, blnk_dom_t dom, const void *in, size_t len)
{
    size_t i, j, r;

    i = ctx->pos;
    r = dom & BLNK_FULL ? BLNK_BLOCK : ctx->rate;       // full-state ?

    for (j = 0; j < len; j++) {
        if (i >= r) {
            BLNK_PI(&ctx->st, dom, ctx->rounds);
            i = 0;
        }
        ctx->st.u8[i++] ^= ((const uint8_t *) in)[j];
    }
    ctx->pos = i;
}

//  Squeeze data

void blnk_get(blnk_t *ctx, blnk_dom_t dom, void *out, size_t len)
{
    size_t i, j, r;

    i = ctx->pos;
    r = ctx->rate;

    for (j = 0; j < len; j++) {
        if (i >= r) {
            BLNK_PI(&ctx->st, dom, ctx->rounds);
            i = 0;
        }
        ((uint8_t *) out)[j] = ctx->st.u8[i++];
    }

    ctx->pos = i;
}

//  Encrypt data

void blnk_enc(blnk_t *ctx, blnk_dom_t dom,
    void *out, const void *in, size_t len)
{
    size_t i, j, r;

    i = ctx->pos;
    r = ctx->rate;

    for (j = 0; j < len; j++) {
        if (i >= r) {
            BLNK_PI(&ctx->st, dom, ctx->rounds);
            i = 0;
        }
        ctx->st.u8[i] ^= ((const uint8_t *) in)[j];
        ((uint8_t *) out)[j] = ctx->st.u8[i++];
    }

    ctx->pos = i;
}

//  Decrypt data

void blnk_dec(blnk_t *ctx, blnk_dom_t dom,
    void *out, const void *in, size_t len)
{
    size_t i, j, r;
    uint8_t t;

    i = ctx->pos;
    r = ctx->rate;

    for (j = 0; j < len; j++) {
        if (i >= r) {
            BLNK_PI(&ctx->st, dom, ctx->rounds);
            i = 0;
        }
        t = ((const uint8_t *) in)[j];
        ((uint8_t *) out)[j] = ctx->st.u8[i] ^ t;
        ctx->st.u8[i++] = t;
    }

    ctx->pos = i;
}

//  Compare to output (0 == equal)

int blnk_cmp(blnk_t *ctx, blnk_dom_t dom, const void *in, size_t len)
{
    size_t i, j, r;
    uint8_t t;

    i = ctx->pos;
    r = ctx->rate;
    t = 0;

    for (j = 0; j < len; j++) {
        if (i >= r) {
            BLNK_PI(&ctx->st, dom, ctx->rounds);
            i = 0;
        }
        t |= ((const uint8_t *) in)[j] ^ ctx->st.u8[i++];
    }

    ctx->pos = i;

    return t != 0;
}

//  Ratchet for forward security

void blnk_ratchet(blnk_t *ctx)
{
    size_t i, r;

    r = ctx->rate;

    for (i = 0; i < r; i++) {
        ctx->st.u8[i] = 0;
    }

    ctx->pos = 0;
}

#endif /* BLNK2 */
