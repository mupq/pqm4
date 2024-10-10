// SPDX-License-Identifier: MIT

#ifndef FIELD_H
#define FIELD_H

#include "params.h"
#include <stddef.h>
#include <stdint.h>

typedef uint64_t GF[2];

#define poly64_mul AIMER_NAMESPACE(poly64_mul)
void poly64_mul(const uint64_t *a, const uint64_t *b, uint64_t *c1, uint64_t *c0);
#define GF_set0 AIMER_NAMESPACE(GF_set0)
void GF_set0(GF a);
#define GF_copy AIMER_NAMESPACE(GF_copy)
void GF_copy(GF out, const GF in);
#define GF_to_bytes AIMER_NAMESPACE(GF_to_bytes)
void GF_to_bytes(uint8_t *out, const GF in);
#define GF_from_bytes AIMER_NAMESPACE(GF_from_bytes)
void GF_from_bytes(GF out, const uint8_t *in);

#define GF_add AIMER_NAMESPACE(GF_add)
void GF_add(GF c, const GF a, const GF b);
#define GF_mul AIMER_NAMESPACE(GF_mul)
void GF_mul(GF c, const GF a, const GF b);
#define GF_mul_add AIMER_NAMESPACE(GF_mul_add)
void GF_mul_add(GF c, const GF a, const GF b);
#define GF_transposed_matmul AIMER_NAMESPACE(GF_transposed_matmul)
void GF_transposed_matmul(GF c, const GF a, const GF b[AIM2_NUM_BITS_FIELD]);
#define GF_transposed_matmul_add AIMER_NAMESPACE(GF_transposed_matmul_add)
void GF_transposed_matmul_add(GF c, const GF a, const GF b[AIM2_NUM_BITS_FIELD]);

#define GF_mul_s AIMER_NAMESPACE(GF_mul_s)
void GF_mul_s(GF c, const GF a, const GF b);
#define GF_mul_add_s AIMER_NAMESPACE(GF_mul_add_s)
void GF_mul_add_s(GF c, const GF a, const GF b);
#define GF_sqr_s AIMER_NAMESPACE(GF_sqr_s)
void GF_sqr_s(GF c, const GF a);

#endif // FIELD_H
