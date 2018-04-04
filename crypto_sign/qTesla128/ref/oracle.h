#ifndef ORACLE_H
#define ORACLE_H

#include "params.h"
#include "poly.h"

void random_oracle(unsigned char *c_bin, poly v, const unsigned char *m, unsigned long long mlen);

#endif
