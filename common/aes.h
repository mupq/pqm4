#ifndef AES_H
#define AES_H

#include <stdint.h>
#include <stdlib.h>

#define AES128_KEYBYTES 16
#define AES192_KEYBYTES 24
#define AES256_KEYBYTES 32
#define AESCTR_NONCEBYTES 12
#define AES_BLOCKBYTES 16

typedef struct {
    uint32_t sk_exp[2*11*AES_BLOCKBYTES/sizeof(uint32_t)];
} aes128ctx;


typedef struct {
    uint32_t sk_exp[2*15*AES_BLOCKBYTES/sizeof(uint32_t)];
} aes256ctx;



/** Initializes the context **/
void aes128_ecb_keyexp(aes128ctx *r, const unsigned char *key);

void aes128_ctr_keyexp(aes128ctx *r, const unsigned char *key);

void aes128_ecb(unsigned char *out, const unsigned char *in, size_t nblocks, const aes128ctx *ctx);

void aes128_ctr(unsigned char *out, size_t outlen, const unsigned char *iv, const aes128ctx *ctx);

void aes128_ctx_release(aes128ctx *r);


/** Initializes the context **/
void aes256_ecb_keyexp(aes256ctx *r, const unsigned char *key);

void aes256_ctr_keyexp(aes256ctx *r, const unsigned char *key);

void aes256_ecb(unsigned char *out, const unsigned char *in, size_t nblocks, const aes256ctx *ctx);

void aes256_ctr(unsigned char *out, size_t outlen, const unsigned char *iv, const aes256ctx *ctx);

void aes256_ctx_release(aes256ctx *r);


#endif
