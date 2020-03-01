//	r5_parameter_sets.h
//	Copyright (c) 2019, PQShield Ltd. and Koninklijke Philips N.V.
//	Markku-Juhani O. Saarinen, Koninklijke Philips N.V.

#ifndef _R5_PARAMETER_SETS_H_
#define _R5_PARAMETER_SETS_H_

#include <stdint.h>
#include <stddef.h>

//	May or may not include the variant definiton
#include "round5_variant_setting.h"

#ifndef PQS_OLOCAL
#define PQS_OLOCAL
#endif

#ifndef PQS_INLINE
#define PQS_INLINE
#endif

//	Our NIST proposal parameter sets

#if defined(R5ND_1CPA_0d)
#define PARAMS_KAPPA_BYTES 16
#define PARAMS_D		   618
#define PARAMS_N		   618
#define PARAMS_H		   104
#define PARAMS_HMAX		   192
#define PARAMS_Q_BITS	   11
#define PARAMS_P_BITS	   8
#define PARAMS_T_BITS	   4
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   0
#define PARAMS_XE		   0
#define CRYPTO_ALGNAME	   "R5ND_1CPA_0d"

#elif defined(R5ND_3CPA_0d)
#define PARAMS_KAPPA_BYTES 24
#define PARAMS_D		   786
#define PARAMS_N		   786
#define PARAMS_H		   384
#define PARAMS_HMAX		   876
#define PARAMS_Q_BITS	   13
#define PARAMS_P_BITS	   9
#define PARAMS_T_BITS	   4
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   0
#define PARAMS_XE		   0
#define CRYPTO_ALGNAME	   "R5ND_3CPA_0d"

#elif defined(R5ND_5CPA_0d)
#define PARAMS_KAPPA_BYTES 32
#define PARAMS_D		   1018
#define PARAMS_N		   1018
#define PARAMS_H		   428
#define PARAMS_HMAX		   934
#define PARAMS_Q_BITS	   14
#define PARAMS_P_BITS	   9
#define PARAMS_T_BITS	   4
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   0
#define PARAMS_XE		   0
#define CRYPTO_ALGNAME	   "R5ND_5CPA_0d"

#elif defined(R5ND_1CCA_0d)
#define ROUND5_CCA
#define PARAMS_KAPPA_BYTES 16
#define PARAMS_D		   586
#define PARAMS_N		   586
#define PARAMS_H		   182
#define PARAMS_HMAX		   357
#define PARAMS_Q_BITS	   13
#define PARAMS_P_BITS	   9
#define PARAMS_T_BITS	   4
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   0
#define PARAMS_XE		   0
#define CRYPTO_ALGNAME	   "R5ND_1CCA_0d"

#elif defined(R5ND_3CCA_0d)
#define ROUND5_CCA
#define PARAMS_KAPPA_BYTES 24
#define PARAMS_D		   852
#define PARAMS_N		   852
#define PARAMS_H		   212
#define PARAMS_HMAX		   414
#define PARAMS_Q_BITS	   12
#define PARAMS_P_BITS	   9
#define PARAMS_T_BITS	   5
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   0
#define PARAMS_XE		   0
#define CRYPTO_ALGNAME	   "R5ND_3CCA_0d"

#elif defined(R5ND_5CCA_0d)
#define ROUND5_CCA
#define PARAMS_KAPPA_BYTES 32
#define PARAMS_D		   1170
#define PARAMS_N		   1170
#define PARAMS_H		   222
#define PARAMS_HMAX		   418
#define PARAMS_Q_BITS	   13
#define PARAMS_P_BITS	   9
#define PARAMS_T_BITS	   5
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   0
#define PARAMS_XE		   0
#define CRYPTO_ALGNAME	   "R5ND_5CCA_0d"

#elif defined(R5ND_1CPA_5d)
#define PARAMS_KAPPA_BYTES 16
#define PARAMS_D		   490
#define PARAMS_N		   490
#define PARAMS_H		   162
#define PARAMS_HMAX		   335
#define PARAMS_Q_BITS	   10
#define PARAMS_P_BITS	   7
#define PARAMS_T_BITS	   3
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   5
#define PARAMS_XE		   190
#define CRYPTO_ALGNAME	   "R5ND_1CPA_5d"

#elif defined(R5ND_3CPA_5d)
#define PARAMS_KAPPA_BYTES 24
#define PARAMS_D		   756
#define PARAMS_N		   756
#define PARAMS_H		   242
#define PARAMS_HMAX		   499
#define PARAMS_Q_BITS	   12
#define PARAMS_P_BITS	   8
#define PARAMS_T_BITS	   2
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   5
#define PARAMS_XE		   218
#define CRYPTO_ALGNAME	   "R5ND_3CPA_5d"

#elif defined(R5ND_5CPA_5d)
#define PARAMS_KAPPA_BYTES 32
#define PARAMS_D		   940
#define PARAMS_N		   940
#define PARAMS_H		   414
#define PARAMS_HMAX		   944
#define PARAMS_Q_BITS	   12
#define PARAMS_P_BITS	   8
#define PARAMS_T_BITS	   2
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   5
#define PARAMS_XE		   234
#define CRYPTO_ALGNAME	   "R5ND_5CPA_5d"

#elif defined(R5ND_1CCA_5d)
#define ROUND5_CCA
#define PARAMS_KAPPA_BYTES 16
#define PARAMS_D		   508
#define PARAMS_N		   508
#define PARAMS_H		   136
#define PARAMS_HMAX		   269
#define PARAMS_Q_BITS	   10
#define PARAMS_P_BITS	   7
#define PARAMS_T_BITS	   4
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   5
#define PARAMS_XE		   190
#define CRYPTO_ALGNAME	   "R5ND_1CCA_5d"

#elif defined(R5ND_3CCA_5d)
#define ROUND5_CCA
#define PARAMS_KAPPA_BYTES 24
#define PARAMS_D		   756
#define PARAMS_N		   756
#define PARAMS_H		   242
#define PARAMS_HMAX		   499
#define PARAMS_Q_BITS	   12
#define PARAMS_P_BITS	   8
#define PARAMS_T_BITS	   3
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   5
#define PARAMS_XE		   218
#define CRYPTO_ALGNAME	   "R5ND_3CCA_5d"

#elif defined(R5ND_5CCA_5d)
#define ROUND5_CCA
#define PARAMS_KAPPA_BYTES 32
#define PARAMS_D		   946
#define PARAMS_N		   946
#define PARAMS_H		   388
#define PARAMS_HMAX		   856
#define PARAMS_Q_BITS	   11
#define PARAMS_P_BITS	   8
#define PARAMS_T_BITS	   5
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   5
#define PARAMS_XE		   234
#define CRYPTO_ALGNAME	   "R5ND_5CCA_5d"

#elif defined(R5N1_1CPA_0d)
#define PARAMS_KAPPA_BYTES 16
#define PARAMS_D		   594
#define PARAMS_N		   1
#define PARAMS_H		   238
#define PARAMS_HMAX		   487
#define PARAMS_Q_BITS	   13
#define PARAMS_P_BITS	   10
#define PARAMS_T_BITS	   7
#define PARAMS_B_BITS	   3
#define PARAMS_N_BAR	   7
#define PARAMS_M_BAR	   7
#define PARAMS_F		   0
#define PARAMS_XE		   0
#define CRYPTO_ALGNAME	   "R5N1_1CPA_0d"

#elif defined(R5N1_3CPA_0d)
#define PARAMS_KAPPA_BYTES 24
#define PARAMS_D		   881
#define PARAMS_N		   1
#define PARAMS_H		   238
#define PARAMS_HMAX		   458
#define PARAMS_Q_BITS	   13
#define PARAMS_P_BITS	   10
#define PARAMS_T_BITS	   7
#define PARAMS_B_BITS	   3
#define PARAMS_N_BAR	   8
#define PARAMS_M_BAR	   8
#define PARAMS_F		   0
#define PARAMS_XE		   0
#define CRYPTO_ALGNAME	   "R5N1_3CPA_0d"

#elif defined(R5N1_5CPA_0d)
#define PARAMS_KAPPA_BYTES 32
#define PARAMS_D		   1186
#define PARAMS_N		   1
#define PARAMS_H		   712
#define PARAMS_HMAX		   1771
#define PARAMS_Q_BITS	   15
#define PARAMS_P_BITS	   12
#define PARAMS_T_BITS	   7
#define PARAMS_B_BITS	   4
#define PARAMS_N_BAR	   8
#define PARAMS_M_BAR	   8
#define PARAMS_F		   0
#define PARAMS_XE		   0
#define CRYPTO_ALGNAME	   "R5N1_5CPA_0d"

#elif defined(R5N1_1CCA_0d)
#define ROUND5_CCA
#define PARAMS_KAPPA_BYTES 16
#define PARAMS_D		   636
#define PARAMS_N		   1
#define PARAMS_H		   114
#define PARAMS_HMAX		   208
#define PARAMS_Q_BITS	   12
#define PARAMS_P_BITS	   9
#define PARAMS_T_BITS	   6
#define PARAMS_B_BITS	   2
#define PARAMS_N_BAR	   8
#define PARAMS_M_BAR	   8
#define PARAMS_F		   0
#define PARAMS_XE		   0
#define CRYPTO_ALGNAME	   "R5N1_1CCA_0d"

#elif defined(R5N1_3CCA_0d)
#define ROUND5_CCA
#define PARAMS_KAPPA_BYTES 24
#define PARAMS_D		   876
#define PARAMS_N		   1
#define PARAMS_H		   446
#define PARAMS_HMAX		   1017
#define PARAMS_Q_BITS	   15
#define PARAMS_P_BITS	   11
#define PARAMS_T_BITS	   7
#define PARAMS_B_BITS	   3
#define PARAMS_N_BAR	   8
#define PARAMS_M_BAR	   8
#define PARAMS_F		   0
#define PARAMS_XE		   0
#define CRYPTO_ALGNAME	   "R5N1_3CCA_0d"

#elif defined(R5N1_5CCA_0d)
#define ROUND5_CCA
#define PARAMS_KAPPA_BYTES 32
#define PARAMS_D		   1217
#define PARAMS_N		   1
#define PARAMS_H		   462
#define PARAMS_HMAX		   950
#define PARAMS_Q_BITS	   15
#define PARAMS_P_BITS	   12
#define PARAMS_T_BITS	   9
#define PARAMS_B_BITS	   4
#define PARAMS_N_BAR	   8
#define PARAMS_M_BAR	   8
#define PARAMS_F		   0
#define PARAMS_XE		   0
#define CRYPTO_ALGNAME	   "R5N1_5CCA_0d"

#elif defined(R5ND_0CPA_2iot)
#define PARAMS_KAPPA_BYTES 16
#define PARAMS_D		   372
#define PARAMS_N		   372
#define PARAMS_H		   178
#define PARAMS_HMAX		   403
#define PARAMS_Q_BITS	   11
#define PARAMS_P_BITS	   7
#define PARAMS_T_BITS	   3
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   2
#define PARAMS_XE		   53
#define CRYPTO_ALGNAME	   "R5ND_0CPA_2iot"

#elif defined(R5ND_1CPA_4longkey)
#define PARAMS_KAPPA_BYTES 24
#define PARAMS_D		   490
#define PARAMS_N		   490
#define PARAMS_H		   162
#define PARAMS_HMAX		   335
#define PARAMS_Q_BITS	   10
#define PARAMS_P_BITS	   7
#define PARAMS_T_BITS	   3
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   1
#define PARAMS_M_BAR	   1
#define PARAMS_F		   4
#define PARAMS_XE		   163
#define CRYPTO_ALGNAME	   "R5ND_1CPA_4longkey"

#elif defined(R5N1_3CCA_0smallCT)
#define ROUND5_CCA
#define PARAMS_KAPPA_BYTES 24
#define PARAMS_D		   757
#define PARAMS_N		   1
#define PARAMS_H		   378
#define PARAMS_HMAX		   882
#define PARAMS_Q_BITS	   14
#define PARAMS_P_BITS	   9
#define PARAMS_T_BITS	   4
#define PARAMS_B_BITS	   1
#define PARAMS_N_BAR	   192
#define PARAMS_M_BAR	   1
#define PARAMS_F		   0
#define PARAMS_XE		   0
#define CRYPTO_ALGNAME	   "R5N1_3CCA_0smallCT"

#else
#error "Algorithm variant not defined"
#endif

// helper functions
#define DIV_CEIL(a,b) ((a+b-1)/b)
#define BITS_TO_BYTES(b) ((b + 7) / 8)

// appropriate types
typedef uint16_t modq_t;
#if (PARAMS_P_BITS <= 8)
typedef uint8_t modp_t;
#else
typedef uint16_t modp_t;
#endif
typedef uint8_t modt_t;

#define PARAMS_Q		(1 << PARAMS_Q_BITS)
#define PARAMS_Q_MASK	(PARAMS_Q - 1)
#define PARAMS_P		(1 << PARAMS_P_BITS)
#define PARAMS_P_MASK	(PARAMS_P - 1)
#define PARAMS_KAPPA	(8 * PARAMS_KAPPA_BYTES)
#define PARAMS_MU		DIV_CEIL((PARAMS_KAPPA + PARAMS_XE), PARAMS_B_BITS)
#define PARAMS_MUT_SIZE BITS_TO_BYTES(PARAMS_MU * PARAMS_T_BITS)

#define PARAMS_RS_DIV	(0x10000 / PARAMS_D)
#define PARAMS_RS_LIM	(PARAMS_D * PARAMS_RS_DIV)
#if (PARAMS_N == PARAMS_D)
#define PARAMS_NDP_SIZE BITS_TO_BYTES(PARAMS_D * PARAMS_P_BITS)
#else
#define PARAMS_DP_SIZE	BITS_TO_BYTES(PARAMS_N_BAR * PARAMS_D * PARAMS_P_BITS)
#define PARAMS_DPU_SIZE BITS_TO_BYTES(PARAMS_M_BAR * PARAMS_D * PARAMS_P_BITS)
#endif

// Rounding constants
#if ((PARAMS_Q_BITS - PARAMS_P_BITS + PARAMS_T_BITS) < PARAMS_P_BITS)
#define PARAMS_Z_BITS	PARAMS_P_BITS
#else
#define PARAMS_Z_BITS	(PARAMS_Q_BITS - PARAMS_P_BITS + PARAMS_T_BITS)
#endif
#define PARAMS_H1		(1 << (PARAMS_Q_BITS - PARAMS_P_BITS - 1))
#define PARAMS_H2		(1 << (PARAMS_Q_BITS - PARAMS_Z_BITS - 1))
#define PARAMS_H3		((1 << (PARAMS_P_BITS - PARAMS_T_BITS - 1)) + (1 << (PARAMS_P_BITS - PARAMS_B_BITS - 1)) - (1 << (PARAMS_Q_BITS - PARAMS_Z_BITS - 1)))

// Used for n=1 when Tau=2
#define PARAM_TAU2_A_RANDOM 0x800

// Public key and ciphertext

#if (PARAMS_N == PARAMS_D)
#define PARAMS_PK_SIZE	(PARAMS_KAPPA_BYTES + PARAMS_NDP_SIZE)
#define PARAMS_CT_SIZE	(PARAMS_NDP_SIZE + PARAMS_MUT_SIZE)
#else
#define PARAMS_PK_SIZE	(PARAMS_KAPPA_BYTES + PARAMS_DP_SIZE)
#define PARAMS_CT_SIZE	(PARAMS_DPU_SIZE + PARAMS_MUT_SIZE)
#endif

// Derive the NIST parameters

#ifdef ROUND5_CCA

//	CCA KEM Variant
#define CRYPTO_SECRETKEYBYTES  (PARAMS_KAPPA_BYTES + PARAMS_KAPPA_BYTES + PARAMS_PK_SIZE)
#define CRYPTO_PUBLICKEYBYTES  PARAMS_PK_SIZE
#define CRYPTO_BYTES		   PARAMS_KAPPA_BYTES
#define CRYPTO_CIPHERTEXTBYTES (PARAMS_CT_SIZE + PARAMS_KAPPA_BYTES)

/*
// CCA PKE Variant
#define CRYPTO_SECRETKEYBYTES  (PARAMS_KAPPA_BYTES + PARAMS_KAPPA_BYTES + PARAMS_PK_SIZE)
#define CRYPTO_PUBLICKEYBYTES  PARAMS_PK_SIZE
#define CRYPTO_BYTES			(PARAMS_CT_SIZE + PARAMS_KAPPA_BYTES + 16)
*/

#else

// CPA KEM Variant
#define CRYPTO_SECRETKEYBYTES  PARAMS_KAPPA_BYTES
#define CRYPTO_PUBLICKEYBYTES  PARAMS_PK_SIZE
#define CRYPTO_BYTES			PARAMS_KAPPA_BYTES
#define CRYPTO_CIPHERTEXTBYTES PARAMS_CT_SIZE

#endif /* ROUND5_CCA */

#endif /* _R5_PARAMETER_SETS_H_ */

