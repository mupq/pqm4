//  r5_ternvec.h
//  2019-09-21  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (c) 2019, PQShield Ltd. All rights reserved.

#ifndef _R5_TERNVEC_H_
#define _R5_TERNVEC_H_

#include "r5_parameter_sets.h"

//  currently constant time support only for ring variants
#if defined(ROUND5_CT) && (PARAMS_N == 1)
//#warning "Disabling ROUND5_CT for non-ring variant."
#undef ROUND5_CT
#endif

//  set the ternary vector type (also used for matrices)
#ifdef ROUND5_CT
//  slow constant-time type
#define TVEC_WORDS DIV_CEIL(PARAMS_D, 64)
typedef uint64_t r5_ternv_t[TVEC_WORDS][2];
#else
//  fast index type
typedef uint16_t r5_ternv_t[PARAMS_H / 2][2];
#endif

//  create a secret indexed vector
PQS_OLOCAL void r5_idx_tern(r5_ternv_t sv,
							void *dom, size_t domlen,
							const uint8_t seed[PARAMS_KAPPA_BYTES],
							size_t idx);

#endif										/* _R5_TERNVEC_H_ */
