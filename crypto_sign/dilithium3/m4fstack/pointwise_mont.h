#ifndef POINTWISE_MONT_H
#define POINTWISE_MONT_H

#include <stdint.h>
#include "params.h"


#define asm_pointwise_montgomery DILITHIUM_NAMESPACE(asm_pointwise_montgomery)
void asm_pointwise_montgomery(int32_t c[N], const int32_t a[N], const int32_t b[N]);
#define asm_pointwise_acc_montgomery DILITHIUM_NAMESPACE(asm_pointwise_acc_montgomery)
void asm_pointwise_acc_montgomery(int32_t c[N], const int32_t a[N], const int32_t b[N]);

#endif
