// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain

#ifndef _BC_2_H_
#define _BC_2_H_

#include "stdint.h"


//
// libaray for basis conversion
// computation unit: 1 bit
//



void bc_1_256( uint32_t *poly , unsigned n_256bit );

void ibc_1_256( uint32_t *poly , unsigned n_256bit );


/////////////////////////////////////////


void bc_1_16384( uint32_t *poly );

void ibc_1_16384( uint32_t *poly );


void bc_1_32768( uint32_t *poly );

void ibc_1_32768( uint32_t *poly );


void bc_1_65536( uint32_t *poly );

void ibc_1_65536( uint32_t *poly );






#endif
