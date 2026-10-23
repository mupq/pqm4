#define ASM_SKIP_INCLUDE 1
#include "m4_defs.h"

.syntax unified
.cpu cortex-m4
.thumb

@ ==============================================================================
@ uint32_t smlad_batch_V(const uint16_t *a, const uint16_t *b)
@ ==============================================================================
.global smlad_batch_V
.type smlad_batch_V, %function
.align 2
smlad_batch_V:
    push {r4-r11, lr}
    mov r12, r0
    mov r0, #0
    .rept SMLAD_STEP_REP_V
    @ load 10 elements from vector a
    ldmia r12!, {r2, r3, r4, r5, r6}
    @ load 10 elements from vector b
    ldmia r1!, {r7, r8, r9, r10, r11}
    @ multiply in pairs and accumulate
    smlad r0, r2, r7, r0
    smlad r0, r3, r8, r0
    smlad r0, r4, r9, r0
    smlad r0, r5, r10, r0
    smlad r0, r6, r11, r0
    .endr
    pop {r4-r11, pc}

#if defined(RSDPG)
@ ==============================================================================
@ uint32_t smlad_batch_W(const uint16_t *a, const uint16_t *b)
@ ==============================================================================
.global smlad_batch_W
.type smlad_batch_W, %function
.align 2
smlad_batch_W:
    push {r4-r11, lr}
    mov r12, r0
    mov r0, #0
    .rept SMLAD_STEP_REP_W
    @ load 10 elements from vector a
    ldmia r12!, {r2, r3, r4, r5, r6}
    @ load 10 elements from vector b
    ldmia r1!, {r7, r8, r9, r10, r11}
    @ multiply in pairs and accumulate
    smlad r0, r2, r7, r0
    smlad r0, r3, r8, r0
    smlad r0, r4, r9, r0
    smlad r0, r5, r10, r0
    smlad r0, r6, r11, r0
    .endr
    pop {r4-r11, pc}
#endif
