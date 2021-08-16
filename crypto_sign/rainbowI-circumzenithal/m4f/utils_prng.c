/// @file utils_prng.c
/// @brief The implementation of PRNG related functions.
///

#include "utils_prng.h"
#include "aes.h"
#include "randombytes.h"
#include "utils_hash.h"
#include <stdlib.h>
#include <string.h>

#if USE_HARDWARE_CRYPTO == 1
#include "hal-aes.h"
#endif

static void prng_update(const unsigned char *provided_data,
                        unsigned char *Key,
                        unsigned char *V) {
    unsigned char temp[48];
    #if USE_HARDWARE_CRYPTO == 0
    aes256ctx ctx;
    aes256_ecb_keyexp(&ctx, Key);

    // fixsliced AES processes two blocks in parallel
    // by using a separate buffer we need only 2/3 of the time

    unsigned char Vtmp[48];
    for (int i = 0; i < 3; i++) {
        //increment V
        for (int j = 15; j >= 0; j--) {
            if (V[j] == 0xff) {
                V[j] = 0x00;
            } else {
                V[j]++;
                break;
            }
        }
        memcpy(Vtmp + AES_BLOCKBYTES * i, V, AES_BLOCKBYTES);
    }
    aes256_ecb(temp, Vtmp, 3, &ctx);
    #else

    //increment V once because this is a weird ctr which starts at 1
    for (int j = 15; j >= 0; j--) {
        if (V[j] == 0xff) {
            V[j] = 0x00;
        } else {
            V[j]++;
            break;
        }
    }

    hal_aes256_ctr(temp, 48, V, Key);
    #endif
    if (provided_data != NULL) {
        for (int i = 0; i < 48; i++) {
            temp[i] ^= provided_data[i];
        }
    }
    #if USE_HARDWARE_CRYPTO == 0
    aes256_ctx_release(&ctx);
    #endif
    memcpy(Key, temp, 32);
    memcpy(V, temp + 32, 16);
}
static void randombytes_init_with_state(prng_t *state,
                                        unsigned char *entropy_input_48bytes) {
    memset(state->Key, 0x00, 32);
    memset(state->V, 0x00, 16);
    prng_update(entropy_input_48bytes, state->Key, state->V);
}

static int randombytes_with_state(prng_t *state,
                                  unsigned char *x,
                                  size_t xlen) {
    #if USE_HARDWARE_CRYPTO == 0
    int i = 0;
    unsigned char block[32];
    unsigned char Vtmp[32];

    aes256ctx ctx;
    aes256_ecb_keyexp(&ctx, state->Key);

    while (xlen > 0) {
        // fixsliced AES processes two blocks in parallel
        // hence, this gives a 2x speed-up
        if(xlen > AES_BLOCKBYTES){
            for(int k=0; k<2;k++){
                //increment V
                for (int j = 15; j >= 0; j--) {
                    if (state->V[j] == 0xff) {
                        state->V[j] = 0x00;
                    } else {
                        state->V[j]++;
                        break;
                    }
                }
                memcpy(Vtmp+k*AES_BLOCKBYTES, state->V, AES_BLOCKBYTES);
            }
            aes256_ecb(block, Vtmp, 2, &ctx);
            if (xlen >= 32){
                memcpy(x + i, block, 32);
                i += 32;
                xlen -= 32;
            } else {
                memcpy(x + i, block, xlen);
                xlen = 0;
            }
        } else {
            //increment V
            for (int j = 15; j >= 0; j--) {
                if (state->V[j] == 0xff) {
                    state->V[j] = 0x00;
                } else {
                    state->V[j]++;
                    break;
                }
            }
            aes256_ecb(block, state->V, 1, &ctx);
            if (xlen > 15) {
                memcpy(x + i, block, 16);
                i += 16;
                xlen -= 16;
            } else {
                memcpy(x + i, block, xlen);
                xlen = 0;
            }
        }
    }
    aes256_ctx_release(&ctx);
    prng_update(NULL, state->Key, state->V);
    #else
    //increment V once because this is a weird ctr which starts at 1
    for (int j = 15; j >= 0; j--) {
        if (state->V[j] == 0xff) {
            state->V[j] = 0x00;
        } else {
            state->V[j]++;
            break;
        }
    }
    // need an additional buffer to get away with a single call to hal_aes256_ctr
    uint8_t tmp[xlen + 48 + 15];

    int off = 0;
    if(xlen % 16 != 0){
        off = 16 - (xlen%16);
    }

    hal_aes256_ctr(tmp, xlen+off+48, state->V, state->Key);

    memcpy(x, tmp, xlen);
    memcpy(state->Key, tmp+xlen+off, 32);
    memcpy(state->V, tmp+xlen+off+32, 16);
    #endif
    return 0;
}

int prng_set(prng_t *ctx, const void *prng_seed, unsigned long prng_seedlen) {
    unsigned char seed[48];
    if (prng_seedlen >= 48) {
        memcpy(seed, prng_seed, 48);
    } else {
        memcpy(seed, prng_seed, prng_seedlen);
        hash_msg(seed + prng_seedlen, 48 - (unsigned)prng_seedlen, (const unsigned char *)prng_seed, prng_seedlen);
    }

    randombytes_init_with_state(ctx, seed);

    return 0;
}

int prng_gen(prng_t *ctx, unsigned char *out, unsigned long outlen) {
    return randombytes_with_state(ctx, out, outlen);
}
