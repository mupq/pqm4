#ifndef PARAM_H
#define PARAM_H

/******************************************************************
 * Mutable parameters
 ******************************************************************/
#define KINDI_KEM_N 256
#define KINDI_KEM_LAMBDA 128
#define KINDI_KEM_SHAKEMODE 128

#define KINDI_KEM_LOGQ 14
#define KINDI_KEM_L 3
#define KINDI_KEM_T 2
#define KINDI_KEM_LOG2RSEC 2
#define KINDI_KEM_S1SIZE (256/8)
#define KINDI_KEM_S1BITS 1
/******************************************************************
 * Derived parameters
 ******************************************************************/
#define KINDI_KEM_Q (1<<KINDI_KEM_LOGQ)
#define KINDI_KEM_RSEC (1<<KINDI_KEM_LOG2RSEC)
#define KINDI_KEM_BYTESLOGQ ((int)ceil((KINDI_KEM_LOGQ / 8.0)))
#define KINDI_KEM_BYTESLOGRSECP1 ((int)ceil(((KINDI_KEM_LOG2RSEC+1) / 8.0)))

#define KINDI_KEM_SEEDSIZE (2*KINDI_KEM_LAMBDA/8)
#define KINDI_KEM_HASHSIZE (2*KINDI_KEM_LAMBDA/8)
#define KINDI_KEM_MESSAGEBYTES ((KINDI_KEM_L+1)*KINDI_KEM_N*(KINDI_KEM_LOG2RSEC+1)/8)

#define KINDI_KEM_SK_COEFFICIENTBITS (KINDI_KEM_LOG2RSEC+1)
#define KINDI_KEM_NUMBER_CIPHERPOLY (KINDI_KEM_L+1)
#define KINDI_KEM_NUMBER_CIPHERCOEFF (KINDI_KEM_NUMBER_CIPHERPOLY*KINDI_KEM_N)
#define KINDI_KEM_CIPHER_POLYBYTES ((KINDI_KEM_N*(KINDI_KEM_LOGQ))/8)
#define KINDI_KEM_PK_POLYBYTES ((KINDI_KEM_N*(KINDI_KEM_LOGQ-KINDI_KEM_T))/8)
#define KINDI_KEM_SK_POLYBYTES ((KINDI_KEM_N*KINDI_KEM_SK_COEFFICIENTBITS)/8)

#define KINDI_KEM_CIPHERBYTES (KINDI_KEM_NUMBER_CIPHERPOLY*KINDI_KEM_CIPHER_POLYBYTES)
#define KINDI_KEM_SECRETKEYBYTES (KINDI_KEM_L*KINDI_KEM_SK_POLYBYTES + KINDI_KEM_PUBLICKEYBYTES)
#define KINDI_KEM_PUBLICKEYBYTES (KINDI_KEM_L*KINDI_KEM_PK_POLYBYTES + KINDI_KEM_SEEDSIZE)

//####################################################################

#endif
