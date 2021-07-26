
#include "macros.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_intt_2x3
.type __asm_intt_2x3, %function
__asm_intt_2x3:
    push {r4-r12, lr}

    // omega3_2_RmodM 2774580 = 42 * 2^16 + 22068
    movw r10, #22068
    movt r10, #42

    // omega3_RmodM 475667 = 7 * 2^16 + 16915
    movw r11, #16915
    movt r11, #7


#ifdef LOOP
    add.w r12, r0, #1280
    vmov.w s2, r12
    _2x3:
#else
.rept 64
#endif

.rept 5

    ldr.w r4, [r0, #0]
    ldr.w r7, [r0, #4*320]
    ldr.w r5, [r0, #4*640]
    ldr.w r8, [r1, #0]
    ldr.w r6, [r1, #4*320]
    ldr.w r9, [r1, #4*640]

    add_sub2 r4, r7, r5, r8
    add_sub r6, r9

    _3_ntt r4, r5, r6, r10, r11, r2, r3, r12, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r12, r14

    str.w r6, [r1, #4*320]
    str.w r9, [r1, #4*640]
    str.w r8, [r1], #4
    str.w r7, [r0, #4*320]
    str.w r5, [r0, #4*640]
    str.w r4, [r0], #4

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _2x3
#else
.endr
#endif


    pop {r4-r12, pc}

.align 2
.global __asm_intt
.type __asm_intt, %function
__asm_intt:
    push {r4-r12, lr}

    .equ unit, 5

    add.w r1, r1, #56
    vldm r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #20
    vmov.w s2, r12
    _6_5_4_light:
#else
.rept 5
#endif

    ldrstr4 ldr.w, r0, r8, r5, r10, r7, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit
    _3_layer_GS_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #0*4*unit, #1*4*unit, #2*4*unit, #3*4*unit
    _3_layer_GS_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #1*4*unit, #2*4*unit, #3*4*unit, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit

    ldrstr4 ldr.w, r0, r8, r5, r10, r7, #4*4*unit+2560, #5*4*unit+2560, #6*4*unit+2560, #7*4*unit+2560
    _3_layer_GS_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #0*4*unit+2560, #1*4*unit+2560, #2*4*unit+2560, #3*4*unit+2560
    _3_layer_GS_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit+2560, #1*4*unit+2560, #2*4*unit+2560, #3*4*unit+2560, #4*4*unit+2560, #5*4*unit+2560, #6*4*unit+2560, #7*4*unit+2560

    add.w r0, r0, #5120

    ldrstr4 ldr.w, r0, r8, r5, r10, r7, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit
    _3_layer_GS_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #0*4*unit, #1*4*unit, #2*4*unit, #3*4*unit
    _3_layer_GS_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #1*4*unit, #2*4*unit, #3*4*unit, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit, #4

    sub.w r0, r0, #5120

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _6_5_4_light
#else
.endr
#endif

    add.w r0, r0, #140

#ifdef LOOP
    add.w r12, r0, #2400
    vmov.w s2, r12
    _6_5_4:
#else
.rept 15
#endif

    vmov.w r1, s1
    vldm r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #20
    vmov.w s3, r14
    _6_5_4_inner:
#else
.rept 5
#endif

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #1*4*unit, #2*4*unit, #3*4*unit, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit
    _3_layer_GS_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #1*4*unit, #2*4*unit, #3*4*unit, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit+2560, #1*4*unit+2560, #2*4*unit+2560, #3*4*unit+2560, #4*4*unit+2560, #5*4*unit+2560, #6*4*unit+2560, #7*4*unit+2560
    _3_layer_GS_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit+2560, #1*4*unit+2560, #2*4*unit+2560, #3*4*unit+2560, #4*4*unit+2560, #5*4*unit+2560, #6*4*unit+2560, #7*4*unit+2560

    add.w r0, r0, #5120

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #1*4*unit, #2*4*unit, #3*4*unit, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit
    _3_layer_GS_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #1*4*unit, #2*4*unit, #3*4*unit, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit, #4

    sub.w r0, r0, #5120

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _6_5_4_inner
#else
.endr
#endif

    add.w r0, r0, #140

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _6_5_4
#else
.endr
#endif

    sub.w r0, r0, #2560

    vmov.w r1, s1
    sub.w r1, r1, #504
    vldm r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #160
    vmov.w s2, r12
    _3_2_1_light:
#else
.rept 40
#endif

    ldrstr4 ldr.w, r0, r8, r5, r10, r7, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit
    _3_layer_GS_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #0*4*unit, #8*4*unit, #16*4*unit, #24*4*unit
    _3_layer_GS_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #8*4*unit, #16*4*unit, #24*4*unit, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit

    ldrstr4 ldr.w, r0, r8, r5, r10, r7, #32*4*unit+2560, #40*4*unit+2560, #48*4*unit+2560, #56*4*unit+2560
    _3_layer_GS_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #0*4*unit+2560, #8*4*unit+2560, #16*4*unit+2560, #24*4*unit+2560
    _3_layer_GS_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit+2560, #8*4*unit+2560, #16*4*unit+2560, #24*4*unit+2560, #32*4*unit+2560, #40*4*unit+2560, #48*4*unit+2560, #56*4*unit+2560

    add.w r0, r0, #5120

    ldrstr4 ldr.w, r0, r8, r5, r10, r7, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit
    _3_layer_GS_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #0*4*unit, #8*4*unit, #16*4*unit, #24*4*unit
    _3_layer_GS_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #8*4*unit, #16*4*unit, #24*4*unit, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit, #4

    sub.w r0, r0, #5120

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_2_1_light
#else
.endr
#endif

    add.w r0, r0, #1120

    vmov.w r1, s1
    vldm r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #160
    vmov.w s2, r12
    _3_2_1:
#else
.rept 40
#endif

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #8*4*unit, #16*4*unit, #24*4*unit, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit
    _3_layer_GS_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #8*4*unit, #16*4*unit, #24*4*unit, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit+2560, #8*4*unit+2560, #16*4*unit+2560, #24*4*unit+2560, #32*4*unit+2560, #40*4*unit+2560, #48*4*unit+2560, #56*4*unit+2560
    _3_layer_GS_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit+2560, #8*4*unit+2560, #16*4*unit+2560, #24*4*unit+2560, #32*4*unit+2560, #40*4*unit+2560, #48*4*unit+2560, #56*4*unit+2560

    add.w r0, r0, #5120

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #8*4*unit, #16*4*unit, #24*4*unit, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit
    _3_layer_GS_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #8*4*unit, #16*4*unit, #24*4*unit, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit, #4

    sub.w r0, r0, #5120

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_2_1
#else
.endr
#endif

    pop {r4-r12, pc}


