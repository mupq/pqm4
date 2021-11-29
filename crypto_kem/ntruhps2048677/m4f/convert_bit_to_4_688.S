// void convert_bit_to_4_688 (int *h, int *f);
.p2align 2,,3
.syntax unified
.text
.global convert_bit_to_4_688
.type convert_bit_to_4_688, %function
convert_bit_to_4_688:
	push.w {r4-r11,lr}
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r7, [r1, #20]
	ldr.w r8, [r1, #24]
	ldr.w r9, [r1, #28]
	ldr.w r2, [r1], #32
	and.w r10, r2, #0x1
	and.w r11, r6, #0x1
	ubfx.w r12, r2, #16, #1
	ubfx.w lr, r6, #16, #1
	eor.w r10, r10, r12, LSL #4
	eor.w r11, r11, lr, LSL #4
	and.w r12, r3, #0x1
	and.w lr, r7, #0x1
	eor.w r10, r10, r12, LSL #8
	eor.w r11, r11, lr, LSL #8
	ubfx.w r12, r3, #16, #1
	ubfx.w lr, r7, #16, #1
	eor.w r10, r10, r12, LSL #12
	eor.w r11, r11, lr, LSL #12
	and.w r12, r4, #0x1
	and.w lr, r8, #0x1
	eor.w r10, r10, r12, LSL #16
	eor.w r11, r11, lr, LSL #16
	ubfx.w r12, r4, #16, #1
	ubfx.w lr, r8, #16, #1
	eor.w r10, r10, r12, LSL #20
	eor.w r11, r11, lr, LSL #20
	and.w r12, r5, #0x1
	and.w lr, r9, #0x1
	eor.w r10, r10, r12, LSL #24
	eor.w r11, r11, lr, LSL #24
	ubfx.w r12, r5, #16, #1
	ubfx.w lr, r9, #16, #1
	eor.w r10, r10, r12, LSL #28
	eor.w r11, r11, lr, LSL #28
	str.w r11, [r0, #4]
	str.w r10, [r0], #8
	pop.w {r4-r11,pc}
