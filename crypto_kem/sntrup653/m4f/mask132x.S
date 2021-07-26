.p2align 2,,3
.syntax unified
.text
.global mask128_264
.type mask128_264, %function
mask128_264:
    push {r4-r9, lr}
.rept 8
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    mov.w r2, #0
.rept 68
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global mask128x_264
.type mask128x_264, %function
mask128x_264:
    push {r4-r9, lr}
    add.w r0, r0, #2
.rept 8
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    mov.w r2, #0
.rept 68
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global imask256_264
.type imask256_264, %function
imask256_264:
    push {r4-r9, lr}
.rept 16
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    pop {r4-r9, pc}

.global imask256x_264
.type imask256x_264, %function
imask256x_264:
    push {r4-r9, lr}
    add.w r1, r1, #2
.rept 16
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    pop {r4-r9, pc}

.global mask256_528
.type mask256_528, %function
mask256_528:
    push {r4-r9, lr}
.rept 16
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    mov.w r2, #0
.rept 136
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global mask256x_528
.type mask256x_528, %function
mask256x_528:
    push {r4-r9, lr}
    add.w r0, r0, #2
.rept 16
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    mov.w r2, #0
.rept 136
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global imask512_528
.type imask512_528, %function
imask512_528:
    push {r4-r9, lr}
.rept 32
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    pop {r4-r9, pc}

.global imask512x_528
.type imask512x_528, %function
imask512x_528:
    push {r4-r9, lr}
    add.w r1, r1, #2
.rept 32
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    pop {r4-r9, pc}

.global mask256_792
.type mask256_792, %function
mask256_792:
    push {r4-r9, lr}
.rept 16
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    mov.w r2, #0
.rept 268
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global mask256x_792
.type mask256x_792, %function
mask256x_792:
    push {r4-r9, lr}
    add.w r0, r0, #2
.rept 16
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    mov.w r2, #0
.rept 268
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global mask512_792
.type mask512_792, %function
mask512_792:
    push {r4-r9, lr}
.rept 32
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    mov.w r2, #0
.rept 140
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global mask512x_792
.type mask512x_792, %function
mask512x_792:
    push {r4-r9, lr}
    add.w r0, r0, #2
.rept 32
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    mov.w r2, #0
.rept 140
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global imask768_792
.type imask768_792, %function
imask768_792:
    push {r4-r9, lr}
.rept 48
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    pop {r4-r9, pc}

.global imask768x_792
.type imask768x_792, %function
imask768x_792:
    push {r4-r9, lr}
    add.w r1, r1, #2
.rept 48
    ldr.w r3, [r1, #4]
    ldr.w r4, [r1, #8]
    ldr.w r5, [r1, #12]
    ldr.w r6, [r1, #16]
    ldr.w r7, [r1, #20]
    ldr.w r8, [r1, #24]
    ldr.w r9, [r1, #28]
    ldr.w r2, [r1], #32
    str.w r3, [r0, #4]
    str.w r4, [r0, #8]
    str.w r5, [r0, #12]
    str.w r6, [r0, #16]
    str.w r7, [r0, #20]
    str.w r8, [r0, #24]
    str.w r9, [r0, #28]
    str.w r2, [r0], #32
.endr
    pop {r4-r9, pc}