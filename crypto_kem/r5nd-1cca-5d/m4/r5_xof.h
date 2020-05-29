//  r5_xof.h
//  2019-03-26  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (c) 2020, PQShield Ltd. All rights reserved.

//  Abstract interface to required FIPS 202 and SP 800-185 features

#ifndef _R5_XOF_H_
#define _R5_XOF_H_

#include "r5_parameter_sets.h"
#include "sp800-185.h"

//  TupleHash - based functionality

#if (PARAMS_KAPPA_BYTES > 16)
#define R5_XOF_RATE SHAKE256_RATE
#else
#define R5_XOF_RATE SHAKE128_RATE
#endif

typedef struct {
	uint64_t st[25];
	uint8_t buf[R5_XOF_RATE];
	size_t idx;
} r5_xof_t;

//  Reset and initialize the context
void r5_xof_ini(r5_xof_t * ctx);

//  Encode a string (data element) from "dat", "len" bytes
void r5_xof_str(r5_xof_t * ctx, const void *dat, size_t len);

//  Pad for output, "bits" = number of output bits, 0 = XOF
void r5_xof_pad(r5_xof_t * ctx, size_t bits);

//  Squeeze "len" bytes of output to "out"
void r5_xof_out(r5_xof_t * ctx, void *out, size_t out_len);

#endif										/* _R5_XOF_H_ */
