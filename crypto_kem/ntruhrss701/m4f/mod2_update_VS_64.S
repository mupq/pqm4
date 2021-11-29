// void __update_VS_64x64_mod2 (int *V, int *S, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_VS_64x64_mod2
.type __update_VS_64x64_mod2, %function
__update_VS_64x64_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #260
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x64_mod2
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x64_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x64_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x64_mod2
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	movw.w r11, #0
	movw.w r12, #0
	add.w lr, r0, #64
add_loop_vs_64:
	ldr.w r2, [r10, #64]
	ldr.w r3, [r10, #68]
	ldr.w r4, [r10, #72]
	ldr.w r5, [r10, #76]
	ldr.w r6, [r10, #192]
	ldr.w r7, [r10, #196]
	ldr.w r8, [r10, #200]
	ldr.w r9, [r10, #204]
	vmov.w s0, s1, r0, r1
	ubfx.w r1, r2, #28, #1
	eor.w r2, r12, r2, LSL #4
	ubfx.w r12, r3, #28, #1
	eor.w r3, r1, r3, LSL #4
	ubfx.w r1, r4, #28, #1
	eor.w r4, r12, r4, LSL #4
	ubfx.w r12, r5, #28, #1
	eor.w r5, r1, r5, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #128]
	ldr.w r7, [r10, #132]
	ldr.w r8, [r10, #136]
	ldr.w r9, [r10, #140]
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
	bne.w add_loop_vs_64
	add.w sp, #260
	pop.w {r3-r12,pc}
// void __update_VS_64x128_mod2 (int *V, int *S, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_VS_64x128_mod2
.type __update_VS_64x128_mod2, %function
__update_VS_64x128_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #388
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x128_mod2
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x128_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x128_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x128_mod2
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	movw.w r11, #0
	movw.w r12, #0
	add.w lr, r0, #96
add_loop_vs_128:
	ldr.w r2, [r10, #96]
	ldr.w r3, [r10, #100]
	ldr.w r4, [r10, #104]
	ldr.w r5, [r10, #108]
	ldr.w r6, [r10, #288]
	ldr.w r7, [r10, #292]
	ldr.w r8, [r10, #296]
	ldr.w r9, [r10, #300]
	vmov.w s0, s1, r0, r1
	ubfx.w r1, r2, #28, #1
	eor.w r2, r12, r2, LSL #4
	ubfx.w r12, r3, #28, #1
	eor.w r3, r1, r3, LSL #4
	ubfx.w r1, r4, #28, #1
	eor.w r4, r12, r4, LSL #4
	ubfx.w r12, r5, #28, #1
	eor.w r5, r1, r5, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #192]
	ldr.w r7, [r10, #196]
	ldr.w r8, [r10, #200]
	ldr.w r9, [r10, #204]
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
	bne.w add_loop_vs_128
	add.w sp, #388
	pop.w {r3-r12,pc}
// void __update_VS_64x192_mod2 (int *V, int *S, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_VS_64x192_mod2
.type __update_VS_64x192_mod2, %function
__update_VS_64x192_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #516
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x192_mod2
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x192_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x192_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x192_mod2
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	movw.w r11, #0
	movw.w r12, #0
	add.w lr, r0, #128
add_loop_vs_192:
	ldr.w r2, [r10, #128]
	ldr.w r3, [r10, #132]
	ldr.w r4, [r10, #136]
	ldr.w r5, [r10, #140]
	ldr.w r6, [r10, #384]
	ldr.w r7, [r10, #388]
	ldr.w r8, [r10, #392]
	ldr.w r9, [r10, #396]
	vmov.w s0, s1, r0, r1
	ubfx.w r1, r2, #28, #1
	eor.w r2, r12, r2, LSL #4
	ubfx.w r12, r3, #28, #1
	eor.w r3, r1, r3, LSL #4
	ubfx.w r1, r4, #28, #1
	eor.w r4, r12, r4, LSL #4
	ubfx.w r12, r5, #28, #1
	eor.w r5, r1, r5, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #256]
	ldr.w r7, [r10, #260]
	ldr.w r8, [r10, #264]
	ldr.w r9, [r10, #268]
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
	bne.w add_loop_vs_192
	add.w sp, #516
	pop.w {r3-r12,pc}
// void __update_VS_64x256_mod2 (int *V, int *S, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_VS_64x256_mod2
.type __update_VS_64x256_mod2, %function
__update_VS_64x256_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #644
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x256_mod2
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x256_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x256_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x256_mod2
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	movw.w r11, #0
	movw.w r12, #0
	add.w lr, r0, #160
add_loop_vs_256:
	ldr.w r2, [r10, #160]
	ldr.w r3, [r10, #164]
	ldr.w r4, [r10, #168]
	ldr.w r5, [r10, #172]
	ldr.w r6, [r10, #480]
	ldr.w r7, [r10, #484]
	ldr.w r8, [r10, #488]
	ldr.w r9, [r10, #492]
	vmov.w s0, s1, r0, r1
	ubfx.w r1, r2, #28, #1
	eor.w r2, r12, r2, LSL #4
	ubfx.w r12, r3, #28, #1
	eor.w r3, r1, r3, LSL #4
	ubfx.w r1, r4, #28, #1
	eor.w r4, r12, r4, LSL #4
	ubfx.w r12, r5, #28, #1
	eor.w r5, r1, r5, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #320]
	ldr.w r7, [r10, #324]
	ldr.w r8, [r10, #328]
	ldr.w r9, [r10, #332]
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
	bne.w add_loop_vs_256
	add.w sp, #644
	pop.w {r3-r12,pc}
// void __update_VS_64x320_mod2 (int *V, int *S, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_VS_64x320_mod2
.type __update_VS_64x320_mod2, %function
__update_VS_64x320_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #772
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x320_mod2
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x320_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x320_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x320_mod2
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	movw.w r11, #0
	movw.w r12, #0
	add.w lr, r0, #192
add_loop_vs_320:
	ldr.w r2, [r10, #192]
	ldr.w r3, [r10, #196]
	ldr.w r4, [r10, #200]
	ldr.w r5, [r10, #204]
	ldr.w r6, [r10, #576]
	ldr.w r7, [r10, #580]
	ldr.w r8, [r10, #584]
	ldr.w r9, [r10, #588]
	vmov.w s0, s1, r0, r1
	ubfx.w r1, r2, #28, #1
	eor.w r2, r12, r2, LSL #4
	ubfx.w r12, r3, #28, #1
	eor.w r3, r1, r3, LSL #4
	ubfx.w r1, r4, #28, #1
	eor.w r4, r12, r4, LSL #4
	ubfx.w r12, r5, #28, #1
	eor.w r5, r1, r5, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #384]
	ldr.w r7, [r10, #388]
	ldr.w r8, [r10, #392]
	ldr.w r9, [r10, #396]
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
	bne.w add_loop_vs_320
	add.w sp, #772
	pop.w {r3-r12,pc}
// void __update_VS_64x384_mod2 (int *V, int *S, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_VS_64x384_mod2
.type __update_VS_64x384_mod2, %function
__update_VS_64x384_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #900
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x384_mod2
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x384_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x384_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x384_mod2
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	movw.w r11, #0
	movw.w r12, #0
	add.w lr, r0, #224
add_loop_vs_384:
	ldr.w r2, [r10, #224]
	ldr.w r3, [r10, #228]
	ldr.w r4, [r10, #232]
	ldr.w r5, [r10, #236]
	ldr.w r6, [r10, #672]
	ldr.w r7, [r10, #676]
	ldr.w r8, [r10, #680]
	ldr.w r9, [r10, #684]
	vmov.w s0, s1, r0, r1
	ubfx.w r1, r2, #28, #1
	eor.w r2, r12, r2, LSL #4
	ubfx.w r12, r3, #28, #1
	eor.w r3, r1, r3, LSL #4
	ubfx.w r1, r4, #28, #1
	eor.w r4, r12, r4, LSL #4
	ubfx.w r12, r5, #28, #1
	eor.w r5, r1, r5, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #448]
	ldr.w r7, [r10, #452]
	ldr.w r8, [r10, #456]
	ldr.w r9, [r10, #460]
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
	bne.w add_loop_vs_384
	add.w sp, #900
	pop.w {r3-r12,pc}
// void __update_VS_64x448_mod2 (int *V, int *S, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_VS_64x448_mod2
.type __update_VS_64x448_mod2, %function
__update_VS_64x448_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1028
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x448_mod2
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x448_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x448_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x448_mod2
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	movw.w r11, #0
	movw.w r12, #0
	add.w lr, r0, #256
add_loop_vs_448:
	ldr.w r2, [r10, #256]
	ldr.w r3, [r10, #260]
	ldr.w r4, [r10, #264]
	ldr.w r5, [r10, #268]
	ldr.w r6, [r10, #768]
	ldr.w r7, [r10, #772]
	ldr.w r8, [r10, #776]
	ldr.w r9, [r10, #780]
	vmov.w s0, s1, r0, r1
	ubfx.w r1, r2, #28, #1
	eor.w r2, r12, r2, LSL #4
	ubfx.w r12, r3, #28, #1
	eor.w r3, r1, r3, LSL #4
	ubfx.w r1, r4, #28, #1
	eor.w r4, r12, r4, LSL #4
	ubfx.w r12, r5, #28, #1
	eor.w r5, r1, r5, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #512]
	ldr.w r7, [r10, #516]
	ldr.w r8, [r10, #520]
	ldr.w r9, [r10, #524]
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
	bne.w add_loop_vs_448
	add.w sp, #1028
	pop.w {r3-r12,pc}
// void __update_VS_64x512_mod2 (int *V, int *S, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_VS_64x512_mod2
.type __update_VS_64x512_mod2, %function
__update_VS_64x512_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1156
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x512_mod2
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x512_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x512_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x512_mod2
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	movw.w r11, #0
	movw.w r12, #0
	add.w lr, r0, #288
add_loop_vs_512:
	ldr.w r2, [r10, #288]
	ldr.w r3, [r10, #292]
	ldr.w r4, [r10, #296]
	ldr.w r5, [r10, #300]
	ldr.w r6, [r10, #864]
	ldr.w r7, [r10, #868]
	ldr.w r8, [r10, #872]
	ldr.w r9, [r10, #876]
	vmov.w s0, s1, r0, r1
	ubfx.w r1, r2, #28, #1
	eor.w r2, r12, r2, LSL #4
	ubfx.w r12, r3, #28, #1
	eor.w r3, r1, r3, LSL #4
	ubfx.w r1, r4, #28, #1
	eor.w r4, r12, r4, LSL #4
	ubfx.w r12, r5, #28, #1
	eor.w r5, r1, r5, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #576]
	ldr.w r7, [r10, #580]
	ldr.w r8, [r10, #584]
	ldr.w r9, [r10, #588]
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
	bne.w add_loop_vs_512
	add.w sp, #1156
	pop.w {r3-r12,pc}
// void __update_VS_64x576_mod2 (int *V, int *S, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_VS_64x576_mod2
.type __update_VS_64x576_mod2, %function
__update_VS_64x576_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1284
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x576_mod2
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x576_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x576_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x576_mod2
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	movw.w r11, #0
	movw.w r12, #0
	add.w lr, r0, #320
add_loop_vs_576:
	ldr.w r2, [r10, #320]
	ldr.w r3, [r10, #324]
	ldr.w r4, [r10, #328]
	ldr.w r5, [r10, #332]
	ldr.w r6, [r10, #960]
	ldr.w r7, [r10, #964]
	ldr.w r8, [r10, #968]
	ldr.w r9, [r10, #972]
	vmov.w s0, s1, r0, r1
	ubfx.w r1, r2, #28, #1
	eor.w r2, r12, r2, LSL #4
	ubfx.w r12, r3, #28, #1
	eor.w r3, r1, r3, LSL #4
	ubfx.w r1, r4, #28, #1
	eor.w r4, r12, r4, LSL #4
	ubfx.w r12, r5, #28, #1
	eor.w r5, r1, r5, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #640]
	ldr.w r7, [r10, #644]
	ldr.w r8, [r10, #648]
	ldr.w r9, [r10, #652]
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
	bne.w add_loop_vs_576
	add.w sp, #1284
	pop.w {r3-r12,pc}
// void __update_VS_64x640_mod2 (int *V, int *S, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_VS_64x640_mod2
.type __update_VS_64x640_mod2, %function
__update_VS_64x640_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1412
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x640_mod2
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x640_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x640_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x640_mod2
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	movw.w r11, #0
	movw.w r12, #0
	add.w lr, r0, #352
add_loop_vs_640:
	ldr.w r2, [r10, #352]
	ldr.w r3, [r10, #356]
	ldr.w r4, [r10, #360]
	ldr.w r5, [r10, #364]
	ldr.w r6, [r10, #1056]
	ldr.w r7, [r10, #1060]
	ldr.w r8, [r10, #1064]
	ldr.w r9, [r10, #1068]
	vmov.w s0, s1, r0, r1
	ubfx.w r1, r2, #28, #1
	eor.w r2, r12, r2, LSL #4
	ubfx.w r12, r3, #28, #1
	eor.w r3, r1, r3, LSL #4
	ubfx.w r1, r4, #28, #1
	eor.w r4, r12, r4, LSL #4
	ubfx.w r12, r5, #28, #1
	eor.w r5, r1, r5, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #704]
	ldr.w r7, [r10, #708]
	ldr.w r8, [r10, #712]
	ldr.w r9, [r10, #716]
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
	bne.w add_loop_vs_640
	add.w sp, #1412
	pop.w {r3-r12,pc}
// void __update_VS_64x704_mod2 (int *V, int *S, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_VS_64x704_mod2
.type __update_VS_64x704_mod2, %function
__update_VS_64x704_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1412
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x704_mod2
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x704_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x704_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x704_mod2
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	movw.w r11, #0
	movw.w r12, #0
	add.w lr, r0, #352
add_loop_vs_704:
	ldr.w r2, [r10, #352]
	ldr.w r3, [r10, #356]
	ldr.w r4, [r10, #360]
	ldr.w r5, [r10, #364]
	ldr.w r6, [r10, #1056]
	ldr.w r7, [r10, #1060]
	ldr.w r8, [r10, #1064]
	ldr.w r9, [r10, #1068]
	vmov.w s0, s1, r0, r1
	ubfx.w r1, r2, #28, #1
	eor.w r2, r12, r2, LSL #4
	ubfx.w r12, r3, #28, #1
	eor.w r3, r1, r3, LSL #4
	ubfx.w r1, r4, #28, #1
	eor.w r4, r12, r4, LSL #4
	ubfx.w r12, r5, #28, #1
	eor.w r5, r1, r5, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #704]
	ldr.w r7, [r10, #708]
	ldr.w r8, [r10, #712]
	ldr.w r9, [r10, #716]
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
	bne.w add_loop_vs_704
	add.w sp, #1412
	pop.w {r3-r12,pc}
// void __update_VS_64x736_mod2 (int *V, int *S, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_VS_64x736_mod2
.type __update_VS_64x736_mod2, %function
__update_VS_64x736_mod2:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1604
	mov.w r0, sp
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x736_mod2
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #64
	bl __polymul_64x736_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #32
	bl __polymul_64x736_mod2
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #96
	bl __polymul_64x736_mod2
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	movw.w r11, #0
	movw.w r12, #0
	add.w lr, r0, #368
add_loop_vs_736:
	ldr.w r2, [r10, #400]
	ldr.w r3, [r10, #404]
	ldr.w r4, [r10, #408]
	ldr.w r5, [r10, #412]
	ldr.w r6, [r10, #1200]
	ldr.w r7, [r10, #1204]
	ldr.w r8, [r10, #1208]
	ldr.w r9, [r10, #1212]
	vmov.w s0, s1, r0, r1
	ubfx.w r1, r2, #28, #1
	eor.w r2, r12, r2, LSL #4
	ubfx.w r12, r3, #28, #1
	eor.w r3, r1, r3, LSL #4
	ubfx.w r1, r4, #28, #1
	eor.w r4, r12, r4, LSL #4
	ubfx.w r12, r5, #28, #1
	eor.w r5, r1, r5, LSL #4
	vmov.w r0, r1, s0, s1
	eor.w r2, r6
	eor.w r3, r7
	eor.w r4, r8
	eor.w r5, r9
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #800]
	ldr.w r7, [r10, #804]
	ldr.w r8, [r10, #808]
	ldr.w r9, [r10, #812]
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
	bne.w add_loop_vs_736
	add.w sp, #1604
	pop.w {r3-r12,pc}
