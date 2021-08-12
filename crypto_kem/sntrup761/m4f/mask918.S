.p2align 2,,3
.syntax unified
.text
.global mask256_918
.type mask256_918, %function
mask256_918:
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
.rept 331
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global mask256x_918
.type mask256x_918, %function
mask256x_918:
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
.rept 331
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global mask512_918
.type mask512_918, %function
mask512_918:
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
.rept 203
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global mask512x_918
.type mask512x_918, %function
mask512x_918:
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
.rept 203
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global imask768_918
.type imask768_918, %function
imask768_918:
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

.global imask768x_918
.type imask768x_918, %function
imask768x_918:
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