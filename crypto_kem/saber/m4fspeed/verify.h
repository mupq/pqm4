#ifndef VERIFY_H
#define VERIFY_H

#include <stddef.h>
#include <stdint.h>

/* b = 1 means mov, b = 0 means don't mov*/
void cmov(uint8_t *r, const uint8_t *x, size_t len, uint8_t b);

#endif
