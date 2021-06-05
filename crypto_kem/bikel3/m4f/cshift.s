// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain

.syntax unified

// void cshift_asm(uint32_t *array, int s)
.global cshift_asm
cshift_asm:
ptr_a 		.req r0
s 			.req r1
ptr_end		.req r2
ptr_end2	.req r3
Rx0			.req r4
Rx1			.req r5
Rx2			.req r6
Rx3			.req r7
Ry0			.req r8
Ry1			.req r9
Ry2			.req r10
Ry3			.req r11
ptr			.req r12
ptr2		.req r14
  push {r4-r11, lr}

  // conditional shifting 512 blocks

  lsr Ry0, s, #14
  and Ry0, #1
  mov Rx0, #983040
  mul Ry0, Rx0
  msr APSR_g, Ry0
  add ptr, ptr_a, #-16
  add ptr2, ptr, #4096
  add ptr_end, ptr, #2048
  loop512_a:
    ldr Rx0, [ptr, #16]!
    ldr Rx1, [ptr, #4]
    ldr Rx2, [ptr, #8]
    ldr Rx3, [ptr, #12]
      ldr Ry0, [ptr, #2048]
      ldr Ry1, [ptr, #2052]
      ldr Ry2, [ptr, #2056]
      ldr Ry3, [ptr, #2060]
      sel Rx0, Ry0, Rx0
      sel Rx1, Ry1, Rx1
      sel Rx2, Ry2, Rx2
      sel Rx3, Ry3, Rx3
      str Rx0, [ptr, #0]
      str Rx1, [ptr, #4]
      str Rx2, [ptr, #8]
      str Rx3, [ptr, #12]
      ldr Rx0, [ptr2, #16]!
      ldr Rx1, [ptr2, #4]
      ldr Rx2, [ptr2, #8]
      ldr Rx3, [ptr2, #12]
      sel Ry0, Rx0, Ry0
      sel Ry1, Rx1, Ry1
      sel Ry2, Rx2, Ry2
      sel Ry3, Rx3, Ry3
      str Ry0, [ptr, #2048]
      str Ry1, [ptr, #2052]
      str Ry2, [ptr, #2056]
      str Ry3, [ptr, #2060]
    teq ptr_end, ptr
    bne loop512_a

  mov ptr, ptr_a
  add ptr, #4096
  add ptr_end, ptr, #24
  loop512_b:
    ldr Rx0, [ptr]
    ldr Ry0, [ptr, #2048]
    sel Rx0, Ry0, Rx0
    str Rx0, [ptr], #4
    teq ptr, ptr_end
    bne loop512_b

  // conditional shifting 256 blocks

  lsr Ry0, s, #13
  and Ry0, #1
  mov Rx0, #983040
  mul Ry0, Rx0
  msr APSR_g, Ry0
  add ptr, ptr_a, #-16
  add ptr_end, ptr, #1024
  loop256_a:
    ldr Rx0, [ptr, #16]!
    ldr Rx1, [ptr, #4]
    ldr Rx2, [ptr, #8]
    ldr Rx3, [ptr, #12]
    add ptr_end2, ptr, #4096
    loop256_aa:
      ldr Ry0, [ptr, #1024]
      ldr Ry1, [ptr, #1028]
      ldr Ry2, [ptr, #1032]
      ldr Ry3, [ptr, #1036]
      sel Rx0, Ry0, Rx0
      sel Rx1, Ry1, Rx1
      sel Rx2, Ry2, Rx2
      sel Rx3, Ry3, Rx3
      str Rx0, [ptr, #0]
      str Rx1, [ptr, #4]
      str Rx2, [ptr, #8]
      str Rx3, [ptr, #12]
      ldr Rx0, [ptr, #2048]
      ldr Rx1, [ptr, #2052]
      ldr Rx2, [ptr, #2056]
      ldr Rx3, [ptr, #2060]
      sel Ry0, Rx0, Ry0
      sel Ry1, Rx1, Ry1
      sel Ry2, Rx2, Ry2
      sel Ry3, Rx3, Ry3
      str Ry0, [ptr, #1024]
      str Ry1, [ptr, #1028]
      str Ry2, [ptr, #1032]
      str Ry3, [ptr, #1036]
      add ptr, #2048
      teq ptr_end2, ptr
      bne loop256_aa
    sub ptr, #4096
    teq ptr_end, ptr
    bne loop256_a

  mov ptr, ptr_a
  add ptr, #4096
  ldr Rx0, [ptr, #0]
  ldr Ry0, [ptr, #1024]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #0]
  ldr Rx0, [ptr, #4]
  ldr Ry0, [ptr, #1028]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #4]
  ldr Rx0, [ptr, #8]
  ldr Ry0, [ptr, #1032]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #8]

  // conditional shifting 128 blocks

  lsr Ry0, s, #12
  and Ry0, #1
  mov Rx0, #983040
  mul Ry0, Rx0
  msr APSR_g, Ry0
  add ptr, ptr_a, #-16
  add ptr_end, ptr, #512
  loop128_a:
    ldr Rx0, [ptr, #16]!
    ldr Rx1, [ptr, #4]
    ldr Rx2, [ptr, #8]
    ldr Rx3, [ptr, #12]
    add ptr_end2, ptr, #3072
    loop128_aa:
      ldr Ry0, [ptr, #512]
      ldr Ry1, [ptr, #516]
      ldr Ry2, [ptr, #520]
      ldr Ry3, [ptr, #524]
      sel Rx0, Ry0, Rx0
      sel Rx1, Ry1, Rx1
      sel Rx2, Ry2, Rx2
      sel Rx3, Ry3, Rx3
      str Rx0, [ptr, #0]
      str Rx1, [ptr, #4]
      str Rx2, [ptr, #8]
      str Rx3, [ptr, #12]
      ldr Rx0, [ptr, #1024]
      ldr Rx1, [ptr, #1028]
      ldr Rx2, [ptr, #1032]
      ldr Rx3, [ptr, #1036]
      sel Ry0, Rx0, Ry0
      sel Ry1, Rx1, Ry1
      sel Ry2, Rx2, Ry2
      sel Ry3, Rx3, Ry3
      str Ry0, [ptr, #512]
      str Ry1, [ptr, #516]
      str Ry2, [ptr, #520]
      str Ry3, [ptr, #524]
      add ptr, #1024
      teq ptr_end2, ptr
      bne loop128_aa
    ldr Ry0, [ptr, #512]
    ldr Ry1, [ptr, #516]
    ldr Ry2, [ptr, #520]
    ldr Ry3, [ptr, #524]
    sel Rx0, Ry0, Rx0
    sel Rx1, Ry1, Rx1
    sel Rx2, Ry2, Rx2
    sel Rx3, Ry3, Rx3
    str Rx0, [ptr, #0]
    str Rx1, [ptr, #4]
    str Rx2, [ptr, #8]
    str Rx3, [ptr, #12]
    sub ptr, #3072
    teq ptr_end, ptr
    bne loop128_a

  mov ptr, ptr_a
  add ptr, #3584
  ldr Rx0, [ptr, #0]
  ldr Ry0, [ptr, #512]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #0]
  ldr Rx0, [ptr, #4]
  ldr Ry0, [ptr, #516]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #4]
  ldr Rx0, [ptr, #8]
  ldr Ry0, [ptr, #520]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #8]

  // conditional shifting 64 blocks

  lsr Ry0, s, #11
  and Ry0, #1
  mov Rx0, #983040
  mul Ry0, Rx0
  msr APSR_g, Ry0
  add ptr, ptr_a, #-16
  add ptr_end, ptr, #256
  loop64_a:
    ldr Rx0, [ptr, #16]!
    ldr Rx1, [ptr, #4]
    ldr Rx2, [ptr, #8]
    ldr Rx3, [ptr, #12]
    add ptr_end2, ptr, #3072
    loop64_aa:
      ldr Ry0, [ptr, #256]
      ldr Ry1, [ptr, #260]
      ldr Ry2, [ptr, #264]
      ldr Ry3, [ptr, #268]
      sel Rx0, Ry0, Rx0
      sel Rx1, Ry1, Rx1
      sel Rx2, Ry2, Rx2
      sel Rx3, Ry3, Rx3
      str Rx0, [ptr, #0]
      str Rx1, [ptr, #4]
      str Rx2, [ptr, #8]
      str Rx3, [ptr, #12]
      ldr Rx0, [ptr, #512]
      ldr Rx1, [ptr, #516]
      ldr Rx2, [ptr, #520]
      ldr Rx3, [ptr, #524]
      sel Ry0, Rx0, Ry0
      sel Ry1, Rx1, Ry1
      sel Ry2, Rx2, Ry2
      sel Ry3, Rx3, Ry3
      str Ry0, [ptr, #256]
      str Ry1, [ptr, #260]
      str Ry2, [ptr, #264]
      str Ry3, [ptr, #268]
      add ptr, #512
      teq ptr_end2, ptr
      bne loop64_aa
    ldr Ry0, [ptr, #256]
    ldr Ry1, [ptr, #260]
    ldr Ry2, [ptr, #264]
    ldr Ry3, [ptr, #268]
    sel Rx0, Ry0, Rx0
    sel Rx1, Ry1, Rx1
    sel Rx2, Ry2, Rx2
    sel Rx3, Ry3, Rx3
    str Rx0, [ptr, #0]
    str Rx1, [ptr, #4]
    str Rx2, [ptr, #8]
    str Rx3, [ptr, #12]
    sub ptr, #3072
    teq ptr_end, ptr
    bne loop64_a

  mov ptr, ptr_a
  add ptr, #3328
  ldr Rx0, [ptr, #0]
  ldr Ry0, [ptr, #256]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #0]
  ldr Rx0, [ptr, #4]
  ldr Ry0, [ptr, #260]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #4]
  ldr Rx0, [ptr, #8]
  ldr Ry0, [ptr, #264]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #8]

  // conditional shifting 32 blocks

  lsr Ry0, s, #10
  and Ry0, #1
  mov Rx0, #983040
  mul Ry0, Rx0
  msr APSR_g, Ry0
  add ptr, ptr_a, #-16
  add ptr_end, ptr, #128
  loop32_a:
    ldr Rx0, [ptr, #16]!
    ldr Rx1, [ptr, #4]
    ldr Rx2, [ptr, #8]
    ldr Rx3, [ptr, #12]
    add ptr_end2, ptr, #3072
    loop32_aa:
      ldr Ry0, [ptr, #128]
      ldr Ry1, [ptr, #132]
      ldr Ry2, [ptr, #136]
      ldr Ry3, [ptr, #140]
      sel Rx0, Ry0, Rx0
      sel Rx1, Ry1, Rx1
      sel Rx2, Ry2, Rx2
      sel Rx3, Ry3, Rx3
      str Rx0, [ptr, #0]
      str Rx1, [ptr, #4]
      str Rx2, [ptr, #8]
      str Rx3, [ptr, #12]
      ldr Rx0, [ptr, #256]
      ldr Rx1, [ptr, #260]
      ldr Rx2, [ptr, #264]
      ldr Rx3, [ptr, #268]
      sel Ry0, Rx0, Ry0
      sel Ry1, Rx1, Ry1
      sel Ry2, Rx2, Ry2
      sel Ry3, Rx3, Ry3
      str Ry0, [ptr, #128]
      str Ry1, [ptr, #132]
      str Ry2, [ptr, #136]
      str Ry3, [ptr, #140]
      add ptr, #256
      teq ptr_end2, ptr
      bne loop32_aa
    ldr Ry0, [ptr, #128]
    ldr Ry1, [ptr, #132]
    ldr Ry2, [ptr, #136]
    ldr Ry3, [ptr, #140]
    sel Rx0, Ry0, Rx0
    sel Rx1, Ry1, Rx1
    sel Rx2, Ry2, Rx2
    sel Rx3, Ry3, Rx3
    str Rx0, [ptr, #0]
    str Rx1, [ptr, #4]
    str Rx2, [ptr, #8]
    str Rx3, [ptr, #12]
    sub ptr, #3072
    teq ptr_end, ptr
    bne loop32_a

  mov ptr, ptr_a
  add ptr, #3200
  ldr Rx0, [ptr, #0]
  ldr Ry0, [ptr, #128]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #0]
  ldr Rx0, [ptr, #4]
  ldr Ry0, [ptr, #132]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #4]
  ldr Rx0, [ptr, #8]
  ldr Ry0, [ptr, #136]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #8]

  // conditional shifting 16 blocks

  lsr Ry0, s, #9
  and Ry0, #1
  mov Rx0, #983040
  mul Ry0, Rx0
  msr APSR_g, Ry0
  add ptr, ptr_a, #-16
  add ptr_end, ptr, #64
  loop16_a:
    ldr Rx0, [ptr, #16]!
    ldr Rx1, [ptr, #4]
    ldr Rx2, [ptr, #8]
    ldr Rx3, [ptr, #12]
    add ptr_end2, ptr, #3072
    loop16_aa:
      ldr Ry0, [ptr, #64]
      ldr Ry1, [ptr, #68]
      ldr Ry2, [ptr, #72]
      ldr Ry3, [ptr, #76]
      sel Rx0, Ry0, Rx0
      sel Rx1, Ry1, Rx1
      sel Rx2, Ry2, Rx2
      sel Rx3, Ry3, Rx3
      str Rx0, [ptr, #0]
      str Rx1, [ptr, #4]
      str Rx2, [ptr, #8]
      str Rx3, [ptr, #12]
      ldr Rx0, [ptr, #128]!
      ldr Rx1, [ptr, #4]
      ldr Rx2, [ptr, #8]
      ldr Rx3, [ptr, #12]
      sel Ry0, Rx0, Ry0
      sel Ry1, Rx1, Ry1
      sel Ry2, Rx2, Ry2
      sel Ry3, Rx3, Ry3
      str Ry0, [ptr, #-64]
      str Ry1, [ptr, #-60]
      str Ry2, [ptr, #-56]
      str Ry3, [ptr, #-52]
      teq ptr_end2, ptr
      bne loop16_aa
    ldr Ry0, [ptr, #64]
    ldr Ry1, [ptr, #68]
    ldr Ry2, [ptr, #72]
    ldr Ry3, [ptr, #76]
    sel Rx0, Ry0, Rx0
    sel Rx1, Ry1, Rx1
    sel Rx2, Ry2, Rx2
    sel Rx3, Ry3, Rx3
    str Rx0, [ptr, #0]
    str Rx1, [ptr, #4]
    str Rx2, [ptr, #8]
    str Rx3, [ptr, #12]
    sub ptr, #3072
    teq ptr_end, ptr
    bne loop16_a

  mov ptr, ptr_a
  add ptr, #3136
  ldr Rx0, [ptr, #0]
  ldr Ry0, [ptr, #64]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #0]
  ldr Rx0, [ptr, #4]
  ldr Ry0, [ptr, #68]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #4]
  ldr Rx0, [ptr, #8]
  ldr Ry0, [ptr, #72]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #8]

  // conditional shifting 8 blocks

  lsr Ry0, s, #8
  and Ry0, #1
  mov Rx0, #983040
  mul Ry0, Rx0
  msr APSR_g, Ry0
  add ptr, ptr_a, #-16
  add ptr_end, ptr, #32
  loop8_a:
    ldr Rx0, [ptr, #16]!
    ldr Rx1, [ptr, #4]
    ldr Rx2, [ptr, #8]
    ldr Rx3, [ptr, #12]
    add ptr_end2, ptr, #3072
    loop8_aa:
      ldr Ry0, [ptr, #32]
      ldr Ry1, [ptr, #36]
      ldr Ry2, [ptr, #40]
      ldr Ry3, [ptr, #44]
      sel Rx0, Ry0, Rx0
      sel Rx1, Ry1, Rx1
      sel Rx2, Ry2, Rx2
      sel Rx3, Ry3, Rx3
      str Rx0, [ptr, #0]
      str Rx1, [ptr, #4]
      str Rx2, [ptr, #8]
      str Rx3, [ptr, #12]
      ldr Rx0, [ptr, #64]!
      ldr Rx1, [ptr, #4]
      ldr Rx2, [ptr, #8]
      ldr Rx3, [ptr, #12]
      sel Ry0, Rx0, Ry0
      sel Ry1, Rx1, Ry1
      sel Ry2, Rx2, Ry2
      sel Ry3, Rx3, Ry3
      str Ry0, [ptr, #-32]
      str Ry1, [ptr, #-28]
      str Ry2, [ptr, #-24]
      str Ry3, [ptr, #-20]
      teq ptr_end2, ptr
      bne loop8_aa
    ldr Ry0, [ptr, #32]
    ldr Ry1, [ptr, #36]
    ldr Ry2, [ptr, #40]
    ldr Ry3, [ptr, #44]
    sel Rx0, Ry0, Rx0
    sel Rx1, Ry1, Rx1
    sel Rx2, Ry2, Rx2
    sel Rx3, Ry3, Rx3
    str Rx0, [ptr, #0]
    str Rx1, [ptr, #4]
    str Rx2, [ptr, #8]
    str Rx3, [ptr, #12]
    sub ptr, #3072
    teq ptr_end, ptr
    bne loop8_a

  mov ptr, ptr_a
  add ptr, #3104
  ldr Rx0, [ptr, #0]
  ldr Ry0, [ptr, #32]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #0]
  ldr Rx0, [ptr, #4]
  ldr Ry0, [ptr, #36]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #4]
  ldr Rx0, [ptr, #8]
  ldr Ry0, [ptr, #40]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #8]

  // conditional shifting 4 blocks

  lsr Ry0, s, #7
  and Ry0, #1
  mov Rx0, #983040
  mul Ry0, Rx0
  msr APSR_g, Ry0
  add ptr, ptr_a, #-16
    ldr Rx0, [ptr, #16]!
    ldr Rx1, [ptr, #4]
    ldr Rx2, [ptr, #8]
    ldr Rx3, [ptr, #12]
    add ptr_end2, ptr, #3072
    loop4_aa:
      ldr Ry0, [ptr, #16]
      ldr Ry1, [ptr, #20]
      ldr Ry2, [ptr, #24]
      ldr Ry3, [ptr, #28]
      sel Rx0, Ry0, Rx0
      sel Rx1, Ry1, Rx1
      sel Rx2, Ry2, Rx2
      sel Rx3, Ry3, Rx3
      str Rx0, [ptr, #0]
      str Rx1, [ptr, #4]
      str Rx2, [ptr, #8]
      str Rx3, [ptr, #12]
      ldr Rx0, [ptr, #32]!
      ldr Rx1, [ptr, #4]
      ldr Rx2, [ptr, #8]
      ldr Rx3, [ptr, #12]
      sel Ry0, Rx0, Ry0
      sel Ry1, Rx1, Ry1
      sel Ry2, Rx2, Ry2
      sel Ry3, Rx3, Ry3
      str Ry0, [ptr, #-16]
      str Ry1, [ptr, #-12]
      str Ry2, [ptr, #-8]
      str Ry3, [ptr, #-4]
      teq ptr_end2, ptr
      bne loop4_aa
    ldr Ry0, [ptr, #16]
    ldr Ry1, [ptr, #20]
    ldr Ry2, [ptr, #24]
    ldr Ry3, [ptr, #28]
    sel Rx0, Ry0, Rx0
    sel Rx1, Ry1, Rx1
    sel Rx2, Ry2, Rx2
    sel Rx3, Ry3, Rx3
    str Rx0, [ptr, #0]
    str Rx1, [ptr, #4]
    str Rx2, [ptr, #8]
    str Rx3, [ptr, #12]

  mov ptr, ptr_a
  add ptr, #3088
  ldr Rx0, [ptr, #0]
  ldr Ry0, [ptr, #16]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #0]
  ldr Rx0, [ptr, #4]
  ldr Ry0, [ptr, #20]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #4]
  ldr Rx0, [ptr, #8]
  ldr Ry0, [ptr, #24]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #8]

  // conditional shifting 2 blocks

  lsr Ry0, s, #6
  and Ry0, #1
  mov Rx0, #983040
  mul Ry0, Rx0
  msr APSR_g, Ry0
  add ptr, ptr_a, #-8
    ldr Rx0, [ptr, #8]!
    ldr Rx1, [ptr, #4]
    add ptr_end2, ptr, #3088
    loop2_aa:
      ldr Ry0, [ptr, #8]
      ldr Ry1, [ptr, #12]
      sel Rx0, Ry0, Rx0
      sel Rx1, Ry1, Rx1
      str Rx0, [ptr, #0]
      str Rx1, [ptr, #4]
      ldr Rx0, [ptr, #16]!
      ldr Rx1, [ptr, #4]
      sel Ry0, Rx0, Ry0
      sel Ry1, Rx1, Ry1
      str Ry0, [ptr, #-8]
      str Ry1, [ptr, #-4]
      teq ptr_end2, ptr
      bne loop2_aa

  mov ptr, ptr_a
  add ptr, #3088
  ldr Rx0, [ptr, #0]
  ldr Ry0, [ptr, #8]
  sel Rx0, Ry0, Rx0
  str Rx0, [ptr, #0]

  // conditional shifting 1 blocks

  lsr Ry0, s, #5
  and Ry0, #1
  mov Rx0, #983040
  mul Ry0, Rx0
  msr APSR_g, Ry0
  add ptr, ptr_a, #-4
    ldr Rx0, [ptr, #4]!
    add ptr_end2, ptr, #3088
    loop1_aa:
      ldr Ry0, [ptr, #4]
      sel Rx0, Ry0, Rx0
      str Rx0, [ptr, #0]
      ldr Rx0, [ptr, #8]!
      sel Ry0, Rx0, Ry0
      str Ry0, [ptr, #-4]
      ldr Ry0, [ptr, #4]
      sel Rx0, Ry0, Rx0
      str Rx0, [ptr, #0]
      ldr Rx0, [ptr, #8]!
      sel Ry0, Rx0, Ry0
      str Ry0, [ptr, #-4]
      teq ptr_end2, ptr
      bne loop1_aa

 pop {r4-r11, pc}
 .unreq ptr_a
 .unreq s
 .unreq ptr_end
 .unreq ptr_end2
 .unreq Rx0
 .unreq Rx1
 .unreq Rx2
 .unreq Rx3
 .unreq Ry0
 .unreq Ry1
 .unreq Ry2
 .unreq Ry3
 .unreq ptr
 .unreq ptr2
