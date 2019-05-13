#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "poly_mul.h"

extern void polymul_asm(uint16_t *r, const uint16_t *a, const uint16_t *b);

void pol_mul(uint16_t* a, uint16_t* b, uint16_t* res, uint16_t p, uint32_t n)
{
    uint32_t i;
    uint16_t c[2*n - 1];

    polymul_asm(c, a, b);
    for (i = n; i < 2*n-1; i++){
        res[i - n] = (c[i - n] - c[i]) & (p - 1);
    }
    res[n - 1] = c[n - 1];
}
