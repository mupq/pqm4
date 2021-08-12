#include <inttypes.h>
typedef int8_t small;
typedef int16_t Fq;
#ifndef NTT612
#define NTT612
void ntt612(int* fpad, int* f);
void ntt612x(int* fpad, int* f);
void intt612(int* f, int* fpad);
void intt612x(int* fpad, int* f);
void basemul_612(int* hpad, int* fpad, int* gpad);
#endif