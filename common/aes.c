#include <stdint.h>
#include <string.h>
#include "aes.h"
#include "rijndael.h"

void AES128_load_schedule(const uint8_t *key, uint8_t *schedule) {

  memcpy(schedule,key,16);

  AES_128_keyschedule(key,schedule+16);

}     

void AES128_ECB_enc_sch(const uint8_t *plaintext, const size_t plaintext_len, const uint8_t *schedule, uint8_t *ciphertext) {

    for (size_t block = 0; block < plaintext_len / 16; block++) {
        AES_128_encrypt(schedule, plaintext + (16 * block), ciphertext + (16 * block));
    }

}

