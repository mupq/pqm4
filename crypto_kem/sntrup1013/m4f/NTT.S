
#include "macros.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_ntt_0_1_2_small
.type __asm_ntt_0_1_2_small, %function
__asm_ntt_0_1_2_small:
    vldr.w s0, [sp, #0]
    push.w {r4-r12, lr}

    .equ width, 1

    vmov.w r4, s0
    add.w r14, r4, #4096
    vmov.w s0, s1, r4, r14

    vldm.w r1, {s4-s10}

#ifdef LOOP
    add.w r14, r0, #245*width
    vmov.w s3, r14
    _0_1_2_small:
#else
.rept 49
#endif

.rept 5
    ldrstr4jump ldrsb.w, r0, r4, r5, r6, r7, #256*width, #512*width, #768*width, #width
    _3_layer_CT_butterfly_small_light_fast_half r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, r14, s0, s1
    ldrstr4jump str.w, r1, r4, r5, r6, r7, #1024, #2048, #3072, #4
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #1024, #2048, #3072, #4
    vmov.w s0, s1, r1, r14
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _0_1_2_small
#else
.endr
#endif

    ldrsb.w r5, [r0, #256*width]
    ldrsb.w r6, [r0, #512*width]
    ldrsb.w r4, [r0], #width
    movw r7, #0
    _3_layer_CT_butterfly_small_light_fast_half r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, r14, s0, s1
    ldrstr4jump str.w, r1, r4, r5, r6, r7, #1024, #2048, #3072, #4
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #1024, #2048, #3072, #4
    vmov.w s0, s1, r1, r14

#ifdef LOOP
    add.w r14, r0, #10*width
    vmov.w s3, r14
    _0_1_2_small_last:
#else
.rept 2
#endif

.rept 5
    ldrsb.w r5, [r0, #256*width]
    ldrsb.w r6, [r0, #512*width]
    ldrsb.w r4, [r0], #width
    movw r7, #0
    _3_layer_CT_butterfly_small_light_fast_half r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, r14, s0, s1
    ldrstr4jump str.w, r1, r4, r5, r6, r7, #1024, #2048, #3072, #4
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #1024, #2048, #3072, #4
    vmov.w s0, s1, r1, r14
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _0_1_2_small_last
#else
.endr
#endif

    pop {r4-r12, pc}


.align 2
.global __asm_ntt_0_1_2
.type __asm_ntt_0_1_2, %function
__asm_ntt_0_1_2:
    vldr.w s0, [sp, #0]
    push.w {r4-r12, lr}

    .equ width, 2

    vmov.w r4, s0
    add.w r14, r4, #4096
    vmov.w s0, s1, r4, r14

    vldm.w r1, {s4-s10}

#ifdef LOOP
    add.w r14, r0, #245*width
    vmov.w s3, r14
    _0_1_2:
#else
.rept 49
#endif

.rept 5
    ldrstr4jump ldrsh.w, r0, r4, r5, r6, r7, #256*width, #512*width, #768*width, #width
    _3_layer_CT_butterfly_light_fast_half r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, r14, s0, s1
    ldrstr4jump str.w, r1, r4, r5, r6, r7, #1024, #2048, #3072, #4
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #1024, #2048, #3072, #4
    vmov.w s0, s1, r1, r14
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _0_1_2
#else
.endr
#endif

    ldrsh.w r5, [r0, #256*width]
    ldrsh.w r6, [r0, #512*width]
    ldrsh.w r4, [r0], #width
    movw r7, #0
    _3_layer_CT_butterfly_light_fast_half r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, r14, s0, s1
    ldrstr4jump str.w, r1, r4, r5, r6, r7, #1024, #2048, #3072, #4
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #1024, #2048, #3072, #4
    vmov.w s0, s1, r1, r14

#ifdef LOOP
    add.w r14, r0, #10*width
    vmov.w s3, r14
    _0_1_2_last:
#else
.rept 2
#endif

.rept 5
    ldrsh.w r5, [r0, #256*width]
    ldrsh.w r6, [r0, #512*width]
    ldrsh.w r4, [r0], #width
    movw r7, #0
    _3_layer_CT_butterfly_light_fast_half r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, r14, s0, s1
    ldrstr4jump str.w, r1, r4, r5, r6, r7, #1024, #2048, #3072, #4
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #1024, #2048, #3072, #4
    vmov.w s0, s1, r1, r14
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _0_1_2_last
#else
.endr
#endif

    pop {r4-r12, pc}


.align 2
.global __asm_ntt_3_4_5_6_7_8
.type __asm_ntt_3_4_5_6_7_8, %function
__asm_ntt_3_4_5_6_7_8:
    push {r4-r12, lr}

    add.w r1, r1, #28
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #128
    vmov.w s3, r14
    _3_4_5_light:
#else
.rept 8
#endif

.rept 4
    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #128, #384, #640, #896
    _3_layer_CT_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0, #256, #512, #768
    _3_layer_CT_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #128, #256, #384, #512, #640, #768, #896, #4
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _3_4_5_light
#else
.endr
#endif

    add.w r0, r0, #896

#ifdef LOOP
    add.w r12, r0, #3072
    add.w r12, r12, #4096
    vmov.w s2, r12
    _3_4_5:
#else
.rept 7
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #128
    vmov.w s3, r14
    _3_4_5_inner:
#else
.rept 16
#endif

.rept 2
    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0, #128, #256, #384, #512, #640, #768, #896
    _3_layer_CT_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #128, #256, #384, #512, #640, #768, #896, #4
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _3_4_5_inner
#else
.endr
#endif

    add.w r0, r0, #896

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_4_5
#else
.endr
#endif

    sub.w r0, r0, #8192

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

.rept 3
    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #16, #48, #80, #112
    _3_layer_CT_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0, #32, #64, #96
    _3_layer_CT_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #16, #32, #48, #64, #80, #96, #112, #4
.endr

    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #16, #48, #80, #112
    _3_layer_CT_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0, #32, #64, #96
    _3_layer_CT_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #16, #32, #48, #64, #80, #96, #112, #116

#ifdef LOOP
    add.w r12, r0, #3968
    add.w r12, r12, #4096
    vmov.w s2, r12
    _6_7_8:
#else
.rept 63
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #16
    vmov.w s3, r14
    _6_7_8_inner:
#else
.rept 2
#endif

.rept 2
    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0, #16, #32, #48, #64, #80, #96, #112
    _3_layer_CT_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #16, #32, #48, #64, #80, #96, #112, #4
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _6_7_8_inner
#else
.endr
#endif

    add.w r0, r0, #112

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _6_7_8
#else
.endr
#endif

    pop.w {r4-r12, pc}


