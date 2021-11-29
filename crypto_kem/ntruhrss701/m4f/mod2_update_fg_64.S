// void __update_fg_64x64_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x64_mod2
.type __update_fg_64x64_mod2, %function
__update_fg_64x64_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #148
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x64_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x64_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x64_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x64_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #32
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #32]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_64:
	ldr.w r2, [r10, #72]
	ldr.w r3, [r10, #76]
	ldr.w r4, [r10, #80]
	ldr.w r5, [r10, #84]
	ldr.w r6, [r10, #108]
	ldr.w r7, [r10, #112]
	ldr.w r8, [r10, #116]
	ldr.w r9, [r10, #120]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #36]
	ldr.w r7, [r10, #40]
	ldr.w r8, [r10, #44]
	ldr.w r9, [r10, #48]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	vmov.w s0, s1, r0, r1
	ubfx.w r0, r2, #28, #1
	eor.w r2, r11, r2, LSL #4
	ubfx.w r11, r3, #28, #1
	eor.w r3, r0, r3, LSL #4
	ubfx.w r0, r4, #28, #1
	eor.w r4, r11, r4, LSL #4
	ubfx.w r11, r5, #28, #1
	eor.w r5, r0, r5, LSL #4
	ubfx.w r1, r6, #28, #1
	eor.w r6, r12, r6, LSL #4
	ubfx.w r12, r7, #28, #1
	eor.w r7, r1, r7, LSL #4
	ubfx.w r1, r8, #28, #1
	eor.w r8, r12, r8, LSL #4
	ubfx.w r12, r9, #28, #1
	eor.w r9, r1, r9, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_64
	add.w sp, #148
	pop.w {r3-r12,pc}
// void __update_fg_64x128_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x128_mod2
.type __update_fg_64x128_mod2, %function
__update_fg_64x128_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #276
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x128_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x128_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x128_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x128_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #64
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #64]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_128:
	ldr.w r2, [r10, #136]
	ldr.w r3, [r10, #140]
	ldr.w r4, [r10, #144]
	ldr.w r5, [r10, #148]
	ldr.w r6, [r10, #204]
	ldr.w r7, [r10, #208]
	ldr.w r8, [r10, #212]
	ldr.w r9, [r10, #216]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #68]
	ldr.w r7, [r10, #72]
	ldr.w r8, [r10, #76]
	ldr.w r9, [r10, #80]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	vmov.w s0, s1, r0, r1
	ubfx.w r0, r2, #28, #1
	eor.w r2, r11, r2, LSL #4
	ubfx.w r11, r3, #28, #1
	eor.w r3, r0, r3, LSL #4
	ubfx.w r0, r4, #28, #1
	eor.w r4, r11, r4, LSL #4
	ubfx.w r11, r5, #28, #1
	eor.w r5, r0, r5, LSL #4
	ubfx.w r1, r6, #28, #1
	eor.w r6, r12, r6, LSL #4
	ubfx.w r12, r7, #28, #1
	eor.w r7, r1, r7, LSL #4
	ubfx.w r1, r8, #28, #1
	eor.w r8, r12, r8, LSL #4
	ubfx.w r12, r9, #28, #1
	eor.w r9, r1, r9, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_128
	add.w sp, #276
	pop.w {r3-r12,pc}
// void __update_fg_64x192_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x192_mod2
.type __update_fg_64x192_mod2, %function
__update_fg_64x192_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #404
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x192_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x192_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x192_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x192_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #96
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #96]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_192:
	ldr.w r2, [r10, #200]
	ldr.w r3, [r10, #204]
	ldr.w r4, [r10, #208]
	ldr.w r5, [r10, #212]
	ldr.w r6, [r10, #300]
	ldr.w r7, [r10, #304]
	ldr.w r8, [r10, #308]
	ldr.w r9, [r10, #312]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #100]
	ldr.w r7, [r10, #104]
	ldr.w r8, [r10, #108]
	ldr.w r9, [r10, #112]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	vmov.w s0, s1, r0, r1
	ubfx.w r0, r2, #28, #1
	eor.w r2, r11, r2, LSL #4
	ubfx.w r11, r3, #28, #1
	eor.w r3, r0, r3, LSL #4
	ubfx.w r0, r4, #28, #1
	eor.w r4, r11, r4, LSL #4
	ubfx.w r11, r5, #28, #1
	eor.w r5, r0, r5, LSL #4
	ubfx.w r1, r6, #28, #1
	eor.w r6, r12, r6, LSL #4
	ubfx.w r12, r7, #28, #1
	eor.w r7, r1, r7, LSL #4
	ubfx.w r1, r8, #28, #1
	eor.w r8, r12, r8, LSL #4
	ubfx.w r12, r9, #28, #1
	eor.w r9, r1, r9, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_192
	add.w sp, #404
	pop.w {r3-r12,pc}
// void __update_fg_64x256_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x256_mod2
.type __update_fg_64x256_mod2, %function
__update_fg_64x256_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #532
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x256_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x256_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x256_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x256_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #128
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #128]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_256:
	ldr.w r2, [r10, #264]
	ldr.w r3, [r10, #268]
	ldr.w r4, [r10, #272]
	ldr.w r5, [r10, #276]
	ldr.w r6, [r10, #396]
	ldr.w r7, [r10, #400]
	ldr.w r8, [r10, #404]
	ldr.w r9, [r10, #408]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #132]
	ldr.w r7, [r10, #136]
	ldr.w r8, [r10, #140]
	ldr.w r9, [r10, #144]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	vmov.w s0, s1, r0, r1
	ubfx.w r0, r2, #28, #1
	eor.w r2, r11, r2, LSL #4
	ubfx.w r11, r3, #28, #1
	eor.w r3, r0, r3, LSL #4
	ubfx.w r0, r4, #28, #1
	eor.w r4, r11, r4, LSL #4
	ubfx.w r11, r5, #28, #1
	eor.w r5, r0, r5, LSL #4
	ubfx.w r1, r6, #28, #1
	eor.w r6, r12, r6, LSL #4
	ubfx.w r12, r7, #28, #1
	eor.w r7, r1, r7, LSL #4
	ubfx.w r1, r8, #28, #1
	eor.w r8, r12, r8, LSL #4
	ubfx.w r12, r9, #28, #1
	eor.w r9, r1, r9, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_256
	add.w sp, #532
	pop.w {r3-r12,pc}
// void __update_fg_64x320_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x320_mod2
.type __update_fg_64x320_mod2, %function
__update_fg_64x320_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #660
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x320_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x320_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x320_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x320_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #160
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #160]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_320:
	ldr.w r2, [r10, #328]
	ldr.w r3, [r10, #332]
	ldr.w r4, [r10, #336]
	ldr.w r5, [r10, #340]
	ldr.w r6, [r10, #492]
	ldr.w r7, [r10, #496]
	ldr.w r8, [r10, #500]
	ldr.w r9, [r10, #504]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #164]
	ldr.w r7, [r10, #168]
	ldr.w r8, [r10, #172]
	ldr.w r9, [r10, #176]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	vmov.w s0, s1, r0, r1
	ubfx.w r0, r2, #28, #1
	eor.w r2, r11, r2, LSL #4
	ubfx.w r11, r3, #28, #1
	eor.w r3, r0, r3, LSL #4
	ubfx.w r0, r4, #28, #1
	eor.w r4, r11, r4, LSL #4
	ubfx.w r11, r5, #28, #1
	eor.w r5, r0, r5, LSL #4
	ubfx.w r1, r6, #28, #1
	eor.w r6, r12, r6, LSL #4
	ubfx.w r12, r7, #28, #1
	eor.w r7, r1, r7, LSL #4
	ubfx.w r1, r8, #28, #1
	eor.w r8, r12, r8, LSL #4
	ubfx.w r12, r9, #28, #1
	eor.w r9, r1, r9, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_320
	add.w sp, #660
	pop.w {r3-r12,pc}
// void __update_fg_64x384_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x384_mod2
.type __update_fg_64x384_mod2, %function
__update_fg_64x384_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #788
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x384_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x384_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x384_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x384_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #192
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #192]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_384:
	ldr.w r2, [r10, #392]
	ldr.w r3, [r10, #396]
	ldr.w r4, [r10, #400]
	ldr.w r5, [r10, #404]
	ldr.w r6, [r10, #588]
	ldr.w r7, [r10, #592]
	ldr.w r8, [r10, #596]
	ldr.w r9, [r10, #600]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #196]
	ldr.w r7, [r10, #200]
	ldr.w r8, [r10, #204]
	ldr.w r9, [r10, #208]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	vmov.w s0, s1, r0, r1
	ubfx.w r0, r2, #28, #1
	eor.w r2, r11, r2, LSL #4
	ubfx.w r11, r3, #28, #1
	eor.w r3, r0, r3, LSL #4
	ubfx.w r0, r4, #28, #1
	eor.w r4, r11, r4, LSL #4
	ubfx.w r11, r5, #28, #1
	eor.w r5, r0, r5, LSL #4
	ubfx.w r1, r6, #28, #1
	eor.w r6, r12, r6, LSL #4
	ubfx.w r12, r7, #28, #1
	eor.w r7, r1, r7, LSL #4
	ubfx.w r1, r8, #28, #1
	eor.w r8, r12, r8, LSL #4
	ubfx.w r12, r9, #28, #1
	eor.w r9, r1, r9, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_384
	add.w sp, #788
	pop.w {r3-r12,pc}
// void __update_fg_64x448_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x448_mod2
.type __update_fg_64x448_mod2, %function
__update_fg_64x448_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #916
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x448_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x448_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x448_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x448_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #224
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #224]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_448:
	ldr.w r2, [r10, #456]
	ldr.w r3, [r10, #460]
	ldr.w r4, [r10, #464]
	ldr.w r5, [r10, #468]
	ldr.w r6, [r10, #684]
	ldr.w r7, [r10, #688]
	ldr.w r8, [r10, #692]
	ldr.w r9, [r10, #696]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #228]
	ldr.w r7, [r10, #232]
	ldr.w r8, [r10, #236]
	ldr.w r9, [r10, #240]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	vmov.w s0, s1, r0, r1
	ubfx.w r0, r2, #28, #1
	eor.w r2, r11, r2, LSL #4
	ubfx.w r11, r3, #28, #1
	eor.w r3, r0, r3, LSL #4
	ubfx.w r0, r4, #28, #1
	eor.w r4, r11, r4, LSL #4
	ubfx.w r11, r5, #28, #1
	eor.w r5, r0, r5, LSL #4
	ubfx.w r1, r6, #28, #1
	eor.w r6, r12, r6, LSL #4
	ubfx.w r12, r7, #28, #1
	eor.w r7, r1, r7, LSL #4
	ubfx.w r1, r8, #28, #1
	eor.w r8, r12, r8, LSL #4
	ubfx.w r12, r9, #28, #1
	eor.w r9, r1, r9, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_448
	add.w sp, #916
	pop.w {r3-r12,pc}
// void __update_fg_64x512_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x512_mod2
.type __update_fg_64x512_mod2, %function
__update_fg_64x512_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1044
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x512_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x512_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x512_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x512_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #256
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #256]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_512:
	ldr.w r2, [r10, #520]
	ldr.w r3, [r10, #524]
	ldr.w r4, [r10, #528]
	ldr.w r5, [r10, #532]
	ldr.w r6, [r10, #780]
	ldr.w r7, [r10, #784]
	ldr.w r8, [r10, #788]
	ldr.w r9, [r10, #792]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #260]
	ldr.w r7, [r10, #264]
	ldr.w r8, [r10, #268]
	ldr.w r9, [r10, #272]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	vmov.w s0, s1, r0, r1
	ubfx.w r0, r2, #28, #1
	eor.w r2, r11, r2, LSL #4
	ubfx.w r11, r3, #28, #1
	eor.w r3, r0, r3, LSL #4
	ubfx.w r0, r4, #28, #1
	eor.w r4, r11, r4, LSL #4
	ubfx.w r11, r5, #28, #1
	eor.w r5, r0, r5, LSL #4
	ubfx.w r1, r6, #28, #1
	eor.w r6, r12, r6, LSL #4
	ubfx.w r12, r7, #28, #1
	eor.w r7, r1, r7, LSL #4
	ubfx.w r1, r8, #28, #1
	eor.w r8, r12, r8, LSL #4
	ubfx.w r12, r9, #28, #1
	eor.w r9, r1, r9, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_512
	add.w sp, #1044
	pop.w {r3-r12,pc}
// void __update_fg_64x576_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x576_mod2
.type __update_fg_64x576_mod2, %function
__update_fg_64x576_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1172
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x576_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x576_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x576_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x576_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #288
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #288]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_576:
	ldr.w r2, [r10, #584]
	ldr.w r3, [r10, #588]
	ldr.w r4, [r10, #592]
	ldr.w r5, [r10, #596]
	ldr.w r6, [r10, #876]
	ldr.w r7, [r10, #880]
	ldr.w r8, [r10, #884]
	ldr.w r9, [r10, #888]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #292]
	ldr.w r7, [r10, #296]
	ldr.w r8, [r10, #300]
	ldr.w r9, [r10, #304]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	vmov.w s0, s1, r0, r1
	ubfx.w r0, r2, #28, #1
	eor.w r2, r11, r2, LSL #4
	ubfx.w r11, r3, #28, #1
	eor.w r3, r0, r3, LSL #4
	ubfx.w r0, r4, #28, #1
	eor.w r4, r11, r4, LSL #4
	ubfx.w r11, r5, #28, #1
	eor.w r5, r0, r5, LSL #4
	ubfx.w r1, r6, #28, #1
	eor.w r6, r12, r6, LSL #4
	ubfx.w r12, r7, #28, #1
	eor.w r7, r1, r7, LSL #4
	ubfx.w r1, r8, #28, #1
	eor.w r8, r12, r8, LSL #4
	ubfx.w r12, r9, #28, #1
	eor.w r9, r1, r9, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_576
	add.w sp, #1172
	pop.w {r3-r12,pc}
// void __update_fg_64x640_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x640_mod2
.type __update_fg_64x640_mod2, %function
__update_fg_64x640_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1300
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x640_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x640_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x640_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x640_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #320
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #320]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_640:
	ldr.w r2, [r10, #648]
	ldr.w r3, [r10, #652]
	ldr.w r4, [r10, #656]
	ldr.w r5, [r10, #660]
	ldr.w r6, [r10, #972]
	ldr.w r7, [r10, #976]
	ldr.w r8, [r10, #980]
	ldr.w r9, [r10, #984]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #324]
	ldr.w r7, [r10, #328]
	ldr.w r8, [r10, #332]
	ldr.w r9, [r10, #336]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	vmov.w s0, s1, r0, r1
	ubfx.w r0, r2, #28, #1
	eor.w r2, r11, r2, LSL #4
	ubfx.w r11, r3, #28, #1
	eor.w r3, r0, r3, LSL #4
	ubfx.w r0, r4, #28, #1
	eor.w r4, r11, r4, LSL #4
	ubfx.w r11, r5, #28, #1
	eor.w r5, r0, r5, LSL #4
	ubfx.w r1, r6, #28, #1
	eor.w r6, r12, r6, LSL #4
	ubfx.w r12, r7, #28, #1
	eor.w r7, r1, r7, LSL #4
	ubfx.w r1, r8, #28, #1
	eor.w r8, r12, r8, LSL #4
	ubfx.w r12, r9, #28, #1
	eor.w r9, r1, r9, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_640
	add.w sp, #1300
	pop.w {r3-r12,pc}
// void __update_fg_64x704_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x704_mod2
.type __update_fg_64x704_mod2, %function
__update_fg_64x704_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1428
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x704_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x704_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x704_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x704_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #352
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #352]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_704:
	ldr.w r2, [r10, #712]
	ldr.w r3, [r10, #716]
	ldr.w r4, [r10, #720]
	ldr.w r5, [r10, #724]
	ldr.w r6, [r10, #1068]
	ldr.w r7, [r10, #1072]
	ldr.w r8, [r10, #1076]
	ldr.w r9, [r10, #1080]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #356]
	ldr.w r7, [r10, #360]
	ldr.w r8, [r10, #364]
	ldr.w r9, [r10, #368]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	vmov.w s0, s1, r0, r1
	ubfx.w r0, r2, #28, #1
	eor.w r2, r11, r2, LSL #4
	ubfx.w r11, r3, #28, #1
	eor.w r3, r0, r3, LSL #4
	ubfx.w r0, r4, #28, #1
	eor.w r4, r11, r4, LSL #4
	ubfx.w r11, r5, #28, #1
	eor.w r5, r0, r5, LSL #4
	ubfx.w r1, r6, #28, #1
	eor.w r6, r12, r6, LSL #4
	ubfx.w r12, r7, #28, #1
	eor.w r7, r1, r7, LSL #4
	ubfx.w r1, r8, #28, #1
	eor.w r8, r12, r8, LSL #4
	ubfx.w r12, r9, #28, #1
	eor.w r9, r1, r9, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_704
	add.w sp, #1428
	pop.w {r3-r12,pc}
