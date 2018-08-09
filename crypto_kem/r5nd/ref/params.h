//  params.h
//  2018-06-26  Markku-Juhani O. Saarinen <mjos@iki.fi>

#ifndef _PARAMS_H_
#define _PARAMS_H_

#include <stdint.h>
#include <stddef.h>

// parameter sets defined here

#ifdef R5ND_1KEM
#define NOFO_CPA
#define PARAMS_ND       522
#define PARAMS_H        208
#define PARAMS_Q_BITS   14
#define PARAMS_P_BITS   8
#define PARAMS_T_BITS   4
#define PARAMS_SS_SIZE  16
#define PARAMS_XE       91
#define CRYPTO_ALGNAME  "Round5 R5ND_1KEM"
#endif

#ifdef R5ND_3KEM
#define NOFO_CPA
#define PARAMS_ND       756
#define PARAMS_H        242
#define PARAMS_Q_BITS   15
#define PARAMS_P_BITS   8
#define PARAMS_T_BITS   4
#define PARAMS_SS_SIZE  24
#define PARAMS_XE       103
#define CRYPTO_ALGNAME  "Round5 R5ND_3KEM"
#endif

#ifdef R5ND_5KEM
#define NOFO_CPA
#define PARAMS_ND       1018
#define PARAMS_H        254
#define PARAMS_Q_BITS   15
#define PARAMS_P_BITS   8
#define PARAMS_T_BITS   4
#define PARAMS_SS_SIZE  32
#define PARAMS_XE       121
#define CRYPTO_ALGNAME  "Round5 R5ND_5KEM"
#endif

#ifdef R5ND_1PKE
#define PARAMS_ND       546
#define PARAMS_H        158
#define PARAMS_Q_BITS   16
#define PARAMS_P_BITS   8
#define PARAMS_T_BITS   4
#define PARAMS_SS_SIZE  16
#define PARAMS_XE       91
#define CRYPTO_ALGNAME  "Round5 R5ND_1PKE"
#endif

#ifdef R5ND_3PKE
#define PARAMS_ND       786
#define PARAMS_H        204
#define PARAMS_Q_BITS   16
#define PARAMS_P_BITS   8
#define PARAMS_T_BITS   6
#define PARAMS_SS_SIZE  24
#define PARAMS_XE       103
#define CRYPTO_ALGNAME  "Round5 R5ND_3PKE"
#endif

#ifdef R5ND_5PKE
#define PARAMS_ND       1108
#define PARAMS_H        198
#define PARAMS_Q_BITS   16
#define PARAMS_P_BITS   8
#define PARAMS_T_BITS   5
#define PARAMS_SS_SIZE  32
#define PARAMS_XE       121
#define CRYPTO_ALGNAME  "Round5 R5ND_5PKE"
#endif

#ifndef CRYPTO_ALGNAME
#error You must define one of: R5ND_1KEM R5ND_1PKE R5ND_3KEM R5ND_3PKE R5ND_5KEM R5ND_5PKE.
#endif

// appropriate types
typedef uint16_t modq_t;
#if (PARAMS_P_BITS <= 8)
typedef uint8_t modp_t;
#else
typedef uint16_t modp_t;
#endif
typedef uint8_t modt_t;

// padding space for unrolled loop
#ifdef CM_CACHE
#define PARAMS_MUL_PAD  1
#else
// This is the best unroll parameter for 3PKE .. not all
#define PARAMS_MUL_PAD  7
#endif /* CM_CACHE */

// derive internal parameters
#ifndef BITS_TO_BYTES
#define BITS_TO_BYTES(x) (((x) + 7) / 8)
#endif

#define PARAMS_Q        (1 << PARAMS_Q_BITS)
#define PARAMS_Q_MASK   (PARAMS_Q - 1)
#define PARAMS_P_MASK   ((1 << PARAMS_P_BITS) - 1)
#define PARAMS_MU       (8 * PARAMS_SS_SIZE + PARAMS_XE)
#define PARAMS_XE_SIZE  BITS_TO_BYTES(PARAMS_XE)
#define PARAMS_NDP_SIZE BITS_TO_BYTES(PARAMS_ND * PARAMS_P_BITS)
#define PARAMS_MUT_SIZE BITS_TO_BYTES(PARAMS_MU * PARAMS_T_BITS)
#define PARAMS_RS_DIV   (0x10000 / PARAMS_ND)
#define PARAMS_RS_LIM   (PARAMS_ND * PARAMS_RS_DIV)

#define PARAMS_PK_SIZE  (PARAMS_SS_SIZE + PARAMS_NDP_SIZE)
#define PARAMS_SK_SIZE  PARAMS_SS_SIZE
#define PARAMS_CT_SIZE  (PARAMS_NDP_SIZE + PARAMS_MUT_SIZE)

// Derive the NIST parameters

// NOFO_CPA = no Fujisaki-Okamoto -> CPA
#ifdef NOFO_CPA

// CPA Variant
#define CRYPTO_SECRETKEYBYTES  PARAMS_SK_SIZE
#define CRYPTO_PUBLICKEYBYTES  PARAMS_PK_SIZE
#define CRYPTO_BYTES           PARAMS_SS_SIZE
#define CRYPTO_CIPHERTEXTBYTES PARAMS_CT_SIZE

#else /* NOFO_CPA */

// CCA Variant
#define CRYPTO_SECRETKEYBYTES  (PARAMS_SK_SIZE + PARAMS_SS_SIZE + PARAMS_PK_SIZE)
#define CRYPTO_PUBLICKEYBYTES  PARAMS_PK_SIZE
#define CRYPTO_BYTES           PARAMS_SS_SIZE
#define CRYPTO_CIPHERTEXTBYTES (PARAMS_CT_SIZE + PARAMS_SS_SIZE)

#endif /* NOFO_CPA */

#endif /* _PARAMS_H_ */

