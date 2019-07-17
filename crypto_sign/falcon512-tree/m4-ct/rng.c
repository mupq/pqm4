/*
 * PRNG and interface to the system RNG.
 *
 * ==========================(LICENSE BEGIN)============================
 *
 * Copyright (c) 2017-2019  Falcon Project
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ===========================(LICENSE END)=============================
 *
 * @author   Thomas Pornin <thomas.pornin@nccgroup.com>
 */

#include <assert.h>

#include "inner.h"

/*
 * PRNG
 * ----
 *
 * The Falcon implementation uses a PRNG based on ChaCha20 for the
 * sampling (the PRNG is seeded from a SHAKE-256 instance, itself seeded
 * with hardware/OS bytes and/or user-provided seeds).
 *
 * Seeding
 * -------
 *
 * Two sources of seeding are used:
 *
 *  - The /dev/urandom file, on Unix-like systems.
 *
 *  - CryptGenRandom(), on Windows systems (Win32).
 *
 * Configuration
 * -------------
 *
 * Normally everything is auto-detected. To override detection, define
 * macros explicitly, with a value of 1 (to enable) or 0 (to disable).
 * Available macros are:
 *
 *  FALCON_USE_URANDOM      /dev/urandom seeding
 *  FALCON_USE_WIN32_RAND   CryptGenRandom() seeding
 *
 * TODO: add support for getrandom()/getentropy() and RDRAND
 */

/*
 * /dev/urandom is accessible on a variety of Unix-like systems.
 */
#ifndef FALCON_USE_URANDOM
#if defined _AIX \
	|| defined __ANDROID__ \
	|| defined __FreeBSD__ \
	|| defined __NetBSD__ \
	|| defined __OpenBSD__ \
	|| defined __DragonFly__ \
	|| defined __linux__ \
	|| (defined __sun && (defined __SVR4 || defined __svr4__)) \
	|| (defined __APPLE__ && defined __MACH__)
#define FALCON_USE_URANDOM   1
#endif
#endif

/*
 * CryptGenRandom() exists on Windows.
 */
#ifndef FALCON_USE_WIN32_RAND
#if defined _WIN32 || defined _WIN64
#define FALCON_USE_WIN32_RAND   1
#endif
#endif

/*
 * Accessing /dev/urandom requires using some file descriptors.
 */
#if FALCON_USE_URANDOM
#include <sys/types.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#endif

/*
 * CryptGenRandom() is defined in specific headers and requires linking
 * with advapi32.lib (to use advapi32.dll).
 */
#if FALCON_USE_WIN32_RAND
#include <windows.h>
#include <wincrypt.h>
#pragma comment(lib, "advapi32")
#endif

#if FALCON_USE_URANDOM
static int
urandom_get_seed(void *seed, size_t len)
{
	int f;

	if (len == 0) {
		return 1;
	}
	f = open("/dev/urandom", O_RDONLY);
	if (f >= 0) {
		while (len > 0) {
			ssize_t rlen;

			rlen = read(f, seed, len);
			if (rlen < 0) {
				if (errno == EINTR) {
					continue;
				}
				break;
			}
			seed = (unsigned char *)seed + rlen;
			len -= (size_t)rlen;
		}
		close(f);
		return len == 0;
	} else {
		return 0;
	}
}
#endif

#if FALCON_USE_WIN32_RAND
static int
win32_get_seed(void *seed, size_t len)
{
	HCRYPTPROV hp;

	if (CryptAcquireContext(&hp, 0, 0, PROV_RSA_FULL,
		CRYPT_VERIFYCONTEXT | CRYPT_SILENT))
	{
		BOOL r;

		r = CryptGenRandom(hp, len, seed);
		CryptReleaseContext(hp, 0);
		return r != 0;
	}
	return 0;
}
#endif

/* see inner.h */
int
Zf(get_seed)(void *seed, size_t len)
{
	(void)seed;
	(void)len;
#if FALCON_USE_URANDOM
	if (urandom_get_seed(seed, len)) {
		return 1;
	}
#endif
#if FALCON_USE_WIN32_RAND
	if (win32_get_seed(seed, len)) {
		return 1;
	}
#endif
	return 0;
}

/* see inner.h */
void
Zf(prng_init)(prng *p, shake256_context *src)
{
#if FALCON_LE
	shake256_extract(src, p->state.d, 56);
#else
	/*
	 * To ensure reproducibility for a given seed, we
	 * must enforce little-endian interpretation of
	 * the state words.
	 */
	unsigned char tmp[56];
	uint64_t th, tl;
	int i;

	shake256_extract(src, tmp, 56);
	for (i = 0; i < 14; i ++) {
		uint32_t w;

		w = (uint32_t)tmp[(i << 2) + 0]
			| ((uint32_t)tmp[(i << 2) + 1] << 8)
			| ((uint32_t)tmp[(i << 2) + 2] << 16)
			| ((uint32_t)tmp[(i << 2) + 3] << 24);
		*(uint32_t *)(p->state.d + (i << 2)) = w;
	}
	tl = *(uint32_t *)(p->state.d + 48);
	th = *(uint32_t *)(p->state.d + 52);
	*(uint64_t *)(p->state.d + 48) = tl + (th << 32);
#endif
	Zf(prng_refill)(p);
}

/*
 * PRNG based on ChaCha20.
 *
 * State consists in key (32 bytes) then IV (16 bytes) and block counter
 * (8 bytes). Normally, we should not care about local endianness (this
 * is for a PRNG), but for the NIST competition we need reproducible KAT
 * vectors that work across architectures, so we enforce little-endian
 * interpretation where applicable. Moreover, output words are "spread
 * out" over the output buffer with the interleaving pattern that is
 * naturally obtained from the AVX2 implementation that runs eight
 * ChaCha20 instances in parallel.
 *
 * The block counter is XORed into the first 8 bytes of the IV.
 */
void
Zf(prng_refill)(prng *p)
{
	static const uint32_t CW[] = {
		0x61707865, 0x3320646e, 0x79622d32, 0x6b206574
	};

	uint64_t cc;
	size_t u;

	/*
	 * State uses local endianness. Only the output bytes must be
	 * converted to little endian (if used on a big-endian machine).
	 */
	cc = *(uint64_t *)(p->state.d + 48);
	for (u = 0; u < 8; u ++) {
		uint32_t state[16];
		size_t v;
		int i;

		memcpy(&state[0], CW, sizeof CW);
		memcpy(&state[4], p->state.d, 48);
		state[14] ^= (uint32_t)cc;
		state[15] ^= (uint32_t)(cc >> 32);
		for (i = 0; i < 10; i ++) {

#define QROUND(a, b, c, d)   do { \
		state[a] += state[b]; \
		state[d] ^= state[a]; \
		state[d] = (state[d] << 16) | (state[d] >> 16); \
		state[c] += state[d]; \
		state[b] ^= state[c]; \
		state[b] = (state[b] << 12) | (state[b] >> 20); \
		state[a] += state[b]; \
		state[d] ^= state[a]; \
		state[d] = (state[d] <<  8) | (state[d] >> 24); \
		state[c] += state[d]; \
		state[b] ^= state[c]; \
		state[b] = (state[b] <<  7) | (state[b] >> 25); \
	} while (0)

			QROUND( 0,  4,  8, 12);
			QROUND( 1,  5,  9, 13);
			QROUND( 2,  6, 10, 14);
			QROUND( 3,  7, 11, 15);
			QROUND( 0,  5, 10, 15);
			QROUND( 1,  6, 11, 12);
			QROUND( 2,  7,  8, 13);
			QROUND( 3,  4,  9, 14);

#undef QROUND

		}

		for (v = 0; v < 4; v ++) {
			state[v] += CW[v];
		}
		for (v = 4; v < 14; v ++) {
			state[v] += ((uint32_t *)p->state.d)[v - 4];
		}
		state[14] += ((uint32_t *)p->state.d)[10]
			^ (uint32_t)cc;
		state[15] += ((uint32_t *)p->state.d)[11]
			^ (uint32_t)(cc >> 32);
		cc ++;

		/*
		 * We mimic the interleaving that is used in the AVX2
		 * implementation.
		 */
		for (v = 0; v < 16; v ++) {
#if FALCON_LE
			((uint32_t *)p->buf.d)[u + (v << 3)] = state[v];
#else
			p->buf.d[(u << 2) + (v << 5) + 0] = state[v];
			p->buf.d[(u << 2) + (v << 5) + 1] = (state[v] >> 8);
			p->buf.d[(u << 2) + (v << 5) + 2] = (state[v] >> 16);
			p->buf.d[(u << 2) + (v << 5) + 3] = (state[v] >> 24);
#endif
		}
	}
	*(uint64_t *)(p->state.d + 48) = cc;
	p->ptr = 0;
}

/* see inner.h */
void
Zf(prng_get_bytes)(prng *p, void *dst, size_t len)
{
	unsigned char *buf;

	buf = dst;
	while (len > 0) {
		size_t clen;

		clen = (sizeof p->buf.d) - p->ptr;
		if (clen > len) {
			clen = len;
		}
		memcpy(buf, p->buf.d, clen);
		buf += clen;
		len -= clen;
		p->ptr += clen;
		if (p->ptr == sizeof p->buf.d) {
			Zf(prng_refill)(p);
		}
	}
}
