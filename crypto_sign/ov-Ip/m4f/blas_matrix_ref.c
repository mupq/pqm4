//// @file blas_matrix.c
/// @brief The standard implementations for blas_matrix.h
///

#include "blas_comm.h"
#include "blas.h"

#include "blas_matrix_ref.h"

#include <stdint.h>
#include <string.h>

/// This implementation depends on these vector functions :
///   0.  gf16v_mul_scalar
///       gf16v_madd
///       gf256v_add
///       gf256v_mul_scalar
///       gf256v_madd
///
///   1.  gf256v_conditional_add     for _gf(16/256)mat_gauss_elim()
///  these functions have to be defined in blas.h




///////////  matrix-vector  multiplications  ////////////////////////////////

void gf16mat_prod_ref(uint8_t *c, const uint8_t *matA, unsigned n_A_vec_byte, unsigned n_A_width, const uint8_t *b) {
    gf256v_set_zero(c, n_A_vec_byte);
    for (unsigned i = 0; i < n_A_width; i++) {
        uint8_t bb = gf16v_get_ele(b, i);
        gf16v_madd(c, matA, bb, n_A_vec_byte);
        matA += n_A_vec_byte;
    }
}

void gf256mat_prod_ref(uint8_t *c, const uint8_t *matA, unsigned n_A_vec_byte, unsigned n_A_width, const uint8_t *b) {
    gf256v_set_zero(c, n_A_vec_byte);
    for (unsigned i = 0; i < n_A_width; i++) {
        gf256v_madd(c, matA, b[i], n_A_vec_byte);
        matA += n_A_vec_byte;
    }
}










static inline
void gf256mat_submat( uint8_t * mat2 , unsigned veclen2_byte , unsigned st , const uint8_t * mat , unsigned veclen_byte , unsigned n_vec )
{
    for(unsigned i=0;i<n_vec;i++) {
        for(unsigned j=0;j<veclen2_byte;j++) mat2[i*veclen2_byte+j] = mat[i*veclen_byte+st+j];
    }
}


/////////////////////////  matrix-matrix multiplication  /////////////////////////////////////////



void gf16mat_rowmat_mul_ref(uint8_t *matC, const uint8_t *matA, unsigned height_A, unsigned width_A_byte, const uint8_t *matB, unsigned width_B_byte)
{
    gf256v_set_zero( matC , height_A*width_B_byte );
    for( unsigned i=0; i<height_A; i++) {
      for( unsigned j=0; j<width_A_byte*2; j++ ) {
          uint8_t ai_j = gf16v_get_ele( matA , j );
          gf16v_madd( matC , matB + j*width_B_byte , ai_j , width_B_byte );
      }
      matC += width_B_byte;
      matA += width_A_byte;
    }
}


void gf16mat_colmat_mul_ref(uint8_t *mat_c, const uint8_t *mat_a, unsigned a_veclen_byte, unsigned a_n_vec, const uint8_t *mat_b, unsigned b_n_vec)
{
    gf16mat_rowmat_mul_ref( mat_c , mat_b , b_n_vec , (a_n_vec+1)>>1 , mat_a , a_veclen_byte );
}


//
// If matC, matA, and matB are row-major matrices    ->  matC = matA x matB
// If matC, matA, and matB are column-major matrices ->  matC = matB x matA
// XXX: optimization with Strassen multiplication
//
void gf256mat_rowmat_mul_ref(uint8_t *matC, const uint8_t *matA, unsigned src_A_n_vec, unsigned src_A_veclen_byte, const uint8_t *matB, unsigned dest_B_veclen_byte)
{
    gf256v_set_zero( matC , src_A_n_vec*dest_B_veclen_byte );
    for( unsigned i=0; i<src_A_n_vec; i++) {
      for( unsigned j=0; j< src_A_veclen_byte; j++ ) {
          uint8_t ai_j = matA[j];
          gf256v_madd( matC , matB + j*dest_B_veclen_byte , ai_j , dest_B_veclen_byte );
      }
      matC += dest_B_veclen_byte;
      matA += src_A_veclen_byte;
    }
}

void gf256mat_colmat_mul_ref(uint8_t *mat_c, const uint8_t *mat_a, unsigned a_veclen_byte, unsigned a_n_vec, const uint8_t *mat_b, unsigned b_n_vec)
{
    gf256mat_rowmat_mul_ref( mat_c , mat_b , b_n_vec , a_n_vec , mat_a , a_veclen_byte );
}


// TODO: remove all the if 0
#if 0
static inline
void gf256mat_transpose( uint8_t *mat , unsigned len )
{
    for(unsigned i=0;i<len;i++) {
        for(unsigned j=i+1;j<len;j++) {
            // swap
            uint8_t tmp = mat[i*len+j];
            mat[i*len+j] = mat[j*len+i];
            mat[j*len+i] = tmp;
        }
    }
}
#endif

void gf256mat_back_substitute_ref( uint8_t *constant, const uint8_t *sq_row_mat_a, unsigned len)
{
    const unsigned MAX_H=96;
    uint8_t column[MAX_H];
    for(int i=len-1;i>0;i--) {
        for(int j=0;j<i;j++) column[j] = sq_row_mat_a[j*len+i];   // row-major -> column-major, i.e., transpose
        gf256v_madd( constant , column , constant[i] , i );
    }
}


void gf16mat_back_substitute_ref( uint8_t *constant, const uint8_t *sq_row_mat_a, unsigned len)
{
    //const unsigned MAX_H=64;
#define MAX_H  (64)
    uint8_t column[MAX_H] = {0};
#undef MAX_H
    unsigned width_byte = (len+1)/2;
    for(int i=len-1;i>0;i--) {
        for(int j=0;j<i;j++) {
           // row-major -> column-major, i.e., transpose
           uint8_t ele = gf16v_get_ele( sq_row_mat_a+width_byte*j , i );
           gf16v_set_ele( column , j , ele );
        }
        gf16v_set_ele( column , i , 0 );  // pad to last byte
        gf16v_madd( constant , column , gf16v_get_ele(constant,i) , (i+1)/2 );
    }
}