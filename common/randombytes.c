#include <stdint.h>
#include <libopencm3/stm32/rng.h>
#include "randombytes.h"

//TODO Maybe we do not want to use the hardware RNG for all randomness, but instead only read a seed and then expand that using fips202.

int randombytes(uint8_t *obuf, size_t len)
{
    union
    {
        unsigned char aschar[4];
        uint32_t asint;
    } random;

    while (len > 4)
    {
        random.asint = rng_get_random_blocking();
        *obuf++ = random.aschar[0];
        *obuf++ = random.aschar[1];
        *obuf++ = random.aschar[2];
        *obuf++ = random.aschar[3];
        len -= 4;
    }
    if (len > 0)
    {
        for (random.asint = rng_get_random_blocking(); len > 0; --len)
        {
            *obuf++ = random.aschar[len - 1];
        }
    }

    return 0;
}
