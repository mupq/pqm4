//  sneik_f512_armv7_fast.S
//  2019-02-06  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (C) 2019, PQShield Ltd. Please see LICENSE.

#include "round5_variant_setting.h"

#ifdef BLNK2

//  SNEIK f512 v1.1 implementation for ARMv7 (including ARMv7-m), fully unrolled

//  C prototype: void sneik_f512(void *state, uint8_t dom, uint8_t rounds);

        .text
        .global sneik_f512
        .syntax unified
        .type   sneik_f512, %function

//  mixing function for 4 rotating registers (r3 is temporary)

.macro  mix_f   pos, t0, t1, t2, t3
        add     \t0, \t0, \t3               // t0 += t3;
        eor     r3,  \t0, \t0, ror #8       // t0 = t0 ^ ROR32(t0, 8)
        eor     \t0, r3,  \t0, ror #7       //         ^ ROR32(t0, 7);
        eor     \t0, \t0, \t2, ror #31      // t0 ^= ROR32(t2, 31);
        ldr     \t2, [r0, #4*((\pos + 2) % 16)] // t2 = vec[(pos + 2) & 0xF];
        add     \t0, \t0, \t2               // t0 += t2;
        eor     r3,  \t0, \t0, ror #8       // t0 = t0 ^ ROR32(t0, 15)
        eor     \t0, \t0, r3,  ror #15      //         ^ ROR32(t0, 23);
        eor     \t0, \t0, \t1               // t0 ^= t1
        str     \t0, [r0, #4*\pos]          // vec[pos] = t0;
        .endm

sneik_f512:

        push    {r4, r5, r6, r7}
        ldr     ip, .rcptr                  // table of round constants
        ldr     r4, [r0]
        ldr     r5, [r0, #4*1]
        ldr     r6, [r0, #4*14]
        ldr     r7, [r0, #4*15]

.round:
        ldrb    r3, [ip], #1                // round constant
        eor     r4, r4, r3
        eor     r5, r5, r1                  // domain
        mix_f   0,  r4, r5, r6, r7
        mix_f   1,  r5, r6, r7, r4
        mix_f   2,  r6, r7, r4, r5
        mix_f   3,  r7, r4, r5, r6
        mix_f   4,  r4, r5, r6, r7
        mix_f   5,  r5, r6, r7, r4
        mix_f   6,  r6, r7, r4, r5
        mix_f   7,  r7, r4, r5, r6
        mix_f   8,  r4, r5, r6, r7
        mix_f   9,  r5, r6, r7, r4
        mix_f   10, r6, r7, r4, r5
        mix_f   11, r7, r4, r5, r6
        mix_f   12, r4, r5, r6, r7
        mix_f   13, r5, r6, r7, r4
        mix_f   14, r6, r7, r4, r5
        mix_f   15, r7, r4, r5, r6

        subs    r2, r2, #1                  // loop
        bne     .round

        pop     {r4, r5, r6, r7}
        bx      lr

        .align  2
.rcptr: .word   .rc

        .size       sneik_f512, .-sneik_f512 + 8
        .section    .rodata

.rc:    .byte   0xEF, 0xE0, 0xD9, 0xD6, 0xBA, 0xB5, 0x8C, 0x83
        .byte   0x10, 0x1F, 0x26, 0x29, 0x45, 0x4A, 0x73, 0x7C

#endif /* BLNK2 */

