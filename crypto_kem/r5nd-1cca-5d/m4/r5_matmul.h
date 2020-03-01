//	r5_matmul.h
//	Copyright (c) 2019, PQShield Ltd. and Koninklijke Philips N.V.

#ifndef _R5_MATMUL_H_
#define _R5_MATMUL_H_

#include "r5_parameter_sets.h"
#include "r5_ternvec.h"

#if (PARAMS_N == 1)

void r5_matmul_as_q(modq_t d[PARAMS_D][PARAMS_N_BAR],
	modq_t a[PARAM_TAU2_A_RANDOM + PARAMS_D],
	const uint16_t a_perm[PARAMS_D],
	const r5_ternv_t s_t[PARAMS_N_BAR]);

void r5_matmul_ra_q(modq_t d[PARAMS_M_BAR][PARAMS_D],
	modq_t a[PARAM_TAU2_A_RANDOM + PARAMS_D],
	const uint16_t a_perm[PARAMS_D],
	const r5_ternv_t r_t[PARAMS_M_BAR]);

void r5_matmul_us_p(modp_t d[PARAMS_MU],
	const modp_t u_t[PARAMS_M_BAR][PARAMS_D],
	const r5_ternv_t s_t[PARAMS_N_BAR]);

void r5_matmul_rb_p(modp_t d[PARAMS_MU],
	const modp_t b[PARAMS_D][PARAMS_N_BAR],
	const r5_ternv_t r_t[PARAMS_M_BAR]);

#endif

#endif /* _R5_MATMUL_H_ */
