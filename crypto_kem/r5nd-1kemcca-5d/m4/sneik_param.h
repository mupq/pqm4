//  sneik_param.h
//  2019-02-19  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (C) 2019, PQShield Ltd. Please see LICENSE.

//  This file provides a BLNK2 instantations with the SNEIK permutation.

#ifndef _SNEIK_PARAM_H_
#define _SNEIK_PARAM_H_

#include <stdint.h>
#include "api.h"

// Cryptographic permutation prototype
void sneik_f512(void *state, uint8_t dom, uint8_t rounds);

// Parameters (sizes are in bytes)
#define BLNK_BLOCK 64

// Profile the permutation ?
#ifdef XOF_PROF
extern uint32_t perm_count[];
#define BLNK_PI(x, dom, rounds) {\
    perm_count[rounds]++;\
    sneik_f512(x, dom, rounds); }
#else
// no profiling
#define BLNK_PI(x, dom, rounds) sneik_f512(x, dom, rounds)
#endif /* XOF_PROF */

// == SNEIKEN AEADs ==

#define SNEIKEN_RATE (BLNK_BLOCK - PARAMS_KAPPA_BYTES)

//  number of rounds for encryption
#if (PARAMS_KAPPA_BYTES <= 16)
#define SNEIKEN_ROUNDS 6
#elif (PARAMS_KAPPA_BYTES <= 24)
#define SNEIKEN_ROUNDS 7
#elif (PARAMS_KAPPA_BYTES <= 32)
#define SNEIKEN_ROUNDS 8
#elif (PARAMS_KAPPA_BYTES <= 48)
#define SNEIKEN_ROUNDS 8
#else
#error "SNEIKEN: Could not determine security level."
#endif

//  == SNEIKHA Cryptographic Hashes ==

//  number of rounds for hashing
#if (PARAMS_KAPPA_BYTES <= 16)
#define SNEIKHA_ROUNDS 6
#define SNEIKHA_RATE 32
#elif (PARAMS_KAPPA_BYTES <= 32)
#define SNEIKHA_ROUNDS 8
#define SNEIKHA_RATE 16
#elif (PARAMS_KAPPA_BYTES <= 48)
#define SNEIKHA_ROUNDS 12
#define SNEIKHA_RATE 8
#else
#error "SNEIKHA: Could not determine security level."
#endif

//  == SNEIGEN Entropy distribution function ==

#ifdef PARAMS_KAPPA_BYTES

#define SNEIGEN_RATE (BLNK_BLOCK - PARAMS_KAPPA_BYTES)

//  number of rounds for entropy diffusion
#if (PARAMS_KAPPA_BYTES <= 8)
#define SNEIGEN_ROUNDS 2
#elif (PARAMS_KAPPA_BYTES <= 16)
#define SNEIGEN_ROUNDS 3
#elif (PARAMS_KAPPA_BYTES <= 24)
#define SNEIGEN_ROUNDS 4
#elif (PARAMS_KAPPA_BYTES <= 32)
#define SNEIGEN_ROUNDS 5
#else
#error "SNEIGEN: Could not determine security level."
#endif

#endif /* PARAMS_KAPPA_BYTES */

#endif  /* _SNEIK_PARAM_H_ */

