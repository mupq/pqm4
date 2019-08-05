//  r5_xof_sneik.c
//  2019-03-26  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (c) 2019, PQShield Ltd.

#include "r5_xof.h"

#ifdef BLNK2

//  For XOF we use the SNEIGEN entropy expansion function
//  The hash used in CCA transform is SNEIKHA

#include "blnk.h"

//  Initialize and absorb a message

void r5_xof_input(r5_xof_ctx_t *ctx,
    const void *in, size_t in_len)
{
    blnk_clr(ctx, SNEIGEN_RATE, SNEIGEN_ROUNDS);    // initialize

    blnk_put(ctx, BLNK_AD, in, in_len);             // absorb input
    blnk_fin(ctx, BLNK_AD);
}

//  Additional customizer "S"

void r5_xof_s_input(r5_xof_ctx_t *ctx,
    const void *in, size_t in_len,
    const void *sstr, size_t sstr_len)
{
    blnk_clr(ctx, SNEIGEN_RATE, SNEIGEN_ROUNDS);    // initialize

    blnk_put(ctx, BLNK_AD, sstr, sstr_len);         // absorb s
    blnk_fin(ctx, BLNK_AD);                         // padding
    blnk_put(ctx, BLNK_AD, in, in_len);             // absorb main input
    blnk_fin(ctx, BLNK_AD);                         // another padding
}

//  Output bytes

void r5_xof_squeeze(r5_xof_ctx_t *ctx,
    void *out, size_t out_len)
{
    blnk_get(ctx, BLNK_HASH, out, out_len);         // squeeze output
}

//  Single-call interface: XOF is SNEIGEN

void r5_xof(void *out, const size_t out_len,
    const void *in, const size_t in_len)
{
    blnk_t ctx;

    blnk_clr(&ctx, SNEIGEN_RATE, SNEIGEN_ROUNDS);   // initialize

    blnk_put(&ctx, BLNK_AD, in, in_len);            // absorb input
    blnk_fin(&ctx, BLNK_AD);
    blnk_get(&ctx, BLNK_HASH, out, out_len);        // squeeze output
}


//  Single-call interface: Hash is SNEIKHA (only used by CCA transforms)

#ifdef ROUND5_CCA_PKE

void r5_hash(void *out, const size_t out_len,
    const void *in, const size_t in_len)
{
    blnk_t ctx;

    blnk_clr(&ctx, SNEIKHA_RATE, SNEIKHA_ROUNDS);   // initialize

    blnk_put(&ctx, BLNK_AD, in, in_len);            // absorb input
    blnk_fin(&ctx, BLNK_AD);
    blnk_get(&ctx, BLNK_HASH, out, out_len);        // squeeze output
}

#endif /* ROUND5_CCA_PKE */

#endif /* BLNK2 */

