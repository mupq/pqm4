.p2align
.syntax unified
.text
.global mask1013
.type mask1013, %function
mask1013:
    push {r4-r9, lr}
.rept 64
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
.rept 580
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global mask1013x
.type mask1013x, %function
mask1013x:
    push {r4-r9, lr}
    add.w r0, r0, #2
.rept 64
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
.rept 580
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global imask2026
.type imask2026, %function
imask2026:
    push {r4-r9, lr}
.rept 128
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

.global mask512_1248
.type mask512_1248, %function
mask512_1248:
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
.rept 368
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global mask512x_1248
.type mask512x_1248, %function
mask512x_1248:
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
.rept 368
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global imask1024_1248
.type imask1024_1248, %function
imask1024_1248:
    push {r4-r9, lr}
.rept 64
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

.global imask1024x_1248
.type imask1024x_1248, %function
imask1024x_1248:
    push {r4-r9, lr}
    add.w r1, r1, #2
.rept 64
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


.global mask256_624
.type mask256_624, %function
mask256_624:
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
.rept 184
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global mask256x_624
.type mask256x_624, %function
mask256x_624:
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
.rept 184
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global imask512_624
.type imask512_624, %function
imask512_624:
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

.global imask512x_624
.type imask512x_624, %function
imask512x_624:
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



.global mask128_312
.type mask128_312, %function
mask128_312:
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
.rept 92
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global mask128x_312
.type mask128x_312, %function
mask128x_312:
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
.rept 92
    str.w r2, [r0], #4
.endr
    pop {r4-r9, pc}

.global imask256_312
.type imask256_312, %function
imask256_312:
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

.global imask256x_312
.type imask256x_312, %function
imask256x_312:
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