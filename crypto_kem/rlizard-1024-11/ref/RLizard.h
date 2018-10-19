#ifndef RLIZARD_H
#define RLIZARD_H

#include <stdint.h>
#include "params.h"
#include "api.h"


#define sft (sizeof(size_t) * 4 - 1)

typedef unsigned char SecretKey[CRYPTO_SECRETKEYBYTES];
typedef unsigned char PublicKey[CRYPTO_PUBLICKEYBYTES];


#endif
