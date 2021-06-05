// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain

#include "string.h"

#include "bmul2.h"
#include "bc_2.h"
#include "btfy_ffft.h"
#include "encode.h"
#include "gfv_tower.h"


void bmul2_2048_to_4096_prepare_ebuff( uint32_t * a_out, const uint8_t * a_in , uint32_t *a0 )
{
  memcpy( a0 , a_in , 2048 );
  bc_1_16384( a0 );

  uint32_t temp[16];
  for(int i=0;i<((32768/32)/32);i++) {
    for(int j=0;j<16;j++) temp[j] = a0[((32768/32)/32)*j+i];
    encode_trunc_fft( a_out+i*32, temp );
  }
  btfy_32768( a_out );
}


void bmul2_2048_to_4096_prepare( uint32_t * a_out, const uint8_t * a_in )
{
  uint32_t a0[16384/32];
  bmul2_2048_to_4096_prepare_ebuff( a_out , a_in , a0 );
}


void bmul2_2048_to_4096_mul_ebuff( uint8_t * c, const uint32_t * a, const uint32_t * b , uint32_t *a0 )
{
  uint32_t * c32 = (uint32_t*)c;

  for(int i=0;i<(32768/32);i+=32) { gf232v_mul( a0+i, a+i , b+i ); }

  ibtfy_32768( a0 );

  uint32_t temp[32];
  for(int i=0;i<(32768/32);i+=32) {
    decode_trunc_fft( temp , a0+i );
    for(int j=0;j<32;j++) c32[((32768/32)/32)*j+i/32] = temp[j];
  }
  ibc_1_32768( c32 );
}


void bmul2_2048_to_4096_mul( uint8_t * c, const uint32_t * a, const uint32_t * b )
{
  uint32_t a0[32768/32];
  bmul2_2048_to_4096_mul_ebuff( c , a, b , a0 );
}



void bmul2_2048_to_4096( uint8_t * c, const uint8_t * a, const uint8_t * b )
{
  uint32_t a_u32[32768/32];
  uint32_t b_u32[32768/32];

  bmul2_2048_to_4096_prepare( a_u32, a );
  bmul2_2048_to_4096_prepare( b_u32, b );

  bmul2_2048_to_4096_mul( c , a_u32 , b_u32 );
}



////////////////////////////////



void bmul2_4096_to_8192_prepare_ebuff( uint32_t * a_out, const uint8_t * a_in , uint32_t *a0 )
{
  memcpy( a0 , a_in , 4096 );
  bc_1_32768( a0 );

  uint32_t temp[16];
  for(int i=0;i<((65536/32)/32);i++) {
    for(int j=0;j<16;j++) temp[j] = a0[((65536/32)/32)*j+i];
    encode_trunc_fft( a_out+i*32, temp );
  }
  btfy_65536( a_out );
}

void bmul2_4096_to_8192_prepare( uint32_t * a_out, const uint8_t * a_in )
{
  uint32_t a0[32768/32];
  bmul2_4096_to_8192_prepare_ebuff( a_out , a_in , a0 );
}


void bmul2_4096_to_8192_mul_ebuff( uint8_t * c, const uint32_t * a, const uint32_t * b , uint32_t *a0)
{
  uint32_t * c32 = (uint32_t*)c;

  for(int i=0;i<(65536/32);i+=32) { gf232v_mul( a0+i, a+i , b+i ); }

  ibtfy_65536( a0 );

  uint32_t temp[32];
  for(int i=0;i<(65536/32);i+=32) {
    decode_trunc_fft( temp , a0+i );
    for(int j=0;j<32;j++) c32[((65536/32)/32)*j+i/32] = temp[j];
  }
  ibc_1_65536( c32 );
}

void bmul2_4096_to_8192_mul( uint8_t * c, const uint32_t * a, const uint32_t * b )
{
  uint32_t a0[65536/32];
  bmul2_4096_to_8192_mul_ebuff( c , a , b , a0 );
}


void bmul2_4096_to_8192( uint8_t * c, const uint8_t * a, const uint8_t * b )
{
  uint32_t a_u32[65536/32];
  uint32_t b_u32[65536/32];

  bmul2_4096_to_8192_prepare( a_u32, a );
  bmul2_4096_to_8192_prepare( b_u32, b );

  bmul2_4096_to_8192_mul( c , a_u32 , b_u32 );
}









