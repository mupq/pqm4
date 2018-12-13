#ifndef AES128_H
#define AES128_H

#include <stdint.h>

void AES128_load_schedule(const uint8_t *key, uint8_t *schedule);
void AES128_ECB_enc_sch(const uint8_t *plaintext, const size_t plaintext_len, const uint8_t *schedule, uint8_t *ciphertext);

#endif
