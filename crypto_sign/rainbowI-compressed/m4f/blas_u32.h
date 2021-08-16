/// @file blas_u32.h
/// @brief Inlined functions for implementing basic linear algebra functions for uint32 arch.
///

#ifndef _BLAS_U32_H_
#define _BLAS_U32_H_

#include "gf16.h"
#include "rainbow_asm.h"

#include <stdint.h>

static inline void _gf256v_add_u32(uint8_t *accu_b, const uint8_t *a, unsigned _num_byte) {
    for (unsigned i = 0; i < _num_byte; i++) accu_b[i] ^= a[i];
}

static inline void _gf256v_predicated_add_u32(uint8_t *accu_b, uint8_t predicate, const uint8_t *a, unsigned _num_byte) {
    uint32_t pr_u32 = ((uint32_t) 0) - ((uint32_t) predicate);
    uint8_t pr_u8 = pr_u32 & 0xff;

    unsigned n_u32 = _num_byte >> 2;
    uint32_t *b_u32 = (uint32_t *) accu_b;
    const uint32_t *a_u32 = (const uint32_t *) a;
    for (unsigned i = 0; i < n_u32; i++) b_u32[i] ^= (a_u32[i] & pr_u32);

    a += (n_u32 << 2);
    accu_b += (n_u32 << 2);
    unsigned rem = _num_byte & 3;
    for (unsigned i = 0; i < rem; i++) accu_b[i] ^= (a[i] & pr_u8);
}

/////////////////////////////////////

static inline void gf16v_madd_u32_normal_bitsliced(uint8_t *accu_c, const uint8_t *a, uint8_t gf16_b, unsigned _num_byte) {
    gf16v_madd_u32_x4_normal_bitsliced_asm((uint32_t *)accu_c, (uint32_t *)a, gf16_b, _num_byte>>4);
}

///////////////////////////////////////

#endif // _BLAS_U32_H_

