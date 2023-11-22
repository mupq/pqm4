#ifndef NTT_H
#define NTT_H

#include "params.h"
#include <stdint.h>

#define ntt HAETAE_NAMESPACE(ntt)
void ntt(int32_t a[N]);

#define invntt_tomont HAETAE_NAMESPACE(invntt_tomont)
void invntt_tomont(int32_t a[N]);

#endif