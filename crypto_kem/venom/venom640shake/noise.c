/********************************************************************************************
* FrodoKEM: Learning with Errors Key Encapsulation
*
* Abstract: secret and ephemeral sampling functions
*********************************************************************************************/

#include <stddef.h>
#include <stdint.h>


void frodo_sample_n(uint16_t *s, const size_t n)
{ // Fills vector s with n samples from the centered binomial distribution B_2.
  // Input: pseudo-random 16-bit values passed in s. The input is overwritten by the output.
    for (size_t i = 0; i < n; ++i) {
        uint16_t x = s[i];
        uint16_t a = (x & 0x1u) + ((x >> 1) & 0x1u);
        uint16_t b = ((x >> 2) & 0x1u) + ((x >> 3) & 0x1u);
        s[i] = (uint16_t)(a - b);
    }
}
