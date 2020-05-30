//  xe5_c64.c
//  2019-09-21  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (C) 2019, PQShield Ltd. Please see LICENSE.

//  Optimized 64-bit "ANSI C" implementation of XE5 codes (Round5 variant)

#include "r5_parameter_sets.h"

#if PARAMS_F == 5

#include "xef.h"
#include "little_endian.h"

//  various bit-twiddling macros for 64-bit words

#define XM64_RTLM(r, n) { r = ((r << (64 % n)) | (r >> (n - (64 % n)))) & \
								 ((1llu << n) - 1llu);}
#define XM64_FLDM(r, n) { r = (r ^ ((r >> n))) & ((1llu << n) - 1llu); }
#define XM64_FLD2(r, n) { r ^= r >> (2 * n); XM64_FLDM(r, n); }
#define XM64_FLD4(r, n) { r ^= r >> (4 * n); XM64_FLD2(r, n); }

#define XM64_GTH8(r) { \
	r ^= r >> 4; \
	r ^= r >> 2; \
	r ^= r >> 1; \
	r &= 0x0101010101010101llu; \
	r ^= r >> 7; \
	r ^= r >> 14; \
	r = (r ^ (r >> 28)) & 0xFF; \
}

#define XM64_GTH4(r) { \
	r ^= r >> 8; \
	r ^= r >> 4; \
	r ^= r >> 2; \
	r ^= r >> 1; \
	r &= 0x0001000100010001llu; \
	r ^= r >> 15; \
	r = (r ^ (r >> 30)) & 0xF; \
}

#define XM64_PR16(r) { r ^= r >> 32; r = (r ^ (r >> 16)) & 0xFFFF; }
#define XM64_UNFM(r, n) { r &= ((1llu << n) - 1llu); r |= r << n; }
#define XM64_UNF2(r, n) { XM64_UNFM(r, n); r |= r << (2 * n); }
#define XM64_UNF4(r, n) { XM64_UNF2(r, n); r |= r << (4 * n); }
#define XM64_ROTR(r, n) { r = ((r >> (64 % n)) | (r << (n - (64 % n)))); }

#define XM64_UNG8(r) { \
	r |= r << 8; \
	r |= r << 16; \
	r |= r << 32; \
	r &= 0x8040201008040201llu; \
	r = (0x0080808080808080llu - r) & 0x8040404040404040llu; \
	r |= ((r >> 63) << 62) | (r << 1); \
	r |= r >> 2; \
	r |= r >> 4; \
}

#define XM64_UNG4(r) { \
	r |= r << 16; \
	r |= r << 32; \
	r &= 0x0008000400020001llu; \
	r =	 0x1000100010001000llu - r; \
	r &= 0x0FF00FF00FF00FF0llu; \
	r = (r << 4) | (r >> 4); \
}

#define MX64_MJ10(c, t0, t1, t2, t3, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9) \
{ \
	t1 = v0 & v1; t0 = v0 ^ v1; \
	c = t0 & v2; t0 ^= v2; t1 ^= c; \
	c = t0 & v3; t0 ^= v3; t1 ^= c; t2 = c & ~t1; \
	c = t0 & v4; t0 ^= v4; t1 ^= c; c &= ~t1; t2 ^= c; \
	c = t0 & v5; t0 ^= v5; t1 ^= c; c &= ~t1; t2 ^= c; \
	c = t0 & v6; t0 ^= v6; t1 ^= c; c &= ~t1; t2 ^= c; \
	c = t0 & v7; t0 ^= v7; t1 ^= c; c &= ~t1; t2 ^= c; t3 = c & ~t2; \
	c = t0 & v8; t0 ^= v8; t1 ^= c; c &= ~t1; t2 ^= c; c &= ~t2; t3 ^= c; \
	c = t0 & v9; t1 ^= c; c &= ~t1; t2 ^= c; c &= ~t2; t3 ^= c; \
	t2 ^= t1; t3 ^= t1 & ~t2; \
}

//  == XE5-190 (128-bit payload) ==

#if PARAMS_XE == 190

void xe5_190_compute(void *block)
{
	uint64_t rp8, r11, r13, r16, r17, r19, r21, r23, r25, r29;
	uint64_t *p64, x;

	//  initialize
	p64 = (uint64_t *) block;
	rp8 = r11 = r13 = r16 = r17 = r19 = r21 = r23 = r25 = r29 =
		LITTLE_ENDIAN64(p64[1]);

	//  fold
	XM64_GTH8(rp8);
	XM64_FLD4(r11, 11);
	XM64_FLD4(r13, 13);
	XM64_FLD2(r17, 17);
	XM64_FLD2(r19, 19);
	XM64_FLD2(r21, 21);
	XM64_FLD2(r23, 23);
	XM64_FLD2(r25, 25);
	XM64_FLD2(r29, 29);

	//  rotate
	XM64_RTLM(r11, 11);
	XM64_RTLM(r13, 13);
	XM64_RTLM(r17, 17);
	XM64_RTLM(r19, 19);
	XM64_RTLM(r21, 21);
	XM64_RTLM(r23, 23);
	XM64_RTLM(r25, 25);
	XM64_RTLM(r29, 29);

	//  xor
	x = LITTLE_ENDIAN64(p64[0]);
	r11 ^= x;
	r13 ^= x;
	r16 ^= x;
	r17 ^= x;
	r19 ^= x;
	r21 ^= x;
	r23 ^= x;
	r25 ^= x;
	r29 ^= x;

	//  fold
	XM64_GTH8(x);
	rp8 = (rp8 << 8) ^ x;
	XM64_FLD4(r11, 11);
	XM64_FLD4(r13, 13);
	XM64_PR16(r16);
	XM64_FLD2(r17, 17);
	XM64_FLD2(r19, 19);
	XM64_FLD2(r21, 21);
	XM64_FLD2(r23, 23);
	XM64_FLD2(r25, 25);
	XM64_FLD2(r29, 29);

	//  XE5-190:     rp8 r11 r13 r16 r17 r19 r21 r23 r25 r29 end
	//  bit offset:  0   16  27  40  56  73  92  113 136 161 190
	x = rp8 ^ (r11 << 16) ^ (r13 << 27) ^ (r16 << 40) ^ (r17 << 56);
	p64[2] ^= LITTLE_ENDIAN64(x);
	x = (r17 >> 8) ^ (r19 << 9) ^ (r21 << 28) ^ (r23 << 49);
	p64[3] ^= LITTLE_ENDIAN64(x);
	x = (r23 >> 15) ^ (r25 << 8) ^ (r29 << 33);
	p64[4] ^= LITTLE_ENDIAN64(x);
}

void xe5_190_fixerr(void *block)
{
	uint64_t rp8, r11, r13, r16, r17, r19, r21, r23, r25, r29;
	uint64_t *p64, x, y, c, t1, t2;

	//  decode
	p64 = (uint64_t *) block;
	x = LITTLE_ENDIAN64(p64[2]);
	rp8 = x;
	r11 = x >> 16;
	r13 = x >> 27;
	r16 = x >> 40;
	r17 = x >> 56;
	x = LITTLE_ENDIAN64(p64[3]);
	r17 ^= x << 8;
	r19 = x >> 9;
	r21 = x >> 28;
	r23 = x >> 49;
	x = LITTLE_ENDIAN64(p64[4]);
	r23 ^= x << 15;
	r25 = x >> 8;
	r29 = x >> 33;

	//  unfold
	y = rp8 & 0xFF;
	XM64_UNG8(y);
	XM64_UNF4(r11, 11);
	XM64_UNF4(r13, 13);
	XM64_UNF2(r16, 16);
	XM64_UNF2(r17, 17);
	XM64_UNF2(r19, 19);
	XM64_UNF2(r21, 21);
	XM64_UNF2(r23, 23);
	XM64_UNF2(r25, 25);
	XM64_UNF2(r29, 29);

	//  majority
	MX64_MJ10(c, y, t1, t2, x, y, r11, r13, r16, r17, r19, r21, r23, r25, r29);
	p64[0] ^= LITTLE_ENDIAN64(x);

	//  rotate
	y = (rp8 >> 8) & 0xFF;
	XM64_UNG8(y);
	XM64_ROTR(r11, 11);
	XM64_ROTR(r13, 13);
	XM64_ROTR(r17, 17);
	XM64_ROTR(r19, 19);
	XM64_ROTR(r21, 21);
	XM64_ROTR(r23, 23);
	XM64_ROTR(r25, 25);
	XM64_ROTR(r29, 29);

	//  majority
	MX64_MJ10(c, y, t1, t2, x, y, r11, r13, r16, r17, r19, r21, r23, r25, r29);
	p64[1] ^= LITTLE_ENDIAN64(x);
}

#endif

//  == XE5-218 (192-bit payload) ==

#if PARAMS_XE == 218

void xe5_218_compute(void *block)
{
	int i;
	uint64_t rp8, r13, r16, r17, r19, r21, r23, r25, r29, r31;
	uint64_t *p64, x;

	//  initialize
	p64 = (uint64_t *) block;
	rp8 = r13 = r16 = r17 = r19 = r21 = r23 = r25 = r29 = r31 =
		LITTLE_ENDIAN64(p64[2]);
	XM64_GTH8(rp8);

	for (i = 2; i >= 0; i--) {
		if (i < 2) {
			//  rotate
			XM64_RTLM(r13, 13);
			XM64_RTLM(r17, 17);
			XM64_RTLM(r19, 19);
			XM64_RTLM(r21, 21);
			XM64_RTLM(r23, 23);
			XM64_RTLM(r25, 25);
			XM64_RTLM(r29, 29);
			XM64_RTLM(r31, 31);

			//  xor
			x = LITTLE_ENDIAN64(p64[i]);
			r13 ^= x;
			r16 ^= x;
			r17 ^= x;
			r19 ^= x;
			r21 ^= x;
			r23 ^= x;
			r25 ^= x;
			r29 ^= x;
			r31 ^= x;
			XM64_GTH8(x);
			rp8 = (rp8 << 8) ^ x;
		}
		//  fold
		XM64_FLD4(r13, 13);
		XM64_PR16(r16);
		XM64_FLD2(r17, 17);
		XM64_FLD2(r19, 19);
		XM64_FLD2(r21, 21);
		XM64_FLD2(r23, 23);
		XM64_FLD2(r25, 25);
		XM64_FLD2(r29, 29);
		XM64_FLD2(r31, 31);
	}

	//  XE5-218:     rp8 r13 r16 r17 r19 r21 r23 r25 r29 r31 end
	//  bit offset:  0   24  37  53  70  89  110 133 158 187 218
	x = rp8 ^ (r13 << 24) ^ (r16 << 37) ^ (r17 << 53);
	p64[3] ^= LITTLE_ENDIAN64(x);
	x = (r17 >> 11) ^ (r19 << 6) ^ (r21 << 25) ^ (r23 << 46);
	p64[4] ^= LITTLE_ENDIAN64(x);
	x = (r23 >> 18) ^ (r25 << 5) ^ (r29 << 30) ^ (r31 << 59);
	p64[5] ^= LITTLE_ENDIAN64(x);
	*((uint32_t *) & p64[6]) ^= LITTLE_ENDIAN32(r31 >> 5);
}

void xe5_218_fixerr(void *block)
{
	int i;
	uint64_t rp8, r13, r16, r17, r19, r21, r23, r25, r29, r31;
	uint64_t *p64, x, y, c, t1, t2;

	//  decode
	p64 = (uint64_t *) block;
	x = LITTLE_ENDIAN64(p64[3]);
	rp8 = x;
	r13 = x >> 24;
	r16 = x >> 37;
	r17 = x >> 53;
	x = LITTLE_ENDIAN64(p64[4]);
	r17 ^= x << 11;
	r19 = x >> 6;
	r21 = x >> 25;
	r23 = x >> 46;
	x = LITTLE_ENDIAN64(p64[5]);
	r23 ^= x << 18;
	r25 = x >> 5;
	r29 = x >> 30;
	r31 = x >> 59;
	r31 ^= LITTLE_ENDIAN32(*((uint32_t *) & p64[6])) << 5;

	//  unfold
	y = rp8 & 0xFF;
	XM64_UNG8(y);
	XM64_UNF4(r13, 13);
	XM64_UNF2(r16, 16);
	XM64_UNF2(r17, 17);
	XM64_UNF2(r19, 19);
	XM64_UNF2(r21, 21);
	XM64_UNF2(r23, 23);
	XM64_UNF2(r25, 25);
	XM64_UNF2(r29, 29);
	XM64_UNF2(r31, 31);

	for (i = 0; i < 3; i++) {
		if (i > 0) {
			//  rotate
			rp8 >>= 8;
			y = rp8 & 0xFF;
			XM64_UNG8(y);
			XM64_ROTR(r13, 13);
			XM64_ROTR(r17, 17);
			XM64_ROTR(r19, 19);
			XM64_ROTR(r21, 21);
			XM64_ROTR(r23, 23);
			XM64_ROTR(r25, 25);
			XM64_ROTR(r29, 29);
			XM64_ROTR(r31, 31);
		}
		//  majority
		MX64_MJ10(c, y, t1, t2, x,
				  y, r13, r16, r17, r19, r21, r23, r25, r29, r31);
		p64[i] ^= LITTLE_ENDIAN64(x);
	}
}

#endif

//  == XE5-234 (256-bit payload) ==

#if PARAMS_XE == 234

void xe5_234_compute(void *block)
{
	int i;
	uint64_t p16, r16, r17, r19, r21, r23, r25, r29, r31, r37;
	uint64_t *p64, x;

	//  initialize
	p64 = (uint64_t *) block;
	p16 = r16 = r17 = r19 = r21 = r23 = r25 = r29 = r31 = r37 =
		LITTLE_ENDIAN64(p64[3]);
	XM64_GTH4(p16);

	for (i = 3; i >= 0; i--) {
		if (i < 3) {
			//  rotate
			XM64_RTLM(r17, 17);
			XM64_RTLM(r19, 19);
			XM64_RTLM(r21, 21);
			XM64_RTLM(r23, 23);
			XM64_RTLM(r25, 25);
			XM64_RTLM(r29, 29);
			XM64_RTLM(r31, 31);
			XM64_RTLM(r37, 37);

			//  xor
			x = LITTLE_ENDIAN64(p64[i]);
			r16 ^= x;
			r17 ^= x;
			r19 ^= x;
			r21 ^= x;
			r23 ^= x;
			r25 ^= x;
			r29 ^= x;
			r31 ^= x;
			r37 ^= x;
			XM64_GTH4(x);
			p16 = (p16 << 4) ^ x;
		}
		//  fold
		XM64_PR16(r16);
		XM64_FLD2(r17, 17);
		XM64_FLD2(r19, 19);
		XM64_FLD2(r21, 21);
		XM64_FLD2(r23, 23);
		XM64_FLD2(r25, 25);
		XM64_FLD2(r29, 29);
		XM64_FLD2(r31, 31);
		XM64_FLDM(r37, 37);
	}

	//  XE5-234:     p16 r16 r17 r19 r21 r23 r25 r29 r31 r37 end
	//  bit offset:  0   16  32  49  68  89  112 137 166 197 234
	x = p16 ^ (r16 << 16) ^ (r17 << 32) ^ (r19 << 49);
	p64[4] ^= LITTLE_ENDIAN64(x);
	x = (r19 >> 15) ^ (r21 << 4) ^ (r23 << 25) ^ (r25 << 48);
	p64[5] ^= LITTLE_ENDIAN64(x);
	x = (r25 >> 16) ^ (r29 << 9) ^ (r31 << 38);
	p64[6] ^= LITTLE_ENDIAN64(x);
	x = (r31 >> 26) ^ (r37 << 5);
	((uint32_t *) & p64[7])[0] ^= LITTLE_ENDIAN32(x);
	((uint16_t *) & p64[7])[2] ^= LITTLE_ENDIAN16(x >> 32);
}

void xe5_234_fixerr(void *block)
{
	int i;
	uint64_t p16, r16, r17, r19, r21, r23, r25, r29, r31, r37;
	uint64_t *p64, x, y, c, t1, t2;

	//  decode
	p64 = (uint64_t *) block;

	x = LITTLE_ENDIAN64(p64[4]);
	p16 = x;
	r16 = x >> 16;
	r17 = x >> 32;
	r19 = x >> 49;
	x = LITTLE_ENDIAN64(p64[5]);
	r19 ^= x << 15;
	r21 = x >> 4;
	r23 = x >> 25;
	r25 = x >> 48;
	x = LITTLE_ENDIAN64(p64[6]);
	r25 ^= x << 16;
	r29 = x >> 9;
	r31 = x >> 38;
	x = ((uint64_t) LITTLE_ENDIAN32(((uint32_t *) & p64[7])[0])) ^
		((uint64_t) LITTLE_ENDIAN16(((uint16_t *) & p64[7])[2]) << 32);
	r31 ^= x << 26;
	r37 = x >> 5;

	//  unfold
	y = p16 & 0xF;
	XM64_UNG4(y);
	XM64_UNF2(r16, 16);
	XM64_UNF2(r17, 17);
	XM64_UNF2(r19, 19);
	XM64_UNF2(r21, 21);
	XM64_UNF2(r23, 23);
	XM64_UNF2(r25, 25);
	XM64_UNF2(r29, 29);
	XM64_UNF2(r31, 31);
	XM64_UNFM(r37, 37);

	for (i = 0; i < 4; i++) {
		if (i > 0) {
			//  rotate
			p16 >>= 4;
			y = p16 & 0xF;
			XM64_UNG4(y);
			XM64_ROTR(r17, 17);
			XM64_ROTR(r19, 19);
			XM64_ROTR(r21, 21);
			XM64_ROTR(r23, 23);
			XM64_ROTR(r25, 25);
			XM64_ROTR(r29, 29);
			XM64_ROTR(r31, 31);
			XM64_ROTR(r37, 37);
		}
		//  majority
		MX64_MJ10(c, y, t1, t2, x,
				  y, r16, r17, r19, r21, r23, r25, r29, r31, r37);
		p64[i] ^= LITTLE_ENDIAN64(x);
	}
}

#endif

#endif
