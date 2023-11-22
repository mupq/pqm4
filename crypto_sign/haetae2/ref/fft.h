#ifndef FFT__H
#define FFT__H

#include "poly.h"
#include <stdint.h>

#define FFT_N 512
#define FFT_LOGN 9

typedef struct {
    int32_t real;
    int32_t imag;
} complex_fp32_16;

void fft(complex_fp32_16 data[FFT_N]);
void fft_bitrev(complex_fp32_16 r[FFT_N], const poly *x);
int32_t complex_fp_sqabs(complex_fp32_16 x);

#endif
