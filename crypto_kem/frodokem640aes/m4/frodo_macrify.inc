/********************************************************************************************
* FrodoKEM: Learning with Errors Key Encapsulation
*
* Abstract: matrix arithmetic functions used by the KEM
*********************************************************************************************/

#include "aes.h"

uint16_t xs(const uint16_t *s, const uint16_t *a_row)
{

  uint16_t result;

    asm volatile (
    "mov %[r], #0;"
    "ldr r10, %[s];"
    "ldr r11, %[a];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    "ldmia r10!, {r0, r1, r2, r3, r4};"
    "ldmia r11!, {r5, r6, r7, r8, r9};"
    "smlad %[r], r0, r5, %[r];"
    "smlad %[r], r1, r6, %[r];"
    "smlad %[r], r2, r7, %[r];"
    "smlad %[r], r3, r8, %[r];"
    "smlad %[r], r4, r9, %[r];"
    : [r]"=r"(result)
    : [s]"m"(s), [a]"m"(a_row)
    : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "cc", "memory"
    );

  return result;
}

int frodo_mul_add_as_plus_e(uint16_t *out, const uint16_t *s, const uint8_t *seed_A) 
{ // Generate-and-multiply: generate matrix A (N x N) row-wise, multiply by s on the right.
  // Inputs: s, e (N x N_BAR)
  // Output: out = A*s + e (N x N_BAR)

    int i, j, k;
    uint16_t a_row[4*PARAMS_N] = {0}; 
    
    int16_t a_row_temp[4*PARAMS_N] = {0};
    aes128ctx roundkeys;

    aes128_keyexp(&roundkeys, seed_A);
                                     
    for (j = 0; j < PARAMS_N; j += PARAMS_STRIPE_STEP) {
        a_row_temp[j + 1 + 0*PARAMS_N] = j;                     // Loading values in the little-endian order
        a_row_temp[j + 1 + 1*PARAMS_N] = j;
        a_row_temp[j + 1 + 2*PARAMS_N] = j;
        a_row_temp[j + 1 + 3*PARAMS_N] = j;
    }

    for (i = 0; i < PARAMS_N; i += 4) {
		
        for (j = 0; j < PARAMS_N; j += PARAMS_STRIPE_STEP) {    // Go through A, four rows at a time
            a_row_temp[j + 0*PARAMS_N] = i+0; // Loading values in the little-endian order                                
            a_row_temp[j + 1*PARAMS_N] = i+1;
            a_row_temp[j + 2*PARAMS_N] = i+2;
            a_row_temp[j + 3*PARAMS_N] = i+3;
        }

        aes128_ecb((unsigned char *)a_row, (unsigned char *)a_row_temp, 4*PARAMS_N*sizeof(int16_t) / AES_BLOCKBYTES, &roundkeys);
		
        for (k = 0; k < PARAMS_NBAR; k++) {
          out[k + (i + 0)*PARAMS_NBAR] += xs(s + k*PARAMS_N,a_row + 0*PARAMS_N);
          out[k + (i + 1)*PARAMS_NBAR] += xs(s + k*PARAMS_N,a_row + 1*PARAMS_N);
          out[k + (i + 2)*PARAMS_NBAR] += xs(s + k*PARAMS_N,a_row + 2*PARAMS_N);
          out[k + (i + 3)*PARAMS_NBAR] += xs(s + k*PARAMS_N,a_row + 3*PARAMS_N);
        }
    }

    
    return 1;
}


int frodo_mul_add_sa_plus_e(uint16_t *out, const uint16_t *s, const uint8_t *seed_A)
{ // Generate-and-multiply: generate matrix A (N x N) column-wise, multiply by s' on the left.
  // Inputs: s', e' (N_BAR x N)
  // Output: out = s'*A + e' (N_BAR x N)

    int i, j, kk;

    uint16_t a_cols[PARAMS_N*PARAMS_STRIPE_STEP] = {0};
    uint16_t a_cols_temp[PARAMS_N*PARAMS_STRIPE_STEP] = {0};       

    aes128ctx roundkeys;
    aes128_keyexp(&roundkeys, seed_A);

    for (i = 0, j = 0; i < PARAMS_N; i++, j += PARAMS_STRIPE_STEP) {
        a_cols_temp[j] = i; // Loading values in the little-endian order
    }

    for (kk = 0; kk < PARAMS_N; kk += PARAMS_STRIPE_STEP) {
		
        for (i = 0; i < (PARAMS_N*PARAMS_STRIPE_STEP); i += PARAMS_STRIPE_STEP) {
            a_cols_temp[i + 1] = kk; // Loading values in the little-endian order
        }
        
        aes128_ecb((unsigned char *)a_cols, (unsigned char *)a_cols_temp, PARAMS_N*PARAMS_STRIPE_STEP*sizeof(int16_t) / AES_BLOCKBYTES, &roundkeys);
		
        for (i = 0; i < PARAMS_N; i += 8) {
        for (j = 0; j < PARAMS_STRIPE_STEP; j++) {

          asm volatile (
          // Load a
          "ldrh r1, [%[a], #0];"
          "ldrh r5, [%[a], #16];"
          "bfi r1, r5, #16, #16;"
          "ldrh r2, [%[a], #32];"
          "ldrh r5, [%[a], #48];"
          "bfi r2, r5, #16, #16;"
          "ldrh r3, [%[a], #64];"
          "ldrh r5, [%[a], #80];"
          "bfi r3, r5, #16, #16;"
          "ldrh r4, [%[a], #96];"
          "ldrh r5, [%[a], #112];"
          "bfi r4, r5, #16, #16;"
          "mov r0, %[s];"
          "mov r9, %[o];"
          // First row
          "ldmia r0, {r5,r6,r7,r8};"
          "ldrh r10, [r9, #0];"
          "smlad r10, r1, r5, r10;"
          "smlad r10, r2, r6, r10;"
          "smlad r10, r3, r7, r10;"
          "smlad r10, r4, r8, r10;"
          "strh r10, [r9, #0];"
          // Second row
          "add r0, r0, #1280;"
          "ldmia r0, {r5,r6,r7,r8};"
          "ldrh r10, [r9, #1280];"
          "smlad r10, r1, r5, r10;"
          "smlad r10, r2, r6, r10;"
          "smlad r10, r3, r7, r10;"
          "smlad r10, r4, r8, r10;"
          "strh r10, [r9, #1280];"
          // Third row
          "add r0, r0, #1280;"
          "ldmia r0, {r5,r6,r7,r8};"
          "ldrh r10, [r9, #2560];"
          "smlad r10, r1, r5, r10;"
          "smlad r10, r2, r6, r10;"
          "smlad r10, r3, r7, r10;"
          "smlad r10, r4, r8, r10;"
          "strh r10, [r9, #2560];"
          // Fourth row
          "add r0, r0, #1280;"
          "ldmia r0, {r5,r6,r7,r8};"
          "ldrh r10, [r9, #3840];"
          "smlad r10, r1, r5, r10;"
          "smlad r10, r2, r6, r10;"
          "smlad r10, r3, r7, r10;"
          "smlad r10, r4, r8, r10;"
          "strh r10, [r9, #3840];"
          "add r9, r9, #5120;"
          // Fifth row
          "add r0, r0, #1280;"
          "ldmia r0, {r5,r6,r7,r8};"
          "ldrh r10, [r9, #0];"
          "smlad r10, r1, r5, r10;"
          "smlad r10, r2, r6, r10;"
          "smlad r10, r3, r7, r10;"
          "smlad r10, r4, r8, r10;"
          "strh r10, [r9, #0];"
          // Sixth row
          "add r0, r0, #1280;"
          "ldmia r0, {r5,r6,r7,r8};"
          "ldrh r10, [r9, #1280];"
          "smlad r10, r1, r5, r10;"
          "smlad r10, r2, r6, r10;"
          "smlad r10, r3, r7, r10;"
          "smlad r10, r4, r8, r10;"
          "strh r10, [r9, #1280];"
          // Seventh row
          "add r0, r0, #1280;"
          "ldmia r0, {r5,r6,r7,r8};"
          "ldrh r10, [r9, #2560];"
          "smlad r10, r1, r5, r10;"
          "smlad r10, r2, r6, r10;"
          "smlad r10, r3, r7, r10;"
          "smlad r10, r4, r8, r10;"
          "strh r10, [r9, #2560];"
          // Eight row
          "add r0, r0, #1280;"
          "ldmia r0, {r5,r6,r7,r8};"
          "ldrh r10, [r9, #3840];"
          "smlad r10, r1, r5, r10;"
          "smlad r10, r2, r6, r10;"
          "smlad r10, r3, r7, r10;"
          "smlad r10, r4, r8, r10;"
          "strh r10, [r9, #3840];"
          :
          : [s]"r"(s+i), [a]"r"(a_cols+i*PARAMS_STRIPE_STEP+j), [o]"r"(out+kk+j)
          : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "cc", "memory"
          );
        }}
    }

  
    return 1;
}


void frodo_mul_bs(uint16_t *out, const uint16_t *b, const uint16_t *s) 
{ // Multiply by s on the right
  // Inputs: b (N_BAR x N), s (N x N_BAR)
  // Output: out = b*s (N_BAR x N_BAR)

    int i;

    for (i = 0; i < PARAMS_NBAR; i++) {
        out[i*PARAMS_NBAR + 0] = xs(b + i*PARAMS_N, s + 0*PARAMS_N);
        out[i*PARAMS_NBAR + 1] = xs(b + i*PARAMS_N, s + 1*PARAMS_N);
        out[i*PARAMS_NBAR + 2] = xs(b + i*PARAMS_N, s + 2*PARAMS_N);
        out[i*PARAMS_NBAR + 3] = xs(b + i*PARAMS_N, s + 3*PARAMS_N);
        out[i*PARAMS_NBAR + 4] = xs(b + i*PARAMS_N, s + 4*PARAMS_N);
        out[i*PARAMS_NBAR + 5] = xs(b + i*PARAMS_N, s + 5*PARAMS_N);
        out[i*PARAMS_NBAR + 6] = xs(b + i*PARAMS_N, s + 6*PARAMS_N);
        out[i*PARAMS_NBAR + 7] = xs(b + i*PARAMS_N, s + 7*PARAMS_N);
    }

}

void sb(const uint16_t *s, const uint16_t *a, uint16_t *out)
{

  asm volatile (
  // Load a
  "ldrh r1, [%[a], #0];"
  "ldrh r5, [%[a], #16];"
  "bfi r1, r5, #16, #16;"
  "ldrh r2, [%[a], #32];"
  "ldrh r5, [%[a], #48];"
  "bfi r2, r5, #16, #16;"
  "ldrh r3, [%[a], #64];"
  "ldrh r5, [%[a], #80];"
  "bfi r3, r5, #16, #16;"
  "ldrh r4, [%[a], #96];"
  "ldrh r5, [%[a], #112];"
  "bfi r4, r5, #16, #16;"
  "mov r0, %[s];"
  "mov r9, %[o];"
  // First row
  "ldmia r0, {r5,r6,r7,r8};"
  "ldrh r10, [r9, #0];"
  "smlad r10, r1, r5, r10;"
  "smlad r10, r2, r6, r10;"
  "smlad r10, r3, r7, r10;"
  "smlad r10, r4, r8, r10;"
  "strh r10, [r9, #0];"
  // Second row
  "add r0, r0, #1280;"
  "ldmia r0, {r5,r6,r7,r8};"
  "ldrh r10, [r9, #16];"
  "smlad r10, r1, r5, r10;"
  "smlad r10, r2, r6, r10;"
  "smlad r10, r3, r7, r10;"
  "smlad r10, r4, r8, r10;"
  "strh r10, [r9, #16];"
  // Third row
  "add r0, r0, #1280;"
  "ldmia r0, {r5,r6,r7,r8};"
  "ldrh r10, [r9, #32];"
  "smlad r10, r1, r5, r10;"
  "smlad r10, r2, r6, r10;"
  "smlad r10, r3, r7, r10;"
  "smlad r10, r4, r8, r10;"
  "strh r10, [r9, #32];"
  // Fourth row
  "add r0, r0, #1280;"
  "ldmia r0, {r5,r6,r7,r8};"
  "ldrh r10, [r9, #48];"
  "smlad r10, r1, r5, r10;"
  "smlad r10, r2, r6, r10;"
  "smlad r10, r3, r7, r10;"
  "smlad r10, r4, r8, r10;"
  "strh r10, [r9, #48];"
  "add r9, r9, #64;"
  // Fifth row
  "add r0, r0, #1280;"
  "ldmia r0, {r5,r6,r7,r8};"
  "ldrh r10, [r9, #0];"
  "smlad r10, r1, r5, r10;"
  "smlad r10, r2, r6, r10;"
  "smlad r10, r3, r7, r10;"
  "smlad r10, r4, r8, r10;"
  "strh r10, [r9, #0];"
  // Sixth row
  "add r0, r0, #1280;"
  "ldmia r0, {r5,r6,r7,r8};"
  "ldrh r10, [r9, #16];"
  "smlad r10, r1, r5, r10;"
  "smlad r10, r2, r6, r10;"
  "smlad r10, r3, r7, r10;"
  "smlad r10, r4, r8, r10;"
  "strh r10, [r9, #16];"
  // Seventh row
  "add r0, r0, #1280;"
  "ldmia r0, {r5,r6,r7,r8};"
  "ldrh r10, [r9, #32];"
  "smlad r10, r1, r5, r10;"
  "smlad r10, r2, r6, r10;"
  "smlad r10, r3, r7, r10;"
  "smlad r10, r4, r8, r10;"
  "strh r10, [r9, #32];"
  // Eight row
  "add r0, r0, #1280;"
  "ldmia r0, {r5,r6,r7,r8};"
  "ldrh r10, [r9, #48];"
  "smlad r10, r1, r5, r10;"
  "smlad r10, r2, r6, r10;"
  "smlad r10, r3, r7, r10;"
  "smlad r10, r4, r8, r10;"
  "strh r10, [r9, #48];"
  :
  : [s]"r"(s), [a]"r"(a), [o]"r"(out)
  : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "cc", "memory"
  );
}


void frodo_mul_add_sb_plus_e(uint16_t *out, const uint16_t *b, const uint16_t *s) 
{ // Multiply by s on the left
  // Inputs: b (N x N_BAR), s (N_BAR x N), e (N_BAR x N_BAR)
  // Output: out = s*b + e (N_BAR x N_BAR)

  for (int k = 0; k < PARAMS_N; k+=8) {
    sb(s+k,b + k*PARAMS_NBAR+0,out+0);
    sb(s+k,b + k*PARAMS_NBAR+1,out+1);
    sb(s+k,b + k*PARAMS_NBAR+2,out+2);
    sb(s+k,b + k*PARAMS_NBAR+3,out+3);
    sb(s+k,b + k*PARAMS_NBAR+4,out+4);
    sb(s+k,b + k*PARAMS_NBAR+5,out+5);
    sb(s+k,b + k*PARAMS_NBAR+6,out+6);
    sb(s+k,b + k*PARAMS_NBAR+7,out+7);
  }
}

void frodo_add(uint16_t *out, const uint16_t *a, const uint16_t *b) 
{ // Add a and b
  // Inputs: a, b (N_BAR x N_BAR)
  // Output: c = a + b

    for (int i = 0; i < (PARAMS_NBAR*PARAMS_NBAR); i++) {
        out[i] = (a[i] + b[i]) & ((1<<PARAMS_LOGQ)-1);
    }
}


void frodo_sub(uint16_t *out, const uint16_t *a, const uint16_t *b) 
{ // Subtract a and b
  // Inputs: a, b (N_BAR x N_BAR)
  // Output: c = a - b

    for (int i = 0; i < (PARAMS_NBAR*PARAMS_NBAR); i++) {
        out[i] = (a[i] - b[i]) & ((1<<PARAMS_LOGQ)-1);
    }
}


void frodo_key_encode(uint16_t *out, const uint16_t *in) 
{ // Encoding
    unsigned int i, j, npieces_word = 8;
    unsigned int nwords = (PARAMS_NBAR*PARAMS_NBAR)/8;
    uint64_t temp, mask = ((uint64_t)1 << PARAMS_EXTRACTED_BITS) - 1;
    uint16_t* pos = out;

    for (i = 0; i < nwords; i++) {
        temp = 0;
        for(j = 0; j < PARAMS_EXTRACTED_BITS; j++) 
            temp |= ((uint64_t)((uint8_t*)in)[i*PARAMS_EXTRACTED_BITS + j]) << (8*j);
        for (j = 0; j < npieces_word; j++) { 
            *pos = (temp & mask) << (PARAMS_LOGQ - PARAMS_EXTRACTED_BITS);  
            temp >>= PARAMS_EXTRACTED_BITS;
            pos++;
        }
    }
}


void frodo_key_decode(uint16_t *out, const uint16_t *in)
{ // Decoding
    unsigned int i, j, index = 0, npieces_word = 8;
    unsigned int nwords = (PARAMS_NBAR * PARAMS_NBAR) / 8;
    uint16_t temp, maskex=((uint16_t)1 << PARAMS_EXTRACTED_BITS) -1, maskq =((uint16_t)1 << PARAMS_LOGQ) -1;
    uint8_t  *pos = (uint8_t*)out;
    uint64_t templong;

    for (i = 0; i < nwords; i++) {
        templong = 0;
        for (j = 0; j < npieces_word; j++) {  // temp = floor(in*2^{-11}+0.5)
            temp = ((in[index] & maskq) + (1 << (PARAMS_LOGQ - PARAMS_EXTRACTED_BITS - 1))) >> (PARAMS_LOGQ - PARAMS_EXTRACTED_BITS);
            templong |= ((uint64_t)(temp & maskex)) << (PARAMS_EXTRACTED_BITS * j);
            index++;
        }
	for(j = 0; j < PARAMS_EXTRACTED_BITS; j++) 
	    pos[i*PARAMS_EXTRACTED_BITS + j] = (templong >> (8*j)) & 0xFF;
    }
}
