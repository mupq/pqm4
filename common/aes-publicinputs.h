#ifndef AES_PUBLICINPUTS_H
#define AES_PUBLICINPUTS_H

#include <stdint.h>
#include <stdlib.h>

#define AES128_KEYBYTES 16
#define AES192_KEYBYTES 24
#define AES256_KEYBYTES 32
#define AESCTR_NONCEBYTES 12
#define AES_BLOCKBYTES 16

typedef struct {
    uint64_t sk_exp[88];
} aes128ctx_publicinputs;

typedef struct {
    uint64_t sk_exp[104];
} aes192ctx_publicinputs;

typedef struct {
    uint64_t sk_exp[120];
} aes256ctx_publicinputs;



/** Initializes the context **/
void aes128_ecb_keyexp_publicinputs(aes128ctx_publicinputs *r, const unsigned char *key);

void aes128_ctr_keyexp_publicinputs(aes128ctx_publicinputs *r, const unsigned char *key);

void aes128_ecb_publicinputs(unsigned char *out, const unsigned char *in, size_t nblocks, const aes128ctx_publicinputs *ctx);

void aes128_ctr_publicinputs(unsigned char *out, size_t outlen, const unsigned char *iv, const aes128ctx_publicinputs *ctx);

void aes128_ctx_release_publicinputs(aes128ctx_publicinputs *r);

/** Initializes the context **/
void aes192_ecb_keyexp_publicinputs(aes192ctx_publicinputs *r, const unsigned char *key);

void aes192_ctr_keyexp_publicinputs(aes192ctx_publicinputs *r, const unsigned char *key);

void aes192_ecb_publicinputs(unsigned char *out, const unsigned char *in, size_t nblocks, const aes192ctx_publicinputs *ctx);

void aes192_ctr_publicinputs(unsigned char *out, size_t outlen, const unsigned char *iv, const aes192ctx_publicinputs *ctx);

void aes192_ctx_release_publicinputs(aes192ctx_publicinputs *r);


/** Initializes the context **/
void aes256_ecb_keyexp_publicinputs(aes256ctx_publicinputs *r, const unsigned char *key);

void aes256_ctr_keyexp_publicinputs(aes256ctx_publicinputs *r, const unsigned char *key);

void aes256_ecb_publicinputs(unsigned char *out, const unsigned char *in, size_t nblocks, const aes256ctx_publicinputs *ctx);

void aes256_ctr_publicinputs(unsigned char *out, size_t outlen, const unsigned char *iv, const aes256ctx_publicinputs *ctx);

void aes256_ctx_release_publicinputs(aes256ctx_publicinputs *r);


#endif
