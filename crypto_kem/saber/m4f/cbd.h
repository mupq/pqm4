#ifndef CBD_H
#define CBD_H

#include "SABER_params.h"
#include <stdint.h>

void cbd(uint16_t s[SABER_N], const uint8_t buf[SABER_POLYCOINBYTES]);

#endif
