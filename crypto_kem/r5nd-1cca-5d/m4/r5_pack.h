//	r5_pack.h
//	2019-10-31	Markku-Juhani O. Saarinen <mjos@pqshield.com>
//	Copyright (c) 2019, PQShield Ltd. All rights reserved.

#ifndef _R5_PACK_H_
#define _R5_PACK_H_
#include "r5_parameter_sets.h"
#if (PARAMS_N == PARAMS_D)

// compress ND elements of q bits into p bits and pack into a byte string
PQS_INLINE void r5_pack_q_p(uint8_t *pv, const modq_t *vq, modq_t rc);

//	unpack a byte string into ND elements of p bits
PQS_INLINE void r5_unpack_p(modp_t *vp, const uint8_t *pv);

#endif	/* (PARAMS_N == PARAMS_D) */
#endif	/* _R5_PACK_H_ */

