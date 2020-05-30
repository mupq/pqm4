//  r5_ringmul.c
//  2019-07-16  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (c) 2019, PQShield Ltd. All rights reserved.

//  Fast ring arithmetic (without cache attack countermeasures)

#include "r5_parameter_sets.h"

#if (PARAMS_N == PARAMS_D) && !defined(ROUND5_CT) && !defined(PQSOC)

#include <string.h>

#include "r5_ringmul.h"
#include "r5_xofgen.h"
#include "r5_addsub.h"
#include "r5_pack.h"
#include "little_endian.h"

// multiplication mod q, result length n

void r5_ringmul_q(modq_t d[PARAMS_D],
				  const uint8_t sigma[PARAMS_KAPPA_BYTES], const r5_ternv_t sv)
{
	modq_t a[2 * (PARAMS_D + 1)];
	size_t i;

	//  expand a
	r5_xof_agen(a, PARAMS_D * sizeof(modq_t),
				((PARAMS_D + AGEN_NBLOCKS -
				  1) / AGEN_NBLOCKS) * sizeof(modq_t), sigma);

#if __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__
	for (i = 0; i < PARAMS_D; i++) {
		a[i] = LITTLE_ENDIAN16(a[i]);
	}
#endif

	//  note: order of coefficients a[1..n] is *NOT* reversed!
	//  "lift" -- multiply by (x - 1)
	a[PARAMS_D] = a[PARAMS_D - 1];
	for (i = PARAMS_D - 1; i >= 1; i--) {
		a[i] = a[i - 1] - a[i];
	}
	a[0] = -a[0];

	//  duplicate at the end
	memcpy(&a[PARAMS_D + 1], a, (PARAMS_D + 1) * sizeof(modq_t));

	//  initialize result
	memset(d, 0, PARAMS_D * sizeof(modq_t));

	for (i = 0; i < (PARAMS_H / 2) - 2; i += 3) {
		r5_modq_addsub3_d(d, &a[(PARAMS_D + 1) - sv[i][0]],
						  &a[(PARAMS_D + 1) - sv[i][1]],
						  &a[(PARAMS_D + 1) - sv[i + 1][0]],
						  &a[(PARAMS_D + 1) - sv[i + 1][1]],
						  &a[(PARAMS_D + 1) - sv[i + 2][0]],
						  &a[(PARAMS_D + 1) - sv[i + 2][1]]);
	}

	while (i < PARAMS_H / 2) {
		r5_modq_addsub_d(d, &a[(PARAMS_D + 1) - sv[i][0]],
						 &a[(PARAMS_D + 1) - sv[i][1]]);
		i++;
	}

	//  "unlift"
	d[0] = -d[0];
	for (i = 1; i < PARAMS_D; i++) {
		d[i] = d[i - 1] - d[i];
	}
}

// multiplication mod p, result length mu

void r5_ringmul_p(modp_t d[PARAMS_MU], const uint8_t * pv, const r5_ternv_t sv)
{
	size_t i;
	modp_t aa[PARAMS_D + PARAMS_MU + 2];
	modp_t *a = aa;

	r5_unpack_p(a, pv);						//  unpack a

	//  note: order of coefficients p[1..N] is *NOT* reversed!
#if (PARAMS_XE == 0)
	//  without error correction we "lift" -- i.e. multiply by (x - 1)
	a[PARAMS_D] = a[PARAMS_D - 1];
	for (i = PARAMS_D - 1; i >= 1; i--) {
		a[i] = a[i - 1] - a[i];
	}
	a[0] = -a[0];
#else
	a[PARAMS_D] = 0;
	a[PARAMS_D + 1] = a[0];
	a++;									//  don't lift, shift!
#endif

	memcpy(&a[PARAMS_D + 1], a, PARAMS_MU * sizeof(modp_t));

	//  initialize result
	memset(d, 0, (PARAMS_MU) * sizeof(modp_t));

	for (i = 0; i < PARAMS_H / 2; i++) {
		r5_modp_addsub_mu(d,
						  &a[PARAMS_D + 1 - sv[i][0]],
						  &a[PARAMS_D + 1 - sv[i][1]]);
	}

#if (PARAMS_XE == 0)
	//  without error correction we "lifted" so we now need to "unlift"
	d[0] = -d[0];
	for (i = 1; i < PARAMS_MU; ++i) {
		d[i] = d[i - 1] - d[i];
	}
#endif
}

#endif
