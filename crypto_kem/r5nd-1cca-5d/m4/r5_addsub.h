//	r5_addsub.h
//	2019-03-10	Markku-Juhani O. Saarinen <mjos@pqshield.com>
//	Copyright (c) 2019, PQShield Ltd. All rights reserved.

//	Low-level functions for handling ternary vectors.

#ifndef _R5_ADDSUB_H_
#define _R5_ADDSUB_H_

#include "r5_parameter_sets.h"
#include "r5_ternvec.h"

#ifndef ARMV7_ASM
#ifndef ROUND5_CT
#if PARAMS_N == 1

//	functions used by matrix code */

PQS_OLOCAL void r5_modq_addsub_d(modq_t *dst,
	const modq_t *p_add, const modq_t *p_sub);

PQS_OLOCAL void r5_modq_addsub3_d(modq_t *dst,
	const modq_t *p_add1, const modq_t *p_sub1,
	const modq_t *p_add2, const modq_t *p_sub2,
	const modq_t *p_add3, const modq_t *p_sub3);

//	only used in r5_matmul.c
PQS_OLOCAL void r5_modq_addsub_perm_nbar_d(modq_t *dst, const uint16_t *perm,
	const modq_t *p_add, const modq_t *p_sub);

//	only used in r5_matmul.c
PQS_OLOCAL void r5_modq_addsub3_perm_nbar_d(modq_t *dst, const uint16_t *perm,
	const modq_t *p_add1, const modq_t *p_sub1,
	const modq_t *p_add2, const modq_t *p_sub2,
	const modq_t *p_add3, const modq_t *p_sub3);

#else	/* PARAMS_N != 1 */

//	functions used by ring code */

#ifndef PQSOC

PQS_OLOCAL void r5_modq_addsub_d(modq_t *dst,
	const modq_t *p_add, const modq_t *p_sub);

PQS_OLOCAL void r5_modq_addsub3_d(modq_t *dst,
	const modq_t *p_add1, const modq_t *p_sub1,
	const modq_t *p_add2, const modq_t *p_sub2,
	const modq_t *p_add3, const modq_t *p_sub3);

PQS_OLOCAL void r5_modp_addsub_mu(modp_t *dst,
	const modp_t *p_add, const modp_t *p_sub);

#endif /* !defined(PQSOC) */

#endif /* PARAMS_N == 1 */
#endif

#else	/* ARMV7_ASM */

//	ARMv7 code is little bit different

PQS_OLOCAL void r5_armv7_addsub8(uint8_t *dst, size_t n,
	const uint8_t *p_add, const uint8_t *p_sub);

PQS_OLOCAL void r5_armv7_addsub16(uint16_t *dst, size_t n,
	const uint16_t *p_add, const uint16_t *p_sub);

#define r5_modq_addsub_d(dst, p_add, p_sub) \
	{ r5_armv7_addsub16(dst, PARAMS_D, p_add, p_sub); }

#if (PARAMS_P_BITS <= 8)
#define r5_modp_addsub_mu(dst, p_add, p_sub) \
	{ r5_armv7_addsub8(dst, PARAMS_MU, p_add, p_sub); }
#else
#define r5_modp_addsub_mu(dst, p_add, p_sub) \
	{ r5_armv7_addsub16(dst, PARAMS_MU, p_add, p_sub); }
#endif

PQS_OLOCAL void r5_armv7_addsub16_3(uint16_t *dst, size_t n,
	const uint16_t *p_add1, const uint16_t *p_sub1,
	const uint16_t *p_add2, const uint16_t *p_sub2,
	const uint16_t *p_add3, const uint16_t *p_sub3);

#define r5_modq_addsub3_d(dst, p_add1, p_sub1, p_add2, p_sub2, p_add3, p_sub3) \
	r5_armv7_addsub16_3(dst, PARAMS_D, \
		p_add1, p_sub1, p_add2, p_sub2, p_add3, p_sub3)

PQS_OLOCAL void r5_armv7_addsub16_perm(modq_t *dst, size_t n, size_t m,
	const uint16_t *perm, const uint16_t *p_add, const uint16_t *p_sub);

#define r5_modq_addsub_perm_nbar_d(dst, perm, p_add, p_sub) \
	r5_armv7_addsub16_perm(dst, PARAMS_D, PARAMS_N_BAR, perm, p_add, p_sub)

PQS_OLOCAL void r5_armv7_addsub16_perm_3(modq_t *dst, size_t n, size_t m,
	const uint16_t *perm,
	const uint16_t *p_add1, const uint16_t *p_sub1,
	const uint16_t *p_add2, const uint16_t *p_sub2,
	const uint16_t *p_add3, const uint16_t *p_sub3);

#define r5_modq_addsub3_perm_nbar_d(dst, perm, \
		p_add1, p_sub1, p_add2, p_sub2, p_add3, p_sub3) \
	r5_armv7_addsub16_perm_3(dst, PARAMS_D, PARAMS_N_BAR, perm, \
		p_add1, p_sub1, p_add2, p_sub2, p_add3, p_sub3)


#endif /* ARMV7_ASM */

#endif /* _R5_ADDSUB_H_ */

