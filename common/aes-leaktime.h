#ifndef AES_LEAKTIME_H
#define AES_LEAKTIME_H

#include <stdint.h>
#include <stdlib.h>

#define AES128_KEYBYTES 16
#define AES192_KEYBYTES 24
#define AES256_KEYBYTES 32
#define AESCTR_NONCEBYTES 12
#define AES_BLOCKBYTES 16

typedef struct {
    uint64_t sk_exp[88];
} aes128leaktimectx;

typedef struct {
    uint64_t sk_exp[104];
} aes192leaktimectx;

typedef struct {
    uint64_t sk_exp[120];
} aes256leaktimectx;



/** Initializes the context **/
void aes128_ecb_keyexp_leaktime(aes128leaktimectx *r, const unsigned char *key);

void aes128_ctr_keyexp_leaktime(aes128leaktimectx *r, const unsigned char *key);

void aes128_ecb_leaktime(unsigned char *out, const unsigned char *in, size_t nblocks, const aes128leaktimectx *ctx);

void aes128_ctr_leaktime(unsigned char *out, size_t outlen, const unsigned char *iv, const aes128leaktimectx *ctx);

void aes128_ctx_release_leaktime(aes128leaktimectx *r);

/** Initializes the context **/
void aes192_ecb_keyexp_leaktime(aes192leaktimectx *r, const unsigned char *key);

void aes192_ctr_keyexp_leaktime(aes192leaktimectx *r, const unsigned char *key);

void aes192_ecb_leaktime(unsigned char *out, const unsigned char *in, size_t nblocks, const aes192leaktimectx *ctx);

void aes192_ctr_leaktime(unsigned char *out, size_t outlen, const unsigned char *iv, const aes192leaktimectx *ctx);

void aes192_ctx_release_leaktime(aes192leaktimectx *r);


/** Initializes the context **/
void aes256_ecb_keyexp_leaktime(aes256leaktimectx *r, const unsigned char *key);

void aes256_ctr_keyexp_leaktime(aes256leaktimectx *r, const unsigned char *key);

void aes256_ecb_leaktime(unsigned char *out, const unsigned char *in, size_t nblocks, const aes256leaktimectx *ctx);

void aes256_ctr_leaktime(unsigned char *out, size_t outlen, const unsigned char *iv, const aes256leaktimectx *ctx);

void aes256_ctx_release_leaktime(aes256leaktimectx *r);


#endif
