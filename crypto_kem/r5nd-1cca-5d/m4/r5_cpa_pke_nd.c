//	r5_cpa_pke_nd.c
//	2019-10-31	Markku-Juhani O. Saarinen <mjos@pqshield.com>
//	Copyright (c) 2019, PQShield Ltd. All rights reserved.

#include "r5_parameter_sets.h"

#if (PARAMS_N == PARAMS_D)

#include <string.h>

#include "little_endian.h"
#include "r5_cpa_pke.h"
#include "r5_ringmul.h"
#include "r5_xof.h"
#include "r5_pack.h"
#include "randombytes.h"
#include "xef.h"

//	secret vector

static void r5_create_secret_vec(r5_ternv_t sv,
	const uint8_t seed[PARAMS_KAPPA_BYTES])
{
	r5_xof_ctx_t xof;

	r5_xof_input(&xof, seed, PARAMS_KAPPA_BYTES);
	r5_sparse_tern(&xof, sv);
}


// generate a keypair (sigma, B)

int r5_cpa_pke_keygen(uint8_t *pk, uint8_t *sk)
{

	modq_t b[PARAMS_D];
	r5_ternv_t s_v;

	randombytes(pk, PARAMS_KAPPA_BYTES); // sigma = seed of A

	randombytes(sk, PARAMS_KAPPA_BYTES); // secret key -- Random S
	r5_create_secret_vec(s_v, sk);

	r5_ringmul_q(b, pk, s_v); // B = A * S

	// Compress B q_bits -> p_bits, pk = sigma | B
	r5_pack_q_p(pk + PARAMS_KAPPA_BYTES, b, PARAMS_H1);

	return 0;
}

int r5_cpa_pke_encrypt(uint8_t *ct, const uint8_t *pk,
	const uint8_t *m, const uint8_t *rho)
{
	size_t i, j;
	r5_ternv_t r_v;
	modq_t u_t[PARAMS_D];
	modp_t x[PARAMS_MU];
	uint8_t m1[BITS_TO_BYTES(PARAMS_MU * PARAMS_B_BITS)];
	modp_t t, tm;

	memcpy(m1, m, PARAMS_KAPPA_BYTES); // add error correction code
	memset(m1 + PARAMS_KAPPA_BYTES, 0,
		BITS_TO_BYTES(PARAMS_MU * PARAMS_B_BITS) - PARAMS_KAPPA_BYTES);
#if (PARAMS_XE != 0)
	XEF_COMPUTE(m1, PARAMS_KAPPA_BYTES, PARAMS_F);
#endif

	// Create R
	r5_create_secret_vec(r_v, rho);

	r5_ringmul_q(u_t, pk, r_v);			// U^T = U = A^T * R = A * R (mod q)
	r5_pack_q_p(ct, u_t, PARAMS_H2);	// ct = U^T | v

	// X = B * R  (mod p)
	r5_ringmul_p(x, pk + PARAMS_KAPPA_BYTES, r_v);
	memset(ct + PARAMS_NDP_SIZE, 0, PARAMS_MUT_SIZE);

	j = 8 * PARAMS_NDP_SIZE;
	for (i = 0; i < PARAMS_MU; i++) {	// compute, pack v
		// compress p->t
		t = ((x[i] + PARAMS_H2) >> (PARAMS_P_BITS - PARAMS_T_BITS));
		// add message
		tm = (m1[(i * PARAMS_B_BITS) >> 3] >>
				((i * PARAMS_B_BITS) & 7));
#if (8 % PARAMS_B_BITS != 0)
		if (((i * PARAMS_B_BITS) & 7) + PARAMS_B_BITS > 8) {
			/* Get spill over from next message byte */
			tm = (tm | (m1[((i * PARAMS_B_BITS) >> 3) + 1]
					<< (8 - ((i * PARAMS_B_BITS) & 7))));
		}
#endif
		t = (t + ((tm & ((1 << PARAMS_B_BITS) - 1))
			<< (PARAMS_T_BITS - PARAMS_B_BITS))) & ((1 << PARAMS_T_BITS) - 1);

		ct[j >> 3] = (ct[j >> 3] | (t << (j & 7))); // pack t bits
		if ((j & 7) + PARAMS_T_BITS > 8) {
			ct[(j >> 3) + 1] = (ct[(j >> 3) + 1] | (t >> (8 - (j & 7))));
		}
		j += PARAMS_T_BITS;
	}

	return 0;
}

int r5_cpa_pke_decrypt(uint8_t *m, const uint8_t *sk, const uint8_t *ct)
{
	size_t i, j;
	r5_ternv_t s_v;
	modp_t v[PARAMS_MU];
	modp_t t, x_prime[PARAMS_MU];
	uint8_t m1[BITS_TO_BYTES(PARAMS_MU * PARAMS_B_BITS)];

	r5_create_secret_vec(s_v, sk);


	j = 8 * PARAMS_NDP_SIZE;
	for (i = 0; i < PARAMS_MU; i++) {
		t = (modp_t) (ct[j >> 3] >> (j & 7)); // unpack t bits
		if ((j & 7) + PARAMS_T_BITS > 8) {
			t = (modp_t) (t | ct[(j >> 3) + 1] << (8 - (j & 7)));
		}
		v[i] = t & ((1 << PARAMS_T_BITS) - 1);
		j += PARAMS_T_BITS;
	}

	// X' = U * S (mod p)
	r5_ringmul_p(x_prime, ct, s_v);			// ct = U^T | v

	// X' = v - X', compressed to 1 bit
	modp_t x_p;
	memset(m1, 0, sizeof(m1));
	for (i = 0; i < PARAMS_MU; i++) {
		// v - X' as mod p value (to be able to perform the rounding!)
		x_p = ((v[i] << (PARAMS_P_BITS - PARAMS_T_BITS)) - x_prime[i]);
		x_p = (((x_p + PARAMS_H3) >> (PARAMS_P_BITS - PARAMS_B_BITS)) &
				((1 << PARAMS_B_BITS) - 1));
		m1[(i * PARAMS_B_BITS) >> 3] = (m1[i * PARAMS_B_BITS >> 3] |
										(x_p << ((i * PARAMS_B_BITS) & 7)));
#if (8 % PARAMS_B_BITS != 0)
		if (((i * PARAMS_B_BITS) & 7) + PARAMS_B_BITS > 8) {
			/* Spill over to next message byte */
			m1[(i * PARAMS_B_BITS >> 3) + 1] =
				m1[((i * PARAMS_B_BITS) >> 3) + 1] |
					(x_p >> (8 - ((i * PARAMS_B_BITS) & 7)));
		}
#endif
	}

#if (PARAMS_XE != 0)
	// Apply error correction
	XEF_COMPUTE(m1, PARAMS_KAPPA_BYTES, PARAMS_F);
	XEF_FIXERR(m1, PARAMS_KAPPA_BYTES, PARAMS_F);
#endif
	memcpy(m, m1, PARAMS_KAPPA_BYTES);

	return 0;
}

#endif

