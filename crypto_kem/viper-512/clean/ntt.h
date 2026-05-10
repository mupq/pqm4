#ifndef NTT_H
#define NTT_H

#include <stdint.h>
#include "params.h"

// 声明预计算的旋转因子表 (Twiddle Factors)
extern const int16_t zetas[128];

// 正向变换: Time Domain -> NTT Domain
void ntt(int16_t poly[256]);

// 逆向变换: NTT Domain -> Time Domain
void invntt(int16_t poly[256]);

// 基乘法: 在 NTT 域中做点乘 (两个一次多项式的模乘)
void basemul(int16_t r[2], const int16_t a[2], const int16_t b[2], int16_t zeta);

#endif