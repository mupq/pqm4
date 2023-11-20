#ifndef ARM_SIMD_H
#define ARM_SIMD_H

#include <string.h>
#include <inttypes.h>

typedef uint32_t uint16x2_t;

/**********************************************************************
 * Name:        load_uint16x2_t
 * Description: Loads two consecutive unsigned 16-bit values
 *              into one 32-bit register. We use half_index to
 *              ensure we read from the aligned address 2*half_index.
 *              This function is implemented to avoid typepunning;
 *              it should compile as a single load instruction
 *              for optimization levels -O1 and higher.
 * Arguments:   a: aligned head of the array to read from
 *              half_index: half the index to be read from.
 * Returns:     Two unsigned 16-bit values packed as bottom and 
 *              top part of a 32-bit register value.
 *********************************************************************/
static inline uint16x2_t load_uint16x2_t(const uint16_t a[], size_t half_index){
    uint16x2_t t;
    memcpy(&t, &a[half_index << 1], sizeof(t));
    return t;
}

#endif /* ARM_SIMD_H */
