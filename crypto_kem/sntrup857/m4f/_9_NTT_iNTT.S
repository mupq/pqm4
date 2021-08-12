
#include "macros.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_9_ntt
.type __asm_9_ntt, %function
__asm_9_ntt:
    push {r4-r12, lr}
    vpush {s16-s31}

    vldm r1, {s4-s12}

    .equ unit, 3

    vmov.w s0, r0

#ifdef LOOP
    add.w r12, r0, #6912
    vmov.w s2, r12
    _9_ntt:
#else
.rept 32
#endif

#ifdef LOOP
    add.w r14, r0, #12
    vmov.w s3, r14
    _9_ntt_inner:
#else
.rept 3
#endif

    ldr.w r5, [r0, #4*unit*1+108]
    ldr.w r6, [r0, #4*unit*2+108]
    ldr.w r8, [r0, #4*unit*4+108]
    ldr.w r9, [r0, #4*unit*5+108]
    ldr.w r11, [r0, #4*unit*7+108]
    ldr.w r12, [r0, #4*unit*8+108]

    vmov.w r4, r7, s7, s8
    vmov.w r10, s9

    smull r0, r14, r5, r4
    smlal r0, r14, r8, r7
    smlal r0, r14, r11, r10
    mul r1, r0, r2
    smlal r0, r14, r1, r3

    smull r0, r7, r6, r7
    smlal r0, r7, r9, r4
    smlal r0, r7, r12, r10
    mul r1, r0, r2
    smlal r0, r7, r1, r3

    vmov.w s25, r7

    vmov.w r4, s10
    smull r0, r1, r5, r4
    smull r7, r4, r6, r4
    vmov.w r10, s11
    smlal r0, r1, r11, r10
    smlal r7, r4, r9, r10
    vmov.w r10, s12
    smlal r0, r1, r8, r10
    smlal r7, r4, r12, r10

    add r5, r8
    add r5, r11
    add r6, r9
    add r6, r12

    mul r8, r0, r2
    smlal r0, r1, r8, r3
    mul r8, r7, r2
    smlal r7, r4, r8, r3

    vmov.w s26, r1

    // (r5, r14, s26, r6, r4, s25) = (a1_, a4_, a7_, a2_, a5_, a8_)
    // free: (r0, r1, r7, r8, r9, r10, r11, r12)

    vmov.w r0, s0

    ldr.w r7, [r0, #4*unit*0+108]
    ldr.w r8, [r0, #4*unit*3+108]
    ldr.w r9, [r0, #4*unit*6+108]

    vmov.w r0, r1, s5, s6

    _3_ntt r7, r8, r9, r0, r1, r2, r3, r11, r12

    _3_ntt r7, r5, r6, r0, r1, r2, r3, r11, r12

    _3_ntt r8, r14, r4, r0, r1, r2, r3, r11, r12

    vmov.w r11, r10, s25, s26

    smull r0, r12, r10, r0
    smlal r0, r12, r11, r1
    mul r1, r0, r2
    smlal r0, r12, r1, r3

    add.w r10, r10, r11
    add.w r11, r12, r10

    add.w r12, r9
    rsb.w r11, r9

    add.w r10, r10, r9

    // (r7, r5, r6, r8, r14, r4, r10, r12, r11) = (a0__, a1__, a2__, a3__, a4__, a5__, a6__, a7__, a8__)

    vmov.w r0, s0
    str r5, [r0, #4*unit*1+108]
    str r6, [r0, #4*unit*2+108]
    str.w r8, [r0, #4*unit*3+108]
    str.w r14, [r0, #4*unit*4+108]
    str.w r4, [r0, #4*unit*5+108]
    str.w r10, [r0, #4*unit*6+108]
    str.w r12, [r0, #4*unit*7+108]
    str.w r11, [r0, #4*unit*8+108]
    str.w r7, [r0, #4*unit*0+108]

    ldr.w r5, [r0, #4*unit*1]
    ldr.w r6, [r0, #4*unit*2]
    ldr.w r8, [r0, #4*unit*4]
    ldr.w r9, [r0, #4*unit*5]
    ldr.w r11, [r0, #4*unit*7]
    ldr.w r12, [r0, #4*unit*8]

    vmov.w r4, r7, s7, s8
    vmov.w r10, s9

    smull r0, r14, r5, r4
    smlal r0, r14, r8, r7
    smlal r0, r14, r11, r10
    mul r1, r0, r2
    smlal r0, r14, r1, r3

    smull r0, r7, r6, r7
    smlal r0, r7, r9, r4
    smlal r0, r7, r12, r10
    mul r1, r0, r2
    smlal r0, r7, r1, r3

    vmov.w s25, r7

    vmov.w r4, s10
    smull r0, r1, r5, r4
    smull r7, r4, r6, r4
    vmov.w r10, s11
    smlal r0, r1, r11, r10
    smlal r7, r4, r9, r10
    vmov.w r10, s12
    smlal r0, r1, r8, r10
    smlal r7, r4, r12, r10

    add r5, r8
    add r5, r11
    add r6, r9
    add r6, r12

    mul r8, r0, r2
    smlal r0, r1, r8, r3
    mul r8, r7, r2
    smlal r7, r4, r8, r3

    vmov.w s26, r1

    // (r5, r14, s26, r6, r4, s25) = (a1_, a4_, a7_, a2_, a5_, a8_)
    // free: (r0, r1, r7, r8, r9, r10, r11, r12)

    vmov.w r0, s0

    ldr.w r7, [r0, #4*unit*0]
    ldr.w r8, [r0, #4*unit*3]
    ldr.w r9, [r0, #4*unit*6]

    vmov.w r0, r1, s5, s6

    _3_ntt r7, r8, r9, r0, r1, r2, r3, r11, r12

    _3_ntt r7, r5, r6, r0, r1, r2, r3, r11, r12

    _3_ntt r8, r14, r4, r0, r1, r2, r3, r11, r12

    vmov.w r11, r10, s25, s26

    smull r0, r12, r10, r0
    smlal r0, r12, r11, r1
    mul r1, r0, r2
    smlal r0, r12, r1, r3

    add.w r10, r10, r11
    add.w r11, r12, r10

    add.w r12, r9
    rsb.w r11, r9

    add.w r10, r10, r9

    // (r7, r5, r6, r8, r14, r4, r10, r12, r11) = (a0__, a1__, a2__, a3__, a4__, a5__, a6__, a7__, a8__)

    vmov.w r0, s0
    str r5, [r0, #4*unit*1]
    str r6, [r0, #4*unit*2]
    str.w r8, [r0, #4*unit*3]
    str.w r14, [r0, #4*unit*4]
    str.w r4, [r0, #4*unit*5]
    str.w r10, [r0, #4*unit*6]
    str.w r12, [r0, #4*unit*7]
    str.w r11, [r0, #4*unit*8]
    str.w r7, [r0], #4
    vmov.w s0, r0

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _9_ntt_inner
#else
.endr
#endif

    add.w r0, r0, #204
    vmov.w s0, r0

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _9_ntt
#else
.endr
#endif

    vpop {s16-s31}
    pop {r4-r12, pc}


.align 2
.global __asm_9_intt
.type __asm_9_intt, %function
__asm_9_intt:
    push {r4-r12, lr}
    vpush {s16-s31}

    vldm r1, {s4-s12}

    .equ unit, 3

    vmov.w s0, r0

#ifdef LOOP
    add.w r12, r0, #6912
    vmov.w s2, r12
    _9_intt:
#else
.rept 32
#endif

#ifdef LOOP
    add.w r14, r0, #12
    vmov.w s3, r14
    _9_intt_inner:
#else
.rept 3
#endif

    ldr.w r5, [r0, #4*unit*3+108]
    ldr.w r6, [r0, #4*unit*6+108]
    ldr.w r8, [r0, #4*unit*4+108]
    ldr.w r9, [r0, #4*unit*7+108]
    ldr.w r11, [r0, #4*unit*5+108]
    ldr.w r12, [r0, #4*unit*8+108]

    vmov.w r4, r7, s7, s8
    vmov.w r10, s9

    smull r0, r14, r5, r4
    smlal r0, r14, r8, r7
    smlal r0, r14, r11, r10
    mul r1, r0, r2
    smlal r0, r14, r1, r3

    smull r0, r7, r6, r7
    smlal r0, r7, r9, r4
    smlal r0, r7, r12, r10
    mul r1, r0, r2
    smlal r0, r7, r1, r3

    vmov.w s25, r7

    vmov.w r4, s10
    smull r0, r1, r5, r4
    smull r7, r4, r6, r4
    vmov.w r10, s11
    smlal r0, r1, r11, r10
    smlal r7, r4, r9, r10
    vmov.w r10, s12
    smlal r0, r1, r8, r10
    smlal r7, r4, r12, r10

    add r5, r8
    add r5, r11
    add r6, r9
    add r6, r12

    mul r8, r0, r2
    smlal r0, r1, r8, r3
    mul r8, r7, r2
    smlal r7, r4, r8, r3

    vmov.w s26, r1

    // (r5, r14, s26, r6, r4, s25) = (a1_, a4_, a7_, a2_, a5_, a8_)
    // free: (r0, r1, r7, r8, r9, r10, r11, r12)

    vmov.w r0, s0

    ldr.w r7, [r0, #4*unit*0+108]
    ldr.w r8, [r0, #4*unit*1+108]
    ldr.w r9, [r0, #4*unit*2+108]

    vmov.w r0, r1, s5, s6

    _3_ntt r7, r8, r9, r0, r1, r2, r3, r11, r12

    _3_ntt r7, r5, r6, r0, r1, r2, r3, r11, r12

    _3_ntt r8, r14, r4, r0, r1, r2, r3, r11, r12

    vmov.w r11, r10, s25, s26

    smull r0, r12, r10, r0
    smlal r0, r12, r11, r1
    mul r1, r0, r2
    smlal r0, r12, r1, r3

    add.w r10, r10, r11
    add.w r11, r12, r10

    add.w r12, r9
    rsb.w r11, r9

    add.w r10, r10, r9

    // (r7, r5, r6, r8, r14, r4, r10, r12, r11) = (a0__, a1__, a2__, a3__, a4__, a5__, a6__, a7__, a8__)

    vmov.w r0, s0
    str r5, [r0, #4*unit*3+108]
    str r6, [r0, #4*unit*6+108]
    str.w r8, [r0, #4*unit*1+108]
    str.w r14, [r0, #4*unit*4+108]
    str.w r4, [r0, #4*unit*7+108]
    str.w r10, [r0, #4*unit*2+108]
    str.w r12, [r0, #4*unit*5+108]
    str.w r11, [r0, #4*unit*8+108]
    str.w r7, [r0, #4*unit*0+108]

    ldr.w r5, [r0, #4*unit*3]
    ldr.w r6, [r0, #4*unit*6]
    ldr.w r8, [r0, #4*unit*4]
    ldr.w r9, [r0, #4*unit*7]
    ldr.w r11, [r0, #4*unit*5]
    ldr.w r12, [r0, #4*unit*8]

    vmov.w r4, r7, s7, s8
    vmov.w r10, s9

    smull r0, r14, r5, r4
    smlal r0, r14, r8, r7
    smlal r0, r14, r11, r10
    mul r1, r0, r2
    smlal r0, r14, r1, r3

    smull r0, r7, r6, r7
    smlal r0, r7, r9, r4
    smlal r0, r7, r12, r10
    mul r1, r0, r2
    smlal r0, r7, r1, r3

    vmov.w s25, r7

    vmov.w r4, s10
    smull r0, r1, r5, r4
    smull r7, r4, r6, r4
    vmov.w r10, s11
    smlal r0, r1, r11, r10
    smlal r7, r4, r9, r10
    vmov.w r10, s12
    smlal r0, r1, r8, r10
    smlal r7, r4, r12, r10

    add r5, r8
    add r5, r11
    add r6, r9
    add r6, r12

    mul r8, r0, r2
    smlal r0, r1, r8, r3
    mul r8, r7, r2
    smlal r7, r4, r8, r3

    vmov.w s26, r1

    // (r5, r14, s26, r6, r4, s25) = (a1_, a4_, a7_, a2_, a5_, a8_)
    // free: (r0, r1, r7, r8, r9, r10, r11, r12)

    vmov.w r0, s0

    ldr.w r7, [r0, #4*unit*0]
    ldr.w r8, [r0, #4*unit*1]
    ldr.w r9, [r0, #4*unit*2]

    vmov.w r0, r1, s5, s6

    _3_ntt r7, r8, r9, r0, r1, r2, r3, r11, r12

    _3_ntt r7, r5, r6, r0, r1, r2, r3, r11, r12

    _3_ntt r8, r14, r4, r0, r1, r2, r3, r11, r12

    vmov.w r11, r10, s25, s26

    smull r0, r12, r10, r0
    smlal r0, r12, r11, r1
    mul r1, r0, r2
    smlal r0, r12, r1, r3

    add.w r10, r10, r11
    add.w r11, r12, r10

    add.w r12, r9
    rsb.w r11, r9

    add.w r10, r10, r9

    // (r7, r5, r6, r8, r14, r4, r10, r12, r11) = (a0__, a1__, a2__, a3__, a4__, a5__, a6__, a7__, a8__)

    vmov.w r0, s0
    str r5, [r0, #4*unit*3]
    str r6, [r0, #4*unit*6]
    str.w r8, [r0, #4*unit*1]
    str.w r14, [r0, #4*unit*4]
    str.w r4, [r0, #4*unit*7]
    str.w r10, [r0, #4*unit*2]
    str.w r12, [r0, #4*unit*5]
    str.w r11, [r0, #4*unit*8]
    str.w r7, [r0], #4
    vmov.w s0, r0

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _9_intt_inner
#else
.endr
#endif

    add.w r0, r0, #204
    vmov.w s0, r0

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _9_intt
#else
.endr
#endif

    vpop {s16-s31}
    pop {r4-r12, pc}










