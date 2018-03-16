#include <stdint.h>
#include <libopencm3/stm32/rng.h>
#include "randombytes.h"

//TODO Maybe we do not want to use the hardware RNG for all randomness, but instead only read a seed and then expand that using fips202.

void randombytes(unsigned char *x,unsigned long long xlen)
{
    union
    {
        unsigned char aschar[4];
        uint32_t asint;
    } random;

    while (xlen > 4)
    {
        random.asint = rng_get_random_blocking();
        *x++ = random.aschar[0];
        *x++ = random.aschar[1];
        *x++ = random.aschar[2];
        *x++ = random.aschar[3];
        xlen -= 4;
    }
    if (xlen > 0)
    {
        for (random.asint = rng_get_random_blocking(); xlen > 0; --xlen)
        {
            *x++ = random.aschar[xlen - 1];
        }
    }
}
