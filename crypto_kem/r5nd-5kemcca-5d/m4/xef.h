//  xef.h
//  2018-10-25 Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  (c) 2018   PQShield Ltd. All Rights Reserved.

//  Prototypes for error correction codes

#ifndef _XEF_H_
#define _XEF_H_

#include <stdint.h>
#include <stddef.h>

//  Computes the parity code, XORs it at the end of payload
//  len = payload (bytes). Returns (payload | xef) length in *bits*.
//  size_t xef_compute(void *block, size_t len, unsigned f);

//  Fixes errors based on parity code. Call xef_compute() first to get delta.
//  len = payload (bytes). Returns (payload | xef) length in *bits*.
//  size_t xef_fixerr(void *block, size_t len, unsigned f);


void xe2_53_compute(void *block);       // xe2_c16.c
void xe2_53_fixerr(void *block);

void xe4_163_compute(void *block);      // xe4_c64.c
void xe4_163_fixerr(void *block);

void xe5_190_compute(void *block);      // xe5_c64.c
void xe5_190_fixerr(void *block);
void xe5_218_compute(void *block);
void xe5_218_fixerr(void *block);
void xe5_234_compute(void *block);
void xe5_234_fixerr(void *block);

/* Wrapper around xef functions so we can seamlessly make use of the optimized xe5 */

#if PARAMS_F == 5
#if PARAMS_XE == 190
#define XEF(function, block, len, f) xe5_190_##function(block)
#elif PARAMS_XE == 218
#define XEF(function, block, len, f) xe5_218_##function(block)
#elif PARAMS_XE == 234
#define XEF(function, block, len, f) xe5_234_##function(block)
#endif
#elif PARAMS_F == 4 && PARAMS_XE == 163
#define XEF(function, block, len, f) xe4_163_##function(block)
#elif PARAMS_F == 2 && PARAMS_XE == 53
#define XEF(function, block, len, f) xe2_53_##function(block)
#else
#define XEF(function, block, len, f) xef_##function(block, len, f)
#endif

#define xef_compute(block, len, f) XEF(compute, block, len, f)
#define xef_fixerr(block, len, f) XEF(fixerr, block, len, f)

#endif /* _XEF_H_ */
