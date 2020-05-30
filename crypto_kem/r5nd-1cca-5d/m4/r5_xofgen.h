//  r5_xofgen.h
//  2020-04-02  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (c) 2020, PQShield Ltd. All rights reserved.

#ifndef _R5_XOFGEN_H_
#define _R5_XOFGEN_H_

#include <stdint.h>
#include <stddef.h>

#define AGEN_NBLOCKS 8

//  "A" vector/matrix generation ("parallel")
void r5_xof_agen(void *d, size_t len, size_t blen, const uint8_t * seed);

//  Convenience function for 3-tuples
void r5_xof_triplet(void *out, size_t olen,
					const void *a, size_t alen,
					const void *b, size_t blen, const void *c, size_t clen);

#endif
