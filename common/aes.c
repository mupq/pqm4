#include <stdint.h>
#include <string.h>
#include "aes.h"

#ifdef PROFILE_HASHING
#include "hal.h"
extern unsigned long long hash_cycles;
#endif

extern void aes128_keyschedule_ffs(uint32_t* rkeys, const uint8_t* key);
extern void aes256_keyschedule_ffs(uint32_t* rkeys, const uint8_t* key);

extern void aes256_encrypt_ffs(uint8_t* ctext, uint8_t* ctext_bis, const uint8_t* ptext,
                   const uint8_t* ptext_bis, const uint32_t* rkey);

extern void aes128_encrypt_ffs(uint8_t* ctext, uint8_t* ctext_bis, const uint8_t* ptext,
                   const uint8_t* ptext_bis, const uint32_t* rkey);


static inline uint32_t br_swap32(uint32_t x) {
    x = ((x & (uint32_t)0x00FF00FF) << 8)
        | ((x >> 8) & (uint32_t)0x00FF00FF);
    return (x << 16) | (x >> 16);
}

static inline void inc1_be(uint32_t *x) {
    uint32_t t = br_swap32(*x) + 1;
    *x = br_swap32(t);
}

static inline void inc2_be(uint32_t *x) {
    uint32_t t = br_swap32(*x) + 2;
    *x = br_swap32(t);
}

void aes128_ecb_keyexp(aes128ctx *r, const unsigned char *key){
    #ifdef PROFILE_HASHING
    uint64_t t0 = hal_get_time();
    #endif

    aes128_keyschedule_ffs(r->sk_exp, key);

    #ifdef PROFILE_HASHING
    uint64_t t1 = hal_get_time();
    hash_cycles += (t1-t0);
    #endif
}

void aes128_ecb(unsigned char *out, const unsigned char *in, size_t nblocks,
                const aes128ctx *ctx){
    #ifdef PROFILE_HASHING
    uint64_t t0 = hal_get_time();
    #endif
    uint8_t buf0[AES_BLOCKBYTES], buf1[AES_BLOCKBYTES];

    while(nblocks > 0){
        if(nblocks >= 2){
            aes128_encrypt_ffs(out, out+AES_BLOCKBYTES, in, in+AES_BLOCKBYTES, ctx->sk_exp);
            out += AES_BLOCKBYTES*2;
            in += AES_BLOCKBYTES*2;
            nblocks -= 2;
        } else {
            aes128_encrypt_ffs(out, buf0, in, buf1, ctx->sk_exp);
            nblocks--;
        }
    }

    #ifdef PROFILE_HASHING
    uint64_t t1 = hal_get_time();
    hash_cycles += (t1-t0);
    #endif
}

void aes128_ctr_keyexp(aes128ctx *r, const unsigned char *key){
    #ifdef PROFILE_HASHING
    uint64_t t0 = hal_get_time();
    #endif

    aes128_keyschedule_ffs(r->sk_exp, key);

    #ifdef PROFILE_HASHING
    uint64_t t1 = hal_get_time();
    hash_cycles += (t1-t0);
    #endif
}


void aes128_ctr(unsigned char *out, size_t outlen, const unsigned char *iv,
                const aes128ctx *ctx){
    #ifdef PROFILE_HASHING
    uint64_t t0 = hal_get_time();
    #endif
    uint32_t ivw1[4] = {0};
    uint32_t ivw2[4] = {0};
    uint8_t buf1[AES_BLOCKBYTES];
    uint8_t buf2[AES_BLOCKBYTES];
    size_t i;

    memcpy(ivw1, iv, AESCTR_NONCEBYTES);
    memcpy(ivw2, iv, AESCTR_NONCEBYTES);
    inc1_be(ivw2 + 3);


    while (outlen > 2*AES_BLOCKBYTES) {
        aes128_encrypt_ffs(out, out+16, (uint8_t *)ivw1, (uint8_t *)ivw2, ctx->sk_exp);
        inc2_be(ivw1 + 3);
        inc2_be(ivw2 + 3);
        out += AES_BLOCKBYTES*2;
        outlen -= AES_BLOCKBYTES*2;
    }
    if (outlen >= AES_BLOCKBYTES) {

        aes128_encrypt_ffs(out, buf2, (uint8_t *)ivw1, (uint8_t *)ivw2, ctx->sk_exp);
        out += AES_BLOCKBYTES;
        outlen -= AES_BLOCKBYTES;
        for (i = 0; i < outlen; i++) {
            out[i] = buf2[i];
        }
    } else if (outlen > 0) {
        aes128_encrypt_ffs(buf1, buf2, (uint8_t *)ivw1, (uint8_t *)ivw2, ctx->sk_exp);
        for (i = 0; i < outlen; i++) {
            out[i] = buf1[i];
        }
    }

    #ifdef PROFILE_HASHING
    uint64_t t1 = hal_get_time();
    hash_cycles += (t1-t0);
    #endif
}
void aes128_ctx_release(aes128ctx *r){
    (void) r;
}


void aes256_ecb_keyexp(aes256ctx *r, const unsigned char *key){
    #ifdef PROFILE_HASHING
    uint64_t t0 = hal_get_time();
    #endif

    aes256_keyschedule_ffs(r->sk_exp, key);

    #ifdef PROFILE_HASHING
    uint64_t t1 = hal_get_time();
    hash_cycles += (t1-t0);
    #endif
}

void aes256_ecb(unsigned char *out, const unsigned char *in, size_t nblocks, const aes256ctx *ctx){
    #ifdef PROFILE_HASHING
    uint64_t t0 = hal_get_time();
    #endif

    uint8_t buf0[AES_BLOCKBYTES], buf1[AES_BLOCKBYTES];

    while(nblocks > 0){
        if(nblocks >= 2){
            aes256_encrypt_ffs(out, out+AES_BLOCKBYTES, in, in+AES_BLOCKBYTES, ctx->sk_exp);
            out += 2*AES_BLOCKBYTES;
            in += 2*AES_BLOCKBYTES;
            nblocks -= 2;
        } else {
            aes256_encrypt_ffs(out, buf0, in, buf1, ctx->sk_exp);
            nblocks--;
        }
    }

    #ifdef PROFILE_HASHING
    uint64_t t1 = hal_get_time();
    hash_cycles += (t1-t0);
    #endif
}
char str[100];
void aes256_ctr_keyexp(aes256ctx *r, const unsigned char *key){
    #ifdef PROFILE_HASHING
    uint64_t t0 = hal_get_time();
    #endif
    aes256_keyschedule_ffs(r->sk_exp, key);

    #ifdef PROFILE_HASHING
    uint64_t t1 = hal_get_time();
    hash_cycles += (t1-t0);
    #endif
}

void aes256_ctr(unsigned char *out, size_t outlen, const unsigned char *iv,
                const aes256ctx *ctx){
    #ifdef PROFILE_HASHING
    uint64_t t0 = hal_get_time();
    #endif
    uint32_t ivw1[4] = {0};
    uint32_t ivw2[4] = {0};
    uint8_t buf1[AES_BLOCKBYTES];
    uint8_t buf2[AES_BLOCKBYTES];
    size_t i;

    memcpy(ivw1, iv, AESCTR_NONCEBYTES);
    memcpy(ivw2, iv, AESCTR_NONCEBYTES);
    inc1_be(ivw2 + 3);


    while (outlen > 2*AES_BLOCKBYTES) {
        aes256_encrypt_ffs(out, out+AES_BLOCKBYTES, (uint8_t *)ivw1, (uint8_t *)ivw2, ctx->sk_exp);
        inc2_be(ivw1 + 3);
        inc2_be(ivw2 + 3);
        out += AES_BLOCKBYTES*2;
        outlen -= AES_BLOCKBYTES*2;
    }
    if (outlen >= AES_BLOCKBYTES) {

        aes256_encrypt_ffs(out, buf2, (uint8_t *)ivw1, (uint8_t *)ivw2, ctx->sk_exp);
        out += AES_BLOCKBYTES;
        outlen -= AES_BLOCKBYTES;
        for (i = 0; i < outlen; i++) {
            out[i] = buf2[i];
        }
    } else if (outlen > 0) {
        aes256_encrypt_ffs(buf1, buf2, (uint8_t *)ivw1, (uint8_t *)ivw2, ctx->sk_exp);
        for (i = 0; i < outlen; i++) {
            out[i] = buf1[i];
        }
    }
    #ifdef PROFILE_HASHING
    uint64_t t1 = hal_get_time();
    hash_cycles += (t1-t0);
    #endif
}

void aes256_ctx_release(aes256ctx *r){
    (void) r;
}