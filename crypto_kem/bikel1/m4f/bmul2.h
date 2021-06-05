// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain

#ifndef _BMUL_2_H_
#define _BMUL_2_H_

#include "stdint.h"


//
// ffft based mulitplication for bit-polynomials
// Use Froebinus FFT
//


// input transform for the multiplication.
// sizeof( a_out ) = 2*sizeof( a_in ) = 4096 bytes
void bmul2_2048_to_4096_prepare( uint32_t * a_out, const uint8_t * a_in );

// multiplication with input operands after input transform.
// sizeof( c ) = sizeof( a ) = sizeof( b ) = 4096 bytes
void bmul2_2048_to_4096_mul( uint8_t * c, const uint32_t * a, const uint32_t * b );


// multiplication for bit polynomials
// sizeof( c ) = 2*sizeof( a ) = 2*sizeof(b) = 4096 bytes
void bmul2_2048_to_4096( uint8_t * c, const uint8_t * a, const uint8_t * b );

/////////////////////

// input transform for the multiplication.
// sizeof( a_out ) = 2*sizeof( a_in ) = 8192 bytes
void bmul2_4096_to_8192_prepare( uint32_t * a_out, const uint8_t * a_in );

// multiplication with input operands after input transform.
// sizeof( c ) = sizeof( a ) = sizeof( b ) = 8192 bytes
void bmul2_4096_to_8192_mul( uint8_t * c, const uint32_t * a, const uint32_t * b );

// multiplication for bit polynomials
// sizeof( c ) = 2*sizeof( a ) = 2*sizeof(b) = 8192 bytes
void bmul2_4096_to_8192( uint8_t * c, const uint8_t * a, const uint8_t * b );


#endif
