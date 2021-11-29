// void __update_fg_64x688_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x688_mod2
.type __update_fg_64x688_mod2, %function
__update_fg_64x688_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1396
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x688_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x688_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x688_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x688_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #336
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #344]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_688:
	ldr.w r2, [r10, #696]
	ldr.w r3, [r10, #700]
	ldr.w r4, [r10, #704]
	ldr.w r5, [r10, #708]
	ldr.w r6, [r10, #1044]
	ldr.w r7, [r10, #1048]
	ldr.w r8, [r10, #1052]
	ldr.w r9, [r10, #1056]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #348]
	ldr.w r7, [r10, #352]
	ldr.w r8, [r10, #356]
	ldr.w r9, [r10, #360]
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
	bne.w add_loop_688
	ldr.w r2, [r10, #696]
	ldr.w r3, [r10, #700]
	ldr.w r6, [r10, #1044]
	ldr.w r7, [r10, #1048]
	eor.w r2, r6
	eor.w r3, r7
	str.w r3, [r1, #4]
	str.w r2, [r1], #8
	ldr.w r6, [r10, #348]
	ldr.w r7, [r10, #352]
	ldr.w r3, [r10, #4]
	ldr.w r2, [r10], #8
	vmov.w s0, s1, r0, r1
	ubfx.w r0, r2, #28, #1
	eor.w r2, r11, r2, LSL #4
	ubfx.w r11, r3, #28, #1
	eor.w r3, r0, r3, LSL #4
	ubfx.w r1, r6, #28, #1
	eor.w r6, r12, r6, LSL #4
	ubfx.w r12, r7, #28, #1
	eor.w r7, r1, r7, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	str.w r3, [r0, #4]
	str.w r2, [r0], #8
	add.w sp, #1396
	pop.w {r3-r12,pc}
// void __update_fg_64x672_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x672_mod2
.type __update_fg_64x672_mod2, %function
__update_fg_64x672_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1364
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x672_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x672_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x672_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x672_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #336
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #336]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_672:
	ldr.w r2, [r10, #680]
	ldr.w r3, [r10, #684]
	ldr.w r4, [r10, #688]
	ldr.w r5, [r10, #692]
	ldr.w r6, [r10, #1020]
	ldr.w r7, [r10, #1024]
	ldr.w r8, [r10, #1028]
	ldr.w r9, [r10, #1032]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #340]
	ldr.w r7, [r10, #344]
	ldr.w r8, [r10, #348]
	ldr.w r9, [r10, #352]
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
	bne.w add_loop_672
	add.w sp, #1364
	pop.w {r3-r12,pc}
// void __update_fg_64x608_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x608_mod2
.type __update_fg_64x608_mod2, %function
__update_fg_64x608_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1236
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x608_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x608_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x608_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x608_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #304
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #304]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_608:
	ldr.w r2, [r10, #616]
	ldr.w r3, [r10, #620]
	ldr.w r4, [r10, #624]
	ldr.w r5, [r10, #628]
	ldr.w r6, [r10, #924]
	ldr.w r7, [r10, #928]
	ldr.w r8, [r10, #932]
	ldr.w r9, [r10, #936]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #308]
	ldr.w r7, [r10, #312]
	ldr.w r8, [r10, #316]
	ldr.w r9, [r10, #320]
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
	bne.w add_loop_608
	add.w sp, #1236
	pop.w {r3-r12,pc}
// void __update_fg_64x544_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x544_mod2
.type __update_fg_64x544_mod2, %function
__update_fg_64x544_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1108
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x544_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x544_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x544_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x544_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #272
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #272]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_544:
	ldr.w r2, [r10, #552]
	ldr.w r3, [r10, #556]
	ldr.w r4, [r10, #560]
	ldr.w r5, [r10, #564]
	ldr.w r6, [r10, #828]
	ldr.w r7, [r10, #832]
	ldr.w r8, [r10, #836]
	ldr.w r9, [r10, #840]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #276]
	ldr.w r7, [r10, #280]
	ldr.w r8, [r10, #284]
	ldr.w r9, [r10, #288]
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
	bne.w add_loop_544
	add.w sp, #1108
	pop.w {r3-r12,pc}
// void __update_fg_64x480_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x480_mod2
.type __update_fg_64x480_mod2, %function
__update_fg_64x480_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #980
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x480_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x480_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x480_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x480_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #240
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #240]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_480:
	ldr.w r2, [r10, #488]
	ldr.w r3, [r10, #492]
	ldr.w r4, [r10, #496]
	ldr.w r5, [r10, #500]
	ldr.w r6, [r10, #732]
	ldr.w r7, [r10, #736]
	ldr.w r8, [r10, #740]
	ldr.w r9, [r10, #744]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #244]
	ldr.w r7, [r10, #248]
	ldr.w r8, [r10, #252]
	ldr.w r9, [r10, #256]
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
	bne.w add_loop_480
	add.w sp, #980
	pop.w {r3-r12,pc}
// void __update_fg_64x416_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x416_mod2
.type __update_fg_64x416_mod2, %function
__update_fg_64x416_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #852
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x416_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x416_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x416_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x416_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #208
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #208]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_416:
	ldr.w r2, [r10, #424]
	ldr.w r3, [r10, #428]
	ldr.w r4, [r10, #432]
	ldr.w r5, [r10, #436]
	ldr.w r6, [r10, #636]
	ldr.w r7, [r10, #640]
	ldr.w r8, [r10, #644]
	ldr.w r9, [r10, #648]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #212]
	ldr.w r7, [r10, #216]
	ldr.w r8, [r10, #220]
	ldr.w r9, [r10, #224]
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
	bne.w add_loop_416
	add.w sp, #852
	pop.w {r3-r12,pc}
// void __update_fg_64x352_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x352_mod2
.type __update_fg_64x352_mod2, %function
__update_fg_64x352_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #724
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x352_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x352_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x352_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x352_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #176
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #176]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_352:
	ldr.w r2, [r10, #360]
	ldr.w r3, [r10, #364]
	ldr.w r4, [r10, #368]
	ldr.w r5, [r10, #372]
	ldr.w r6, [r10, #540]
	ldr.w r7, [r10, #544]
	ldr.w r8, [r10, #548]
	ldr.w r9, [r10, #552]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #180]
	ldr.w r7, [r10, #184]
	ldr.w r8, [r10, #188]
	ldr.w r9, [r10, #192]
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
	bne.w add_loop_352
	add.w sp, #724
	pop.w {r3-r12,pc}
// void __update_fg_64x288_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x288_mod2
.type __update_fg_64x288_mod2, %function
__update_fg_64x288_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #596
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x288_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x288_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x288_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x288_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #144
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #144]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_288:
	ldr.w r2, [r10, #296]
	ldr.w r3, [r10, #300]
	ldr.w r4, [r10, #304]
	ldr.w r5, [r10, #308]
	ldr.w r6, [r10, #444]
	ldr.w r7, [r10, #448]
	ldr.w r8, [r10, #452]
	ldr.w r9, [r10, #456]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #148]
	ldr.w r7, [r10, #152]
	ldr.w r8, [r10, #156]
	ldr.w r9, [r10, #160]
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
	bne.w add_loop_288
	add.w sp, #596
	pop.w {r3-r12,pc}
// void __update_fg_64x224_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x224_mod2
.type __update_fg_64x224_mod2, %function
__update_fg_64x224_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #468
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x224_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x224_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x224_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x224_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #112
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #112]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_224:
	ldr.w r2, [r10, #232]
	ldr.w r3, [r10, #236]
	ldr.w r4, [r10, #240]
	ldr.w r5, [r10, #244]
	ldr.w r6, [r10, #348]
	ldr.w r7, [r10, #352]
	ldr.w r8, [r10, #356]
	ldr.w r9, [r10, #360]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #116]
	ldr.w r7, [r10, #120]
	ldr.w r8, [r10, #124]
	ldr.w r9, [r10, #128]
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
	bne.w add_loop_224
	add.w sp, #468
	pop.w {r3-r12,pc}
// void __update_fg_64x160_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x160_mod2
.type __update_fg_64x160_mod2, %function
__update_fg_64x160_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #340
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x160_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x160_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x160_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x160_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #80
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #80]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_160:
	ldr.w r2, [r10, #168]
	ldr.w r3, [r10, #172]
	ldr.w r4, [r10, #176]
	ldr.w r5, [r10, #180]
	ldr.w r6, [r10, #252]
	ldr.w r7, [r10, #256]
	ldr.w r8, [r10, #260]
	ldr.w r9, [r10, #264]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #84]
	ldr.w r7, [r10, #88]
	ldr.w r8, [r10, #92]
	ldr.w r9, [r10, #96]
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
	bne.w add_loop_160
	add.w sp, #340
	pop.w {r3-r12,pc}
// void __update_fg_64x96_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x96_mod2
.type __update_fg_64x96_mod2, %function
__update_fg_64x96_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #212
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x96_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x96_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x96_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x96_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #48
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #48]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_96:
	ldr.w r2, [r10, #104]
	ldr.w r3, [r10, #108]
	ldr.w r4, [r10, #112]
	ldr.w r5, [r10, #116]
	ldr.w r6, [r10, #156]
	ldr.w r7, [r10, #160]
	ldr.w r8, [r10, #164]
	ldr.w r9, [r10, #168]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #52]
	ldr.w r7, [r10, #56]
	ldr.w r8, [r10, #60]
	ldr.w r9, [r10, #64]
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
	bne.w add_loop_96
	add.w sp, #212
	pop.w {r3-r12,pc}
// void __update_fg_32x32_mod2 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_32x32_mod2
.type __update_fg_32x32_mod2, %function
__update_fg_32x32_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #84
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_32x32_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #16
	bl __polymul_32x32_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #32
	bl __polymul_32x32_mod2_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #48
	bl __polymul_32x32_mod2_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w lr, r0, #16
	add.w r10, #4
	ldr.w r11, [r10, #-4]
	ldr.w r12, [r10, #16]
	ubfx.w r11, r11, #28, #1
	ubfx.w r12, r12, #28, #1
add_loop_32:
	ldr.w r2, [r10, #40]
	ldr.w r3, [r10, #44]
	ldr.w r4, [r10, #48]
	ldr.w r5, [r10, #52]
	ldr.w r6, [r10, #60]
	ldr.w r7, [r10, #64]
	ldr.w r8, [r10, #68]
	ldr.w r9, [r10, #72]
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #20]
	ldr.w r7, [r10, #24]
	ldr.w r8, [r10, #28]
	ldr.w r9, [r10, #32]
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
	bne.w add_loop_32
	add.w sp, #84
	pop.w {r3-r12,pc}
