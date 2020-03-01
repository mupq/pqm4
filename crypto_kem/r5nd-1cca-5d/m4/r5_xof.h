//  r5_xof.h
//  2019-03-26  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (c) 2019, PQShield Ltd.

//  Abstract interface to an extensible output function ("XOF") type hash.
//  Allows only one "input", but you can call "squeeze" many times.

#ifndef _R5_XOF_H_
#define _R5_XOF_H_

#include "r5_parameter_sets.h"

#ifndef BLNK2

//  -- Keccak-based functionality --

#include "fips202.h"

#if (PARAMS_KAPPA_BYTES > 16)
typedef shake256incctx r5_xof_ctx_t;
#else
typedef shake128incctx r5_xof_ctx_t;
#endif

// In Round5 SHAKE is used for everything, so hash = xof
#define r5_hash r5_xof

#else   /* !BLNK2 */

//  -- SNEIK-based functionality --

#include "blnk.h"
typedef blnk_t r5_xof_ctx_t;

// In R5SNEIK the CCA transform uses a SNEIKHA while seed expansion is SNEIGEN
void r5_hash(void *out, const size_t out_len,
    const void *in, const size_t in_len);

#endif  /* BLNK2 */

//  Common interface

void r5_xof(void *out, const size_t out_len,
    const void *in, const size_t in_len);

void r5_xof_input(r5_xof_ctx_t *ctx,
    const void *in, size_t in_len);

void r5_xof_s_input(r5_xof_ctx_t *ctx,
    const void *in, size_t in_len,
    const void *sstr, size_t sstr_len);

void r5_xof_squeeze(r5_xof_ctx_t *ctx,
    void *out, size_t out_len);

#endif /* _R5_XOF_H_ */

