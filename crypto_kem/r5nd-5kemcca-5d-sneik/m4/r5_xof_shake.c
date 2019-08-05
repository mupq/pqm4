//  r5_xof_shake.c
//  2019-03-26  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (c) 2019, PQShield Ltd.

#include "r5_xof.h"

#ifndef BLNK2

#include "sp800-185.h"

#include <assert.h>
#include <string.h>

void r5_xof_input(r5_xof_ctx_t *ctx,
    const void *in, size_t in_len)
{
#if (PARAMS_KAPPA_BYTES > 16)
    shake256_inc_init(ctx);
    shake256_inc_absorb(ctx, in, in_len);
    shake256_inc_finalize(ctx);
#else
    shake128_inc_init(ctx);
    shake128_inc_absorb(ctx, in, in_len);
    shake128_inc_finalize(ctx);
#endif
}

void r5_xof_squeeze(r5_xof_ctx_t *ctx,
    void *out, size_t out_len)
{
#if (PARAMS_KAPPA_BYTES > 16)
    shake256_inc_squeeze(out, out_len, ctx);
#else
    shake128_inc_squeeze(out, out_len, ctx);
#endif
}

void r5_xof(void *out, size_t out_len,
    const void *in, size_t in_len)
{
#if (PARAMS_KAPPA_BYTES > 16)
    shake256(out, out_len, in, in_len);
#else
    shake128(out, out_len, in, in_len);
#endif
}

void r5_xof_s_input(r5_xof_ctx_t *ctx,
    const void *in, size_t in_len,
    const void *sstr, size_t sstr_len)
{
#if (PARAMS_KAPPA_BYTES > 16)
    cshake256_inc_init(ctx, (const uint8_t *)"", 0, sstr, sstr_len);
    cshake256_inc_absorb(ctx, in, in_len);
    cshake256_inc_finalize(ctx);
#else
    cshake128_inc_init(ctx, (const uint8_t *)"", 0, sstr, sstr_len);
    cshake128_inc_absorb(ctx, in, in_len);
    cshake128_inc_finalize(ctx);
#endif
}

#endif /* !BLNK2 */
