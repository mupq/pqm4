
#include "macros.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_intt
.type __asm_intt, %function
__asm_intt:
    push.w {r4-r12, lr}

    // RmodM
    movw r4, #35407
    movt r4, #46
    neg.w r4, r4
    vmov.w s15, r4

    add.w r1, r1, #252
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #16
    vmov.w s3, r14
    _8_7_6_light:
#else
.rept 2
#endif

.rept 2
    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0, #16, #32, #48, #64, #80, #96, #112

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11
    vmov.w r1, s9
    montgomery_mul r9, r1, r12, r9, r2, r3, r14
    vmov.w r1, s10
    montgomery_mul r11, r1, r12, r11, r2, r3, r14
    montgomery_mul_vec4 r4, r6, r8, r10, s15, r1, r2, r3, r12, r14
    montgomery_mul r5, r1, r12, r5, r2, r3, r14
    vmov.w r1, s8
    montgomery_mul r7, r1, r12, r7, r2, r3, r14
    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11
    montgomery_mul r10, r1, r12, r10, r2, r3, r14
    montgomery_mul r11, r1, r12, r11, r2, r3, r14
    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11

    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #16, #32, #48, #64, #80, #96, #112, #4
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _8_7_6_light
#else
.endr
#endif

    add.w r0, r0, #112

#ifdef LOOP
    add.w r12, r0, #3968
    add.w r12, r12, #4096
    vmov.w s2, r12
    _8_7_6:
#else
.rept 63
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #16
    vmov.w s3, r14
    _8_7_6_inner:
#else
.rept 2
#endif

.rept 2
    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0, #16, #32, #48, #64, #80, #96, #112

    add_sub4 r4, r5, r6, r7, r8, r9, r10, r11
    vmov.w r1, s7
    montgomery_mul r5, r1, r12, r5, r2, r3, r14
    vmov.w r1, s8
    montgomery_mul r7, r1, r12, r7, r2, r3, r14
    vmov.w r1, s9
    montgomery_mul r9, r1, r12, r9, r2, r3, r14
    vmov.w r1, s10
    montgomery_mul r11, r1, r12, r11, r2, r3, r14
    montgomery_mul_vec4 r4, r6, r8, r10, s15, r1, r2, r3, r12, r14

    add_sub4 r4, r6, r5, r7, r8, r10, r9, r11
    vmov.w r1, s5
    montgomery_mul r6, r1, r12, r6, r2, r3, r14
    montgomery_mul r7, r1, r12, r7, r2, r3, r14
    vmov.w r1, s6
    montgomery_mul r10, r1, r12, r10, r2, r3, r14
    montgomery_mul r11, r1, r12, r11, r2, r3, r14

    add_sub4 r4, r8, r5, r9, r6, r10, r7, r11
    montgomery_mul_vec4 r8, r9, r10, r11, s4, r1, r2, r3, r12, r14

    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #16, #32, #48, #64, #80, #96, #112, #4
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _8_7_6_inner
#else
.endr
#endif

    add.w r0, r0, #112

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _8_7_6
#else
.endr
#endif

    sub.w r0, r0, #4096
    sub.w r0, r0, #4096

    vmov.w r1, s1
    sub.w r1, r1, #2016

    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #128
    vmov.w s3, r14
    _5_4_3_light:
#else
.rept 16
#endif

.rept 2
    ldrstr4 ldr.w, r0, r8, r5, r10, r7, #512, #640, #768, #896
    _3_layer_GS_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #0, #128, #256, #384
    _3_layer_GS_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #128, #256, #384, #512, #640, #768, #896, #4
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _5_4_3_light
#else
.endr
#endif

    add.w r0, r0, #896

#ifdef LOOP
    add.w r12, r0, #3072
    add.w r12, r12, #4096
    vmov.w s2, r12
    _5_4_3:
#else
.rept 7
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #128
    vmov.w s3, r14
    _5_4_3_inner:
#else
.rept 16
#endif

.rept 2
    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0, #128, #256, #384, #512, #640, #768, #896
    _3_layer_GS_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #128, #256, #384, #512, #640, #768, #896, #4
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _5_4_3_inner
#else
.endr
#endif

    add.w r0, r0, #896

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _5_4_3
#else
.endr
#endif

    vmov.w r1, s1
    sub.w r1, r1, #252
    vldm.w r1, {s4-s10}

    sub.w r1, r0, #4096
    sub.w r0, r1, #4096
    vmov.w s0, r1

#ifdef LOOP
    add.w r14, r0, #1024
    vmov.w s3, r14
    _2_1_0:
#else
.rept 64
#endif

.rept 4
    vmov.w r1, s0
    ldrstr4 ldr.w, r1, r8, r5, r10, r7, #0, #1024, #2048, #3072
    _3_layer_GS_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #0, #1024, #2048, #3072
    _3_layer_GS_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s0
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #1024, #2048, #3072, #4
    ldrstr4jump str.w, r1, r8, r9, r10, r11, #1024, #2048, #3072, #4
    vmov.w s0, r1
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _2_1_0
#else
.endr
#endif

    pop.w {r4-r12, pc}


