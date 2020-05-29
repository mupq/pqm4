//  r5_xofgen.c
//  2020-04-02  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (c) 2020, PQShield Ltd. All rights reserved.

//  xof-related (domain separation) convenience functions

#include "r5_xofgen.h"
#include "r5_xof.h"

//  Convenience function for 3-tuples

void r5_xof_triplet(void *out, size_t olen,
					const void *a, size_t alen,
					const void *b, size_t blen, const void *c, size_t clen)
{
	r5_xof_t xof;

	r5_xof_ini(&xof);
	r5_xof_str(&xof, a, alen);
	r5_xof_str(&xof, b, blen);
	r5_xof_str(&xof, c, clen);
	r5_xof_pad(&xof, 8 * olen);				//  TupleHash
	r5_xof_out(&xof, out, olen);
}

//  A public value generation

void r5_xof_agen(void *d, size_t len, size_t blen, const uint8_t * seed)
{
	r5_xof_t xof;

	uint8_t ibyte = 0;
	uint8_t *dpt = d;

	while (len > 0) {
		r5_xof_ini(&xof);
		r5_xof_str(&xof, "AGEN", 4);
		r5_xof_str(&xof, seed, PARAMS_KAPPA_BYTES);
		r5_xof_str(&xof, &ibyte, 1);
		r5_xof_pad(&xof, 8 * blen);			//  TupleHash
		if (blen > len)						//  XXX this should be before pad
			blen = len;
		r5_xof_out(&xof, dpt, blen);
		dpt += blen;
		len -= blen;
		ibyte++;
	}
}
