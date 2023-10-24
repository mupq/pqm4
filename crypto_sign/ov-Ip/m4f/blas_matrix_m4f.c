#include "blas_matrix_m4f.h"
#include "blas_matrix_ref.h"
#include "blas.h"
#include "params.h"
#include "config.h"

#ifdef _USE_GF16
#include "gf16_asm.h"
#else
#include "gf256_asm.h"
#endif

//TODO: check if this can be removed
#include "parallel_matrix_op.h"

static inline
void gf256mat_submat( uint8_t * mat2 , unsigned veclen2_byte , unsigned st , const uint8_t * mat , unsigned veclen_byte , unsigned n_vec )
{
    for(unsigned i=0;i<n_vec;i++) {
        for(unsigned j=0;j<veclen2_byte;j++) mat2[i*veclen2_byte+j] = mat[i*veclen_byte+st+j];
    }
}

#ifdef _USE_GF16
void gf16mat_prod_m4f(uint8_t *c, const uint8_t *matA, unsigned n_A_vec_byte, unsigned n_A_width, const uint8_t *b)
{
  //TODO: add errors if used with different params
  if(n_A_vec_byte == 2048 && n_A_width == 96){
    gf16mat_prod_m4f_2048_96_normal_normal(c, matA, b);
  } else if(n_A_vec_byte == 48 && n_A_width == 64){
    gf16mat_prod_m4f_48_64_normal_normal(c, matA, b);
  } else if(n_A_vec_byte == 32){
    gf16mat_prod_m4f_32_X_normal_normal(c, matA, b, n_A_width);
  }
}


unsigned gf16mat_LDUinv_m4f(uint8_t *mat_U_AinvB, uint8_t *mat_Ainv,
                             uint8_t *mat_CAinvB_inv, uint8_t *mat_L_C,
                             const uint8_t *matA , unsigned len)
{
    #if _O != 64
    #error not implemented
    #endif
    // column-major matrices
    unsigned a_veclen_byte = len/2;
    unsigned a_n_vec = len;
    unsigned a_veclen_byte_2 = a_veclen_byte/2;
    unsigned a_n_vec_2 = a_n_vec/2;

    uint8_t * temp = mat_L_C;

    gf256mat_submat( temp, a_veclen_byte_2 , 0 , matA , a_veclen_byte , a_n_vec_2 );  // A
    unsigned r = gf16mat_inv_m4f_32( mat_Ainv , temp );
    if( 0==r ) return 0;

    gf256mat_submat( temp , a_veclen_byte_2 , 0 , matA+a_veclen_byte*a_n_vec_2 , a_veclen_byte , a_n_vec_2 );  // B
    gf16mat_colmat_mul_ref( mat_U_AinvB , mat_Ainv , a_veclen_byte_2 , a_n_vec_2  , temp , a_n_vec_2 );  // A^-1 x B

    gf256mat_submat( temp , a_veclen_byte_2 , a_veclen_byte_2  , matA , a_veclen_byte , a_n_vec_2 );  // C
    gf16mat_colmat_mul_ref( mat_CAinvB_inv , temp , a_veclen_byte_2 , a_n_vec_2 , mat_U_AinvB , a_n_vec_2 );
    gf256mat_submat( temp , a_veclen_byte_2 , a_veclen_byte_2 , matA+a_veclen_byte*a_n_vec_2 , a_veclen_byte , a_n_vec_2 );  // D
    gf256v_add( temp , mat_CAinvB_inv , a_veclen_byte_2*a_n_vec_2 );  // (D-CA^-1B)

    r &= gf16mat_inv_m4f_32( mat_CAinvB_inv , temp );
    if( 0==r ) return 0;

    gf256mat_submat( mat_L_C , a_veclen_byte_2 , a_veclen_byte_2 , matA , a_veclen_byte , a_n_vec_2 );  // C

    return r;
}

unsigned gf16mat_inv_m4f(uint8_t * inv_a , const uint8_t * a , unsigned H )
{
  #if _O != 64
  #error not implemented
  #endif
  (void)H;
  return gf16mat_inv_m4f_64(inv_a, a);
}


void batch_quad_trimat_eval_gf16_m4f(unsigned char * y, const unsigned char * trimat,
                                     const unsigned char * x, unsigned dim , unsigned size_batch)
{
  // TODO: add errors if this is not the case
  if(dim == 96 && size_batch == 32){
    gf16trimat_eval_m4f_96_32(y, trimat, x);
  }
}

unsigned gf16mat_gaussian_elim_m4f(uint8_t *sqmat_a , uint8_t *constant, unsigned len) {
  //TODO: add errors if _O is different
  (void) len;
  uint8_t mat[_O*(_O_BYTE+4)];
  for(unsigned i=0;i<_O;i++) {
      uint8_t * ai = mat + i*(_O_BYTE+4);
      for(unsigned j=0;j<_O;j++) {
         // transpose since sqmat_a is col-major
         gf16v_set_ele( ai , j , gf16v_get_ele(sqmat_a+j*_O_BYTE,i) );
      }
      ai[_O_BYTE] = gf16v_get_ele(constant,i);
  }

  unsigned char r8 = gf16mat_gauss_elim_row_echolen_m4f_64(mat);

  for(unsigned i=0;i<_O;i++) {
      uint8_t * ai = mat + i*(_O_BYTE+4);
      memcpy( sqmat_a+i*_O_BYTE , ai  , _O_BYTE ); // output a row-major matrix
      gf16v_set_ele(constant,i, ai[_O_BYTE] );
  }
  return r8;
}
#else

void gf256mat_prod_m4f(uint8_t *c, const uint8_t *matA, unsigned n_A_vec_byte, unsigned n_A_width, const uint8_t *b){
  //TODO: add errors if used with different params
  if(n_A_vec_byte == 1936 && n_A_width == 68){
    gf256mat_prod_m4f_1936_68_normal_normal(c, matA, b);
  } else if(n_A_vec_byte == 68 && n_A_width == 44) {
    gf256mat_prod_m4f_68_44_normal_normal(c, matA, b);
  } else if(n_A_vec_byte == 44) {
    gf256mat_prod_m4f_44_X_normal_normal(c, matA, b, n_A_width);
  }
}


unsigned gf256mat_LDUinv_m4f(uint8_t *mat_U_AinvB, uint8_t *mat_Ainv, uint8_t *mat_CAinvB_inv, uint8_t *mat_L_C, const uint8_t *matA , unsigned len) {
  #if _O != 44
  #error not implemented
  #endif

  // column-major matrices
  unsigned a_veclen_byte = len;
  unsigned a_n_vec = len;
  unsigned a_veclen_byte_2 = a_veclen_byte/2;
  unsigned a_n_vec_2 = a_n_vec/2;

  uint8_t * temp = mat_L_C;

  gf256mat_submat( temp, a_veclen_byte_2 , 0 , matA , a_veclen_byte , a_n_vec_2 );  // A
  unsigned r = gf256mat_inv_m4f_22( mat_Ainv , temp);
  if( 0==r ) return 0;

  gf256mat_submat( temp , a_veclen_byte_2 , 0 , matA+a_veclen_byte*a_n_vec_2 , a_veclen_byte , a_n_vec_2 );  // B
  gf256mat_colmat_mul_ref( mat_U_AinvB , mat_Ainv , a_veclen_byte_2 , a_n_vec_2  , temp , a_n_vec_2 );  // A^-1 x B

  gf256mat_submat( temp , a_veclen_byte_2 , a_veclen_byte_2  , matA , a_veclen_byte , a_n_vec_2 );  // C
  gf256mat_colmat_mul_ref( mat_CAinvB_inv , temp , a_veclen_byte_2 , a_n_vec_2 , mat_U_AinvB , a_n_vec_2 );

  gf256mat_submat( temp , a_veclen_byte_2 , a_veclen_byte_2 , matA+a_veclen_byte*a_n_vec_2 , a_veclen_byte , a_n_vec_2 );  // D
  gf256v_add( temp , mat_CAinvB_inv , a_veclen_byte_2*a_n_vec_2 );  // (D-CA^-1B)
  r = gf256mat_inv_m4f_22( mat_CAinvB_inv , temp);
  if( 0==r ) return 0;

  gf256mat_submat( mat_L_C , a_veclen_byte_2 , a_veclen_byte_2 , matA , a_veclen_byte , a_n_vec_2 );  // C
  return 1;
}


unsigned gf256mat_inv_m4f(uint8_t * inv_a , const uint8_t * a , unsigned H ){
  #if _O != 44
  #error not implemented
  #endif
  (void) H;
  return gf256mat_inv_m4f_44(inv_a, a);
}

void batch_quad_trimat_eval_gf256_m4f(unsigned char * y, const unsigned char * trimat, const unsigned char * x, unsigned dim , unsigned size_batch){
  // TODO: add errors if this is not the case
  if(dim == 68 && size_batch == 44){
      gf256trimat_eval_m4f_68_44(y, trimat, x);
  }
}

unsigned gf256mat_gaussian_elim_m4f(uint8_t *sqmat_a , uint8_t *constant, unsigned len){
  //TODO: add error if _O is different
  (void) len;
  uint8_t mat[_O*(_O_BYTE+4)];
   for(unsigned i=0;i<_O;i++) {
       uint8_t * ai = mat + i*(_O_BYTE+4);
       for(unsigned j=0;j<_O;j++) {
           // transpose since sqmat_a is col-major
           ai[j] = sqmat_a[j*_O_BYTE+i];
       }
       ai[_O_BYTE] = constant[i];
   }

   unsigned char r8 = gf256mat_gauss_elim_row_echolen_m4f_44(mat);

   for(unsigned i=0;i<_O;i++) {
       uint8_t * ai = mat + i*(_O_BYTE+4);
       memcpy( sqmat_a + i*_O_BYTE , ai , _O_BYTE);     // output a row-major matrix
       constant[i] = ai[_O_BYTE];
   }
   return r8;
}

#endif

#if defined(_OV_PKC) || defined(_OV_PKC_SKC)
void ov_pkc_calculate_F_from_Q_m4f( sk_t * Fs)
{
  // TODO: add errors if parameters change
  #ifdef _USE_GF16
    gf16trimat_2trimat_madd_m4f_96_48_64_32( Fs->S , Fs->P1 , Fs->O);
  #else
    gf256trimat_2trimat_madd_m4f_68_68_44_44( Fs->S , Fs->P1 , Fs->O);
  #endif
}
#endif

