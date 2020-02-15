#ifndef VERIFY_H
#define VERIFY_H

#include <stdio.h>

/* b = 1 means mov, b = 0 means don't mov*/
void cmov(unsigned char *r, const unsigned char *x, size_t len, unsigned char b);

#endif
