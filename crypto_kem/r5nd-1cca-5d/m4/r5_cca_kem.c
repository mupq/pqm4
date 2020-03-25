//	r5_cca_kem.c
//	2019-10-31	Markku-Juhani O. Saarinen <mjos@pqshield.com>
//	Copyright (c) 2019, PQShield Ltd. and Koninklijke Philips N.V.

//	Implementation of NIST KEM API - **CCA** KEMs

#include "r5_parameter_sets.h"

#ifdef ROUND5_CCA

#include <string.h>

#include "nist_kem.h"
#include "r5_cpa_pke.h"
#include "randombytes.h"
#include "r5_xof.h"

// constant time comparison; return nonzero if not equal

static uint8_t ct_memcmp(const void *a, const void *b, size_t len)
{
	const uint8_t *a8 = (const uint8_t *) a;
	const uint8_t *b8 = (const uint8_t *) b;
	uint32_t r = 0;
	size_t i;

	for (i = 0; i < len; i++) {
		r |= a8[i] ^ b8[i];
	}

	return (int) ((-r) >> 31);
}

// conditional move; overwrite d with a if flag is nonzero

static void ct_cmov(void *d, const void * a, uint8_t flag, size_t len)
{
	uint8_t *d8 = (uint8_t *) d;
	const uint8_t *a8 = (const uint8_t *) a;
	size_t i;
	flag = -(flag & 1);						// 0x00 or 0xFF
	for (i = 0; i < len; i++) {
		d8[i] ^= flag & (d8[i] ^ a8[i]);
	}
}

//	CCA-KEM KeyGen()

int crypto_kem_keypair(uint8_t *pk, uint8_t *sk)
{
	uint8_t y[PARAMS_KAPPA_BYTES];

	/* Generate the base key pair */
	r5_cpa_pke_keygen(pk, sk);

	/* Append y and pk to sk */
	randombytes(y, PARAMS_KAPPA_BYTES);
	memcpy(sk + PARAMS_KAPPA_BYTES, y, PARAMS_KAPPA_BYTES);
	memcpy(sk + PARAMS_KAPPA_BYTES + PARAMS_KAPPA_BYTES, pk, PARAMS_PK_SIZE);

	return 0;
}

//	CCA-KEM Encaps()

int crypto_kem_enc(uint8_t *ct, uint8_t *k, const uint8_t *pk)
{
	uint8_t hash_in[PARAMS_KAPPA_BYTES +
		(PARAMS_CT_SIZE + PARAMS_KAPPA_BYTES > PARAMS_PK_SIZE ?
			PARAMS_CT_SIZE + PARAMS_KAPPA_BYTES : PARAMS_PK_SIZE)];
	uint8_t m[PARAMS_KAPPA_BYTES];
	uint8_t L_g_rho[3][PARAMS_KAPPA_BYTES];

	randombytes(m, PARAMS_KAPPA_BYTES); // generate random m

	memcpy(hash_in, m, PARAMS_KAPPA_BYTES); // G: (l | g | rho) = h(m | pk);
	memcpy(hash_in + PARAMS_KAPPA_BYTES, pk, PARAMS_PK_SIZE);
	r5_hash(L_g_rho, 3 * PARAMS_KAPPA_BYTES, hash_in,
		PARAMS_KAPPA_BYTES + PARAMS_PK_SIZE);

	/* Encrypt	*/
	r5_cpa_pke_encrypt(ct, pk, m, L_g_rho[2]); // m: ct = (U,v)

	/* Append g: ct = (U,v,g) */
	memcpy(ct + PARAMS_CT_SIZE, L_g_rho[1], PARAMS_KAPPA_BYTES);

	/* k = H(L, ct) */
	memcpy(hash_in, L_g_rho[0], PARAMS_KAPPA_BYTES);
	memcpy(hash_in + PARAMS_KAPPA_BYTES,
			ct, PARAMS_CT_SIZE + PARAMS_KAPPA_BYTES);
	r5_hash(k, PARAMS_KAPPA_BYTES, hash_in,
		PARAMS_KAPPA_BYTES + PARAMS_CT_SIZE + PARAMS_KAPPA_BYTES);

	return 0;
}

//	CCA-KEM Decaps()

int crypto_kem_dec(uint8_t *k, const uint8_t *ct, const uint8_t *sk)
{
	uint8_t hash_in[PARAMS_KAPPA_BYTES +
			(PARAMS_CT_SIZE + PARAMS_KAPPA_BYTES > PARAMS_PK_SIZE ?
				PARAMS_CT_SIZE + PARAMS_KAPPA_BYTES : PARAMS_PK_SIZE)];
	uint8_t m_prime[PARAMS_KAPPA_BYTES];
	uint8_t L_g_rho_prime[3][PARAMS_KAPPA_BYTES];
	uint8_t ct_prime[PARAMS_CT_SIZE + PARAMS_KAPPA_BYTES];
	uint8_t fail;

	r5_cpa_pke_decrypt(m_prime, sk, ct); // r5_cpa_pke_decrypt m'

	memcpy(hash_in, m_prime, PARAMS_KAPPA_BYTES);
	memcpy(hash_in + PARAMS_KAPPA_BYTES, // (L | g | rho) = h(m | pk)
			sk + PARAMS_KAPPA_BYTES + PARAMS_KAPPA_BYTES, PARAMS_PK_SIZE);
	r5_hash(L_g_rho_prime, 3 * PARAMS_KAPPA_BYTES, hash_in,
		PARAMS_KAPPA_BYTES + PARAMS_PK_SIZE);

	// Encrypt m: ct' = (U',v')
	r5_cpa_pke_encrypt(ct_prime, sk + PARAMS_KAPPA_BYTES + PARAMS_KAPPA_BYTES,
		m_prime, L_g_rho_prime[2]);

	// ct' = (U',v',g')
	memcpy(ct_prime + PARAMS_CT_SIZE, L_g_rho_prime[1], PARAMS_KAPPA_BYTES);

	// k = H(L', ct')
	memcpy(hash_in, L_g_rho_prime[0], PARAMS_KAPPA_BYTES);
	// verification ok ?
	fail = ct_memcmp(ct, ct_prime,
		PARAMS_CT_SIZE + PARAMS_KAPPA_BYTES);

	// k = H(y, ct') depending on fail state
	ct_cmov(hash_in, sk + PARAMS_KAPPA_BYTES, fail, PARAMS_KAPPA_BYTES);

	memcpy(hash_in + PARAMS_KAPPA_BYTES, ct_prime,
		PARAMS_CT_SIZE + PARAMS_KAPPA_BYTES);
	r5_hash(k, PARAMS_KAPPA_BYTES, hash_in,
		PARAMS_KAPPA_BYTES + PARAMS_CT_SIZE + PARAMS_KAPPA_BYTES);

	return 0;
}

#endif /* ROUND5_CCA */

