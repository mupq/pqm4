#ifndef PARAMS_H
#define PARAMS_H

#ifndef VIPER_PARAM
#define VIPER_PARAM 128
#endif

#define MLWQ_N 256
#define MLWQ_Q 3329

#define SEEDBYTES 32
#define HASHBYTES 32

#if VIPER_PARAM == 128
  #define PARAM_NAME "Viper-128"
  #define MLWQ_K 2
  #define MLWQ_ETA_S 2
  #define MLWQ_ETA_R 2
  #define BIT_PK 10
  #define BIT_U  9
  #define BIT_V  5
#elif VIPER_PARAM == 192
  #define PARAM_NAME "Viper-192"
  #define MLWQ_K 3
  #define MLWQ_ETA_S 3
  #define MLWQ_ETA_R 2
  #define BIT_PK 10
  #define BIT_U  10
  #define BIT_V  5
#elif VIPER_PARAM == 256
  #define PARAM_NAME "Viper-256"
  #define MLWQ_K 4
  #define MLWQ_ETA_S 3
  #define MLWQ_ETA_R 2
  #define BIT_PK 10
  #define BIT_U  10
  #define BIT_V  5
#elif VIPER_PARAM == 384
  #define PARAM_NAME "Viper-384"
  #define MLWQ_K 7
  #define MLWQ_ETA_S 1
  #define MLWQ_ETA_R 1
  #define BIT_PK 11
  #define BIT_U  11
  #define BIT_V  6
  #define MSG_BITS 2
  #define MU_BYTES 48
  #define MLWQ_SSBYTES 48
#elif VIPER_PARAM == 512
  #define PARAM_NAME "Viper-512"
  #define MLWQ_K 9
  #define MLWQ_ETA_S 1
  #define MLWQ_ETA_R 1
  #define BIT_PK 11
  #define BIT_U  11
  #define BIT_V  7
  #define MSG_BITS 2
  #define MU_BYTES 64
  #define MLWQ_SSBYTES 64
#else
  #error "Invalid VIPER_PARAM (expected 128/192/256/384/512)"
#endif

#ifndef MSG_BITS
#define MSG_BITS 1
#endif
#ifndef MU_BYTES
#define MU_BYTES 32
#endif
#ifndef MLWQ_SSBYTES
#define MLWQ_SSBYTES 32
#endif

#define MU_BITS (MU_BYTES * 8)

#define P_PK (1 << BIT_PK)
#define P_U  (1 << BIT_U)
#define P_V  (1 << BIT_V)

#define MLWQ_ETA1 MLWQ_ETA_S

#define MLWQ_POLYBYTES ((MLWQ_N * BIT_PK) / 8)
#define MLWQ_POLYVECBYTES (MLWQ_K * MLWQ_POLYBYTES)
#define MLWQ_POLY_U_BYTES ((MLWQ_N * BIT_U) / 8)
#define MLWQ_POLYVECCOMPRESSEDBYTES (MLWQ_K * MLWQ_POLY_U_BYTES)
#define MLWQ_POLYCOMPRESSEDBYTES ((MLWQ_N * BIT_V) / 8)

#if VIPER_PARAM == 384
#define MLWQ_CIPHERTEXTBYTES (MLWQ_POLYVECCOMPRESSEDBYTES + MLWQ_POLYCOMPRESSEDBYTES + MU_BYTES)
#elif VIPER_PARAM == 512
#define MLWQ_CIPHERTEXTBYTES (MLWQ_POLYVECCOMPRESSEDBYTES + MLWQ_POLYCOMPRESSEDBYTES + MU_BYTES)
#else
#define MLWQ_CIPHERTEXTBYTES (MLWQ_POLYVECCOMPRESSEDBYTES + MLWQ_POLYCOMPRESSEDBYTES + SEEDBYTES)
#endif
#define MLWQ_PUBLICKEYBYTES (MLWQ_POLYVECBYTES + SEEDBYTES)
#define MLWQ_SECRETKEYBYTES (MLWQ_POLYVECBYTES)
#if VIPER_PARAM == 128
#define MLWQ_KEM_SECRETKEYBYTES 1504
#elif VIPER_PARAM == 192
#define MLWQ_KEM_SECRETKEYBYTES 2208
#elif VIPER_PARAM == 256
#define MLWQ_KEM_SECRETKEYBYTES 2912
#elif VIPER_PARAM == 384
#define MLWQ_KEM_SECRETKEYBYTES 5280
#elif VIPER_PARAM == 512
#define MLWQ_KEM_SECRETKEYBYTES 6784
#endif

#define CRYPTO_PUBLICKEYBYTES MLWQ_PUBLICKEYBYTES
#define CRYPTO_CIPHERTEXTBYTES MLWQ_CIPHERTEXTBYTES
#define CRYPTO_SECRETKEYBYTES MLWQ_KEM_SECRETKEYBYTES

#endif