#ifndef RIJNDAEL_H
#define RIJNDAEL_H

#include <stdint.h>

void AES_128_keyschedule(const uint8_t *key, uint8_t *rk);
void AES_128_encrypt(const uint8_t *rk, const uint8_t *in, uint8_t *out);

#endif
