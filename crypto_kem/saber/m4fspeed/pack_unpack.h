#ifndef PACK_UNPACK_H
#define PACK_UNPACK_H

#include "SABER_params.h"
#include <stdint.h>

extern void __asm_1_to_16(uint16_t*, const uint8_t*);
extern void __asm_3_to_16(uint16_t*, const uint8_t*);
extern void __asm_4_to_16(uint16_t*, const uint8_t*);
extern void __asm_6_to_16(uint16_t*, const uint8_t*);
extern void __asm_10_to_16(uint16_t*, const uint8_t*);
extern void __asm_13_to_16(uint16_t*, const uint8_t*);

void POLmsg2BS(uint8_t bytes[SABER_KEYBYTES], const uint16_t data[SABER_N]);
void POLp2BS(uint8_t bytes[SABER_POLYCOMPRESSEDBYTES], const uint16_t data[SABER_N]);
void POLq2BS(uint8_t bytes[SABER_POLYBYTES], const uint16_t data[SABER_N]);
void POLT2BS(uint8_t bytes[SABER_SCALEBYTES_KEM], const uint16_t data[SABER_N]);
uint32_t POLp2BS_cmp(const uint8_t bytes[SABER_POLYCOMPRESSEDBYTES], const uint16_t data[SABER_N]);
uint32_t POLT2BS_cmp(const uint8_t bytes[SABER_SCALEBYTES_KEM], const uint16_t data[SABER_N]);

void POLmu2BS(uint8_t bytes[SABER_N / 2], const uint16_t data[SABER_N]);

static inline void BS2POLmsg(const uint8_t bytes[SABER_KEYBYTES], uint16_t data[SABER_N]);
static inline void BS2POLp(const uint8_t bytes[SABER_POLYCOMPRESSEDBYTES], uint16_t data[SABER_N]);
static inline void BS2POLq(const uint8_t bytes[SABER_POLYBYTES], uint16_t data[SABER_N]);
static inline void BS2POLT(const uint8_t bytes[SABER_SCALEBYTES_KEM], uint16_t data[SABER_N]);
static inline void BS2POLmu(const uint8_t bytes[SABER_POLYSECRETBYTES], uint16_t data[SABER_N]);

void POLVECp2BS(uint8_t bytes[SABER_POLYVECCOMPRESSEDBYTES], const uint16_t data[SABER_L][SABER_N]);
void POLVECq2BS(uint8_t bytes[SABER_POLYVECBYTES], const uint16_t data[SABER_L][SABER_N]);
uint32_t POLVECp2BS_cmp(const uint8_t bytes[SABER_POLYVECCOMPRESSEDBYTES], const uint16_t data[SABER_L][SABER_N]);

void BS2POLVECq(const uint8_t bytes[SABER_POLYVECBYTES], uint16_t data[SABER_L][SABER_N]);
void BS2POLVECp(const uint8_t bytes[SABER_POLYVECCOMPRESSEDBYTES], uint16_t data[SABER_L][SABER_N]);

////////////////////////////////////////////////////////////////////////////////////////////////
///                                 Bit-string to polynomial                                 ///
////////////////////////////////////////////////////////////////////////////////////////////////

static inline void BS2POLmsg(const uint8_t bytes[SABER_KEYBYTES], uint16_t data[SABER_N]){
    __asm_1_to_16(data, bytes);
}

static inline void BS2POLp(const uint8_t bytes[SABER_POLYCOMPRESSEDBYTES], uint16_t data[SABER_N]){
    __asm_10_to_16(data, bytes);
}

static inline void BS2POLq(const uint8_t bytes[SABER_POLYBYTES], uint16_t data[SABER_N]){
    __asm_13_to_16(data, bytes);
}

/* This function does NOT reduce its output mod T */
static inline void BS2POLT(const uint8_t bytes[SABER_SCALEBYTES_KEM], uint16_t data[SABER_N]){
#if SABER_ET == 3 // LightSaber
    __asm_3_to_16(data, bytes);
#elif SABER_ET == 4 // Saber
    __asm_4_to_16(data, bytes);
#elif SABER_ET == 6 // FireSaber
    __asm_6_to_16(data, bytes);
#else
#error "Unsupported SABER parameter."
#endif
}

static inline void BS2POLmu(const uint8_t bytes[SABER_POLYSECRETBYTES], uint16_t data[SABER_N]){
    __asm_4_to_16(data, bytes);
}

#endif

