//	r5_ringmul_ct.c
//	2019-09-21	Markku-Juhani O. Saarinen <mjos@pqshield.com>
//	Copyright (c) 2019, PQShield Ltd. All rights reserved.

//	Constant-time ring arithmetic (slow!)

#include "r5_parameter_sets.h"

#if (PARAMS_N == PARAMS_D) && defined(ROUND5_CT)

#include <string.h>
#include "r5_ringmul.h"
#include "r5_xof.h"
#include "r5_pack.h"

// multiplication mod q, result length n

void r5_ringmul_q(modq_t d[PARAMS_D],
	const uint8_t sigma[PARAMS_KAPPA_BYTES],
	const r5_ternv_t sv)
{
	modq_t aa[2 * (PARAMS_D + 1)];
	size_t i, j, k;
	modq_t addf, subf, w, *b;
	uint64_t t, u;
	modq_t *a = aa;

	//	expand a
	r5_xof(a, PARAMS_D * sizeof (modq_t), sigma, PARAMS_KAPPA_BYTES);
#if __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__
	for (i = 0; i < PARAMS_D; i++) {
		a[i] = LITTLE_ENDIAN16(a[i]);
#endif

	//	note: order of coefficients a[1..n] is *NOT* reversed!
	//	"lift" -- multiply by (x - 1)
	a[PARAMS_D] = a[PARAMS_D - 1];
	for (i = PARAMS_D - 1; i >= 1; i--) {
		a[i] = a[i - 1] - a[i];
	}
	a[0] = -a[0];

	//	duplicate at the end
	b = &a[PARAMS_D + 1];
	memcpy(b, a, (PARAMS_D + 1) * sizeof(modq_t));

	//	initialize result
	memset(d, 0, PARAMS_D * sizeof(modq_t));

	a++;								//	adjust for comparison
	for (k = 0; k < TVEC_WORDS; k++) {
		t = sv[k][0] & ~sv[k][1];		//	addition mask
		u = sv[k][0] & sv[k][1];		//	subtraction mask
		for (i = 0; i < 64; i++) {
			addf = -(t & 1);			//	expand lsb
			subf = -(u & 1);
			for (j = 0; j < PARAMS_D; j++) {
				w = b[j];				// no multiplication here!
				w = (addf & w) - (subf & w);
				d[j] += w;
			}
			b--;
			if (b == a)
				break;
			t >>= 1;
			u >>= 1;
		}
	}

	//	"unlift"
	d[0] = -d[0];
	for (i = 1; i < PARAMS_D; i++) {
		d[i] = d[i - 1] - d[i];
	}
}

// multiplication mod p, result length mu

void r5_ringmul_p(modp_t d[PARAMS_MU],
	const uint8_t *pv, const r5_ternv_t sv)
{
	modp_t aa[PARAMS_D + PARAMS_MU + 2];
	modp_t addf, subf, w, *b;
	size_t i, j, k;
	uint64_t t, u;
	modp_t *a = aa;

	r5_unpack_p(a, pv);					//	unpack a

	//	note: order of coefficients p[1..N] is *NOT* reversed!
#if (PARAMS_XE == 0)
	//	without error correction we "lift" -- i.e. multiply by (x - 1)
	a[PARAMS_D] = a[PARAMS_D - 1];
	for (i = PARAMS_D - 1; i >= 1; i--) {
		a[i] = a[i - 1] - a[i];
	}
	a[0] = -a[0];
#else
	a[PARAMS_D] = 0;
	a[PARAMS_D + 1] = a[0];
	a++;								//	don't lift, shift!
#endif
	b = &a[PARAMS_D + 1];
	memcpy(b, a, PARAMS_MU * sizeof(modp_t));

	//	initialize result
	memset(d, 0, (PARAMS_MU) * sizeof(modp_t));

	a++;								//	adjust for comparison
	for (k = 0; k < TVEC_WORDS; k++) {
		t = sv[k][0] & ~sv[k][1];		//	addition mask
		u = sv[k][0] & sv[k][1];		//	subtraction mask
		for (i = 0; i < 64; i++) {
			addf = -(t & 1);			//	expand lsb
			subf = -(u & 1);
			for (j = 0; j < PARAMS_MU; j++) {
				w = b[j];				// no multiplication here!
				w = (addf & w) - (subf & w);
				d[j] += w;
			}
			b--;
			if (b == a)
				break;
			t >>= 1;
			u >>= 1;
		}
	}

#if (PARAMS_XE == 0)
	//	without error correction we "lifted" so we now need to "unlift"
	d[0] = -d[0];
	for (i = 1; i < PARAMS_MU; ++i) {
		d[i] = d[i - 1] - d[i];
	}
#endif
}

#endif	/* (PARAMS_N == PARAMS_D) && defined(ROUND5_CT) */
