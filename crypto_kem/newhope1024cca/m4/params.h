#ifndef PARAMS_H
#define PARAMS_H

#ifndef NEWHOPE_N
#define NEWHOPE_N 1024
#endif

#define NEWHOPE_Q 12289
#define NEWHOPE_K 8           /* used in noise sampling */

#define NEWHOPE_SYMBYTES 32   /* size of shared key, seeds/coins, and hashes */

#define NEWHOPE_POLYBYTES            ((14*NEWHOPE_N)/8)
#define NEWHOPE_POLYCOMPRESSEDBYTES  (( 3*NEWHOPE_N)/8)

#define NEWHOPE_CPAPKE_PUBLICKEYBYTES  (NEWHOPE_POLYBYTES + NEWHOPE_SYMBYTES)
#define NEWHOPE_CPAPKE_SECRETKEYBYTES  (NEWHOPE_POLYBYTES)
#define NEWHOPE_CPAPKE_CIPHERTEXTBYTES (NEWHOPE_POLYBYTES + NEWHOPE_POLYCOMPRESSEDBYTES)

#define NEWHOPE_CPAKEM_PUBLICKEYBYTES NEWHOPE_CPAPKE_PUBLICKEYBYTES
#define NEWHOPE_CPAKEM_SECRETKEYBYTES NEWHOPE_CPAPKE_SECRETKEYBYTES
#define NEWHOPE_CPAKEM_CIPHERTEXTBYTES NEWHOPE_CPAPKE_CIPHERTEXTBYTES

#define NEWHOPE_CCAKEM_PUBLICKEYBYTES NEWHOPE_CPAPKE_PUBLICKEYBYTES
#define NEWHOPE_CCAKEM_SECRETKEYBYTES (NEWHOPE_CPAPKE_SECRETKEYBYTES + NEWHOPE_CPAPKE_PUBLICKEYBYTES + 2*NEWHOPE_SYMBYTES)
#define NEWHOPE_CCAKEM_CIPHERTEXTBYTES (NEWHOPE_CPAPKE_CIPHERTEXTBYTES + NEWHOPE_SYMBYTES)  /* Second part is for Targhi-Unruh */

#endif
