// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain

#ifndef _ROTR_CSHIFT_H_
#define _ROTR_CSHIFT_H_

#include "stdint.h"


#define SIZE_MEMORY_CSHIFT_12323 772

#define SIZE_MEMORY_CSHIFT_24659 1542


void cshift(uint32_t *array1, int s);

void rotr_cshift(uint32_t *array1, const uint32_t *array0, int s);

void rotr_cshift_prepare(uint32_t *array);


#endif
