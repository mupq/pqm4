#ifndef HAETAE_ROUNDING_H
#define HAETAE_ROUNDING_H

#include "params.h"
#include <stdint.h>

#define decompose_z1 HAETAE_NAMESPACE(decompose_z1)
void decompose_z1(int32_t *highbits, int32_t *lowbits, const int32_t r);

#define decompose_hint HAETAE_NAMESPACE(decompose_hint)
void decompose_hint(int32_t *highbits, const int32_t r);

#define decompose_vk HAETAE_NAMESPACE(decompose_vk)
int32_t decompose_vk(int32_t *a0, const int32_t a);

#endif
