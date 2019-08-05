//  r5_ringmul.h
//  Copyright (c) 2019, PQShield Ltd. and Koninklijke Philips N.V.

#ifndef _R5_RINGMUL_H_
#define _R5_RINGMUL_H_

#include "r5_parameter_sets.h"

#if (PARAMS_N == PARAMS_D)

// multiplication mod q, result length n
void r5_ringmul_q(modq_t d[PARAMS_D],
    modq_t a[2 * (PARAMS_D + 1)],
    uint16_t idx[PARAMS_H / 2][2]);

// multiplication mod p, result length mu
void r5_ringmul_p(modp_t d[PARAMS_D],
    modp_t a[PARAMS_D + PARAMS_MU + 2],
    uint16_t idx[PARAMS_H / 2][2]);

#endif

#endif /* _R5_RINGMUL_H_ */
