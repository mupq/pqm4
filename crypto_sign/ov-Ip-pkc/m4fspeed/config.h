#ifndef CONFIG_H_
#define CONFIG_H_

/*
 *   This file contains all implementation options that do not affect testvectors
 *   params.h contains other options.
 */

// defined from the makefile
//#define _BLAS_UINT64_
//#define _BLAS_SSE_
//#define _BLAS_AVX2_
//#define _BLAS_M4F_
#define _BLAS_M4F_
#define NDEBUG
//#define _UTILS_SUPERCOP_   // XXX: un-supported now
#define _UTILS_PQM4_

// default:
//`#define _UTILS_OPENSSL_


//
// The following macro will implement randombytes() with C rand()
// Turn on only when there is no proper implementation
//
// #define _DEBUG_RANDOMBYTES_


#endif
