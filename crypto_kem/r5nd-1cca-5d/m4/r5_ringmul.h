//  r5_ringmul.h
//  2019-09-21  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (c) 2019, PQShield Ltd. All rights reserved.

#ifndef _R5_RINGMUL_H_
#define _R5_RINGMUL_H_

#include "r5_parameter_sets.h"

#if (PARAMS_N == PARAMS_D)

#include "r5_ternvec.h"

// multiplication mod q, result length n
PQS_OLOCAL void r5_ringmul_q(modq_t d[PARAMS_D],
							 const uint8_t sigma[PARAMS_KAPPA_BYTES],
							 const r5_ternv_t sv);

// multiplication mod p, result length mu
PQS_OLOCAL void r5_ringmul_p(modp_t d[PARAMS_MU],
							 const uint8_t * pv, const r5_ternv_t sv);

#endif

#endif										/* _R5_RINGMUL_H_ */
