#ifndef PARAMS_H
#define PARAMS_H

//#define RING_CATEGORY1
#define RING_CATEGORY3_N1024
//#define RING_CATEGORY3_N2048
//#define RING_CATEGORY5

#ifdef RING_CATEGORY1
#define PARAMNAME "RLizard.KEM_CATEGORY1"
#define LWE_N 1024		// LWE dim and LWR dim
#define LOG_Q 10
#define _16_LOG_Q 6
#define LOG_P 8
#define RD_ADD 0x80 	// 2^(15 - LOG_P)
#define RD_AND 0xff00
#define HR 128			// Hamming weight of coefficient vector r
#define HS 128			// Hamming weight of coefficient vector s
#define LOG_T 1
#define _16_LOG_T 15
#define T 2
#define DEC_ADD 0x4000	// 2^(15 - LOG_T)
#define LAMBDA 128
#define NOISE_D1		// standard deviation for discrete gaussian distribution
#endif

#ifdef RING_CATEGORY3_N1024
#define PARAMNAME "RLizard.KEM_CATEGORY3_N1024"
#define LWE_N 1024		// LWE dim and LWR dim
#define LOG_Q 11
#define _16_LOG_Q 5
#define LOG_P 9
#define RD_ADD 0x40 	// 2^(15 - LOG_P)
#define RD_AND 0xff80
#define HR 264			// Hamming weight of coefficient vector r
#define HS 256			// Hamming weight of coefficient vector s
#define LOG_T 1
#define _16_LOG_T 15
#define T 2
#define DEC_ADD 0x4000	// 2^(15 - LOG_T)
#define LAMBDA 192
#define NOISE_D2		// standard deviation for discrete gaussian distribution
#endif

#ifdef RING_CATEGORY3_N2048
#define PARAMNAME "RLizard.KEM_CATEGORY3_N2048"
#define LWE_N 2048		// LWE dim and LWR dim
#define LOG_Q 11
#define _16_LOG_Q 5
#define LOG_P 9
#define RD_ADD 0x40 	// 2^(15 - LOG_P)
#define RD_AND 0xff80
#define HR 164			// Hamming weight of coefficient vector r
#define HS 184			// Hamming weight of coefficient vector s
#define LOG_T 1
#define _16_LOG_T 15
#define T 2
#define DEC_ADD 0x4000	// 2^(15 - LOG_T)
#define LAMBDA 192
#define NOISE_D3		// standard deviation for discrete gaussian distribution
#endif

#ifdef RING_CATEGORY5
#define PARAMNAME "RLizard.KEM_CATEGORY5"
#define LWE_N 2048		// LWE dim and LWR dim
#define LOG_Q 12
#define _16_LOG_Q 4
#define LOG_P 10
#define RD_ADD 0x20 	// 2^(15 - LOG_P)
#define RD_AND 0xffC0
#define HR 256			// Hamming weight of coefficient vector r
#define HS 256			// Hamming weight of coefficient vector s
#define LOG_T 1
#define _16_LOG_T 15
#define T 2
#define DEC_ADD 0x4000	// 2^(15 - LOG_T)
#define LAMBDA 256
#define NOISE_D4		// standard deviation for discrete gaussian distribution
#endif

#define KEYGEN Keygen_kem_ring
#define ENCDECTEST EncDecTest_kem_RING

#endif
