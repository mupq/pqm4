
#include "macros.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_final_map
.type __asm_final_map, %function
__asm_final_map:
    push.w {r4-r12, lr}

    ldr.w r11, [sp, #40]
    vmov.w s0, r11

    .equ width, 4
    .equ strwidth, 2

    ldr.w r8, [r1, #1*width]
    ldr.w r9, [r1, #0*width]

    vmov.w r11, s0
    ldrstr4 ldr.w, r11, r4, r5, r6, r7, #0*width, #256*width, #512*width, #768*width
    add_sub2 r4, r5, r6, r7
    montgomery_mul_32 r7, r8, r2, r3, r12, r14
    add_sub2 r4, r6, r5, r7
    vmov.w s4, s5, r4, r5
    vmov.w s6, s7, r6, r7

    vmov.w r11, s0
    ldrstr4 ldr.w, r11, r4, r5, r6, r7, #1*width, #257*width, #513*width, #769*width
    add_sub2 r4, r5, r6, r7
    montgomery_mul_32 r7, r8, r2, r3, r12, r14
    add_sub2 r4, r6, r5, r7
    vmov.w s8, s9, r4, r5
    vmov.w s10, s11, r6, r7

    vmov.w r11, s0
    ldrstr4 ldr.w, r11, r4, r5, r6, r7, #2*width, #258*width, #514*width, #770*width
    add_sub2 r4, r5, r6, r7
    montgomery_mul_32 r7, r8, r2, r3, r12, r14
    add_sub2 r4, r6, r5, r7
    vmov.w s12, s13, r4, r5
    vmov.w s14, s15, r6, r7

    vmov.w r11, s0
    add.w r11, r11, #3*width
    vmov.w s0, r11
    add.w r0, r0, #3*strwidth

#ifdef LOOP
    add.w r12, r0, #249*strwidth
    vmov.w s2, r12
    _final_map:
#else
.rept 83
#endif

    vmov.w r11, s0
    ldrstr4 ldr.w, r11, r4, r5, r6, r7, #0*width, #256*width, #512*width, #768*width
    add_sub2 r4, r5, r6, r7
    montgomery_mul_32 r7, r8, r2, r3, r12, r14
    add_sub2 r4, r6, r5, r7
    vmov.w r10, r11, s6, s7
    add r4, r10
    add r5, r11
    montgomery_mul_32 r4, r9, r2, r3, r12, r14
    montgomery_mul_32 r5, r9, r2, r3, r12, r14
    lsr.w r1, r3, #1
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    ubfx.w r4, r4, #0, #11
    ubfx.w r5, r5, #0, #11
    ldrstr2 strh.w, r0, r4, r5, #0*strwidth, #256*strwidth
    vmov.w s6, s7, r6, r7

    vmov.w r11, s0
    ldrstr4 ldr.w, r11, r4, r5, r6, r7, #1*width, #257*width, #513*width, #769*width
    add_sub2 r4, r5, r6, r7
    montgomery_mul_32 r7, r8, r2, r3, r12, r14
    add_sub2 r4, r6, r5, r7
    vmov.w r10, r11, s10, s11
    add r4, r10
    add r5, r11
    montgomery_mul_32 r4, r9, r2, r3, r12, r14
    montgomery_mul_32 r5, r9, r2, r3, r12, r14
    lsr.w r1, r3, #1
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    ubfx.w r4, r4, #0, #11
    ubfx.w r5, r5, #0, #11
    ldrstr2 strh.w, r0, r4, r5, #1*strwidth, #257*strwidth
    vmov.w s10, s11, r6, r7

    vmov.w r11, s0
    ldrstr4 ldr.w, r11, r4, r5, r6, r7, #2*width, #258*width, #514*width, #770*width
    add_sub2 r4, r5, r6, r7
    montgomery_mul_32 r7, r8, r2, r3, r12, r14
    add_sub2 r4, r6, r5, r7
    vmov.w r10, r11, s14, s15
    add r4, r10
    add r5, r11
    montgomery_mul_32 r4, r9, r2, r3, r12, r14
    montgomery_mul_32 r5, r9, r2, r3, r12, r14
    lsr.w r1, r3, #1
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    ubfx.w r4, r4, #0, #11
    ubfx.w r5, r5, #0, #11
    ldrstr2 strh.w, r0, r4, r5, #2*strwidth, #258*strwidth
    vmov.w s14, s15, r6, r7

    vmov.w r11, s0
    add.w r11, r11, #3*width
    vmov.w s0, r11
    add.w r0, r0, #3*strwidth

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _final_map
#else
.endr
#endif

    vmov.w r11, s0
    ldrstr4 ldr.w, r11, r4, r5, r6, r7, #0*width, #256*width, #512*width, #768*width
    add_sub2 r4, r5, r6, r7
    montgomery_mul_32 r7, r8, r2, r3, r12, r14
    add_sub2 r4, r6, r5, r7
    vmov.w r10, r11, s6, s7
    add r4, r10
    add r5, r11
    montgomery_mul_32 r4, r9, r2, r3, r12, r14
    montgomery_mul_32 r5, r9, r2, r3, r12, r14
    lsr.w r1, r3, #1
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    ubfx.w r4, r4, #0, #11
    ubfx.w r5, r5, #0, #11
    ldrstr2 strh.w, r0, r4, r5, #0*strwidth, #256*strwidth
    vmov.w s6, r6

    vmov.w r11, s0
    ldrstr4 ldr.w, r11, r4, r5, r6, r7, #1*width, #257*width, #513*width, #769*width
    add_sub2 r4, r5, r6, r7
    montgomery_mul_32 r7, r8, r2, r3, r12, r14
    add_sub2 r4, r6, r5, r7
    vmov.w r10, r11, s10, s11
    add r4, r4, r10
    add r5, r5, r11
    montgomery_mul_32 r4, r9, r2, r3, r12, r14
    lsr.w r1, r3, #1
    central_reduce r4, r1, r3
    ubfx.w r4, r4, #0, #11
    strh.w r4, [r0, #1*strwidth]
    sub.w r0, r0, #252*strwidth
    vmov.w r11, s4
    add.w r5, r5, r11
    montgomery_mul_32 r5, r9, r2, r3, r12, r14
    lsr.w r1, r3, #1
    central_reduce r5, r1, r3
    ubfx.w r5, r5, #0, #11
    strh.w r5, [r0, #0*strwidth]
    add.w r0, r0, #252*strwidth
    vmov.w s10, r6

    vmov.w r11, s0
    ldrstr4 ldr.w, r11, r4, r5, r6, r7, #2*width, #258*width, #514*width, #770*width
    add_sub2 r4, r5, r6, r7
    montgomery_mul_32 r7, r8, r2, r3, r12, r14
    add_sub2 r4, r6, r5, r7
    vmov.w r10, r11, s14, s15
    add r4, r10
    add r5, r11
    montgomery_mul_32 r4, r9, r2, r3, r12, r14
    lsr.w r1, r3, #1
    central_reduce r4, r1, r3
    ubfx.w r4, r4, #0, #11
    strh.w r4, [r0, #2*strwidth]
    sub.w r0, r0, #252*strwidth
    vmov.w r11, s8
    add.w r5, r5, r11
    montgomery_mul_32 r5, r9, r2, r3, r12, r14
    lsr.w r1, r3, #1
    central_reduce r5, r1, r3
    ubfx.w r5, r5, #0, #11
    strh.w r5, [r0, #1*strwidth]
    add.w r0, r0, #252*strwidth
    vmov.w s14, r6

    vmov.w r11, s0
    add.w r11, r11, #3*width
    vmov.w s0, r11
    add.w r0, r0, #3*strwidth

    vmov.w r11, s0
    ldrstr4 ldr.w, r11, r4, r5, r6, r7, #0*width, #256*width, #512*width, #768*width
    add_sub2 r4, r5, r6, r7
    montgomery_mul_32 r7, r8, r2, r3, r12, r14
    add_sub2 r4, r6, r5, r7
    vmov.w r10, r11, s6, s7
    add r4, r10
    add r5, r11
    montgomery_mul_32 r4, r9, r2, r3, r12, r14
    lsr.w r1, r3, #1
    central_reduce r4, r1, r3
    ubfx.w r4, r4, #0, #11
    strh.w r4, [r0, #0*strwidth]
    sub.w r0, r0, #255*strwidth
    vmov.w r11, s12
    add.w r5, r5, r11
    montgomery_mul_32 r5, r9, r2, r3, r12, r14
    lsr.w r1, r3, #1
    central_reduce r5, r1, r3
    ubfx.w r5, r5, #0, #11
    strh.w r5, [r0, #2*strwidth]
    add.w r0, r0, #255*strwidth
    vmov.w s6, r6

    vmov.w r4, r5, s5, s6
    vmov.w r6, r7, s9, s10
    vmov.w r8, r10, s13, s14

    add r4, r7
    add r6, r10
    add.w r8, r8, r5

    montgomery_mul_32 r4, r9, r2, r3, r12, r14
    montgomery_mul_32 r6, r9, r2, r3, r12, r14
    montgomery_mul_32 r8, r9, r2, r3, r12, r14
    lsr.w r1, r3, #1
    central_reduce r4, r1, r3
    central_reduce r6, r1, r3
    central_reduce r8, r1, r3
    ubfx.w r4, r4, #0, #11
    ubfx.w r6, r6, #0, #11
    ubfx.w r8, r8, #0, #11
    strh.w r4, [r0, #1*strwidth]
    strh.w r6, [r0, #2*strwidth]
    strh.w r8, [r0, #3*strwidth]

    pop.w {r4-r12, pc}





