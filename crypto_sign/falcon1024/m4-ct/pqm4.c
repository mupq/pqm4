#include <stddef.h>
#include <string.h>

#include "api.h"
#include "inner.h"

/* ==================================================================== */

/*
 * Falcon degree is N = 2^LOGN, where LOGN=9 (for Falcon-512) or 10
 * (for Falcon-1024). We use the advertised public key size to know
 * which degree is used.
 */
#if CRYPTO_PUBLICKEYBYTES == 897
#define LOGN   9
#elif CRYPTO_PUBLICKEYBYTES == 1793
#define LOGN   10
#else
#error Unknown Falcon degree (unexpected public key size)
#endif

#define N   ((size_t)1 << LOGN)
#define NONCELEN   40
#define SEEDLEN    48

/*
 * If the private key length is larger than 10000, then this is the
 * variant with precomputed expanded keys.
 */
#if CRYPTO_SECRETKEYBYTES > 10000
#define KG_EXPAND   1
#else
#define KG_EXPAND   0
#endif

/*
 * Common buffer, to avoid bulky stack allocation. The buffer sizes are
 * all expressed in bytes, but the buffer must be suitably aligned for
 * 64-bit integers and floating-point values.
 *
 * Required size (in bytes):
 *
 *   With expanded key:
 *      keygen:  48*N + 6*N = 54*N
 *      sign:    48*N + 2*N = 50*N
 *      vrfy:    8*N
 *
 *   Without expanded key:
 *      keygen:  28*N + 5*N = 33*N
 *      sign:    72*N + 6*N = 78*N
 *      vrfy:    8*N
 */
static union {
#if KG_EXPAND
	uint8_t b[54 * N];
#else
	uint8_t b[78 * N];
#endif
	uint64_t dummy_u64;
	fpr dummy_fp;
} tmp;

int randombytes(unsigned char *dst, size_t len);

int
crypto_sign_keypair(unsigned char *pk, unsigned char *sk)
{
	int8_t *f, *g, *F, *G;
	uint16_t *h;
	inner_shake256_context rng;
	unsigned char seed[SEEDLEN];
#if KG_EXPAND
	size_t v;
#else
	size_t u, v;
#endif
	unsigned sav_cw;

#if KG_EXPAND
	f = (int8_t *)&tmp.b[48 * N];
	g = f + N;
	F = g + N;
	G = F + N;
	h = (uint16_t *)(G + N);
#else
	f = (int8_t *)&tmp.b[28 * N];
	g = f + N;
	F = g + N;
	G = NULL;
	h = (uint16_t *)(F + N);
#endif

	randombytes(seed, SEEDLEN);
	inner_shake256_init(&rng);
	inner_shake256_inject(&rng, seed, SEEDLEN);
	inner_shake256_flip(&rng);
	sav_cw = set_fpu_cw(2);
	Zf(keygen)(&rng, f, g, F, G, h, LOGN, tmp.b);

#if KG_EXPAND
	/*
	 * Expand private key.
	 */
	Zf(expand_privkey)((fpr *)sk, f, g, F, G, LOGN, tmp.b);
	set_fpu_cw(sav_cw);
#else
	set_fpu_cw(sav_cw);

	/*
	 * Encode private key.
	 */
	sk[0] = 0x50 + LOGN;
	u = 1;
	v = Zf(trim_i8_encode)(sk + u, CRYPTO_SECRETKEYBYTES - u,
		f, LOGN, Zf(max_fg_bits)[LOGN]);
	if (v == 0) {
		return -1;
	}
	u += v;
	v = Zf(trim_i8_encode)(sk + u, CRYPTO_SECRETKEYBYTES - u,
		g, LOGN, Zf(max_fg_bits)[LOGN]);
	if (v == 0) {
		return -1;
	}
	u += v;
	v = Zf(trim_i8_encode)(sk + u, CRYPTO_SECRETKEYBYTES - u,
		F, LOGN, Zf(max_FG_bits)[LOGN]);
	if (v == 0) {
		return -1;
	}
	u += v;
	if (u != CRYPTO_SECRETKEYBYTES) {
		return -1;
	}
#endif

	/*
	 * Encode public key.
	 */
	pk[0] = 0x00 + LOGN;
	v = Zf(modq_encode)(pk + 1, CRYPTO_PUBLICKEYBYTES - 1, h, LOGN);
	if (v != CRYPTO_PUBLICKEYBYTES - 1) {
		return -1;
	}

	return 0;
}

int
crypto_sign(unsigned char *sm, size_t *smlen,
	const unsigned char *m, size_t mlen,
	const unsigned char *sk)
{
#if KG_EXPAND
	const fpr *expanded_key;
#else
	int8_t *f, *g, *F, *G;
	size_t u, v;
#endif
	int16_t *sig;
	uint16_t *hm;
	unsigned char seed[SEEDLEN], nonce[NONCELEN];
	unsigned char *esig;
	inner_shake256_context sc;
	size_t sig_len;
	unsigned sav_cw;

#if KG_EXPAND
	sig = (int16_t *)&tmp.b[48 * N];
#else
	f = (int8_t *)&tmp.b[72 * N];
	g = f + N;
	F = g + N;
	G = F + N;
	sig = (int16_t *)(G + N);
#endif
	hm = (uint16_t *)sig;  /* hm[] is shared with sig[] */
	esig = (unsigned char *)tmp.b;

#if KG_EXPAND
	/*
	 * Expanded key is provided "as is".
	 */
	expanded_key = (const fpr *)sk;
#else
	/*
	 * Decode the private key.
	 */
	if (sk[0] != 0x50 + LOGN) {
		return -1;
	}
	u = 1;
	v = Zf(trim_i8_decode)(f, LOGN, Zf(max_fg_bits)[LOGN],
		sk + u, CRYPTO_SECRETKEYBYTES - u);
	if (v == 0) {
		return -1;
	}
	u += v;
	v = Zf(trim_i8_decode)(g, LOGN, Zf(max_fg_bits)[LOGN],
		sk + u, CRYPTO_SECRETKEYBYTES - u);
	if (v == 0) {
		return -1;
	}
	u += v;
	v = Zf(trim_i8_decode)(F, LOGN, Zf(max_FG_bits)[LOGN],
		sk + u, CRYPTO_SECRETKEYBYTES - u);
	if (v == 0) {
		return -1;
	}
	u += v;
	if (u != CRYPTO_SECRETKEYBYTES) {
		return -1;
	}
	if (!Zf(complete_private)(G, f, g, F, LOGN, tmp.b)) {
		return -1;
	}
#endif

	/*
	 * Create a random nonce (40 bytes).
	 */
	randombytes(nonce, NONCELEN);

	/*
	 * Hash message nonce + message into a vector.
	 */
	inner_shake256_init(&sc);
	inner_shake256_inject(&sc, nonce, NONCELEN);
	inner_shake256_inject(&sc, m, mlen);
	inner_shake256_flip(&sc);
	Zf(hash_to_point_vartime)(&sc, hm, LOGN);

	/*
	 * Initialize a RNG.
	 */
	randombytes(seed, SEEDLEN);
	inner_shake256_init(&sc);
	inner_shake256_inject(&sc, seed, SEEDLEN);
	inner_shake256_flip(&sc);

	/*
	 * Compute the signature.
	 */
	sav_cw = set_fpu_cw(2);
#if KG_EXPAND
	Zf(sign_tree)(sig, &sc, expanded_key, hm, LOGN, tmp.b);
#else
	Zf(sign_dyn)(sig, &sc, f, g, F, G, hm, LOGN, tmp.b);
#endif
	set_fpu_cw(sav_cw);

	/*
	 * Encode the signature and bundle it with the message. Format is:
	 *   signature length     2 bytes, big-endian
	 *   nonce                40 bytes
	 *   message              mlen bytes
	 *   signature            slen bytes
	 */
	esig[0] = 0x20 + LOGN;
	sig_len = Zf(comp_encode)(esig + 1, CRYPTO_BYTES - 1, sig, LOGN);
	if (sig_len == 0) {
		return -1;
	}
	sig_len ++;
	memmove(sm + 2 + NONCELEN, m, mlen);
	sm[0] = (unsigned char)(sig_len >> 8);
	sm[1] = (unsigned char)sig_len;
	memcpy(sm + 2, nonce, NONCELEN);
	memcpy(sm + 2 + NONCELEN + mlen, esig, sig_len);
	*smlen = 2 + NONCELEN + mlen + sig_len;
	return 0;
}

int
crypto_sign_open(unsigned char *m, size_t *mlen,
	const unsigned char *sm, size_t smlen,
	const unsigned char *pk)
{
	uint16_t *h, *hm;
	int16_t *sig;
	const unsigned char *esig;
	inner_shake256_context sc;
	size_t sig_len, msg_len;

	h = (uint16_t *)&tmp.b[2 * N];
	hm = h + N;
	sig = (int16_t *)(hm + N);

	/*
	 * Decode public key.
	 */
	if (pk[0] != 0x00 + LOGN) {
		return -1;
	}
	if (Zf(modq_decode)(h, LOGN, pk + 1, CRYPTO_PUBLICKEYBYTES - 1)
		!= CRYPTO_PUBLICKEYBYTES - 1)
	{
		return -1;
	}
	Zf(to_ntt_monty)(h, LOGN);

	/*
	 * Find nonce, signature, message length.
	 */
	if (smlen < 2 + NONCELEN) {
		return -1;
	}
	sig_len = ((size_t)sm[0] << 8) | (size_t)sm[1];
	if (sig_len > (smlen - 2 - NONCELEN)) {
		return -1;
	}
	msg_len = smlen - 2 - NONCELEN - sig_len;

	/*
	 * Decode signature.
	 */
	esig = sm + 2 + NONCELEN + msg_len;
	if (sig_len < 1 || esig[0] != 0x20 + LOGN) {
		return -1;
	}
	if (Zf(comp_decode)(sig, LOGN,
		esig + 1, sig_len - 1) != sig_len - 1)
	{
		return -1;
	}

	/*
	 * Hash nonce + message into a vector.
	 */
	inner_shake256_init(&sc);
	inner_shake256_inject(&sc, sm + 2, NONCELEN + msg_len);
	inner_shake256_flip(&sc);
	Zf(hash_to_point_vartime)(&sc, hm, LOGN);

	/*
	 * Verify signature.
	 */
	if (!Zf(verify_raw)(hm, sig, h, LOGN, tmp.b)) {
		return -1;
	}

	/*
	 * Return plaintext.
	 */
	memmove(m, sm + 2 + NONCELEN, msg_len);
	*mlen = msg_len;
	return 0;
}
