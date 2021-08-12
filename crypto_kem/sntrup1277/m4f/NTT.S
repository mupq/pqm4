
#include "macros.S"
#include "special_butterflies.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_ntt_Good_512x5
.type __asm_ntt_Good_512x5, %function
__asm_ntt_Good_512x5:
    vldr.w s0, [sp, #0]
    push {r4-r12, lr}

    vldm r1, {s4-s10}

    .equ width, 2
    .equ unit, 5

    add.w r14, r0, #1024*unit
    vmov.w s1, r14

#ifdef LOOP
    add.w r12, r0, #1200
    vmov.w s2, r12
    _Good_loop0:
#else
.rept 12
#endif

.rept 4
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r4, r6, r9, r11, #640*width, #320*width, #960*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r4, r6, r9, r11, #640*width, #320*width, #960*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _Good_loop0
#else
.endr
#endif

.rept 4
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r4, r6, r9, r11, #640*width, #320*width, #960*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1010 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

    vmov.w r14, s1
    sub.w r14, r14, #1280
    sub.w r0, r0, #1280
    vmov.w s1, r14

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r5, r4, r7, r10, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    add.w r12, r0, #1200
    vmov.w s2, r12
    _Good_loop1:
#else
.rept 12
#endif

.rept 4
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r5, r4, r7, r10, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r5, r4, r7, r10, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _Good_loop1
#else
.endr
#endif

.rept 3
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r5, r4, r7, r10, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

    vmov.w r14, s1
    sub.w r14, r14, #1280
    sub.w r0, r0, #1280
    vmov.w s1, r14

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r6, r5, r8, r11, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r6, r5, r8, r11, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    add.w r12, r0, #1200
    vmov.w s2, r12
    _Good_loop2:
#else
.rept 12
#endif

.rept 4
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r6, r5, r8, r11, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r6, r5, r8, r11, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _Good_loop2
#else
.endr
#endif

.rept 2
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r6, r5, r8, r11, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0110 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

    vmov.w r14, s1
    sub.w r14, r14, #1280
    sub.w r0, r0, #1280
    vmov.w s1, r14

.rept 2
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r7, r4, r6, r9, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r7, r4, r6, r9, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    add.w r12, r0, #1200
    vmov.w s2, r12
    _Good_loop3:
#else
.rept 12
#endif

.rept 4
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r7, r4, r6, r9, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r7, r4, r6, r9, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _Good_loop3
#else
.endr
#endif

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r7, r4, r6, r9, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1011 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

    vmov.w r14, s1
    sub.w r14, r14, #1280
    sub.w r0, r0, #1280
    vmov.w s1, r14

.rept 3
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r8, r5, r7, r10, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r8, r5, r7, r10, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    add.w r12, r0, #1100
    vmov.w s2, r12
    _Good_loop4:
#else
.rept 11
#endif

.rept 4
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r8, r5, r7, r10, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r8, r5, r7, r10, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _Good_loop4
#else
.endr
#endif

.rept 2
    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r8, r5, r7, r10, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 2
    vmov.w r14, s0
    ldrsh.w r5, [r14, #320*width]
    ldrsh.w r10, [r14, #640*width]
    ldrsh.w r8, [r14], #width
    movw r7, #0
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrsh.w r5, [r14, #320*width]
    ldrsh.w r10, [r14, #640*width]
    ldrsh.w r8, [r14], #width
    movw r7, #0
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4 str.w, r14, r8, r9, r10, r11, #0*unit, #256*unit, #512*unit, #768*unit
    ldrstr4 str.w, r0, r4, r5, r6, r7, #0*unit, #256*unit, #512*unit, #768*unit
.endr

    pop {r4-r12, pc}

.align 2
.global __asm_ntt_Good_512x5_small
.type __asm_ntt_Good_512x5_small, %function
__asm_ntt_Good_512x5_small:
    vldr.w s0, [sp, #0]
    push {r4-r12, lr}

    vldm r1, {s4-s10}

    .equ width, 1
    .equ unit, 5

    add.w r14, r0, #1024*unit
    vmov.w s1, r14

#ifdef LOOP
    add.w r12, r0, #1200
    vmov.w s2, r12
    _Good_loop0_small:
#else
.rept 12
#endif

.rept 4
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r4, r6, r9, r11, #640*width, #320*width, #960*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r4, r6, r9, r11, #640*width, #320*width, #960*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _Good_loop0_small
#else
.endr
#endif

.rept 4
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r4, r6, r9, r11, #640*width, #320*width, #960*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1010_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

    vmov.w r14, s1
    sub.w r14, r14, #1280
    sub.w r0, r0, #1280
    vmov.w s1, r14

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r5, r4, r7, r10, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    add.w r12, r0, #1200
    vmov.w s2, r12
    _Good_loop1_small:
#else
.rept 12
#endif

.rept 4
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r5, r4, r7, r10, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r5, r4, r7, r10, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _Good_loop1_small
#else
.endr
#endif

.rept 3
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r5, r4, r7, r10, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

    vmov.w r14, s1
    sub.w r14, r14, #1280
    sub.w r0, r0, #1280
    vmov.w s1, r14

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r6, r5, r8, r11, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r6, r5, r8, r11, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    add.w r12, r0, #1200
    vmov.w s2, r12
    _Good_loop2_small:
#else
.rept 12
#endif

.rept 4
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r6, r5, r8, r11, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r6, r5, r8, r11, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _Good_loop2_small
#else
.endr
#endif

.rept 2
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r6, r5, r8, r11, #960*width, #640*width, #320*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0110_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

    vmov.w r14, s1
    sub.w r14, r14, #1280
    sub.w r0, r0, #1280
    vmov.w s1, r14

.rept 2
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r7, r4, r6, r9, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r7, r4, r6, r9, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    add.w r12, r0, #1200
    vmov.w s2, r12
    _Good_loop3_small:
#else
.rept 12
#endif

.rept 4
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r7, r4, r6, r9, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r7, r4, r6, r9, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _Good_loop3_small
#else
.endr
#endif

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r7, r4, r6, r9, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_1011_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

    vmov.w r14, s1
    sub.w r14, r14, #1280
    sub.w r0, r0, #1280
    vmov.w s1, r14

.rept 3
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r8, r5, r7, r10, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r8, r5, r7, r10, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    add.w r12, r0, #1100
    vmov.w s2, r12
    _Good_loop4_small:
#else
.rept 11
#endif

.rept 4
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r8, r5, r7, r10, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r8, r5, r7, r10, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s1, r14
.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _Good_loop4_small
#else
.endr
#endif

.rept 2
    vmov.w r14, s0
    ldrstr4jump ldrsb.w, r14, r8, r5, r7, r10, #320*width, #960*width, #640*width, #width
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 2
    vmov.w r14, s0
    ldrsb.w r5, [r14, #320*width]
    ldrsb.w r10, [r14, #640*width]
    ldrsb.w r8, [r14], #width
    movw r7, #0
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #24
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #24
    vmov.w s1, r14
.endr

.rept 1
    vmov.w r14, s0
    ldrsb.w r5, [r14, #320*width]
    ldrsb.w r10, [r14, #640*width]
    ldrsb.w r8, [r14], #width
    movw r7, #0
    vmov.w s0, r14
    _3_layer_CT_butterfly_type_0101_small r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s1
    ldrstr4 str.w, r14, r8, r9, r10, r11, #0*unit, #256*unit, #512*unit, #768*unit
    ldrstr4 str.w, r0, r4, r5, r6, r7, #0*unit, #256*unit, #512*unit, #768*unit
.endr

    pop {r4-r12, pc}

.align 2
.global __asm_ntt
.type __asm_ntt, %function
__asm_ntt:
    push {r4-r12, lr}

    // RmodM
    movw r4, #12715
    movt r4, #35
    neg.w r4, r4
    vmov.w s11, r4

    .equ unit, 5

    add.w r1, r1, #28
    vldm r1!, {s4-s10}
    vmov.w s1, r1

// ================================

#ifdef LOOP
    add.w r12, r0, #32*unit
    vmov.w s2, r12
    _3_4_5_light:
#else
.rept 8
#endif

.rept unit

    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #32*unit, #96*unit, #160*unit, #224*unit
    _3_layer_CT_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0*unit, #64*unit, #128*unit, #192*unit
    _3_layer_CT_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #32*unit, #64*unit, #96*unit, #128*unit, #160*unit, #192*unit, #224*unit, #4

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_4_5_light
#else
.endr
#endif

    add.w r0, r0, #224*unit

// ================================

#ifdef LOOP
    add.w r12, r0, #256*7*unit
    vmov.w s2, r12
    _3_4_5:
#else
.rept 7
#endif

    vmov.w r1, s1
    vldm r1!, {s4-s10}
    vmov.w s1, r1

// ================================

#ifdef LOOP
    add.w r14, r0, #32*unit
    vmov.w s3, r14
    _3_4_5_inner:
#else
.rept 4*unit
#endif

.rept 2
    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*unit, #32*unit, #64*unit, #96*unit, #128*unit, #160*unit, #192*unit, #224*unit
    _3_layer_CT_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #32*unit, #64*unit, #96*unit, #128*unit, #160*unit, #192*unit, #224*unit, #4
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _3_4_5_inner
#else
.endr
#endif

    add.w r0, r0, #224*unit

// ================================

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_4_5
#else
.endr
#endif

// ================================

    sub.w r0, r0, #2048*unit

    vmov.w r1, s1
    vldm r1!, {s4-s10}
    vmov.w s1, r1

// ================================

.rept unit
    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #4*unit, #12*unit, #20*unit, #28*unit
    _3_layer_CT_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0*unit, #8*unit, #16*unit, #24*unit
    _3_layer_CT_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit, #4
.endr

    add.w r0, r0, #28*unit

// ================================

#ifdef LOOP
    add.w r12, r0, #10240
    sub.w r12, r12, #160
    vmov.w s2, r12
    _6_7_8:
#else
.rept 63
#endif

    vmov.w r1, s1
    vldm r1!, {s4-s10}
    vmov.w s1, r1

// ================================

#ifdef LOOP
    add.w r14, r0, #16
    vmov.w s3, r14
    _6_7_8_inner:
#else
.rept 2
#endif

.rept 2

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*unit, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit
    _3_layer_CT_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit, #4

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _6_7_8_inner
#else
.endr
#endif

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*unit, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit
    _3_layer_CT_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit, #4

    add.w r0, r0, #28*unit

// ================================

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _6_7_8
#else
.endr
#endif

// ================================


    pop {r4-r12, pc}