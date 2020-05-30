//  r5_xof.c
//  2019-03-26  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (c) 2020, PQShield Ltd. All rights reserved.

//  Minimal interface to SP 800-185 (TupleHash) features.

#include <string.h>

#include "r5_xof.h"
#include "keccakf1600.h"

//  incremental input using idx

static inline void r5_xof_in(r5_xof_t * xof, const uint8_t * in, size_t len)
{
	size_t i;

	i = xof->idx;
	if (i > 0) {
		if (i + len < R5_XOF_RATE) {
			memcpy(xof->buf + i, in, len);
			xof->idx = i + len;
			return;
		}
		memcpy(xof->buf + i, in, R5_XOF_RATE - i);
		KeccakF1600_StateXORBytes(xof->st, xof->buf, 0, R5_XOF_RATE);
		KeccakF1600_StatePermute(xof->st);
		i = R5_XOF_RATE - i;
		len -= i;
		in += i;
		xof->idx = 0;
	}
	while (len >= R5_XOF_RATE) {
		KeccakF1600_StateXORBytes(xof->st, in, 0, R5_XOF_RATE);
		KeccakF1600_StatePermute(xof->st);
		len -= R5_XOF_RATE;
		in += R5_XOF_RATE;
	}
	if (len > 0) {
		memcpy(xof->buf, in, len);
		xof->idx = len;
	}
}

//  right_encode

static inline void r5_xof_renc(r5_xof_t * xof, size_t x)
{
	int i;
	uint8_t buf[9];

	i = 8;
	do {
		buf[--i] = x & 0xFF;
		x >>= 8;
	}
	while (x > 0);
	buf[8] = 8 - i;

	r5_xof_in(xof, buf + i, 9 - i);
}

//  left_encode

static inline void r5_xof_lenc(r5_xof_t * xof, size_t x)
{
	int i;
	uint8_t buf[9];

	i = 8;
	do {
		buf[i--] = x & 0xFF;
		x >>= 8;
	}
	while (x > 0);
	buf[i] = 8 - i;
	r5_xof_in(xof, buf + i, 9 - i);
}

//  incremental output using idx

void r5_xof_out(r5_xof_t * xof, void *out, size_t len)
{
	size_t i;
	uint8_t *op = out;

	i = R5_XOF_RATE - xof->idx;
	if (i >= len) {
		memcpy(op, xof->buf + xof->idx, len);
		xof->idx += len;
		return;
	}
	if (i > 0) {
		memcpy(op, xof->buf + xof->idx, i);
		op += i;
		len -= i;
		xof->idx = R5_XOF_RATE;
	}
	while (len >= R5_XOF_RATE) {
		KeccakF1600_StatePermute(xof->st);
		KeccakF1600_StateExtractBytes(xof->st, op, 0, R5_XOF_RATE);
		len -= R5_XOF_RATE;
		op += R5_XOF_RATE;
	}
	if (len > 0) {
		KeccakF1600_StatePermute(xof->st);
		KeccakF1600_StateExtractBytes(xof->st, xof->buf, 0, R5_XOF_RATE);
		memcpy(op, xof->buf, len);
		xof->idx = len;
	}
}


//  Encode a string (data element) from "dat", "len" bytes

void r5_xof_str(r5_xof_t * xof, const void *dat, size_t len)
{
	r5_xof_lenc(xof, 8 * len);
	if (len > 0) {
		r5_xof_in(xof, dat, len);
	}
}

//  Reset and initialize the context

void r5_xof_ini(r5_xof_t * xof)
{
	static uint64_t cache_st[25];
	static int cache_ini = 0;
	size_t i;

	if (cache_ini) {
		//  we have cached stated stored..
		for (i = 0; i < 25; i++) {
			xof->st[i] = cache_st[i];
		}
	} else {
		//  initialize the permutation
		for (i = 0; i < 25; i++) {
			xof->st[i] = 0;
		}
		xof->idx = 0;
		r5_xof_lenc(xof, R5_XOF_RATE);
		r5_xof_str(xof, "TupleHash", 9);
		r5_xof_str(xof, NULL, 0);			//  S
//      r5_xof_str(xof, "My Tuple App", 12);
		memset(xof->buf + xof->idx, 0x00, R5_XOF_RATE - xof->idx);
		KeccakF1600_StateXORBytes(xof->st, xof->buf, 0, R5_XOF_RATE);
		KeccakF1600_StatePermute(xof->st);
		for (i = 0; i < 25; i++) {
			cache_st[i] = xof->st[i];
		}
		cache_ini = 1;
	}

	xof->idx = 0;
}

//  Pad for output, "bits" = number of output bits, 0 = XOF

void r5_xof_pad(r5_xof_t * xof, size_t bits)
{
	size_t i;

	r5_xof_renc(xof, bits);					//  output length
	i = xof->idx;
	xof->buf[i] = 0x04;						//  cSHAKE
	memset(xof->buf + i + 1, 0x00, R5_XOF_RATE - i - 1);
	xof->buf[R5_XOF_RATE - 1] |= 0x80;
	KeccakF1600_StateXORBytes(xof->st, xof->buf, 0, R5_XOF_RATE);
	xof->idx = R5_XOF_RATE;
	//  no call to permutation unless output actually requested
}
