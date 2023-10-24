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



/////////////////   algorithms:  gaussian elim  //////////////////
////////////  private functions  /////////////////////////////



static
unsigned gf16mat_gauss_elim_32x64_ref( uint8_t *mat ) {
    const unsigned h = 32;
    const unsigned w = 64;
    const unsigned w_byte = w/2;

    unsigned r8 = 1;
    for (unsigned i = 0; i < h; i++) {
        unsigned i_start = ((i>>1)&(~(_BLAS_UNIT_LEN_-1)));
        uint8_t *ai = mat + i*w_byte;
        for (unsigned j = i + 1; j < h; j++) {
            uint8_t *aj = mat + j*w_byte;
            gf256v_conditional_add(ai + i_start, !gf16_is_nonzero(gf16v_get_ele(ai, i)), aj + i_start, w_byte - i_start );
        }
        uint8_t pivot = gf16v_get_ele(ai, i);
        r8 &= gf16_is_nonzero(pivot);
        pivot = gf16_inv(pivot);
        gf16v_mul_scalar(ai + i_start, pivot, w_byte - i_start );
        for (unsigned j = 0; j < h; j++) {
            if (i == j) continue;
            uint8_t *aj = mat + j*w_byte;
            gf16v_madd(aj + i_start, ai + i_start, gf16v_get_ele(aj, i), w_byte-i_start);
        }
    }
    return r8;
}


static
unsigned gf16mat_gauss_elim_ref(uint8_t *mat, unsigned h, unsigned w) {
    const unsigned w_byte = (w+1)>>1;

    unsigned r8 = 1;
    for (unsigned i = 0; i < h; i++) {
        unsigned i_start = ((i>>1)&(~(_BLAS_UNIT_LEN_-1)));
        //unsigned i_start = (i>>1);
        uint8_t *ai = mat + i*w_byte;
        for (unsigned j = i + 1; j < h; j++) {
            uint8_t *aj = mat + j*w_byte;
            gf256v_conditional_add(ai + i_start, !gf16_is_nonzero(gf16v_get_ele(ai, i)), aj + i_start, w_byte - i_start );
        }
        uint8_t pivot = gf16v_get_ele(ai, i);
        r8 &= gf16_is_nonzero(pivot);
        pivot = gf16_inv(pivot);
        gf16v_mul_scalar(ai + i_start, pivot, w_byte - i_start );
        for (unsigned j = 0; j < h; j++) {
            if (i == j) continue;
            uint8_t *aj = mat + j*w_byte;
            gf16v_madd(aj + i_start, ai + i_start, gf16v_get_ele(aj, i), w_byte-i_start);
        }
    }
    return r8;
}


/////////////////////////////////////////////////


static
unsigned gf256mat_gauss_elim_ref( uint8_t * mat , unsigned h , unsigned w )
{
    unsigned r8 = 1;

    for(unsigned i=0;i<h;i++) {
        uint8_t * ai = mat + w*i;
        //unsigned i_start = i-(i&(_BLAS_UNIT_LEN_-1));
        unsigned i_start = i;

        for(unsigned j=i+1;j<h;j++) {
            uint8_t * aj = mat + w*j;
            gf256v_conditional_add( ai + i_start , !gf256_is_nonzero(ai[i]) , aj + i_start , w - i_start );
        }
        r8 &= gf256_is_nonzero(ai[i]);
        uint8_t pivot = ai[i];
        pivot = gf256_inv( pivot );
        gf256v_mul_scalar( ai + i_start  , pivot , w - i_start );
        for(unsigned j=0;j<h;j++) {
            if(i==j) continue;
            uint8_t * aj = mat + w*j;
            gf256v_madd( aj + i_start , ai+ i_start , aj[i] , w - i_start );
        }
    }

    return r8;
}



////////////  private functions  /////////////////////////////




static
unsigned gf16mat_inv_32x32_ref(uint8_t *inv_a, const uint8_t *a )
{
    const unsigned H=32;
    uint8_t mat[32*32];
    for (unsigned i = 0; i < H; i++) {
        uint8_t *ai = mat + i * 32;
        gf256v_set_zero(ai, 32 );
        gf256v_add(ai, a + i * 16, 16);
        gf16v_set_ele(ai + 16, i, 1);
    }
    uint8_t r8 = gf16mat_gauss_elim_32x64_ref(mat);
    gf256mat_submat(inv_a, H/2, H/2, mat, H, H);

    return r8;
}


////////////////////  public function   ///////////////////////


unsigned gf16mat_inv_ref(uint8_t *inv_a, const uint8_t *a , unsigned H )
{
    if( 32==H ) return gf16mat_inv_32x32_ref( inv_a , a );

    const unsigned MAX_H=64;
    uint8_t mat[MAX_H*MAX_H];  // max: 64x128

    unsigned h_byte = (H+1)>>1;
    for (unsigned i = 0; i < H; i++) {
        uint8_t *ai = mat + i * H;
        gf256v_set_zero(ai, H );
        gf256v_add(ai, a + i * h_byte, h_byte);
        gf16v_set_ele(ai + h_byte, i, 1);
    }
    uint8_t r8 = gf16mat_gauss_elim_ref(mat, H , H*2);
    gf256mat_submat(inv_a, h_byte, h_byte, mat, H, H);

    return r8;
}


/////////////////////////////////////////////////




static
unsigned gf256mat_inv_32x32_ref( uint8_t * inv_a , const uint8_t * a )
{
    const unsigned H=32;
    uint8_t mat[H*H*2];
    for(unsigned i=0;i<H;i++) {
        uint8_t * ai = mat + i*2*H;
        gf256v_set_zero( ai , 2*H );
        gf256v_add( ai , a + i*H , H );
        ai[H+i] = 1;
    }
    unsigned char r8 = gf256mat_gauss_elim_ref( mat , H , 2*H );
    gf256mat_submat( inv_a , H , H , mat , 2*H , H );
    gf256v_set_zero(mat,H*2*H);
    return r8;
}

static
unsigned gf256mat_inv_36x36_ref( uint8_t * inv_a , const uint8_t * a )
{
    const unsigned H=36;
    uint8_t mat[H*H*2];
    for(unsigned i=0;i<H;i++) {
        uint8_t * ai = mat + i*2*H;
        gf256v_set_zero( ai , 2*H );
        gf256v_add( ai , a + i*H , H );
        ai[H+i] = 1;
    }
    unsigned char r8 = gf256mat_gauss_elim_ref( mat , H , 2*H );
    gf256mat_submat( inv_a , H , H , mat , 2*H , H );
    gf256v_set_zero(mat,H*2*H);
    return r8;
}



////////////////////  public function   ///////////////////////


//
// Should work for both column- and row-major matrices
//
unsigned gf256mat_inv_ref( uint8_t * inv_a , const uint8_t * a , unsigned H )
{
    if( 32 == H ) return gf256mat_inv_32x32_ref(inv_a,a);
    if( 36 == H ) return gf256mat_inv_36x36_ref(inv_a,a);

    const unsigned MAX_H=64;
    uint8_t mat[MAX_H*MAX_H*2];

    for(unsigned i=0;i<H;i++) {
        uint8_t * ai = mat + i*2*H;
        gf256v_set_zero( ai , 2*H );
        gf256v_add( ai , a + i*H , H );
        ai[H+i] = 1;
    }
    unsigned char r8 = gf256mat_gauss_elim_ref( mat , H , 2*H );
    gf256mat_submat( inv_a , H , H , mat , 2*H , H );
    gf256v_set_zero(mat,H*2*H);
    return r8;

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

///////////////////  LDU decomposition  /////////////////////


//void gf256mat_submat( uint8_t * mat2 , unsigned w2 , unsigned st , const uint8_t * mat , unsigned w , unsigned h )
//void gf256mat_mul_ref(uint8_t *matC, const uint8_t *matA, unsigned height_A, unsigned width_A_byte, const uint8_t *matB, unsigned width_B_byte)

//
// matA is a square matrix.
// matA = [ A B ]
//        [ C D ]
//
// LDU_A = [ 1      0 ] [ A      0      ] [ 1 A^-1 B]
//         [ C A^-1 1 ] [ 0  D-C A^-1 B ] [ 0   1   ]
//
// LDU_inv = [ 1  -A^-1 B ] [ A^-1         0       ] [    1      0 ]
//           [ 0     1    ] [  0     (D-CA^-1B)^-1 ] [ -C A^-1   1 ]


unsigned gf256mat_LDUinv_ref(uint8_t *mat_U_AinvB, uint8_t *mat_Ainv, uint8_t *mat_CAinvB_inv, uint8_t *mat_L_C, const uint8_t *matA , unsigned len)
{
#if 1
    // column-major matrices
    unsigned a_veclen_byte = len;
    unsigned a_n_vec = len;
    unsigned a_veclen_byte_2 = a_veclen_byte/2;
    unsigned a_n_vec_2 = a_n_vec/2;

    uint8_t * temp = mat_L_C;

    gf256mat_submat( temp, a_veclen_byte_2 , 0 , matA , a_veclen_byte , a_n_vec_2 );  // A
    unsigned r = gf256mat_inv_ref( mat_Ainv , temp , a_n_vec_2 );
    if( 0==r ) return 0;

    gf256mat_submat( temp , a_veclen_byte_2 , 0 , matA+a_veclen_byte*a_n_vec_2 , a_veclen_byte , a_n_vec_2 );  // B
    gf256mat_colmat_mul_ref( mat_U_AinvB , mat_Ainv , a_veclen_byte_2 , a_n_vec_2  , temp , a_n_vec_2 );  // A^-1 x B

    gf256mat_submat( temp , a_veclen_byte_2 , a_veclen_byte_2  , matA , a_veclen_byte , a_n_vec_2 );  // C
    gf256mat_colmat_mul_ref( mat_CAinvB_inv , temp , a_veclen_byte_2 , a_n_vec_2 , mat_U_AinvB , a_n_vec_2 );
    gf256mat_submat( temp , a_veclen_byte_2 , a_veclen_byte_2 , matA+a_veclen_byte*a_n_vec_2 , a_veclen_byte , a_n_vec_2 );  // D
    gf256v_add( temp , mat_CAinvB_inv , a_veclen_byte_2*a_n_vec_2 );  // (D-CA^-1B)
    r = gf256mat_inv_ref( mat_CAinvB_inv , temp , a_n_vec_2 );
    if( 0==r ) return 0;

    gf256mat_submat( mat_L_C , a_veclen_byte_2 , a_veclen_byte_2 , matA , a_veclen_byte , a_n_vec_2 );  // C
#else
    // code for row-major matrices
    unsigned len_2 = len/2;
    uint8_t * temp = mat_L_C;

    gf256mat_submat( temp, len_2 , 0 , matA , len , len_2 );  // A
    unsigned r = gf256mat_inv_ref( mat_Ainv , temp , len_2 );
    if( 0==r ) return 0;

    gf256mat_submat( temp , len_2 , len_2 , matA , len , len_2 );  // B
    gf256mat_rowmat_mul_ref( mat_U_AinvB , mat_Ainv , len_2 , len_2 , temp , len_2 );

    gf256mat_submat( temp , len_2 , 0 , matA+len_2*len , len , len_2 );  // C
    gf256mat_rowmat_mul_ref( mat_CAinvB_inv , temp , len_2 , len_2 , mat_U_AinvB , len_2 );
    gf256mat_submat( temp , len_2 , len_2 , matA+len_2*len , len , len_2 );  // D
    gf256v_add( temp , mat_CAinvB_inv , len_2*len_2 );
    r = gf256mat_inv_ref( mat_CAinvB_inv , temp , len_2 );
    if( 0==r ) return 0;

    gf256mat_submat( mat_L_C , len_2 , 0 , matA+len_2*len , len , len_2 );  // C
#endif

    return 1;
}

#if 1


//
// matA is a square matrix.
// matA = [ A B ]
//        [ C D ]
//
// LDU_A = [ 1      0 ] [ A      0      ] [ 1 A^-1 B]
//         [ C A^-1 1 ] [ 0  D-C A^-1 B ] [ 0   1   ]
//
// LDU_inv = [ 1  -A^-1 B ] [ A^-1         0       ] [    1      0 ]
//           [ 0     1    ] [  0     (D-CA^-1B)^-1 ] [ -C A^-1   1 ]

unsigned gf16mat_LDUinv_ref(uint8_t *mat_U_AinvB, uint8_t *mat_Ainv, uint8_t *mat_CAinvB_inv, uint8_t *mat_L_C, const uint8_t *matA , unsigned len)
{
    // column-major matrices
    unsigned a_veclen_byte = len/2;
    unsigned a_n_vec = len;
    unsigned a_veclen_byte_2 = a_veclen_byte/2;
    unsigned a_n_vec_2 = a_n_vec/2;

    uint8_t * temp = mat_L_C;

    gf256mat_submat( temp, a_veclen_byte_2 , 0 , matA , a_veclen_byte , a_n_vec_2 );  // A
    unsigned r = gf16mat_inv_ref( mat_Ainv , temp , a_n_vec_2 );
    if( 0==r ) return 0;

    gf256mat_submat( temp , a_veclen_byte_2 , 0 , matA+a_veclen_byte*a_n_vec_2 , a_veclen_byte , a_n_vec_2 );  // B
    gf16mat_colmat_mul_ref( mat_U_AinvB , mat_Ainv , a_veclen_byte_2 , a_n_vec_2  , temp , a_n_vec_2 );  // A^-1 x B

    gf256mat_submat( temp , a_veclen_byte_2 , a_veclen_byte_2  , matA , a_veclen_byte , a_n_vec_2 );  // C
    gf16mat_colmat_mul_ref( mat_CAinvB_inv , temp , a_veclen_byte_2 , a_n_vec_2 , mat_U_AinvB , a_n_vec_2 );
    gf256mat_submat( temp , a_veclen_byte_2 , a_veclen_byte_2 , matA+a_veclen_byte*a_n_vec_2 , a_veclen_byte , a_n_vec_2 );  // D
    gf256v_add( temp , mat_CAinvB_inv , a_veclen_byte_2*a_n_vec_2 );  // (D-CA^-1B)
    r &= gf16mat_inv_ref( mat_CAinvB_inv , temp , a_n_vec_2 );
    if( 0==r ) return 0;

    gf256mat_submat( mat_L_C , a_veclen_byte_2 , a_veclen_byte_2 , matA , a_veclen_byte , a_n_vec_2 );  // C

    return r;
}

#endif


#define _MAX_LEN  256


// LDU_inv = [ 1  -A^-1 B ] [ A^-1         0       ] [    1      0 ]    x  [b_u]
//           [ 0     1    ] [  0     (D-CA^-1B)^-1 ] [ -C A^-1   1 ]       [b_b]

void gf256mat_LDUinv_prod_ref(uint8_t *c, const uint8_t *mat_U_AinvB, const uint8_t *mat_Ainv, const uint8_t *mat_CAinvB_inv, const uint8_t *mat_L_C,
        const uint8_t * b , unsigned len)
{
    uint8_t temp[_MAX_LEN];
    unsigned len_2 = len/2;

    gf256mat_prod_ref( c       , mat_Ainv , len_2 , len_2 , b );  //   A^-1 x b_u
    //gf256mat_prod_ref( c+len_2 , mat_Ainv , len_2 , len_2 , b+len_2 );

    gf256mat_prod_ref( temp , mat_L_C , len_2 , len_2 , c );    //  C x  (A^-1xb_u)
    gf256v_add( temp , b+len_2 , len_2 );     //   C x  (A^-1xb_u) + b_b
    gf256mat_prod_ref( c+len_2 , mat_CAinvB_inv , len_2 , len_2 , temp );  //   (D-CA^-1B)^-1  x  (C x  (A^-1xb_u) + b_b)

    gf256mat_prod_ref( temp , mat_U_AinvB , len_2 , len_2 , c+len_2 );
    gf256v_add( c , temp , len_2 );
}


// LDU_inv = [ 1  -A^-1 B ] [ A^-1         0       ] [    1      0 ]    x  [b_u]
//           [ 0     1    ] [  0     (D-CA^-1B)^-1 ] [ -C A^-1   1 ]       [b_b]

void gf16mat_LDUinv_prod_ref(uint8_t *c, const uint8_t *mat_U_AinvB, const uint8_t *mat_Ainv, const uint8_t *mat_CAinvB_inv, const uint8_t *mat_L_C,
        const uint8_t * b , unsigned veclen_byte)
{
    uint8_t temp[_MAX_LEN];
    unsigned veclen_byte_2 = veclen_byte/2;
    unsigned n_vec_2 = veclen_byte;

    gf16mat_prod_ref( c       , mat_Ainv , veclen_byte_2 , n_vec_2 , b );  //   A^-1 x b_u

    gf16mat_prod_ref( temp , mat_L_C , veclen_byte_2 , n_vec_2 , c );    //  C x  (A^-1xb_u)
    gf256v_add( temp , b+veclen_byte_2 , veclen_byte_2 );     //   C x  (A^-1xb_u) + b_b
    gf16mat_prod_ref( c+veclen_byte_2 , mat_CAinvB_inv , veclen_byte_2 , n_vec_2 , temp );  //   (D-CA^-1B)^-1  x  (C x  (A^-1xb_u) + b_b)

    gf16mat_prod_ref( temp , mat_U_AinvB , veclen_byte_2 , n_vec_2 , c+veclen_byte_2 );
    gf256v_add( c , temp , veclen_byte_2 );
}


#undef _MAX_LEN




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