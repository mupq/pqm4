//  r5_addsub.c
//  2019-03-10  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (C) 2019, PQShield Ltd. Please see LICENSE.

//  Addition-subtraction loops. The right number of of combined elements
//  depends on the register file structure of the target -- ARM allows
//  basically any register to be used as a pointer, which is a benefit.

//  PQSOC implementations do not use these

#include "r5_parameter_sets.h"
#include "r5_ternvec.h"
#include "r5_addsub.h"

#if !defined(ROUND5_CT)
#if (!defined(PQSOC) || (PARAMS_N == 1))

#if !defined(ARMV7_ASM)

//  Basic generic C versions

void r5_modq_addsub_d(modq_t * dst, const modq_t * p_add, const modq_t * p_sub)
{
	size_t i;

	for (i = 0; i < PARAMS_D; i++) {
		dst[i] += p_add[i] - p_sub[i];
	}
}

void r5_modq_addsub3_d(modq_t * dst,
					   const modq_t * p_add1, const modq_t * p_sub1,
					   const modq_t * p_add2, const modq_t * p_sub2,
					   const modq_t * p_add3, const modq_t * p_sub3)
{
	size_t i;

	for (i = 0; i < PARAMS_D; i++) {
		dst[i] += p_add1[i] - p_sub1[i]
			+ p_add2[i] - p_sub2[i]
			+ p_add3[i] - p_sub3[i];
	}
}
#endif

#endif										/* !defined(PQSOC) && (PARAMS_N == PARAMS_D) */

#if (PARAMS_N == 1)

//  only used in r5_matmul.c

#if !defined(ARMV7_ASM)

void r5_modq_addsub_perm_nbar_d(modq_t * dst, const uint16_t * perm,
								const modq_t * p_add, const modq_t * p_sub)
{
	size_t i, j, k;

	i = 0;
	for (j = 0; j < PARAMS_D; j++) {
		k = perm[j];
		dst[i] += p_add[k] - p_sub[k];
		i += PARAMS_N_BAR;
	}
}

//  only used in r5_matmul.c

void r5_modq_addsub3_perm_nbar_d(modq_t * dst, const uint16_t * perm,
								 const modq_t * p_add1, const modq_t * p_sub1,
								 const modq_t * p_add2, const modq_t * p_sub2,
								 const modq_t * p_add3, const modq_t * p_sub3)
{
	size_t i, j, k;

	i = 0;
	for (j = 0; j < PARAMS_D; j++) {
		k = perm[j];
		dst[i] += p_add1[k] - p_sub1[k]
			+ p_add2[k] - p_sub2[k]
			+ p_add3[k] - p_sub3[k];
		i += PARAMS_N_BAR;
	}
}
#endif

#else										/* PARAMS_N != 1 */

#if !defined(ARMV7_ASM)

void r5_modp_addsub_mu(modp_t * dst,
					   const modp_t * p_add, const modp_t * p_sub)
{
	size_t i;

	for (i = 0; i < PARAMS_MU; i++) {
		dst[i] += p_add[i] - p_sub[i];
	}
}

#endif

#endif										/* PARAMS_N == 1 */

#endif										/* (!defined(ARMV7_ASM) && !defined(ROUND5_CT)) */
