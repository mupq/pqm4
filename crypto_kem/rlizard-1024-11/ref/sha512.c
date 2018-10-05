/* sha512.c - Functions to compute SHA512 message digest of files or
memory blocks according to the NIST specification FIPS-180-2.

Copyright (C) 2005, 2006, 2008 Free Software Foundation, Inc.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* Written by David Madore, considerably copypasting from
Scott G. Miller's sha1.c
*/

// Simplified for inclusion in Cubby by Keith Rarick.

#include "sha512.h"


#include <string.h>
#include <stddef.h>

#ifdef WORDS_BIGENDIAN
# define SWAP(n) (n)
#else
# define SWAP(n) \
    (((((n) << 56) | (((n) & 0x0000ff00LLU) << 40)) | \
      ((((n) & 0x00ff0000LLU) << 24) | (((n) & 0xff000000LLU) <<  8))) | \
     (((((n) >>  8) & 0xff000000LLU) | (((n) >> 24) & 0x00ff0000LLU)) | \
      ((((n) >> 40) & 0x0000ff00LLU) | ((n) >> 56))))
#endif

/* This array contains the bytes used to pad the buffer to the next
128-byte boundary.  */
static const unsigned char fillbuf[128] = { 0x80, 0 /* , 0, 0, ...  */ };

/* Structure to save state of computation between the single steps.  */
struct sha512_ctx
{
	uint64_t state[8];

	uint64_t total[2];
	size_t buflen;
	uint64_t buffer[32];
};

/* Copy the value from V into the memory location pointed to by *CP,
If your architecture allows unaligned access, this is equivalent to
* (__typeof__ (v) *) cp = v  */
static inline void
set_uint64(char *cp, uint64_t v, int len)
{
	memcpy(cp, &v, len);
}

/* SHA512 round constants */
#define K(I) sha512_round_constants[I]
static uint64_t const sha512_round_constants[80] = {
	0x428a2f98d728ae22LLU, 0x7137449123ef65cdLLU,
	0xb5c0fbcfec4d3b2fLLU, 0xe9b5dba58189dbbcLLU,
	0x3956c25bf348b538LLU, 0x59f111f1b605d019LLU,
	0x923f82a4af194f9bLLU, 0xab1c5ed5da6d8118LLU,
	0xd807aa98a3030242LLU, 0x12835b0145706fbeLLU,
	0x243185be4ee4b28cLLU, 0x550c7dc3d5ffb4e2LLU,
	0x72be5d74f27b896fLLU, 0x80deb1fe3b1696b1LLU,
	0x9bdc06a725c71235LLU, 0xc19bf174cf692694LLU,
	0xe49b69c19ef14ad2LLU, 0xefbe4786384f25e3LLU,
	0x0fc19dc68b8cd5b5LLU, 0x240ca1cc77ac9c65LLU,
	0x2de92c6f592b0275LLU, 0x4a7484aa6ea6e483LLU,
	0x5cb0a9dcbd41fbd4LLU, 0x76f988da831153b5LLU,
	0x983e5152ee66dfabLLU, 0xa831c66d2db43210LLU,
	0xb00327c898fb213fLLU, 0xbf597fc7beef0ee4LLU,
	0xc6e00bf33da88fc2LLU, 0xd5a79147930aa725LLU,
	0x06ca6351e003826fLLU, 0x142929670a0e6e70LLU,
	0x27b70a8546d22ffcLLU, 0x2e1b21385c26c926LLU,
	0x4d2c6dfc5ac42aedLLU, 0x53380d139d95b3dfLLU,
	0x650a73548baf63deLLU, 0x766a0abb3c77b2a8LLU,
	0x81c2c92e47edaee6LLU, 0x92722c851482353bLLU,
	0xa2bfe8a14cf10364LLU, 0xa81a664bbc423001LLU,
	0xc24b8b70d0f89791LLU, 0xc76c51a30654be30LLU,
	0xd192e819d6ef5218LLU, 0xd69906245565a910LLU,
	0xf40e35855771202aLLU, 0x106aa07032bbd1b8LLU,
	0x19a4c116b8d2d0c8LLU, 0x1e376c085141ab53LLU,
	0x2748774cdf8eeb99LLU, 0x34b0bcb5e19b48a8LLU,
	0x391c0cb3c5c95a63LLU, 0x4ed8aa4ae3418acbLLU,
	0x5b9cca4f7763e373LLU, 0x682e6ff3d6b2b8a3LLU,
	0x748f82ee5defb2fcLLU, 0x78a5636f43172f60LLU,
	0x84c87814a1f0ab72LLU, 0x8cc702081a6439ecLLU,
	0x90befffa23631e28LLU, 0xa4506cebde82bde9LLU,
	0xbef9a3f7b2c67915LLU, 0xc67178f2e372532bLLU,
	0xca273eceea26619cLLU, 0xd186b8c721c0c207LLU,
	0xeada7dd6cde0eb1eLLU, 0xf57d4f7fee6ed178LLU,
	0x06f067aa72176fbaLLU, 0x0a637dc5a2c898a6LLU,
	0x113f9804bef90daeLLU, 0x1b710b35131c471bLLU,
	0x28db77f523047d84LLU, 0x32caab7b40c72493LLU,
	0x3c9ebe0a15c9bebcLLU, 0x431d67c49c100d4cLLU,
	0x4cc5d4becb3e42b6LLU, 0x597f299cfc657e2aLLU,
	0x5fcb6fab3ad6faecLLU, 0x6c44198c4a475817LLU,
};

/* Round functions.  */
#define F2(A, B, C) ((A & B) | (C & (A | B)))
#define F1(E, F, G) (G ^ (E & (F ^ G)))

/* Process LEN bytes of BUFFER, accumulating context into CTX.
It is assumed that LEN % 128 == 0.
Most of this code comes from GnuPG's cipher/sha1.c.  */

static void
sha512_process_block(const void *buffer, size_t len, struct sha512_ctx *ctx)
{
	uint64_t const *words = buffer;
	uint64_t const *endp = words + len / sizeof(uint64_t);
	uint64_t x[16];
	uint64_t a = ctx->state[0];
	uint64_t b = ctx->state[1];
	uint64_t c = ctx->state[2];
	uint64_t d = ctx->state[3];
	uint64_t e = ctx->state[4];
	uint64_t f = ctx->state[5];
	uint64_t g = ctx->state[6];
	uint64_t h = ctx->state[7];

	/* First increment the byte count.  FIPS PUB 180-2 specifies the possible
	length of the file up to 2^128 bits.  Here we only compute the
	number of bytes.  Do a double word increment.  */
	ctx->total[0] = ctx->total[0] + ((uint64_t)len);
	if (ctx->total[0] < ((uint64_t)len))
		ctx->total[1] = ctx->total[1] + 1LLU;

#define rol(x, n) (((x) << (n)) | ((x) >> (64 - (n))))

#define S0(x) (rol(x, 63) ^ (rol(x, 56) ^ (x >> 7)))
#define S1(x) (rol(x, 45) ^ (rol(x, 3) ^ (x >> 6)))
#define SS0(x) (rol(x, 36) ^ (rol(x, 30) ^ rol(x, 25)))
#define SS1(x) (rol(x, 50) ^ (rol(x, 46) ^ rol(x, 23)))

#define M(I) (x[(I) & 15]                                                 \
              = (x[(I) & 15] + S1(x[((I) - 2) & 15]) +                    \
                 x[((I) - 7) & 15] + S0(x[((I) - 15) & 15])))

#define R(A, B, C, D, E, F, G, H, K, M)                                   \
  do                                                                      \
    {                                                                     \
      uint64_t t0 = SS0(A) + F2(A, B, C);                                 \
      uint64_t t1 = H + SS1(E) + F1(E, F, G) + K + M;                     \
      D = D + t1;                                                         \
      H = t0 + t1;                                                        \
    }                                                                     \
  while (0)

	while (words < endp)
	{
		int t;
		/* FIXME: see sha1.c for a better implementation.  */
		for (t = 0; t < 16; t++)
		{
			x[t] = SWAP(*words);
			words++;
		}

		R(a, b, c, d, e, f, g, h, K(0), x[0]);
		R(h, a, b, c, d, e, f, g, K(1), x[1]);
		R(g, h, a, b, c, d, e, f, K(2), x[2]);
		R(f, g, h, a, b, c, d, e, K(3), x[3]);
		R(e, f, g, h, a, b, c, d, K(4), x[4]);
		R(d, e, f, g, h, a, b, c, K(5), x[5]);
		R(c, d, e, f, g, h, a, b, K(6), x[6]);
		R(b, c, d, e, f, g, h, a, K(7), x[7]);
		R(a, b, c, d, e, f, g, h, K(8), x[8]);
		R(h, a, b, c, d, e, f, g, K(9), x[9]);
		R(g, h, a, b, c, d, e, f, K(10), x[10]);
		R(f, g, h, a, b, c, d, e, K(11), x[11]);
		R(e, f, g, h, a, b, c, d, K(12), x[12]);
		R(d, e, f, g, h, a, b, c, K(13), x[13]);
		R(c, d, e, f, g, h, a, b, K(14), x[14]);
		R(b, c, d, e, f, g, h, a, K(15), x[15]);
		R(a, b, c, d, e, f, g, h, K(16), M(16));
		R(h, a, b, c, d, e, f, g, K(17), M(17));
		R(g, h, a, b, c, d, e, f, K(18), M(18));
		R(f, g, h, a, b, c, d, e, K(19), M(19));
		R(e, f, g, h, a, b, c, d, K(20), M(20));
		R(d, e, f, g, h, a, b, c, K(21), M(21));
		R(c, d, e, f, g, h, a, b, K(22), M(22));
		R(b, c, d, e, f, g, h, a, K(23), M(23));
		R(a, b, c, d, e, f, g, h, K(24), M(24));
		R(h, a, b, c, d, e, f, g, K(25), M(25));
		R(g, h, a, b, c, d, e, f, K(26), M(26));
		R(f, g, h, a, b, c, d, e, K(27), M(27));
		R(e, f, g, h, a, b, c, d, K(28), M(28));
		R(d, e, f, g, h, a, b, c, K(29), M(29));
		R(c, d, e, f, g, h, a, b, K(30), M(30));
		R(b, c, d, e, f, g, h, a, K(31), M(31));
		R(a, b, c, d, e, f, g, h, K(32), M(32));
		R(h, a, b, c, d, e, f, g, K(33), M(33));
		R(g, h, a, b, c, d, e, f, K(34), M(34));
		R(f, g, h, a, b, c, d, e, K(35), M(35));
		R(e, f, g, h, a, b, c, d, K(36), M(36));
		R(d, e, f, g, h, a, b, c, K(37), M(37));
		R(c, d, e, f, g, h, a, b, K(38), M(38));
		R(b, c, d, e, f, g, h, a, K(39), M(39));
		R(a, b, c, d, e, f, g, h, K(40), M(40));
		R(h, a, b, c, d, e, f, g, K(41), M(41));
		R(g, h, a, b, c, d, e, f, K(42), M(42));
		R(f, g, h, a, b, c, d, e, K(43), M(43));
		R(e, f, g, h, a, b, c, d, K(44), M(44));
		R(d, e, f, g, h, a, b, c, K(45), M(45));
		R(c, d, e, f, g, h, a, b, K(46), M(46));
		R(b, c, d, e, f, g, h, a, K(47), M(47));
		R(a, b, c, d, e, f, g, h, K(48), M(48));
		R(h, a, b, c, d, e, f, g, K(49), M(49));
		R(g, h, a, b, c, d, e, f, K(50), M(50));
		R(f, g, h, a, b, c, d, e, K(51), M(51));
		R(e, f, g, h, a, b, c, d, K(52), M(52));
		R(d, e, f, g, h, a, b, c, K(53), M(53));
		R(c, d, e, f, g, h, a, b, K(54), M(54));
		R(b, c, d, e, f, g, h, a, K(55), M(55));
		R(a, b, c, d, e, f, g, h, K(56), M(56));
		R(h, a, b, c, d, e, f, g, K(57), M(57));
		R(g, h, a, b, c, d, e, f, K(58), M(58));
		R(f, g, h, a, b, c, d, e, K(59), M(59));
		R(e, f, g, h, a, b, c, d, K(60), M(60));
		R(d, e, f, g, h, a, b, c, K(61), M(61));
		R(c, d, e, f, g, h, a, b, K(62), M(62));
		R(b, c, d, e, f, g, h, a, K(63), M(63));
		R(a, b, c, d, e, f, g, h, K(64), M(64));
		R(h, a, b, c, d, e, f, g, K(65), M(65));
		R(g, h, a, b, c, d, e, f, K(66), M(66));
		R(f, g, h, a, b, c, d, e, K(67), M(67));
		R(e, f, g, h, a, b, c, d, K(68), M(68));
		R(d, e, f, g, h, a, b, c, K(69), M(69));
		R(c, d, e, f, g, h, a, b, K(70), M(70));
		R(b, c, d, e, f, g, h, a, K(71), M(71));
		R(a, b, c, d, e, f, g, h, K(72), M(72));
		R(h, a, b, c, d, e, f, g, K(73), M(73));
		R(g, h, a, b, c, d, e, f, K(74), M(74));
		R(f, g, h, a, b, c, d, e, K(75), M(75));
		R(e, f, g, h, a, b, c, d, K(76), M(76));
		R(d, e, f, g, h, a, b, c, K(77), M(77));
		R(c, d, e, f, g, h, a, b, K(78), M(78));
		R(b, c, d, e, f, g, h, a, K(79), M(79));

		a = ctx->state[0] = ctx->state[0] + a;
		b = ctx->state[1] = ctx->state[1] + b;
		c = ctx->state[2] = ctx->state[2] + c;
		d = ctx->state[3] = ctx->state[3] + d;
		e = ctx->state[4] = ctx->state[4] + e;
		f = ctx->state[5] = ctx->state[5] + f;
		g = ctx->state[6] = ctx->state[6] + g;
		h = ctx->state[7] = ctx->state[7] + h;
	}
}

static void
sha512_process_bytes(const void *buffer, size_t len, struct sha512_ctx *ctx)
{
	/* When we already have some bits in our internal buffer concatenate
	both inputs first.  */
	if (ctx->buflen != 0)
	{
		size_t left_over = ctx->buflen;
		size_t add = 256 - left_over > len ? len : 256 - left_over;

		memcpy(&((char *)ctx->buffer)[left_over], buffer, add);
		ctx->buflen += add;

		if (ctx->buflen > 128)
		{
			sha512_process_block(ctx->buffer, ctx->buflen & ~63, ctx);

			ctx->buflen &= 127;
			/* The regions in the following copy operation cannot overlap.  */
			memcpy(ctx->buffer,
				&((char *)ctx->buffer)[(left_over + add) & ~127],
				ctx->buflen);
		}

		buffer = (const char *)buffer + add;
		len -= add;
	}

	/* Process available complete blocks.  */
	if (len >= 128)
	{
#if !_STRING_ARCH_unaligned
# define alignof(type) offsetof (struct { char c; type x; }, x)
# define UNALIGNED_P(p) (((size_t) p) % alignof (uint64_t) != 0)
		if (UNALIGNED_P(buffer))
			while (len > 128)
			{
				sha512_process_block(memcpy(ctx->buffer, buffer, 128), 128, ctx);
				buffer = (const char *)buffer + 128;
				len -= 128;
			}
		else
#endif
		{
			sha512_process_block(buffer, len & ~127, ctx);
			buffer = (const char *)buffer + (len & ~127);
			len &= 127;
		}
	}

	/* Move remaining bytes in internal buffer.  */
	if (len > 0)
	{
		size_t left_over = ctx->buflen;

		memcpy(&((char *)ctx->buffer)[left_over], buffer, len);
		left_over += len;
		if (left_over >= 128)
		{
			sha512_process_block(ctx->buffer, 128, ctx);
			left_over -= 128;
			memcpy(ctx->buffer, &ctx->buffer[16], left_over);
		}
		ctx->buflen = left_over;
	}
}

/* Compute SHA512 message digest for LEN bytes beginning at BUFFER.  The
result is always in little endian byte order, so that a byte-wise
output yields to the wanted ASCII representation of the message
digest.  */
void *
sha512(const char *buffer, size_t len, void *resbuf, int outlen)
{
	int i;
	char *r = resbuf;
	struct sha512_ctx ctx;

	/* Intialize ctx to the start constants of the SHA512 algorithm. */
	ctx.state[0] = 0x6a09e667f3bcc908LLU;
	ctx.state[1] = 0xbb67ae8584caa73bLLU;
	ctx.state[2] = 0x3c6ef372fe94f82bLLU;
	ctx.state[3] = 0xa54ff53a5f1d36f1LLU;
	ctx.state[4] = 0x510e527fade682d1LLU;
	ctx.state[5] = 0x9b05688c2b3e6c1fLLU;
	ctx.state[6] = 0x1f83d9abfb41bd6bLLU;
	ctx.state[7] = 0x5be0cd19137e2179LLU;

	ctx.total[0] = ctx.total[1] = 0LLU;
	ctx.buflen = 0;

	/* Process whole buffer but last len % 128 bytes.  */
	sha512_process_bytes(buffer, len, &ctx);

	/* Process the remaining bytes in the internal buffer and the usual
	prolog according to the standard and write the result to RESBUF.  */
	/* Take yet unprocessed bytes into account.  */
	size_t bytes = ctx.buflen;
	size_t size = (bytes < 112) ? 128 / 8 : 128 * 2 / 8;

	/* Now count remaining bytes.  */
	ctx.total[0] = ctx.total[0] + ((uint64_t)bytes);
	if (ctx.total[0] < ((uint64_t)bytes))
		ctx.total[1] = ctx.total[1] + 1LLU;

	/* Put the 64-bit file length in *bits* at the end of the buffer.  */
	ctx.buffer[size - 2] = SWAP((ctx.total[1] << 3) | (ctx.total[0] >> 61));
	ctx.buffer[size - 1] = SWAP(ctx.total[0] << 3);

	memcpy(&((char *)ctx.buffer)[bytes], fillbuf, (size - 2) * 8 - bytes);

	/* Process last bytes.  */
	sha512_process_block(ctx.buffer, size * 8, &ctx);

	/* Put result from CTX in first outlen bytes following RESBUF.
	The result must be in little endian byte order.  */
	for (i = 0; i < (outlen / sizeof(uint64_t)); i++) {
		set_uint64(r + i * sizeof ctx.state[0], SWAP(ctx.state[i]), sizeof(uint64_t));
	}
	set_uint64(r + i * sizeof ctx.state[0], SWAP(ctx.state[i]), outlen % sizeof(uint64_t));

	return resbuf;
}