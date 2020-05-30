//  r5_pack.c
//  2019-10-31  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (c) 2019, PQShield Ltd. All rights reserved.

#include "r5_parameter_sets.h"
#if (PARAMS_N == PARAMS_D)
#include "r5_pack.h"

#include <string.h>

//  compress ND elements of q bits into p bits and pack into a byte string

void r5_pack_q_p(uint8_t * pv, const modq_t * vq, modq_t rc)
{
#if (PARAMS_P_BITS == 8)
	size_t i;

	for (i = 0; i < PARAMS_D; i++) {
		pv[i] = (uint8_t) (((vq[i] + rc) >>
							(PARAMS_Q_BITS - PARAMS_P_BITS)) & (PARAMS_P - 1));
	}
#else
	size_t i, j;
	modp_t t;

	memset(pv, 0, PARAMS_NDP_SIZE);
	j = 0;
	for (i = 0; i < PARAMS_D; i++) {
		t = ((vq[i] + rc) >> (PARAMS_Q_BITS - PARAMS_P_BITS)) & (PARAMS_P - 1);
		pv[j >> 3] = (uint8_t) (pv[j >> 3] | (t << (j & 7)));	// pack p bits
		if ((j & 7) + PARAMS_P_BITS > 8) {
			pv[(j >> 3) + 1] =
				(uint8_t) (pv[(j >> 3) + 1] | (t >> (8 - (j & 7))));
		}
		j += PARAMS_P_BITS;
	}
#endif
}

//  unpack a byte string into ND elements of p bits

void r5_unpack_p(modp_t * vp, const uint8_t * pv)
{
#if (PARAMS_P_BITS == 8)
	memcpy(vp, pv, PARAMS_D);
#else
	size_t i, j;
	modp_t t;

	j = 0;
	for (i = 0; i < PARAMS_D; i++) {
		t = (modp_t) (pv[j >> 3] >> (j & 7));	//      unpack p bits
		if ((j & 7) + PARAMS_P_BITS > 8) {
			t = (modp_t) (t | ((modp_t) pv[(j >> 3) + 1]) << (8 - (j & 7)));
		}
		vp[i] = t & (PARAMS_P - 1);
		j += PARAMS_P_BITS;
	}
#endif
}

#endif										/* (PARAMS_N == PARAMS_D) */
