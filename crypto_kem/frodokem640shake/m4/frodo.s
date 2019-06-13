.syntax unified
.cpu cortex-m4
.thumb

//uint16_t xs(const uint16_t *s, const uint16_t *a_row)
.global xs 
.type xs, %function
.align 2
xs: 
    push {r4-r11, lr}
    mov r12, r0
    mov r0, #0
    .rept 64
    ldmia r12!, {r2, r3, r4, r5, r6}
    ldmia r1!, {r7, r8, r9, r10, r11}
    smlad r0, r2, r7, r0
    smlad r0, r3, r8, r0
    smlad r0, r4, r9, r0
    smlad r0, r5, r10, r0
    smlad r0, r6, r11, r0
    .endr
    pop {r4-r11, pc}

//void sb(uint16_t *out, const uint16_t *s, const uint16_t *a)
.global sb
.type sb, %function
.align 2 
sb:
    push {r4-r11, lr}
    mov r14, r2 
    // Load a
    ldrh r12, [r2, #0]
    ldrh r5, [r2, #16]
    bfi r12, r5, #16, #16
    ldrh r14, [r2, #32]
    ldrh r5, [r2, #48]
    bfi r14, r5, #16, #16
    ldrh r3, [r2, #64]
    ldrh r5, [r2, #80]
    bfi r3, r5, #16, #16
    ldrh r4, [r2, #96]
    ldrh r5, [r2, #112]
    bfi r4, r5, #16, #16
    .rept 8
        ldmia r1, {r5,r6,r7,r8}
        ldrh r10, [r0, #0]
        smlad r10, r12, r5, r10
        smlad r10, r14, r6, r10
        smlad r10, r3, r7, r10
        smlad r10, r4, r8, r10
        strh r10, [r0], #16
        add r1, r1, #1280
    .endr 
    pop {r4-r11, pc}
