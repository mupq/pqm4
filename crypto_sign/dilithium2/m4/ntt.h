#ifndef NTT_H
#define NTT_H

#include "params.h"
#include <stdint.h>

void ntt_asm(uint32_t p[N]);
void inv_ntt_asm(uint32_t p[N]);

#endif
