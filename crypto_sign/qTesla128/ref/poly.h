#ifndef POLY_H
#define POLY_H
#include "params.h"
#include <stdint.h>

typedef	int64_t __attribute__ ((aligned(32))) poly[PARAM_N];

/* Interface function prototypes */
void poly_mul(poly result, const poly x, const poly y);
void poly_add(poly result, const poly x, const poly y);
void poly_sub(poly result, const poly x, const poly y);
void poly_uniform(poly a, const unsigned char *seed);
#endif /* POLY_H */
