/**
 * @file memset.h
 * @brief Header file for memset.c
 */

#ifndef PERK_CRYPTO_MEMSET_H
#define PERK_CRYPTO_MEMSET_H

#include <stddef.h>

/**
 * safer call to memset https://github.com/veorq/cryptocoding#problem-4
 */
extern void *(*volatile memset_volatile)(void *, int, size_t);

#define memset_zero(ptr, len) memset_volatile((ptr), 0, (len))

#endif  // PERK_CRYPTO_MEMSET_H
