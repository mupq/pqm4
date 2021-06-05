// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain

#ifndef _ENCODE_H_
#define _ENCODE_H_

#include "stdint.h"

#include "gfv_tower.h"  // for sto_t


void encode_to_gft(sto_t * dest_32bit, const sto_t *src_16bit);
void decode_from_gft(sto_t * dest_32bit, const sto_t *src_32bit);

#define encode_trunc_fft encode_to_gft
#define decode_trunc_fft decode_from_gft



#endif // _ENCODE_H_
