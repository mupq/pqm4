//  xecc.c
//  2018-06-15  Markku-Juhani O. Saarinen <mjos@iki.fi>

//  Error Correction Codes

#include "api.h"
#include "xecc.h"

#define ROTR32_REGN(r, n) { r = (r >> (32 % n)) | (r << (n - (32 % n))); }
#define FOLD_MASK(r, x, n) { r = (r ^ x ^ (x >> n)) & ((1 << n) - 1); }
#define FOLD2_MASK(r, x, n) \
    { r = (r ^ x ^ (x >> n) ^ (x >> (2 * n))) & ((1 << n) - 1); }

#define MASK_UNFOLD(r, n) { r &= ((1 << n) - 1); r ^= r << n; }
#define MASK_UNFOLD2(r, n) { r &= ((1 << n) - 1); \
    r ^= (r << n) ^ (r << (2 * n)); }
#define ROTL32_REGN(r, n) { r = (r << (32 % n)) | (r >> (n - (32 % n))); }

#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#define ENDIAN32(x) (x)
#else
#define ENDIAN32(x) ((((x) & 0xFF000000) >> 24u) |  \
                     (((x) & 0x00FF0000) >> 8u)  |  \
                     (((x) & 0x0000FF00) << 8u)  |  \
                     (((x) & 0x000000FF) << 24u))
#endif

// == Error Correction Code XE3-91 =======================================

#if ((PARAMS_SS_SIZE == 16) && (PARAMS_XE_SIZE == 12))

void xe_compute(void *block)
{
    int i;
    uint32_t x;
    uint32_t r11, r13, r15, r16, r17, r19;
    uint32_t *v = (uint32_t *) block;

    r11 = r13 = r15 = r16 = r17 = r19 = 0;

    for (i = 3; i >= 0; i--) {          // six word payload

        if (i < 3) {
            ROTR32_REGN(r11, 11);
            ROTR32_REGN(r13, 13);
            ROTR32_REGN(r15, 15);
            ROTR32_REGN(r17, 17);
            ROTR32_REGN(r19, 19);
        }

        x = ENDIAN32(v[i]);             // load a word
        FOLD2_MASK(r11, x, 11);
        FOLD2_MASK(r13, x, 13);
        FOLD2_MASK(r15, x, 15);
        r16 ^= x;
        FOLD_MASK(r17, x, 17);
        FOLD_MASK(r19, x, 19);
    }
    r16 = (r16 ^ (r16 >> 16)) & 0xFFFF;

    // Codeword:    r13 r19 r15 r17 r16 r11
    // Bit offset:  0   13  32  47  64  80  91
    x = r13 ^ (r19 << 13);
    v[ 4] ^= ENDIAN32(x);
    x = r15 ^ (r17 << 15);
    v[ 5] ^= ENDIAN32(x);
    x = r16 ^ (r11 << 16);
    v[ 6] ^= ENDIAN32(x);
}

void xe_fixerr(void *block)
{
    int i, j;
    uint32_t x;
    uint32_t r11, r13, r15, r16, r17, r19;
    uint32_t *v = (uint32_t *) block;

    xe_compute(block);

    // Codeword:    r13 r19 r15 r17 r16 r11
    // Bit offset:  0   13  32  47  64  80  91
    r13 = ENDIAN32(v[4]);
    r19 = r13 >> 13;
    r15 = ENDIAN32(v[5]);
    r17 = r15 >> 15;
    r16 = ENDIAN32(v[6]);
    r11 = r16 >> 16;

    MASK_UNFOLD2(r11, 11);
    MASK_UNFOLD2(r13, 13);
    MASK_UNFOLD2(r15, 15);
    MASK_UNFOLD(r16, 16);
    MASK_UNFOLD(r17, 17);
    MASK_UNFOLD(r19, 19);

    for (i = 0; i < 4; i++) {
        x = ENDIAN32(v[i]);
        for (j = 0; j < 4; j++) {
            x ^= ((0x44444444 + (((r13 >> j) & 0x11111111) +
                ((r15 >> j) & 0x11111111) + ((r16 >> j) & 0x11111111) +
                ((r17 >> j) & 0x11111111) + ((r19 >> j) & 0x11111111) +
                ((r11 >> j) & 0x11111111))) & 0x88888888) >> (3 - j);
        }
        v[i] = ENDIAN32(x);

        if (i < 3) {
            ROTL32_REGN(r11, 11);
            ROTL32_REGN(r13, 13);
            ROTL32_REGN(r15, 15);
            ROTL32_REGN(r17, 17);
            ROTL32_REGN(r19, 19);
        }
    }
}

#endif

// == Error Correction Code XE3-103 =======================================

#if ((PARAMS_SS_SIZE == 24) && (PARAMS_XE_SIZE == 13))

void xe_compute(void *block)
{
    int i;
    uint32_t x;
    uint32_t r13, r15, r16, r17, r19, r23;
    uint32_t *v = (uint32_t *) block;

    r13 = r15 = r16 = r17 = r19 = r23 = 0;

    for (i = 5; i >= 0; i--) {          // six word payload

        if (i < 5) {
            ROTR32_REGN(r13, 13);
            ROTR32_REGN(r15, 15);
            ROTR32_REGN(r17, 17);
            ROTR32_REGN(r19, 19);
            ROTR32_REGN(r23, 23);
        }

        x = ENDIAN32(v[i]);             // load a word
        FOLD2_MASK(r13, x, 13);
        FOLD2_MASK(r15, x, 15);
        r16 ^= x;
        FOLD_MASK(r17, x, 17);
        FOLD_MASK(r19, x, 19);
        FOLD_MASK(r23, x, 23);
    }
    r16 = (r16 ^ (r16 >> 16)) & 0xFFFF;

    // Codeword:    r13 r19 r15 r17 r16 r23
    // Bit offset:  0   13  32  47  64  80  103
    x = r13 ^ (r19 << 13);
    v[ 6] ^= ENDIAN32(x);
    x = r15 ^ (r17 << 15);
    v[ 7] ^= ENDIAN32(x); 
    x = r16 ^ (r23 << 16);
    v[ 8] ^= ENDIAN32(x); 
    *((uint8_t *) &v[9]) ^= r23 >> 16;  //  7 bits
}

void xe_fixerr(void *block)
{
    int i, j;
    uint32_t x;
    uint32_t r13, r15, r16, r17, r19, r23;
    uint32_t *v = (uint32_t *) block;

    xe_compute(block);

    // Codeword:    r13 r19 r15 r17 r16 r23
    // Bit offset:  0   13  32  47  64  80  103
    r13 = ENDIAN32(v[6]);
    r19 = r13 >> 13;
    r15 = ENDIAN32(v[7]);
    r17 = r15 >> 15;
    r16 = ENDIAN32(v[8]);
    r23 = (r16 >> 16) ^ (((uint32_t) *((uint8_t *) &v[9])) << 16);

    MASK_UNFOLD2(r13, 13);
    MASK_UNFOLD2(r15, 15);
    MASK_UNFOLD(r16, 16);
    MASK_UNFOLD(r17, 17);
    MASK_UNFOLD(r19, 19);
    MASK_UNFOLD(r23, 23);

    for (i = 0; i < 6; i++) {
        x = ENDIAN32(v[i]);
        for (j = 0; j < 4; j++) {
            x ^= ((0x44444444 + (((r13 >> j) & 0x11111111) +
                ((r15 >> j) & 0x11111111) + ((r16 >> j) & 0x11111111) +
                ((r17 >> j) & 0x11111111) + ((r19 >> j) & 0x11111111) +
                ((r23 >> j) & 0x11111111))) & 0x88888888) >> (3 - j);
        }
        v[i] = ENDIAN32(x);

        if (i < 5) {
            ROTL32_REGN(r13, 13);
            ROTL32_REGN(r15, 15);
            ROTL32_REGN(r17, 17);
            ROTL32_REGN(r19, 19);
            ROTL32_REGN(r23, 23);
        }
    }
}

#endif

// == Error Correction Code XE3-121 =======================================

#if ((PARAMS_SS_SIZE == 32) && (PARAMS_XE_SIZE == 16))

void xe_compute(void *block)
{
    int i;
    uint32_t x;
    uint32_t r16, r17, r19, r21, r23, r25;
    uint32_t *v = (uint32_t *) block;

    r16 = r17 = r19 = r21 = r23 = r25 = 0;

    for (i = 7; i >= 0; i--) {          // six word payload

        if (i < 7) {
            ROTR32_REGN(r17, 17);
            ROTR32_REGN(r19, 19);
            ROTR32_REGN(r21, 21);
            ROTR32_REGN(r23, 23);
            ROTR32_REGN(r25, 25);
        }

        x = ENDIAN32(v[i]);             // load a word
        r16 ^= x;
        FOLD_MASK(r17, x, 17);
        FOLD_MASK(r19, x, 19);
        FOLD_MASK(r21, x, 21);
        FOLD_MASK(r23, x, 23);
        FOLD_MASK(r25, x, 25);
    }
    r16 = (r16 ^ (r16 >> 16)) & 0xFFFF;

    // Codeword:    r16 r17 r19 r21 r23 r25
    // Bit offset:  0   16  33  52  73  96  121
    x = r16 ^ (r17 << 16);
    v[ 8] ^= ENDIAN32(x);
    x = (r17 >> 16) ^ (r19 << 1) ^ (r21 << 20);
    v[ 9] ^= ENDIAN32(x);
    x = (r21 >> 12) ^ (r23 << 9);
    v[10] ^= ENDIAN32(x);
    v[11] ^= ENDIAN32(r25);
}

void xe_fixerr(void *block)
{
    int i, j;
    uint32_t x;
    uint32_t r16, r17, r19, r21, r23, r25;
    uint32_t *v = (uint32_t *) block;

    xe_compute(block);

    // Codeword:    r16 r17 r19 r21 r23 r25
    // Bit offset:  0   16  33  52  73  96  121
    r16 = ENDIAN32(v[8]);
    x   = ENDIAN32(v[9]);
    r17 = (r16 >> 16) ^ (x << 16);
    r19 = x >> 1;
    r23 = ENDIAN32(v[10]);
    r21 = (x >> 20) ^ (r23 << 12);
    r23 >>= 9;
    r25 = ENDIAN32(v[11]);

    MASK_UNFOLD(r16, 16);
    MASK_UNFOLD(r17, 17);
    MASK_UNFOLD(r19, 19);
    MASK_UNFOLD(r21, 21);
    MASK_UNFOLD(r23, 23);
    MASK_UNFOLD(r25, 25);

    for (i = 0; i < 8; i++) {
        x = ENDIAN32(v[i]);
        for (j = 0; j < 4; j++) {
            x ^= ((0x44444444 + (((r16 >> j) & 0x11111111) +
                ((r17 >> j) & 0x11111111) + ((r19 >> j) & 0x11111111) +
                ((r21 >> j) & 0x11111111) + ((r23 >> j) & 0x11111111) +
                ((r25 >> j) & 0x11111111))) & 0x88888888) >> (3 - j);
        }
        v[i] = ENDIAN32(x);

        if (i < 7) {
            ROTL32_REGN(r17, 17);
            ROTL32_REGN(r19, 19);
            ROTL32_REGN(r21, 21);
            ROTL32_REGN(r23, 23);
            ROTL32_REGN(r25, 25);
        }
    }
}

#endif


