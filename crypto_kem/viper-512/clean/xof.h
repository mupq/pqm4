#ifndef REF_XOF_H
#define REF_XOF_H

#include "structs.h"

void ref_xof_expand_matrix(poly_matrix *A, const uint8_t *seed);

// [Fix] 增加 modulus 参数，用于约束 d 的大小
void ref_xof_expand_poly_vec(poly_vec *v, const uint8_t *seed, int32_t modulus);
void ref_xof_expand_poly(poly *v, const uint8_t *seed, int32_t modulus);

#endif