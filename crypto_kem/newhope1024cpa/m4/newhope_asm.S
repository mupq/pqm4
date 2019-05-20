	.macro montgomery a, q, t  
	  sub \t,\q,#2
	  mul \t,\a,\t
	  ubfx \t,\t,#0,#18
	  mla \t,\t,\q,\a
	  lsr \a,\t,#18
    .endm

	.macro barrett a, q, t
	  mov \t,#5
	  smulwb \t,\a,\t
	  mls \a,\t,\q,\a
	.endm
	.macro butterfly a0,a1,q,t
      mov \t,#3
	  mla \t,\q,\t,\a0
	  sub \t,\t,\a1
	  add \a0,\a1
	.endm

    .macro butterfly_without_barrett a0,a1,w,q,t
	  butterfly \a0,\a1,\q,\t
	  mul \a1,\t,\w
	  montgomery \a1,\q,\t
	.endm
	
    .macro butterfly_with_barrett a0,a1,w,q,t
	  butterfly \a0,\a1,\q,\t
	  barrett \a0,\q,\a1
	  mul \a1,\t,\w
	  montgomery \a1,\q,\t
	.endm
	
	.global	ntt
	.type	ntt, %function
	//
    .align 4
	.syntax unified
	.cpu cortex-m4
    // r0=&a, r1=&omegas
	// r2 loop counter
	// r3 to r10 8 elements of a, in that way we are able to merge 3 layers in one loop
	// r11 omegas[i]
	// r12 temp var.
	// r14 q and -R^{-1}
ntt:
	push {r0-r12,lr}	
	// set r14 as q
	mov r14,#3
    lsl r14,#12
	add r14,#1
	// set the loop counter to zero (zero because I am using it in address calculation of omegas)
	mov r2,#0
	push {r0,r1}
    // First 3 layers
firstloop:
	// Calculate starting address of omegas for first layer (add 4 times r2)
	lsl r11,r2,#2
	add r1,r11
	// Load 8 element of a
	ldrh r3,[r0],#2
	ldrh r4,[r0],#2
	ldrh r5,[r0],#2
	ldrh r6,[r0],#2
	ldrh r7,[r0],#2
	ldrh r8,[r0],#2
	ldrh r9,[r0],#2
	ldrh r10,[r0],#2
	// Now r0 point to next element of array a
	//
	// first layer
	// load 1. omega
	ldrh r11,[r1]
	butterfly_without_barrett r3,r4,r11,r14,r12
	// load 2. omega
	ldrh r11,[r1,#2]
	butterfly_without_barrett r5,r6,r11,r14,r12
	// load 3. omega 
	ldrh r11,[r1,#4]
    butterfly_without_barrett r7,r8,r11,r14,r12
	// load 4. omega 
	ldrh r11,[r1,#6]
	butterfly_without_barrett r9,r10,r11,r14,r12
	
	// second layer
	// Calculate starting address of omegas for first layer (add 2 times r2)
	lsl r11,r2,#1
	sub r1,r11
	ldrh r11,[r1]
	butterfly_with_barrett r3,r5,r11,r14,r12
	butterfly_with_barrett r4,r6,r11,r14,r12
	// 
	ldrh r11,[r1,#2]
    butterfly_with_barrett r7,r9,r11,r14,r12
	butterfly_with_barrett r8,r10,r11,r14,r12

	// third layer
	// Calculate starting address of omegas for first layer (add r2) 
	sub r1,r2
	// in this layer we need just one omega, so r11 shouldn't change...
	ldrh r11,[r1]
	butterfly_without_barrett r3,r7,r11,r14,r12
	butterfly_without_barrett r4,r8,r11,r14,r12
   	butterfly_without_barrett r5,r9,r11,r14,r12
	butterfly_without_barrett r6,r10,r11,r14,r12
	
	// r0 pointing next element of array, so we have to calculate relative addresses
	strh r3,[r0,#-16]
	strh r4,[r0,#-14]
	strh r5,[r0,#-12]
	strh r6,[r0,#-10]
	strh r7,[r0,#-8]
	strh r8,[r0,#-6]
	strh r9,[r0,#-4]
	strh r10,[r0,#-2]
	// change r1 back to original address of omegas
	sub r1,r2
    add r2,#2
	// because we use loop counter 0 to n, we have to use cmp. It is not good...
	cmp r2,#256
	bne firstloop



    pop {r0,r1}
	push {r0,r1}
    // 4., 5., 6. layers merged 

	mov r2,#0
secondloop:
	//
	lsl r11,r2,#2
	add r1,r11
	mov r11,#0

inloop:
	push {r1,r11}
    ldrh r3,[r0]
	ldrh r4,[r0,#16]
	ldrh r5,[r0,#32]
	ldrh r6,[r0,#48]
	ldrh r7,[r0,#64]
	ldrh r8,[r0,#80]
	ldrh r9,[r0,#96]
	ldrh r10,[r0,#112]
	// fourth layer
	ldrh r11,[r1]
	butterfly_with_barrett r3,r4,r11,r14,r12
	//
	ldrh r11,[r1,#2]
	butterfly_with_barrett r5,r6,r11,r14,r12
	// 
	ldrh r11,[r1,#4]
    butterfly_with_barrett r7,r8,r11,r14,r12
	//
	ldrh r11,[r1,#6]
	butterfly_with_barrett r9,r10,r11,r14,r12
	
	// fifth layer
	lsl r11,r2,#1
	sub r1,r11
	ldrh r11,[r1]
	butterfly_without_barrett r3,r5,r11,r14,r12
	butterfly_without_barrett r4,r6,r11,r14,r12
	// 
	ldrh r11,[r1,#2]
    butterfly_without_barrett r7,r9,r11,r14,r12
	butterfly_without_barrett r8,r10,r11,r14,r12

	// sixth layer
	sub r1,r2
	ldrh r11,[r1]
	butterfly_with_barrett r3,r7,r11,r14,r12
	butterfly_with_barrett r4,r8,r11,r14,r12
	butterfly_with_barrett r5,r9,r11,r14,r12
	butterfly_with_barrett r6,r10,r11,r14,r12
	
	strh r10,[r0,#112]
	strh r9,[r0,#96]
	strh r8,[r0,#80]
	strh r7,[r0,#64]
	strh r6,[r0,#48]
	strh r5,[r0,#32]
	strh r4,[r0,#16]
	strh r3,[r0],#2
    pop {r1,r11}
	add r11,#1
	cmp r11,#8
	bne inloop
    
	add r0,#112
	lsl r11,r2,#2
	sub r1,r11
    add r2,#2
	cmp r2,#32
	bne secondloop
	
	mov r2,#0

    pop {r0,r1}  
    push {r0,r1}

    // 7., 8, 9. layers merged and unrolled to merge with 10. layer
	// first half calculate 7., 8., 9. layers with a[0:512]
	// And it uses no multiplication for omegas[0]=1
firsthalf:
	ldrh r3,[r0]
	ldrh r4,[r0,#128]
	ldrh r5,[r0,#256]
	ldrh r6,[r0,#384]
	ldrh r7,[r0,#512]
	ldrh r8,[r0,#640]
	ldrh r9,[r0,#768]
	ldrh r10,[r0,#896]
	// seventh layer
	//
	butterfly r3,r4,r14,r12
	mov r4,r12
	//
	ldrh r11,[r1,#2]
	butterfly_without_barrett r5,r6,r11,r14,r12
	// 
	ldrh r11,[r1,#4]
    butterfly_without_barrett r7,r8,r11,r14,r12
	//
	ldrh r11,[r1,#6]
	butterfly_without_barrett r9,r10,r11,r14,r12
	
	// eighth layer
	//
	butterfly r3,r5,r14,r12
	barrett r3,r14,r5
	barrett r12,r14,r5
	butterfly r4,r6,r14,r5
	barrett r4,r14,r6
	barrett r5,r14,r6
	// 
	ldrh r11,[r1,#2]
    butterfly_with_barrett r7,r9,r11,r14,r6
	butterfly_with_barrett r8,r10,r11,r14,r6

	// nineth layer
	//
	butterfly r3,r7,r14,r6
	butterfly r4,r8,r14,r7
	butterfly r12,r9,r14,r8
	butterfly r5,r10,r14,r9
    
	strh r9,[r0,#896]
	strh r8,[r0,#768]
	strh r7,[r0,#640]
	strh r6,[r0,#512]
	strh r5,[r0,#384]
	strh r12,[r0,#256]
	strh r4,[r0,#128]
	strh r3,[r0],#2
	add r2,#2
	cmp r2,#128
	bne firsthalf

	pop {r0,r1}
    add r0,#1024
	mov r2,#0
	// second half of 7., 8. and 9. layers 
	// it calculates second half of output of 9. layer
	// And load first half value and calculate 10. layer
	// again no need to multiply with omegas[0]=1
lasthalf:
	ldrh r3,[r0]
	ldrh r4,[r0,#128]
	ldrh r5,[r0,#256]
	ldrh r6,[r0,#384]
	ldrh r7,[r0,#512]
	ldrh r8,[r0,#640]
	ldrh r9,[r0,#768]
	ldrh r10,[r0,#896]
	// seventh layer
	ldrh r11,[r1,#8]
	butterfly_without_barrett r3,r4,r11,r14,r12
	//
	ldrh r11,[r1,#10]
	butterfly_without_barrett r5,r6,r11,r14,r12
	// 
	ldrh r11,[r1,#12]
    butterfly_without_barrett r7,r8,r11,r14,r12
	//
	ldrh r11,[r1,#14]
	butterfly_without_barrett r9,r10,r11,r14,r12
	//
	// eighth layer
	ldrh r11,[r1,#4]
    butterfly_with_barrett r3,r5,r11,r14,r12
	butterfly_with_barrett r4,r6,r11,r14,r12
	// 
	ldrh r11,[r1,#6]
    butterfly_with_barrett r7,r9,r11,r14,r12
	butterfly_with_barrett r8,r10,r11,r14,r12
    //
	// nineth layer
	ldrh r11,[r1,#2]
	// 
	butterfly_without_barrett r3,r7,r11,r14,r12
	butterfly_without_barrett r4,r8,r11,r14,r12
	butterfly_without_barrett r5,r9,r11,r14,r12
	butterfly_without_barrett r6,r10,r11,r14,r12

	sub r0,#1024
	// address of omegas won't be used after this point
	// so we can use r1 as a 3q 
	push {r1,r2}
	lsl r1,r14,#1
	add r1,r14
	
	ldrh r11,[r0,#896]
	ldrh r2,[r0,#768]
	
	add r12,r11,r1
	sub r12,r12,r10
	add r10,r11
	barrett r10,r14,r11
	barrett r12,r14,r11
	
	add r11,r2,r1
	sub r11,r11,r9
	add r9,r2
	barrett r9,r14,r2
	barrett r11,r14,r2

    strh r9,[r0,#768]
	strh r10,[r0,#896]
	strh r11,[r0,#1792]
	strh r12,[r0,#1920]
	ldrh r11,[r0,#640]
	ldrh r10,[r0,#512]
	ldrh r9,[r0,#384]
	ldrh r2,[r0,#256]
	
	add r12,r11,r1
	sub r12,r12,r8
	add r8,r11
	barrett r8,r14,r11
	barrett r12,r14,r11

	add r11,r10,r1
	sub r11,r11,r7
	add r7,r10
	barrett r7,r14,r10
	barrett r11,r14,r10

	add r10,r9,r1
	sub r10,r10,r6
	add r6,r9
	barrett r6,r14,r9
	barrett r10,r14,r9

	add r9,r2,r1
	sub r9,r9,r5
	add r5,r2
	barrett r5,r14,r2
	barrett r9,r14,r2
	
	strh r8,[r0,#640]
	strh r7,[r0,#512]
	strh r6,[r0,#384]
	strh r5,[r0,#256]
	strh r12,[r0,#1664]
	strh r11,[r0,#1536]
	strh r10,[r0,#1408]
	strh r9,[r0,#1280]
	ldrh r11,[r0,#128]
	ldrh r10,[r0]
	
	// r12,r4
	add r12,r11,r1
	sub r12,r12,r4
	add r4,r11
	barrett r12,r14,r11
	barrett r4,r14,r11
	// r11,r3
    add r11,r10,r1
	sub r11,r11,r3
	add r3,r10
	barrett r11,r14,r10
	barrett r3,r14,r10
	
	strh r4,[r0,#128]
	strh r12,[r0,#1152]
	strh r11,[r0,#1024]
	strh r3,[r0],#2
    
	pop {r1,r2}
	add r0,#1024
	add r2,#2
	cmp r2,#128
	bne lasthalf
	
	pop {r0-r12,pc}	

	.global	barrett_reduce
	.type	barrett_reduce, %function
barrett_reduce:
    push {r1-r12,lr}

    mov r2,#3
    lsl r2,#12
	add r2,#1
	barrett r0,r2,r1
	
	pop {r1-r12,pc}
	
	.global	mul_coeff
	.type	mul_coeff, %function
	// Multiplication with psis with using omegas
	// unaligned loads and store add one cycle each block
    .align 4
	.syntax unified
	.cpu cortex-m4

mul_coeff:
    push {r0-r12,lr}

    mov r2, #128
	// set r14 as q
	mov r14,#3
    lsl r14,#12
	add r14,#1

	sub r12,r14,#2
	mov r11,#7
	add r10,r0,#1024
looppsis1:
    
	ldm r0,{r3,r4}
	ldm r1!,{r7,r8}
	
	smulbb r5,r3,r7
	mul r9,r5,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r5
	lsr r5,r9,#18
	smultt r6,r3,r7
	mul r9,r6,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r6
	lsr r6,r9,#2
	pkhbt r3, r5, r6
	
	smulbb r5,r4,r8
	mul r9,r5,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r5
	lsr r5,r9,#18
	smultt r6,r4,r8
	mul r9,r6,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r6
	lsr r6,r9,#2
	pkhbt r4, r5, r6

	stm r0!,{r3,r4}


	ldm r10,{r5,r6}
	
	smulbb r3,r5,r7
	mul r3,r11
	mul r9,r3,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r3
	lsr r3,r9,#18
	smultt r7,r5,r7
	mul r7,r11
	mul r9,r7,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r7
	lsr r7,r9,#2
	pkhbt r5, r3, r7
	
	smulbb r3,r6,r8
	mul r3,r11
	mul r9,r3,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r3
	lsr r3,r9,#18
	smultt r8,r6,r8
	mul r8,r11
	mul r9,r8,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r8
	lsr r8,r9,#2
	pkhbt r6, r3, r8

	stm r10!,{r5,r6}

    sub r2,#1
	cmp r2,#0
	bne looppsis1
	
	pop {r0-r12,pc}	


	.global	mul_coefficients
	.type	mul_coefficients, %function
	// unaligned loads and store add one cycle each block
    .align 4
	.syntax unified
	.cpu cortex-m4

mul_coefficients:
    push {r0-r12,lr}

    mov r2, #128
	// set r14 as q
	mov r14,#3
    lsl r14,#12
	add r14,#1
	sub r12,r14,#2
	mov r11,#0
looptop:
    
	ldm r0,{r3,r4}
	ldm r1!,{r7,r8}
	
	smulbb r5,r3,r7
	mul r9,r5,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r5
	lsr r5,r9,#18
	smultt r6,r3,r7
	mul r9,r6,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r6
	lsr r6,r9,#2
	pkhbt r3, r5, r6
	
	smulbb r5,r4,r8
	mul r9,r5,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r5
	lsr r5,r9,#18
	smultt r6,r4,r8
	mul r9,r6,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r6
	lsr r6,r9,#2
	pkhbt r4, r5, r6

	ldrd r5,r6,[r0,#8]
	ldm r1!,{r7,r8}
	
	smulbb r10,r5,r7
	mul r9,r10,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r10
	lsr r10,r9,#18
	smultt r7,r5,r7
	mul r9,r7,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r7
	lsr r7,r9,#2
	pkhbt r5, r10, r7
	
	smulbb r10,r6,r8
	mul r9,r10,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r10
	lsr r10,r9,#18
	smultt r8,r6,r8
	mul r9,r8,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r8
	lsr r8,r9,#2
	pkhbt r6, r10, r8

    stm r0!,{r3,r4,r5,r6}

    sub r2,#1
	cmp r2,#0
	bne looptop
	
	pop {r0-r12,pc}	

    .global bitrev_vector
    .type bitrev_vector, %function
    .align 2
	.syntax unified
	.cpu cortex-m4

bitrev_vector:
    push {r0-r12,lr}
    mov r1,#2
	rbit r2,r1
	lsr r2,#20
	mov r5,#7 
	lsl r5,#8
	add r5,#190
looptopb:
	ldrh r3,[r0,r1]
    ldrh r4,[r0,r2]
    strh r3,[r0,r2]
    strh r4,[r0,r1]
	cmp r1,r5
	beq exit
loopin:
    add r1,#2
	rbit r2,r1
	lsr r2,#20
	cmp r2,r1
	ble loopin
    b looptopb
exit:
	pop {r0-r12,pc}

	.global	poly_pointwise
	.type	poly_pointwise, %function
	// unaligned loads and store add one cycle each block
    .align 4
	.syntax unified
	.cpu cortex-m4

poly_pointwise:
    push {r0-r12,lr}

    mov r10, #128
	// set r14 as q
	mov r14,#3
    lsl r14,#12
	add r14,#1
	sub r12,r14,#2
	mov r11,#3072
	add r11,#114
looptopp:
   	ldm r1!,{r3,r4}
	ldm r2!,{r7,r8}
	push {r10}
	
	smulbb r5,r11,r7
	mul r9,r5,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r5
	lsr r5,r9,#18
	smulbb r5,r5,r3
	mul r9,r5,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r5
	lsr r5,r9,#18
	smulbt r6,r11,r7
	mul r9,r6,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r6
	lsr r6,r9,#18
	smulbt r6,r6,r3
	mul r9,r6,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r6
	lsr r6,r9,#2
	pkhbt r3, r5, r6
	
	smulbb r5,r11,r8
	mul r9,r5,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r5
	lsr r5,r9,#18
	smulbb r5,r5,r4
	mul r9,r5,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r5
	lsr r5,r9,#18
	smulbt r6,r11,r8
	mul r9,r6,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r6
	lsr r6,r9,#18
	smulbt r6,r6,r4
	mul r9,r6,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r6
	lsr r6,r9,#2
	pkhbt r4, r5, r6

	ldrd r5,r6,[r1],#8
	ldm r2!,{r7,r8}
	
	smulbb r10,r11,r7
	mul r9,r10,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r10
	lsr r10,r9,#18
	smulbb r10,r10,r5
	mul r9,r10,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r10
	lsr r10,r9,#18
	smulbt r7,r11,r7
	mul r9,r7,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r7
	lsr r7,r9,#18
	smulbt r7,r7,r5
	mul r9,r7,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r7
	lsr r7,r9,#2
	pkhbt r5, r10, r7
	
	smulbb r10,r11,r8
	mul r9,r10,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r10
	lsr r10,r9,#18
	smulbb r10,r10,r6
	mul r9,r10,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r10
	lsr r10,r9,#18
	smulbt r8,r11,r8
	mul r9,r8,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r8
	lsr r8,r9,#18
	smulbt r8,r8,r6
	mul r9,r8,r12
	ubfx r9,r9,#0,#18
	mla r9,r9,r14,r8
	lsr r8,r9,#2
	pkhbt r6, r10, r8
    pop {r10}
    stm r0!,{r3,r4,r5,r6}

    sub r10,#1
	cmp r10,#0
	bne looptopp
	
	pop {r0-r12,pc}	


