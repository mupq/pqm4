#ifndef CONFIG_H
#define CONFIG_H

#define HAETAE_MODE 3

/*********************************************************************
 * STACK_STRATEGY
 *   0 or undefined:    optimized for speed (default)
 *   1:                 do not buffer the polynomials of
 *                      the verification key
 *   2:                 as 1, and use multiple passes 
 *                      to sample the hyperball
 *********************************************************************/
#define STACK_STRATEGY 0

#if HAETAE_MODE == 2
#define CRYPTO_ALGNAME "HAETAE2"
#define HAETAE_NAMESPACETOP haetae2
#define HAETAE_NAMESPACE(s) cryptolab_haetae2_##s
#elif HAETAE_MODE == 3
#define CRYPTO_ALGNAME "HAETAE3"
#define HAETAE_NAMESPACETOP haetae3
#define HAETAE_NAMESPACE(s) cryptolab_haetae3_##s
#elif HAETAE_MODE == 5
#define CRYPTO_ALGNAME "HAETAE5"
#define HAETAE_NAMESPACETOP haetae5
#define HAETAE_NAMESPACE(s) cryptolab_haetae5_##s
#endif
#endif
