#include "randombytes.h"
#include "em_chip.h"
#include "em_device.h"

int randombytes(uint8_t *buf, size_t len)
{
    union
    {
        uint8_t aschar[4];
        uint32_t asint;
    } random;

    while (len > 4)
    {
        while (!TRNG0->FIFOLEVEL)
            ;
        random.asint = TRNG0->FIFO;
        *buf++ = random.aschar[0];
        *buf++ = random.aschar[1];
        *buf++ = random.aschar[2];
        *buf++ = random.aschar[3];
        len -= 4;
    }
    if (len > 0)
    {
        while (!TRNG0->FIFOLEVEL)
            ;
        random.asint = TRNG0->FIFO;
        for (; len > 0; len--)
        {
            *buf++ = random.aschar[len - 1];
        }
    }
    return 0;
}