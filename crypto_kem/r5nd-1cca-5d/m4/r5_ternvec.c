//	r5_ternvec.c
//	2019-09-21	Markku-Juhani O. Saarinen <mjos@pqshield.com>
//	Copyright (C) 2019, PQShield Ltd. Please see LICENSE.

//	Expand ternary vectors from seed

#include "r5_parameter_sets.h"
#include "r5_ternvec.h"
#include "r5_xof.h"
#include "little_endian.h"

#include <string.h>

#ifndef ROUND5_CT

//	create a sparse ternary vector (faster index type)

void r5_sparse_tern(r5_xof_ctx_t *xof, r5_ternv_t tv)
{
	size_t i;
	uint16_t x;
	uint8_t v[PARAMS_D];

	memset(v, 0, sizeof(v));				//	reset table

	for (i = 0; i < PARAMS_H; i++) {
		do {
			do {							//	uniform sampling
				r5_xof_squeeze(xof, &x, sizeof (x));
				x = LITTLE_ENDIAN16(x);
			} while (x >= PARAMS_RS_LIM);	//	RS_LIM = d * RS_DIV
			x /= PARAMS_RS_DIV;
		} while (v[x]);						//	is occupied ?
		v[x] = 1;							//	mark as occupied
		tv[i >> 1][i & 1] = x;				//	addition / subtract index
	}
}

#else	/* ROUND5_CT */

//	create a sparse ternary vector (slower constant time version)

void r5_sparse_tern(r5_xof_ctx_t *xof, r5_ternv_t tv)
{
	int h;
	size_t i, j;
	uint16_t x;
	uint64_t a, b, t;

	memset(tv, 0, sizeof(r5_ternv_t));

	//	mark >=d slots as occupied (uniform sampling)
#if (PARAMS_D & 0x3F) != 0
	tv[TVEC_WORDS - 1][0] = (~0llu) << (PARAMS_D & 0x3F);
#endif

	h = -PARAMS_H;							//	dummy rounds once h reaches 0

	for (i = 0; i < PARAMS_HMAX; i++) {		//	see "ct_compute_hi.py"

		r5_xof_squeeze(xof, &x, sizeof (x));
		x = LITTLE_ENDIAN16(x);
		x /= PARAMS_RS_DIV;					//	no uniform rejection here

		a = 1llu << (x & 0x3F);				//	bit selector
		b = 1llu << (x >> 6);				//	word selector

		a &= (((int64_t) h) >> 63);			//	set a to zero if h >= 0

		for (j = 0; j < TVEC_WORDS; j++) {
			t = (-(b & 1llu)) & a;			//	bit selector
			t &= ~tv[j][0];					//	is empty ?
			tv[j][0] |= t;					//	set as occupied (x1)
			//	-1 (11) or +1 (01), depending on the parity of h
			tv[j][1] |= (-((uint64_t) (h & 1))) & t;
			t |= t >> 1;					//	t == 0 ? 0 : 1
			t = (t^(-t)) >> 63;				//	(is there a faster way ?)
			h += t;							//	optional increment
			b >>= 1;						//	b & 1 == 1 when j == x >> 6
		}
	}
}

#endif /* ROUND5_CT */

