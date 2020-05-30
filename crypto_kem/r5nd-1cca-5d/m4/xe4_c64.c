//  xe4_c64.c
//  2019-09-21  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (C) 2019, PQShield Ltd. Please see LICENSE.

//  Optimized 64-bit "ANSI C" implementation of XE4-163

#include "r5_parameter_sets.h"

#if (PARAMS_F == 4 && PARAMS_XE == 163)

#include "xef.h"
#include "little_endian.h"

//  various bit-twiddling macros for 64-bit words

#define XM64_RTLM(r, n) { r = ((r << (64 % n)) | (r >> (n - (64 % n)))) & \
								 ((1llu << n) - 1llu);}
#define XM64_FLDM(r, n) { r = (r ^ ((r >> n))) & ((1llu << n) - 1llu); }
#define XM64_FLD2(r, n) { r ^= r >> (2 * n); XM64_FLDM(r, n); }
#define XM64_FLD4(r, n) { r ^= r >> (4 * n); XM64_FLD2(r, n); }

#define XM64_PR16(r) { r ^= r >> 32; r = (r ^ (r >> 16)) & 0xFFFF; }
#define XM64_UNFM(r, n) { r &= ((1llu << n) - 1llu); r |= r << n; }
#define XM64_UNF2(r, n) { XM64_UNFM(r, n); r |= r << (2 * n); }
#define XM64_UNF4(r, n) { XM64_UNF2(r, n); r |= r << (4 * n); }
#define XM64_ROTR(r, n) { r = ((r >> (64 % n)) | (r << (n - (64 % n)))); }

#define MX64_MJ8(c, t0, t1, t2, t3, v0, v1, v2, v3, v4, v5, v6, v7) \
{ \
	t1 = v0 & v1; t0 = v0 ^ v1; \
	c = t0 & v2; t0 ^= v2; t1 ^= c; \
	c = t0 & v3; t0 ^= v3; t1 ^= c; t2 = c & ~t1; \
	c = t0 & v4; t0 ^= v4; t1 ^= c; c &= ~t1; t2 ^= c; \
	c = t0 & v5; t0 ^= v5; t1 ^= c; c &= ~t1; t2 ^= c; \
	c = t0 & v6; t0 ^= v6; t1 ^= c; c &= ~t1; t2 ^= c; \
	c = t0 & v7; t0 ^= v7; t1 ^= c; c &= ~t1; t2 ^= c; t3 = c & ~t2; \
	c = t0 | t1; t2 ^= c; t3 ^= c & ~t2; \
}

//  == XE4-163 (192-bit payload) ==

void xe4_163_compute(void *block)
{
	int i;
	uint64_t r13, r15, r16, r17, r19, r23, r29, r31;
	uint64_t *p64, x;

	//  initialize
	p64 = (uint64_t *) block;
	r13 = r15 = r16 = r17 = r19 = r23 = r29 = r31 = LITTLE_ENDIAN64(p64[2]);

	for (i = 2; i >= 0; i--) {
		if (i < 2) {
			//  rotate
			XM64_RTLM(r13, 13);
			XM64_RTLM(r15, 15);
			XM64_RTLM(r17, 17);
			XM64_RTLM(r19, 19);
			XM64_RTLM(r23, 23);
			XM64_RTLM(r29, 29);
			XM64_RTLM(r31, 31);

			//  xor
			x = LITTLE_ENDIAN64(p64[i]);
			r13 ^= x;
			r15 ^= x;
			r16 ^= x;
			r17 ^= x;
			r19 ^= x;
			r23 ^= x;
			r29 ^= x;
			r31 ^= x;
		}
		//  fold
		XM64_FLD4(r13, 13);
		XM64_FLD4(r15, 15);
		XM64_PR16(r16);
		XM64_FLD2(r17, 17);
		XM64_FLD2(r19, 19);
		XM64_FLD2(r23, 23);
		XM64_FLD2(r29, 29);
		XM64_FLD2(r31, 31);
	}

	//  XE4-163:     r13 r15 r16 r17 r19 r23 r29 r31 end
	//  bit offset:  0   13  28  44  61  80  103 132 163

	x = r13 ^ (r15 << 13) ^ (r16 << 28) ^ (r17 << 44) ^ (r19 << 61);
	p64[3] ^= LITTLE_ENDIAN64(x);
	x = (r19 >> 3) ^ (r23 << 16) ^ (r29 << 39);
	p64[4] ^= LITTLE_ENDIAN64(x);
	x = (uint32_t) ((r29 >> 25) ^ (r31 << 4));
	((uint32_t *) block)[10] ^= LITTLE_ENDIAN32(x);
	((uint8_t *) block)[44] ^= (uint8_t) (r31 >> 28);
}

void xe4_163_fixerr(void *block)
{
	int i;
	uint64_t r13, r15, r16, r17, r19, r23, r29, r31;
	uint64_t *p64, x, c, t0, t1, t2;

	//  decode
	p64 = (uint64_t *) block;
	x = LITTLE_ENDIAN64(p64[3]);
	r13 = x;
	r15 = x >> 13;
	r16 = x >> 28;
	r17 = x >> 44;
	r19 = x >> 61;
	x = LITTLE_ENDIAN64(p64[4]);
	r19 ^= x << 3;
	r23 = x >> 16;
	r29 = x >> 39;
	x = LITTLE_ENDIAN32(((uint32_t *) block)[10]);
	r29 ^= x << 25;
	r31 = x >> 4;
	x = ((uint8_t *) block)[44];
	r31 ^= x << 28;

	//  unfold
	XM64_UNF4(r13, 13);
	XM64_UNF4(r15, 15);
	XM64_UNF2(r16, 16);
	XM64_UNF2(r17, 17);
	XM64_UNF2(r19, 19);
	XM64_UNF2(r23, 23);
	XM64_UNF2(r29, 29);
	XM64_UNF2(r31, 31);

	for (i = 0; i < 3; i++) {
		if (i > 0) {
			//  rotate
			XM64_ROTR(r13, 13);
			XM64_ROTR(r15, 15);
			XM64_ROTR(r17, 17);
			XM64_ROTR(r19, 19);
			XM64_ROTR(r23, 23);
			XM64_ROTR(r29, 29);
			XM64_ROTR(r31, 31);
		}
		//  majority
		MX64_MJ8(c, t0, t1, t2, x, r13, r15, r16, r17, r19, r23, r29, r31);
		p64[i] ^= LITTLE_ENDIAN64(x);
	}
}

#endif
