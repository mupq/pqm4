// void convert_bit_to_16_704 (int *h, int *f);
.p2align 2,,3
.syntax unified
.text
.global convert_bit_to_16_704
.type convert_bit_to_16_704, %function
convert_bit_to_16_704:
	push.w {r4-r11,lr}
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	ldr.w r11, [r1, #4]
	ldr.w r10, [r1], #8
	and.w r2, r10, #0x1
	and.w r6, r11, #0x1
	ubfx.w r12, r10, #4, #1
	ubfx.w lr, r11, #4, #1
	eor.w r2, r2, r12, LSL #16
	eor.w r6, r6, lr, LSL #16
	ubfx.w r3, r10, #8, #1
	ubfx.w r7, r11, #8, #1
	ubfx.w r12, r10, #12, #1
	ubfx.w lr, r11, #12, #1
	eor.w r3, r3, r12, LSL #16
	eor.w r7, r7, lr, LSL #16
	ubfx.w r4, r10, #16, #1
	ubfx.w r8, r11, #16, #1
	ubfx.w r12, r10, #20, #1
	ubfx.w lr, r11, #20, #1
	eor.w r4, r4, r12, LSL #16
	eor.w r8, r8, lr, LSL #16
	ubfx.w r5, r10, #24, #1
	ubfx.w r9, r11, #24, #1
	ubfx.w r12, r10, #28, #1
	ubfx.w lr, r11, #28, #1
	eor.w r5, r5, r12, LSL #16
	eor.w r9, r9, lr, LSL #16
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r7, [r0, #20]
	str.w r8, [r0, #24]
	str.w r9, [r0, #28]
	str.w r2, [r0], #32
	pop.w {r4-r11,pc}
