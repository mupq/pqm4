#include "pack_unpack.h"
#include <stddef.h>



////////////////////////////////////////////////////////////////////////////////////////////////
///                                 Polynomial to bit-string                                 ///
////////////////////////////////////////////////////////////////////////////////////////////////


/* This function reduces its input mod 2 */
void POLmsg2BS(uint8_t bytes[SABER_KEYBYTES], const uint16_t data[SABER_N])
{
    size_t i, j;
    uint8_t byte;
    for (j = 0; j < SABER_KEYBYTES; j++) {
        byte = 0;
        for (i = 0; i < 8; i++) {
            byte |= ((data[j * 8 + i] & 0x01) << i);
        }
        bytes[j] = byte;
    }
}

/* This function reduces its input mod p */
void POLp2BS(uint8_t bytes[SABER_POLYCOMPRESSEDBYTES], const uint16_t data[SABER_N])
{
    size_t i;
    const uint16_t *in = data;
    uint8_t *out = bytes;
    for (i = 0; i < SABER_N / 4; i++) {
        out[0] = (uint8_t) (in[0]);
        out[1] = (uint8_t) (((in[0] >> 8) & 0x03) | (in[1] << 2));
        out[2] = (uint8_t) (((in[1] >> 6) & 0x0f) | (in[2] << 4));
        out[3] = (uint8_t) (((in[2] >> 4) & 0x3f) | (in[3] << 6));
        out[4] = (uint8_t) (in[3] >> 2);
        in += 4;
        out += 5;
    }
}

/* This function reduces its input mod p */
uint32_t POLp2BS_cmp(const uint8_t bytes[SABER_POLYCOMPRESSEDBYTES], const uint16_t data[SABER_N])
{
    size_t j;
    const uint16_t *in = data;
    const uint8_t *out = bytes;
    uint32_t fail = 0;

    for (j = 0; j < SABER_N / 4; j++) {
        fail |= out[0] ^ (uint8_t) (in[0]);
        fail |= out[1] ^ (uint8_t) (((in[0] >> 8) & 0x03) | (in[1] << 2));
        fail |= out[2] ^ (uint8_t) (((in[1] >> 6) & 0x0f) | (in[2] << 4));
        fail |= out[3] ^ (uint8_t) (((in[2] >> 4) & 0x3f) | (in[3] << 6));
        fail |= out[4] ^ (uint8_t) (in[3] >> 2);
        in += 4;
        out += 5;
    }
    return fail;
}

/* This function reduces its input mod q */
void POLq2BS(uint8_t bytes[SABER_POLYBYTES], const uint16_t data[SABER_N])
{
    size_t i;
    const uint16_t *in = data;
    uint8_t *out = bytes;
    for (i = 0; i < SABER_N / 8; i++) {
        out[0] = (uint8_t) (in[0]);
        out[1] = (uint8_t) (((in[0] >> 8) & 0x1f) | (in[1] << 5));
        out[2] = (uint8_t) (in[1] >> 3);
        out[3] = (uint8_t) (((in[1] >> 11) & 0x03) | (in[2] << 2));
        out[4] = (uint8_t) (((in[2] >> 6) & 0x7f) | (in[3] << 7));
        out[5] = (uint8_t) (in[3] >> 1);
        out[6] = (uint8_t) (((in[3] >> 9) & 0x0f) | (in[4] << 4));
        out[7] = (uint8_t) (in[4] >> 4);
        out[8] = (uint8_t) (((in[4] >> 12) & 0x01) | (in[5] << 1));
        out[9] = (uint8_t) (((in[5] >> 7) & 0x3f) | (in[6] << 6));
        out[10] = (uint8_t) (in[6] >> 2);
        out[11] = (uint8_t) (((in[6] >> 10) & 0x07) | (in[7] << 3));
        out[12] = (uint8_t) (in[7] >> 5);
        in += 8;
        out += 13;
    }
}


/* This function reduces its input mod T */
void POLT2BS(uint8_t bytes[SABER_SCALEBYTES_KEM], const uint16_t data[SABER_N])
{
    size_t j;
    const uint16_t *in = data;
    uint8_t *out = bytes;
#if SABER_ET == 3 // LightSaber
    for (j = 0; j < SABER_N / 8; j++) {
        out[0] = (uint8_t) ((in[0] & 0x7) | ((in[1] & 0x7) << 3) | (in[2] << 6));
        out[1] = (uint8_t) (((in[2] >> 2) & 0x01) | ((in[3] & 0x7) << 1) | ((in[4] & 0x7) << 4) | (in[5] << 7));
        out[2] = (uint8_t) (((in[5] >> 1) & 0x03) | ((in[6] & 0x7) << 2) | (in[7] << 5));
        in += 8;
        out += 3;
    }
#elif SABER_ET == 4 // Saber
    for (j = 0; j < SABER_N / 2; j++) {
        out[0] = (uint8_t) ((in[0] & 0x0f) | (in[1] << 4));
        in += 2;
        out += 1;
    }
#elif SABER_ET == 6 // FireSaber
    for (j = 0; j < SABER_N / 4; j++) {
        out[0] = (uint8_t) ((in[0] & 0x3f) | (in[1] << 6));
        out[1] = (uint8_t) (((in[1] >> 2) & 0x0f) | (in[2] << 4));
        out[2] = (uint8_t) (((in[2] >> 4) & 0x03) | (in[3] << 2));
        in += 4;
        out += 3;
    }
#else
#error "Unsupported SABER parameter."
#endif
}

/* This function reduces its input mod T */
uint32_t POLT2BS_cmp(const uint8_t bytes[SABER_SCALEBYTES_KEM], const uint16_t data[SABER_N])
{
    size_t j;
    const uint16_t *in = data;
    const uint8_t *out = bytes;
    uint32_t fail = 0;
#if SABER_ET == 3 // LightSaber
    for (j = 0; j < SABER_N / 8; j++) {
        fail |= out[0] ^ (uint8_t) ((in[0] & 0x7) | ((in[1] & 0x7) << 3) | (in[2] << 6));
        fail |= out[1] ^ (uint8_t) (((in[2] >> 2) & 0x01) | ((in[3] & 0x7) << 1) | ((in[4] & 0x7) << 4) | (in[5] << 7));
        fail |= out[2] ^ (uint8_t) (((in[5] >> 1) & 0x03) | ((in[6] & 0x7) << 2) | (in[7] << 5));
        in += 8;
        out += 3;
    }
#elif SABER_ET == 4 // Saber
    for (j = 0; j < SABER_N / 2; j++) {
        fail |= out[0] ^ (uint8_t) ((in[0] & 0x0f) | (in[1] << 4));
        in += 2;
        out += 1;
    }
#elif SABER_ET == 6 // FireSaber
    for (j = 0; j < SABER_N / 4; j++) {
        fail |= out[0] ^ (uint8_t) ((in[0] & 0x3f) | (in[1] << 6));
        fail |= out[1] ^ (uint8_t) (((in[1] >> 2) & 0x0f) | (in[2] << 4));
        fail |= out[2] ^ (uint8_t) (((in[2] >> 4) & 0x03) | (in[3] << 2));
        in += 4;
        out += 3;
    }
#else
#error "Unsupported SABER parameter."
#endif
    return fail;
}




////////////////////////////////////////////////////////////////////////////////////////////////
///                             Polynomial vector to bit-string                              ///
////////////////////////////////////////////////////////////////////////////////////////////////


void POLVECp2BS(uint8_t bytes[SABER_POLYVECCOMPRESSEDBYTES], const uint16_t data[SABER_L][SABER_N])
{
    size_t i;

    for (i = 0; i < SABER_L; i++) {
        /* This function reduces its input mod p */
        POLp2BS(&bytes[i * SABER_POLYCOMPRESSEDBYTES], data[i]);
    }
}

uint32_t POLVECp2BS_cmp(const uint8_t bytes[SABER_POLYVECCOMPRESSEDBYTES], const uint16_t data[SABER_L][SABER_N])
{
    size_t i;
    uint32_t fail = 0;

    for (i = 0; i < SABER_L; i++) {
        /* This function reduces its input mod p */
        fail |= POLp2BS_cmp(&bytes[i * SABER_POLYCOMPRESSEDBYTES], data[i]);
    }

    return fail;
}


void POLVECq2BS(uint8_t bytes[SABER_POLYVECBYTES], const uint16_t data[SABER_L][SABER_N])
{
    size_t i;

    for (i = 0; i < SABER_L; i++) {
        /* This function reduces its input mod q */
        POLq2BS(&bytes[i * SABER_POLYBYTES], data[i]);
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////
///                             Bit-string to polynomial vector                              ///
////////////////////////////////////////////////////////////////////////////////////////////////

void BS2POLVECp(const uint8_t bytes[SABER_POLYVECCOMPRESSEDBYTES], uint16_t data[SABER_L][SABER_N])
{
    size_t i;
    for (i = 0; i < SABER_L; i++) {
        /* This function sign-extends its output from p-bit to 16-bit */
        BS2POLp(bytes + i * (SABER_EP * SABER_N / 8), data[i]);
    }
}

void BS2POLVECq(const uint8_t bytes[SABER_POLYVECBYTES], uint16_t data[SABER_L][SABER_N])
{
    size_t i;
    for (i = 0; i < SABER_L; i++) {
        /* This function sign-extends its output from q-bit to 16-bit */
        BS2POLq(&bytes[i * SABER_POLYBYTES], data[i]);
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// The following functions are for compressed secret. Secrets are stored with their 4-bit value in [-SABER_MU/2, SABER_MU/2]. ///
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* This function reduces its input mod 2**4 */
void POLmu2BS(uint8_t bytes[SABER_N / 2], const uint16_t data[SABER_N])
{
    size_t j;
    const uint16_t *in = data;
    uint8_t *out = bytes;
    for (j = 0; j < SABER_N / 2; j++) {
        out[0] = (uint8_t) ((in[0] & 0x0f) | (in[1] << 4));
        in += 2;
        out += 1;
    }
}

// #ifdef SABER_COMPRESS_SECRETKEY


// void POLVECmu2BS(uint8_t bytes[SABER_INDCPA_SECRETKEYBYTES], const uint16_t data[SABER_L][SABER_N])
// {
//     size_t i;
//     for (i = 0; i < SABER_L; i++) {
//         POLmu2BS(bytes + i * SABER_POLYSECRETBYTES, data[i]);
//     }
// }

// void BS2POLVECmu(const uint8_t bytes[SABER_INDCPA_SECRETKEYBYTES], uint16_t data[SABER_L][SABER_N])
// {
//     size_t i;
//     for (i = 0; i < SABER_L; i++) {
//         /* This function sign-extends its output from 4-bit to 16-bit */
//         BS2POLmu(bytes + i * SABER_POLYSECRETBYTES, data[i]);
//     }
// }

// #endif
