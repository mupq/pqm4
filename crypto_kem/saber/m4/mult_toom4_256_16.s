# This assembly file is automatically generated. Do not modify it directly.
# The code generator is available at https://github.com/mupq/polymul-z2mx-m4
# - Matthias Kannwischer, Joost Rijneveld, and Peter Schwabe, 2018, Public Domain

.syntax unified
.cpu cortex-m4
.global schoolbook_16x16
.type schoolbook_16x16, %function
.align 2
schoolbook_16x16:
push {lr}
ldr r6, [r1, #0]
ldr.w ip, [r1, #4]
ldr.w r3, [r1, #8]
ldr.w sl, [r1, #12]
ldr.w r7, [r2, #0]
ldr.w r8, [r2, #4]
ldr.w r4, [r2, #8]
ldr.w lr, [r2, #12]
smulbb r9, r7, r6
smuadx fp, r7, r6
pkhbt r9, r9, fp, lsl #16
str.w r9, [r0]
smuadx fp, r7, ip
smulbb r5, r7, ip
pkhbt r9, r8, r7
smladx fp, r8, r6, fp
smlad r5, r9, r6, r5
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #4]
smulbb r5, r3, r7
smuadx fp, r3, r7
smlad r5, r9, ip, r5
pkhbt r9, r4, r8
smlad r5, r9, r6, r5
smladx fp, r8, ip, fp
smladx fp, r4, r6, fp
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #8]
smulbb r5, sl, r7
smuadx fp, sl, r7
smlad r5, ip, r9, r5
pkhbt r9, r8, r7
smlad r5, r3, r9, r5
pkhbt r9, lr, r4
smlad r5, r6, r9, r5
smladx fp, r3, r8, fp
smladx fp, ip, r4, fp
smladx fp, r6, lr, fp
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #12]
smultt r5, r6, lr
smuadx fp, sl, r8
smlad r5, ip, r9, r5
pkhbt r9, r8, r7
smlad r5, sl, r9, r5
pkhbt r9, r4, r8
smlad r5, r3, r9, r5
smladx fp, r3, r4, fp
smladx fp, ip, lr, fp
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #16]
smultt r5, ip, lr
smuadx fp, sl, r4
smlad r5, sl, r9, r5
pkhbt r9, lr, r4
smlad r5, r3, r9, r5
smladx fp, r3, lr, fp
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #20]
smuad r5, sl, r9
smuadx fp, sl, lr
smlatt r5, r3, lr, r5
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #24]
smultt fp, sl, lr
movt fp, #0
str.w fp, [r0, #28]
ldr.w r7, [r2, #16]
ldr.w r8, [r2, #20]
ldr.w r4, [r2, #24]
ldr.w lr, [r2, #28]
ldr.w r9, [r0, #16]
ldr.w r5, [r0, #20]
mov.w fp, r9, lsr #16
smlabb r9, r7, r6, r9
smladx fp, r7, r6, fp
pkhbt r9, r9, fp, lsl #16
str.w r9, [r0, #16]
mov.w fp, r5, lsr #16
smladx fp, r7, ip, fp
smlabb r5, r7, ip, r5
pkhbt r9, r8, r7
smladx fp, r8, r6, fp
smlad r5, r9, r6, r5
pkhbt fp, r5, fp, lsl #16
ldr.w r5, [r0, #24]
str.w fp, [r0, #20]
mov.w fp, r5, lsr #16
smlabb r5, r3, r7, r5
smladx fp, r3, r7, fp
smlad r5, r9, ip, r5
pkhbt r9, r4, r8
smlad r5, r9, r6, r5
smladx fp, r8, ip, fp
smladx fp, r4, r6, fp
pkhbt fp, r5, fp, lsl #16
ldr.w r5, [r0, #28]
str.w fp, [r0, #24]
mov.w fp, r5, lsr #16
smlabb r5, sl, r7, r5
smladx fp, sl, r7, fp
smlad r5, ip, r9, r5
pkhbt r9, r8, r7
smlad r5, r3, r9, r5
pkhbt r9, lr, r4
smlad r5, r6, r9, r5
smladx fp, r3, r8, fp
smladx fp, ip, r4, fp
smladx fp, r6, lr, fp
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #28]
smultt r5, r6, lr
smuadx fp, sl, r8
smlad r5, ip, r9, r5
pkhbt r9, r8, r7
smlad r5, sl, r9, r5
pkhbt r9, r4, r8
smlad r5, r3, r9, r5
smladx fp, r3, r4, fp
smladx fp, ip, lr, fp
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #32]
smultt r5, ip, lr
smuadx fp, sl, r4
smlad r5, sl, r9, r5
pkhbt r9, lr, r4
smlad r5, r3, r9, r5
smladx fp, r3, lr, fp
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #36]
smuad r5, sl, r9
smuadx fp, sl, lr
smlatt r5, r3, lr, r5
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #40]
smultt fp, sl, lr
movt fp, #0
str.w fp, [r0, #44]
ldr.w r6, [r1, #16]
ldr.w ip, [r1, #20]
ldr.w r3, [r1, #24]
ldr.w sl, [r1, #28]
ldr.w r9, [r0, #32]
ldr.w r5, [r0, #36]
mov.w fp, r9, lsr #16
smlabb r9, r7, r6, r9
smladx fp, r7, r6, fp
pkhbt r9, r9, fp, lsl #16
str.w r9, [r0, #32]
mov.w fp, r5, lsr #16
smladx fp, r7, ip, fp
smlabb r5, r7, ip, r5
pkhbt r9, r8, r7
smladx fp, r8, r6, fp
smlad r5, r9, r6, r5
pkhbt fp, r5, fp, lsl #16
ldr.w r5, [r0, #40]
str.w fp, [r0, #36]
mov.w fp, r5, lsr #16
smlabb r5, r3, r7, r5
smladx fp, r3, r7, fp
smlad r5, r9, ip, r5
pkhbt r9, r4, r8
smlad r5, r9, r6, r5
smladx fp, r8, ip, fp
smladx fp, r4, r6, fp
pkhbt fp, r5, fp, lsl #16
ldr.w r5, [r0, #44]
str.w fp, [r0, #40]
mov.w fp, r5, lsr #16
smlabb r5, sl, r7, r5
smladx fp, sl, r7, fp
smlad r5, ip, r9, r5
pkhbt r9, r8, r7
smlad r5, r3, r9, r5
pkhbt r9, lr, r4
smlad r5, r6, r9, r5
smladx fp, r3, r8, fp
smladx fp, ip, r4, fp
smladx fp, r6, lr, fp
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #44]
smultt r5, r6, lr
smuadx fp, sl, r8
smlad r5, ip, r9, r5
pkhbt r9, r8, r7
smlad r5, sl, r9, r5
pkhbt r9, r4, r8
smlad r5, r3, r9, r5
smladx fp, r3, r4, fp
smladx fp, ip, lr, fp
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #48]
smultt r5, ip, lr
smuadx fp, sl, r4
smlad r5, sl, r9, r5
pkhbt r9, lr, r4
smlad r5, r3, r9, r5
smladx fp, r3, lr, fp
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #52]
smuad r5, sl, r9
smuadx fp, sl, lr
smlatt r5, r3, lr, r5
pkhbt fp, r5, fp, lsl #16
str.w fp, [r0, #56]
smultt fp, sl, lr
strh.w fp, [r0, #60]
ldr.w r7, [r2, #0]
ldr.w r8, [r2, #4]
ldr.w r4, [r2, #8]
ldr.w lr, [r2, #12]
ldr.w r9, [r0, #16]
ldr.w r5, [r0, #20]
mov.w fp, r9, lsr #16
smlabb r9, r7, r6, r9
smladx fp, r7, r6, fp
pkhbt r9, r9, fp, lsl #16
str.w r9, [r0, #16]
mov.w fp, r5, lsr #16
smladx fp, r7, ip, fp
smlabb r5, r7, ip, r5
pkhbt r9, r8, r7
smladx fp, r8, r6, fp
smlad r5, r9, r6, r5
pkhbt fp, r5, fp, lsl #16
ldr.w r5, [r0, #24]
str.w fp, [r0, #20]
mov.w fp, r5, lsr #16
smlabb r5, r3, r7, r5
smladx fp, r3, r7, fp
smlad r5, r9, ip, r5
pkhbt r9, r4, r8
smlad r5, r9, r6, r5
smladx fp, r8, ip, fp
smladx fp, r4, r6, fp
pkhbt fp, r5, fp, lsl #16
ldr.w r5, [r0, #28]
str.w fp, [r0, #24]
mov.w fp, r5, lsr #16
smlabb r5, sl, r7, r5
smladx fp, sl, r7, fp
smlad r5, ip, r9, r5
pkhbt r9, r8, r7
smlad r5, r3, r9, r5
pkhbt r9, lr, r4
smlad r5, r6, r9, r5
smladx fp, r3, r8, fp
smladx fp, ip, r4, fp
smladx fp, r6, lr, fp
pkhbt fp, r5, fp, lsl #16
ldr.w r5, [r0, #32]
str.w fp, [r0, #28]
mov.w fp, r5, lsr #16
smlatt r5, r6, lr, r5
smladx fp, sl, r8, fp
smlad r5, ip, r9, r5
pkhbt r9, r8, r7
smlad r5, sl, r9, r5
pkhbt r9, r4, r8
smlad r5, r3, r9, r5
smladx fp, r3, r4, fp
smladx fp, ip, lr, fp
pkhbt fp, r5, fp, lsl #16
ldr.w r5, [r0, #36]
str.w fp, [r0, #32]
mov.w fp, r5, lsr #16
smlatt r5, ip, lr, r5
smladx fp, sl, r4, fp
smlad r5, sl, r9, r5
pkhbt r9, lr, r4
smlad r5, r3, r9, r5
smladx fp, r3, lr, fp
pkhbt fp, r5, fp, lsl #16
ldr.w r5, [r0, #40]
str.w fp, [r0, #36]
mov.w fp, r5, lsr #16
smlad r5, sl, r9, r5
smladx fp, sl, lr, fp
smlatt r5, r3, lr, r5
pkhbt fp, r5, fp, lsl #16
ldrh.w r5, [r0, #44]
str.w fp, [r0, #40]
smlatt fp, sl, lr, r5
strh.w fp, [r0, #44]
ldr.w lr, [sp], #4
bx lr
.global karatsuba_64x64
.type karatsuba_64x64, %function
.align 2
karatsuba_64x64:
push.w {lr}
bl schoolbook_16x16
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #32
add.w r2, r2, #32
add.w r0, r0, #64
bl schoolbook_16x16
sub.w r1, r1, #32
sub.w r2, r2, #32
sub sp, #128
ldr r3, [r1, #0]
ldr r4, [r1, #32]
ldr r5, [r1, #4]
ldr r6, [r1, #36]
ldr r7, [r1, #8]
ldr.w r8, [r1, #40]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #44]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #48]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #52]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
str r0, [sp, #20]
ldr r3, [r1, #24]
ldr r4, [r1, #56]
ldr r5, [r1, #28]
ldr.w r6, [r1, #60]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
str r3, [sp, #24]
str r5, [sp, #28]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #32]
ldr r5, [r2, #4]
ldr r6, [r2, #36]
ldr r7, [r2, #8]
ldr.w r8, [r2, #40]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #44]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #48]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #52]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #32]
str r5, [sp, #36]
str.w r7, [sp, #40]
str.w r9, [sp, #44]
str.w fp, [sp, #48]
str r0, [sp, #52]
ldr r3, [r2, #24]
ldr r4, [r2, #56]
ldr r5, [r2, #28]
ldr.w r6, [r2, #60]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
str r3, [sp, #56]
str r5, [sp, #60]
add r2, sp, #32
add r0, sp, #64
bl schoolbook_16x16
mov r3, r0
ldr r0, [sp, #128]
ldr r5, [r3, #0]
ldr r6, [r3, #32]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #32]
ldr.w r9, [r0, #64]
ldr.w sl, [r0, #96]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #32]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #64]
ldr r5, [r3, #4]
ldr r6, [r3, #36]
ldr r7, [r0, #4]
ldr.w r8, [r0, #36]
ldr.w r9, [r0, #68]
ldr.w sl, [r0, #100]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #36]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #68]
ldr r5, [r3, #8]
ldr r6, [r3, #40]
ldr r7, [r0, #8]
ldr.w r8, [r0, #40]
ldr.w r9, [r0, #72]
ldr.w sl, [r0, #104]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #40]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #72]
ldr r5, [r3, #12]
ldr r6, [r3, #44]
ldr r7, [r0, #12]
ldr.w r8, [r0, #44]
ldr.w r9, [r0, #76]
ldr.w sl, [r0, #108]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #44]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #76]
ldr r5, [r3, #16]
ldr r6, [r3, #48]
ldr r7, [r0, #16]
ldr.w r8, [r0, #48]
ldr.w r9, [r0, #80]
ldr.w sl, [r0, #112]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #48]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #80]
ldr r5, [r3, #20]
ldr r6, [r3, #52]
ldr r7, [r0, #20]
ldr.w r8, [r0, #52]
ldr.w r9, [r0, #84]
ldr.w sl, [r0, #116]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #52]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #84]
ldr r5, [r3, #24]
ldr r6, [r3, #56]
ldr r7, [r0, #24]
ldr.w r8, [r0, #56]
ldr.w r9, [r0, #88]
ldr.w sl, [r0, #120]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #56]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #88]
ldrh r5, [r3, #28]
ldrh r6, [r3, #60]
ldrh r7, [r0, #28]
ldrh.w r8, [r0, #60]
ldrh.w r9, [r0, #92]
ldrh.w sl, [r0, #124]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #60]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #92]
ldrh r5, [r3, #30]
ldrh r7, [r0, #30]
ldrh.w r9, [r0, #94]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #62]
add sp, #132
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #64
add.w r2, r2, #64
add.w r0, r0, #128
bl schoolbook_16x16
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #32
add.w r2, r2, #32
add.w r0, r0, #64
bl schoolbook_16x16
sub.w r1, r1, #32
sub.w r2, r2, #32
sub sp, #128
ldr r3, [r1, #0]
ldr r4, [r1, #32]
ldr r5, [r1, #4]
ldr r6, [r1, #36]
ldr r7, [r1, #8]
ldr.w r8, [r1, #40]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #44]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #48]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #52]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
str r0, [sp, #20]
ldr r3, [r1, #24]
ldr r4, [r1, #56]
ldr r5, [r1, #28]
ldr.w r6, [r1, #60]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
str r3, [sp, #24]
str r5, [sp, #28]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #32]
ldr r5, [r2, #4]
ldr r6, [r2, #36]
ldr r7, [r2, #8]
ldr.w r8, [r2, #40]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #44]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #48]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #52]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #32]
str r5, [sp, #36]
str.w r7, [sp, #40]
str.w r9, [sp, #44]
str.w fp, [sp, #48]
str r0, [sp, #52]
ldr r3, [r2, #24]
ldr r4, [r2, #56]
ldr r5, [r2, #28]
ldr.w r6, [r2, #60]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
str r3, [sp, #56]
str r5, [sp, #60]
add r2, sp, #32
add r0, sp, #64
bl schoolbook_16x16
mov r3, r0
ldr r0, [sp, #128]
ldr r5, [r3, #0]
ldr r6, [r3, #32]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #32]
ldr.w r9, [r0, #64]
ldr.w sl, [r0, #96]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #32]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #64]
ldr r5, [r3, #4]
ldr r6, [r3, #36]
ldr r7, [r0, #4]
ldr.w r8, [r0, #36]
ldr.w r9, [r0, #68]
ldr.w sl, [r0, #100]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #36]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #68]
ldr r5, [r3, #8]
ldr r6, [r3, #40]
ldr r7, [r0, #8]
ldr.w r8, [r0, #40]
ldr.w r9, [r0, #72]
ldr.w sl, [r0, #104]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #40]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #72]
ldr r5, [r3, #12]
ldr r6, [r3, #44]
ldr r7, [r0, #12]
ldr.w r8, [r0, #44]
ldr.w r9, [r0, #76]
ldr.w sl, [r0, #108]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #44]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #76]
ldr r5, [r3, #16]
ldr r6, [r3, #48]
ldr r7, [r0, #16]
ldr.w r8, [r0, #48]
ldr.w r9, [r0, #80]
ldr.w sl, [r0, #112]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #48]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #80]
ldr r5, [r3, #20]
ldr r6, [r3, #52]
ldr r7, [r0, #20]
ldr.w r8, [r0, #52]
ldr.w r9, [r0, #84]
ldr.w sl, [r0, #116]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #52]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #84]
ldr r5, [r3, #24]
ldr r6, [r3, #56]
ldr r7, [r0, #24]
ldr.w r8, [r0, #56]
ldr.w r9, [r0, #88]
ldr.w sl, [r0, #120]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #56]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #88]
ldrh r5, [r3, #28]
ldrh r6, [r3, #60]
ldrh r7, [r0, #28]
ldrh.w r8, [r0, #60]
ldrh.w r9, [r0, #92]
ldrh.w sl, [r0, #124]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #60]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #92]
ldrh r5, [r3, #30]
ldrh r7, [r0, #30]
ldrh.w r9, [r0, #94]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #62]
add sp, #132
pop {r2}
pop.w {r1}
sub.w r1, r1, #64
sub.w r2, r2, #64
sub sp, #256
ldr r3, [r1, #0]
ldr r4, [r1, #64]
ldr r5, [r1, #4]
ldr r6, [r1, #68]
ldr r7, [r1, #8]
ldr.w r8, [r1, #72]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #76]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #80]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
str r0, [sp, #20]
ldr r3, [r1, #24]
ldr r4, [r1, #88]
ldr r5, [r1, #28]
ldr r6, [r1, #92]
ldr r7, [r1, #32]
ldr.w r8, [r1, #96]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #100]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #104]
ldr.w r0, [r1, #44]
ldr.w lr, [r1, #108]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
str r0, [sp, #44]
ldr r3, [r1, #48]
ldr r4, [r1, #112]
ldr r5, [r1, #52]
ldr r6, [r1, #116]
ldr r7, [r1, #56]
ldr.w r8, [r1, #120]
ldr.w r9, [r1, #60]
ldr.w sl, [r1, #124]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
str r3, [sp, #48]
str r5, [sp, #52]
str.w r7, [sp, #56]
str.w r9, [sp, #60]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #64]
ldr r5, [r2, #4]
ldr r6, [r2, #68]
ldr r7, [r2, #8]
ldr.w r8, [r2, #72]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #76]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #80]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #64]
str r5, [sp, #68]
str.w r7, [sp, #72]
str.w r9, [sp, #76]
str.w fp, [sp, #80]
str r0, [sp, #84]
ldr r3, [r2, #24]
ldr r4, [r2, #88]
ldr r5, [r2, #28]
ldr r6, [r2, #92]
ldr r7, [r2, #32]
ldr.w r8, [r2, #96]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #100]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #104]
ldr.w r0, [r2, #44]
ldr.w lr, [r2, #108]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #88]
str r5, [sp, #92]
str.w r7, [sp, #96]
str.w r9, [sp, #100]
str.w fp, [sp, #104]
str r0, [sp, #108]
ldr r3, [r2, #48]
ldr r4, [r2, #112]
ldr r5, [r2, #52]
ldr r6, [r2, #116]
ldr r7, [r2, #56]
ldr.w r8, [r2, #120]
ldr.w r9, [r2, #60]
ldr.w sl, [r2, #124]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
str r3, [sp, #112]
str r5, [sp, #116]
str.w r7, [sp, #120]
str.w r9, [sp, #124]
add r2, sp, #64
add r0, sp, #128
bl schoolbook_16x16
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #32
add.w r2, r2, #32
add.w r0, r0, #64
bl schoolbook_16x16
sub.w r1, r1, #32
sub.w r2, r2, #32
sub sp, #128
ldr r3, [r1, #0]
ldr r4, [r1, #32]
ldr r5, [r1, #4]
ldr r6, [r1, #36]
ldr r7, [r1, #8]
ldr.w r8, [r1, #40]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #44]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #48]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #52]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
str r0, [sp, #20]
ldr r3, [r1, #24]
ldr r4, [r1, #56]
ldr r5, [r1, #28]
ldr.w r6, [r1, #60]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
str r3, [sp, #24]
str r5, [sp, #28]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #32]
ldr r5, [r2, #4]
ldr r6, [r2, #36]
ldr r7, [r2, #8]
ldr.w r8, [r2, #40]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #44]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #48]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #52]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #32]
str r5, [sp, #36]
str.w r7, [sp, #40]
str.w r9, [sp, #44]
str.w fp, [sp, #48]
str r0, [sp, #52]
ldr r3, [r2, #24]
ldr r4, [r2, #56]
ldr r5, [r2, #28]
ldr.w r6, [r2, #60]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
str r3, [sp, #56]
str r5, [sp, #60]
add r2, sp, #32
add r0, sp, #64
bl schoolbook_16x16
mov r3, r0
ldr r0, [sp, #128]
ldr r5, [r3, #0]
ldr r6, [r3, #32]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #32]
ldr.w r9, [r0, #64]
ldr.w sl, [r0, #96]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #32]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #64]
ldr r5, [r3, #4]
ldr r6, [r3, #36]
ldr r7, [r0, #4]
ldr.w r8, [r0, #36]
ldr.w r9, [r0, #68]
ldr.w sl, [r0, #100]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #36]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #68]
ldr r5, [r3, #8]
ldr r6, [r3, #40]
ldr r7, [r0, #8]
ldr.w r8, [r0, #40]
ldr.w r9, [r0, #72]
ldr.w sl, [r0, #104]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #40]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #72]
ldr r5, [r3, #12]
ldr r6, [r3, #44]
ldr r7, [r0, #12]
ldr.w r8, [r0, #44]
ldr.w r9, [r0, #76]
ldr.w sl, [r0, #108]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #44]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #76]
ldr r5, [r3, #16]
ldr r6, [r3, #48]
ldr r7, [r0, #16]
ldr.w r8, [r0, #48]
ldr.w r9, [r0, #80]
ldr.w sl, [r0, #112]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #48]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #80]
ldr r5, [r3, #20]
ldr r6, [r3, #52]
ldr r7, [r0, #20]
ldr.w r8, [r0, #52]
ldr.w r9, [r0, #84]
ldr.w sl, [r0, #116]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #52]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #84]
ldr r5, [r3, #24]
ldr r6, [r3, #56]
ldr r7, [r0, #24]
ldr.w r8, [r0, #56]
ldr.w r9, [r0, #88]
ldr.w sl, [r0, #120]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #56]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #88]
ldrh r5, [r3, #28]
ldrh r6, [r3, #60]
ldrh r7, [r0, #28]
ldrh.w r8, [r0, #60]
ldrh.w r9, [r0, #92]
ldrh.w sl, [r0, #124]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #60]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #92]
ldrh r5, [r3, #30]
ldrh r7, [r0, #30]
ldrh.w r9, [r0, #94]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #62]
add sp, #132
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #256]
ldr r5, [r3, #0]
ldr r6, [r3, #64]
ldr r7, [r0, #0]
ldr.w r8, [r0, #64]
ldr.w r9, [r0, #128]
ldr.w sl, [r0, #192]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #64]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #128]
ldr r5, [r3, #4]
ldr r6, [r3, #68]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #68]
ldr.w r9, [r0, #132]
ldr.w sl, [r0, #196]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #68]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #132]
ldr r5, [r3, #8]
ldr r6, [r3, #72]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #72]
ldr.w r9, [r0, #136]
ldr.w sl, [r0, #200]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #72]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #136]
ldr r5, [r3, #12]
ldr r6, [r3, #76]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #76]
ldr.w r9, [r0, #140]
ldr.w sl, [r0, #204]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #76]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #140]
ldr r5, [r3, #16]
ldr r6, [r3, #80]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #80]
ldr.w r9, [r0, #144]
ldr.w sl, [r0, #208]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #80]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #144]
ldr r5, [r3, #20]
ldr r6, [r3, #84]
ldr.w r7, [r0, #20]
ldr.w r8, [r0, #84]
ldr.w r9, [r0, #148]
ldr.w sl, [r0, #212]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #84]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #148]
ldr r5, [r3, #24]
ldr r6, [r3, #88]
ldr.w r7, [r0, #24]
ldr.w r8, [r0, #88]
ldr.w r9, [r0, #152]
ldr.w sl, [r0, #216]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #88]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #152]
ldr r5, [r3, #28]
ldr r6, [r3, #92]
ldr.w r7, [r0, #28]
ldr.w r8, [r0, #92]
ldr.w r9, [r0, #156]
ldr.w sl, [r0, #220]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #92]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #156]
ldr r5, [r3, #32]
ldr r6, [r3, #96]
ldr.w r7, [r0, #32]
ldr.w r8, [r0, #96]
ldr.w r9, [r0, #160]
ldr.w sl, [r0, #224]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #96]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #160]
ldr r5, [r3, #36]
ldr r6, [r3, #100]
ldr.w r7, [r0, #36]
ldr.w r8, [r0, #100]
ldr.w r9, [r0, #164]
ldr.w sl, [r0, #228]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #100]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #164]
ldr r5, [r3, #40]
ldr r6, [r3, #104]
ldr.w r7, [r0, #40]
ldr.w r8, [r0, #104]
ldr.w r9, [r0, #168]
ldr.w sl, [r0, #232]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #104]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #168]
ldr r5, [r3, #44]
ldr r6, [r3, #108]
ldr.w r7, [r0, #44]
ldr.w r8, [r0, #108]
ldr.w r9, [r0, #172]
ldr.w sl, [r0, #236]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #108]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #172]
ldr r5, [r3, #48]
ldr r6, [r3, #112]
ldr.w r7, [r0, #48]
ldr.w r8, [r0, #112]
ldr.w r9, [r0, #176]
ldr.w sl, [r0, #240]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #112]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #176]
ldr r5, [r3, #52]
ldr r6, [r3, #116]
ldr.w r7, [r0, #52]
ldr.w r8, [r0, #116]
ldr.w r9, [r0, #180]
ldr.w sl, [r0, #244]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #116]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #180]
ldr r5, [r3, #56]
ldr r6, [r3, #120]
ldr.w r7, [r0, #56]
ldr.w r8, [r0, #120]
ldr.w r9, [r0, #184]
ldr.w sl, [r0, #248]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #120]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #184]
ldrh.w r5, [r3, #60]
ldrh.w r6, [r3, #124]
ldrh.w r7, [r0, #60]
ldrh.w r8, [r0, #124]
ldrh.w r9, [r0, #188]
ldrh.w sl, [r0, #252]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #124]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #188]
ldrh r5, [r3, #62]
ldrh r7, [r0, #62]
ldrh.w r9, [r0, #190]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #126]
add sp, #260
pop {r2}
pop.w {r1}
ldr.w lr, [sp], #4
bx lr
.global polymul_asm
.type polymul_asm, %function
.align 2
polymul_asm:
stmdb sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
sub.w sp, sp, #3328
add r3, sp, #768
ldr r4, [r1, #0]
ldr.w r5, [r1, #128]
ldr.w r6, [r1, #256]
ldr.w r7, [r1, #384]
str.w r7, [sp, #640]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp]
str.w ip, [sp, #128]
str.w r9, [sp, #256]
str.w sl, [sp, #384]
str r7, [sp, #512]
ldr r4, [r2, #0]
ldr.w r5, [r2, #128]
ldr.w r6, [r2, #256]
ldr.w r7, [r2, #384]
str.w r7, [r3, #640]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3]
str.w ip, [r3, #128]
str.w r9, [r3, #256]
str.w sl, [r3, #384]
str.w r7, [r3, #512]
ldr.w r4, [r1, #4]
ldr.w r5, [r1, #132]
ldr.w r6, [r1, #260]
ldr.w r7, [r1, #388]
str.w r7, [sp, #644]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #4]
str.w ip, [sp, #132]
str.w r9, [sp, #260]
str.w sl, [sp, #388]
str r7, [sp, #516]
ldr r4, [r2, #4]
ldr.w r5, [r2, #132]
ldr.w r6, [r2, #260]
ldr.w r7, [r2, #388]
str.w r7, [r3, #644]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #4]
str.w ip, [r3, #132]
str.w r9, [r3, #260]
str.w sl, [r3, #388]
str.w r7, [r3, #516]
ldr.w r4, [r1, #8]
ldr.w r5, [r1, #136]
ldr.w r6, [r1, #264]
ldr.w r7, [r1, #392]
str.w r7, [sp, #648]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #8]
str.w ip, [sp, #136]
str.w r9, [sp, #264]
str.w sl, [sp, #392]
str r7, [sp, #520]
ldr r4, [r2, #8]
ldr.w r5, [r2, #136]
ldr.w r6, [r2, #264]
ldr.w r7, [r2, #392]
str.w r7, [r3, #648]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #8]
str.w ip, [r3, #136]
str.w r9, [r3, #264]
str.w sl, [r3, #392]
str.w r7, [r3, #520]
ldr.w r4, [r1, #12]
ldr.w r5, [r1, #140]
ldr.w r6, [r1, #268]
ldr.w r7, [r1, #396]
str.w r7, [sp, #652]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #12]
str.w ip, [sp, #140]
str.w r9, [sp, #268]
str.w sl, [sp, #396]
str r7, [sp, #524]
ldr r4, [r2, #12]
ldr.w r5, [r2, #140]
ldr.w r6, [r2, #268]
ldr.w r7, [r2, #396]
str.w r7, [r3, #652]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #12]
str.w ip, [r3, #140]
str.w r9, [r3, #268]
str.w sl, [r3, #396]
str.w r7, [r3, #524]
ldr.w r4, [r1, #16]
ldr.w r5, [r1, #144]
ldr.w r6, [r1, #272]
ldr.w r7, [r1, #400]
str.w r7, [sp, #656]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #16]
str.w ip, [sp, #144]
str.w r9, [sp, #272]
str.w sl, [sp, #400]
str r7, [sp, #528]
ldr r4, [r2, #16]
ldr.w r5, [r2, #144]
ldr.w r6, [r2, #272]
ldr.w r7, [r2, #400]
str.w r7, [r3, #656]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #16]
str.w ip, [r3, #144]
str.w r9, [r3, #272]
str.w sl, [r3, #400]
str.w r7, [r3, #528]
ldr.w r4, [r1, #20]
ldr.w r5, [r1, #148]
ldr.w r6, [r1, #276]
ldr.w r7, [r1, #404]
str.w r7, [sp, #660]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #20]
str.w ip, [sp, #148]
str.w r9, [sp, #276]
str.w sl, [sp, #404]
str r7, [sp, #532]
ldr r4, [r2, #20]
ldr.w r5, [r2, #148]
ldr.w r6, [r2, #276]
ldr.w r7, [r2, #404]
str.w r7, [r3, #660]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #20]
str.w ip, [r3, #148]
str.w r9, [r3, #276]
str.w sl, [r3, #404]
str.w r7, [r3, #532]
ldr.w r4, [r1, #24]
ldr.w r5, [r1, #152]
ldr.w r6, [r1, #280]
ldr.w r7, [r1, #408]
str.w r7, [sp, #664]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #24]
str.w ip, [sp, #152]
str.w r9, [sp, #280]
str.w sl, [sp, #408]
str r7, [sp, #536]
ldr r4, [r2, #24]
ldr.w r5, [r2, #152]
ldr.w r6, [r2, #280]
ldr.w r7, [r2, #408]
str.w r7, [r3, #664]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #24]
str.w ip, [r3, #152]
str.w r9, [r3, #280]
str.w sl, [r3, #408]
str.w r7, [r3, #536]
ldr.w r4, [r1, #28]
ldr.w r5, [r1, #156]
ldr.w r6, [r1, #284]
ldr.w r7, [r1, #412]
str.w r7, [sp, #668]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #28]
str.w ip, [sp, #156]
str.w r9, [sp, #284]
str.w sl, [sp, #412]
str r7, [sp, #540]
ldr r4, [r2, #28]
ldr.w r5, [r2, #156]
ldr.w r6, [r2, #284]
ldr.w r7, [r2, #412]
str.w r7, [r3, #668]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #28]
str.w ip, [r3, #156]
str.w r9, [r3, #284]
str.w sl, [r3, #412]
str.w r7, [r3, #540]
ldr.w r4, [r1, #32]
ldr.w r5, [r1, #160]
ldr.w r6, [r1, #288]
ldr.w r7, [r1, #416]
str.w r7, [sp, #672]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #32]
str.w ip, [sp, #160]
str.w r9, [sp, #288]
str.w sl, [sp, #416]
str r7, [sp, #544]
ldr r4, [r2, #32]
ldr.w r5, [r2, #160]
ldr.w r6, [r2, #288]
ldr.w r7, [r2, #416]
str.w r7, [r3, #672]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #32]
str.w ip, [r3, #160]
str.w r9, [r3, #288]
str.w sl, [r3, #416]
str.w r7, [r3, #544]
ldr.w r4, [r1, #36]
ldr.w r5, [r1, #164]
ldr.w r6, [r1, #292]
ldr.w r7, [r1, #420]
str.w r7, [sp, #676]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #36]
str.w ip, [sp, #164]
str.w r9, [sp, #292]
str.w sl, [sp, #420]
str r7, [sp, #548]
ldr r4, [r2, #36]
ldr.w r5, [r2, #164]
ldr.w r6, [r2, #292]
ldr.w r7, [r2, #420]
str.w r7, [r3, #676]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #36]
str.w ip, [r3, #164]
str.w r9, [r3, #292]
str.w sl, [r3, #420]
str.w r7, [r3, #548]
ldr.w r4, [r1, #40]
ldr.w r5, [r1, #168]
ldr.w r6, [r1, #296]
ldr.w r7, [r1, #424]
str.w r7, [sp, #680]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #40]
str.w ip, [sp, #168]
str.w r9, [sp, #296]
str.w sl, [sp, #424]
str r7, [sp, #552]
ldr r4, [r2, #40]
ldr.w r5, [r2, #168]
ldr.w r6, [r2, #296]
ldr.w r7, [r2, #424]
str.w r7, [r3, #680]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #40]
str.w ip, [r3, #168]
str.w r9, [r3, #296]
str.w sl, [r3, #424]
str.w r7, [r3, #552]
ldr.w r4, [r1, #44]
ldr.w r5, [r1, #172]
ldr.w r6, [r1, #300]
ldr.w r7, [r1, #428]
str.w r7, [sp, #684]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #44]
str.w ip, [sp, #172]
str.w r9, [sp, #300]
str.w sl, [sp, #428]
str r7, [sp, #556]
ldr r4, [r2, #44]
ldr.w r5, [r2, #172]
ldr.w r6, [r2, #300]
ldr.w r7, [r2, #428]
str.w r7, [r3, #684]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #44]
str.w ip, [r3, #172]
str.w r9, [r3, #300]
str.w sl, [r3, #428]
str.w r7, [r3, #556]
ldr.w r4, [r1, #48]
ldr.w r5, [r1, #176]
ldr.w r6, [r1, #304]
ldr.w r7, [r1, #432]
str.w r7, [sp, #688]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #48]
str.w ip, [sp, #176]
str.w r9, [sp, #304]
str.w sl, [sp, #432]
str r7, [sp, #560]
ldr r4, [r2, #48]
ldr.w r5, [r2, #176]
ldr.w r6, [r2, #304]
ldr.w r7, [r2, #432]
str.w r7, [r3, #688]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #48]
str.w ip, [r3, #176]
str.w r9, [r3, #304]
str.w sl, [r3, #432]
str.w r7, [r3, #560]
ldr.w r4, [r1, #52]
ldr.w r5, [r1, #180]
ldr.w r6, [r1, #308]
ldr.w r7, [r1, #436]
str.w r7, [sp, #692]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #52]
str.w ip, [sp, #180]
str.w r9, [sp, #308]
str.w sl, [sp, #436]
str r7, [sp, #564]
ldr r4, [r2, #52]
ldr.w r5, [r2, #180]
ldr.w r6, [r2, #308]
ldr.w r7, [r2, #436]
str.w r7, [r3, #692]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #52]
str.w ip, [r3, #180]
str.w r9, [r3, #308]
str.w sl, [r3, #436]
str.w r7, [r3, #564]
ldr.w r4, [r1, #56]
ldr.w r5, [r1, #184]
ldr.w r6, [r1, #312]
ldr.w r7, [r1, #440]
str.w r7, [sp, #696]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #56]
str.w ip, [sp, #184]
str.w r9, [sp, #312]
str.w sl, [sp, #440]
str r7, [sp, #568]
ldr r4, [r2, #56]
ldr.w r5, [r2, #184]
ldr.w r6, [r2, #312]
ldr.w r7, [r2, #440]
str.w r7, [r3, #696]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #56]
str.w ip, [r3, #184]
str.w r9, [r3, #312]
str.w sl, [r3, #440]
str.w r7, [r3, #568]
ldr.w r4, [r1, #60]
ldr.w r5, [r1, #188]
ldr.w r6, [r1, #316]
ldr.w r7, [r1, #444]
str.w r7, [sp, #700]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #60]
str.w ip, [sp, #188]
str.w r9, [sp, #316]
str.w sl, [sp, #444]
str r7, [sp, #572]
ldr r4, [r2, #60]
ldr.w r5, [r2, #188]
ldr.w r6, [r2, #316]
ldr.w r7, [r2, #444]
str.w r7, [r3, #700]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #60]
str.w ip, [r3, #188]
str.w r9, [r3, #316]
str.w sl, [r3, #444]
str.w r7, [r3, #572]
ldr.w r4, [r1, #64]
ldr.w r5, [r1, #192]
ldr.w r6, [r1, #320]
ldr.w r7, [r1, #448]
str.w r7, [sp, #704]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #64]
str.w ip, [sp, #192]
str.w r9, [sp, #320]
str.w sl, [sp, #448]
str r7, [sp, #576]
ldr r4, [r2, #64]
ldr.w r5, [r2, #192]
ldr.w r6, [r2, #320]
ldr.w r7, [r2, #448]
str.w r7, [r3, #704]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #64]
str.w ip, [r3, #192]
str.w r9, [r3, #320]
str.w sl, [r3, #448]
str.w r7, [r3, #576]
ldr.w r4, [r1, #68]
ldr.w r5, [r1, #196]
ldr.w r6, [r1, #324]
ldr.w r7, [r1, #452]
str.w r7, [sp, #708]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #68]
str.w ip, [sp, #196]
str.w r9, [sp, #324]
str.w sl, [sp, #452]
str r7, [sp, #580]
ldr r4, [r2, #68]
ldr.w r5, [r2, #196]
ldr.w r6, [r2, #324]
ldr.w r7, [r2, #452]
str.w r7, [r3, #708]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #68]
str.w ip, [r3, #196]
str.w r9, [r3, #324]
str.w sl, [r3, #452]
str.w r7, [r3, #580]
ldr.w r4, [r1, #72]
ldr.w r5, [r1, #200]
ldr.w r6, [r1, #328]
ldr.w r7, [r1, #456]
str.w r7, [sp, #712]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #72]
str.w ip, [sp, #200]
str.w r9, [sp, #328]
str.w sl, [sp, #456]
str r7, [sp, #584]
ldr r4, [r2, #72]
ldr.w r5, [r2, #200]
ldr.w r6, [r2, #328]
ldr.w r7, [r2, #456]
str.w r7, [r3, #712]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #72]
str.w ip, [r3, #200]
str.w r9, [r3, #328]
str.w sl, [r3, #456]
str.w r7, [r3, #584]
ldr.w r4, [r1, #76]
ldr.w r5, [r1, #204]
ldr.w r6, [r1, #332]
ldr.w r7, [r1, #460]
str.w r7, [sp, #716]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #76]
str.w ip, [sp, #204]
str.w r9, [sp, #332]
str.w sl, [sp, #460]
str r7, [sp, #588]
ldr r4, [r2, #76]
ldr.w r5, [r2, #204]
ldr.w r6, [r2, #332]
ldr.w r7, [r2, #460]
str.w r7, [r3, #716]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #76]
str.w ip, [r3, #204]
str.w r9, [r3, #332]
str.w sl, [r3, #460]
str.w r7, [r3, #588]
ldr.w r4, [r1, #80]
ldr.w r5, [r1, #208]
ldr.w r6, [r1, #336]
ldr.w r7, [r1, #464]
str.w r7, [sp, #720]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #80]
str.w ip, [sp, #208]
str.w r9, [sp, #336]
str.w sl, [sp, #464]
str r7, [sp, #592]
ldr r4, [r2, #80]
ldr.w r5, [r2, #208]
ldr.w r6, [r2, #336]
ldr.w r7, [r2, #464]
str.w r7, [r3, #720]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #80]
str.w ip, [r3, #208]
str.w r9, [r3, #336]
str.w sl, [r3, #464]
str.w r7, [r3, #592]
ldr.w r4, [r1, #84]
ldr.w r5, [r1, #212]
ldr.w r6, [r1, #340]
ldr.w r7, [r1, #468]
str.w r7, [sp, #724]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #84]
str.w ip, [sp, #212]
str.w r9, [sp, #340]
str.w sl, [sp, #468]
str r7, [sp, #596]
ldr r4, [r2, #84]
ldr.w r5, [r2, #212]
ldr.w r6, [r2, #340]
ldr.w r7, [r2, #468]
str.w r7, [r3, #724]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #84]
str.w ip, [r3, #212]
str.w r9, [r3, #340]
str.w sl, [r3, #468]
str.w r7, [r3, #596]
ldr.w r4, [r1, #88]
ldr.w r5, [r1, #216]
ldr.w r6, [r1, #344]
ldr.w r7, [r1, #472]
str.w r7, [sp, #728]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #88]
str.w ip, [sp, #216]
str.w r9, [sp, #344]
str.w sl, [sp, #472]
str r7, [sp, #600]
ldr r4, [r2, #88]
ldr.w r5, [r2, #216]
ldr.w r6, [r2, #344]
ldr.w r7, [r2, #472]
str.w r7, [r3, #728]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #88]
str.w ip, [r3, #216]
str.w r9, [r3, #344]
str.w sl, [r3, #472]
str.w r7, [r3, #600]
ldr.w r4, [r1, #92]
ldr.w r5, [r1, #220]
ldr.w r6, [r1, #348]
ldr.w r7, [r1, #476]
str.w r7, [sp, #732]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #92]
str.w ip, [sp, #220]
str.w r9, [sp, #348]
str.w sl, [sp, #476]
str r7, [sp, #604]
ldr r4, [r2, #92]
ldr.w r5, [r2, #220]
ldr.w r6, [r2, #348]
ldr.w r7, [r2, #476]
str.w r7, [r3, #732]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #92]
str.w ip, [r3, #220]
str.w r9, [r3, #348]
str.w sl, [r3, #476]
str.w r7, [r3, #604]
ldr.w r4, [r1, #96]
ldr.w r5, [r1, #224]
ldr.w r6, [r1, #352]
ldr.w r7, [r1, #480]
str.w r7, [sp, #736]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #96]
str.w ip, [sp, #224]
str.w r9, [sp, #352]
str.w sl, [sp, #480]
str r7, [sp, #608]
ldr r4, [r2, #96]
ldr.w r5, [r2, #224]
ldr.w r6, [r2, #352]
ldr.w r7, [r2, #480]
str.w r7, [r3, #736]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #96]
str.w ip, [r3, #224]
str.w r9, [r3, #352]
str.w sl, [r3, #480]
str.w r7, [r3, #608]
ldr.w r4, [r1, #100]
ldr.w r5, [r1, #228]
ldr.w r6, [r1, #356]
ldr.w r7, [r1, #484]
str.w r7, [sp, #740]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #100]
str.w ip, [sp, #228]
str.w r9, [sp, #356]
str.w sl, [sp, #484]
str r7, [sp, #612]
ldr r4, [r2, #100]
ldr.w r5, [r2, #228]
ldr.w r6, [r2, #356]
ldr.w r7, [r2, #484]
str.w r7, [r3, #740]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #100]
str.w ip, [r3, #228]
str.w r9, [r3, #356]
str.w sl, [r3, #484]
str.w r7, [r3, #612]
ldr.w r4, [r1, #104]
ldr.w r5, [r1, #232]
ldr.w r6, [r1, #360]
ldr.w r7, [r1, #488]
str.w r7, [sp, #744]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #104]
str.w ip, [sp, #232]
str.w r9, [sp, #360]
str.w sl, [sp, #488]
str r7, [sp, #616]
ldr r4, [r2, #104]
ldr.w r5, [r2, #232]
ldr.w r6, [r2, #360]
ldr.w r7, [r2, #488]
str.w r7, [r3, #744]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #104]
str.w ip, [r3, #232]
str.w r9, [r3, #360]
str.w sl, [r3, #488]
str.w r7, [r3, #616]
ldr.w r4, [r1, #108]
ldr.w r5, [r1, #236]
ldr.w r6, [r1, #364]
ldr.w r7, [r1, #492]
str.w r7, [sp, #748]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #108]
str.w ip, [sp, #236]
str.w r9, [sp, #364]
str.w sl, [sp, #492]
str r7, [sp, #620]
ldr r4, [r2, #108]
ldr.w r5, [r2, #236]
ldr.w r6, [r2, #364]
ldr.w r7, [r2, #492]
str.w r7, [r3, #748]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #108]
str.w ip, [r3, #236]
str.w r9, [r3, #364]
str.w sl, [r3, #492]
str.w r7, [r3, #620]
ldr.w r4, [r1, #112]
ldr.w r5, [r1, #240]
ldr.w r6, [r1, #368]
ldr.w r7, [r1, #496]
str.w r7, [sp, #752]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #112]
str.w ip, [sp, #240]
str.w r9, [sp, #368]
str.w sl, [sp, #496]
str r7, [sp, #624]
ldr r4, [r2, #112]
ldr.w r5, [r2, #240]
ldr.w r6, [r2, #368]
ldr.w r7, [r2, #496]
str.w r7, [r3, #752]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #112]
str.w ip, [r3, #240]
str.w r9, [r3, #368]
str.w sl, [r3, #496]
str.w r7, [r3, #624]
ldr.w r4, [r1, #116]
ldr.w r5, [r1, #244]
ldr.w r6, [r1, #372]
ldr.w r7, [r1, #500]
str.w r7, [sp, #756]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #116]
str.w ip, [sp, #244]
str.w r9, [sp, #372]
str.w sl, [sp, #500]
str r7, [sp, #628]
ldr r4, [r2, #116]
ldr.w r5, [r2, #244]
ldr.w r6, [r2, #372]
ldr.w r7, [r2, #500]
str.w r7, [r3, #756]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #116]
str.w ip, [r3, #244]
str.w r9, [r3, #372]
str.w sl, [r3, #500]
str.w r7, [r3, #628]
ldr.w r4, [r1, #120]
ldr.w r5, [r1, #248]
ldr.w r6, [r1, #376]
ldr.w r7, [r1, #504]
str.w r7, [sp, #760]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #120]
str.w ip, [sp, #248]
str.w r9, [sp, #376]
str.w sl, [sp, #504]
str r7, [sp, #632]
ldr r4, [r2, #120]
ldr.w r5, [r2, #248]
ldr.w r6, [r2, #376]
ldr.w r7, [r2, #504]
str.w r7, [r3, #760]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #120]
str.w ip, [r3, #248]
str.w r9, [r3, #376]
str.w sl, [r3, #504]
str.w r7, [r3, #632]
ldr.w r4, [r1, #124]
ldr.w r5, [r1, #252]
ldr.w r6, [r1, #380]
ldr.w r7, [r1, #508]
str.w r7, [sp, #764]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [sp, #124]
str.w ip, [sp, #252]
str.w r9, [sp, #380]
str.w sl, [sp, #508]
str r7, [sp, #636]
ldr r4, [r2, #124]
ldr.w r5, [r2, #252]
ldr.w r6, [r2, #380]
ldr.w r7, [r2, #508]
str.w r7, [r3, #764]
uadd16 lr, r4, r6
uadd16 ip, r5, r7
uadd16 fp, lr, ip
usub16 ip, lr, ip
uadd16 lr, r6, r6
uadd16 lr, lr, lr
uadd16 lr, r4, lr
uadd16 sl, r7, r7
uadd16 sl, sl, sl
uadd16 sl, r5, sl
uadd16 sl, sl, sl
uadd16 r9, lr, sl
usub16 sl, lr, sl
uadd16 r8, r7, r7
uadd16 r7, r8, r7
uadd16 r7, r7, r6
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r5
uadd16 r8, r7, r7
uadd16 r7, r7, r8
uadd16 r7, r7, r4
str.w fp, [r3, #124]
str.w ip, [r3, #252]
str.w r9, [r3, #380]
str.w sl, [r3, #508]
str.w r7, [r3, #636]
push {r0}
push {r3}
mov.w fp, #1544
add.w r0, sp, fp
bl karatsuba_64x64
pop.w {r3}
add.w r0, r0, #256
add.w r1, sp, #4
add.w r2, r3, #0
bl karatsuba_64x64
add.w r0, r0, #256
add.w r1, r1, #128
add.w r2, r2, #128
bl karatsuba_64x64
add.w r0, r0, #256
add.w r1, r1, #128
add.w r2, r2, #128
bl karatsuba_64x64
add.w r0, r0, #256
add.w r1, r1, #128
add.w r2, r2, #128
bl karatsuba_64x64
add.w r0, r0, #256
add.w r1, r1, #128
add.w r2, r2, #128
bl karatsuba_64x64
add.w r0, r0, #256
add.w r1, r1, #128
add.w r2, r2, #128
bl karatsuba_64x64
pop.w {r0}
add.w sp, sp, #1536
add.w fp, sp, #1024
movw lr, #43691
movw ip, #52429
ldrh.w r1, [sp]
ldrh.w r2, [sp, #256]
ldrh.w r3, [sp, #512]
ldrh.w r4, [sp, #768]
ldrh.w r5, [fp]
ldrh.w r6, [fp, #256]
ldrh.w r7, [fp, #512]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #0]
strh.w r3, [r0, #128]
strh.w r8, [r0, #256]
strh.w r6, [r0, #384]
strh.w r9, [r0, #512]
strh.w r5, [r0, #640]
strh.w r7, [r0, #768]
ldrh.w r1, [sp, #2]
ldrh.w r2, [sp, #258]
ldrh.w r3, [sp, #514]
ldrh.w r4, [sp, #770]
ldrh.w r5, [fp, #2]
ldrh.w r6, [fp, #258]
ldrh.w r7, [fp, #514]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #2]
strh.w r3, [r0, #130]
strh.w r8, [r0, #258]
strh.w r6, [r0, #386]
strh.w r9, [r0, #514]
strh.w r5, [r0, #642]
strh.w r7, [r0, #770]
ldrh.w r1, [sp, #4]
ldrh.w r2, [sp, #260]
ldrh.w r3, [sp, #516]
ldrh.w r4, [sp, #772]
ldrh.w r5, [fp, #4]
ldrh.w r6, [fp, #260]
ldrh.w r7, [fp, #516]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #4]
strh.w r3, [r0, #132]
strh.w r8, [r0, #260]
strh.w r6, [r0, #388]
strh.w r9, [r0, #516]
strh.w r5, [r0, #644]
strh.w r7, [r0, #772]
ldrh.w r1, [sp, #6]
ldrh.w r2, [sp, #262]
ldrh.w r3, [sp, #518]
ldrh.w r4, [sp, #774]
ldrh.w r5, [fp, #6]
ldrh.w r6, [fp, #262]
ldrh.w r7, [fp, #518]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #6]
strh.w r3, [r0, #134]
strh.w r8, [r0, #262]
strh.w r6, [r0, #390]
strh.w r9, [r0, #518]
strh.w r5, [r0, #646]
strh.w r7, [r0, #774]
ldrh.w r1, [sp, #8]
ldrh.w r2, [sp, #264]
ldrh.w r3, [sp, #520]
ldrh.w r4, [sp, #776]
ldrh.w r5, [fp, #8]
ldrh.w r6, [fp, #264]
ldrh.w r7, [fp, #520]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #8]
strh.w r3, [r0, #136]
strh.w r8, [r0, #264]
strh.w r6, [r0, #392]
strh.w r9, [r0, #520]
strh.w r5, [r0, #648]
strh.w r7, [r0, #776]
ldrh.w r1, [sp, #10]
ldrh.w r2, [sp, #266]
ldrh.w r3, [sp, #522]
ldrh.w r4, [sp, #778]
ldrh.w r5, [fp, #10]
ldrh.w r6, [fp, #266]
ldrh.w r7, [fp, #522]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #10]
strh.w r3, [r0, #138]
strh.w r8, [r0, #266]
strh.w r6, [r0, #394]
strh.w r9, [r0, #522]
strh.w r5, [r0, #650]
strh.w r7, [r0, #778]
ldrh.w r1, [sp, #12]
ldrh.w r2, [sp, #268]
ldrh.w r3, [sp, #524]
ldrh.w r4, [sp, #780]
ldrh.w r5, [fp, #12]
ldrh.w r6, [fp, #268]
ldrh.w r7, [fp, #524]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #12]
strh.w r3, [r0, #140]
strh.w r8, [r0, #268]
strh.w r6, [r0, #396]
strh.w r9, [r0, #524]
strh.w r5, [r0, #652]
strh.w r7, [r0, #780]
ldrh.w r1, [sp, #14]
ldrh.w r2, [sp, #270]
ldrh.w r3, [sp, #526]
ldrh.w r4, [sp, #782]
ldrh.w r5, [fp, #14]
ldrh.w r6, [fp, #270]
ldrh.w r7, [fp, #526]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #14]
strh.w r3, [r0, #142]
strh.w r8, [r0, #270]
strh.w r6, [r0, #398]
strh.w r9, [r0, #526]
strh.w r5, [r0, #654]
strh.w r7, [r0, #782]
ldrh.w r1, [sp, #16]
ldrh.w r2, [sp, #272]
ldrh.w r3, [sp, #528]
ldrh.w r4, [sp, #784]
ldrh.w r5, [fp, #16]
ldrh.w r6, [fp, #272]
ldrh.w r7, [fp, #528]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #16]
strh.w r3, [r0, #144]
strh.w r8, [r0, #272]
strh.w r6, [r0, #400]
strh.w r9, [r0, #528]
strh.w r5, [r0, #656]
strh.w r7, [r0, #784]
ldrh.w r1, [sp, #18]
ldrh.w r2, [sp, #274]
ldrh.w r3, [sp, #530]
ldrh.w r4, [sp, #786]
ldrh.w r5, [fp, #18]
ldrh.w r6, [fp, #274]
ldrh.w r7, [fp, #530]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #18]
strh.w r3, [r0, #146]
strh.w r8, [r0, #274]
strh.w r6, [r0, #402]
strh.w r9, [r0, #530]
strh.w r5, [r0, #658]
strh.w r7, [r0, #786]
ldrh.w r1, [sp, #20]
ldrh.w r2, [sp, #276]
ldrh.w r3, [sp, #532]
ldrh.w r4, [sp, #788]
ldrh.w r5, [fp, #20]
ldrh.w r6, [fp, #276]
ldrh.w r7, [fp, #532]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #20]
strh.w r3, [r0, #148]
strh.w r8, [r0, #276]
strh.w r6, [r0, #404]
strh.w r9, [r0, #532]
strh.w r5, [r0, #660]
strh.w r7, [r0, #788]
ldrh.w r1, [sp, #22]
ldrh.w r2, [sp, #278]
ldrh.w r3, [sp, #534]
ldrh.w r4, [sp, #790]
ldrh.w r5, [fp, #22]
ldrh.w r6, [fp, #278]
ldrh.w r7, [fp, #534]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #22]
strh.w r3, [r0, #150]
strh.w r8, [r0, #278]
strh.w r6, [r0, #406]
strh.w r9, [r0, #534]
strh.w r5, [r0, #662]
strh.w r7, [r0, #790]
ldrh.w r1, [sp, #24]
ldrh.w r2, [sp, #280]
ldrh.w r3, [sp, #536]
ldrh.w r4, [sp, #792]
ldrh.w r5, [fp, #24]
ldrh.w r6, [fp, #280]
ldrh.w r7, [fp, #536]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #24]
strh.w r3, [r0, #152]
strh.w r8, [r0, #280]
strh.w r6, [r0, #408]
strh.w r9, [r0, #536]
strh.w r5, [r0, #664]
strh.w r7, [r0, #792]
ldrh.w r1, [sp, #26]
ldrh.w r2, [sp, #282]
ldrh.w r3, [sp, #538]
ldrh.w r4, [sp, #794]
ldrh.w r5, [fp, #26]
ldrh.w r6, [fp, #282]
ldrh.w r7, [fp, #538]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #26]
strh.w r3, [r0, #154]
strh.w r8, [r0, #282]
strh.w r6, [r0, #410]
strh.w r9, [r0, #538]
strh.w r5, [r0, #666]
strh.w r7, [r0, #794]
ldrh.w r1, [sp, #28]
ldrh.w r2, [sp, #284]
ldrh.w r3, [sp, #540]
ldrh.w r4, [sp, #796]
ldrh.w r5, [fp, #28]
ldrh.w r6, [fp, #284]
ldrh.w r7, [fp, #540]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #28]
strh.w r3, [r0, #156]
strh.w r8, [r0, #284]
strh.w r6, [r0, #412]
strh.w r9, [r0, #540]
strh.w r5, [r0, #668]
strh.w r7, [r0, #796]
ldrh.w r1, [sp, #30]
ldrh.w r2, [sp, #286]
ldrh.w r3, [sp, #542]
ldrh.w r4, [sp, #798]
ldrh.w r5, [fp, #30]
ldrh.w r6, [fp, #286]
ldrh.w r7, [fp, #542]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #30]
strh.w r3, [r0, #158]
strh.w r8, [r0, #286]
strh.w r6, [r0, #414]
strh.w r9, [r0, #542]
strh.w r5, [r0, #670]
strh.w r7, [r0, #798]
ldrh.w r1, [sp, #32]
ldrh.w r2, [sp, #288]
ldrh.w r3, [sp, #544]
ldrh.w r4, [sp, #800]
ldrh.w r5, [fp, #32]
ldrh.w r6, [fp, #288]
ldrh.w r7, [fp, #544]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #32]
strh.w r3, [r0, #160]
strh.w r8, [r0, #288]
strh.w r6, [r0, #416]
strh.w r9, [r0, #544]
strh.w r5, [r0, #672]
strh.w r7, [r0, #800]
ldrh.w r1, [sp, #34]
ldrh.w r2, [sp, #290]
ldrh.w r3, [sp, #546]
ldrh.w r4, [sp, #802]
ldrh.w r5, [fp, #34]
ldrh.w r6, [fp, #290]
ldrh.w r7, [fp, #546]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #34]
strh.w r3, [r0, #162]
strh.w r8, [r0, #290]
strh.w r6, [r0, #418]
strh.w r9, [r0, #546]
strh.w r5, [r0, #674]
strh.w r7, [r0, #802]
ldrh.w r1, [sp, #36]
ldrh.w r2, [sp, #292]
ldrh.w r3, [sp, #548]
ldrh.w r4, [sp, #804]
ldrh.w r5, [fp, #36]
ldrh.w r6, [fp, #292]
ldrh.w r7, [fp, #548]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #36]
strh.w r3, [r0, #164]
strh.w r8, [r0, #292]
strh.w r6, [r0, #420]
strh.w r9, [r0, #548]
strh.w r5, [r0, #676]
strh.w r7, [r0, #804]
ldrh.w r1, [sp, #38]
ldrh.w r2, [sp, #294]
ldrh.w r3, [sp, #550]
ldrh.w r4, [sp, #806]
ldrh.w r5, [fp, #38]
ldrh.w r6, [fp, #294]
ldrh.w r7, [fp, #550]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #38]
strh.w r3, [r0, #166]
strh.w r8, [r0, #294]
strh.w r6, [r0, #422]
strh.w r9, [r0, #550]
strh.w r5, [r0, #678]
strh.w r7, [r0, #806]
ldrh.w r1, [sp, #40]
ldrh.w r2, [sp, #296]
ldrh.w r3, [sp, #552]
ldrh.w r4, [sp, #808]
ldrh.w r5, [fp, #40]
ldrh.w r6, [fp, #296]
ldrh.w r7, [fp, #552]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #40]
strh.w r3, [r0, #168]
strh.w r8, [r0, #296]
strh.w r6, [r0, #424]
strh.w r9, [r0, #552]
strh.w r5, [r0, #680]
strh.w r7, [r0, #808]
ldrh.w r1, [sp, #42]
ldrh.w r2, [sp, #298]
ldrh.w r3, [sp, #554]
ldrh.w r4, [sp, #810]
ldrh.w r5, [fp, #42]
ldrh.w r6, [fp, #298]
ldrh.w r7, [fp, #554]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #42]
strh.w r3, [r0, #170]
strh.w r8, [r0, #298]
strh.w r6, [r0, #426]
strh.w r9, [r0, #554]
strh.w r5, [r0, #682]
strh.w r7, [r0, #810]
ldrh.w r1, [sp, #44]
ldrh.w r2, [sp, #300]
ldrh.w r3, [sp, #556]
ldrh.w r4, [sp, #812]
ldrh.w r5, [fp, #44]
ldrh.w r6, [fp, #300]
ldrh.w r7, [fp, #556]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #44]
strh.w r3, [r0, #172]
strh.w r8, [r0, #300]
strh.w r6, [r0, #428]
strh.w r9, [r0, #556]
strh.w r5, [r0, #684]
strh.w r7, [r0, #812]
ldrh.w r1, [sp, #46]
ldrh.w r2, [sp, #302]
ldrh.w r3, [sp, #558]
ldrh.w r4, [sp, #814]
ldrh.w r5, [fp, #46]
ldrh.w r6, [fp, #302]
ldrh.w r7, [fp, #558]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #46]
strh.w r3, [r0, #174]
strh.w r8, [r0, #302]
strh.w r6, [r0, #430]
strh.w r9, [r0, #558]
strh.w r5, [r0, #686]
strh.w r7, [r0, #814]
ldrh.w r1, [sp, #48]
ldrh.w r2, [sp, #304]
ldrh.w r3, [sp, #560]
ldrh.w r4, [sp, #816]
ldrh.w r5, [fp, #48]
ldrh.w r6, [fp, #304]
ldrh.w r7, [fp, #560]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #48]
strh.w r3, [r0, #176]
strh.w r8, [r0, #304]
strh.w r6, [r0, #432]
strh.w r9, [r0, #560]
strh.w r5, [r0, #688]
strh.w r7, [r0, #816]
ldrh.w r1, [sp, #50]
ldrh.w r2, [sp, #306]
ldrh.w r3, [sp, #562]
ldrh.w r4, [sp, #818]
ldrh.w r5, [fp, #50]
ldrh.w r6, [fp, #306]
ldrh.w r7, [fp, #562]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #50]
strh.w r3, [r0, #178]
strh.w r8, [r0, #306]
strh.w r6, [r0, #434]
strh.w r9, [r0, #562]
strh.w r5, [r0, #690]
strh.w r7, [r0, #818]
ldrh.w r1, [sp, #52]
ldrh.w r2, [sp, #308]
ldrh.w r3, [sp, #564]
ldrh.w r4, [sp, #820]
ldrh.w r5, [fp, #52]
ldrh.w r6, [fp, #308]
ldrh.w r7, [fp, #564]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #52]
strh.w r3, [r0, #180]
strh.w r8, [r0, #308]
strh.w r6, [r0, #436]
strh.w r9, [r0, #564]
strh.w r5, [r0, #692]
strh.w r7, [r0, #820]
ldrh.w r1, [sp, #54]
ldrh.w r2, [sp, #310]
ldrh.w r3, [sp, #566]
ldrh.w r4, [sp, #822]
ldrh.w r5, [fp, #54]
ldrh.w r6, [fp, #310]
ldrh.w r7, [fp, #566]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #54]
strh.w r3, [r0, #182]
strh.w r8, [r0, #310]
strh.w r6, [r0, #438]
strh.w r9, [r0, #566]
strh.w r5, [r0, #694]
strh.w r7, [r0, #822]
ldrh.w r1, [sp, #56]
ldrh.w r2, [sp, #312]
ldrh.w r3, [sp, #568]
ldrh.w r4, [sp, #824]
ldrh.w r5, [fp, #56]
ldrh.w r6, [fp, #312]
ldrh.w r7, [fp, #568]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #56]
strh.w r3, [r0, #184]
strh.w r8, [r0, #312]
strh.w r6, [r0, #440]
strh.w r9, [r0, #568]
strh.w r5, [r0, #696]
strh.w r7, [r0, #824]
ldrh.w r1, [sp, #58]
ldrh.w r2, [sp, #314]
ldrh.w r3, [sp, #570]
ldrh.w r4, [sp, #826]
ldrh.w r5, [fp, #58]
ldrh.w r6, [fp, #314]
ldrh.w r7, [fp, #570]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #58]
strh.w r3, [r0, #186]
strh.w r8, [r0, #314]
strh.w r6, [r0, #442]
strh.w r9, [r0, #570]
strh.w r5, [r0, #698]
strh.w r7, [r0, #826]
ldrh.w r1, [sp, #60]
ldrh.w r2, [sp, #316]
ldrh.w r3, [sp, #572]
ldrh.w r4, [sp, #828]
ldrh.w r5, [fp, #60]
ldrh.w r6, [fp, #316]
ldrh.w r7, [fp, #572]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #60]
strh.w r3, [r0, #188]
strh.w r8, [r0, #316]
strh.w r6, [r0, #444]
strh.w r9, [r0, #572]
strh.w r5, [r0, #700]
strh.w r7, [r0, #828]
ldrh.w r1, [sp, #62]
ldrh.w r2, [sp, #318]
ldrh.w r3, [sp, #574]
ldrh.w r4, [sp, #830]
ldrh.w r5, [fp, #62]
ldrh.w r6, [fp, #318]
ldrh.w r7, [fp, #574]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #62]
strh.w r3, [r0, #190]
strh.w r8, [r0, #318]
strh.w r6, [r0, #446]
strh.w r9, [r0, #574]
strh.w r5, [r0, #702]
strh.w r7, [r0, #830]
ldrh.w r1, [sp, #64]
ldrh.w r2, [sp, #320]
ldrh.w r3, [sp, #576]
ldrh.w r4, [sp, #832]
ldrh.w r5, [fp, #64]
ldrh.w r6, [fp, #320]
ldrh.w r7, [fp, #576]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #64]
strh.w r3, [r0, #192]
strh.w r8, [r0, #320]
strh.w r6, [r0, #448]
strh.w r9, [r0, #576]
strh.w r5, [r0, #704]
strh.w r7, [r0, #832]
ldrh.w r1, [sp, #66]
ldrh.w r2, [sp, #322]
ldrh.w r3, [sp, #578]
ldrh.w r4, [sp, #834]
ldrh.w r5, [fp, #66]
ldrh.w r6, [fp, #322]
ldrh.w r7, [fp, #578]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #66]
strh.w r3, [r0, #194]
strh.w r8, [r0, #322]
strh.w r6, [r0, #450]
strh.w r9, [r0, #578]
strh.w r5, [r0, #706]
strh.w r7, [r0, #834]
ldrh.w r1, [sp, #68]
ldrh.w r2, [sp, #324]
ldrh.w r3, [sp, #580]
ldrh.w r4, [sp, #836]
ldrh.w r5, [fp, #68]
ldrh.w r6, [fp, #324]
ldrh.w r7, [fp, #580]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #68]
strh.w r3, [r0, #196]
strh.w r8, [r0, #324]
strh.w r6, [r0, #452]
strh.w r9, [r0, #580]
strh.w r5, [r0, #708]
strh.w r7, [r0, #836]
ldrh.w r1, [sp, #70]
ldrh.w r2, [sp, #326]
ldrh.w r3, [sp, #582]
ldrh.w r4, [sp, #838]
ldrh.w r5, [fp, #70]
ldrh.w r6, [fp, #326]
ldrh.w r7, [fp, #582]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #70]
strh.w r3, [r0, #198]
strh.w r8, [r0, #326]
strh.w r6, [r0, #454]
strh.w r9, [r0, #582]
strh.w r5, [r0, #710]
strh.w r7, [r0, #838]
ldrh.w r1, [sp, #72]
ldrh.w r2, [sp, #328]
ldrh.w r3, [sp, #584]
ldrh.w r4, [sp, #840]
ldrh.w r5, [fp, #72]
ldrh.w r6, [fp, #328]
ldrh.w r7, [fp, #584]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #72]
strh.w r3, [r0, #200]
strh.w r8, [r0, #328]
strh.w r6, [r0, #456]
strh.w r9, [r0, #584]
strh.w r5, [r0, #712]
strh.w r7, [r0, #840]
ldrh.w r1, [sp, #74]
ldrh.w r2, [sp, #330]
ldrh.w r3, [sp, #586]
ldrh.w r4, [sp, #842]
ldrh.w r5, [fp, #74]
ldrh.w r6, [fp, #330]
ldrh.w r7, [fp, #586]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #74]
strh.w r3, [r0, #202]
strh.w r8, [r0, #330]
strh.w r6, [r0, #458]
strh.w r9, [r0, #586]
strh.w r5, [r0, #714]
strh.w r7, [r0, #842]
ldrh.w r1, [sp, #76]
ldrh.w r2, [sp, #332]
ldrh.w r3, [sp, #588]
ldrh.w r4, [sp, #844]
ldrh.w r5, [fp, #76]
ldrh.w r6, [fp, #332]
ldrh.w r7, [fp, #588]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #76]
strh.w r3, [r0, #204]
strh.w r8, [r0, #332]
strh.w r6, [r0, #460]
strh.w r9, [r0, #588]
strh.w r5, [r0, #716]
strh.w r7, [r0, #844]
ldrh.w r1, [sp, #78]
ldrh.w r2, [sp, #334]
ldrh.w r3, [sp, #590]
ldrh.w r4, [sp, #846]
ldrh.w r5, [fp, #78]
ldrh.w r6, [fp, #334]
ldrh.w r7, [fp, #590]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #78]
strh.w r3, [r0, #206]
strh.w r8, [r0, #334]
strh.w r6, [r0, #462]
strh.w r9, [r0, #590]
strh.w r5, [r0, #718]
strh.w r7, [r0, #846]
ldrh.w r1, [sp, #80]
ldrh.w r2, [sp, #336]
ldrh.w r3, [sp, #592]
ldrh.w r4, [sp, #848]
ldrh.w r5, [fp, #80]
ldrh.w r6, [fp, #336]
ldrh.w r7, [fp, #592]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #80]
strh.w r3, [r0, #208]
strh.w r8, [r0, #336]
strh.w r6, [r0, #464]
strh.w r9, [r0, #592]
strh.w r5, [r0, #720]
strh.w r7, [r0, #848]
ldrh.w r1, [sp, #82]
ldrh.w r2, [sp, #338]
ldrh.w r3, [sp, #594]
ldrh.w r4, [sp, #850]
ldrh.w r5, [fp, #82]
ldrh.w r6, [fp, #338]
ldrh.w r7, [fp, #594]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #82]
strh.w r3, [r0, #210]
strh.w r8, [r0, #338]
strh.w r6, [r0, #466]
strh.w r9, [r0, #594]
strh.w r5, [r0, #722]
strh.w r7, [r0, #850]
ldrh.w r1, [sp, #84]
ldrh.w r2, [sp, #340]
ldrh.w r3, [sp, #596]
ldrh.w r4, [sp, #852]
ldrh.w r5, [fp, #84]
ldrh.w r6, [fp, #340]
ldrh.w r7, [fp, #596]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #84]
strh.w r3, [r0, #212]
strh.w r8, [r0, #340]
strh.w r6, [r0, #468]
strh.w r9, [r0, #596]
strh.w r5, [r0, #724]
strh.w r7, [r0, #852]
ldrh.w r1, [sp, #86]
ldrh.w r2, [sp, #342]
ldrh.w r3, [sp, #598]
ldrh.w r4, [sp, #854]
ldrh.w r5, [fp, #86]
ldrh.w r6, [fp, #342]
ldrh.w r7, [fp, #598]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #86]
strh.w r3, [r0, #214]
strh.w r8, [r0, #342]
strh.w r6, [r0, #470]
strh.w r9, [r0, #598]
strh.w r5, [r0, #726]
strh.w r7, [r0, #854]
ldrh.w r1, [sp, #88]
ldrh.w r2, [sp, #344]
ldrh.w r3, [sp, #600]
ldrh.w r4, [sp, #856]
ldrh.w r5, [fp, #88]
ldrh.w r6, [fp, #344]
ldrh.w r7, [fp, #600]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #88]
strh.w r3, [r0, #216]
strh.w r8, [r0, #344]
strh.w r6, [r0, #472]
strh.w r9, [r0, #600]
strh.w r5, [r0, #728]
strh.w r7, [r0, #856]
ldrh.w r1, [sp, #90]
ldrh.w r2, [sp, #346]
ldrh.w r3, [sp, #602]
ldrh.w r4, [sp, #858]
ldrh.w r5, [fp, #90]
ldrh.w r6, [fp, #346]
ldrh.w r7, [fp, #602]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #90]
strh.w r3, [r0, #218]
strh.w r8, [r0, #346]
strh.w r6, [r0, #474]
strh.w r9, [r0, #602]
strh.w r5, [r0, #730]
strh.w r7, [r0, #858]
ldrh.w r1, [sp, #92]
ldrh.w r2, [sp, #348]
ldrh.w r3, [sp, #604]
ldrh.w r4, [sp, #860]
ldrh.w r5, [fp, #92]
ldrh.w r6, [fp, #348]
ldrh.w r7, [fp, #604]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #92]
strh.w r3, [r0, #220]
strh.w r8, [r0, #348]
strh.w r6, [r0, #476]
strh.w r9, [r0, #604]
strh.w r5, [r0, #732]
strh.w r7, [r0, #860]
ldrh.w r1, [sp, #94]
ldrh.w r2, [sp, #350]
ldrh.w r3, [sp, #606]
ldrh.w r4, [sp, #862]
ldrh.w r5, [fp, #94]
ldrh.w r6, [fp, #350]
ldrh.w r7, [fp, #606]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #94]
strh.w r3, [r0, #222]
strh.w r8, [r0, #350]
strh.w r6, [r0, #478]
strh.w r9, [r0, #606]
strh.w r5, [r0, #734]
strh.w r7, [r0, #862]
ldrh.w r1, [sp, #96]
ldrh.w r2, [sp, #352]
ldrh.w r3, [sp, #608]
ldrh.w r4, [sp, #864]
ldrh.w r5, [fp, #96]
ldrh.w r6, [fp, #352]
ldrh.w r7, [fp, #608]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #96]
strh.w r3, [r0, #224]
strh.w r8, [r0, #352]
strh.w r6, [r0, #480]
strh.w r9, [r0, #608]
strh.w r5, [r0, #736]
strh.w r7, [r0, #864]
ldrh.w r1, [sp, #98]
ldrh.w r2, [sp, #354]
ldrh.w r3, [sp, #610]
ldrh.w r4, [sp, #866]
ldrh.w r5, [fp, #98]
ldrh.w r6, [fp, #354]
ldrh.w r7, [fp, #610]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #98]
strh.w r3, [r0, #226]
strh.w r8, [r0, #354]
strh.w r6, [r0, #482]
strh.w r9, [r0, #610]
strh.w r5, [r0, #738]
strh.w r7, [r0, #866]
ldrh.w r1, [sp, #100]
ldrh.w r2, [sp, #356]
ldrh.w r3, [sp, #612]
ldrh.w r4, [sp, #868]
ldrh.w r5, [fp, #100]
ldrh.w r6, [fp, #356]
ldrh.w r7, [fp, #612]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #100]
strh.w r3, [r0, #228]
strh.w r8, [r0, #356]
strh.w r6, [r0, #484]
strh.w r9, [r0, #612]
strh.w r5, [r0, #740]
strh.w r7, [r0, #868]
ldrh.w r1, [sp, #102]
ldrh.w r2, [sp, #358]
ldrh.w r3, [sp, #614]
ldrh.w r4, [sp, #870]
ldrh.w r5, [fp, #102]
ldrh.w r6, [fp, #358]
ldrh.w r7, [fp, #614]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #102]
strh.w r3, [r0, #230]
strh.w r8, [r0, #358]
strh.w r6, [r0, #486]
strh.w r9, [r0, #614]
strh.w r5, [r0, #742]
strh.w r7, [r0, #870]
ldrh.w r1, [sp, #104]
ldrh.w r2, [sp, #360]
ldrh.w r3, [sp, #616]
ldrh.w r4, [sp, #872]
ldrh.w r5, [fp, #104]
ldrh.w r6, [fp, #360]
ldrh.w r7, [fp, #616]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #104]
strh.w r3, [r0, #232]
strh.w r8, [r0, #360]
strh.w r6, [r0, #488]
strh.w r9, [r0, #616]
strh.w r5, [r0, #744]
strh.w r7, [r0, #872]
ldrh.w r1, [sp, #106]
ldrh.w r2, [sp, #362]
ldrh.w r3, [sp, #618]
ldrh.w r4, [sp, #874]
ldrh.w r5, [fp, #106]
ldrh.w r6, [fp, #362]
ldrh.w r7, [fp, #618]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #106]
strh.w r3, [r0, #234]
strh.w r8, [r0, #362]
strh.w r6, [r0, #490]
strh.w r9, [r0, #618]
strh.w r5, [r0, #746]
strh.w r7, [r0, #874]
ldrh.w r1, [sp, #108]
ldrh.w r2, [sp, #364]
ldrh.w r3, [sp, #620]
ldrh.w r4, [sp, #876]
ldrh.w r5, [fp, #108]
ldrh.w r6, [fp, #364]
ldrh.w r7, [fp, #620]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #108]
strh.w r3, [r0, #236]
strh.w r8, [r0, #364]
strh.w r6, [r0, #492]
strh.w r9, [r0, #620]
strh.w r5, [r0, #748]
strh.w r7, [r0, #876]
ldrh.w r1, [sp, #110]
ldrh.w r2, [sp, #366]
ldrh.w r3, [sp, #622]
ldrh.w r4, [sp, #878]
ldrh.w r5, [fp, #110]
ldrh.w r6, [fp, #366]
ldrh.w r7, [fp, #622]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #110]
strh.w r3, [r0, #238]
strh.w r8, [r0, #366]
strh.w r6, [r0, #494]
strh.w r9, [r0, #622]
strh.w r5, [r0, #750]
strh.w r7, [r0, #878]
ldrh.w r1, [sp, #112]
ldrh.w r2, [sp, #368]
ldrh.w r3, [sp, #624]
ldrh.w r4, [sp, #880]
ldrh.w r5, [fp, #112]
ldrh.w r6, [fp, #368]
ldrh.w r7, [fp, #624]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #112]
strh.w r3, [r0, #240]
strh.w r8, [r0, #368]
strh.w r6, [r0, #496]
strh.w r9, [r0, #624]
strh.w r5, [r0, #752]
strh.w r7, [r0, #880]
ldrh.w r1, [sp, #114]
ldrh.w r2, [sp, #370]
ldrh.w r3, [sp, #626]
ldrh.w r4, [sp, #882]
ldrh.w r5, [fp, #114]
ldrh.w r6, [fp, #370]
ldrh.w r7, [fp, #626]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #114]
strh.w r3, [r0, #242]
strh.w r8, [r0, #370]
strh.w r6, [r0, #498]
strh.w r9, [r0, #626]
strh.w r5, [r0, #754]
strh.w r7, [r0, #882]
ldrh.w r1, [sp, #116]
ldrh.w r2, [sp, #372]
ldrh.w r3, [sp, #628]
ldrh.w r4, [sp, #884]
ldrh.w r5, [fp, #116]
ldrh.w r6, [fp, #372]
ldrh.w r7, [fp, #628]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #116]
strh.w r3, [r0, #244]
strh.w r8, [r0, #372]
strh.w r6, [r0, #500]
strh.w r9, [r0, #628]
strh.w r5, [r0, #756]
strh.w r7, [r0, #884]
ldrh.w r1, [sp, #118]
ldrh.w r2, [sp, #374]
ldrh.w r3, [sp, #630]
ldrh.w r4, [sp, #886]
ldrh.w r5, [fp, #118]
ldrh.w r6, [fp, #374]
ldrh.w r7, [fp, #630]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #118]
strh.w r3, [r0, #246]
strh.w r8, [r0, #374]
strh.w r6, [r0, #502]
strh.w r9, [r0, #630]
strh.w r5, [r0, #758]
strh.w r7, [r0, #886]
ldrh.w r1, [sp, #120]
ldrh.w r2, [sp, #376]
ldrh.w r3, [sp, #632]
ldrh.w r4, [sp, #888]
ldrh.w r5, [fp, #120]
ldrh.w r6, [fp, #376]
ldrh.w r7, [fp, #632]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #120]
strh.w r3, [r0, #248]
strh.w r8, [r0, #376]
strh.w r6, [r0, #504]
strh.w r9, [r0, #632]
strh.w r5, [r0, #760]
strh.w r7, [r0, #888]
ldrh.w r1, [sp, #122]
ldrh.w r2, [sp, #378]
ldrh.w r3, [sp, #634]
ldrh.w r4, [sp, #890]
ldrh.w r5, [fp, #122]
ldrh.w r6, [fp, #378]
ldrh.w r7, [fp, #634]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #122]
strh.w r3, [r0, #250]
strh.w r8, [r0, #378]
strh.w r6, [r0, #506]
strh.w r9, [r0, #634]
strh.w r5, [r0, #762]
strh.w r7, [r0, #890]
ldrh.w r1, [sp, #124]
ldrh.w r2, [sp, #380]
ldrh.w r3, [sp, #636]
ldrh.w r4, [sp, #892]
ldrh.w r5, [fp, #124]
ldrh.w r6, [fp, #380]
ldrh.w r7, [fp, #636]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #124]
strh.w r3, [r0, #252]
strh.w r8, [r0, #380]
strh.w r6, [r0, #508]
strh.w r9, [r0, #636]
strh.w r5, [r0, #764]
strh.w r7, [r0, #892]
ldrh.w r1, [sp, #126]
ldrh.w r2, [sp, #382]
ldrh.w r3, [sp, #638]
ldrh.w r4, [sp, #894]
ldrh.w r5, [fp, #126]
ldrh.w r6, [fp, #382]
ldrh.w r7, [fp, #638]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
strh.w r1, [r0, #126]
strh.w r3, [r0, #254]
strh.w r8, [r0, #382]
strh.w r6, [r0, #510]
strh.w r9, [r0, #638]
strh.w r5, [r0, #766]
strh.w r7, [r0, #894]
ldrh.w r1, [sp, #128]
ldrh.w r2, [sp, #384]
ldrh.w r3, [sp, #640]
ldrh.w r4, [sp, #896]
ldrh.w r5, [fp, #128]
ldrh.w r6, [fp, #384]
ldrh.w r7, [fp, #640]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #128]
add.w r1, sl
strh.w r1, [r0, #128]
ldrh.w sl, [r0, #256]
add.w r3, sl
strh.w r3, [r0, #256]
ldrh.w sl, [r0, #384]
add.w r8, sl
strh.w r8, [r0, #384]
ldrh.w sl, [r0, #512]
add.w r6, sl
strh.w r6, [r0, #512]
ldrh.w sl, [r0, #640]
add.w r9, sl
strh.w r9, [r0, #640]
ldrh.w sl, [r0, #768]
add.w r5, sl
strh.w r5, [r0, #768]
strh.w r7, [r0, #896]
ldrh.w r1, [sp, #130]
ldrh.w r2, [sp, #386]
ldrh.w r3, [sp, #642]
ldrh.w r4, [sp, #898]
ldrh.w r5, [fp, #130]
ldrh.w r6, [fp, #386]
ldrh.w r7, [fp, #642]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #130]
add.w r1, sl
strh.w r1, [r0, #130]
ldrh.w sl, [r0, #258]
add.w r3, sl
strh.w r3, [r0, #258]
ldrh.w sl, [r0, #386]
add.w r8, sl
strh.w r8, [r0, #386]
ldrh.w sl, [r0, #514]
add.w r6, sl
strh.w r6, [r0, #514]
ldrh.w sl, [r0, #642]
add.w r9, sl
strh.w r9, [r0, #642]
ldrh.w sl, [r0, #770]
add.w r5, sl
strh.w r5, [r0, #770]
strh.w r7, [r0, #898]
ldrh.w r1, [sp, #132]
ldrh.w r2, [sp, #388]
ldrh.w r3, [sp, #644]
ldrh.w r4, [sp, #900]
ldrh.w r5, [fp, #132]
ldrh.w r6, [fp, #388]
ldrh.w r7, [fp, #644]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #132]
add.w r1, sl
strh.w r1, [r0, #132]
ldrh.w sl, [r0, #260]
add.w r3, sl
strh.w r3, [r0, #260]
ldrh.w sl, [r0, #388]
add.w r8, sl
strh.w r8, [r0, #388]
ldrh.w sl, [r0, #516]
add.w r6, sl
strh.w r6, [r0, #516]
ldrh.w sl, [r0, #644]
add.w r9, sl
strh.w r9, [r0, #644]
ldrh.w sl, [r0, #772]
add.w r5, sl
strh.w r5, [r0, #772]
strh.w r7, [r0, #900]
ldrh.w r1, [sp, #134]
ldrh.w r2, [sp, #390]
ldrh.w r3, [sp, #646]
ldrh.w r4, [sp, #902]
ldrh.w r5, [fp, #134]
ldrh.w r6, [fp, #390]
ldrh.w r7, [fp, #646]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #134]
add.w r1, sl
strh.w r1, [r0, #134]
ldrh.w sl, [r0, #262]
add.w r3, sl
strh.w r3, [r0, #262]
ldrh.w sl, [r0, #390]
add.w r8, sl
strh.w r8, [r0, #390]
ldrh.w sl, [r0, #518]
add.w r6, sl
strh.w r6, [r0, #518]
ldrh.w sl, [r0, #646]
add.w r9, sl
strh.w r9, [r0, #646]
ldrh.w sl, [r0, #774]
add.w r5, sl
strh.w r5, [r0, #774]
strh.w r7, [r0, #902]
ldrh.w r1, [sp, #136]
ldrh.w r2, [sp, #392]
ldrh.w r3, [sp, #648]
ldrh.w r4, [sp, #904]
ldrh.w r5, [fp, #136]
ldrh.w r6, [fp, #392]
ldrh.w r7, [fp, #648]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #136]
add.w r1, sl
strh.w r1, [r0, #136]
ldrh.w sl, [r0, #264]
add.w r3, sl
strh.w r3, [r0, #264]
ldrh.w sl, [r0, #392]
add.w r8, sl
strh.w r8, [r0, #392]
ldrh.w sl, [r0, #520]
add.w r6, sl
strh.w r6, [r0, #520]
ldrh.w sl, [r0, #648]
add.w r9, sl
strh.w r9, [r0, #648]
ldrh.w sl, [r0, #776]
add.w r5, sl
strh.w r5, [r0, #776]
strh.w r7, [r0, #904]
ldrh.w r1, [sp, #138]
ldrh.w r2, [sp, #394]
ldrh.w r3, [sp, #650]
ldrh.w r4, [sp, #906]
ldrh.w r5, [fp, #138]
ldrh.w r6, [fp, #394]
ldrh.w r7, [fp, #650]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #138]
add.w r1, sl
strh.w r1, [r0, #138]
ldrh.w sl, [r0, #266]
add.w r3, sl
strh.w r3, [r0, #266]
ldrh.w sl, [r0, #394]
add.w r8, sl
strh.w r8, [r0, #394]
ldrh.w sl, [r0, #522]
add.w r6, sl
strh.w r6, [r0, #522]
ldrh.w sl, [r0, #650]
add.w r9, sl
strh.w r9, [r0, #650]
ldrh.w sl, [r0, #778]
add.w r5, sl
strh.w r5, [r0, #778]
strh.w r7, [r0, #906]
ldrh.w r1, [sp, #140]
ldrh.w r2, [sp, #396]
ldrh.w r3, [sp, #652]
ldrh.w r4, [sp, #908]
ldrh.w r5, [fp, #140]
ldrh.w r6, [fp, #396]
ldrh.w r7, [fp, #652]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #140]
add.w r1, sl
strh.w r1, [r0, #140]
ldrh.w sl, [r0, #268]
add.w r3, sl
strh.w r3, [r0, #268]
ldrh.w sl, [r0, #396]
add.w r8, sl
strh.w r8, [r0, #396]
ldrh.w sl, [r0, #524]
add.w r6, sl
strh.w r6, [r0, #524]
ldrh.w sl, [r0, #652]
add.w r9, sl
strh.w r9, [r0, #652]
ldrh.w sl, [r0, #780]
add.w r5, sl
strh.w r5, [r0, #780]
strh.w r7, [r0, #908]
ldrh.w r1, [sp, #142]
ldrh.w r2, [sp, #398]
ldrh.w r3, [sp, #654]
ldrh.w r4, [sp, #910]
ldrh.w r5, [fp, #142]
ldrh.w r6, [fp, #398]
ldrh.w r7, [fp, #654]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #142]
add.w r1, sl
strh.w r1, [r0, #142]
ldrh.w sl, [r0, #270]
add.w r3, sl
strh.w r3, [r0, #270]
ldrh.w sl, [r0, #398]
add.w r8, sl
strh.w r8, [r0, #398]
ldrh.w sl, [r0, #526]
add.w r6, sl
strh.w r6, [r0, #526]
ldrh.w sl, [r0, #654]
add.w r9, sl
strh.w r9, [r0, #654]
ldrh.w sl, [r0, #782]
add.w r5, sl
strh.w r5, [r0, #782]
strh.w r7, [r0, #910]
ldrh.w r1, [sp, #144]
ldrh.w r2, [sp, #400]
ldrh.w r3, [sp, #656]
ldrh.w r4, [sp, #912]
ldrh.w r5, [fp, #144]
ldrh.w r6, [fp, #400]
ldrh.w r7, [fp, #656]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #144]
add.w r1, sl
strh.w r1, [r0, #144]
ldrh.w sl, [r0, #272]
add.w r3, sl
strh.w r3, [r0, #272]
ldrh.w sl, [r0, #400]
add.w r8, sl
strh.w r8, [r0, #400]
ldrh.w sl, [r0, #528]
add.w r6, sl
strh.w r6, [r0, #528]
ldrh.w sl, [r0, #656]
add.w r9, sl
strh.w r9, [r0, #656]
ldrh.w sl, [r0, #784]
add.w r5, sl
strh.w r5, [r0, #784]
strh.w r7, [r0, #912]
ldrh.w r1, [sp, #146]
ldrh.w r2, [sp, #402]
ldrh.w r3, [sp, #658]
ldrh.w r4, [sp, #914]
ldrh.w r5, [fp, #146]
ldrh.w r6, [fp, #402]
ldrh.w r7, [fp, #658]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #146]
add.w r1, sl
strh.w r1, [r0, #146]
ldrh.w sl, [r0, #274]
add.w r3, sl
strh.w r3, [r0, #274]
ldrh.w sl, [r0, #402]
add.w r8, sl
strh.w r8, [r0, #402]
ldrh.w sl, [r0, #530]
add.w r6, sl
strh.w r6, [r0, #530]
ldrh.w sl, [r0, #658]
add.w r9, sl
strh.w r9, [r0, #658]
ldrh.w sl, [r0, #786]
add.w r5, sl
strh.w r5, [r0, #786]
strh.w r7, [r0, #914]
ldrh.w r1, [sp, #148]
ldrh.w r2, [sp, #404]
ldrh.w r3, [sp, #660]
ldrh.w r4, [sp, #916]
ldrh.w r5, [fp, #148]
ldrh.w r6, [fp, #404]
ldrh.w r7, [fp, #660]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #148]
add.w r1, sl
strh.w r1, [r0, #148]
ldrh.w sl, [r0, #276]
add.w r3, sl
strh.w r3, [r0, #276]
ldrh.w sl, [r0, #404]
add.w r8, sl
strh.w r8, [r0, #404]
ldrh.w sl, [r0, #532]
add.w r6, sl
strh.w r6, [r0, #532]
ldrh.w sl, [r0, #660]
add.w r9, sl
strh.w r9, [r0, #660]
ldrh.w sl, [r0, #788]
add.w r5, sl
strh.w r5, [r0, #788]
strh.w r7, [r0, #916]
ldrh.w r1, [sp, #150]
ldrh.w r2, [sp, #406]
ldrh.w r3, [sp, #662]
ldrh.w r4, [sp, #918]
ldrh.w r5, [fp, #150]
ldrh.w r6, [fp, #406]
ldrh.w r7, [fp, #662]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #150]
add.w r1, sl
strh.w r1, [r0, #150]
ldrh.w sl, [r0, #278]
add.w r3, sl
strh.w r3, [r0, #278]
ldrh.w sl, [r0, #406]
add.w r8, sl
strh.w r8, [r0, #406]
ldrh.w sl, [r0, #534]
add.w r6, sl
strh.w r6, [r0, #534]
ldrh.w sl, [r0, #662]
add.w r9, sl
strh.w r9, [r0, #662]
ldrh.w sl, [r0, #790]
add.w r5, sl
strh.w r5, [r0, #790]
strh.w r7, [r0, #918]
ldrh.w r1, [sp, #152]
ldrh.w r2, [sp, #408]
ldrh.w r3, [sp, #664]
ldrh.w r4, [sp, #920]
ldrh.w r5, [fp, #152]
ldrh.w r6, [fp, #408]
ldrh.w r7, [fp, #664]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #152]
add.w r1, sl
strh.w r1, [r0, #152]
ldrh.w sl, [r0, #280]
add.w r3, sl
strh.w r3, [r0, #280]
ldrh.w sl, [r0, #408]
add.w r8, sl
strh.w r8, [r0, #408]
ldrh.w sl, [r0, #536]
add.w r6, sl
strh.w r6, [r0, #536]
ldrh.w sl, [r0, #664]
add.w r9, sl
strh.w r9, [r0, #664]
ldrh.w sl, [r0, #792]
add.w r5, sl
strh.w r5, [r0, #792]
strh.w r7, [r0, #920]
ldrh.w r1, [sp, #154]
ldrh.w r2, [sp, #410]
ldrh.w r3, [sp, #666]
ldrh.w r4, [sp, #922]
ldrh.w r5, [fp, #154]
ldrh.w r6, [fp, #410]
ldrh.w r7, [fp, #666]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #154]
add.w r1, sl
strh.w r1, [r0, #154]
ldrh.w sl, [r0, #282]
add.w r3, sl
strh.w r3, [r0, #282]
ldrh.w sl, [r0, #410]
add.w r8, sl
strh.w r8, [r0, #410]
ldrh.w sl, [r0, #538]
add.w r6, sl
strh.w r6, [r0, #538]
ldrh.w sl, [r0, #666]
add.w r9, sl
strh.w r9, [r0, #666]
ldrh.w sl, [r0, #794]
add.w r5, sl
strh.w r5, [r0, #794]
strh.w r7, [r0, #922]
ldrh.w r1, [sp, #156]
ldrh.w r2, [sp, #412]
ldrh.w r3, [sp, #668]
ldrh.w r4, [sp, #924]
ldrh.w r5, [fp, #156]
ldrh.w r6, [fp, #412]
ldrh.w r7, [fp, #668]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #156]
add.w r1, sl
strh.w r1, [r0, #156]
ldrh.w sl, [r0, #284]
add.w r3, sl
strh.w r3, [r0, #284]
ldrh.w sl, [r0, #412]
add.w r8, sl
strh.w r8, [r0, #412]
ldrh.w sl, [r0, #540]
add.w r6, sl
strh.w r6, [r0, #540]
ldrh.w sl, [r0, #668]
add.w r9, sl
strh.w r9, [r0, #668]
ldrh.w sl, [r0, #796]
add.w r5, sl
strh.w r5, [r0, #796]
strh.w r7, [r0, #924]
ldrh.w r1, [sp, #158]
ldrh.w r2, [sp, #414]
ldrh.w r3, [sp, #670]
ldrh.w r4, [sp, #926]
ldrh.w r5, [fp, #158]
ldrh.w r6, [fp, #414]
ldrh.w r7, [fp, #670]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #158]
add.w r1, sl
strh.w r1, [r0, #158]
ldrh.w sl, [r0, #286]
add.w r3, sl
strh.w r3, [r0, #286]
ldrh.w sl, [r0, #414]
add.w r8, sl
strh.w r8, [r0, #414]
ldrh.w sl, [r0, #542]
add.w r6, sl
strh.w r6, [r0, #542]
ldrh.w sl, [r0, #670]
add.w r9, sl
strh.w r9, [r0, #670]
ldrh.w sl, [r0, #798]
add.w r5, sl
strh.w r5, [r0, #798]
strh.w r7, [r0, #926]
ldrh.w r1, [sp, #160]
ldrh.w r2, [sp, #416]
ldrh.w r3, [sp, #672]
ldrh.w r4, [sp, #928]
ldrh.w r5, [fp, #160]
ldrh.w r6, [fp, #416]
ldrh.w r7, [fp, #672]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #160]
add.w r1, sl
strh.w r1, [r0, #160]
ldrh.w sl, [r0, #288]
add.w r3, sl
strh.w r3, [r0, #288]
ldrh.w sl, [r0, #416]
add.w r8, sl
strh.w r8, [r0, #416]
ldrh.w sl, [r0, #544]
add.w r6, sl
strh.w r6, [r0, #544]
ldrh.w sl, [r0, #672]
add.w r9, sl
strh.w r9, [r0, #672]
ldrh.w sl, [r0, #800]
add.w r5, sl
strh.w r5, [r0, #800]
strh.w r7, [r0, #928]
ldrh.w r1, [sp, #162]
ldrh.w r2, [sp, #418]
ldrh.w r3, [sp, #674]
ldrh.w r4, [sp, #930]
ldrh.w r5, [fp, #162]
ldrh.w r6, [fp, #418]
ldrh.w r7, [fp, #674]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #162]
add.w r1, sl
strh.w r1, [r0, #162]
ldrh.w sl, [r0, #290]
add.w r3, sl
strh.w r3, [r0, #290]
ldrh.w sl, [r0, #418]
add.w r8, sl
strh.w r8, [r0, #418]
ldrh.w sl, [r0, #546]
add.w r6, sl
strh.w r6, [r0, #546]
ldrh.w sl, [r0, #674]
add.w r9, sl
strh.w r9, [r0, #674]
ldrh.w sl, [r0, #802]
add.w r5, sl
strh.w r5, [r0, #802]
strh.w r7, [r0, #930]
ldrh.w r1, [sp, #164]
ldrh.w r2, [sp, #420]
ldrh.w r3, [sp, #676]
ldrh.w r4, [sp, #932]
ldrh.w r5, [fp, #164]
ldrh.w r6, [fp, #420]
ldrh.w r7, [fp, #676]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #164]
add.w r1, sl
strh.w r1, [r0, #164]
ldrh.w sl, [r0, #292]
add.w r3, sl
strh.w r3, [r0, #292]
ldrh.w sl, [r0, #420]
add.w r8, sl
strh.w r8, [r0, #420]
ldrh.w sl, [r0, #548]
add.w r6, sl
strh.w r6, [r0, #548]
ldrh.w sl, [r0, #676]
add.w r9, sl
strh.w r9, [r0, #676]
ldrh.w sl, [r0, #804]
add.w r5, sl
strh.w r5, [r0, #804]
strh.w r7, [r0, #932]
ldrh.w r1, [sp, #166]
ldrh.w r2, [sp, #422]
ldrh.w r3, [sp, #678]
ldrh.w r4, [sp, #934]
ldrh.w r5, [fp, #166]
ldrh.w r6, [fp, #422]
ldrh.w r7, [fp, #678]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #166]
add.w r1, sl
strh.w r1, [r0, #166]
ldrh.w sl, [r0, #294]
add.w r3, sl
strh.w r3, [r0, #294]
ldrh.w sl, [r0, #422]
add.w r8, sl
strh.w r8, [r0, #422]
ldrh.w sl, [r0, #550]
add.w r6, sl
strh.w r6, [r0, #550]
ldrh.w sl, [r0, #678]
add.w r9, sl
strh.w r9, [r0, #678]
ldrh.w sl, [r0, #806]
add.w r5, sl
strh.w r5, [r0, #806]
strh.w r7, [r0, #934]
ldrh.w r1, [sp, #168]
ldrh.w r2, [sp, #424]
ldrh.w r3, [sp, #680]
ldrh.w r4, [sp, #936]
ldrh.w r5, [fp, #168]
ldrh.w r6, [fp, #424]
ldrh.w r7, [fp, #680]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #168]
add.w r1, sl
strh.w r1, [r0, #168]
ldrh.w sl, [r0, #296]
add.w r3, sl
strh.w r3, [r0, #296]
ldrh.w sl, [r0, #424]
add.w r8, sl
strh.w r8, [r0, #424]
ldrh.w sl, [r0, #552]
add.w r6, sl
strh.w r6, [r0, #552]
ldrh.w sl, [r0, #680]
add.w r9, sl
strh.w r9, [r0, #680]
ldrh.w sl, [r0, #808]
add.w r5, sl
strh.w r5, [r0, #808]
strh.w r7, [r0, #936]
ldrh.w r1, [sp, #170]
ldrh.w r2, [sp, #426]
ldrh.w r3, [sp, #682]
ldrh.w r4, [sp, #938]
ldrh.w r5, [fp, #170]
ldrh.w r6, [fp, #426]
ldrh.w r7, [fp, #682]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #170]
add.w r1, sl
strh.w r1, [r0, #170]
ldrh.w sl, [r0, #298]
add.w r3, sl
strh.w r3, [r0, #298]
ldrh.w sl, [r0, #426]
add.w r8, sl
strh.w r8, [r0, #426]
ldrh.w sl, [r0, #554]
add.w r6, sl
strh.w r6, [r0, #554]
ldrh.w sl, [r0, #682]
add.w r9, sl
strh.w r9, [r0, #682]
ldrh.w sl, [r0, #810]
add.w r5, sl
strh.w r5, [r0, #810]
strh.w r7, [r0, #938]
ldrh.w r1, [sp, #172]
ldrh.w r2, [sp, #428]
ldrh.w r3, [sp, #684]
ldrh.w r4, [sp, #940]
ldrh.w r5, [fp, #172]
ldrh.w r6, [fp, #428]
ldrh.w r7, [fp, #684]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #172]
add.w r1, sl
strh.w r1, [r0, #172]
ldrh.w sl, [r0, #300]
add.w r3, sl
strh.w r3, [r0, #300]
ldrh.w sl, [r0, #428]
add.w r8, sl
strh.w r8, [r0, #428]
ldrh.w sl, [r0, #556]
add.w r6, sl
strh.w r6, [r0, #556]
ldrh.w sl, [r0, #684]
add.w r9, sl
strh.w r9, [r0, #684]
ldrh.w sl, [r0, #812]
add.w r5, sl
strh.w r5, [r0, #812]
strh.w r7, [r0, #940]
ldrh.w r1, [sp, #174]
ldrh.w r2, [sp, #430]
ldrh.w r3, [sp, #686]
ldrh.w r4, [sp, #942]
ldrh.w r5, [fp, #174]
ldrh.w r6, [fp, #430]
ldrh.w r7, [fp, #686]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #174]
add.w r1, sl
strh.w r1, [r0, #174]
ldrh.w sl, [r0, #302]
add.w r3, sl
strh.w r3, [r0, #302]
ldrh.w sl, [r0, #430]
add.w r8, sl
strh.w r8, [r0, #430]
ldrh.w sl, [r0, #558]
add.w r6, sl
strh.w r6, [r0, #558]
ldrh.w sl, [r0, #686]
add.w r9, sl
strh.w r9, [r0, #686]
ldrh.w sl, [r0, #814]
add.w r5, sl
strh.w r5, [r0, #814]
strh.w r7, [r0, #942]
ldrh.w r1, [sp, #176]
ldrh.w r2, [sp, #432]
ldrh.w r3, [sp, #688]
ldrh.w r4, [sp, #944]
ldrh.w r5, [fp, #176]
ldrh.w r6, [fp, #432]
ldrh.w r7, [fp, #688]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #176]
add.w r1, sl
strh.w r1, [r0, #176]
ldrh.w sl, [r0, #304]
add.w r3, sl
strh.w r3, [r0, #304]
ldrh.w sl, [r0, #432]
add.w r8, sl
strh.w r8, [r0, #432]
ldrh.w sl, [r0, #560]
add.w r6, sl
strh.w r6, [r0, #560]
ldrh.w sl, [r0, #688]
add.w r9, sl
strh.w r9, [r0, #688]
ldrh.w sl, [r0, #816]
add.w r5, sl
strh.w r5, [r0, #816]
strh.w r7, [r0, #944]
ldrh.w r1, [sp, #178]
ldrh.w r2, [sp, #434]
ldrh.w r3, [sp, #690]
ldrh.w r4, [sp, #946]
ldrh.w r5, [fp, #178]
ldrh.w r6, [fp, #434]
ldrh.w r7, [fp, #690]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #178]
add.w r1, sl
strh.w r1, [r0, #178]
ldrh.w sl, [r0, #306]
add.w r3, sl
strh.w r3, [r0, #306]
ldrh.w sl, [r0, #434]
add.w r8, sl
strh.w r8, [r0, #434]
ldrh.w sl, [r0, #562]
add.w r6, sl
strh.w r6, [r0, #562]
ldrh.w sl, [r0, #690]
add.w r9, sl
strh.w r9, [r0, #690]
ldrh.w sl, [r0, #818]
add.w r5, sl
strh.w r5, [r0, #818]
strh.w r7, [r0, #946]
ldrh.w r1, [sp, #180]
ldrh.w r2, [sp, #436]
ldrh.w r3, [sp, #692]
ldrh.w r4, [sp, #948]
ldrh.w r5, [fp, #180]
ldrh.w r6, [fp, #436]
ldrh.w r7, [fp, #692]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #180]
add.w r1, sl
strh.w r1, [r0, #180]
ldrh.w sl, [r0, #308]
add.w r3, sl
strh.w r3, [r0, #308]
ldrh.w sl, [r0, #436]
add.w r8, sl
strh.w r8, [r0, #436]
ldrh.w sl, [r0, #564]
add.w r6, sl
strh.w r6, [r0, #564]
ldrh.w sl, [r0, #692]
add.w r9, sl
strh.w r9, [r0, #692]
ldrh.w sl, [r0, #820]
add.w r5, sl
strh.w r5, [r0, #820]
strh.w r7, [r0, #948]
ldrh.w r1, [sp, #182]
ldrh.w r2, [sp, #438]
ldrh.w r3, [sp, #694]
ldrh.w r4, [sp, #950]
ldrh.w r5, [fp, #182]
ldrh.w r6, [fp, #438]
ldrh.w r7, [fp, #694]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #182]
add.w r1, sl
strh.w r1, [r0, #182]
ldrh.w sl, [r0, #310]
add.w r3, sl
strh.w r3, [r0, #310]
ldrh.w sl, [r0, #438]
add.w r8, sl
strh.w r8, [r0, #438]
ldrh.w sl, [r0, #566]
add.w r6, sl
strh.w r6, [r0, #566]
ldrh.w sl, [r0, #694]
add.w r9, sl
strh.w r9, [r0, #694]
ldrh.w sl, [r0, #822]
add.w r5, sl
strh.w r5, [r0, #822]
strh.w r7, [r0, #950]
ldrh.w r1, [sp, #184]
ldrh.w r2, [sp, #440]
ldrh.w r3, [sp, #696]
ldrh.w r4, [sp, #952]
ldrh.w r5, [fp, #184]
ldrh.w r6, [fp, #440]
ldrh.w r7, [fp, #696]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #184]
add.w r1, sl
strh.w r1, [r0, #184]
ldrh.w sl, [r0, #312]
add.w r3, sl
strh.w r3, [r0, #312]
ldrh.w sl, [r0, #440]
add.w r8, sl
strh.w r8, [r0, #440]
ldrh.w sl, [r0, #568]
add.w r6, sl
strh.w r6, [r0, #568]
ldrh.w sl, [r0, #696]
add.w r9, sl
strh.w r9, [r0, #696]
ldrh.w sl, [r0, #824]
add.w r5, sl
strh.w r5, [r0, #824]
strh.w r7, [r0, #952]
ldrh.w r1, [sp, #186]
ldrh.w r2, [sp, #442]
ldrh.w r3, [sp, #698]
ldrh.w r4, [sp, #954]
ldrh.w r5, [fp, #186]
ldrh.w r6, [fp, #442]
ldrh.w r7, [fp, #698]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #186]
add.w r1, sl
strh.w r1, [r0, #186]
ldrh.w sl, [r0, #314]
add.w r3, sl
strh.w r3, [r0, #314]
ldrh.w sl, [r0, #442]
add.w r8, sl
strh.w r8, [r0, #442]
ldrh.w sl, [r0, #570]
add.w r6, sl
strh.w r6, [r0, #570]
ldrh.w sl, [r0, #698]
add.w r9, sl
strh.w r9, [r0, #698]
ldrh.w sl, [r0, #826]
add.w r5, sl
strh.w r5, [r0, #826]
strh.w r7, [r0, #954]
ldrh.w r1, [sp, #188]
ldrh.w r2, [sp, #444]
ldrh.w r3, [sp, #700]
ldrh.w r4, [sp, #956]
ldrh.w r5, [fp, #188]
ldrh.w r6, [fp, #444]
ldrh.w r7, [fp, #700]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #188]
add.w r1, sl
strh.w r1, [r0, #188]
ldrh.w sl, [r0, #316]
add.w r3, sl
strh.w r3, [r0, #316]
ldrh.w sl, [r0, #444]
add.w r8, sl
strh.w r8, [r0, #444]
ldrh.w sl, [r0, #572]
add.w r6, sl
strh.w r6, [r0, #572]
ldrh.w sl, [r0, #700]
add.w r9, sl
strh.w r9, [r0, #700]
ldrh.w sl, [r0, #828]
add.w r5, sl
strh.w r5, [r0, #828]
strh.w r7, [r0, #956]
ldrh.w r1, [sp, #190]
ldrh.w r2, [sp, #446]
ldrh.w r3, [sp, #702]
ldrh.w r4, [sp, #958]
ldrh.w r5, [fp, #190]
ldrh.w r6, [fp, #446]
ldrh.w r7, [fp, #702]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #190]
add.w r1, sl
strh.w r1, [r0, #190]
ldrh.w sl, [r0, #318]
add.w r3, sl
strh.w r3, [r0, #318]
ldrh.w sl, [r0, #446]
add.w r8, sl
strh.w r8, [r0, #446]
ldrh.w sl, [r0, #574]
add.w r6, sl
strh.w r6, [r0, #574]
ldrh.w sl, [r0, #702]
add.w r9, sl
strh.w r9, [r0, #702]
ldrh.w sl, [r0, #830]
add.w r5, sl
strh.w r5, [r0, #830]
strh.w r7, [r0, #958]
ldrh.w r1, [sp, #192]
ldrh.w r2, [sp, #448]
ldrh.w r3, [sp, #704]
ldrh.w r4, [sp, #960]
ldrh.w r5, [fp, #192]
ldrh.w r6, [fp, #448]
ldrh.w r7, [fp, #704]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #192]
add.w r1, sl
strh.w r1, [r0, #192]
ldrh.w sl, [r0, #320]
add.w r3, sl
strh.w r3, [r0, #320]
ldrh.w sl, [r0, #448]
add.w r8, sl
strh.w r8, [r0, #448]
ldrh.w sl, [r0, #576]
add.w r6, sl
strh.w r6, [r0, #576]
ldrh.w sl, [r0, #704]
add.w r9, sl
strh.w r9, [r0, #704]
ldrh.w sl, [r0, #832]
add.w r5, sl
strh.w r5, [r0, #832]
strh.w r7, [r0, #960]
ldrh.w r1, [sp, #194]
ldrh.w r2, [sp, #450]
ldrh.w r3, [sp, #706]
ldrh.w r4, [sp, #962]
ldrh.w r5, [fp, #194]
ldrh.w r6, [fp, #450]
ldrh.w r7, [fp, #706]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #194]
add.w r1, sl
strh.w r1, [r0, #194]
ldrh.w sl, [r0, #322]
add.w r3, sl
strh.w r3, [r0, #322]
ldrh.w sl, [r0, #450]
add.w r8, sl
strh.w r8, [r0, #450]
ldrh.w sl, [r0, #578]
add.w r6, sl
strh.w r6, [r0, #578]
ldrh.w sl, [r0, #706]
add.w r9, sl
strh.w r9, [r0, #706]
ldrh.w sl, [r0, #834]
add.w r5, sl
strh.w r5, [r0, #834]
strh.w r7, [r0, #962]
ldrh.w r1, [sp, #196]
ldrh.w r2, [sp, #452]
ldrh.w r3, [sp, #708]
ldrh.w r4, [sp, #964]
ldrh.w r5, [fp, #196]
ldrh.w r6, [fp, #452]
ldrh.w r7, [fp, #708]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #196]
add.w r1, sl
strh.w r1, [r0, #196]
ldrh.w sl, [r0, #324]
add.w r3, sl
strh.w r3, [r0, #324]
ldrh.w sl, [r0, #452]
add.w r8, sl
strh.w r8, [r0, #452]
ldrh.w sl, [r0, #580]
add.w r6, sl
strh.w r6, [r0, #580]
ldrh.w sl, [r0, #708]
add.w r9, sl
strh.w r9, [r0, #708]
ldrh.w sl, [r0, #836]
add.w r5, sl
strh.w r5, [r0, #836]
strh.w r7, [r0, #964]
ldrh.w r1, [sp, #198]
ldrh.w r2, [sp, #454]
ldrh.w r3, [sp, #710]
ldrh.w r4, [sp, #966]
ldrh.w r5, [fp, #198]
ldrh.w r6, [fp, #454]
ldrh.w r7, [fp, #710]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #198]
add.w r1, sl
strh.w r1, [r0, #198]
ldrh.w sl, [r0, #326]
add.w r3, sl
strh.w r3, [r0, #326]
ldrh.w sl, [r0, #454]
add.w r8, sl
strh.w r8, [r0, #454]
ldrh.w sl, [r0, #582]
add.w r6, sl
strh.w r6, [r0, #582]
ldrh.w sl, [r0, #710]
add.w r9, sl
strh.w r9, [r0, #710]
ldrh.w sl, [r0, #838]
add.w r5, sl
strh.w r5, [r0, #838]
strh.w r7, [r0, #966]
ldrh.w r1, [sp, #200]
ldrh.w r2, [sp, #456]
ldrh.w r3, [sp, #712]
ldrh.w r4, [sp, #968]
ldrh.w r5, [fp, #200]
ldrh.w r6, [fp, #456]
ldrh.w r7, [fp, #712]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #200]
add.w r1, sl
strh.w r1, [r0, #200]
ldrh.w sl, [r0, #328]
add.w r3, sl
strh.w r3, [r0, #328]
ldrh.w sl, [r0, #456]
add.w r8, sl
strh.w r8, [r0, #456]
ldrh.w sl, [r0, #584]
add.w r6, sl
strh.w r6, [r0, #584]
ldrh.w sl, [r0, #712]
add.w r9, sl
strh.w r9, [r0, #712]
ldrh.w sl, [r0, #840]
add.w r5, sl
strh.w r5, [r0, #840]
strh.w r7, [r0, #968]
ldrh.w r1, [sp, #202]
ldrh.w r2, [sp, #458]
ldrh.w r3, [sp, #714]
ldrh.w r4, [sp, #970]
ldrh.w r5, [fp, #202]
ldrh.w r6, [fp, #458]
ldrh.w r7, [fp, #714]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #202]
add.w r1, sl
strh.w r1, [r0, #202]
ldrh.w sl, [r0, #330]
add.w r3, sl
strh.w r3, [r0, #330]
ldrh.w sl, [r0, #458]
add.w r8, sl
strh.w r8, [r0, #458]
ldrh.w sl, [r0, #586]
add.w r6, sl
strh.w r6, [r0, #586]
ldrh.w sl, [r0, #714]
add.w r9, sl
strh.w r9, [r0, #714]
ldrh.w sl, [r0, #842]
add.w r5, sl
strh.w r5, [r0, #842]
strh.w r7, [r0, #970]
ldrh.w r1, [sp, #204]
ldrh.w r2, [sp, #460]
ldrh.w r3, [sp, #716]
ldrh.w r4, [sp, #972]
ldrh.w r5, [fp, #204]
ldrh.w r6, [fp, #460]
ldrh.w r7, [fp, #716]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #204]
add.w r1, sl
strh.w r1, [r0, #204]
ldrh.w sl, [r0, #332]
add.w r3, sl
strh.w r3, [r0, #332]
ldrh.w sl, [r0, #460]
add.w r8, sl
strh.w r8, [r0, #460]
ldrh.w sl, [r0, #588]
add.w r6, sl
strh.w r6, [r0, #588]
ldrh.w sl, [r0, #716]
add.w r9, sl
strh.w r9, [r0, #716]
ldrh.w sl, [r0, #844]
add.w r5, sl
strh.w r5, [r0, #844]
strh.w r7, [r0, #972]
ldrh.w r1, [sp, #206]
ldrh.w r2, [sp, #462]
ldrh.w r3, [sp, #718]
ldrh.w r4, [sp, #974]
ldrh.w r5, [fp, #206]
ldrh.w r6, [fp, #462]
ldrh.w r7, [fp, #718]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #206]
add.w r1, sl
strh.w r1, [r0, #206]
ldrh.w sl, [r0, #334]
add.w r3, sl
strh.w r3, [r0, #334]
ldrh.w sl, [r0, #462]
add.w r8, sl
strh.w r8, [r0, #462]
ldrh.w sl, [r0, #590]
add.w r6, sl
strh.w r6, [r0, #590]
ldrh.w sl, [r0, #718]
add.w r9, sl
strh.w r9, [r0, #718]
ldrh.w sl, [r0, #846]
add.w r5, sl
strh.w r5, [r0, #846]
strh.w r7, [r0, #974]
ldrh.w r1, [sp, #208]
ldrh.w r2, [sp, #464]
ldrh.w r3, [sp, #720]
ldrh.w r4, [sp, #976]
ldrh.w r5, [fp, #208]
ldrh.w r6, [fp, #464]
ldrh.w r7, [fp, #720]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #208]
add.w r1, sl
strh.w r1, [r0, #208]
ldrh.w sl, [r0, #336]
add.w r3, sl
strh.w r3, [r0, #336]
ldrh.w sl, [r0, #464]
add.w r8, sl
strh.w r8, [r0, #464]
ldrh.w sl, [r0, #592]
add.w r6, sl
strh.w r6, [r0, #592]
ldrh.w sl, [r0, #720]
add.w r9, sl
strh.w r9, [r0, #720]
ldrh.w sl, [r0, #848]
add.w r5, sl
strh.w r5, [r0, #848]
strh.w r7, [r0, #976]
ldrh.w r1, [sp, #210]
ldrh.w r2, [sp, #466]
ldrh.w r3, [sp, #722]
ldrh.w r4, [sp, #978]
ldrh.w r5, [fp, #210]
ldrh.w r6, [fp, #466]
ldrh.w r7, [fp, #722]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #210]
add.w r1, sl
strh.w r1, [r0, #210]
ldrh.w sl, [r0, #338]
add.w r3, sl
strh.w r3, [r0, #338]
ldrh.w sl, [r0, #466]
add.w r8, sl
strh.w r8, [r0, #466]
ldrh.w sl, [r0, #594]
add.w r6, sl
strh.w r6, [r0, #594]
ldrh.w sl, [r0, #722]
add.w r9, sl
strh.w r9, [r0, #722]
ldrh.w sl, [r0, #850]
add.w r5, sl
strh.w r5, [r0, #850]
strh.w r7, [r0, #978]
ldrh.w r1, [sp, #212]
ldrh.w r2, [sp, #468]
ldrh.w r3, [sp, #724]
ldrh.w r4, [sp, #980]
ldrh.w r5, [fp, #212]
ldrh.w r6, [fp, #468]
ldrh.w r7, [fp, #724]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #212]
add.w r1, sl
strh.w r1, [r0, #212]
ldrh.w sl, [r0, #340]
add.w r3, sl
strh.w r3, [r0, #340]
ldrh.w sl, [r0, #468]
add.w r8, sl
strh.w r8, [r0, #468]
ldrh.w sl, [r0, #596]
add.w r6, sl
strh.w r6, [r0, #596]
ldrh.w sl, [r0, #724]
add.w r9, sl
strh.w r9, [r0, #724]
ldrh.w sl, [r0, #852]
add.w r5, sl
strh.w r5, [r0, #852]
strh.w r7, [r0, #980]
ldrh.w r1, [sp, #214]
ldrh.w r2, [sp, #470]
ldrh.w r3, [sp, #726]
ldrh.w r4, [sp, #982]
ldrh.w r5, [fp, #214]
ldrh.w r6, [fp, #470]
ldrh.w r7, [fp, #726]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #214]
add.w r1, sl
strh.w r1, [r0, #214]
ldrh.w sl, [r0, #342]
add.w r3, sl
strh.w r3, [r0, #342]
ldrh.w sl, [r0, #470]
add.w r8, sl
strh.w r8, [r0, #470]
ldrh.w sl, [r0, #598]
add.w r6, sl
strh.w r6, [r0, #598]
ldrh.w sl, [r0, #726]
add.w r9, sl
strh.w r9, [r0, #726]
ldrh.w sl, [r0, #854]
add.w r5, sl
strh.w r5, [r0, #854]
strh.w r7, [r0, #982]
ldrh.w r1, [sp, #216]
ldrh.w r2, [sp, #472]
ldrh.w r3, [sp, #728]
ldrh.w r4, [sp, #984]
ldrh.w r5, [fp, #216]
ldrh.w r6, [fp, #472]
ldrh.w r7, [fp, #728]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #216]
add.w r1, sl
strh.w r1, [r0, #216]
ldrh.w sl, [r0, #344]
add.w r3, sl
strh.w r3, [r0, #344]
ldrh.w sl, [r0, #472]
add.w r8, sl
strh.w r8, [r0, #472]
ldrh.w sl, [r0, #600]
add.w r6, sl
strh.w r6, [r0, #600]
ldrh.w sl, [r0, #728]
add.w r9, sl
strh.w r9, [r0, #728]
ldrh.w sl, [r0, #856]
add.w r5, sl
strh.w r5, [r0, #856]
strh.w r7, [r0, #984]
ldrh.w r1, [sp, #218]
ldrh.w r2, [sp, #474]
ldrh.w r3, [sp, #730]
ldrh.w r4, [sp, #986]
ldrh.w r5, [fp, #218]
ldrh.w r6, [fp, #474]
ldrh.w r7, [fp, #730]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #218]
add.w r1, sl
strh.w r1, [r0, #218]
ldrh.w sl, [r0, #346]
add.w r3, sl
strh.w r3, [r0, #346]
ldrh.w sl, [r0, #474]
add.w r8, sl
strh.w r8, [r0, #474]
ldrh.w sl, [r0, #602]
add.w r6, sl
strh.w r6, [r0, #602]
ldrh.w sl, [r0, #730]
add.w r9, sl
strh.w r9, [r0, #730]
ldrh.w sl, [r0, #858]
add.w r5, sl
strh.w r5, [r0, #858]
strh.w r7, [r0, #986]
ldrh.w r1, [sp, #220]
ldrh.w r2, [sp, #476]
ldrh.w r3, [sp, #732]
ldrh.w r4, [sp, #988]
ldrh.w r5, [fp, #220]
ldrh.w r6, [fp, #476]
ldrh.w r7, [fp, #732]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #220]
add.w r1, sl
strh.w r1, [r0, #220]
ldrh.w sl, [r0, #348]
add.w r3, sl
strh.w r3, [r0, #348]
ldrh.w sl, [r0, #476]
add.w r8, sl
strh.w r8, [r0, #476]
ldrh.w sl, [r0, #604]
add.w r6, sl
strh.w r6, [r0, #604]
ldrh.w sl, [r0, #732]
add.w r9, sl
strh.w r9, [r0, #732]
ldrh.w sl, [r0, #860]
add.w r5, sl
strh.w r5, [r0, #860]
strh.w r7, [r0, #988]
ldrh.w r1, [sp, #222]
ldrh.w r2, [sp, #478]
ldrh.w r3, [sp, #734]
ldrh.w r4, [sp, #990]
ldrh.w r5, [fp, #222]
ldrh.w r6, [fp, #478]
ldrh.w r7, [fp, #734]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #222]
add.w r1, sl
strh.w r1, [r0, #222]
ldrh.w sl, [r0, #350]
add.w r3, sl
strh.w r3, [r0, #350]
ldrh.w sl, [r0, #478]
add.w r8, sl
strh.w r8, [r0, #478]
ldrh.w sl, [r0, #606]
add.w r6, sl
strh.w r6, [r0, #606]
ldrh.w sl, [r0, #734]
add.w r9, sl
strh.w r9, [r0, #734]
ldrh.w sl, [r0, #862]
add.w r5, sl
strh.w r5, [r0, #862]
strh.w r7, [r0, #990]
ldrh.w r1, [sp, #224]
ldrh.w r2, [sp, #480]
ldrh.w r3, [sp, #736]
ldrh.w r4, [sp, #992]
ldrh.w r5, [fp, #224]
ldrh.w r6, [fp, #480]
ldrh.w r7, [fp, #736]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #224]
add.w r1, sl
strh.w r1, [r0, #224]
ldrh.w sl, [r0, #352]
add.w r3, sl
strh.w r3, [r0, #352]
ldrh.w sl, [r0, #480]
add.w r8, sl
strh.w r8, [r0, #480]
ldrh.w sl, [r0, #608]
add.w r6, sl
strh.w r6, [r0, #608]
ldrh.w sl, [r0, #736]
add.w r9, sl
strh.w r9, [r0, #736]
ldrh.w sl, [r0, #864]
add.w r5, sl
strh.w r5, [r0, #864]
strh.w r7, [r0, #992]
ldrh.w r1, [sp, #226]
ldrh.w r2, [sp, #482]
ldrh.w r3, [sp, #738]
ldrh.w r4, [sp, #994]
ldrh.w r5, [fp, #226]
ldrh.w r6, [fp, #482]
ldrh.w r7, [fp, #738]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #226]
add.w r1, sl
strh.w r1, [r0, #226]
ldrh.w sl, [r0, #354]
add.w r3, sl
strh.w r3, [r0, #354]
ldrh.w sl, [r0, #482]
add.w r8, sl
strh.w r8, [r0, #482]
ldrh.w sl, [r0, #610]
add.w r6, sl
strh.w r6, [r0, #610]
ldrh.w sl, [r0, #738]
add.w r9, sl
strh.w r9, [r0, #738]
ldrh.w sl, [r0, #866]
add.w r5, sl
strh.w r5, [r0, #866]
strh.w r7, [r0, #994]
ldrh.w r1, [sp, #228]
ldrh.w r2, [sp, #484]
ldrh.w r3, [sp, #740]
ldrh.w r4, [sp, #996]
ldrh.w r5, [fp, #228]
ldrh.w r6, [fp, #484]
ldrh.w r7, [fp, #740]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #228]
add.w r1, sl
strh.w r1, [r0, #228]
ldrh.w sl, [r0, #356]
add.w r3, sl
strh.w r3, [r0, #356]
ldrh.w sl, [r0, #484]
add.w r8, sl
strh.w r8, [r0, #484]
ldrh.w sl, [r0, #612]
add.w r6, sl
strh.w r6, [r0, #612]
ldrh.w sl, [r0, #740]
add.w r9, sl
strh.w r9, [r0, #740]
ldrh.w sl, [r0, #868]
add.w r5, sl
strh.w r5, [r0, #868]
strh.w r7, [r0, #996]
ldrh.w r1, [sp, #230]
ldrh.w r2, [sp, #486]
ldrh.w r3, [sp, #742]
ldrh.w r4, [sp, #998]
ldrh.w r5, [fp, #230]
ldrh.w r6, [fp, #486]
ldrh.w r7, [fp, #742]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #230]
add.w r1, sl
strh.w r1, [r0, #230]
ldrh.w sl, [r0, #358]
add.w r3, sl
strh.w r3, [r0, #358]
ldrh.w sl, [r0, #486]
add.w r8, sl
strh.w r8, [r0, #486]
ldrh.w sl, [r0, #614]
add.w r6, sl
strh.w r6, [r0, #614]
ldrh.w sl, [r0, #742]
add.w r9, sl
strh.w r9, [r0, #742]
ldrh.w sl, [r0, #870]
add.w r5, sl
strh.w r5, [r0, #870]
strh.w r7, [r0, #998]
ldrh.w r1, [sp, #232]
ldrh.w r2, [sp, #488]
ldrh.w r3, [sp, #744]
ldrh.w r4, [sp, #1000]
ldrh.w r5, [fp, #232]
ldrh.w r6, [fp, #488]
ldrh.w r7, [fp, #744]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #232]
add.w r1, sl
strh.w r1, [r0, #232]
ldrh.w sl, [r0, #360]
add.w r3, sl
strh.w r3, [r0, #360]
ldrh.w sl, [r0, #488]
add.w r8, sl
strh.w r8, [r0, #488]
ldrh.w sl, [r0, #616]
add.w r6, sl
strh.w r6, [r0, #616]
ldrh.w sl, [r0, #744]
add.w r9, sl
strh.w r9, [r0, #744]
ldrh.w sl, [r0, #872]
add.w r5, sl
strh.w r5, [r0, #872]
strh.w r7, [r0, #1000]
ldrh.w r1, [sp, #234]
ldrh.w r2, [sp, #490]
ldrh.w r3, [sp, #746]
ldrh.w r4, [sp, #1002]
ldrh.w r5, [fp, #234]
ldrh.w r6, [fp, #490]
ldrh.w r7, [fp, #746]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #234]
add.w r1, sl
strh.w r1, [r0, #234]
ldrh.w sl, [r0, #362]
add.w r3, sl
strh.w r3, [r0, #362]
ldrh.w sl, [r0, #490]
add.w r8, sl
strh.w r8, [r0, #490]
ldrh.w sl, [r0, #618]
add.w r6, sl
strh.w r6, [r0, #618]
ldrh.w sl, [r0, #746]
add.w r9, sl
strh.w r9, [r0, #746]
ldrh.w sl, [r0, #874]
add.w r5, sl
strh.w r5, [r0, #874]
strh.w r7, [r0, #1002]
ldrh.w r1, [sp, #236]
ldrh.w r2, [sp, #492]
ldrh.w r3, [sp, #748]
ldrh.w r4, [sp, #1004]
ldrh.w r5, [fp, #236]
ldrh.w r6, [fp, #492]
ldrh.w r7, [fp, #748]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #236]
add.w r1, sl
strh.w r1, [r0, #236]
ldrh.w sl, [r0, #364]
add.w r3, sl
strh.w r3, [r0, #364]
ldrh.w sl, [r0, #492]
add.w r8, sl
strh.w r8, [r0, #492]
ldrh.w sl, [r0, #620]
add.w r6, sl
strh.w r6, [r0, #620]
ldrh.w sl, [r0, #748]
add.w r9, sl
strh.w r9, [r0, #748]
ldrh.w sl, [r0, #876]
add.w r5, sl
strh.w r5, [r0, #876]
strh.w r7, [r0, #1004]
ldrh.w r1, [sp, #238]
ldrh.w r2, [sp, #494]
ldrh.w r3, [sp, #750]
ldrh.w r4, [sp, #1006]
ldrh.w r5, [fp, #238]
ldrh.w r6, [fp, #494]
ldrh.w r7, [fp, #750]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #238]
add.w r1, sl
strh.w r1, [r0, #238]
ldrh.w sl, [r0, #366]
add.w r3, sl
strh.w r3, [r0, #366]
ldrh.w sl, [r0, #494]
add.w r8, sl
strh.w r8, [r0, #494]
ldrh.w sl, [r0, #622]
add.w r6, sl
strh.w r6, [r0, #622]
ldrh.w sl, [r0, #750]
add.w r9, sl
strh.w r9, [r0, #750]
ldrh.w sl, [r0, #878]
add.w r5, sl
strh.w r5, [r0, #878]
strh.w r7, [r0, #1006]
ldrh.w r1, [sp, #240]
ldrh.w r2, [sp, #496]
ldrh.w r3, [sp, #752]
ldrh.w r4, [sp, #1008]
ldrh.w r5, [fp, #240]
ldrh.w r6, [fp, #496]
ldrh.w r7, [fp, #752]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #240]
add.w r1, sl
strh.w r1, [r0, #240]
ldrh.w sl, [r0, #368]
add.w r3, sl
strh.w r3, [r0, #368]
ldrh.w sl, [r0, #496]
add.w r8, sl
strh.w r8, [r0, #496]
ldrh.w sl, [r0, #624]
add.w r6, sl
strh.w r6, [r0, #624]
ldrh.w sl, [r0, #752]
add.w r9, sl
strh.w r9, [r0, #752]
ldrh.w sl, [r0, #880]
add.w r5, sl
strh.w r5, [r0, #880]
strh.w r7, [r0, #1008]
ldrh.w r1, [sp, #242]
ldrh.w r2, [sp, #498]
ldrh.w r3, [sp, #754]
ldrh.w r4, [sp, #1010]
ldrh.w r5, [fp, #242]
ldrh.w r6, [fp, #498]
ldrh.w r7, [fp, #754]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #242]
add.w r1, sl
strh.w r1, [r0, #242]
ldrh.w sl, [r0, #370]
add.w r3, sl
strh.w r3, [r0, #370]
ldrh.w sl, [r0, #498]
add.w r8, sl
strh.w r8, [r0, #498]
ldrh.w sl, [r0, #626]
add.w r6, sl
strh.w r6, [r0, #626]
ldrh.w sl, [r0, #754]
add.w r9, sl
strh.w r9, [r0, #754]
ldrh.w sl, [r0, #882]
add.w r5, sl
strh.w r5, [r0, #882]
strh.w r7, [r0, #1010]
ldrh.w r1, [sp, #244]
ldrh.w r2, [sp, #500]
ldrh.w r3, [sp, #756]
ldrh.w r4, [sp, #1012]
ldrh.w r5, [fp, #244]
ldrh.w r6, [fp, #500]
ldrh.w r7, [fp, #756]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #244]
add.w r1, sl
strh.w r1, [r0, #244]
ldrh.w sl, [r0, #372]
add.w r3, sl
strh.w r3, [r0, #372]
ldrh.w sl, [r0, #500]
add.w r8, sl
strh.w r8, [r0, #500]
ldrh.w sl, [r0, #628]
add.w r6, sl
strh.w r6, [r0, #628]
ldrh.w sl, [r0, #756]
add.w r9, sl
strh.w r9, [r0, #756]
ldrh.w sl, [r0, #884]
add.w r5, sl
strh.w r5, [r0, #884]
strh.w r7, [r0, #1012]
ldrh.w r1, [sp, #246]
ldrh.w r2, [sp, #502]
ldrh.w r3, [sp, #758]
ldrh.w r4, [sp, #1014]
ldrh.w r5, [fp, #246]
ldrh.w r6, [fp, #502]
ldrh.w r7, [fp, #758]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #246]
add.w r1, sl
strh.w r1, [r0, #246]
ldrh.w sl, [r0, #374]
add.w r3, sl
strh.w r3, [r0, #374]
ldrh.w sl, [r0, #502]
add.w r8, sl
strh.w r8, [r0, #502]
ldrh.w sl, [r0, #630]
add.w r6, sl
strh.w r6, [r0, #630]
ldrh.w sl, [r0, #758]
add.w r9, sl
strh.w r9, [r0, #758]
ldrh.w sl, [r0, #886]
add.w r5, sl
strh.w r5, [r0, #886]
strh.w r7, [r0, #1014]
ldrh.w r1, [sp, #248]
ldrh.w r2, [sp, #504]
ldrh.w r3, [sp, #760]
ldrh.w r4, [sp, #1016]
ldrh.w r5, [fp, #248]
ldrh.w r6, [fp, #504]
ldrh.w r7, [fp, #760]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #248]
add.w r1, sl
strh.w r1, [r0, #248]
ldrh.w sl, [r0, #376]
add.w r3, sl
strh.w r3, [r0, #376]
ldrh.w sl, [r0, #504]
add.w r8, sl
strh.w r8, [r0, #504]
ldrh.w sl, [r0, #632]
add.w r6, sl
strh.w r6, [r0, #632]
ldrh.w sl, [r0, #760]
add.w r9, sl
strh.w r9, [r0, #760]
ldrh.w sl, [r0, #888]
add.w r5, sl
strh.w r5, [r0, #888]
strh.w r7, [r0, #1016]
ldrh.w r1, [sp, #250]
ldrh.w r2, [sp, #506]
ldrh.w r3, [sp, #762]
ldrh.w r4, [sp, #1018]
ldrh.w r5, [fp, #250]
ldrh.w r6, [fp, #506]
ldrh.w r7, [fp, #762]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #250]
add.w r1, sl
strh.w r1, [r0, #250]
ldrh.w sl, [r0, #378]
add.w r3, sl
strh.w r3, [r0, #378]
ldrh.w sl, [r0, #506]
add.w r8, sl
strh.w r8, [r0, #506]
ldrh.w sl, [r0, #634]
add.w r6, sl
strh.w r6, [r0, #634]
ldrh.w sl, [r0, #762]
add.w r9, sl
strh.w r9, [r0, #762]
ldrh.w sl, [r0, #890]
add.w r5, sl
strh.w r5, [r0, #890]
strh.w r7, [r0, #1018]
ldrh.w r1, [sp, #252]
ldrh.w r2, [sp, #508]
ldrh.w r3, [sp, #764]
ldrh.w r4, [sp, #1020]
ldrh.w r5, [fp, #252]
ldrh.w r6, [fp, #508]
ldrh.w r7, [fp, #764]
add.w r8, r2, r3
mov.w r8, r8, lsr #1
sub.w r8, r8, r1
sub.w r8, r8, r7
add.w r9, r4, r5
sub.w r9, r9, r1, lsl #1
sub.w r9, r9, r7, lsl #7
mov.w r9, r9, lsr #3
sub.w r9, r9, r8
mul.w r9, r9, lr
sub.w r8, r8, r9
sub.w r2, r2, r3
mov.w r2, r2, lsr #1
sub.w r3, r4, r5
mov.w r3, r3, lsr #2
sub.w r3, r3, r2
mul.w r3, r3, lr
add.w r4, r7, r7, lsl #3
add.w r4, r9
add.w r4, r4, r4, lsl #3
add.w r4, r8
add.w r4, r4, r4, lsl #3
add.w r4, r1
sub.w r4, r6, r4
mul.w r4, r4, lr
sub.w r4, r4, r2
mov.w r4, r4, lsr #3
sub.w r4, r4, r3
mul.w r5, r4, ip
sub.w r6, r3, r4
sub.w r3, r2, r6
sub.w r3, r3, r5
ldrh.w sl, [r0, #252]
add.w r1, sl
strh.w r1, [r0, #252]
ldrh.w sl, [r0, #380]
add.w r3, sl
strh.w r3, [r0, #380]
ldrh.w sl, [r0, #508]
add.w r8, sl
strh.w r8, [r0, #508]
ldrh.w sl, [r0, #636]
add.w r6, sl
strh.w r6, [r0, #636]
ldrh.w sl, [r0, #764]
add.w r9, sl
strh.w r9, [r0, #764]
ldrh.w sl, [r0, #892]
add.w r5, sl
strh.w r5, [r0, #892]
strh.w r7, [r0, #1020]
add.w sp, sp, #1792
ldmia.w sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
bx lr
