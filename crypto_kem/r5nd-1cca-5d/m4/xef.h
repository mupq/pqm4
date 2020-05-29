//  xef.h
//  2018-10-25 Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (c) 2020, PQShield Ltd. All rights reserved.

//  Prototypes for error correction codes

#ifndef _XEF_H_
#define _XEF_H_

//  #include "../pqs_local.h"

/* Wrapper around xef functions so we can seamlessly make use of the optimized xe5 */

#if PARAMS_F == 5
#if PARAMS_XE == 190
PQS_OLOCAL void xe5_190_compute(void *block);	// xe5_c64.c
PQS_OLOCAL void xe5_190_fixerr(void *block);
#define XEF(function, block, len, f) xe5_190_##function(block)
#elif PARAMS_XE == 218
PQS_OLOCAL void xe5_218_compute(void *block);
PQS_OLOCAL void xe5_218_fixerr(void *block);
#define XEF(function, block, len, f) xe5_218_##function(block)
#elif PARAMS_XE == 234
PQS_OLOCAL void xe5_234_compute(void *block);
PQS_OLOCAL void xe5_234_fixerr(void *block);
#define XEF(function, block, len, f) xe5_234_##function(block)
#endif
#elif PARAMS_F == 4 && PARAMS_XE == 163
PQS_OLOCAL void xe4_163_compute(void *block);	// xe4_c64.c
PQS_OLOCAL void xe4_163_fixerr(void *block);
#define XEF(function, block, len, f) xe4_163_##function(block)
#elif PARAMS_F == 2 && PARAMS_XE == 53
PQS_OLOCAL void xe2_53_compute(void *block);	// xe2_c16.c
PQS_OLOCAL void xe2_53_fixerr(void *block);
#define XEF(function, block, len, f) xe2_53_##function(block)
#else
#define XEF(function, block, len, f) xef_##function(block, len, f)
#endif

#define XEF_COMPUTE(block, len, f) XEF(compute, block, len, f)
#define XEF_FIXERR(block, len, f) XEF(fixerr, block, len, f)

#endif										/* _XEF_H_ */
