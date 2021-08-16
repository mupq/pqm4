/// @file blas_comm.c
/// @brief The standard implementations for blas_comm.h
///

#include "blas_comm.h"
#include "blas.h"

#include <assert.h>  // FIXME(js): don't use assert() and don't deal with NDEBUG
#include <stdint.h>
#include <string.h>

/// This implementation depends on these vector functions :
///   0.  gf16v_mul_scalar
///       gf16v_madd
///       gf256v_add
///       gf256v_mul_scalar
///       gf256v_madd
///
///   1.  gf256v_predicated_add     for _gf(16/256)mat_gauss_elim()
///   2.  gf16v_dot                 for gf16v_rowmat_prod()
///   3.  gf(16/256)mat_gauss_elim  for _gf(16/256)mat_solve_linear_eq()
///  these functions have to be defined in blas.h

/////////////////////////////////////

void gf256v_set_zero(uint8_t *b, unsigned _num_byte) {
    gf256v_add(b, b, _num_byte);
}

unsigned gf256v_is_zero(const uint8_t *a, unsigned _num_byte) {
    uint8_t r = 0;
    while( _num_byte-- ) { r |= a[0]; a++; }
    return (0 == r);
}

static inline void gf16mat_submat(uint8_t *mat2, unsigned w2, unsigned st, const uint8_t *mat, unsigned w, unsigned h) {
    unsigned n_byte_w1 = (w + 1) / 2;
    unsigned n_byte_w2 = (w2 + 1) / 2;
    unsigned st_2 = st / 2;
    for (unsigned i = 0; i < h; i++) {
        for (unsigned j = 0; j < n_byte_w2; j++) mat2[i * n_byte_w2 + j] = mat[i * n_byte_w1 + st_2 + j];
    }
}
