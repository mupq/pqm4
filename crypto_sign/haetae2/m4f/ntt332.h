#ifndef NTT332_H
#define NTT332_H

#include "params.h"
#include <stdint.h>

#if N != 256
#error "NTT332: Only N==256 is supported."
#endif

void haetae_ntt332(int32_t poly[N]);
void haetae_invntt332_tomont(int32_t poly[N]);

#endif /* NTT332_H */