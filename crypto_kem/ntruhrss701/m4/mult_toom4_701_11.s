# This assembly file is automatically generated. Do not modify it directly.
# The code generator is available at https://github.com/mupq/polymul-z2mx-m4
# - Matthias Kannwischer, Joost Rijneveld, and Peter Schwabe, 2018, Public Domain

.syntax unified
.cpu cortex-m4
.global schoolbook_11x11
.type schoolbook_11x11, %function
.align 2
schoolbook_11x11:
push {lr}
ldr r3, [r1, #0]
ldr r4, [r1, #4]
ldr r5, [r1, #8]
ldr r6, [r1, #12]
ldr r7, [r1, #16]
ldrh.w r8, [r1, #20]
push {r1}
ldr r1, [r2, #0]
ldr.w r9, [r2, #4]
ldr.w sl, [r2, #8]
ldr.w fp, [r2, #12]
ldr.w ip, [r2, #16]
ldrh.w lr, [r2, #20]
push.w {r2}
smuadx r2, r3, r1
strh.w r2, [r0, #2]
smuadx r2, r3, r9
smladx r2, r4, r1, r2
strh.w r2, [r0, #6]
smuadx r2, r3, sl
smladx r2, r4, r9, r2
smladx r2, r5, r1, r2
strh.w r2, [r0, #10]
smuadx r2, r3, fp
smladx r2, r4, sl, r2
smladx r2, r5, r9, r2
smladx r2, r6, r1, r2
strh.w r2, [r0, #14]
smuadx r2, r3, ip
smladx r2, r4, fp, r2
smladx r2, r5, sl, r2
smladx r2, r6, r9, r2
smladx r2, r7, r1, r2
strh.w r2, [r0, #18]
smultb r2, r3, lr
smladx r2, r4, ip, r2
smladx r2, r5, fp, r2
smladx r2, r6, sl, r2
smladx r2, r7, r9, r2
smlabt r2, r8, r1, r2
strh.w r2, [r0, #22]
smultb r2, r4, lr
smladx r2, r5, ip, r2
smladx r2, r6, fp, r2
smladx r2, r7, sl, r2
smlabt r2, r8, r9, r2
strh.w r2, [r0, #26]
smultb r2, r5, lr
smladx r2, r6, ip, r2
smladx r2, r7, fp, r2
smlabt r2, r8, sl, r2
strh.w r2, [r0, #30]
smultb r2, r6, lr
smladx r2, r7, ip, r2
smlabt r2, r8, fp, r2
strh.w r2, [r0, #34]
smultb r2, r7, lr
smlabt r2, r8, ip, r2
strh.w r2, [r0, #38]
pkhbt r2, r9, r1
pkhbt r9, sl, r9
pkhbt sl, fp, sl
pkhbt fp, ip, fp
pkhbt ip, lr, ip
mul.w lr, r3, r1
strh.w lr, [r0]
smuad lr, r3, r2
mla lr, r4, r1, lr
strh.w lr, [r0, #4]
smuad lr, r3, r9
smlad lr, r4, r2, lr
mla lr, r5, r1, lr
strh.w lr, [r0, #8]
smuad lr, r3, sl
smlad lr, r4, r9, lr
smlad lr, r5, r2, lr
mla lr, r6, r1, lr
strh.w lr, [r0, #12]
smuad lr, r3, fp
smlad lr, r4, sl, lr
smlad lr, r5, r9, lr
smlad lr, r6, r2, lr
mla lr, r7, r1, lr
strh.w lr, [r0, #16]
smuad lr, r3, ip
smlad lr, r4, fp, lr
smlad lr, r5, sl, lr
smlad lr, r6, r9, lr
smlad lr, r7, r2, lr
mla lr, r8, r1, lr
strh.w lr, [r0, #20]
smuad lr, r4, ip
smlad lr, r5, fp, lr
smlad lr, r6, sl, lr
smlad lr, r7, r9, lr
mla lr, r8, r2, lr
strh.w lr, [r0, #24]
smuad lr, r5, ip
smlad lr, r6, fp, lr
smlad lr, r7, sl, lr
mla lr, r8, r9, lr
strh.w lr, [r0, #28]
smuad lr, r6, ip
smlad lr, r7, fp, lr
mla lr, r8, sl, lr
strh.w lr, [r0, #32]
smuad lr, r7, ip
mla lr, r8, fp, lr
strh.w lr, [r0, #36]
smuad lr, r8, ip
strh.w lr, [r0, #40]
pop {r2}
pop {r1}
ldr.w lr, [sp], #4
bx lr
.global karatsuba_176x176
.type karatsuba_176x176, %function
.align 2
karatsuba_176x176:
push.w {lr}
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #44
add.w r2, r2, #44
add.w r0, r0, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop.w {r1}
sub.w r1, r1, #44
sub.w r2, r2, #44
sub sp, #176
ldr r3, [r1, #0]
ldr r4, [r1, #44]
ldr r5, [r1, #4]
ldr r6, [r1, #48]
ldr r7, [r1, #8]
ldr.w r8, [r1, #52]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #56]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #60]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #64]
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
ldr r4, [r1, #68]
ldr r5, [r1, #28]
ldr r6, [r1, #72]
ldr r7, [r1, #32]
ldr.w r8, [r1, #76]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #80]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #44]
ldr r5, [r2, #4]
ldr r6, [r2, #48]
ldr r7, [r2, #8]
ldr.w r8, [r2, #52]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #56]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #60]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #64]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #44]
str r5, [sp, #48]
str.w r7, [sp, #52]
str.w r9, [sp, #56]
str.w fp, [sp, #60]
str r0, [sp, #64]
ldr r3, [r2, #24]
ldr r4, [r2, #68]
ldr r5, [r2, #28]
ldr r6, [r2, #72]
ldr r7, [r2, #32]
ldr.w r8, [r2, #76]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #80]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #68]
str r5, [sp, #72]
str.w r7, [sp, #76]
str.w r9, [sp, #80]
str.w fp, [sp, #84]
add r2, sp, #44
add r0, sp, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #176]
ldr r5, [r3, #0]
ldr r6, [r3, #44]
ldr r7, [r0, #0]
ldr.w r8, [r0, #44]
ldr.w r9, [r0, #88]
ldr.w sl, [r0, #132]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #44]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #88]
ldr r5, [r3, #4]
ldr r6, [r3, #48]
ldr r7, [r0, #4]
ldr.w r8, [r0, #48]
ldr.w r9, [r0, #92]
ldr.w sl, [r0, #136]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #48]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #92]
ldr r5, [r3, #8]
ldr r6, [r3, #52]
ldr r7, [r0, #8]
ldr.w r8, [r0, #52]
ldr.w r9, [r0, #96]
ldr.w sl, [r0, #140]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #52]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #96]
ldr r5, [r3, #12]
ldr r6, [r3, #56]
ldr r7, [r0, #12]
ldr.w r8, [r0, #56]
ldr.w r9, [r0, #100]
ldr.w sl, [r0, #144]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #56]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #100]
ldr r5, [r3, #16]
ldr r6, [r3, #60]
ldr r7, [r0, #16]
ldr.w r8, [r0, #60]
ldr.w r9, [r0, #104]
ldr.w sl, [r0, #148]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #60]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #104]
ldr r5, [r3, #20]
ldr r6, [r3, #64]
ldr r7, [r0, #20]
ldr.w r8, [r0, #64]
ldr.w r9, [r0, #108]
ldr.w sl, [r0, #152]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #64]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #108]
ldr r5, [r3, #24]
ldr r6, [r3, #68]
ldr r7, [r0, #24]
ldr.w r8, [r0, #68]
ldr.w r9, [r0, #112]
ldr.w sl, [r0, #156]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #68]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #112]
ldr r5, [r3, #28]
ldr r6, [r3, #72]
ldr r7, [r0, #28]
ldr.w r8, [r0, #72]
ldr.w r9, [r0, #116]
ldr.w sl, [r0, #160]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #72]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #116]
ldr r5, [r3, #32]
ldr r6, [r3, #76]
ldr r7, [r0, #32]
ldr.w r8, [r0, #76]
ldr.w r9, [r0, #120]
ldr.w sl, [r0, #164]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #76]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #120]
ldr r5, [r3, #36]
ldr r6, [r3, #80]
ldr r7, [r0, #36]
ldr.w r8, [r0, #80]
ldr.w r9, [r0, #124]
ldr.w sl, [r0, #168]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #80]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #124]
ldrh r5, [r3, #40]
ldrh.w r6, [r3, #84]
ldrh.w r7, [r0, #40]
ldrh.w r8, [r0, #84]
ldrh.w r9, [r0, #128]
ldrh.w sl, [r0, #172]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #84]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #128]
ldrh r5, [r3, #42]
ldrh r7, [r0, #42]
ldrh.w r9, [r0, #130]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #86]
add sp, #180
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #88
add.w r2, r2, #88
add.w r0, r0, #176
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #44
add.w r2, r2, #44
add.w r0, r0, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop.w {r1}
sub.w r1, r1, #44
sub.w r2, r2, #44
sub sp, #176
ldr r3, [r1, #0]
ldr r4, [r1, #44]
ldr r5, [r1, #4]
ldr r6, [r1, #48]
ldr r7, [r1, #8]
ldr.w r8, [r1, #52]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #56]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #60]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #64]
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
ldr r4, [r1, #68]
ldr r5, [r1, #28]
ldr r6, [r1, #72]
ldr r7, [r1, #32]
ldr.w r8, [r1, #76]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #80]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #44]
ldr r5, [r2, #4]
ldr r6, [r2, #48]
ldr r7, [r2, #8]
ldr.w r8, [r2, #52]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #56]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #60]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #64]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #44]
str r5, [sp, #48]
str.w r7, [sp, #52]
str.w r9, [sp, #56]
str.w fp, [sp, #60]
str r0, [sp, #64]
ldr r3, [r2, #24]
ldr r4, [r2, #68]
ldr r5, [r2, #28]
ldr r6, [r2, #72]
ldr r7, [r2, #32]
ldr.w r8, [r2, #76]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #80]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #68]
str r5, [sp, #72]
str.w r7, [sp, #76]
str.w r9, [sp, #80]
str.w fp, [sp, #84]
add r2, sp, #44
add r0, sp, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #176]
ldr r5, [r3, #0]
ldr r6, [r3, #44]
ldr r7, [r0, #0]
ldr.w r8, [r0, #44]
ldr.w r9, [r0, #88]
ldr.w sl, [r0, #132]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #44]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #88]
ldr r5, [r3, #4]
ldr r6, [r3, #48]
ldr r7, [r0, #4]
ldr.w r8, [r0, #48]
ldr.w r9, [r0, #92]
ldr.w sl, [r0, #136]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #48]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #92]
ldr r5, [r3, #8]
ldr r6, [r3, #52]
ldr r7, [r0, #8]
ldr.w r8, [r0, #52]
ldr.w r9, [r0, #96]
ldr.w sl, [r0, #140]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #52]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #96]
ldr r5, [r3, #12]
ldr r6, [r3, #56]
ldr r7, [r0, #12]
ldr.w r8, [r0, #56]
ldr.w r9, [r0, #100]
ldr.w sl, [r0, #144]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #56]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #100]
ldr r5, [r3, #16]
ldr r6, [r3, #60]
ldr r7, [r0, #16]
ldr.w r8, [r0, #60]
ldr.w r9, [r0, #104]
ldr.w sl, [r0, #148]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #60]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #104]
ldr r5, [r3, #20]
ldr r6, [r3, #64]
ldr r7, [r0, #20]
ldr.w r8, [r0, #64]
ldr.w r9, [r0, #108]
ldr.w sl, [r0, #152]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #64]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #108]
ldr r5, [r3, #24]
ldr r6, [r3, #68]
ldr r7, [r0, #24]
ldr.w r8, [r0, #68]
ldr.w r9, [r0, #112]
ldr.w sl, [r0, #156]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #68]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #112]
ldr r5, [r3, #28]
ldr r6, [r3, #72]
ldr r7, [r0, #28]
ldr.w r8, [r0, #72]
ldr.w r9, [r0, #116]
ldr.w sl, [r0, #160]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #72]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #116]
ldr r5, [r3, #32]
ldr r6, [r3, #76]
ldr r7, [r0, #32]
ldr.w r8, [r0, #76]
ldr.w r9, [r0, #120]
ldr.w sl, [r0, #164]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #76]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #120]
ldr r5, [r3, #36]
ldr r6, [r3, #80]
ldr r7, [r0, #36]
ldr.w r8, [r0, #80]
ldr.w r9, [r0, #124]
ldr.w sl, [r0, #168]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #80]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #124]
ldrh r5, [r3, #40]
ldrh.w r6, [r3, #84]
ldrh.w r7, [r0, #40]
ldrh.w r8, [r0, #84]
ldrh.w r9, [r0, #128]
ldrh.w sl, [r0, #172]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #84]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #128]
ldrh r5, [r3, #42]
ldrh r7, [r0, #42]
ldrh.w r9, [r0, #130]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #86]
add sp, #180
pop {r2}
pop.w {r1}
sub.w r1, r1, #88
sub.w r2, r2, #88
sub sp, #352
ldr r3, [r1, #0]
ldr r4, [r1, #88]
ldr r5, [r1, #4]
ldr r6, [r1, #92]
ldr r7, [r1, #8]
ldr.w r8, [r1, #96]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #100]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #104]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #108]
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
ldr r4, [r1, #112]
ldr r5, [r1, #28]
ldr r6, [r1, #116]
ldr r7, [r1, #32]
ldr.w r8, [r1, #120]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #124]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #128]
ldr.w r0, [r1, #44]
ldr.w lr, [r1, #132]
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
ldr.w r4, [r1, #136]
ldr.w r5, [r1, #52]
ldr.w r6, [r1, #140]
ldr.w r7, [r1, #56]
ldr.w r8, [r1, #144]
ldr.w r9, [r1, #60]
ldr.w sl, [r1, #148]
ldr.w fp, [r1, #64]
ldr.w ip, [r1, #152]
ldr.w r0, [r1, #68]
ldr.w lr, [r1, #156]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #48]
str r5, [sp, #52]
str.w r7, [sp, #56]
str.w r9, [sp, #60]
str.w fp, [sp, #64]
str r0, [sp, #68]
ldr r3, [r1, #72]
ldr.w r4, [r1, #160]
ldr.w r5, [r1, #76]
ldr.w r6, [r1, #164]
ldr.w r7, [r1, #80]
ldr.w r8, [r1, #168]
ldr.w r9, [r1, #84]
ldr.w sl, [r1, #172]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
str r3, [sp, #72]
str r5, [sp, #76]
str.w r7, [sp, #80]
str.w r9, [sp, #84]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #88]
ldr r5, [r2, #4]
ldr r6, [r2, #92]
ldr r7, [r2, #8]
ldr.w r8, [r2, #96]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #100]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #104]
ldr.w r0, [r2, #20]
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
ldr r3, [r2, #24]
ldr r4, [r2, #112]
ldr r5, [r2, #28]
ldr r6, [r2, #116]
ldr r7, [r2, #32]
ldr.w r8, [r2, #120]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #124]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #128]
ldr.w r0, [r2, #44]
ldr.w lr, [r2, #132]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #112]
str r5, [sp, #116]
str.w r7, [sp, #120]
str.w r9, [sp, #124]
str.w fp, [sp, #128]
str r0, [sp, #132]
ldr r3, [r2, #48]
ldr.w r4, [r2, #136]
ldr.w r5, [r2, #52]
ldr.w r6, [r2, #140]
ldr.w r7, [r2, #56]
ldr.w r8, [r2, #144]
ldr.w r9, [r2, #60]
ldr.w sl, [r2, #148]
ldr.w fp, [r2, #64]
ldr.w ip, [r2, #152]
ldr.w r0, [r2, #68]
ldr.w lr, [r2, #156]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #136]
str r5, [sp, #140]
str.w r7, [sp, #144]
str.w r9, [sp, #148]
str.w fp, [sp, #152]
str r0, [sp, #156]
ldr r3, [r2, #72]
ldr.w r4, [r2, #160]
ldr.w r5, [r2, #76]
ldr.w r6, [r2, #164]
ldr.w r7, [r2, #80]
ldr.w r8, [r2, #168]
ldr.w r9, [r2, #84]
ldr.w sl, [r2, #172]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
str r3, [sp, #160]
str r5, [sp, #164]
str.w r7, [sp, #168]
str.w r9, [sp, #172]
add r2, sp, #88
add r0, sp, #176
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #44
add.w r2, r2, #44
add.w r0, r0, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop.w {r1}
sub.w r1, r1, #44
sub.w r2, r2, #44
sub sp, #176
ldr r3, [r1, #0]
ldr r4, [r1, #44]
ldr r5, [r1, #4]
ldr r6, [r1, #48]
ldr r7, [r1, #8]
ldr.w r8, [r1, #52]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #56]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #60]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #64]
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
ldr r4, [r1, #68]
ldr r5, [r1, #28]
ldr r6, [r1, #72]
ldr r7, [r1, #32]
ldr.w r8, [r1, #76]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #80]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #44]
ldr r5, [r2, #4]
ldr r6, [r2, #48]
ldr r7, [r2, #8]
ldr.w r8, [r2, #52]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #56]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #60]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #64]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #44]
str r5, [sp, #48]
str.w r7, [sp, #52]
str.w r9, [sp, #56]
str.w fp, [sp, #60]
str r0, [sp, #64]
ldr r3, [r2, #24]
ldr r4, [r2, #68]
ldr r5, [r2, #28]
ldr r6, [r2, #72]
ldr r7, [r2, #32]
ldr.w r8, [r2, #76]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #80]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #68]
str r5, [sp, #72]
str.w r7, [sp, #76]
str.w r9, [sp, #80]
str.w fp, [sp, #84]
add r2, sp, #44
add r0, sp, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #176]
ldr r5, [r3, #0]
ldr r6, [r3, #44]
ldr r7, [r0, #0]
ldr.w r8, [r0, #44]
ldr.w r9, [r0, #88]
ldr.w sl, [r0, #132]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #44]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #88]
ldr r5, [r3, #4]
ldr r6, [r3, #48]
ldr r7, [r0, #4]
ldr.w r8, [r0, #48]
ldr.w r9, [r0, #92]
ldr.w sl, [r0, #136]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #48]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #92]
ldr r5, [r3, #8]
ldr r6, [r3, #52]
ldr r7, [r0, #8]
ldr.w r8, [r0, #52]
ldr.w r9, [r0, #96]
ldr.w sl, [r0, #140]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #52]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #96]
ldr r5, [r3, #12]
ldr r6, [r3, #56]
ldr r7, [r0, #12]
ldr.w r8, [r0, #56]
ldr.w r9, [r0, #100]
ldr.w sl, [r0, #144]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #56]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #100]
ldr r5, [r3, #16]
ldr r6, [r3, #60]
ldr r7, [r0, #16]
ldr.w r8, [r0, #60]
ldr.w r9, [r0, #104]
ldr.w sl, [r0, #148]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #60]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #104]
ldr r5, [r3, #20]
ldr r6, [r3, #64]
ldr r7, [r0, #20]
ldr.w r8, [r0, #64]
ldr.w r9, [r0, #108]
ldr.w sl, [r0, #152]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #64]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #108]
ldr r5, [r3, #24]
ldr r6, [r3, #68]
ldr r7, [r0, #24]
ldr.w r8, [r0, #68]
ldr.w r9, [r0, #112]
ldr.w sl, [r0, #156]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #68]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #112]
ldr r5, [r3, #28]
ldr r6, [r3, #72]
ldr r7, [r0, #28]
ldr.w r8, [r0, #72]
ldr.w r9, [r0, #116]
ldr.w sl, [r0, #160]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #72]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #116]
ldr r5, [r3, #32]
ldr r6, [r3, #76]
ldr r7, [r0, #32]
ldr.w r8, [r0, #76]
ldr.w r9, [r0, #120]
ldr.w sl, [r0, #164]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #76]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #120]
ldr r5, [r3, #36]
ldr r6, [r3, #80]
ldr r7, [r0, #36]
ldr.w r8, [r0, #80]
ldr.w r9, [r0, #124]
ldr.w sl, [r0, #168]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #80]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #124]
ldrh r5, [r3, #40]
ldrh.w r6, [r3, #84]
ldrh.w r7, [r0, #40]
ldrh.w r8, [r0, #84]
ldrh.w r9, [r0, #128]
ldrh.w sl, [r0, #172]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #84]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #128]
ldrh r5, [r3, #42]
ldrh r7, [r0, #42]
ldrh.w r9, [r0, #130]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #86]
add sp, #180
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #352]
ldr r5, [r3, #0]
ldr r6, [r3, #88]
ldr r7, [r0, #0]
ldr.w r8, [r0, #88]
ldr.w r9, [r0, #176]
ldr.w sl, [r0, #264]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #88]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #176]
ldr r5, [r3, #4]
ldr r6, [r3, #92]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #92]
ldr.w r9, [r0, #180]
ldr.w sl, [r0, #268]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #92]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #180]
ldr r5, [r3, #8]
ldr r6, [r3, #96]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #96]
ldr.w r9, [r0, #184]
ldr.w sl, [r0, #272]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #96]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #184]
ldr r5, [r3, #12]
ldr r6, [r3, #100]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #100]
ldr.w r9, [r0, #188]
ldr.w sl, [r0, #276]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #100]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #188]
ldr r5, [r3, #16]
ldr r6, [r3, #104]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #104]
ldr.w r9, [r0, #192]
ldr.w sl, [r0, #280]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #104]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #192]
ldr r5, [r3, #20]
ldr r6, [r3, #108]
ldr.w r7, [r0, #20]
ldr.w r8, [r0, #108]
ldr.w r9, [r0, #196]
ldr.w sl, [r0, #284]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #108]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #196]
ldr r5, [r3, #24]
ldr r6, [r3, #112]
ldr.w r7, [r0, #24]
ldr.w r8, [r0, #112]
ldr.w r9, [r0, #200]
ldr.w sl, [r0, #288]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #112]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #200]
ldr r5, [r3, #28]
ldr r6, [r3, #116]
ldr.w r7, [r0, #28]
ldr.w r8, [r0, #116]
ldr.w r9, [r0, #204]
ldr.w sl, [r0, #292]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #116]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #204]
ldr r5, [r3, #32]
ldr r6, [r3, #120]
ldr.w r7, [r0, #32]
ldr.w r8, [r0, #120]
ldr.w r9, [r0, #208]
ldr.w sl, [r0, #296]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #120]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #208]
ldr r5, [r3, #36]
ldr r6, [r3, #124]
ldr.w r7, [r0, #36]
ldr.w r8, [r0, #124]
ldr.w r9, [r0, #212]
ldr.w sl, [r0, #300]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #124]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #212]
ldr.w r5, [r3, #40]
ldr.w r6, [r3, #128]
ldr.w r7, [r0, #40]
ldr.w r8, [r0, #128]
ldr.w r9, [r0, #216]
ldr.w sl, [r0, #304]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #128]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #216]
ldr.w r5, [r3, #44]
ldr.w r6, [r3, #132]
ldr.w r7, [r0, #44]
ldr.w r8, [r0, #132]
ldr.w r9, [r0, #220]
ldr.w sl, [r0, #308]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #132]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #220]
ldr.w r5, [r3, #48]
ldr.w r6, [r3, #136]
ldr.w r7, [r0, #48]
ldr.w r8, [r0, #136]
ldr.w r9, [r0, #224]
ldr.w sl, [r0, #312]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #136]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #224]
ldr.w r5, [r3, #52]
ldr.w r6, [r3, #140]
ldr.w r7, [r0, #52]
ldr.w r8, [r0, #140]
ldr.w r9, [r0, #228]
ldr.w sl, [r0, #316]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #140]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #228]
ldr.w r5, [r3, #56]
ldr.w r6, [r3, #144]
ldr.w r7, [r0, #56]
ldr.w r8, [r0, #144]
ldr.w r9, [r0, #232]
ldr.w sl, [r0, #320]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #144]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #232]
ldr.w r5, [r3, #60]
ldr.w r6, [r3, #148]
ldr.w r7, [r0, #60]
ldr.w r8, [r0, #148]
ldr.w r9, [r0, #236]
ldr.w sl, [r0, #324]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #148]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #236]
ldr.w r5, [r3, #64]
ldr.w r6, [r3, #152]
ldr.w r7, [r0, #64]
ldr.w r8, [r0, #152]
ldr.w r9, [r0, #240]
ldr.w sl, [r0, #328]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #152]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #240]
ldr.w r5, [r3, #68]
ldr.w r6, [r3, #156]
ldr.w r7, [r0, #68]
ldr.w r8, [r0, #156]
ldr.w r9, [r0, #244]
ldr.w sl, [r0, #332]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #156]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #244]
ldr.w r5, [r3, #72]
ldr.w r6, [r3, #160]
ldr.w r7, [r0, #72]
ldr.w r8, [r0, #160]
ldr.w r9, [r0, #248]
ldr.w sl, [r0, #336]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #160]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #248]
ldr.w r5, [r3, #76]
ldr.w r6, [r3, #164]
ldr.w r7, [r0, #76]
ldr.w r8, [r0, #164]
ldr.w r9, [r0, #252]
ldr.w sl, [r0, #340]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #164]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #252]
ldr.w r5, [r3, #80]
ldr.w r6, [r3, #168]
ldr.w r7, [r0, #80]
ldr.w r8, [r0, #168]
ldr.w r9, [r0, #256]
ldr.w sl, [r0, #344]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #168]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #256]
ldrh.w r5, [r3, #84]
ldrh.w r6, [r3, #172]
ldrh.w r7, [r0, #84]
ldrh.w r8, [r0, #172]
ldrh.w r9, [r0, #260]
ldrh.w sl, [r0, #348]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #172]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #260]
ldrh.w r5, [r3, #86]
ldrh.w r7, [r0, #86]
ldrh.w r9, [r0, #262]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #174]
add sp, #356
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #176
add.w r2, r2, #176
add.w r0, r0, #352
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #44
add.w r2, r2, #44
add.w r0, r0, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop.w {r1}
sub.w r1, r1, #44
sub.w r2, r2, #44
sub sp, #176
ldr r3, [r1, #0]
ldr r4, [r1, #44]
ldr r5, [r1, #4]
ldr r6, [r1, #48]
ldr r7, [r1, #8]
ldr.w r8, [r1, #52]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #56]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #60]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #64]
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
ldr r4, [r1, #68]
ldr r5, [r1, #28]
ldr r6, [r1, #72]
ldr r7, [r1, #32]
ldr.w r8, [r1, #76]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #80]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #44]
ldr r5, [r2, #4]
ldr r6, [r2, #48]
ldr r7, [r2, #8]
ldr.w r8, [r2, #52]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #56]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #60]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #64]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #44]
str r5, [sp, #48]
str.w r7, [sp, #52]
str.w r9, [sp, #56]
str.w fp, [sp, #60]
str r0, [sp, #64]
ldr r3, [r2, #24]
ldr r4, [r2, #68]
ldr r5, [r2, #28]
ldr r6, [r2, #72]
ldr r7, [r2, #32]
ldr.w r8, [r2, #76]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #80]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #68]
str r5, [sp, #72]
str.w r7, [sp, #76]
str.w r9, [sp, #80]
str.w fp, [sp, #84]
add r2, sp, #44
add r0, sp, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #176]
ldr r5, [r3, #0]
ldr r6, [r3, #44]
ldr r7, [r0, #0]
ldr.w r8, [r0, #44]
ldr.w r9, [r0, #88]
ldr.w sl, [r0, #132]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #44]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #88]
ldr r5, [r3, #4]
ldr r6, [r3, #48]
ldr r7, [r0, #4]
ldr.w r8, [r0, #48]
ldr.w r9, [r0, #92]
ldr.w sl, [r0, #136]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #48]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #92]
ldr r5, [r3, #8]
ldr r6, [r3, #52]
ldr r7, [r0, #8]
ldr.w r8, [r0, #52]
ldr.w r9, [r0, #96]
ldr.w sl, [r0, #140]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #52]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #96]
ldr r5, [r3, #12]
ldr r6, [r3, #56]
ldr r7, [r0, #12]
ldr.w r8, [r0, #56]
ldr.w r9, [r0, #100]
ldr.w sl, [r0, #144]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #56]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #100]
ldr r5, [r3, #16]
ldr r6, [r3, #60]
ldr r7, [r0, #16]
ldr.w r8, [r0, #60]
ldr.w r9, [r0, #104]
ldr.w sl, [r0, #148]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #60]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #104]
ldr r5, [r3, #20]
ldr r6, [r3, #64]
ldr r7, [r0, #20]
ldr.w r8, [r0, #64]
ldr.w r9, [r0, #108]
ldr.w sl, [r0, #152]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #64]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #108]
ldr r5, [r3, #24]
ldr r6, [r3, #68]
ldr r7, [r0, #24]
ldr.w r8, [r0, #68]
ldr.w r9, [r0, #112]
ldr.w sl, [r0, #156]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #68]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #112]
ldr r5, [r3, #28]
ldr r6, [r3, #72]
ldr r7, [r0, #28]
ldr.w r8, [r0, #72]
ldr.w r9, [r0, #116]
ldr.w sl, [r0, #160]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #72]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #116]
ldr r5, [r3, #32]
ldr r6, [r3, #76]
ldr r7, [r0, #32]
ldr.w r8, [r0, #76]
ldr.w r9, [r0, #120]
ldr.w sl, [r0, #164]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #76]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #120]
ldr r5, [r3, #36]
ldr r6, [r3, #80]
ldr r7, [r0, #36]
ldr.w r8, [r0, #80]
ldr.w r9, [r0, #124]
ldr.w sl, [r0, #168]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #80]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #124]
ldrh r5, [r3, #40]
ldrh.w r6, [r3, #84]
ldrh.w r7, [r0, #40]
ldrh.w r8, [r0, #84]
ldrh.w r9, [r0, #128]
ldrh.w sl, [r0, #172]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #84]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #128]
ldrh r5, [r3, #42]
ldrh r7, [r0, #42]
ldrh.w r9, [r0, #130]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #86]
add sp, #180
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #88
add.w r2, r2, #88
add.w r0, r0, #176
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #44
add.w r2, r2, #44
add.w r0, r0, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop.w {r1}
sub.w r1, r1, #44
sub.w r2, r2, #44
sub sp, #176
ldr r3, [r1, #0]
ldr r4, [r1, #44]
ldr r5, [r1, #4]
ldr r6, [r1, #48]
ldr r7, [r1, #8]
ldr.w r8, [r1, #52]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #56]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #60]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #64]
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
ldr r4, [r1, #68]
ldr r5, [r1, #28]
ldr r6, [r1, #72]
ldr r7, [r1, #32]
ldr.w r8, [r1, #76]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #80]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #44]
ldr r5, [r2, #4]
ldr r6, [r2, #48]
ldr r7, [r2, #8]
ldr.w r8, [r2, #52]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #56]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #60]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #64]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #44]
str r5, [sp, #48]
str.w r7, [sp, #52]
str.w r9, [sp, #56]
str.w fp, [sp, #60]
str r0, [sp, #64]
ldr r3, [r2, #24]
ldr r4, [r2, #68]
ldr r5, [r2, #28]
ldr r6, [r2, #72]
ldr r7, [r2, #32]
ldr.w r8, [r2, #76]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #80]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #68]
str r5, [sp, #72]
str.w r7, [sp, #76]
str.w r9, [sp, #80]
str.w fp, [sp, #84]
add r2, sp, #44
add r0, sp, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #176]
ldr r5, [r3, #0]
ldr r6, [r3, #44]
ldr r7, [r0, #0]
ldr.w r8, [r0, #44]
ldr.w r9, [r0, #88]
ldr.w sl, [r0, #132]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #44]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #88]
ldr r5, [r3, #4]
ldr r6, [r3, #48]
ldr r7, [r0, #4]
ldr.w r8, [r0, #48]
ldr.w r9, [r0, #92]
ldr.w sl, [r0, #136]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #48]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #92]
ldr r5, [r3, #8]
ldr r6, [r3, #52]
ldr r7, [r0, #8]
ldr.w r8, [r0, #52]
ldr.w r9, [r0, #96]
ldr.w sl, [r0, #140]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #52]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #96]
ldr r5, [r3, #12]
ldr r6, [r3, #56]
ldr r7, [r0, #12]
ldr.w r8, [r0, #56]
ldr.w r9, [r0, #100]
ldr.w sl, [r0, #144]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #56]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #100]
ldr r5, [r3, #16]
ldr r6, [r3, #60]
ldr r7, [r0, #16]
ldr.w r8, [r0, #60]
ldr.w r9, [r0, #104]
ldr.w sl, [r0, #148]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #60]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #104]
ldr r5, [r3, #20]
ldr r6, [r3, #64]
ldr r7, [r0, #20]
ldr.w r8, [r0, #64]
ldr.w r9, [r0, #108]
ldr.w sl, [r0, #152]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #64]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #108]
ldr r5, [r3, #24]
ldr r6, [r3, #68]
ldr r7, [r0, #24]
ldr.w r8, [r0, #68]
ldr.w r9, [r0, #112]
ldr.w sl, [r0, #156]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #68]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #112]
ldr r5, [r3, #28]
ldr r6, [r3, #72]
ldr r7, [r0, #28]
ldr.w r8, [r0, #72]
ldr.w r9, [r0, #116]
ldr.w sl, [r0, #160]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #72]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #116]
ldr r5, [r3, #32]
ldr r6, [r3, #76]
ldr r7, [r0, #32]
ldr.w r8, [r0, #76]
ldr.w r9, [r0, #120]
ldr.w sl, [r0, #164]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #76]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #120]
ldr r5, [r3, #36]
ldr r6, [r3, #80]
ldr r7, [r0, #36]
ldr.w r8, [r0, #80]
ldr.w r9, [r0, #124]
ldr.w sl, [r0, #168]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #80]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #124]
ldrh r5, [r3, #40]
ldrh.w r6, [r3, #84]
ldrh.w r7, [r0, #40]
ldrh.w r8, [r0, #84]
ldrh.w r9, [r0, #128]
ldrh.w sl, [r0, #172]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #84]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #128]
ldrh r5, [r3, #42]
ldrh r7, [r0, #42]
ldrh.w r9, [r0, #130]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #86]
add sp, #180
pop {r2}
pop.w {r1}
sub.w r1, r1, #88
sub.w r2, r2, #88
sub sp, #352
ldr r3, [r1, #0]
ldr r4, [r1, #88]
ldr r5, [r1, #4]
ldr r6, [r1, #92]
ldr r7, [r1, #8]
ldr.w r8, [r1, #96]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #100]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #104]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #108]
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
ldr r4, [r1, #112]
ldr r5, [r1, #28]
ldr r6, [r1, #116]
ldr r7, [r1, #32]
ldr.w r8, [r1, #120]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #124]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #128]
ldr.w r0, [r1, #44]
ldr.w lr, [r1, #132]
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
ldr.w r4, [r1, #136]
ldr.w r5, [r1, #52]
ldr.w r6, [r1, #140]
ldr.w r7, [r1, #56]
ldr.w r8, [r1, #144]
ldr.w r9, [r1, #60]
ldr.w sl, [r1, #148]
ldr.w fp, [r1, #64]
ldr.w ip, [r1, #152]
ldr.w r0, [r1, #68]
ldr.w lr, [r1, #156]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #48]
str r5, [sp, #52]
str.w r7, [sp, #56]
str.w r9, [sp, #60]
str.w fp, [sp, #64]
str r0, [sp, #68]
ldr r3, [r1, #72]
ldr.w r4, [r1, #160]
ldr.w r5, [r1, #76]
ldr.w r6, [r1, #164]
ldr.w r7, [r1, #80]
ldr.w r8, [r1, #168]
ldr.w r9, [r1, #84]
ldr.w sl, [r1, #172]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
str r3, [sp, #72]
str r5, [sp, #76]
str.w r7, [sp, #80]
str.w r9, [sp, #84]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #88]
ldr r5, [r2, #4]
ldr r6, [r2, #92]
ldr r7, [r2, #8]
ldr.w r8, [r2, #96]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #100]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #104]
ldr.w r0, [r2, #20]
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
ldr r3, [r2, #24]
ldr r4, [r2, #112]
ldr r5, [r2, #28]
ldr r6, [r2, #116]
ldr r7, [r2, #32]
ldr.w r8, [r2, #120]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #124]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #128]
ldr.w r0, [r2, #44]
ldr.w lr, [r2, #132]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #112]
str r5, [sp, #116]
str.w r7, [sp, #120]
str.w r9, [sp, #124]
str.w fp, [sp, #128]
str r0, [sp, #132]
ldr r3, [r2, #48]
ldr.w r4, [r2, #136]
ldr.w r5, [r2, #52]
ldr.w r6, [r2, #140]
ldr.w r7, [r2, #56]
ldr.w r8, [r2, #144]
ldr.w r9, [r2, #60]
ldr.w sl, [r2, #148]
ldr.w fp, [r2, #64]
ldr.w ip, [r2, #152]
ldr.w r0, [r2, #68]
ldr.w lr, [r2, #156]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #136]
str r5, [sp, #140]
str.w r7, [sp, #144]
str.w r9, [sp, #148]
str.w fp, [sp, #152]
str r0, [sp, #156]
ldr r3, [r2, #72]
ldr.w r4, [r2, #160]
ldr.w r5, [r2, #76]
ldr.w r6, [r2, #164]
ldr.w r7, [r2, #80]
ldr.w r8, [r2, #168]
ldr.w r9, [r2, #84]
ldr.w sl, [r2, #172]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
str r3, [sp, #160]
str r5, [sp, #164]
str.w r7, [sp, #168]
str.w r9, [sp, #172]
add r2, sp, #88
add r0, sp, #176
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #44
add.w r2, r2, #44
add.w r0, r0, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop.w {r1}
sub.w r1, r1, #44
sub.w r2, r2, #44
sub sp, #176
ldr r3, [r1, #0]
ldr r4, [r1, #44]
ldr r5, [r1, #4]
ldr r6, [r1, #48]
ldr r7, [r1, #8]
ldr.w r8, [r1, #52]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #56]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #60]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #64]
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
ldr r4, [r1, #68]
ldr r5, [r1, #28]
ldr r6, [r1, #72]
ldr r7, [r1, #32]
ldr.w r8, [r1, #76]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #80]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #44]
ldr r5, [r2, #4]
ldr r6, [r2, #48]
ldr r7, [r2, #8]
ldr.w r8, [r2, #52]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #56]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #60]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #64]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #44]
str r5, [sp, #48]
str.w r7, [sp, #52]
str.w r9, [sp, #56]
str.w fp, [sp, #60]
str r0, [sp, #64]
ldr r3, [r2, #24]
ldr r4, [r2, #68]
ldr r5, [r2, #28]
ldr r6, [r2, #72]
ldr r7, [r2, #32]
ldr.w r8, [r2, #76]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #80]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #68]
str r5, [sp, #72]
str.w r7, [sp, #76]
str.w r9, [sp, #80]
str.w fp, [sp, #84]
add r2, sp, #44
add r0, sp, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #176]
ldr r5, [r3, #0]
ldr r6, [r3, #44]
ldr r7, [r0, #0]
ldr.w r8, [r0, #44]
ldr.w r9, [r0, #88]
ldr.w sl, [r0, #132]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #44]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #88]
ldr r5, [r3, #4]
ldr r6, [r3, #48]
ldr r7, [r0, #4]
ldr.w r8, [r0, #48]
ldr.w r9, [r0, #92]
ldr.w sl, [r0, #136]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #48]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #92]
ldr r5, [r3, #8]
ldr r6, [r3, #52]
ldr r7, [r0, #8]
ldr.w r8, [r0, #52]
ldr.w r9, [r0, #96]
ldr.w sl, [r0, #140]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #52]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #96]
ldr r5, [r3, #12]
ldr r6, [r3, #56]
ldr r7, [r0, #12]
ldr.w r8, [r0, #56]
ldr.w r9, [r0, #100]
ldr.w sl, [r0, #144]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #56]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #100]
ldr r5, [r3, #16]
ldr r6, [r3, #60]
ldr r7, [r0, #16]
ldr.w r8, [r0, #60]
ldr.w r9, [r0, #104]
ldr.w sl, [r0, #148]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #60]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #104]
ldr r5, [r3, #20]
ldr r6, [r3, #64]
ldr r7, [r0, #20]
ldr.w r8, [r0, #64]
ldr.w r9, [r0, #108]
ldr.w sl, [r0, #152]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #64]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #108]
ldr r5, [r3, #24]
ldr r6, [r3, #68]
ldr r7, [r0, #24]
ldr.w r8, [r0, #68]
ldr.w r9, [r0, #112]
ldr.w sl, [r0, #156]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #68]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #112]
ldr r5, [r3, #28]
ldr r6, [r3, #72]
ldr r7, [r0, #28]
ldr.w r8, [r0, #72]
ldr.w r9, [r0, #116]
ldr.w sl, [r0, #160]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #72]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #116]
ldr r5, [r3, #32]
ldr r6, [r3, #76]
ldr r7, [r0, #32]
ldr.w r8, [r0, #76]
ldr.w r9, [r0, #120]
ldr.w sl, [r0, #164]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #76]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #120]
ldr r5, [r3, #36]
ldr r6, [r3, #80]
ldr r7, [r0, #36]
ldr.w r8, [r0, #80]
ldr.w r9, [r0, #124]
ldr.w sl, [r0, #168]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #80]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #124]
ldrh r5, [r3, #40]
ldrh.w r6, [r3, #84]
ldrh.w r7, [r0, #40]
ldrh.w r8, [r0, #84]
ldrh.w r9, [r0, #128]
ldrh.w sl, [r0, #172]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #84]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #128]
ldrh r5, [r3, #42]
ldrh r7, [r0, #42]
ldrh.w r9, [r0, #130]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #86]
add sp, #180
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #352]
ldr r5, [r3, #0]
ldr r6, [r3, #88]
ldr r7, [r0, #0]
ldr.w r8, [r0, #88]
ldr.w r9, [r0, #176]
ldr.w sl, [r0, #264]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #88]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #176]
ldr r5, [r3, #4]
ldr r6, [r3, #92]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #92]
ldr.w r9, [r0, #180]
ldr.w sl, [r0, #268]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #92]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #180]
ldr r5, [r3, #8]
ldr r6, [r3, #96]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #96]
ldr.w r9, [r0, #184]
ldr.w sl, [r0, #272]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #96]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #184]
ldr r5, [r3, #12]
ldr r6, [r3, #100]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #100]
ldr.w r9, [r0, #188]
ldr.w sl, [r0, #276]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #100]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #188]
ldr r5, [r3, #16]
ldr r6, [r3, #104]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #104]
ldr.w r9, [r0, #192]
ldr.w sl, [r0, #280]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #104]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #192]
ldr r5, [r3, #20]
ldr r6, [r3, #108]
ldr.w r7, [r0, #20]
ldr.w r8, [r0, #108]
ldr.w r9, [r0, #196]
ldr.w sl, [r0, #284]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #108]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #196]
ldr r5, [r3, #24]
ldr r6, [r3, #112]
ldr.w r7, [r0, #24]
ldr.w r8, [r0, #112]
ldr.w r9, [r0, #200]
ldr.w sl, [r0, #288]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #112]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #200]
ldr r5, [r3, #28]
ldr r6, [r3, #116]
ldr.w r7, [r0, #28]
ldr.w r8, [r0, #116]
ldr.w r9, [r0, #204]
ldr.w sl, [r0, #292]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #116]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #204]
ldr r5, [r3, #32]
ldr r6, [r3, #120]
ldr.w r7, [r0, #32]
ldr.w r8, [r0, #120]
ldr.w r9, [r0, #208]
ldr.w sl, [r0, #296]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #120]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #208]
ldr r5, [r3, #36]
ldr r6, [r3, #124]
ldr.w r7, [r0, #36]
ldr.w r8, [r0, #124]
ldr.w r9, [r0, #212]
ldr.w sl, [r0, #300]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #124]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #212]
ldr.w r5, [r3, #40]
ldr.w r6, [r3, #128]
ldr.w r7, [r0, #40]
ldr.w r8, [r0, #128]
ldr.w r9, [r0, #216]
ldr.w sl, [r0, #304]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #128]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #216]
ldr.w r5, [r3, #44]
ldr.w r6, [r3, #132]
ldr.w r7, [r0, #44]
ldr.w r8, [r0, #132]
ldr.w r9, [r0, #220]
ldr.w sl, [r0, #308]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #132]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #220]
ldr.w r5, [r3, #48]
ldr.w r6, [r3, #136]
ldr.w r7, [r0, #48]
ldr.w r8, [r0, #136]
ldr.w r9, [r0, #224]
ldr.w sl, [r0, #312]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #136]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #224]
ldr.w r5, [r3, #52]
ldr.w r6, [r3, #140]
ldr.w r7, [r0, #52]
ldr.w r8, [r0, #140]
ldr.w r9, [r0, #228]
ldr.w sl, [r0, #316]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #140]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #228]
ldr.w r5, [r3, #56]
ldr.w r6, [r3, #144]
ldr.w r7, [r0, #56]
ldr.w r8, [r0, #144]
ldr.w r9, [r0, #232]
ldr.w sl, [r0, #320]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #144]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #232]
ldr.w r5, [r3, #60]
ldr.w r6, [r3, #148]
ldr.w r7, [r0, #60]
ldr.w r8, [r0, #148]
ldr.w r9, [r0, #236]
ldr.w sl, [r0, #324]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #148]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #236]
ldr.w r5, [r3, #64]
ldr.w r6, [r3, #152]
ldr.w r7, [r0, #64]
ldr.w r8, [r0, #152]
ldr.w r9, [r0, #240]
ldr.w sl, [r0, #328]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #152]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #240]
ldr.w r5, [r3, #68]
ldr.w r6, [r3, #156]
ldr.w r7, [r0, #68]
ldr.w r8, [r0, #156]
ldr.w r9, [r0, #244]
ldr.w sl, [r0, #332]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #156]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #244]
ldr.w r5, [r3, #72]
ldr.w r6, [r3, #160]
ldr.w r7, [r0, #72]
ldr.w r8, [r0, #160]
ldr.w r9, [r0, #248]
ldr.w sl, [r0, #336]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #160]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #248]
ldr.w r5, [r3, #76]
ldr.w r6, [r3, #164]
ldr.w r7, [r0, #76]
ldr.w r8, [r0, #164]
ldr.w r9, [r0, #252]
ldr.w sl, [r0, #340]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #164]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #252]
ldr.w r5, [r3, #80]
ldr.w r6, [r3, #168]
ldr.w r7, [r0, #80]
ldr.w r8, [r0, #168]
ldr.w r9, [r0, #256]
ldr.w sl, [r0, #344]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #168]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #256]
ldrh.w r5, [r3, #84]
ldrh.w r6, [r3, #172]
ldrh.w r7, [r0, #84]
ldrh.w r8, [r0, #172]
ldrh.w r9, [r0, #260]
ldrh.w sl, [r0, #348]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #172]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #260]
ldrh.w r5, [r3, #86]
ldrh.w r7, [r0, #86]
ldrh.w r9, [r0, #262]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #174]
add sp, #356
pop {r2}
pop.w {r1}
sub.w r1, r1, #176
sub.w r2, r2, #176
sub.w sp, sp, #704
ldr.w r3, [r1, #0]
ldr.w r4, [r1, #176]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #180]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #184]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #188]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #192]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #196]
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
ldr.w r4, [r1, #200]
ldr.w r5, [r1, #28]
ldr.w r6, [r1, #204]
ldr.w r7, [r1, #32]
ldr.w r8, [r1, #208]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #212]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #216]
ldr.w r0, [r1, #44]
ldr.w lr, [r1, #220]
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
ldr.w r4, [r1, #224]
ldr.w r5, [r1, #52]
ldr.w r6, [r1, #228]
ldr.w r7, [r1, #56]
ldr.w r8, [r1, #232]
ldr.w r9, [r1, #60]
ldr.w sl, [r1, #236]
ldr.w fp, [r1, #64]
ldr.w ip, [r1, #240]
ldr.w r0, [r1, #68]
ldr.w lr, [r1, #244]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #48]
str r5, [sp, #52]
str.w r7, [sp, #56]
str.w r9, [sp, #60]
str.w fp, [sp, #64]
str r0, [sp, #68]
ldr r3, [r1, #72]
ldr.w r4, [r1, #248]
ldr.w r5, [r1, #76]
ldr.w r6, [r1, #252]
ldr.w r7, [r1, #80]
ldr.w r8, [r1, #256]
ldr.w r9, [r1, #84]
ldr.w sl, [r1, #260]
ldr.w fp, [r1, #88]
ldr.w ip, [r1, #264]
ldr.w r0, [r1, #92]
ldr.w lr, [r1, #268]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #72]
str r5, [sp, #76]
str.w r7, [sp, #80]
str.w r9, [sp, #84]
str.w fp, [sp, #88]
str r0, [sp, #92]
ldr r3, [r1, #96]
ldr.w r4, [r1, #272]
ldr.w r5, [r1, #100]
ldr.w r6, [r1, #276]
ldr.w r7, [r1, #104]
ldr.w r8, [r1, #280]
ldr.w r9, [r1, #108]
ldr.w sl, [r1, #284]
ldr.w fp, [r1, #112]
ldr.w ip, [r1, #288]
ldr.w r0, [r1, #116]
ldr.w lr, [r1, #292]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #96]
str r5, [sp, #100]
str.w r7, [sp, #104]
str.w r9, [sp, #108]
str.w fp, [sp, #112]
str r0, [sp, #116]
ldr r3, [r1, #120]
ldr.w r4, [r1, #296]
ldr.w r5, [r1, #124]
ldr.w r6, [r1, #300]
ldr.w r7, [r1, #128]
ldr.w r8, [r1, #304]
ldr.w r9, [r1, #132]
ldr.w sl, [r1, #308]
ldr.w fp, [r1, #136]
ldr.w ip, [r1, #312]
ldr.w r0, [r1, #140]
ldr.w lr, [r1, #316]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #120]
str r5, [sp, #124]
str.w r7, [sp, #128]
str.w r9, [sp, #132]
str.w fp, [sp, #136]
str.w r0, [sp, #140]
ldr.w r3, [r1, #144]
ldr.w r4, [r1, #320]
ldr.w r5, [r1, #148]
ldr.w r6, [r1, #324]
ldr.w r7, [r1, #152]
ldr.w r8, [r1, #328]
ldr.w r9, [r1, #156]
ldr.w sl, [r1, #332]
ldr.w fp, [r1, #160]
ldr.w ip, [r1, #336]
ldr.w r0, [r1, #164]
ldr.w lr, [r1, #340]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #144]
str r5, [sp, #148]
str.w r7, [sp, #152]
str.w r9, [sp, #156]
str.w fp, [sp, #160]
str.w r0, [sp, #164]
ldr.w r3, [r1, #168]
ldr.w r4, [r1, #344]
ldr.w r5, [r1, #172]
ldr.w r6, [r1, #348]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
str r3, [sp, #168]
str r5, [sp, #172]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #176]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #180]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #184]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #188]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #192]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #196]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #176]
str r5, [sp, #180]
str.w r7, [sp, #184]
str.w r9, [sp, #188]
str.w fp, [sp, #192]
str r0, [sp, #196]
ldr r3, [r2, #24]
ldr.w r4, [r2, #200]
ldr.w r5, [r2, #28]
ldr.w r6, [r2, #204]
ldr.w r7, [r2, #32]
ldr.w r8, [r2, #208]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #212]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #216]
ldr.w r0, [r2, #44]
ldr.w lr, [r2, #220]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #200]
str r5, [sp, #204]
str.w r7, [sp, #208]
str.w r9, [sp, #212]
str.w fp, [sp, #216]
str r0, [sp, #220]
ldr r3, [r2, #48]
ldr.w r4, [r2, #224]
ldr.w r5, [r2, #52]
ldr.w r6, [r2, #228]
ldr.w r7, [r2, #56]
ldr.w r8, [r2, #232]
ldr.w r9, [r2, #60]
ldr.w sl, [r2, #236]
ldr.w fp, [r2, #64]
ldr.w ip, [r2, #240]
ldr.w r0, [r2, #68]
ldr.w lr, [r2, #244]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #224]
str r5, [sp, #228]
str.w r7, [sp, #232]
str.w r9, [sp, #236]
str.w fp, [sp, #240]
str r0, [sp, #244]
ldr r3, [r2, #72]
ldr.w r4, [r2, #248]
ldr.w r5, [r2, #76]
ldr.w r6, [r2, #252]
ldr.w r7, [r2, #80]
ldr.w r8, [r2, #256]
ldr.w r9, [r2, #84]
ldr.w sl, [r2, #260]
ldr.w fp, [r2, #88]
ldr.w ip, [r2, #264]
ldr.w r0, [r2, #92]
ldr.w lr, [r2, #268]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #248]
str r5, [sp, #252]
str.w r7, [sp, #256]
str.w r9, [sp, #260]
str.w fp, [sp, #264]
str r0, [sp, #268]
ldr r3, [r2, #96]
ldr.w r4, [r2, #272]
ldr.w r5, [r2, #100]
ldr.w r6, [r2, #276]
ldr.w r7, [r2, #104]
ldr.w r8, [r2, #280]
ldr.w r9, [r2, #108]
ldr.w sl, [r2, #284]
ldr.w fp, [r2, #112]
ldr.w ip, [r2, #288]
ldr.w r0, [r2, #116]
ldr.w lr, [r2, #292]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #272]
str r5, [sp, #276]
str.w r7, [sp, #280]
str.w r9, [sp, #284]
str.w fp, [sp, #288]
str r0, [sp, #292]
ldr r3, [r2, #120]
ldr.w r4, [r2, #296]
ldr.w r5, [r2, #124]
ldr.w r6, [r2, #300]
ldr.w r7, [r2, #128]
ldr.w r8, [r2, #304]
ldr.w r9, [r2, #132]
ldr.w sl, [r2, #308]
ldr.w fp, [r2, #136]
ldr.w ip, [r2, #312]
ldr.w r0, [r2, #140]
ldr.w lr, [r2, #316]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #296]
str r5, [sp, #300]
str.w r7, [sp, #304]
str.w r9, [sp, #308]
str.w fp, [sp, #312]
str.w r0, [sp, #316]
ldr.w r3, [r2, #144]
ldr.w r4, [r2, #320]
ldr.w r5, [r2, #148]
ldr.w r6, [r2, #324]
ldr.w r7, [r2, #152]
ldr.w r8, [r2, #328]
ldr.w r9, [r2, #156]
ldr.w sl, [r2, #332]
ldr.w fp, [r2, #160]
ldr.w ip, [r2, #336]
ldr.w r0, [r2, #164]
ldr.w lr, [r2, #340]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #320]
str r5, [sp, #324]
str.w r7, [sp, #328]
str.w r9, [sp, #332]
str.w fp, [sp, #336]
str.w r0, [sp, #340]
ldr.w r3, [r2, #168]
ldr.w r4, [r2, #344]
ldr.w r5, [r2, #172]
ldr.w r6, [r2, #348]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
str r3, [sp, #344]
str r5, [sp, #348]
add r2, sp, #176
add r0, sp, #352
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #44
add.w r2, r2, #44
add.w r0, r0, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop.w {r1}
sub.w r1, r1, #44
sub.w r2, r2, #44
sub sp, #176
ldr r3, [r1, #0]
ldr r4, [r1, #44]
ldr r5, [r1, #4]
ldr r6, [r1, #48]
ldr r7, [r1, #8]
ldr.w r8, [r1, #52]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #56]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #60]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #64]
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
ldr r4, [r1, #68]
ldr r5, [r1, #28]
ldr r6, [r1, #72]
ldr r7, [r1, #32]
ldr.w r8, [r1, #76]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #80]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #44]
ldr r5, [r2, #4]
ldr r6, [r2, #48]
ldr r7, [r2, #8]
ldr.w r8, [r2, #52]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #56]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #60]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #64]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #44]
str r5, [sp, #48]
str.w r7, [sp, #52]
str.w r9, [sp, #56]
str.w fp, [sp, #60]
str r0, [sp, #64]
ldr r3, [r2, #24]
ldr r4, [r2, #68]
ldr r5, [r2, #28]
ldr r6, [r2, #72]
ldr r7, [r2, #32]
ldr.w r8, [r2, #76]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #80]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #68]
str r5, [sp, #72]
str.w r7, [sp, #76]
str.w r9, [sp, #80]
str.w fp, [sp, #84]
add r2, sp, #44
add r0, sp, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #176]
ldr r5, [r3, #0]
ldr r6, [r3, #44]
ldr r7, [r0, #0]
ldr.w r8, [r0, #44]
ldr.w r9, [r0, #88]
ldr.w sl, [r0, #132]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #44]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #88]
ldr r5, [r3, #4]
ldr r6, [r3, #48]
ldr r7, [r0, #4]
ldr.w r8, [r0, #48]
ldr.w r9, [r0, #92]
ldr.w sl, [r0, #136]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #48]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #92]
ldr r5, [r3, #8]
ldr r6, [r3, #52]
ldr r7, [r0, #8]
ldr.w r8, [r0, #52]
ldr.w r9, [r0, #96]
ldr.w sl, [r0, #140]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #52]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #96]
ldr r5, [r3, #12]
ldr r6, [r3, #56]
ldr r7, [r0, #12]
ldr.w r8, [r0, #56]
ldr.w r9, [r0, #100]
ldr.w sl, [r0, #144]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #56]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #100]
ldr r5, [r3, #16]
ldr r6, [r3, #60]
ldr r7, [r0, #16]
ldr.w r8, [r0, #60]
ldr.w r9, [r0, #104]
ldr.w sl, [r0, #148]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #60]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #104]
ldr r5, [r3, #20]
ldr r6, [r3, #64]
ldr r7, [r0, #20]
ldr.w r8, [r0, #64]
ldr.w r9, [r0, #108]
ldr.w sl, [r0, #152]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #64]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #108]
ldr r5, [r3, #24]
ldr r6, [r3, #68]
ldr r7, [r0, #24]
ldr.w r8, [r0, #68]
ldr.w r9, [r0, #112]
ldr.w sl, [r0, #156]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #68]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #112]
ldr r5, [r3, #28]
ldr r6, [r3, #72]
ldr r7, [r0, #28]
ldr.w r8, [r0, #72]
ldr.w r9, [r0, #116]
ldr.w sl, [r0, #160]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #72]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #116]
ldr r5, [r3, #32]
ldr r6, [r3, #76]
ldr r7, [r0, #32]
ldr.w r8, [r0, #76]
ldr.w r9, [r0, #120]
ldr.w sl, [r0, #164]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #76]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #120]
ldr r5, [r3, #36]
ldr r6, [r3, #80]
ldr r7, [r0, #36]
ldr.w r8, [r0, #80]
ldr.w r9, [r0, #124]
ldr.w sl, [r0, #168]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #80]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #124]
ldrh r5, [r3, #40]
ldrh.w r6, [r3, #84]
ldrh.w r7, [r0, #40]
ldrh.w r8, [r0, #84]
ldrh.w r9, [r0, #128]
ldrh.w sl, [r0, #172]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #84]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #128]
ldrh r5, [r3, #42]
ldrh r7, [r0, #42]
ldrh.w r9, [r0, #130]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #86]
add sp, #180
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #88
add.w r2, r2, #88
add.w r0, r0, #176
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #44
add.w r2, r2, #44
add.w r0, r0, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop.w {r1}
sub.w r1, r1, #44
sub.w r2, r2, #44
sub sp, #176
ldr r3, [r1, #0]
ldr r4, [r1, #44]
ldr r5, [r1, #4]
ldr r6, [r1, #48]
ldr r7, [r1, #8]
ldr.w r8, [r1, #52]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #56]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #60]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #64]
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
ldr r4, [r1, #68]
ldr r5, [r1, #28]
ldr r6, [r1, #72]
ldr r7, [r1, #32]
ldr.w r8, [r1, #76]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #80]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #44]
ldr r5, [r2, #4]
ldr r6, [r2, #48]
ldr r7, [r2, #8]
ldr.w r8, [r2, #52]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #56]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #60]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #64]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #44]
str r5, [sp, #48]
str.w r7, [sp, #52]
str.w r9, [sp, #56]
str.w fp, [sp, #60]
str r0, [sp, #64]
ldr r3, [r2, #24]
ldr r4, [r2, #68]
ldr r5, [r2, #28]
ldr r6, [r2, #72]
ldr r7, [r2, #32]
ldr.w r8, [r2, #76]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #80]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #68]
str r5, [sp, #72]
str.w r7, [sp, #76]
str.w r9, [sp, #80]
str.w fp, [sp, #84]
add r2, sp, #44
add r0, sp, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #176]
ldr r5, [r3, #0]
ldr r6, [r3, #44]
ldr r7, [r0, #0]
ldr.w r8, [r0, #44]
ldr.w r9, [r0, #88]
ldr.w sl, [r0, #132]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #44]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #88]
ldr r5, [r3, #4]
ldr r6, [r3, #48]
ldr r7, [r0, #4]
ldr.w r8, [r0, #48]
ldr.w r9, [r0, #92]
ldr.w sl, [r0, #136]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #48]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #92]
ldr r5, [r3, #8]
ldr r6, [r3, #52]
ldr r7, [r0, #8]
ldr.w r8, [r0, #52]
ldr.w r9, [r0, #96]
ldr.w sl, [r0, #140]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #52]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #96]
ldr r5, [r3, #12]
ldr r6, [r3, #56]
ldr r7, [r0, #12]
ldr.w r8, [r0, #56]
ldr.w r9, [r0, #100]
ldr.w sl, [r0, #144]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #56]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #100]
ldr r5, [r3, #16]
ldr r6, [r3, #60]
ldr r7, [r0, #16]
ldr.w r8, [r0, #60]
ldr.w r9, [r0, #104]
ldr.w sl, [r0, #148]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #60]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #104]
ldr r5, [r3, #20]
ldr r6, [r3, #64]
ldr r7, [r0, #20]
ldr.w r8, [r0, #64]
ldr.w r9, [r0, #108]
ldr.w sl, [r0, #152]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #64]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #108]
ldr r5, [r3, #24]
ldr r6, [r3, #68]
ldr r7, [r0, #24]
ldr.w r8, [r0, #68]
ldr.w r9, [r0, #112]
ldr.w sl, [r0, #156]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #68]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #112]
ldr r5, [r3, #28]
ldr r6, [r3, #72]
ldr r7, [r0, #28]
ldr.w r8, [r0, #72]
ldr.w r9, [r0, #116]
ldr.w sl, [r0, #160]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #72]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #116]
ldr r5, [r3, #32]
ldr r6, [r3, #76]
ldr r7, [r0, #32]
ldr.w r8, [r0, #76]
ldr.w r9, [r0, #120]
ldr.w sl, [r0, #164]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #76]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #120]
ldr r5, [r3, #36]
ldr r6, [r3, #80]
ldr r7, [r0, #36]
ldr.w r8, [r0, #80]
ldr.w r9, [r0, #124]
ldr.w sl, [r0, #168]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #80]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #124]
ldrh r5, [r3, #40]
ldrh.w r6, [r3, #84]
ldrh.w r7, [r0, #40]
ldrh.w r8, [r0, #84]
ldrh.w r9, [r0, #128]
ldrh.w sl, [r0, #172]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #84]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #128]
ldrh r5, [r3, #42]
ldrh r7, [r0, #42]
ldrh.w r9, [r0, #130]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #86]
add sp, #180
pop {r2}
pop.w {r1}
sub.w r1, r1, #88
sub.w r2, r2, #88
sub sp, #352
ldr r3, [r1, #0]
ldr r4, [r1, #88]
ldr r5, [r1, #4]
ldr r6, [r1, #92]
ldr r7, [r1, #8]
ldr.w r8, [r1, #96]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #100]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #104]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #108]
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
ldr r4, [r1, #112]
ldr r5, [r1, #28]
ldr r6, [r1, #116]
ldr r7, [r1, #32]
ldr.w r8, [r1, #120]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #124]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #128]
ldr.w r0, [r1, #44]
ldr.w lr, [r1, #132]
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
ldr.w r4, [r1, #136]
ldr.w r5, [r1, #52]
ldr.w r6, [r1, #140]
ldr.w r7, [r1, #56]
ldr.w r8, [r1, #144]
ldr.w r9, [r1, #60]
ldr.w sl, [r1, #148]
ldr.w fp, [r1, #64]
ldr.w ip, [r1, #152]
ldr.w r0, [r1, #68]
ldr.w lr, [r1, #156]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #48]
str r5, [sp, #52]
str.w r7, [sp, #56]
str.w r9, [sp, #60]
str.w fp, [sp, #64]
str r0, [sp, #68]
ldr r3, [r1, #72]
ldr.w r4, [r1, #160]
ldr.w r5, [r1, #76]
ldr.w r6, [r1, #164]
ldr.w r7, [r1, #80]
ldr.w r8, [r1, #168]
ldr.w r9, [r1, #84]
ldr.w sl, [r1, #172]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
str r3, [sp, #72]
str r5, [sp, #76]
str.w r7, [sp, #80]
str.w r9, [sp, #84]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #88]
ldr r5, [r2, #4]
ldr r6, [r2, #92]
ldr r7, [r2, #8]
ldr.w r8, [r2, #96]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #100]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #104]
ldr.w r0, [r2, #20]
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
ldr r3, [r2, #24]
ldr r4, [r2, #112]
ldr r5, [r2, #28]
ldr r6, [r2, #116]
ldr r7, [r2, #32]
ldr.w r8, [r2, #120]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #124]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #128]
ldr.w r0, [r2, #44]
ldr.w lr, [r2, #132]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #112]
str r5, [sp, #116]
str.w r7, [sp, #120]
str.w r9, [sp, #124]
str.w fp, [sp, #128]
str r0, [sp, #132]
ldr r3, [r2, #48]
ldr.w r4, [r2, #136]
ldr.w r5, [r2, #52]
ldr.w r6, [r2, #140]
ldr.w r7, [r2, #56]
ldr.w r8, [r2, #144]
ldr.w r9, [r2, #60]
ldr.w sl, [r2, #148]
ldr.w fp, [r2, #64]
ldr.w ip, [r2, #152]
ldr.w r0, [r2, #68]
ldr.w lr, [r2, #156]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #136]
str r5, [sp, #140]
str.w r7, [sp, #144]
str.w r9, [sp, #148]
str.w fp, [sp, #152]
str r0, [sp, #156]
ldr r3, [r2, #72]
ldr.w r4, [r2, #160]
ldr.w r5, [r2, #76]
ldr.w r6, [r2, #164]
ldr.w r7, [r2, #80]
ldr.w r8, [r2, #168]
ldr.w r9, [r2, #84]
ldr.w sl, [r2, #172]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
str r3, [sp, #160]
str r5, [sp, #164]
str.w r7, [sp, #168]
str.w r9, [sp, #172]
add r2, sp, #88
add r0, sp, #176
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
push {r1}
push {r2}
push {r0}
add.w r1, r1, #44
add.w r2, r2, #44
add.w r0, r0, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop.w {r1}
sub.w r1, r1, #44
sub.w r2, r2, #44
sub sp, #176
ldr r3, [r1, #0]
ldr r4, [r1, #44]
ldr r5, [r1, #4]
ldr r6, [r1, #48]
ldr r7, [r1, #8]
ldr.w r8, [r1, #52]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #56]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #60]
ldr.w r0, [r1, #20]
ldr.w lr, [r1, #64]
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
ldr r4, [r1, #68]
ldr r5, [r1, #28]
ldr r6, [r1, #72]
ldr r7, [r1, #32]
ldr.w r8, [r1, #76]
ldr.w r9, [r1, #36]
ldr.w sl, [r1, #80]
ldr.w fp, [r1, #40]
ldr.w ip, [r1, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
mov r1, sp
ldr r3, [r2, #0]
ldr r4, [r2, #44]
ldr r5, [r2, #4]
ldr r6, [r2, #48]
ldr r7, [r2, #8]
ldr.w r8, [r2, #52]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #56]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #60]
ldr.w r0, [r2, #20]
ldr.w lr, [r2, #64]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
uadd16 r0, r0, lr
str r3, [sp, #44]
str r5, [sp, #48]
str.w r7, [sp, #52]
str.w r9, [sp, #56]
str.w fp, [sp, #60]
str r0, [sp, #64]
ldr r3, [r2, #24]
ldr r4, [r2, #68]
ldr r5, [r2, #28]
ldr r6, [r2, #72]
ldr r7, [r2, #32]
ldr.w r8, [r2, #76]
ldr.w r9, [r2, #36]
ldr.w sl, [r2, #80]
ldr.w fp, [r2, #40]
ldr.w ip, [r2, #84]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #68]
str r5, [sp, #72]
str.w r7, [sp, #76]
str.w r9, [sp, #80]
str.w fp, [sp, #84]
add r2, sp, #44
add r0, sp, #88
bl schoolbook_11x11
push {r1}
push {r2}
push.w {r0}
add.w r1, r1, #22
add.w r2, r2, #22
add.w r0, r0, #44
bl schoolbook_11x11
sub.w r1, r1, #22
sub.w r2, r2, #22
sub sp, #92
ldr r3, [r1, #0]
ldr.w r4, [r1, #22]
ldr.w r5, [r1, #4]
ldr.w r6, [r1, #26]
ldr.w r7, [r1, #8]
ldr.w r8, [r1, #30]
ldr.w r9, [r1, #12]
ldr.w sl, [r1, #34]
ldr.w fp, [r1, #16]
ldr.w ip, [r1, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #0]
str r5, [sp, #4]
str.w r7, [sp, #8]
str.w r9, [sp, #12]
str.w fp, [sp, #16]
ldrh r5, [r1, #20]
ldrh r6, [r1, #42]
add.w r5, r6
strh.w r5, [sp, #20]
mov r1, sp
ldr r3, [r2, #0]
ldr.w r4, [r2, #22]
ldr.w r5, [r2, #4]
ldr.w r6, [r2, #26]
ldr.w r7, [r2, #8]
ldr.w r8, [r2, #30]
ldr.w r9, [r2, #12]
ldr.w sl, [r2, #34]
ldr.w fp, [r2, #16]
ldr.w ip, [r2, #38]
uadd16 r3, r3, r4
uadd16 r5, r5, r6
uadd16 r7, r7, r8
uadd16 r9, r9, sl
uadd16 fp, fp, ip
str r3, [sp, #24]
str r5, [sp, #28]
str.w r7, [sp, #32]
str.w r9, [sp, #36]
str.w fp, [sp, #40]
ldrh r5, [r2, #20]
ldrh r6, [r2, #42]
add.w r5, r6
strh.w r5, [sp, #44]
add r2, sp, #24
add r0, sp, #48
bl schoolbook_11x11
mov r3, r0
ldr r0, [sp, #92]
ldr.w r5, [r3, #0]
ldr.w r6, [r3, #22]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #22]
ldr.w r9, [r0, #44]
ldr.w sl, [r0, #66]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #22]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #44]
ldr r5, [r3, #4]
ldr.w r6, [r3, #26]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #26]
ldr.w r9, [r0, #48]
ldr.w sl, [r0, #70]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #26]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #48]
ldr r5, [r3, #8]
ldr.w r6, [r3, #30]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #30]
ldr.w r9, [r0, #52]
ldr.w sl, [r0, #74]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #30]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #52]
ldr r5, [r3, #12]
ldr.w r6, [r3, #34]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #34]
ldr.w r9, [r0, #56]
ldr.w sl, [r0, #78]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #34]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #56]
ldr r5, [r3, #16]
ldr.w r6, [r3, #38]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #38]
ldr.w r9, [r0, #60]
ldr.w sl, [r0, #82]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #38]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #60]
ldrh r5, [r3, #20]
ldrh.w r7, [r0, #20]
ldrh.w r9, [r0, #64]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #42]
add sp, #96
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #176]
ldr r5, [r3, #0]
ldr r6, [r3, #44]
ldr r7, [r0, #0]
ldr.w r8, [r0, #44]
ldr.w r9, [r0, #88]
ldr.w sl, [r0, #132]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #44]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #88]
ldr r5, [r3, #4]
ldr r6, [r3, #48]
ldr r7, [r0, #4]
ldr.w r8, [r0, #48]
ldr.w r9, [r0, #92]
ldr.w sl, [r0, #136]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #48]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #92]
ldr r5, [r3, #8]
ldr r6, [r3, #52]
ldr r7, [r0, #8]
ldr.w r8, [r0, #52]
ldr.w r9, [r0, #96]
ldr.w sl, [r0, #140]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #52]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #96]
ldr r5, [r3, #12]
ldr r6, [r3, #56]
ldr r7, [r0, #12]
ldr.w r8, [r0, #56]
ldr.w r9, [r0, #100]
ldr.w sl, [r0, #144]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #56]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #100]
ldr r5, [r3, #16]
ldr r6, [r3, #60]
ldr r7, [r0, #16]
ldr.w r8, [r0, #60]
ldr.w r9, [r0, #104]
ldr.w sl, [r0, #148]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #60]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #104]
ldr r5, [r3, #20]
ldr r6, [r3, #64]
ldr r7, [r0, #20]
ldr.w r8, [r0, #64]
ldr.w r9, [r0, #108]
ldr.w sl, [r0, #152]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #64]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #108]
ldr r5, [r3, #24]
ldr r6, [r3, #68]
ldr r7, [r0, #24]
ldr.w r8, [r0, #68]
ldr.w r9, [r0, #112]
ldr.w sl, [r0, #156]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #68]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #112]
ldr r5, [r3, #28]
ldr r6, [r3, #72]
ldr r7, [r0, #28]
ldr.w r8, [r0, #72]
ldr.w r9, [r0, #116]
ldr.w sl, [r0, #160]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #72]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #116]
ldr r5, [r3, #32]
ldr r6, [r3, #76]
ldr r7, [r0, #32]
ldr.w r8, [r0, #76]
ldr.w r9, [r0, #120]
ldr.w sl, [r0, #164]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #76]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #120]
ldr r5, [r3, #36]
ldr r6, [r3, #80]
ldr r7, [r0, #36]
ldr.w r8, [r0, #80]
ldr.w r9, [r0, #124]
ldr.w sl, [r0, #168]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #80]
usub16 r6, r6, r8
usub16 r6, r6, sl
str r6, [r0, #124]
ldrh r5, [r3, #40]
ldrh.w r6, [r3, #84]
ldrh.w r7, [r0, #40]
ldrh.w r8, [r0, #84]
ldrh.w r9, [r0, #128]
ldrh.w sl, [r0, #172]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #84]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #128]
ldrh r5, [r3, #42]
ldrh r7, [r0, #42]
ldrh.w r9, [r0, #130]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #86]
add sp, #180
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #352]
ldr r5, [r3, #0]
ldr r6, [r3, #88]
ldr r7, [r0, #0]
ldr.w r8, [r0, #88]
ldr.w r9, [r0, #176]
ldr.w sl, [r0, #264]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #88]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #176]
ldr r5, [r3, #4]
ldr r6, [r3, #92]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #92]
ldr.w r9, [r0, #180]
ldr.w sl, [r0, #268]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #92]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #180]
ldr r5, [r3, #8]
ldr r6, [r3, #96]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #96]
ldr.w r9, [r0, #184]
ldr.w sl, [r0, #272]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #96]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #184]
ldr r5, [r3, #12]
ldr r6, [r3, #100]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #100]
ldr.w r9, [r0, #188]
ldr.w sl, [r0, #276]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #100]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #188]
ldr r5, [r3, #16]
ldr r6, [r3, #104]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #104]
ldr.w r9, [r0, #192]
ldr.w sl, [r0, #280]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #104]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #192]
ldr r5, [r3, #20]
ldr r6, [r3, #108]
ldr.w r7, [r0, #20]
ldr.w r8, [r0, #108]
ldr.w r9, [r0, #196]
ldr.w sl, [r0, #284]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #108]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #196]
ldr r5, [r3, #24]
ldr r6, [r3, #112]
ldr.w r7, [r0, #24]
ldr.w r8, [r0, #112]
ldr.w r9, [r0, #200]
ldr.w sl, [r0, #288]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #112]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #200]
ldr r5, [r3, #28]
ldr r6, [r3, #116]
ldr.w r7, [r0, #28]
ldr.w r8, [r0, #116]
ldr.w r9, [r0, #204]
ldr.w sl, [r0, #292]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #116]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #204]
ldr r5, [r3, #32]
ldr r6, [r3, #120]
ldr.w r7, [r0, #32]
ldr.w r8, [r0, #120]
ldr.w r9, [r0, #208]
ldr.w sl, [r0, #296]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #120]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #208]
ldr r5, [r3, #36]
ldr r6, [r3, #124]
ldr.w r7, [r0, #36]
ldr.w r8, [r0, #124]
ldr.w r9, [r0, #212]
ldr.w sl, [r0, #300]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #124]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #212]
ldr.w r5, [r3, #40]
ldr.w r6, [r3, #128]
ldr.w r7, [r0, #40]
ldr.w r8, [r0, #128]
ldr.w r9, [r0, #216]
ldr.w sl, [r0, #304]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #128]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #216]
ldr.w r5, [r3, #44]
ldr.w r6, [r3, #132]
ldr.w r7, [r0, #44]
ldr.w r8, [r0, #132]
ldr.w r9, [r0, #220]
ldr.w sl, [r0, #308]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #132]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #220]
ldr.w r5, [r3, #48]
ldr.w r6, [r3, #136]
ldr.w r7, [r0, #48]
ldr.w r8, [r0, #136]
ldr.w r9, [r0, #224]
ldr.w sl, [r0, #312]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #136]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #224]
ldr.w r5, [r3, #52]
ldr.w r6, [r3, #140]
ldr.w r7, [r0, #52]
ldr.w r8, [r0, #140]
ldr.w r9, [r0, #228]
ldr.w sl, [r0, #316]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #140]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #228]
ldr.w r5, [r3, #56]
ldr.w r6, [r3, #144]
ldr.w r7, [r0, #56]
ldr.w r8, [r0, #144]
ldr.w r9, [r0, #232]
ldr.w sl, [r0, #320]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #144]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #232]
ldr.w r5, [r3, #60]
ldr.w r6, [r3, #148]
ldr.w r7, [r0, #60]
ldr.w r8, [r0, #148]
ldr.w r9, [r0, #236]
ldr.w sl, [r0, #324]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #148]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #236]
ldr.w r5, [r3, #64]
ldr.w r6, [r3, #152]
ldr.w r7, [r0, #64]
ldr.w r8, [r0, #152]
ldr.w r9, [r0, #240]
ldr.w sl, [r0, #328]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #152]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #240]
ldr.w r5, [r3, #68]
ldr.w r6, [r3, #156]
ldr.w r7, [r0, #68]
ldr.w r8, [r0, #156]
ldr.w r9, [r0, #244]
ldr.w sl, [r0, #332]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #156]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #244]
ldr.w r5, [r3, #72]
ldr.w r6, [r3, #160]
ldr.w r7, [r0, #72]
ldr.w r8, [r0, #160]
ldr.w r9, [r0, #248]
ldr.w sl, [r0, #336]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #160]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #248]
ldr.w r5, [r3, #76]
ldr.w r6, [r3, #164]
ldr.w r7, [r0, #76]
ldr.w r8, [r0, #164]
ldr.w r9, [r0, #252]
ldr.w sl, [r0, #340]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #164]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #252]
ldr.w r5, [r3, #80]
ldr.w r6, [r3, #168]
ldr.w r7, [r0, #80]
ldr.w r8, [r0, #168]
ldr.w r9, [r0, #256]
ldr.w sl, [r0, #344]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #168]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #256]
ldrh.w r5, [r3, #84]
ldrh.w r6, [r3, #172]
ldrh.w r7, [r0, #84]
ldrh.w r8, [r0, #172]
ldrh.w r9, [r0, #260]
ldrh.w sl, [r0, #348]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #172]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #260]
ldrh.w r5, [r3, #86]
ldrh.w r7, [r0, #86]
ldrh.w r9, [r0, #262]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #174]
add sp, #356
pop {r2}
pop {r1}
mov r3, r0
ldr r0, [sp, #704]
ldr r5, [r3, #0]
ldr.w r6, [r3, #176]
ldr.w r7, [r0, #0]
ldr.w r8, [r0, #176]
ldr.w r9, [r0, #352]
ldr.w sl, [r0, #528]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #176]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #352]
ldr.w r5, [r3, #4]
ldr.w r6, [r3, #180]
ldr.w r7, [r0, #4]
ldr.w r8, [r0, #180]
ldr.w r9, [r0, #356]
ldr.w sl, [r0, #532]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #180]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #356]
ldr.w r5, [r3, #8]
ldr.w r6, [r3, #184]
ldr.w r7, [r0, #8]
ldr.w r8, [r0, #184]
ldr.w r9, [r0, #360]
ldr.w sl, [r0, #536]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #184]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #360]
ldr.w r5, [r3, #12]
ldr.w r6, [r3, #188]
ldr.w r7, [r0, #12]
ldr.w r8, [r0, #188]
ldr.w r9, [r0, #364]
ldr.w sl, [r0, #540]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #188]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #364]
ldr.w r5, [r3, #16]
ldr.w r6, [r3, #192]
ldr.w r7, [r0, #16]
ldr.w r8, [r0, #192]
ldr.w r9, [r0, #368]
ldr.w sl, [r0, #544]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #192]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #368]
ldr.w r5, [r3, #20]
ldr.w r6, [r3, #196]
ldr.w r7, [r0, #20]
ldr.w r8, [r0, #196]
ldr.w r9, [r0, #372]
ldr.w sl, [r0, #548]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #196]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #372]
ldr.w r5, [r3, #24]
ldr.w r6, [r3, #200]
ldr.w r7, [r0, #24]
ldr.w r8, [r0, #200]
ldr.w r9, [r0, #376]
ldr.w sl, [r0, #552]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #200]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #376]
ldr.w r5, [r3, #28]
ldr.w r6, [r3, #204]
ldr.w r7, [r0, #28]
ldr.w r8, [r0, #204]
ldr.w r9, [r0, #380]
ldr.w sl, [r0, #556]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #204]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #380]
ldr.w r5, [r3, #32]
ldr.w r6, [r3, #208]
ldr.w r7, [r0, #32]
ldr.w r8, [r0, #208]
ldr.w r9, [r0, #384]
ldr.w sl, [r0, #560]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #208]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #384]
ldr.w r5, [r3, #36]
ldr.w r6, [r3, #212]
ldr.w r7, [r0, #36]
ldr.w r8, [r0, #212]
ldr.w r9, [r0, #388]
ldr.w sl, [r0, #564]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #212]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #388]
ldr.w r5, [r3, #40]
ldr.w r6, [r3, #216]
ldr.w r7, [r0, #40]
ldr.w r8, [r0, #216]
ldr.w r9, [r0, #392]
ldr.w sl, [r0, #568]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #216]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #392]
ldr.w r5, [r3, #44]
ldr.w r6, [r3, #220]
ldr.w r7, [r0, #44]
ldr.w r8, [r0, #220]
ldr.w r9, [r0, #396]
ldr.w sl, [r0, #572]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #220]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #396]
ldr.w r5, [r3, #48]
ldr.w r6, [r3, #224]
ldr.w r7, [r0, #48]
ldr.w r8, [r0, #224]
ldr.w r9, [r0, #400]
ldr.w sl, [r0, #576]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #224]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #400]
ldr.w r5, [r3, #52]
ldr.w r6, [r3, #228]
ldr.w r7, [r0, #52]
ldr.w r8, [r0, #228]
ldr.w r9, [r0, #404]
ldr.w sl, [r0, #580]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #228]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #404]
ldr.w r5, [r3, #56]
ldr.w r6, [r3, #232]
ldr.w r7, [r0, #56]
ldr.w r8, [r0, #232]
ldr.w r9, [r0, #408]
ldr.w sl, [r0, #584]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #232]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #408]
ldr.w r5, [r3, #60]
ldr.w r6, [r3, #236]
ldr.w r7, [r0, #60]
ldr.w r8, [r0, #236]
ldr.w r9, [r0, #412]
ldr.w sl, [r0, #588]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #236]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #412]
ldr.w r5, [r3, #64]
ldr.w r6, [r3, #240]
ldr.w r7, [r0, #64]
ldr.w r8, [r0, #240]
ldr.w r9, [r0, #416]
ldr.w sl, [r0, #592]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #240]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #416]
ldr.w r5, [r3, #68]
ldr.w r6, [r3, #244]
ldr.w r7, [r0, #68]
ldr.w r8, [r0, #244]
ldr.w r9, [r0, #420]
ldr.w sl, [r0, #596]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #244]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #420]
ldr.w r5, [r3, #72]
ldr.w r6, [r3, #248]
ldr.w r7, [r0, #72]
ldr.w r8, [r0, #248]
ldr.w r9, [r0, #424]
ldr.w sl, [r0, #600]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #248]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #424]
ldr.w r5, [r3, #76]
ldr.w r6, [r3, #252]
ldr.w r7, [r0, #76]
ldr.w r8, [r0, #252]
ldr.w r9, [r0, #428]
ldr.w sl, [r0, #604]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #252]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #428]
ldr.w r5, [r3, #80]
ldr.w r6, [r3, #256]
ldr.w r7, [r0, #80]
ldr.w r8, [r0, #256]
ldr.w r9, [r0, #432]
ldr.w sl, [r0, #608]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #256]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #432]
ldr.w r5, [r3, #84]
ldr.w r6, [r3, #260]
ldr.w r7, [r0, #84]
ldr.w r8, [r0, #260]
ldr.w r9, [r0, #436]
ldr.w sl, [r0, #612]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #260]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #436]
ldr.w r5, [r3, #88]
ldr.w r6, [r3, #264]
ldr.w r7, [r0, #88]
ldr.w r8, [r0, #264]
ldr.w r9, [r0, #440]
ldr.w sl, [r0, #616]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #264]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #440]
ldr.w r5, [r3, #92]
ldr.w r6, [r3, #268]
ldr.w r7, [r0, #92]
ldr.w r8, [r0, #268]
ldr.w r9, [r0, #444]
ldr.w sl, [r0, #620]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #268]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #444]
ldr.w r5, [r3, #96]
ldr.w r6, [r3, #272]
ldr.w r7, [r0, #96]
ldr.w r8, [r0, #272]
ldr.w r9, [r0, #448]
ldr.w sl, [r0, #624]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #272]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #448]
ldr.w r5, [r3, #100]
ldr.w r6, [r3, #276]
ldr.w r7, [r0, #100]
ldr.w r8, [r0, #276]
ldr.w r9, [r0, #452]
ldr.w sl, [r0, #628]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #276]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #452]
ldr.w r5, [r3, #104]
ldr.w r6, [r3, #280]
ldr.w r7, [r0, #104]
ldr.w r8, [r0, #280]
ldr.w r9, [r0, #456]
ldr.w sl, [r0, #632]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #280]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #456]
ldr.w r5, [r3, #108]
ldr.w r6, [r3, #284]
ldr.w r7, [r0, #108]
ldr.w r8, [r0, #284]
ldr.w r9, [r0, #460]
ldr.w sl, [r0, #636]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #284]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #460]
ldr.w r5, [r3, #112]
ldr.w r6, [r3, #288]
ldr.w r7, [r0, #112]
ldr.w r8, [r0, #288]
ldr.w r9, [r0, #464]
ldr.w sl, [r0, #640]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #288]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #464]
ldr.w r5, [r3, #116]
ldr.w r6, [r3, #292]
ldr.w r7, [r0, #116]
ldr.w r8, [r0, #292]
ldr.w r9, [r0, #468]
ldr.w sl, [r0, #644]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #292]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #468]
ldr.w r5, [r3, #120]
ldr.w r6, [r3, #296]
ldr.w r7, [r0, #120]
ldr.w r8, [r0, #296]
ldr.w r9, [r0, #472]
ldr.w sl, [r0, #648]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #296]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #472]
ldr.w r5, [r3, #124]
ldr.w r6, [r3, #300]
ldr.w r7, [r0, #124]
ldr.w r8, [r0, #300]
ldr.w r9, [r0, #476]
ldr.w sl, [r0, #652]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #300]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #476]
ldr.w r5, [r3, #128]
ldr.w r6, [r3, #304]
ldr.w r7, [r0, #128]
ldr.w r8, [r0, #304]
ldr.w r9, [r0, #480]
ldr.w sl, [r0, #656]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #304]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #480]
ldr.w r5, [r3, #132]
ldr.w r6, [r3, #308]
ldr.w r7, [r0, #132]
ldr.w r8, [r0, #308]
ldr.w r9, [r0, #484]
ldr.w sl, [r0, #660]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #308]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #484]
ldr.w r5, [r3, #136]
ldr.w r6, [r3, #312]
ldr.w r7, [r0, #136]
ldr.w r8, [r0, #312]
ldr.w r9, [r0, #488]
ldr.w sl, [r0, #664]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #312]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #488]
ldr.w r5, [r3, #140]
ldr.w r6, [r3, #316]
ldr.w r7, [r0, #140]
ldr.w r8, [r0, #316]
ldr.w r9, [r0, #492]
ldr.w sl, [r0, #668]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #316]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #492]
ldr.w r5, [r3, #144]
ldr.w r6, [r3, #320]
ldr.w r7, [r0, #144]
ldr.w r8, [r0, #320]
ldr.w r9, [r0, #496]
ldr.w sl, [r0, #672]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #320]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #496]
ldr.w r5, [r3, #148]
ldr.w r6, [r3, #324]
ldr.w r7, [r0, #148]
ldr.w r8, [r0, #324]
ldr.w r9, [r0, #500]
ldr.w sl, [r0, #676]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #324]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #500]
ldr.w r5, [r3, #152]
ldr.w r6, [r3, #328]
ldr.w r7, [r0, #152]
ldr.w r8, [r0, #328]
ldr.w r9, [r0, #504]
ldr.w sl, [r0, #680]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #328]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #504]
ldr.w r5, [r3, #156]
ldr.w r6, [r3, #332]
ldr.w r7, [r0, #156]
ldr.w r8, [r0, #332]
ldr.w r9, [r0, #508]
ldr.w sl, [r0, #684]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #332]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #508]
ldr.w r5, [r3, #160]
ldr.w r6, [r3, #336]
ldr.w r7, [r0, #160]
ldr.w r8, [r0, #336]
ldr.w r9, [r0, #512]
ldr.w sl, [r0, #688]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #336]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #512]
ldr.w r5, [r3, #164]
ldr.w r6, [r3, #340]
ldr.w r7, [r0, #164]
ldr.w r8, [r0, #340]
ldr.w r9, [r0, #516]
ldr.w sl, [r0, #692]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #340]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #516]
ldr.w r5, [r3, #168]
ldr.w r6, [r3, #344]
ldr.w r7, [r0, #168]
ldr.w r8, [r0, #344]
ldr.w r9, [r0, #520]
ldr.w sl, [r0, #696]
usub16 fp, r5, r7
usub16 r8, r8, r9
uadd16 fp, fp, r8
str.w fp, [r0, #344]
usub16 r6, r6, r8
usub16 r6, r6, sl
str.w r6, [r0, #520]
ldrh.w r5, [r3, #172]
ldrh.w r6, [r3, #348]
ldrh.w r7, [r0, #172]
ldrh.w r8, [r0, #348]
ldrh.w r9, [r0, #524]
ldrh.w sl, [r0, #700]
sub.w fp, r5, r7
sub.w r8, r8, r9
add.w fp, r8
strh.w fp, [r0, #348]
sub.w r6, r6, r8
sub.w r6, r6, sl
strh.w r6, [r0, #524]
ldrh.w r5, [r3, #174]
ldrh.w r7, [r0, #174]
ldrh.w r9, [r0, #526]
sub.w fp, r5, r7
sub.w fp, fp, r9
strh.w fp, [r0, #350]
add.w sp, sp, #708
pop {r2}
pop {r1}
ldr.w lr, [sp], #4
bx lr
.global polymul_asm
.type polymul_asm, %function
.align 2
polymul_asm:
stmdb sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
mov.w r4, #9152
sub.w sp, sp, r4
add.w r3, sp, #2112
ldr.w r4, [r1, #0]
ldr.w r5, [r1, #352]
ldr.w r6, [r1, #704]
ldr.w r7, [r1, #1056]
str.w r7, [sp, #1760]
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
str.w ip, [sp, #352]
str.w r9, [sp, #704]
str.w sl, [sp, #1056]
str.w r7, [sp, #1408]
ldr.w r4, [r2, #0]
ldr.w r5, [r2, #352]
ldr.w r6, [r2, #704]
ldr.w r7, [r2, #1056]
str.w r7, [r3, #1760]
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
str.w ip, [r3, #352]
str.w r9, [r3, #704]
str.w sl, [r3, #1056]
str.w r7, [r3, #1408]
ldr.w r4, [r1, #4]
ldr.w r5, [r1, #356]
ldr.w r6, [r1, #708]
ldr.w r7, [r1, #1060]
str.w r7, [sp, #1764]
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
str.w ip, [sp, #356]
str.w r9, [sp, #708]
str.w sl, [sp, #1060]
str.w r7, [sp, #1412]
ldr.w r4, [r2, #4]
ldr.w r5, [r2, #356]
ldr.w r6, [r2, #708]
ldr.w r7, [r2, #1060]
str.w r7, [r3, #1764]
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
str.w ip, [r3, #356]
str.w r9, [r3, #708]
str.w sl, [r3, #1060]
str.w r7, [r3, #1412]
ldr.w r4, [r1, #8]
ldr.w r5, [r1, #360]
ldr.w r6, [r1, #712]
ldr.w r7, [r1, #1064]
str.w r7, [sp, #1768]
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
str.w ip, [sp, #360]
str.w r9, [sp, #712]
str.w sl, [sp, #1064]
str.w r7, [sp, #1416]
ldr.w r4, [r2, #8]
ldr.w r5, [r2, #360]
ldr.w r6, [r2, #712]
ldr.w r7, [r2, #1064]
str.w r7, [r3, #1768]
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
str.w ip, [r3, #360]
str.w r9, [r3, #712]
str.w sl, [r3, #1064]
str.w r7, [r3, #1416]
ldr.w r4, [r1, #12]
ldr.w r5, [r1, #364]
ldr.w r6, [r1, #716]
ldr.w r7, [r1, #1068]
str.w r7, [sp, #1772]
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
str.w ip, [sp, #364]
str.w r9, [sp, #716]
str.w sl, [sp, #1068]
str.w r7, [sp, #1420]
ldr.w r4, [r2, #12]
ldr.w r5, [r2, #364]
ldr.w r6, [r2, #716]
ldr.w r7, [r2, #1068]
str.w r7, [r3, #1772]
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
str.w ip, [r3, #364]
str.w r9, [r3, #716]
str.w sl, [r3, #1068]
str.w r7, [r3, #1420]
ldr.w r4, [r1, #16]
ldr.w r5, [r1, #368]
ldr.w r6, [r1, #720]
ldr.w r7, [r1, #1072]
str.w r7, [sp, #1776]
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
str.w ip, [sp, #368]
str.w r9, [sp, #720]
str.w sl, [sp, #1072]
str.w r7, [sp, #1424]
ldr.w r4, [r2, #16]
ldr.w r5, [r2, #368]
ldr.w r6, [r2, #720]
ldr.w r7, [r2, #1072]
str.w r7, [r3, #1776]
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
str.w ip, [r3, #368]
str.w r9, [r3, #720]
str.w sl, [r3, #1072]
str.w r7, [r3, #1424]
ldr.w r4, [r1, #20]
ldr.w r5, [r1, #372]
ldr.w r6, [r1, #724]
ldr.w r7, [r1, #1076]
str.w r7, [sp, #1780]
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
str.w ip, [sp, #372]
str.w r9, [sp, #724]
str.w sl, [sp, #1076]
str.w r7, [sp, #1428]
ldr.w r4, [r2, #20]
ldr.w r5, [r2, #372]
ldr.w r6, [r2, #724]
ldr.w r7, [r2, #1076]
str.w r7, [r3, #1780]
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
str.w ip, [r3, #372]
str.w r9, [r3, #724]
str.w sl, [r3, #1076]
str.w r7, [r3, #1428]
ldr.w r4, [r1, #24]
ldr.w r5, [r1, #376]
ldr.w r6, [r1, #728]
ldr.w r7, [r1, #1080]
str.w r7, [sp, #1784]
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
str.w ip, [sp, #376]
str.w r9, [sp, #728]
str.w sl, [sp, #1080]
str.w r7, [sp, #1432]
ldr.w r4, [r2, #24]
ldr.w r5, [r2, #376]
ldr.w r6, [r2, #728]
ldr.w r7, [r2, #1080]
str.w r7, [r3, #1784]
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
str.w ip, [r3, #376]
str.w r9, [r3, #728]
str.w sl, [r3, #1080]
str.w r7, [r3, #1432]
ldr.w r4, [r1, #28]
ldr.w r5, [r1, #380]
ldr.w r6, [r1, #732]
ldr.w r7, [r1, #1084]
str.w r7, [sp, #1788]
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
str.w ip, [sp, #380]
str.w r9, [sp, #732]
str.w sl, [sp, #1084]
str.w r7, [sp, #1436]
ldr.w r4, [r2, #28]
ldr.w r5, [r2, #380]
ldr.w r6, [r2, #732]
ldr.w r7, [r2, #1084]
str.w r7, [r3, #1788]
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
str.w ip, [r3, #380]
str.w r9, [r3, #732]
str.w sl, [r3, #1084]
str.w r7, [r3, #1436]
ldr.w r4, [r1, #32]
ldr.w r5, [r1, #384]
ldr.w r6, [r1, #736]
ldr.w r7, [r1, #1088]
str.w r7, [sp, #1792]
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
str.w ip, [sp, #384]
str.w r9, [sp, #736]
str.w sl, [sp, #1088]
str.w r7, [sp, #1440]
ldr.w r4, [r2, #32]
ldr.w r5, [r2, #384]
ldr.w r6, [r2, #736]
ldr.w r7, [r2, #1088]
str.w r7, [r3, #1792]
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
str.w ip, [r3, #384]
str.w r9, [r3, #736]
str.w sl, [r3, #1088]
str.w r7, [r3, #1440]
ldr.w r4, [r1, #36]
ldr.w r5, [r1, #388]
ldr.w r6, [r1, #740]
ldr.w r7, [r1, #1092]
str.w r7, [sp, #1796]
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
str.w ip, [sp, #388]
str.w r9, [sp, #740]
str.w sl, [sp, #1092]
str.w r7, [sp, #1444]
ldr.w r4, [r2, #36]
ldr.w r5, [r2, #388]
ldr.w r6, [r2, #740]
ldr.w r7, [r2, #1092]
str.w r7, [r3, #1796]
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
str.w ip, [r3, #388]
str.w r9, [r3, #740]
str.w sl, [r3, #1092]
str.w r7, [r3, #1444]
ldr.w r4, [r1, #40]
ldr.w r5, [r1, #392]
ldr.w r6, [r1, #744]
ldr.w r7, [r1, #1096]
str.w r7, [sp, #1800]
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
str.w ip, [sp, #392]
str.w r9, [sp, #744]
str.w sl, [sp, #1096]
str.w r7, [sp, #1448]
ldr.w r4, [r2, #40]
ldr.w r5, [r2, #392]
ldr.w r6, [r2, #744]
ldr.w r7, [r2, #1096]
str.w r7, [r3, #1800]
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
str.w ip, [r3, #392]
str.w r9, [r3, #744]
str.w sl, [r3, #1096]
str.w r7, [r3, #1448]
ldr.w r4, [r1, #44]
ldr.w r5, [r1, #396]
ldr.w r6, [r1, #748]
ldr.w r7, [r1, #1100]
str.w r7, [sp, #1804]
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
str.w ip, [sp, #396]
str.w r9, [sp, #748]
str.w sl, [sp, #1100]
str.w r7, [sp, #1452]
ldr.w r4, [r2, #44]
ldr.w r5, [r2, #396]
ldr.w r6, [r2, #748]
ldr.w r7, [r2, #1100]
str.w r7, [r3, #1804]
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
str.w ip, [r3, #396]
str.w r9, [r3, #748]
str.w sl, [r3, #1100]
str.w r7, [r3, #1452]
ldr.w r4, [r1, #48]
ldr.w r5, [r1, #400]
ldr.w r6, [r1, #752]
ldr.w r7, [r1, #1104]
str.w r7, [sp, #1808]
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
str.w ip, [sp, #400]
str.w r9, [sp, #752]
str.w sl, [sp, #1104]
str.w r7, [sp, #1456]
ldr.w r4, [r2, #48]
ldr.w r5, [r2, #400]
ldr.w r6, [r2, #752]
ldr.w r7, [r2, #1104]
str.w r7, [r3, #1808]
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
str.w ip, [r3, #400]
str.w r9, [r3, #752]
str.w sl, [r3, #1104]
str.w r7, [r3, #1456]
ldr.w r4, [r1, #52]
ldr.w r5, [r1, #404]
ldr.w r6, [r1, #756]
ldr.w r7, [r1, #1108]
str.w r7, [sp, #1812]
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
str.w ip, [sp, #404]
str.w r9, [sp, #756]
str.w sl, [sp, #1108]
str.w r7, [sp, #1460]
ldr.w r4, [r2, #52]
ldr.w r5, [r2, #404]
ldr.w r6, [r2, #756]
ldr.w r7, [r2, #1108]
str.w r7, [r3, #1812]
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
str.w ip, [r3, #404]
str.w r9, [r3, #756]
str.w sl, [r3, #1108]
str.w r7, [r3, #1460]
ldr.w r4, [r1, #56]
ldr.w r5, [r1, #408]
ldr.w r6, [r1, #760]
ldr.w r7, [r1, #1112]
str.w r7, [sp, #1816]
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
str.w ip, [sp, #408]
str.w r9, [sp, #760]
str.w sl, [sp, #1112]
str.w r7, [sp, #1464]
ldr.w r4, [r2, #56]
ldr.w r5, [r2, #408]
ldr.w r6, [r2, #760]
ldr.w r7, [r2, #1112]
str.w r7, [r3, #1816]
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
str.w ip, [r3, #408]
str.w r9, [r3, #760]
str.w sl, [r3, #1112]
str.w r7, [r3, #1464]
ldr.w r4, [r1, #60]
ldr.w r5, [r1, #412]
ldr.w r6, [r1, #764]
ldr.w r7, [r1, #1116]
str.w r7, [sp, #1820]
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
str.w ip, [sp, #412]
str.w r9, [sp, #764]
str.w sl, [sp, #1116]
str.w r7, [sp, #1468]
ldr.w r4, [r2, #60]
ldr.w r5, [r2, #412]
ldr.w r6, [r2, #764]
ldr.w r7, [r2, #1116]
str.w r7, [r3, #1820]
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
str.w ip, [r3, #412]
str.w r9, [r3, #764]
str.w sl, [r3, #1116]
str.w r7, [r3, #1468]
ldr.w r4, [r1, #64]
ldr.w r5, [r1, #416]
ldr.w r6, [r1, #768]
ldr.w r7, [r1, #1120]
str.w r7, [sp, #1824]
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
str.w ip, [sp, #416]
str.w r9, [sp, #768]
str.w sl, [sp, #1120]
str.w r7, [sp, #1472]
ldr.w r4, [r2, #64]
ldr.w r5, [r2, #416]
ldr.w r6, [r2, #768]
ldr.w r7, [r2, #1120]
str.w r7, [r3, #1824]
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
str.w ip, [r3, #416]
str.w r9, [r3, #768]
str.w sl, [r3, #1120]
str.w r7, [r3, #1472]
ldr.w r4, [r1, #68]
ldr.w r5, [r1, #420]
ldr.w r6, [r1, #772]
ldr.w r7, [r1, #1124]
str.w r7, [sp, #1828]
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
str.w ip, [sp, #420]
str.w r9, [sp, #772]
str.w sl, [sp, #1124]
str.w r7, [sp, #1476]
ldr.w r4, [r2, #68]
ldr.w r5, [r2, #420]
ldr.w r6, [r2, #772]
ldr.w r7, [r2, #1124]
str.w r7, [r3, #1828]
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
str.w ip, [r3, #420]
str.w r9, [r3, #772]
str.w sl, [r3, #1124]
str.w r7, [r3, #1476]
ldr.w r4, [r1, #72]
ldr.w r5, [r1, #424]
ldr.w r6, [r1, #776]
ldr.w r7, [r1, #1128]
str.w r7, [sp, #1832]
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
str.w ip, [sp, #424]
str.w r9, [sp, #776]
str.w sl, [sp, #1128]
str.w r7, [sp, #1480]
ldr.w r4, [r2, #72]
ldr.w r5, [r2, #424]
ldr.w r6, [r2, #776]
ldr.w r7, [r2, #1128]
str.w r7, [r3, #1832]
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
str.w ip, [r3, #424]
str.w r9, [r3, #776]
str.w sl, [r3, #1128]
str.w r7, [r3, #1480]
ldr.w r4, [r1, #76]
ldr.w r5, [r1, #428]
ldr.w r6, [r1, #780]
ldr.w r7, [r1, #1132]
str.w r7, [sp, #1836]
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
str.w ip, [sp, #428]
str.w r9, [sp, #780]
str.w sl, [sp, #1132]
str.w r7, [sp, #1484]
ldr.w r4, [r2, #76]
ldr.w r5, [r2, #428]
ldr.w r6, [r2, #780]
ldr.w r7, [r2, #1132]
str.w r7, [r3, #1836]
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
str.w ip, [r3, #428]
str.w r9, [r3, #780]
str.w sl, [r3, #1132]
str.w r7, [r3, #1484]
ldr.w r4, [r1, #80]
ldr.w r5, [r1, #432]
ldr.w r6, [r1, #784]
ldr.w r7, [r1, #1136]
str.w r7, [sp, #1840]
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
str.w ip, [sp, #432]
str.w r9, [sp, #784]
str.w sl, [sp, #1136]
str.w r7, [sp, #1488]
ldr.w r4, [r2, #80]
ldr.w r5, [r2, #432]
ldr.w r6, [r2, #784]
ldr.w r7, [r2, #1136]
str.w r7, [r3, #1840]
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
str.w ip, [r3, #432]
str.w r9, [r3, #784]
str.w sl, [r3, #1136]
str.w r7, [r3, #1488]
ldr.w r4, [r1, #84]
ldr.w r5, [r1, #436]
ldr.w r6, [r1, #788]
ldr.w r7, [r1, #1140]
str.w r7, [sp, #1844]
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
str.w ip, [sp, #436]
str.w r9, [sp, #788]
str.w sl, [sp, #1140]
str.w r7, [sp, #1492]
ldr.w r4, [r2, #84]
ldr.w r5, [r2, #436]
ldr.w r6, [r2, #788]
ldr.w r7, [r2, #1140]
str.w r7, [r3, #1844]
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
str.w ip, [r3, #436]
str.w r9, [r3, #788]
str.w sl, [r3, #1140]
str.w r7, [r3, #1492]
ldr.w r4, [r1, #88]
ldr.w r5, [r1, #440]
ldr.w r6, [r1, #792]
ldr.w r7, [r1, #1144]
str.w r7, [sp, #1848]
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
str.w ip, [sp, #440]
str.w r9, [sp, #792]
str.w sl, [sp, #1144]
str.w r7, [sp, #1496]
ldr.w r4, [r2, #88]
ldr.w r5, [r2, #440]
ldr.w r6, [r2, #792]
ldr.w r7, [r2, #1144]
str.w r7, [r3, #1848]
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
str.w ip, [r3, #440]
str.w r9, [r3, #792]
str.w sl, [r3, #1144]
str.w r7, [r3, #1496]
ldr.w r4, [r1, #92]
ldr.w r5, [r1, #444]
ldr.w r6, [r1, #796]
ldr.w r7, [r1, #1148]
str.w r7, [sp, #1852]
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
str.w ip, [sp, #444]
str.w r9, [sp, #796]
str.w sl, [sp, #1148]
str.w r7, [sp, #1500]
ldr.w r4, [r2, #92]
ldr.w r5, [r2, #444]
ldr.w r6, [r2, #796]
ldr.w r7, [r2, #1148]
str.w r7, [r3, #1852]
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
str.w ip, [r3, #444]
str.w r9, [r3, #796]
str.w sl, [r3, #1148]
str.w r7, [r3, #1500]
ldr.w r4, [r1, #96]
ldr.w r5, [r1, #448]
ldr.w r6, [r1, #800]
ldr.w r7, [r1, #1152]
str.w r7, [sp, #1856]
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
str.w ip, [sp, #448]
str.w r9, [sp, #800]
str.w sl, [sp, #1152]
str.w r7, [sp, #1504]
ldr.w r4, [r2, #96]
ldr.w r5, [r2, #448]
ldr.w r6, [r2, #800]
ldr.w r7, [r2, #1152]
str.w r7, [r3, #1856]
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
str.w ip, [r3, #448]
str.w r9, [r3, #800]
str.w sl, [r3, #1152]
str.w r7, [r3, #1504]
ldr.w r4, [r1, #100]
ldr.w r5, [r1, #452]
ldr.w r6, [r1, #804]
ldr.w r7, [r1, #1156]
str.w r7, [sp, #1860]
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
str.w ip, [sp, #452]
str.w r9, [sp, #804]
str.w sl, [sp, #1156]
str.w r7, [sp, #1508]
ldr.w r4, [r2, #100]
ldr.w r5, [r2, #452]
ldr.w r6, [r2, #804]
ldr.w r7, [r2, #1156]
str.w r7, [r3, #1860]
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
str.w ip, [r3, #452]
str.w r9, [r3, #804]
str.w sl, [r3, #1156]
str.w r7, [r3, #1508]
ldr.w r4, [r1, #104]
ldr.w r5, [r1, #456]
ldr.w r6, [r1, #808]
ldr.w r7, [r1, #1160]
str.w r7, [sp, #1864]
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
str.w ip, [sp, #456]
str.w r9, [sp, #808]
str.w sl, [sp, #1160]
str.w r7, [sp, #1512]
ldr.w r4, [r2, #104]
ldr.w r5, [r2, #456]
ldr.w r6, [r2, #808]
ldr.w r7, [r2, #1160]
str.w r7, [r3, #1864]
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
str.w ip, [r3, #456]
str.w r9, [r3, #808]
str.w sl, [r3, #1160]
str.w r7, [r3, #1512]
ldr.w r4, [r1, #108]
ldr.w r5, [r1, #460]
ldr.w r6, [r1, #812]
ldr.w r7, [r1, #1164]
str.w r7, [sp, #1868]
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
str.w ip, [sp, #460]
str.w r9, [sp, #812]
str.w sl, [sp, #1164]
str.w r7, [sp, #1516]
ldr.w r4, [r2, #108]
ldr.w r5, [r2, #460]
ldr.w r6, [r2, #812]
ldr.w r7, [r2, #1164]
str.w r7, [r3, #1868]
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
str.w ip, [r3, #460]
str.w r9, [r3, #812]
str.w sl, [r3, #1164]
str.w r7, [r3, #1516]
ldr.w r4, [r1, #112]
ldr.w r5, [r1, #464]
ldr.w r6, [r1, #816]
ldr.w r7, [r1, #1168]
str.w r7, [sp, #1872]
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
str.w ip, [sp, #464]
str.w r9, [sp, #816]
str.w sl, [sp, #1168]
str.w r7, [sp, #1520]
ldr.w r4, [r2, #112]
ldr.w r5, [r2, #464]
ldr.w r6, [r2, #816]
ldr.w r7, [r2, #1168]
str.w r7, [r3, #1872]
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
str.w ip, [r3, #464]
str.w r9, [r3, #816]
str.w sl, [r3, #1168]
str.w r7, [r3, #1520]
ldr.w r4, [r1, #116]
ldr.w r5, [r1, #468]
ldr.w r6, [r1, #820]
ldr.w r7, [r1, #1172]
str.w r7, [sp, #1876]
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
str.w ip, [sp, #468]
str.w r9, [sp, #820]
str.w sl, [sp, #1172]
str.w r7, [sp, #1524]
ldr.w r4, [r2, #116]
ldr.w r5, [r2, #468]
ldr.w r6, [r2, #820]
ldr.w r7, [r2, #1172]
str.w r7, [r3, #1876]
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
str.w ip, [r3, #468]
str.w r9, [r3, #820]
str.w sl, [r3, #1172]
str.w r7, [r3, #1524]
ldr.w r4, [r1, #120]
ldr.w r5, [r1, #472]
ldr.w r6, [r1, #824]
ldr.w r7, [r1, #1176]
str.w r7, [sp, #1880]
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
str.w ip, [sp, #472]
str.w r9, [sp, #824]
str.w sl, [sp, #1176]
str.w r7, [sp, #1528]
ldr.w r4, [r2, #120]
ldr.w r5, [r2, #472]
ldr.w r6, [r2, #824]
ldr.w r7, [r2, #1176]
str.w r7, [r3, #1880]
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
str.w ip, [r3, #472]
str.w r9, [r3, #824]
str.w sl, [r3, #1176]
str.w r7, [r3, #1528]
ldr.w r4, [r1, #124]
ldr.w r5, [r1, #476]
ldr.w r6, [r1, #828]
ldr.w r7, [r1, #1180]
str.w r7, [sp, #1884]
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
str.w ip, [sp, #476]
str.w r9, [sp, #828]
str.w sl, [sp, #1180]
str.w r7, [sp, #1532]
ldr.w r4, [r2, #124]
ldr.w r5, [r2, #476]
ldr.w r6, [r2, #828]
ldr.w r7, [r2, #1180]
str.w r7, [r3, #1884]
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
str.w ip, [r3, #476]
str.w r9, [r3, #828]
str.w sl, [r3, #1180]
str.w r7, [r3, #1532]
ldr.w r4, [r1, #128]
ldr.w r5, [r1, #480]
ldr.w r6, [r1, #832]
ldr.w r7, [r1, #1184]
str.w r7, [sp, #1888]
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
str.w fp, [sp, #128]
str.w ip, [sp, #480]
str.w r9, [sp, #832]
str.w sl, [sp, #1184]
str.w r7, [sp, #1536]
ldr.w r4, [r2, #128]
ldr.w r5, [r2, #480]
ldr.w r6, [r2, #832]
ldr.w r7, [r2, #1184]
str.w r7, [r3, #1888]
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
str.w fp, [r3, #128]
str.w ip, [r3, #480]
str.w r9, [r3, #832]
str.w sl, [r3, #1184]
str.w r7, [r3, #1536]
ldr.w r4, [r1, #132]
ldr.w r5, [r1, #484]
ldr.w r6, [r1, #836]
ldr.w r7, [r1, #1188]
str.w r7, [sp, #1892]
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
str.w fp, [sp, #132]
str.w ip, [sp, #484]
str.w r9, [sp, #836]
str.w sl, [sp, #1188]
str.w r7, [sp, #1540]
ldr.w r4, [r2, #132]
ldr.w r5, [r2, #484]
ldr.w r6, [r2, #836]
ldr.w r7, [r2, #1188]
str.w r7, [r3, #1892]
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
str.w fp, [r3, #132]
str.w ip, [r3, #484]
str.w r9, [r3, #836]
str.w sl, [r3, #1188]
str.w r7, [r3, #1540]
ldr.w r4, [r1, #136]
ldr.w r5, [r1, #488]
ldr.w r6, [r1, #840]
ldr.w r7, [r1, #1192]
str.w r7, [sp, #1896]
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
str.w fp, [sp, #136]
str.w ip, [sp, #488]
str.w r9, [sp, #840]
str.w sl, [sp, #1192]
str.w r7, [sp, #1544]
ldr.w r4, [r2, #136]
ldr.w r5, [r2, #488]
ldr.w r6, [r2, #840]
ldr.w r7, [r2, #1192]
str.w r7, [r3, #1896]
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
str.w fp, [r3, #136]
str.w ip, [r3, #488]
str.w r9, [r3, #840]
str.w sl, [r3, #1192]
str.w r7, [r3, #1544]
ldr.w r4, [r1, #140]
ldr.w r5, [r1, #492]
ldr.w r6, [r1, #844]
ldr.w r7, [r1, #1196]
str.w r7, [sp, #1900]
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
str.w fp, [sp, #140]
str.w ip, [sp, #492]
str.w r9, [sp, #844]
str.w sl, [sp, #1196]
str.w r7, [sp, #1548]
ldr.w r4, [r2, #140]
ldr.w r5, [r2, #492]
ldr.w r6, [r2, #844]
ldr.w r7, [r2, #1196]
str.w r7, [r3, #1900]
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
str.w fp, [r3, #140]
str.w ip, [r3, #492]
str.w r9, [r3, #844]
str.w sl, [r3, #1196]
str.w r7, [r3, #1548]
ldr.w r4, [r1, #144]
ldr.w r5, [r1, #496]
ldr.w r6, [r1, #848]
ldr.w r7, [r1, #1200]
str.w r7, [sp, #1904]
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
str.w fp, [sp, #144]
str.w ip, [sp, #496]
str.w r9, [sp, #848]
str.w sl, [sp, #1200]
str.w r7, [sp, #1552]
ldr.w r4, [r2, #144]
ldr.w r5, [r2, #496]
ldr.w r6, [r2, #848]
ldr.w r7, [r2, #1200]
str.w r7, [r3, #1904]
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
str.w fp, [r3, #144]
str.w ip, [r3, #496]
str.w r9, [r3, #848]
str.w sl, [r3, #1200]
str.w r7, [r3, #1552]
ldr.w r4, [r1, #148]
ldr.w r5, [r1, #500]
ldr.w r6, [r1, #852]
ldr.w r7, [r1, #1204]
str.w r7, [sp, #1908]
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
str.w fp, [sp, #148]
str.w ip, [sp, #500]
str.w r9, [sp, #852]
str.w sl, [sp, #1204]
str.w r7, [sp, #1556]
ldr.w r4, [r2, #148]
ldr.w r5, [r2, #500]
ldr.w r6, [r2, #852]
ldr.w r7, [r2, #1204]
str.w r7, [r3, #1908]
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
str.w fp, [r3, #148]
str.w ip, [r3, #500]
str.w r9, [r3, #852]
str.w sl, [r3, #1204]
str.w r7, [r3, #1556]
ldr.w r4, [r1, #152]
ldr.w r5, [r1, #504]
ldr.w r6, [r1, #856]
ldr.w r7, [r1, #1208]
str.w r7, [sp, #1912]
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
str.w fp, [sp, #152]
str.w ip, [sp, #504]
str.w r9, [sp, #856]
str.w sl, [sp, #1208]
str.w r7, [sp, #1560]
ldr.w r4, [r2, #152]
ldr.w r5, [r2, #504]
ldr.w r6, [r2, #856]
ldr.w r7, [r2, #1208]
str.w r7, [r3, #1912]
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
str.w fp, [r3, #152]
str.w ip, [r3, #504]
str.w r9, [r3, #856]
str.w sl, [r3, #1208]
str.w r7, [r3, #1560]
ldr.w r4, [r1, #156]
ldr.w r5, [r1, #508]
ldr.w r6, [r1, #860]
ldr.w r7, [r1, #1212]
str.w r7, [sp, #1916]
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
str.w fp, [sp, #156]
str.w ip, [sp, #508]
str.w r9, [sp, #860]
str.w sl, [sp, #1212]
str.w r7, [sp, #1564]
ldr.w r4, [r2, #156]
ldr.w r5, [r2, #508]
ldr.w r6, [r2, #860]
ldr.w r7, [r2, #1212]
str.w r7, [r3, #1916]
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
str.w fp, [r3, #156]
str.w ip, [r3, #508]
str.w r9, [r3, #860]
str.w sl, [r3, #1212]
str.w r7, [r3, #1564]
ldr.w r4, [r1, #160]
ldr.w r5, [r1, #512]
ldr.w r6, [r1, #864]
ldr.w r7, [r1, #1216]
str.w r7, [sp, #1920]
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
str.w fp, [sp, #160]
str.w ip, [sp, #512]
str.w r9, [sp, #864]
str.w sl, [sp, #1216]
str.w r7, [sp, #1568]
ldr.w r4, [r2, #160]
ldr.w r5, [r2, #512]
ldr.w r6, [r2, #864]
ldr.w r7, [r2, #1216]
str.w r7, [r3, #1920]
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
str.w fp, [r3, #160]
str.w ip, [r3, #512]
str.w r9, [r3, #864]
str.w sl, [r3, #1216]
str.w r7, [r3, #1568]
ldr.w r4, [r1, #164]
ldr.w r5, [r1, #516]
ldr.w r6, [r1, #868]
ldr.w r7, [r1, #1220]
str.w r7, [sp, #1924]
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
str.w fp, [sp, #164]
str.w ip, [sp, #516]
str.w r9, [sp, #868]
str.w sl, [sp, #1220]
str.w r7, [sp, #1572]
ldr.w r4, [r2, #164]
ldr.w r5, [r2, #516]
ldr.w r6, [r2, #868]
ldr.w r7, [r2, #1220]
str.w r7, [r3, #1924]
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
str.w fp, [r3, #164]
str.w ip, [r3, #516]
str.w r9, [r3, #868]
str.w sl, [r3, #1220]
str.w r7, [r3, #1572]
ldr.w r4, [r1, #168]
ldr.w r5, [r1, #520]
ldr.w r6, [r1, #872]
ldr.w r7, [r1, #1224]
str.w r7, [sp, #1928]
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
str.w fp, [sp, #168]
str.w ip, [sp, #520]
str.w r9, [sp, #872]
str.w sl, [sp, #1224]
str.w r7, [sp, #1576]
ldr.w r4, [r2, #168]
ldr.w r5, [r2, #520]
ldr.w r6, [r2, #872]
ldr.w r7, [r2, #1224]
str.w r7, [r3, #1928]
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
str.w fp, [r3, #168]
str.w ip, [r3, #520]
str.w r9, [r3, #872]
str.w sl, [r3, #1224]
str.w r7, [r3, #1576]
ldr.w r4, [r1, #172]
ldr.w r5, [r1, #524]
ldr.w r6, [r1, #876]
ldr.w r7, [r1, #1228]
str.w r7, [sp, #1932]
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
str.w fp, [sp, #172]
str.w ip, [sp, #524]
str.w r9, [sp, #876]
str.w sl, [sp, #1228]
str.w r7, [sp, #1580]
ldr.w r4, [r2, #172]
ldr.w r5, [r2, #524]
ldr.w r6, [r2, #876]
ldr.w r7, [r2, #1228]
str.w r7, [r3, #1932]
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
str.w fp, [r3, #172]
str.w ip, [r3, #524]
str.w r9, [r3, #876]
str.w sl, [r3, #1228]
str.w r7, [r3, #1580]
ldr.w r4, [r1, #176]
ldr.w r5, [r1, #528]
ldr.w r6, [r1, #880]
ldr.w r7, [r1, #1232]
str.w r7, [sp, #1936]
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
str.w fp, [sp, #176]
str.w ip, [sp, #528]
str.w r9, [sp, #880]
str.w sl, [sp, #1232]
str.w r7, [sp, #1584]
ldr.w r4, [r2, #176]
ldr.w r5, [r2, #528]
ldr.w r6, [r2, #880]
ldr.w r7, [r2, #1232]
str.w r7, [r3, #1936]
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
str.w fp, [r3, #176]
str.w ip, [r3, #528]
str.w r9, [r3, #880]
str.w sl, [r3, #1232]
str.w r7, [r3, #1584]
ldr.w r4, [r1, #180]
ldr.w r5, [r1, #532]
ldr.w r6, [r1, #884]
ldr.w r7, [r1, #1236]
str.w r7, [sp, #1940]
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
str.w fp, [sp, #180]
str.w ip, [sp, #532]
str.w r9, [sp, #884]
str.w sl, [sp, #1236]
str.w r7, [sp, #1588]
ldr.w r4, [r2, #180]
ldr.w r5, [r2, #532]
ldr.w r6, [r2, #884]
ldr.w r7, [r2, #1236]
str.w r7, [r3, #1940]
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
str.w fp, [r3, #180]
str.w ip, [r3, #532]
str.w r9, [r3, #884]
str.w sl, [r3, #1236]
str.w r7, [r3, #1588]
ldr.w r4, [r1, #184]
ldr.w r5, [r1, #536]
ldr.w r6, [r1, #888]
ldr.w r7, [r1, #1240]
str.w r7, [sp, #1944]
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
str.w fp, [sp, #184]
str.w ip, [sp, #536]
str.w r9, [sp, #888]
str.w sl, [sp, #1240]
str.w r7, [sp, #1592]
ldr.w r4, [r2, #184]
ldr.w r5, [r2, #536]
ldr.w r6, [r2, #888]
ldr.w r7, [r2, #1240]
str.w r7, [r3, #1944]
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
str.w fp, [r3, #184]
str.w ip, [r3, #536]
str.w r9, [r3, #888]
str.w sl, [r3, #1240]
str.w r7, [r3, #1592]
ldr.w r4, [r1, #188]
ldr.w r5, [r1, #540]
ldr.w r6, [r1, #892]
ldr.w r7, [r1, #1244]
str.w r7, [sp, #1948]
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
str.w fp, [sp, #188]
str.w ip, [sp, #540]
str.w r9, [sp, #892]
str.w sl, [sp, #1244]
str.w r7, [sp, #1596]
ldr.w r4, [r2, #188]
ldr.w r5, [r2, #540]
ldr.w r6, [r2, #892]
ldr.w r7, [r2, #1244]
str.w r7, [r3, #1948]
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
str.w fp, [r3, #188]
str.w ip, [r3, #540]
str.w r9, [r3, #892]
str.w sl, [r3, #1244]
str.w r7, [r3, #1596]
ldr.w r4, [r1, #192]
ldr.w r5, [r1, #544]
ldr.w r6, [r1, #896]
ldr.w r7, [r1, #1248]
str.w r7, [sp, #1952]
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
str.w fp, [sp, #192]
str.w ip, [sp, #544]
str.w r9, [sp, #896]
str.w sl, [sp, #1248]
str.w r7, [sp, #1600]
ldr.w r4, [r2, #192]
ldr.w r5, [r2, #544]
ldr.w r6, [r2, #896]
ldr.w r7, [r2, #1248]
str.w r7, [r3, #1952]
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
str.w fp, [r3, #192]
str.w ip, [r3, #544]
str.w r9, [r3, #896]
str.w sl, [r3, #1248]
str.w r7, [r3, #1600]
ldr.w r4, [r1, #196]
ldr.w r5, [r1, #548]
ldr.w r6, [r1, #900]
ldr.w r7, [r1, #1252]
str.w r7, [sp, #1956]
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
str.w fp, [sp, #196]
str.w ip, [sp, #548]
str.w r9, [sp, #900]
str.w sl, [sp, #1252]
str.w r7, [sp, #1604]
ldr.w r4, [r2, #196]
ldr.w r5, [r2, #548]
ldr.w r6, [r2, #900]
ldr.w r7, [r2, #1252]
str.w r7, [r3, #1956]
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
str.w fp, [r3, #196]
str.w ip, [r3, #548]
str.w r9, [r3, #900]
str.w sl, [r3, #1252]
str.w r7, [r3, #1604]
ldr.w r4, [r1, #200]
ldr.w r5, [r1, #552]
ldr.w r6, [r1, #904]
ldr.w r7, [r1, #1256]
str.w r7, [sp, #1960]
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
str.w fp, [sp, #200]
str.w ip, [sp, #552]
str.w r9, [sp, #904]
str.w sl, [sp, #1256]
str.w r7, [sp, #1608]
ldr.w r4, [r2, #200]
ldr.w r5, [r2, #552]
ldr.w r6, [r2, #904]
ldr.w r7, [r2, #1256]
str.w r7, [r3, #1960]
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
str.w fp, [r3, #200]
str.w ip, [r3, #552]
str.w r9, [r3, #904]
str.w sl, [r3, #1256]
str.w r7, [r3, #1608]
ldr.w r4, [r1, #204]
ldr.w r5, [r1, #556]
ldr.w r6, [r1, #908]
ldr.w r7, [r1, #1260]
str.w r7, [sp, #1964]
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
str.w fp, [sp, #204]
str.w ip, [sp, #556]
str.w r9, [sp, #908]
str.w sl, [sp, #1260]
str.w r7, [sp, #1612]
ldr.w r4, [r2, #204]
ldr.w r5, [r2, #556]
ldr.w r6, [r2, #908]
ldr.w r7, [r2, #1260]
str.w r7, [r3, #1964]
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
str.w fp, [r3, #204]
str.w ip, [r3, #556]
str.w r9, [r3, #908]
str.w sl, [r3, #1260]
str.w r7, [r3, #1612]
ldr.w r4, [r1, #208]
ldr.w r5, [r1, #560]
ldr.w r6, [r1, #912]
ldr.w r7, [r1, #1264]
str.w r7, [sp, #1968]
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
str.w fp, [sp, #208]
str.w ip, [sp, #560]
str.w r9, [sp, #912]
str.w sl, [sp, #1264]
str.w r7, [sp, #1616]
ldr.w r4, [r2, #208]
ldr.w r5, [r2, #560]
ldr.w r6, [r2, #912]
ldr.w r7, [r2, #1264]
str.w r7, [r3, #1968]
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
str.w fp, [r3, #208]
str.w ip, [r3, #560]
str.w r9, [r3, #912]
str.w sl, [r3, #1264]
str.w r7, [r3, #1616]
ldr.w r4, [r1, #212]
ldr.w r5, [r1, #564]
ldr.w r6, [r1, #916]
ldr.w r7, [r1, #1268]
str.w r7, [sp, #1972]
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
str.w fp, [sp, #212]
str.w ip, [sp, #564]
str.w r9, [sp, #916]
str.w sl, [sp, #1268]
str.w r7, [sp, #1620]
ldr.w r4, [r2, #212]
ldr.w r5, [r2, #564]
ldr.w r6, [r2, #916]
ldr.w r7, [r2, #1268]
str.w r7, [r3, #1972]
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
str.w fp, [r3, #212]
str.w ip, [r3, #564]
str.w r9, [r3, #916]
str.w sl, [r3, #1268]
str.w r7, [r3, #1620]
ldr.w r4, [r1, #216]
ldr.w r5, [r1, #568]
ldr.w r6, [r1, #920]
ldr.w r7, [r1, #1272]
str.w r7, [sp, #1976]
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
str.w fp, [sp, #216]
str.w ip, [sp, #568]
str.w r9, [sp, #920]
str.w sl, [sp, #1272]
str.w r7, [sp, #1624]
ldr.w r4, [r2, #216]
ldr.w r5, [r2, #568]
ldr.w r6, [r2, #920]
ldr.w r7, [r2, #1272]
str.w r7, [r3, #1976]
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
str.w fp, [r3, #216]
str.w ip, [r3, #568]
str.w r9, [r3, #920]
str.w sl, [r3, #1272]
str.w r7, [r3, #1624]
ldr.w r4, [r1, #220]
ldr.w r5, [r1, #572]
ldr.w r6, [r1, #924]
ldr.w r7, [r1, #1276]
str.w r7, [sp, #1980]
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
str.w fp, [sp, #220]
str.w ip, [sp, #572]
str.w r9, [sp, #924]
str.w sl, [sp, #1276]
str.w r7, [sp, #1628]
ldr.w r4, [r2, #220]
ldr.w r5, [r2, #572]
ldr.w r6, [r2, #924]
ldr.w r7, [r2, #1276]
str.w r7, [r3, #1980]
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
str.w fp, [r3, #220]
str.w ip, [r3, #572]
str.w r9, [r3, #924]
str.w sl, [r3, #1276]
str.w r7, [r3, #1628]
ldr.w r4, [r1, #224]
ldr.w r5, [r1, #576]
ldr.w r6, [r1, #928]
ldr.w r7, [r1, #1280]
str.w r7, [sp, #1984]
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
str.w fp, [sp, #224]
str.w ip, [sp, #576]
str.w r9, [sp, #928]
str.w sl, [sp, #1280]
str.w r7, [sp, #1632]
ldr.w r4, [r2, #224]
ldr.w r5, [r2, #576]
ldr.w r6, [r2, #928]
ldr.w r7, [r2, #1280]
str.w r7, [r3, #1984]
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
str.w fp, [r3, #224]
str.w ip, [r3, #576]
str.w r9, [r3, #928]
str.w sl, [r3, #1280]
str.w r7, [r3, #1632]
ldr.w r4, [r1, #228]
ldr.w r5, [r1, #580]
ldr.w r6, [r1, #932]
ldr.w r7, [r1, #1284]
str.w r7, [sp, #1988]
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
str.w fp, [sp, #228]
str.w ip, [sp, #580]
str.w r9, [sp, #932]
str.w sl, [sp, #1284]
str.w r7, [sp, #1636]
ldr.w r4, [r2, #228]
ldr.w r5, [r2, #580]
ldr.w r6, [r2, #932]
ldr.w r7, [r2, #1284]
str.w r7, [r3, #1988]
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
str.w fp, [r3, #228]
str.w ip, [r3, #580]
str.w r9, [r3, #932]
str.w sl, [r3, #1284]
str.w r7, [r3, #1636]
ldr.w r4, [r1, #232]
ldr.w r5, [r1, #584]
ldr.w r6, [r1, #936]
ldr.w r7, [r1, #1288]
str.w r7, [sp, #1992]
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
str.w fp, [sp, #232]
str.w ip, [sp, #584]
str.w r9, [sp, #936]
str.w sl, [sp, #1288]
str.w r7, [sp, #1640]
ldr.w r4, [r2, #232]
ldr.w r5, [r2, #584]
ldr.w r6, [r2, #936]
ldr.w r7, [r2, #1288]
str.w r7, [r3, #1992]
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
str.w fp, [r3, #232]
str.w ip, [r3, #584]
str.w r9, [r3, #936]
str.w sl, [r3, #1288]
str.w r7, [r3, #1640]
ldr.w r4, [r1, #236]
ldr.w r5, [r1, #588]
ldr.w r6, [r1, #940]
ldr.w r7, [r1, #1292]
str.w r7, [sp, #1996]
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
str.w fp, [sp, #236]
str.w ip, [sp, #588]
str.w r9, [sp, #940]
str.w sl, [sp, #1292]
str.w r7, [sp, #1644]
ldr.w r4, [r2, #236]
ldr.w r5, [r2, #588]
ldr.w r6, [r2, #940]
ldr.w r7, [r2, #1292]
str.w r7, [r3, #1996]
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
str.w fp, [r3, #236]
str.w ip, [r3, #588]
str.w r9, [r3, #940]
str.w sl, [r3, #1292]
str.w r7, [r3, #1644]
ldr.w r4, [r1, #240]
ldr.w r5, [r1, #592]
ldr.w r6, [r1, #944]
ldr.w r7, [r1, #1296]
str.w r7, [sp, #2000]
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
str.w fp, [sp, #240]
str.w ip, [sp, #592]
str.w r9, [sp, #944]
str.w sl, [sp, #1296]
str.w r7, [sp, #1648]
ldr.w r4, [r2, #240]
ldr.w r5, [r2, #592]
ldr.w r6, [r2, #944]
ldr.w r7, [r2, #1296]
str.w r7, [r3, #2000]
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
str.w fp, [r3, #240]
str.w ip, [r3, #592]
str.w r9, [r3, #944]
str.w sl, [r3, #1296]
str.w r7, [r3, #1648]
ldr.w r4, [r1, #244]
ldr.w r5, [r1, #596]
ldr.w r6, [r1, #948]
ldr.w r7, [r1, #1300]
str.w r7, [sp, #2004]
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
str.w fp, [sp, #244]
str.w ip, [sp, #596]
str.w r9, [sp, #948]
str.w sl, [sp, #1300]
str.w r7, [sp, #1652]
ldr.w r4, [r2, #244]
ldr.w r5, [r2, #596]
ldr.w r6, [r2, #948]
ldr.w r7, [r2, #1300]
str.w r7, [r3, #2004]
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
str.w fp, [r3, #244]
str.w ip, [r3, #596]
str.w r9, [r3, #948]
str.w sl, [r3, #1300]
str.w r7, [r3, #1652]
ldr.w r4, [r1, #248]
ldr.w r5, [r1, #600]
ldr.w r6, [r1, #952]
ldr.w r7, [r1, #1304]
str.w r7, [sp, #2008]
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
str.w fp, [sp, #248]
str.w ip, [sp, #600]
str.w r9, [sp, #952]
str.w sl, [sp, #1304]
str.w r7, [sp, #1656]
ldr.w r4, [r2, #248]
ldr.w r5, [r2, #600]
ldr.w r6, [r2, #952]
ldr.w r7, [r2, #1304]
str.w r7, [r3, #2008]
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
str.w fp, [r3, #248]
str.w ip, [r3, #600]
str.w r9, [r3, #952]
str.w sl, [r3, #1304]
str.w r7, [r3, #1656]
ldr.w r4, [r1, #252]
ldr.w r5, [r1, #604]
ldr.w r6, [r1, #956]
ldr.w r7, [r1, #1308]
str.w r7, [sp, #2012]
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
str.w fp, [sp, #252]
str.w ip, [sp, #604]
str.w r9, [sp, #956]
str.w sl, [sp, #1308]
str.w r7, [sp, #1660]
ldr.w r4, [r2, #252]
ldr.w r5, [r2, #604]
ldr.w r6, [r2, #956]
ldr.w r7, [r2, #1308]
str.w r7, [r3, #2012]
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
str.w fp, [r3, #252]
str.w ip, [r3, #604]
str.w r9, [r3, #956]
str.w sl, [r3, #1308]
str.w r7, [r3, #1660]
ldr.w r4, [r1, #256]
ldr.w r5, [r1, #608]
ldr.w r6, [r1, #960]
ldr.w r7, [r1, #1312]
str.w r7, [sp, #2016]
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
str.w fp, [sp, #256]
str.w ip, [sp, #608]
str.w r9, [sp, #960]
str.w sl, [sp, #1312]
str.w r7, [sp, #1664]
ldr.w r4, [r2, #256]
ldr.w r5, [r2, #608]
ldr.w r6, [r2, #960]
ldr.w r7, [r2, #1312]
str.w r7, [r3, #2016]
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
str.w fp, [r3, #256]
str.w ip, [r3, #608]
str.w r9, [r3, #960]
str.w sl, [r3, #1312]
str.w r7, [r3, #1664]
ldr.w r4, [r1, #260]
ldr.w r5, [r1, #612]
ldr.w r6, [r1, #964]
ldr.w r7, [r1, #1316]
str.w r7, [sp, #2020]
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
str.w fp, [sp, #260]
str.w ip, [sp, #612]
str.w r9, [sp, #964]
str.w sl, [sp, #1316]
str.w r7, [sp, #1668]
ldr.w r4, [r2, #260]
ldr.w r5, [r2, #612]
ldr.w r6, [r2, #964]
ldr.w r7, [r2, #1316]
str.w r7, [r3, #2020]
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
str.w fp, [r3, #260]
str.w ip, [r3, #612]
str.w r9, [r3, #964]
str.w sl, [r3, #1316]
str.w r7, [r3, #1668]
ldr.w r4, [r1, #264]
ldr.w r5, [r1, #616]
ldr.w r6, [r1, #968]
ldr.w r7, [r1, #1320]
str.w r7, [sp, #2024]
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
str.w fp, [sp, #264]
str.w ip, [sp, #616]
str.w r9, [sp, #968]
str.w sl, [sp, #1320]
str.w r7, [sp, #1672]
ldr.w r4, [r2, #264]
ldr.w r5, [r2, #616]
ldr.w r6, [r2, #968]
ldr.w r7, [r2, #1320]
str.w r7, [r3, #2024]
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
str.w fp, [r3, #264]
str.w ip, [r3, #616]
str.w r9, [r3, #968]
str.w sl, [r3, #1320]
str.w r7, [r3, #1672]
ldr.w r4, [r1, #268]
ldr.w r5, [r1, #620]
ldr.w r6, [r1, #972]
ldr.w r7, [r1, #1324]
str.w r7, [sp, #2028]
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
str.w fp, [sp, #268]
str.w ip, [sp, #620]
str.w r9, [sp, #972]
str.w sl, [sp, #1324]
str.w r7, [sp, #1676]
ldr.w r4, [r2, #268]
ldr.w r5, [r2, #620]
ldr.w r6, [r2, #972]
ldr.w r7, [r2, #1324]
str.w r7, [r3, #2028]
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
str.w fp, [r3, #268]
str.w ip, [r3, #620]
str.w r9, [r3, #972]
str.w sl, [r3, #1324]
str.w r7, [r3, #1676]
ldr.w r4, [r1, #272]
ldr.w r5, [r1, #624]
ldr.w r6, [r1, #976]
ldr.w r7, [r1, #1328]
str.w r7, [sp, #2032]
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
str.w fp, [sp, #272]
str.w ip, [sp, #624]
str.w r9, [sp, #976]
str.w sl, [sp, #1328]
str.w r7, [sp, #1680]
ldr.w r4, [r2, #272]
ldr.w r5, [r2, #624]
ldr.w r6, [r2, #976]
ldr.w r7, [r2, #1328]
str.w r7, [r3, #2032]
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
str.w fp, [r3, #272]
str.w ip, [r3, #624]
str.w r9, [r3, #976]
str.w sl, [r3, #1328]
str.w r7, [r3, #1680]
ldr.w r4, [r1, #276]
ldr.w r5, [r1, #628]
ldr.w r6, [r1, #980]
ldr.w r7, [r1, #1332]
str.w r7, [sp, #2036]
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
str.w fp, [sp, #276]
str.w ip, [sp, #628]
str.w r9, [sp, #980]
str.w sl, [sp, #1332]
str.w r7, [sp, #1684]
ldr.w r4, [r2, #276]
ldr.w r5, [r2, #628]
ldr.w r6, [r2, #980]
ldr.w r7, [r2, #1332]
str.w r7, [r3, #2036]
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
str.w fp, [r3, #276]
str.w ip, [r3, #628]
str.w r9, [r3, #980]
str.w sl, [r3, #1332]
str.w r7, [r3, #1684]
ldr.w r4, [r1, #280]
ldr.w r5, [r1, #632]
ldr.w r6, [r1, #984]
ldr.w r7, [r1, #1336]
str.w r7, [sp, #2040]
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
str.w fp, [sp, #280]
str.w ip, [sp, #632]
str.w r9, [sp, #984]
str.w sl, [sp, #1336]
str.w r7, [sp, #1688]
ldr.w r4, [r2, #280]
ldr.w r5, [r2, #632]
ldr.w r6, [r2, #984]
ldr.w r7, [r2, #1336]
str.w r7, [r3, #2040]
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
str.w fp, [r3, #280]
str.w ip, [r3, #632]
str.w r9, [r3, #984]
str.w sl, [r3, #1336]
str.w r7, [r3, #1688]
ldr.w r4, [r1, #284]
ldr.w r5, [r1, #636]
ldr.w r6, [r1, #988]
ldr.w r7, [r1, #1340]
str.w r7, [sp, #2044]
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
str.w fp, [sp, #284]
str.w ip, [sp, #636]
str.w r9, [sp, #988]
str.w sl, [sp, #1340]
str.w r7, [sp, #1692]
ldr.w r4, [r2, #284]
ldr.w r5, [r2, #636]
ldr.w r6, [r2, #988]
ldr.w r7, [r2, #1340]
str.w r7, [r3, #2044]
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
str.w fp, [r3, #284]
str.w ip, [r3, #636]
str.w r9, [r3, #988]
str.w sl, [r3, #1340]
str.w r7, [r3, #1692]
ldr.w r4, [r1, #288]
ldr.w r5, [r1, #640]
ldr.w r6, [r1, #992]
ldr.w r7, [r1, #1344]
str.w r7, [sp, #2048]
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
str.w fp, [sp, #288]
str.w ip, [sp, #640]
str.w r9, [sp, #992]
str.w sl, [sp, #1344]
str.w r7, [sp, #1696]
ldr.w r4, [r2, #288]
ldr.w r5, [r2, #640]
ldr.w r6, [r2, #992]
ldr.w r7, [r2, #1344]
str.w r7, [r3, #2048]
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
str.w fp, [r3, #288]
str.w ip, [r3, #640]
str.w r9, [r3, #992]
str.w sl, [r3, #1344]
str.w r7, [r3, #1696]
ldr.w r4, [r1, #292]
ldr.w r5, [r1, #644]
ldr.w r6, [r1, #996]
ldr.w r7, [r1, #1348]
str.w r7, [sp, #2052]
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
str.w fp, [sp, #292]
str.w ip, [sp, #644]
str.w r9, [sp, #996]
str.w sl, [sp, #1348]
str.w r7, [sp, #1700]
ldr.w r4, [r2, #292]
ldr.w r5, [r2, #644]
ldr.w r6, [r2, #996]
ldr.w r7, [r2, #1348]
str.w r7, [r3, #2052]
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
str.w fp, [r3, #292]
str.w ip, [r3, #644]
str.w r9, [r3, #996]
str.w sl, [r3, #1348]
str.w r7, [r3, #1700]
ldr.w r4, [r1, #296]
ldr.w r5, [r1, #648]
ldr.w r6, [r1, #1000]
ldr.w r7, [r1, #1352]
str.w r7, [sp, #2056]
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
str.w fp, [sp, #296]
str.w ip, [sp, #648]
str.w r9, [sp, #1000]
str.w sl, [sp, #1352]
str.w r7, [sp, #1704]
ldr.w r4, [r2, #296]
ldr.w r5, [r2, #648]
ldr.w r6, [r2, #1000]
ldr.w r7, [r2, #1352]
str.w r7, [r3, #2056]
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
str.w fp, [r3, #296]
str.w ip, [r3, #648]
str.w r9, [r3, #1000]
str.w sl, [r3, #1352]
str.w r7, [r3, #1704]
ldr.w r4, [r1, #300]
ldr.w r5, [r1, #652]
ldr.w r6, [r1, #1004]
ldr.w r7, [r1, #1356]
str.w r7, [sp, #2060]
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
str.w fp, [sp, #300]
str.w ip, [sp, #652]
str.w r9, [sp, #1004]
str.w sl, [sp, #1356]
str.w r7, [sp, #1708]
ldr.w r4, [r2, #300]
ldr.w r5, [r2, #652]
ldr.w r6, [r2, #1004]
ldr.w r7, [r2, #1356]
str.w r7, [r3, #2060]
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
str.w fp, [r3, #300]
str.w ip, [r3, #652]
str.w r9, [r3, #1004]
str.w sl, [r3, #1356]
str.w r7, [r3, #1708]
ldr.w r4, [r1, #304]
ldr.w r5, [r1, #656]
ldr.w r6, [r1, #1008]
ldr.w r7, [r1, #1360]
str.w r7, [sp, #2064]
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
str.w fp, [sp, #304]
str.w ip, [sp, #656]
str.w r9, [sp, #1008]
str.w sl, [sp, #1360]
str.w r7, [sp, #1712]
ldr.w r4, [r2, #304]
ldr.w r5, [r2, #656]
ldr.w r6, [r2, #1008]
ldr.w r7, [r2, #1360]
str.w r7, [r3, #2064]
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
str.w fp, [r3, #304]
str.w ip, [r3, #656]
str.w r9, [r3, #1008]
str.w sl, [r3, #1360]
str.w r7, [r3, #1712]
ldr.w r4, [r1, #308]
ldr.w r5, [r1, #660]
ldr.w r6, [r1, #1012]
ldr.w r7, [r1, #1364]
str.w r7, [sp, #2068]
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
str.w fp, [sp, #308]
str.w ip, [sp, #660]
str.w r9, [sp, #1012]
str.w sl, [sp, #1364]
str.w r7, [sp, #1716]
ldr.w r4, [r2, #308]
ldr.w r5, [r2, #660]
ldr.w r6, [r2, #1012]
ldr.w r7, [r2, #1364]
str.w r7, [r3, #2068]
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
str.w fp, [r3, #308]
str.w ip, [r3, #660]
str.w r9, [r3, #1012]
str.w sl, [r3, #1364]
str.w r7, [r3, #1716]
ldr.w r4, [r1, #312]
ldr.w r5, [r1, #664]
ldr.w r6, [r1, #1016]
ldr.w r7, [r1, #1368]
str.w r7, [sp, #2072]
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
str.w fp, [sp, #312]
str.w ip, [sp, #664]
str.w r9, [sp, #1016]
str.w sl, [sp, #1368]
str.w r7, [sp, #1720]
ldr.w r4, [r2, #312]
ldr.w r5, [r2, #664]
ldr.w r6, [r2, #1016]
ldr.w r7, [r2, #1368]
str.w r7, [r3, #2072]
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
str.w fp, [r3, #312]
str.w ip, [r3, #664]
str.w r9, [r3, #1016]
str.w sl, [r3, #1368]
str.w r7, [r3, #1720]
ldr.w r4, [r1, #316]
ldr.w r5, [r1, #668]
ldr.w r6, [r1, #1020]
ldr.w r7, [r1, #1372]
str.w r7, [sp, #2076]
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
str.w fp, [sp, #316]
str.w ip, [sp, #668]
str.w r9, [sp, #1020]
str.w sl, [sp, #1372]
str.w r7, [sp, #1724]
ldr.w r4, [r2, #316]
ldr.w r5, [r2, #668]
ldr.w r6, [r2, #1020]
ldr.w r7, [r2, #1372]
str.w r7, [r3, #2076]
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
str.w fp, [r3, #316]
str.w ip, [r3, #668]
str.w r9, [r3, #1020]
str.w sl, [r3, #1372]
str.w r7, [r3, #1724]
ldr.w r4, [r1, #320]
ldr.w r5, [r1, #672]
ldr.w r6, [r1, #1024]
ldr.w r7, [r1, #1376]
str.w r7, [sp, #2080]
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
str.w fp, [sp, #320]
str.w ip, [sp, #672]
str.w r9, [sp, #1024]
str.w sl, [sp, #1376]
str.w r7, [sp, #1728]
ldr.w r4, [r2, #320]
ldr.w r5, [r2, #672]
ldr.w r6, [r2, #1024]
ldr.w r7, [r2, #1376]
str.w r7, [r3, #2080]
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
str.w fp, [r3, #320]
str.w ip, [r3, #672]
str.w r9, [r3, #1024]
str.w sl, [r3, #1376]
str.w r7, [r3, #1728]
ldr.w r4, [r1, #324]
ldr.w r5, [r1, #676]
ldr.w r6, [r1, #1028]
ldr.w r7, [r1, #1380]
str.w r7, [sp, #2084]
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
str.w fp, [sp, #324]
str.w ip, [sp, #676]
str.w r9, [sp, #1028]
str.w sl, [sp, #1380]
str.w r7, [sp, #1732]
ldr.w r4, [r2, #324]
ldr.w r5, [r2, #676]
ldr.w r6, [r2, #1028]
ldr.w r7, [r2, #1380]
str.w r7, [r3, #2084]
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
str.w fp, [r3, #324]
str.w ip, [r3, #676]
str.w r9, [r3, #1028]
str.w sl, [r3, #1380]
str.w r7, [r3, #1732]
ldr.w r4, [r1, #328]
ldr.w r5, [r1, #680]
ldr.w r6, [r1, #1032]
ldr.w r7, [r1, #1384]
str.w r7, [sp, #2088]
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
str.w fp, [sp, #328]
str.w ip, [sp, #680]
str.w r9, [sp, #1032]
str.w sl, [sp, #1384]
str.w r7, [sp, #1736]
ldr.w r4, [r2, #328]
ldr.w r5, [r2, #680]
ldr.w r6, [r2, #1032]
ldr.w r7, [r2, #1384]
str.w r7, [r3, #2088]
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
str.w fp, [r3, #328]
str.w ip, [r3, #680]
str.w r9, [r3, #1032]
str.w sl, [r3, #1384]
str.w r7, [r3, #1736]
ldr.w r4, [r1, #332]
ldr.w r5, [r1, #684]
ldr.w r6, [r1, #1036]
ldr.w r7, [r1, #1388]
str.w r7, [sp, #2092]
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
str.w fp, [sp, #332]
str.w ip, [sp, #684]
str.w r9, [sp, #1036]
str.w sl, [sp, #1388]
str.w r7, [sp, #1740]
ldr.w r4, [r2, #332]
ldr.w r5, [r2, #684]
ldr.w r6, [r2, #1036]
ldr.w r7, [r2, #1388]
str.w r7, [r3, #2092]
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
str.w fp, [r3, #332]
str.w ip, [r3, #684]
str.w r9, [r3, #1036]
str.w sl, [r3, #1388]
str.w r7, [r3, #1740]
ldr.w r4, [r1, #336]
ldr.w r5, [r1, #688]
ldr.w r6, [r1, #1040]
ldr.w r7, [r1, #1392]
str.w r7, [sp, #2096]
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
str.w fp, [sp, #336]
str.w ip, [sp, #688]
str.w r9, [sp, #1040]
str.w sl, [sp, #1392]
str.w r7, [sp, #1744]
ldr.w r4, [r2, #336]
ldr.w r5, [r2, #688]
ldr.w r6, [r2, #1040]
ldr.w r7, [r2, #1392]
str.w r7, [r3, #2096]
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
str.w fp, [r3, #336]
str.w ip, [r3, #688]
str.w r9, [r3, #1040]
str.w sl, [r3, #1392]
str.w r7, [r3, #1744]
ldr.w r4, [r1, #340]
ldr.w r5, [r1, #692]
ldr.w r6, [r1, #1044]
ldr.w r7, [r1, #1396]
str.w r7, [sp, #2100]
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
str.w fp, [sp, #340]
str.w ip, [sp, #692]
str.w r9, [sp, #1044]
str.w sl, [sp, #1396]
str.w r7, [sp, #1748]
ldr.w r4, [r2, #340]
ldr.w r5, [r2, #692]
ldr.w r6, [r2, #1044]
ldr.w r7, [r2, #1396]
str.w r7, [r3, #2100]
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
str.w fp, [r3, #340]
str.w ip, [r3, #692]
str.w r9, [r3, #1044]
str.w sl, [r3, #1396]
str.w r7, [r3, #1748]
ldr.w r4, [r1, #344]
ldr.w r5, [r1, #696]
ldr.w r6, [r1, #1048]
ldrh.w r7, [r1, #1400]
str.w r7, [sp, #2104]
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
str.w fp, [sp, #344]
str.w ip, [sp, #696]
str.w r9, [sp, #1048]
str.w sl, [sp, #1400]
str.w r7, [sp, #1752]
ldr.w r4, [r2, #344]
ldr.w r5, [r2, #696]
ldr.w r6, [r2, #1048]
ldrh.w r7, [r2, #1400]
str.w r7, [r3, #2104]
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
str.w fp, [r3, #344]
str.w ip, [r3, #696]
str.w r9, [r3, #1048]
str.w sl, [r3, #1400]
str.w r7, [r3, #1752]
ldr.w r4, [r1, #348]
ldr.w r5, [r1, #700]
ldr.w r6, [r1, #1052]
mov.w r7, #0
str.w r7, [sp, #2108]
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
str.w fp, [sp, #348]
str.w ip, [sp, #700]
str.w r9, [sp, #1052]
str.w sl, [sp, #1404]
str.w r7, [sp, #1756]
ldr.w r4, [r2, #348]
ldr.w r5, [r2, #700]
ldr.w r6, [r2, #1052]
mov.w r7, #0
str.w r7, [r3, #2108]
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
str.w fp, [r3, #348]
str.w ip, [r3, #700]
str.w r9, [r3, #1052]
str.w sl, [r3, #1404]
str.w r7, [r3, #1756]
push {r0}
push {r3}
movw fp, #4232
add.w r0, sp, fp
bl karatsuba_176x176
pop.w {r3}
add.w r0, r0, #704
add.w r1, sp, #4
add.w r2, r3, #0
bl karatsuba_176x176
add.w r0, r0, #704
add.w r1, r1, #352
add.w r2, r2, #352
bl karatsuba_176x176
add.w r0, r0, #704
add.w r1, r1, #352
add.w r2, r2, #352
bl karatsuba_176x176
add.w r0, r0, #704
add.w r1, r1, #352
add.w r2, r2, #352
bl karatsuba_176x176
add.w r0, r0, #704
add.w r1, r1, #352
add.w r2, r2, #352
bl karatsuba_176x176
add.w r0, r0, #704
add.w r1, r1, #352
add.w r2, r2, #352
bl karatsuba_176x176
pop.w {r0}
mov.w fp, #4224
add.w sp, fp
add.w fp, sp, #2816
movw lr, #43691
movw ip, #52429
ldrh.w r1, [sp]
ldrh.w r2, [sp, #704]
ldrh.w r3, [sp, #1408]
ldrh.w r4, [sp, #2112]
ldrh.w r5, [fp]
ldrh.w r6, [fp, #704]
ldrh.w r7, [fp, #1408]
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
strh.w r3, [r0, #352]
strh.w r8, [r0, #704]
strh.w r6, [r0, #1056]
strh.w r9, [r0, #1408]
strh.w r5, [r0, #1760]
strh.w r7, [r0, #2112]
ldrh.w r1, [sp, #2]
ldrh.w r2, [sp, #706]
ldrh.w r3, [sp, #1410]
ldrh.w r4, [sp, #2114]
ldrh.w r5, [fp, #2]
ldrh.w r6, [fp, #706]
ldrh.w r7, [fp, #1410]
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
strh.w r3, [r0, #354]
strh.w r8, [r0, #706]
strh.w r6, [r0, #1058]
strh.w r9, [r0, #1410]
strh.w r5, [r0, #1762]
strh.w r7, [r0, #2114]
ldrh.w r1, [sp, #4]
ldrh.w r2, [sp, #708]
ldrh.w r3, [sp, #1412]
ldrh.w r4, [sp, #2116]
ldrh.w r5, [fp, #4]
ldrh.w r6, [fp, #708]
ldrh.w r7, [fp, #1412]
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
strh.w r3, [r0, #356]
strh.w r8, [r0, #708]
strh.w r6, [r0, #1060]
strh.w r9, [r0, #1412]
strh.w r5, [r0, #1764]
strh.w r7, [r0, #2116]
ldrh.w r1, [sp, #6]
ldrh.w r2, [sp, #710]
ldrh.w r3, [sp, #1414]
ldrh.w r4, [sp, #2118]
ldrh.w r5, [fp, #6]
ldrh.w r6, [fp, #710]
ldrh.w r7, [fp, #1414]
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
strh.w r3, [r0, #358]
strh.w r8, [r0, #710]
strh.w r6, [r0, #1062]
strh.w r9, [r0, #1414]
strh.w r5, [r0, #1766]
strh.w r7, [r0, #2118]
ldrh.w r1, [sp, #8]
ldrh.w r2, [sp, #712]
ldrh.w r3, [sp, #1416]
ldrh.w r4, [sp, #2120]
ldrh.w r5, [fp, #8]
ldrh.w r6, [fp, #712]
ldrh.w r7, [fp, #1416]
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
strh.w r3, [r0, #360]
strh.w r8, [r0, #712]
strh.w r6, [r0, #1064]
strh.w r9, [r0, #1416]
strh.w r5, [r0, #1768]
strh.w r7, [r0, #2120]
ldrh.w r1, [sp, #10]
ldrh.w r2, [sp, #714]
ldrh.w r3, [sp, #1418]
ldrh.w r4, [sp, #2122]
ldrh.w r5, [fp, #10]
ldrh.w r6, [fp, #714]
ldrh.w r7, [fp, #1418]
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
strh.w r3, [r0, #362]
strh.w r8, [r0, #714]
strh.w r6, [r0, #1066]
strh.w r9, [r0, #1418]
strh.w r5, [r0, #1770]
strh.w r7, [r0, #2122]
ldrh.w r1, [sp, #12]
ldrh.w r2, [sp, #716]
ldrh.w r3, [sp, #1420]
ldrh.w r4, [sp, #2124]
ldrh.w r5, [fp, #12]
ldrh.w r6, [fp, #716]
ldrh.w r7, [fp, #1420]
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
strh.w r3, [r0, #364]
strh.w r8, [r0, #716]
strh.w r6, [r0, #1068]
strh.w r9, [r0, #1420]
strh.w r5, [r0, #1772]
strh.w r7, [r0, #2124]
ldrh.w r1, [sp, #14]
ldrh.w r2, [sp, #718]
ldrh.w r3, [sp, #1422]
ldrh.w r4, [sp, #2126]
ldrh.w r5, [fp, #14]
ldrh.w r6, [fp, #718]
ldrh.w r7, [fp, #1422]
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
strh.w r3, [r0, #366]
strh.w r8, [r0, #718]
strh.w r6, [r0, #1070]
strh.w r9, [r0, #1422]
strh.w r5, [r0, #1774]
strh.w r7, [r0, #2126]
ldrh.w r1, [sp, #16]
ldrh.w r2, [sp, #720]
ldrh.w r3, [sp, #1424]
ldrh.w r4, [sp, #2128]
ldrh.w r5, [fp, #16]
ldrh.w r6, [fp, #720]
ldrh.w r7, [fp, #1424]
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
strh.w r3, [r0, #368]
strh.w r8, [r0, #720]
strh.w r6, [r0, #1072]
strh.w r9, [r0, #1424]
strh.w r5, [r0, #1776]
strh.w r7, [r0, #2128]
ldrh.w r1, [sp, #18]
ldrh.w r2, [sp, #722]
ldrh.w r3, [sp, #1426]
ldrh.w r4, [sp, #2130]
ldrh.w r5, [fp, #18]
ldrh.w r6, [fp, #722]
ldrh.w r7, [fp, #1426]
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
strh.w r3, [r0, #370]
strh.w r8, [r0, #722]
strh.w r6, [r0, #1074]
strh.w r9, [r0, #1426]
strh.w r5, [r0, #1778]
strh.w r7, [r0, #2130]
ldrh.w r1, [sp, #20]
ldrh.w r2, [sp, #724]
ldrh.w r3, [sp, #1428]
ldrh.w r4, [sp, #2132]
ldrh.w r5, [fp, #20]
ldrh.w r6, [fp, #724]
ldrh.w r7, [fp, #1428]
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
strh.w r3, [r0, #372]
strh.w r8, [r0, #724]
strh.w r6, [r0, #1076]
strh.w r9, [r0, #1428]
strh.w r5, [r0, #1780]
strh.w r7, [r0, #2132]
ldrh.w r1, [sp, #22]
ldrh.w r2, [sp, #726]
ldrh.w r3, [sp, #1430]
ldrh.w r4, [sp, #2134]
ldrh.w r5, [fp, #22]
ldrh.w r6, [fp, #726]
ldrh.w r7, [fp, #1430]
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
strh.w r3, [r0, #374]
strh.w r8, [r0, #726]
strh.w r6, [r0, #1078]
strh.w r9, [r0, #1430]
strh.w r5, [r0, #1782]
strh.w r7, [r0, #2134]
ldrh.w r1, [sp, #24]
ldrh.w r2, [sp, #728]
ldrh.w r3, [sp, #1432]
ldrh.w r4, [sp, #2136]
ldrh.w r5, [fp, #24]
ldrh.w r6, [fp, #728]
ldrh.w r7, [fp, #1432]
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
strh.w r3, [r0, #376]
strh.w r8, [r0, #728]
strh.w r6, [r0, #1080]
strh.w r9, [r0, #1432]
strh.w r5, [r0, #1784]
strh.w r7, [r0, #2136]
ldrh.w r1, [sp, #26]
ldrh.w r2, [sp, #730]
ldrh.w r3, [sp, #1434]
ldrh.w r4, [sp, #2138]
ldrh.w r5, [fp, #26]
ldrh.w r6, [fp, #730]
ldrh.w r7, [fp, #1434]
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
strh.w r3, [r0, #378]
strh.w r8, [r0, #730]
strh.w r6, [r0, #1082]
strh.w r9, [r0, #1434]
strh.w r5, [r0, #1786]
strh.w r7, [r0, #2138]
ldrh.w r1, [sp, #28]
ldrh.w r2, [sp, #732]
ldrh.w r3, [sp, #1436]
ldrh.w r4, [sp, #2140]
ldrh.w r5, [fp, #28]
ldrh.w r6, [fp, #732]
ldrh.w r7, [fp, #1436]
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
strh.w r3, [r0, #380]
strh.w r8, [r0, #732]
strh.w r6, [r0, #1084]
strh.w r9, [r0, #1436]
strh.w r5, [r0, #1788]
strh.w r7, [r0, #2140]
ldrh.w r1, [sp, #30]
ldrh.w r2, [sp, #734]
ldrh.w r3, [sp, #1438]
ldrh.w r4, [sp, #2142]
ldrh.w r5, [fp, #30]
ldrh.w r6, [fp, #734]
ldrh.w r7, [fp, #1438]
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
strh.w r3, [r0, #382]
strh.w r8, [r0, #734]
strh.w r6, [r0, #1086]
strh.w r9, [r0, #1438]
strh.w r5, [r0, #1790]
strh.w r7, [r0, #2142]
ldrh.w r1, [sp, #32]
ldrh.w r2, [sp, #736]
ldrh.w r3, [sp, #1440]
ldrh.w r4, [sp, #2144]
ldrh.w r5, [fp, #32]
ldrh.w r6, [fp, #736]
ldrh.w r7, [fp, #1440]
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
strh.w r3, [r0, #384]
strh.w r8, [r0, #736]
strh.w r6, [r0, #1088]
strh.w r9, [r0, #1440]
strh.w r5, [r0, #1792]
strh.w r7, [r0, #2144]
ldrh.w r1, [sp, #34]
ldrh.w r2, [sp, #738]
ldrh.w r3, [sp, #1442]
ldrh.w r4, [sp, #2146]
ldrh.w r5, [fp, #34]
ldrh.w r6, [fp, #738]
ldrh.w r7, [fp, #1442]
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
strh.w r3, [r0, #386]
strh.w r8, [r0, #738]
strh.w r6, [r0, #1090]
strh.w r9, [r0, #1442]
strh.w r5, [r0, #1794]
strh.w r7, [r0, #2146]
ldrh.w r1, [sp, #36]
ldrh.w r2, [sp, #740]
ldrh.w r3, [sp, #1444]
ldrh.w r4, [sp, #2148]
ldrh.w r5, [fp, #36]
ldrh.w r6, [fp, #740]
ldrh.w r7, [fp, #1444]
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
strh.w r3, [r0, #388]
strh.w r8, [r0, #740]
strh.w r6, [r0, #1092]
strh.w r9, [r0, #1444]
strh.w r5, [r0, #1796]
strh.w r7, [r0, #2148]
ldrh.w r1, [sp, #38]
ldrh.w r2, [sp, #742]
ldrh.w r3, [sp, #1446]
ldrh.w r4, [sp, #2150]
ldrh.w r5, [fp, #38]
ldrh.w r6, [fp, #742]
ldrh.w r7, [fp, #1446]
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
strh.w r3, [r0, #390]
strh.w r8, [r0, #742]
strh.w r6, [r0, #1094]
strh.w r9, [r0, #1446]
strh.w r5, [r0, #1798]
strh.w r7, [r0, #2150]
ldrh.w r1, [sp, #40]
ldrh.w r2, [sp, #744]
ldrh.w r3, [sp, #1448]
ldrh.w r4, [sp, #2152]
ldrh.w r5, [fp, #40]
ldrh.w r6, [fp, #744]
ldrh.w r7, [fp, #1448]
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
strh.w r3, [r0, #392]
strh.w r8, [r0, #744]
strh.w r6, [r0, #1096]
strh.w r9, [r0, #1448]
strh.w r5, [r0, #1800]
strh.w r7, [r0, #2152]
ldrh.w r1, [sp, #42]
ldrh.w r2, [sp, #746]
ldrh.w r3, [sp, #1450]
ldrh.w r4, [sp, #2154]
ldrh.w r5, [fp, #42]
ldrh.w r6, [fp, #746]
ldrh.w r7, [fp, #1450]
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
strh.w r3, [r0, #394]
strh.w r8, [r0, #746]
strh.w r6, [r0, #1098]
strh.w r9, [r0, #1450]
strh.w r5, [r0, #1802]
strh.w r7, [r0, #2154]
ldrh.w r1, [sp, #44]
ldrh.w r2, [sp, #748]
ldrh.w r3, [sp, #1452]
ldrh.w r4, [sp, #2156]
ldrh.w r5, [fp, #44]
ldrh.w r6, [fp, #748]
ldrh.w r7, [fp, #1452]
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
strh.w r3, [r0, #396]
strh.w r8, [r0, #748]
strh.w r6, [r0, #1100]
strh.w r9, [r0, #1452]
strh.w r5, [r0, #1804]
strh.w r7, [r0, #2156]
ldrh.w r1, [sp, #46]
ldrh.w r2, [sp, #750]
ldrh.w r3, [sp, #1454]
ldrh.w r4, [sp, #2158]
ldrh.w r5, [fp, #46]
ldrh.w r6, [fp, #750]
ldrh.w r7, [fp, #1454]
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
strh.w r3, [r0, #398]
strh.w r8, [r0, #750]
strh.w r6, [r0, #1102]
strh.w r9, [r0, #1454]
strh.w r5, [r0, #1806]
strh.w r7, [r0, #2158]
ldrh.w r1, [sp, #48]
ldrh.w r2, [sp, #752]
ldrh.w r3, [sp, #1456]
ldrh.w r4, [sp, #2160]
ldrh.w r5, [fp, #48]
ldrh.w r6, [fp, #752]
ldrh.w r7, [fp, #1456]
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
strh.w r3, [r0, #400]
strh.w r8, [r0, #752]
strh.w r6, [r0, #1104]
strh.w r9, [r0, #1456]
strh.w r5, [r0, #1808]
strh.w r7, [r0, #2160]
ldrh.w r1, [sp, #50]
ldrh.w r2, [sp, #754]
ldrh.w r3, [sp, #1458]
ldrh.w r4, [sp, #2162]
ldrh.w r5, [fp, #50]
ldrh.w r6, [fp, #754]
ldrh.w r7, [fp, #1458]
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
strh.w r3, [r0, #402]
strh.w r8, [r0, #754]
strh.w r6, [r0, #1106]
strh.w r9, [r0, #1458]
strh.w r5, [r0, #1810]
strh.w r7, [r0, #2162]
ldrh.w r1, [sp, #52]
ldrh.w r2, [sp, #756]
ldrh.w r3, [sp, #1460]
ldrh.w r4, [sp, #2164]
ldrh.w r5, [fp, #52]
ldrh.w r6, [fp, #756]
ldrh.w r7, [fp, #1460]
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
strh.w r3, [r0, #404]
strh.w r8, [r0, #756]
strh.w r6, [r0, #1108]
strh.w r9, [r0, #1460]
strh.w r5, [r0, #1812]
strh.w r7, [r0, #2164]
ldrh.w r1, [sp, #54]
ldrh.w r2, [sp, #758]
ldrh.w r3, [sp, #1462]
ldrh.w r4, [sp, #2166]
ldrh.w r5, [fp, #54]
ldrh.w r6, [fp, #758]
ldrh.w r7, [fp, #1462]
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
strh.w r3, [r0, #406]
strh.w r8, [r0, #758]
strh.w r6, [r0, #1110]
strh.w r9, [r0, #1462]
strh.w r5, [r0, #1814]
strh.w r7, [r0, #2166]
ldrh.w r1, [sp, #56]
ldrh.w r2, [sp, #760]
ldrh.w r3, [sp, #1464]
ldrh.w r4, [sp, #2168]
ldrh.w r5, [fp, #56]
ldrh.w r6, [fp, #760]
ldrh.w r7, [fp, #1464]
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
strh.w r3, [r0, #408]
strh.w r8, [r0, #760]
strh.w r6, [r0, #1112]
strh.w r9, [r0, #1464]
strh.w r5, [r0, #1816]
strh.w r7, [r0, #2168]
ldrh.w r1, [sp, #58]
ldrh.w r2, [sp, #762]
ldrh.w r3, [sp, #1466]
ldrh.w r4, [sp, #2170]
ldrh.w r5, [fp, #58]
ldrh.w r6, [fp, #762]
ldrh.w r7, [fp, #1466]
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
strh.w r3, [r0, #410]
strh.w r8, [r0, #762]
strh.w r6, [r0, #1114]
strh.w r9, [r0, #1466]
strh.w r5, [r0, #1818]
strh.w r7, [r0, #2170]
ldrh.w r1, [sp, #60]
ldrh.w r2, [sp, #764]
ldrh.w r3, [sp, #1468]
ldrh.w r4, [sp, #2172]
ldrh.w r5, [fp, #60]
ldrh.w r6, [fp, #764]
ldrh.w r7, [fp, #1468]
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
strh.w r3, [r0, #412]
strh.w r8, [r0, #764]
strh.w r6, [r0, #1116]
strh.w r9, [r0, #1468]
strh.w r5, [r0, #1820]
strh.w r7, [r0, #2172]
ldrh.w r1, [sp, #62]
ldrh.w r2, [sp, #766]
ldrh.w r3, [sp, #1470]
ldrh.w r4, [sp, #2174]
ldrh.w r5, [fp, #62]
ldrh.w r6, [fp, #766]
ldrh.w r7, [fp, #1470]
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
strh.w r3, [r0, #414]
strh.w r8, [r0, #766]
strh.w r6, [r0, #1118]
strh.w r9, [r0, #1470]
strh.w r5, [r0, #1822]
strh.w r7, [r0, #2174]
ldrh.w r1, [sp, #64]
ldrh.w r2, [sp, #768]
ldrh.w r3, [sp, #1472]
ldrh.w r4, [sp, #2176]
ldrh.w r5, [fp, #64]
ldrh.w r6, [fp, #768]
ldrh.w r7, [fp, #1472]
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
strh.w r3, [r0, #416]
strh.w r8, [r0, #768]
strh.w r6, [r0, #1120]
strh.w r9, [r0, #1472]
strh.w r5, [r0, #1824]
strh.w r7, [r0, #2176]
ldrh.w r1, [sp, #66]
ldrh.w r2, [sp, #770]
ldrh.w r3, [sp, #1474]
ldrh.w r4, [sp, #2178]
ldrh.w r5, [fp, #66]
ldrh.w r6, [fp, #770]
ldrh.w r7, [fp, #1474]
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
strh.w r3, [r0, #418]
strh.w r8, [r0, #770]
strh.w r6, [r0, #1122]
strh.w r9, [r0, #1474]
strh.w r5, [r0, #1826]
strh.w r7, [r0, #2178]
ldrh.w r1, [sp, #68]
ldrh.w r2, [sp, #772]
ldrh.w r3, [sp, #1476]
ldrh.w r4, [sp, #2180]
ldrh.w r5, [fp, #68]
ldrh.w r6, [fp, #772]
ldrh.w r7, [fp, #1476]
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
strh.w r3, [r0, #420]
strh.w r8, [r0, #772]
strh.w r6, [r0, #1124]
strh.w r9, [r0, #1476]
strh.w r5, [r0, #1828]
strh.w r7, [r0, #2180]
ldrh.w r1, [sp, #70]
ldrh.w r2, [sp, #774]
ldrh.w r3, [sp, #1478]
ldrh.w r4, [sp, #2182]
ldrh.w r5, [fp, #70]
ldrh.w r6, [fp, #774]
ldrh.w r7, [fp, #1478]
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
strh.w r3, [r0, #422]
strh.w r8, [r0, #774]
strh.w r6, [r0, #1126]
strh.w r9, [r0, #1478]
strh.w r5, [r0, #1830]
strh.w r7, [r0, #2182]
ldrh.w r1, [sp, #72]
ldrh.w r2, [sp, #776]
ldrh.w r3, [sp, #1480]
ldrh.w r4, [sp, #2184]
ldrh.w r5, [fp, #72]
ldrh.w r6, [fp, #776]
ldrh.w r7, [fp, #1480]
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
strh.w r3, [r0, #424]
strh.w r8, [r0, #776]
strh.w r6, [r0, #1128]
strh.w r9, [r0, #1480]
strh.w r5, [r0, #1832]
strh.w r7, [r0, #2184]
ldrh.w r1, [sp, #74]
ldrh.w r2, [sp, #778]
ldrh.w r3, [sp, #1482]
ldrh.w r4, [sp, #2186]
ldrh.w r5, [fp, #74]
ldrh.w r6, [fp, #778]
ldrh.w r7, [fp, #1482]
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
strh.w r3, [r0, #426]
strh.w r8, [r0, #778]
strh.w r6, [r0, #1130]
strh.w r9, [r0, #1482]
strh.w r5, [r0, #1834]
strh.w r7, [r0, #2186]
ldrh.w r1, [sp, #76]
ldrh.w r2, [sp, #780]
ldrh.w r3, [sp, #1484]
ldrh.w r4, [sp, #2188]
ldrh.w r5, [fp, #76]
ldrh.w r6, [fp, #780]
ldrh.w r7, [fp, #1484]
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
strh.w r3, [r0, #428]
strh.w r8, [r0, #780]
strh.w r6, [r0, #1132]
strh.w r9, [r0, #1484]
strh.w r5, [r0, #1836]
strh.w r7, [r0, #2188]
ldrh.w r1, [sp, #78]
ldrh.w r2, [sp, #782]
ldrh.w r3, [sp, #1486]
ldrh.w r4, [sp, #2190]
ldrh.w r5, [fp, #78]
ldrh.w r6, [fp, #782]
ldrh.w r7, [fp, #1486]
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
strh.w r3, [r0, #430]
strh.w r8, [r0, #782]
strh.w r6, [r0, #1134]
strh.w r9, [r0, #1486]
strh.w r5, [r0, #1838]
strh.w r7, [r0, #2190]
ldrh.w r1, [sp, #80]
ldrh.w r2, [sp, #784]
ldrh.w r3, [sp, #1488]
ldrh.w r4, [sp, #2192]
ldrh.w r5, [fp, #80]
ldrh.w r6, [fp, #784]
ldrh.w r7, [fp, #1488]
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
strh.w r3, [r0, #432]
strh.w r8, [r0, #784]
strh.w r6, [r0, #1136]
strh.w r9, [r0, #1488]
strh.w r5, [r0, #1840]
strh.w r7, [r0, #2192]
ldrh.w r1, [sp, #82]
ldrh.w r2, [sp, #786]
ldrh.w r3, [sp, #1490]
ldrh.w r4, [sp, #2194]
ldrh.w r5, [fp, #82]
ldrh.w r6, [fp, #786]
ldrh.w r7, [fp, #1490]
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
strh.w r3, [r0, #434]
strh.w r8, [r0, #786]
strh.w r6, [r0, #1138]
strh.w r9, [r0, #1490]
strh.w r5, [r0, #1842]
strh.w r7, [r0, #2194]
ldrh.w r1, [sp, #84]
ldrh.w r2, [sp, #788]
ldrh.w r3, [sp, #1492]
ldrh.w r4, [sp, #2196]
ldrh.w r5, [fp, #84]
ldrh.w r6, [fp, #788]
ldrh.w r7, [fp, #1492]
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
strh.w r3, [r0, #436]
strh.w r8, [r0, #788]
strh.w r6, [r0, #1140]
strh.w r9, [r0, #1492]
strh.w r5, [r0, #1844]
strh.w r7, [r0, #2196]
ldrh.w r1, [sp, #86]
ldrh.w r2, [sp, #790]
ldrh.w r3, [sp, #1494]
ldrh.w r4, [sp, #2198]
ldrh.w r5, [fp, #86]
ldrh.w r6, [fp, #790]
ldrh.w r7, [fp, #1494]
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
strh.w r3, [r0, #438]
strh.w r8, [r0, #790]
strh.w r6, [r0, #1142]
strh.w r9, [r0, #1494]
strh.w r5, [r0, #1846]
strh.w r7, [r0, #2198]
ldrh.w r1, [sp, #88]
ldrh.w r2, [sp, #792]
ldrh.w r3, [sp, #1496]
ldrh.w r4, [sp, #2200]
ldrh.w r5, [fp, #88]
ldrh.w r6, [fp, #792]
ldrh.w r7, [fp, #1496]
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
strh.w r3, [r0, #440]
strh.w r8, [r0, #792]
strh.w r6, [r0, #1144]
strh.w r9, [r0, #1496]
strh.w r5, [r0, #1848]
strh.w r7, [r0, #2200]
ldrh.w r1, [sp, #90]
ldrh.w r2, [sp, #794]
ldrh.w r3, [sp, #1498]
ldrh.w r4, [sp, #2202]
ldrh.w r5, [fp, #90]
ldrh.w r6, [fp, #794]
ldrh.w r7, [fp, #1498]
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
strh.w r3, [r0, #442]
strh.w r8, [r0, #794]
strh.w r6, [r0, #1146]
strh.w r9, [r0, #1498]
strh.w r5, [r0, #1850]
strh.w r7, [r0, #2202]
ldrh.w r1, [sp, #92]
ldrh.w r2, [sp, #796]
ldrh.w r3, [sp, #1500]
ldrh.w r4, [sp, #2204]
ldrh.w r5, [fp, #92]
ldrh.w r6, [fp, #796]
ldrh.w r7, [fp, #1500]
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
strh.w r3, [r0, #444]
strh.w r8, [r0, #796]
strh.w r6, [r0, #1148]
strh.w r9, [r0, #1500]
strh.w r5, [r0, #1852]
strh.w r7, [r0, #2204]
ldrh.w r1, [sp, #94]
ldrh.w r2, [sp, #798]
ldrh.w r3, [sp, #1502]
ldrh.w r4, [sp, #2206]
ldrh.w r5, [fp, #94]
ldrh.w r6, [fp, #798]
ldrh.w r7, [fp, #1502]
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
strh.w r3, [r0, #446]
strh.w r8, [r0, #798]
strh.w r6, [r0, #1150]
strh.w r9, [r0, #1502]
strh.w r5, [r0, #1854]
strh.w r7, [r0, #2206]
ldrh.w r1, [sp, #96]
ldrh.w r2, [sp, #800]
ldrh.w r3, [sp, #1504]
ldrh.w r4, [sp, #2208]
ldrh.w r5, [fp, #96]
ldrh.w r6, [fp, #800]
ldrh.w r7, [fp, #1504]
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
strh.w r3, [r0, #448]
strh.w r8, [r0, #800]
strh.w r6, [r0, #1152]
strh.w r9, [r0, #1504]
strh.w r5, [r0, #1856]
strh.w r7, [r0, #2208]
ldrh.w r1, [sp, #98]
ldrh.w r2, [sp, #802]
ldrh.w r3, [sp, #1506]
ldrh.w r4, [sp, #2210]
ldrh.w r5, [fp, #98]
ldrh.w r6, [fp, #802]
ldrh.w r7, [fp, #1506]
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
strh.w r3, [r0, #450]
strh.w r8, [r0, #802]
strh.w r6, [r0, #1154]
strh.w r9, [r0, #1506]
strh.w r5, [r0, #1858]
strh.w r7, [r0, #2210]
ldrh.w r1, [sp, #100]
ldrh.w r2, [sp, #804]
ldrh.w r3, [sp, #1508]
ldrh.w r4, [sp, #2212]
ldrh.w r5, [fp, #100]
ldrh.w r6, [fp, #804]
ldrh.w r7, [fp, #1508]
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
strh.w r3, [r0, #452]
strh.w r8, [r0, #804]
strh.w r6, [r0, #1156]
strh.w r9, [r0, #1508]
strh.w r5, [r0, #1860]
strh.w r7, [r0, #2212]
ldrh.w r1, [sp, #102]
ldrh.w r2, [sp, #806]
ldrh.w r3, [sp, #1510]
ldrh.w r4, [sp, #2214]
ldrh.w r5, [fp, #102]
ldrh.w r6, [fp, #806]
ldrh.w r7, [fp, #1510]
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
strh.w r3, [r0, #454]
strh.w r8, [r0, #806]
strh.w r6, [r0, #1158]
strh.w r9, [r0, #1510]
strh.w r5, [r0, #1862]
strh.w r7, [r0, #2214]
ldrh.w r1, [sp, #104]
ldrh.w r2, [sp, #808]
ldrh.w r3, [sp, #1512]
ldrh.w r4, [sp, #2216]
ldrh.w r5, [fp, #104]
ldrh.w r6, [fp, #808]
ldrh.w r7, [fp, #1512]
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
strh.w r3, [r0, #456]
strh.w r8, [r0, #808]
strh.w r6, [r0, #1160]
strh.w r9, [r0, #1512]
strh.w r5, [r0, #1864]
strh.w r7, [r0, #2216]
ldrh.w r1, [sp, #106]
ldrh.w r2, [sp, #810]
ldrh.w r3, [sp, #1514]
ldrh.w r4, [sp, #2218]
ldrh.w r5, [fp, #106]
ldrh.w r6, [fp, #810]
ldrh.w r7, [fp, #1514]
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
strh.w r3, [r0, #458]
strh.w r8, [r0, #810]
strh.w r6, [r0, #1162]
strh.w r9, [r0, #1514]
strh.w r5, [r0, #1866]
strh.w r7, [r0, #2218]
ldrh.w r1, [sp, #108]
ldrh.w r2, [sp, #812]
ldrh.w r3, [sp, #1516]
ldrh.w r4, [sp, #2220]
ldrh.w r5, [fp, #108]
ldrh.w r6, [fp, #812]
ldrh.w r7, [fp, #1516]
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
strh.w r3, [r0, #460]
strh.w r8, [r0, #812]
strh.w r6, [r0, #1164]
strh.w r9, [r0, #1516]
strh.w r5, [r0, #1868]
strh.w r7, [r0, #2220]
ldrh.w r1, [sp, #110]
ldrh.w r2, [sp, #814]
ldrh.w r3, [sp, #1518]
ldrh.w r4, [sp, #2222]
ldrh.w r5, [fp, #110]
ldrh.w r6, [fp, #814]
ldrh.w r7, [fp, #1518]
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
strh.w r3, [r0, #462]
strh.w r8, [r0, #814]
strh.w r6, [r0, #1166]
strh.w r9, [r0, #1518]
strh.w r5, [r0, #1870]
strh.w r7, [r0, #2222]
ldrh.w r1, [sp, #112]
ldrh.w r2, [sp, #816]
ldrh.w r3, [sp, #1520]
ldrh.w r4, [sp, #2224]
ldrh.w r5, [fp, #112]
ldrh.w r6, [fp, #816]
ldrh.w r7, [fp, #1520]
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
strh.w r3, [r0, #464]
strh.w r8, [r0, #816]
strh.w r6, [r0, #1168]
strh.w r9, [r0, #1520]
strh.w r5, [r0, #1872]
strh.w r7, [r0, #2224]
ldrh.w r1, [sp, #114]
ldrh.w r2, [sp, #818]
ldrh.w r3, [sp, #1522]
ldrh.w r4, [sp, #2226]
ldrh.w r5, [fp, #114]
ldrh.w r6, [fp, #818]
ldrh.w r7, [fp, #1522]
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
strh.w r3, [r0, #466]
strh.w r8, [r0, #818]
strh.w r6, [r0, #1170]
strh.w r9, [r0, #1522]
strh.w r5, [r0, #1874]
strh.w r7, [r0, #2226]
ldrh.w r1, [sp, #116]
ldrh.w r2, [sp, #820]
ldrh.w r3, [sp, #1524]
ldrh.w r4, [sp, #2228]
ldrh.w r5, [fp, #116]
ldrh.w r6, [fp, #820]
ldrh.w r7, [fp, #1524]
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
strh.w r3, [r0, #468]
strh.w r8, [r0, #820]
strh.w r6, [r0, #1172]
strh.w r9, [r0, #1524]
strh.w r5, [r0, #1876]
strh.w r7, [r0, #2228]
ldrh.w r1, [sp, #118]
ldrh.w r2, [sp, #822]
ldrh.w r3, [sp, #1526]
ldrh.w r4, [sp, #2230]
ldrh.w r5, [fp, #118]
ldrh.w r6, [fp, #822]
ldrh.w r7, [fp, #1526]
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
strh.w r3, [r0, #470]
strh.w r8, [r0, #822]
strh.w r6, [r0, #1174]
strh.w r9, [r0, #1526]
strh.w r5, [r0, #1878]
strh.w r7, [r0, #2230]
ldrh.w r1, [sp, #120]
ldrh.w r2, [sp, #824]
ldrh.w r3, [sp, #1528]
ldrh.w r4, [sp, #2232]
ldrh.w r5, [fp, #120]
ldrh.w r6, [fp, #824]
ldrh.w r7, [fp, #1528]
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
strh.w r3, [r0, #472]
strh.w r8, [r0, #824]
strh.w r6, [r0, #1176]
strh.w r9, [r0, #1528]
strh.w r5, [r0, #1880]
strh.w r7, [r0, #2232]
ldrh.w r1, [sp, #122]
ldrh.w r2, [sp, #826]
ldrh.w r3, [sp, #1530]
ldrh.w r4, [sp, #2234]
ldrh.w r5, [fp, #122]
ldrh.w r6, [fp, #826]
ldrh.w r7, [fp, #1530]
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
strh.w r3, [r0, #474]
strh.w r8, [r0, #826]
strh.w r6, [r0, #1178]
strh.w r9, [r0, #1530]
strh.w r5, [r0, #1882]
strh.w r7, [r0, #2234]
ldrh.w r1, [sp, #124]
ldrh.w r2, [sp, #828]
ldrh.w r3, [sp, #1532]
ldrh.w r4, [sp, #2236]
ldrh.w r5, [fp, #124]
ldrh.w r6, [fp, #828]
ldrh.w r7, [fp, #1532]
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
strh.w r3, [r0, #476]
strh.w r8, [r0, #828]
strh.w r6, [r0, #1180]
strh.w r9, [r0, #1532]
strh.w r5, [r0, #1884]
strh.w r7, [r0, #2236]
ldrh.w r1, [sp, #126]
ldrh.w r2, [sp, #830]
ldrh.w r3, [sp, #1534]
ldrh.w r4, [sp, #2238]
ldrh.w r5, [fp, #126]
ldrh.w r6, [fp, #830]
ldrh.w r7, [fp, #1534]
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
strh.w r3, [r0, #478]
strh.w r8, [r0, #830]
strh.w r6, [r0, #1182]
strh.w r9, [r0, #1534]
strh.w r5, [r0, #1886]
strh.w r7, [r0, #2238]
ldrh.w r1, [sp, #128]
ldrh.w r2, [sp, #832]
ldrh.w r3, [sp, #1536]
ldrh.w r4, [sp, #2240]
ldrh.w r5, [fp, #128]
ldrh.w r6, [fp, #832]
ldrh.w r7, [fp, #1536]
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
strh.w r1, [r0, #128]
strh.w r3, [r0, #480]
strh.w r8, [r0, #832]
strh.w r6, [r0, #1184]
strh.w r9, [r0, #1536]
strh.w r5, [r0, #1888]
strh.w r7, [r0, #2240]
ldrh.w r1, [sp, #130]
ldrh.w r2, [sp, #834]
ldrh.w r3, [sp, #1538]
ldrh.w r4, [sp, #2242]
ldrh.w r5, [fp, #130]
ldrh.w r6, [fp, #834]
ldrh.w r7, [fp, #1538]
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
strh.w r1, [r0, #130]
strh.w r3, [r0, #482]
strh.w r8, [r0, #834]
strh.w r6, [r0, #1186]
strh.w r9, [r0, #1538]
strh.w r5, [r0, #1890]
strh.w r7, [r0, #2242]
ldrh.w r1, [sp, #132]
ldrh.w r2, [sp, #836]
ldrh.w r3, [sp, #1540]
ldrh.w r4, [sp, #2244]
ldrh.w r5, [fp, #132]
ldrh.w r6, [fp, #836]
ldrh.w r7, [fp, #1540]
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
strh.w r1, [r0, #132]
strh.w r3, [r0, #484]
strh.w r8, [r0, #836]
strh.w r6, [r0, #1188]
strh.w r9, [r0, #1540]
strh.w r5, [r0, #1892]
strh.w r7, [r0, #2244]
ldrh.w r1, [sp, #134]
ldrh.w r2, [sp, #838]
ldrh.w r3, [sp, #1542]
ldrh.w r4, [sp, #2246]
ldrh.w r5, [fp, #134]
ldrh.w r6, [fp, #838]
ldrh.w r7, [fp, #1542]
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
strh.w r1, [r0, #134]
strh.w r3, [r0, #486]
strh.w r8, [r0, #838]
strh.w r6, [r0, #1190]
strh.w r9, [r0, #1542]
strh.w r5, [r0, #1894]
strh.w r7, [r0, #2246]
ldrh.w r1, [sp, #136]
ldrh.w r2, [sp, #840]
ldrh.w r3, [sp, #1544]
ldrh.w r4, [sp, #2248]
ldrh.w r5, [fp, #136]
ldrh.w r6, [fp, #840]
ldrh.w r7, [fp, #1544]
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
strh.w r1, [r0, #136]
strh.w r3, [r0, #488]
strh.w r8, [r0, #840]
strh.w r6, [r0, #1192]
strh.w r9, [r0, #1544]
strh.w r5, [r0, #1896]
strh.w r7, [r0, #2248]
ldrh.w r1, [sp, #138]
ldrh.w r2, [sp, #842]
ldrh.w r3, [sp, #1546]
ldrh.w r4, [sp, #2250]
ldrh.w r5, [fp, #138]
ldrh.w r6, [fp, #842]
ldrh.w r7, [fp, #1546]
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
strh.w r1, [r0, #138]
strh.w r3, [r0, #490]
strh.w r8, [r0, #842]
strh.w r6, [r0, #1194]
strh.w r9, [r0, #1546]
strh.w r5, [r0, #1898]
strh.w r7, [r0, #2250]
ldrh.w r1, [sp, #140]
ldrh.w r2, [sp, #844]
ldrh.w r3, [sp, #1548]
ldrh.w r4, [sp, #2252]
ldrh.w r5, [fp, #140]
ldrh.w r6, [fp, #844]
ldrh.w r7, [fp, #1548]
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
strh.w r1, [r0, #140]
strh.w r3, [r0, #492]
strh.w r8, [r0, #844]
strh.w r6, [r0, #1196]
strh.w r9, [r0, #1548]
strh.w r5, [r0, #1900]
strh.w r7, [r0, #2252]
ldrh.w r1, [sp, #142]
ldrh.w r2, [sp, #846]
ldrh.w r3, [sp, #1550]
ldrh.w r4, [sp, #2254]
ldrh.w r5, [fp, #142]
ldrh.w r6, [fp, #846]
ldrh.w r7, [fp, #1550]
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
strh.w r1, [r0, #142]
strh.w r3, [r0, #494]
strh.w r8, [r0, #846]
strh.w r6, [r0, #1198]
strh.w r9, [r0, #1550]
strh.w r5, [r0, #1902]
strh.w r7, [r0, #2254]
ldrh.w r1, [sp, #144]
ldrh.w r2, [sp, #848]
ldrh.w r3, [sp, #1552]
ldrh.w r4, [sp, #2256]
ldrh.w r5, [fp, #144]
ldrh.w r6, [fp, #848]
ldrh.w r7, [fp, #1552]
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
strh.w r1, [r0, #144]
strh.w r3, [r0, #496]
strh.w r8, [r0, #848]
strh.w r6, [r0, #1200]
strh.w r9, [r0, #1552]
strh.w r5, [r0, #1904]
strh.w r7, [r0, #2256]
ldrh.w r1, [sp, #146]
ldrh.w r2, [sp, #850]
ldrh.w r3, [sp, #1554]
ldrh.w r4, [sp, #2258]
ldrh.w r5, [fp, #146]
ldrh.w r6, [fp, #850]
ldrh.w r7, [fp, #1554]
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
strh.w r1, [r0, #146]
strh.w r3, [r0, #498]
strh.w r8, [r0, #850]
strh.w r6, [r0, #1202]
strh.w r9, [r0, #1554]
strh.w r5, [r0, #1906]
strh.w r7, [r0, #2258]
ldrh.w r1, [sp, #148]
ldrh.w r2, [sp, #852]
ldrh.w r3, [sp, #1556]
ldrh.w r4, [sp, #2260]
ldrh.w r5, [fp, #148]
ldrh.w r6, [fp, #852]
ldrh.w r7, [fp, #1556]
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
strh.w r1, [r0, #148]
strh.w r3, [r0, #500]
strh.w r8, [r0, #852]
strh.w r6, [r0, #1204]
strh.w r9, [r0, #1556]
strh.w r5, [r0, #1908]
strh.w r7, [r0, #2260]
ldrh.w r1, [sp, #150]
ldrh.w r2, [sp, #854]
ldrh.w r3, [sp, #1558]
ldrh.w r4, [sp, #2262]
ldrh.w r5, [fp, #150]
ldrh.w r6, [fp, #854]
ldrh.w r7, [fp, #1558]
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
strh.w r1, [r0, #150]
strh.w r3, [r0, #502]
strh.w r8, [r0, #854]
strh.w r6, [r0, #1206]
strh.w r9, [r0, #1558]
strh.w r5, [r0, #1910]
strh.w r7, [r0, #2262]
ldrh.w r1, [sp, #152]
ldrh.w r2, [sp, #856]
ldrh.w r3, [sp, #1560]
ldrh.w r4, [sp, #2264]
ldrh.w r5, [fp, #152]
ldrh.w r6, [fp, #856]
ldrh.w r7, [fp, #1560]
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
strh.w r1, [r0, #152]
strh.w r3, [r0, #504]
strh.w r8, [r0, #856]
strh.w r6, [r0, #1208]
strh.w r9, [r0, #1560]
strh.w r5, [r0, #1912]
strh.w r7, [r0, #2264]
ldrh.w r1, [sp, #154]
ldrh.w r2, [sp, #858]
ldrh.w r3, [sp, #1562]
ldrh.w r4, [sp, #2266]
ldrh.w r5, [fp, #154]
ldrh.w r6, [fp, #858]
ldrh.w r7, [fp, #1562]
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
strh.w r1, [r0, #154]
strh.w r3, [r0, #506]
strh.w r8, [r0, #858]
strh.w r6, [r0, #1210]
strh.w r9, [r0, #1562]
strh.w r5, [r0, #1914]
strh.w r7, [r0, #2266]
ldrh.w r1, [sp, #156]
ldrh.w r2, [sp, #860]
ldrh.w r3, [sp, #1564]
ldrh.w r4, [sp, #2268]
ldrh.w r5, [fp, #156]
ldrh.w r6, [fp, #860]
ldrh.w r7, [fp, #1564]
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
strh.w r1, [r0, #156]
strh.w r3, [r0, #508]
strh.w r8, [r0, #860]
strh.w r6, [r0, #1212]
strh.w r9, [r0, #1564]
strh.w r5, [r0, #1916]
strh.w r7, [r0, #2268]
ldrh.w r1, [sp, #158]
ldrh.w r2, [sp, #862]
ldrh.w r3, [sp, #1566]
ldrh.w r4, [sp, #2270]
ldrh.w r5, [fp, #158]
ldrh.w r6, [fp, #862]
ldrh.w r7, [fp, #1566]
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
strh.w r1, [r0, #158]
strh.w r3, [r0, #510]
strh.w r8, [r0, #862]
strh.w r6, [r0, #1214]
strh.w r9, [r0, #1566]
strh.w r5, [r0, #1918]
strh.w r7, [r0, #2270]
ldrh.w r1, [sp, #160]
ldrh.w r2, [sp, #864]
ldrh.w r3, [sp, #1568]
ldrh.w r4, [sp, #2272]
ldrh.w r5, [fp, #160]
ldrh.w r6, [fp, #864]
ldrh.w r7, [fp, #1568]
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
strh.w r1, [r0, #160]
strh.w r3, [r0, #512]
strh.w r8, [r0, #864]
strh.w r6, [r0, #1216]
strh.w r9, [r0, #1568]
strh.w r5, [r0, #1920]
strh.w r7, [r0, #2272]
ldrh.w r1, [sp, #162]
ldrh.w r2, [sp, #866]
ldrh.w r3, [sp, #1570]
ldrh.w r4, [sp, #2274]
ldrh.w r5, [fp, #162]
ldrh.w r6, [fp, #866]
ldrh.w r7, [fp, #1570]
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
strh.w r1, [r0, #162]
strh.w r3, [r0, #514]
strh.w r8, [r0, #866]
strh.w r6, [r0, #1218]
strh.w r9, [r0, #1570]
strh.w r5, [r0, #1922]
strh.w r7, [r0, #2274]
ldrh.w r1, [sp, #164]
ldrh.w r2, [sp, #868]
ldrh.w r3, [sp, #1572]
ldrh.w r4, [sp, #2276]
ldrh.w r5, [fp, #164]
ldrh.w r6, [fp, #868]
ldrh.w r7, [fp, #1572]
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
strh.w r1, [r0, #164]
strh.w r3, [r0, #516]
strh.w r8, [r0, #868]
strh.w r6, [r0, #1220]
strh.w r9, [r0, #1572]
strh.w r5, [r0, #1924]
strh.w r7, [r0, #2276]
ldrh.w r1, [sp, #166]
ldrh.w r2, [sp, #870]
ldrh.w r3, [sp, #1574]
ldrh.w r4, [sp, #2278]
ldrh.w r5, [fp, #166]
ldrh.w r6, [fp, #870]
ldrh.w r7, [fp, #1574]
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
strh.w r1, [r0, #166]
strh.w r3, [r0, #518]
strh.w r8, [r0, #870]
strh.w r6, [r0, #1222]
strh.w r9, [r0, #1574]
strh.w r5, [r0, #1926]
strh.w r7, [r0, #2278]
ldrh.w r1, [sp, #168]
ldrh.w r2, [sp, #872]
ldrh.w r3, [sp, #1576]
ldrh.w r4, [sp, #2280]
ldrh.w r5, [fp, #168]
ldrh.w r6, [fp, #872]
ldrh.w r7, [fp, #1576]
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
strh.w r1, [r0, #168]
strh.w r3, [r0, #520]
strh.w r8, [r0, #872]
strh.w r6, [r0, #1224]
strh.w r9, [r0, #1576]
strh.w r5, [r0, #1928]
strh.w r7, [r0, #2280]
ldrh.w r1, [sp, #170]
ldrh.w r2, [sp, #874]
ldrh.w r3, [sp, #1578]
ldrh.w r4, [sp, #2282]
ldrh.w r5, [fp, #170]
ldrh.w r6, [fp, #874]
ldrh.w r7, [fp, #1578]
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
strh.w r1, [r0, #170]
strh.w r3, [r0, #522]
strh.w r8, [r0, #874]
strh.w r6, [r0, #1226]
strh.w r9, [r0, #1578]
strh.w r5, [r0, #1930]
strh.w r7, [r0, #2282]
ldrh.w r1, [sp, #172]
ldrh.w r2, [sp, #876]
ldrh.w r3, [sp, #1580]
ldrh.w r4, [sp, #2284]
ldrh.w r5, [fp, #172]
ldrh.w r6, [fp, #876]
ldrh.w r7, [fp, #1580]
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
strh.w r1, [r0, #172]
strh.w r3, [r0, #524]
strh.w r8, [r0, #876]
strh.w r6, [r0, #1228]
strh.w r9, [r0, #1580]
strh.w r5, [r0, #1932]
strh.w r7, [r0, #2284]
ldrh.w r1, [sp, #174]
ldrh.w r2, [sp, #878]
ldrh.w r3, [sp, #1582]
ldrh.w r4, [sp, #2286]
ldrh.w r5, [fp, #174]
ldrh.w r6, [fp, #878]
ldrh.w r7, [fp, #1582]
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
strh.w r1, [r0, #174]
strh.w r3, [r0, #526]
strh.w r8, [r0, #878]
strh.w r6, [r0, #1230]
strh.w r9, [r0, #1582]
strh.w r5, [r0, #1934]
strh.w r7, [r0, #2286]
ldrh.w r1, [sp, #176]
ldrh.w r2, [sp, #880]
ldrh.w r3, [sp, #1584]
ldrh.w r4, [sp, #2288]
ldrh.w r5, [fp, #176]
ldrh.w r6, [fp, #880]
ldrh.w r7, [fp, #1584]
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
strh.w r1, [r0, #176]
strh.w r3, [r0, #528]
strh.w r8, [r0, #880]
strh.w r6, [r0, #1232]
strh.w r9, [r0, #1584]
strh.w r5, [r0, #1936]
strh.w r7, [r0, #2288]
ldrh.w r1, [sp, #178]
ldrh.w r2, [sp, #882]
ldrh.w r3, [sp, #1586]
ldrh.w r4, [sp, #2290]
ldrh.w r5, [fp, #178]
ldrh.w r6, [fp, #882]
ldrh.w r7, [fp, #1586]
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
strh.w r1, [r0, #178]
strh.w r3, [r0, #530]
strh.w r8, [r0, #882]
strh.w r6, [r0, #1234]
strh.w r9, [r0, #1586]
strh.w r5, [r0, #1938]
strh.w r7, [r0, #2290]
ldrh.w r1, [sp, #180]
ldrh.w r2, [sp, #884]
ldrh.w r3, [sp, #1588]
ldrh.w r4, [sp, #2292]
ldrh.w r5, [fp, #180]
ldrh.w r6, [fp, #884]
ldrh.w r7, [fp, #1588]
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
strh.w r1, [r0, #180]
strh.w r3, [r0, #532]
strh.w r8, [r0, #884]
strh.w r6, [r0, #1236]
strh.w r9, [r0, #1588]
strh.w r5, [r0, #1940]
strh.w r7, [r0, #2292]
ldrh.w r1, [sp, #182]
ldrh.w r2, [sp, #886]
ldrh.w r3, [sp, #1590]
ldrh.w r4, [sp, #2294]
ldrh.w r5, [fp, #182]
ldrh.w r6, [fp, #886]
ldrh.w r7, [fp, #1590]
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
strh.w r1, [r0, #182]
strh.w r3, [r0, #534]
strh.w r8, [r0, #886]
strh.w r6, [r0, #1238]
strh.w r9, [r0, #1590]
strh.w r5, [r0, #1942]
strh.w r7, [r0, #2294]
ldrh.w r1, [sp, #184]
ldrh.w r2, [sp, #888]
ldrh.w r3, [sp, #1592]
ldrh.w r4, [sp, #2296]
ldrh.w r5, [fp, #184]
ldrh.w r6, [fp, #888]
ldrh.w r7, [fp, #1592]
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
strh.w r1, [r0, #184]
strh.w r3, [r0, #536]
strh.w r8, [r0, #888]
strh.w r6, [r0, #1240]
strh.w r9, [r0, #1592]
strh.w r5, [r0, #1944]
strh.w r7, [r0, #2296]
ldrh.w r1, [sp, #186]
ldrh.w r2, [sp, #890]
ldrh.w r3, [sp, #1594]
ldrh.w r4, [sp, #2298]
ldrh.w r5, [fp, #186]
ldrh.w r6, [fp, #890]
ldrh.w r7, [fp, #1594]
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
strh.w r1, [r0, #186]
strh.w r3, [r0, #538]
strh.w r8, [r0, #890]
strh.w r6, [r0, #1242]
strh.w r9, [r0, #1594]
strh.w r5, [r0, #1946]
strh.w r7, [r0, #2298]
ldrh.w r1, [sp, #188]
ldrh.w r2, [sp, #892]
ldrh.w r3, [sp, #1596]
ldrh.w r4, [sp, #2300]
ldrh.w r5, [fp, #188]
ldrh.w r6, [fp, #892]
ldrh.w r7, [fp, #1596]
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
strh.w r1, [r0, #188]
strh.w r3, [r0, #540]
strh.w r8, [r0, #892]
strh.w r6, [r0, #1244]
strh.w r9, [r0, #1596]
strh.w r5, [r0, #1948]
strh.w r7, [r0, #2300]
ldrh.w r1, [sp, #190]
ldrh.w r2, [sp, #894]
ldrh.w r3, [sp, #1598]
ldrh.w r4, [sp, #2302]
ldrh.w r5, [fp, #190]
ldrh.w r6, [fp, #894]
ldrh.w r7, [fp, #1598]
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
strh.w r1, [r0, #190]
strh.w r3, [r0, #542]
strh.w r8, [r0, #894]
strh.w r6, [r0, #1246]
strh.w r9, [r0, #1598]
strh.w r5, [r0, #1950]
strh.w r7, [r0, #2302]
ldrh.w r1, [sp, #192]
ldrh.w r2, [sp, #896]
ldrh.w r3, [sp, #1600]
ldrh.w r4, [sp, #2304]
ldrh.w r5, [fp, #192]
ldrh.w r6, [fp, #896]
ldrh.w r7, [fp, #1600]
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
strh.w r1, [r0, #192]
strh.w r3, [r0, #544]
strh.w r8, [r0, #896]
strh.w r6, [r0, #1248]
strh.w r9, [r0, #1600]
strh.w r5, [r0, #1952]
strh.w r7, [r0, #2304]
ldrh.w r1, [sp, #194]
ldrh.w r2, [sp, #898]
ldrh.w r3, [sp, #1602]
ldrh.w r4, [sp, #2306]
ldrh.w r5, [fp, #194]
ldrh.w r6, [fp, #898]
ldrh.w r7, [fp, #1602]
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
strh.w r1, [r0, #194]
strh.w r3, [r0, #546]
strh.w r8, [r0, #898]
strh.w r6, [r0, #1250]
strh.w r9, [r0, #1602]
strh.w r5, [r0, #1954]
strh.w r7, [r0, #2306]
ldrh.w r1, [sp, #196]
ldrh.w r2, [sp, #900]
ldrh.w r3, [sp, #1604]
ldrh.w r4, [sp, #2308]
ldrh.w r5, [fp, #196]
ldrh.w r6, [fp, #900]
ldrh.w r7, [fp, #1604]
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
strh.w r1, [r0, #196]
strh.w r3, [r0, #548]
strh.w r8, [r0, #900]
strh.w r6, [r0, #1252]
strh.w r9, [r0, #1604]
strh.w r5, [r0, #1956]
strh.w r7, [r0, #2308]
ldrh.w r1, [sp, #198]
ldrh.w r2, [sp, #902]
ldrh.w r3, [sp, #1606]
ldrh.w r4, [sp, #2310]
ldrh.w r5, [fp, #198]
ldrh.w r6, [fp, #902]
ldrh.w r7, [fp, #1606]
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
strh.w r1, [r0, #198]
strh.w r3, [r0, #550]
strh.w r8, [r0, #902]
strh.w r6, [r0, #1254]
strh.w r9, [r0, #1606]
strh.w r5, [r0, #1958]
strh.w r7, [r0, #2310]
ldrh.w r1, [sp, #200]
ldrh.w r2, [sp, #904]
ldrh.w r3, [sp, #1608]
ldrh.w r4, [sp, #2312]
ldrh.w r5, [fp, #200]
ldrh.w r6, [fp, #904]
ldrh.w r7, [fp, #1608]
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
strh.w r1, [r0, #200]
strh.w r3, [r0, #552]
strh.w r8, [r0, #904]
strh.w r6, [r0, #1256]
strh.w r9, [r0, #1608]
strh.w r5, [r0, #1960]
strh.w r7, [r0, #2312]
ldrh.w r1, [sp, #202]
ldrh.w r2, [sp, #906]
ldrh.w r3, [sp, #1610]
ldrh.w r4, [sp, #2314]
ldrh.w r5, [fp, #202]
ldrh.w r6, [fp, #906]
ldrh.w r7, [fp, #1610]
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
strh.w r1, [r0, #202]
strh.w r3, [r0, #554]
strh.w r8, [r0, #906]
strh.w r6, [r0, #1258]
strh.w r9, [r0, #1610]
strh.w r5, [r0, #1962]
strh.w r7, [r0, #2314]
ldrh.w r1, [sp, #204]
ldrh.w r2, [sp, #908]
ldrh.w r3, [sp, #1612]
ldrh.w r4, [sp, #2316]
ldrh.w r5, [fp, #204]
ldrh.w r6, [fp, #908]
ldrh.w r7, [fp, #1612]
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
strh.w r1, [r0, #204]
strh.w r3, [r0, #556]
strh.w r8, [r0, #908]
strh.w r6, [r0, #1260]
strh.w r9, [r0, #1612]
strh.w r5, [r0, #1964]
strh.w r7, [r0, #2316]
ldrh.w r1, [sp, #206]
ldrh.w r2, [sp, #910]
ldrh.w r3, [sp, #1614]
ldrh.w r4, [sp, #2318]
ldrh.w r5, [fp, #206]
ldrh.w r6, [fp, #910]
ldrh.w r7, [fp, #1614]
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
strh.w r1, [r0, #206]
strh.w r3, [r0, #558]
strh.w r8, [r0, #910]
strh.w r6, [r0, #1262]
strh.w r9, [r0, #1614]
strh.w r5, [r0, #1966]
strh.w r7, [r0, #2318]
ldrh.w r1, [sp, #208]
ldrh.w r2, [sp, #912]
ldrh.w r3, [sp, #1616]
ldrh.w r4, [sp, #2320]
ldrh.w r5, [fp, #208]
ldrh.w r6, [fp, #912]
ldrh.w r7, [fp, #1616]
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
strh.w r1, [r0, #208]
strh.w r3, [r0, #560]
strh.w r8, [r0, #912]
strh.w r6, [r0, #1264]
strh.w r9, [r0, #1616]
strh.w r5, [r0, #1968]
strh.w r7, [r0, #2320]
ldrh.w r1, [sp, #210]
ldrh.w r2, [sp, #914]
ldrh.w r3, [sp, #1618]
ldrh.w r4, [sp, #2322]
ldrh.w r5, [fp, #210]
ldrh.w r6, [fp, #914]
ldrh.w r7, [fp, #1618]
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
strh.w r1, [r0, #210]
strh.w r3, [r0, #562]
strh.w r8, [r0, #914]
strh.w r6, [r0, #1266]
strh.w r9, [r0, #1618]
strh.w r5, [r0, #1970]
strh.w r7, [r0, #2322]
ldrh.w r1, [sp, #212]
ldrh.w r2, [sp, #916]
ldrh.w r3, [sp, #1620]
ldrh.w r4, [sp, #2324]
ldrh.w r5, [fp, #212]
ldrh.w r6, [fp, #916]
ldrh.w r7, [fp, #1620]
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
strh.w r1, [r0, #212]
strh.w r3, [r0, #564]
strh.w r8, [r0, #916]
strh.w r6, [r0, #1268]
strh.w r9, [r0, #1620]
strh.w r5, [r0, #1972]
strh.w r7, [r0, #2324]
ldrh.w r1, [sp, #214]
ldrh.w r2, [sp, #918]
ldrh.w r3, [sp, #1622]
ldrh.w r4, [sp, #2326]
ldrh.w r5, [fp, #214]
ldrh.w r6, [fp, #918]
ldrh.w r7, [fp, #1622]
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
strh.w r1, [r0, #214]
strh.w r3, [r0, #566]
strh.w r8, [r0, #918]
strh.w r6, [r0, #1270]
strh.w r9, [r0, #1622]
strh.w r5, [r0, #1974]
strh.w r7, [r0, #2326]
ldrh.w r1, [sp, #216]
ldrh.w r2, [sp, #920]
ldrh.w r3, [sp, #1624]
ldrh.w r4, [sp, #2328]
ldrh.w r5, [fp, #216]
ldrh.w r6, [fp, #920]
ldrh.w r7, [fp, #1624]
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
strh.w r1, [r0, #216]
strh.w r3, [r0, #568]
strh.w r8, [r0, #920]
strh.w r6, [r0, #1272]
strh.w r9, [r0, #1624]
strh.w r5, [r0, #1976]
strh.w r7, [r0, #2328]
ldrh.w r1, [sp, #218]
ldrh.w r2, [sp, #922]
ldrh.w r3, [sp, #1626]
ldrh.w r4, [sp, #2330]
ldrh.w r5, [fp, #218]
ldrh.w r6, [fp, #922]
ldrh.w r7, [fp, #1626]
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
strh.w r1, [r0, #218]
strh.w r3, [r0, #570]
strh.w r8, [r0, #922]
strh.w r6, [r0, #1274]
strh.w r9, [r0, #1626]
strh.w r5, [r0, #1978]
strh.w r7, [r0, #2330]
ldrh.w r1, [sp, #220]
ldrh.w r2, [sp, #924]
ldrh.w r3, [sp, #1628]
ldrh.w r4, [sp, #2332]
ldrh.w r5, [fp, #220]
ldrh.w r6, [fp, #924]
ldrh.w r7, [fp, #1628]
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
strh.w r1, [r0, #220]
strh.w r3, [r0, #572]
strh.w r8, [r0, #924]
strh.w r6, [r0, #1276]
strh.w r9, [r0, #1628]
strh.w r5, [r0, #1980]
strh.w r7, [r0, #2332]
ldrh.w r1, [sp, #222]
ldrh.w r2, [sp, #926]
ldrh.w r3, [sp, #1630]
ldrh.w r4, [sp, #2334]
ldrh.w r5, [fp, #222]
ldrh.w r6, [fp, #926]
ldrh.w r7, [fp, #1630]
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
strh.w r1, [r0, #222]
strh.w r3, [r0, #574]
strh.w r8, [r0, #926]
strh.w r6, [r0, #1278]
strh.w r9, [r0, #1630]
strh.w r5, [r0, #1982]
strh.w r7, [r0, #2334]
ldrh.w r1, [sp, #224]
ldrh.w r2, [sp, #928]
ldrh.w r3, [sp, #1632]
ldrh.w r4, [sp, #2336]
ldrh.w r5, [fp, #224]
ldrh.w r6, [fp, #928]
ldrh.w r7, [fp, #1632]
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
strh.w r1, [r0, #224]
strh.w r3, [r0, #576]
strh.w r8, [r0, #928]
strh.w r6, [r0, #1280]
strh.w r9, [r0, #1632]
strh.w r5, [r0, #1984]
strh.w r7, [r0, #2336]
ldrh.w r1, [sp, #226]
ldrh.w r2, [sp, #930]
ldrh.w r3, [sp, #1634]
ldrh.w r4, [sp, #2338]
ldrh.w r5, [fp, #226]
ldrh.w r6, [fp, #930]
ldrh.w r7, [fp, #1634]
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
strh.w r1, [r0, #226]
strh.w r3, [r0, #578]
strh.w r8, [r0, #930]
strh.w r6, [r0, #1282]
strh.w r9, [r0, #1634]
strh.w r5, [r0, #1986]
strh.w r7, [r0, #2338]
ldrh.w r1, [sp, #228]
ldrh.w r2, [sp, #932]
ldrh.w r3, [sp, #1636]
ldrh.w r4, [sp, #2340]
ldrh.w r5, [fp, #228]
ldrh.w r6, [fp, #932]
ldrh.w r7, [fp, #1636]
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
strh.w r1, [r0, #228]
strh.w r3, [r0, #580]
strh.w r8, [r0, #932]
strh.w r6, [r0, #1284]
strh.w r9, [r0, #1636]
strh.w r5, [r0, #1988]
strh.w r7, [r0, #2340]
ldrh.w r1, [sp, #230]
ldrh.w r2, [sp, #934]
ldrh.w r3, [sp, #1638]
ldrh.w r4, [sp, #2342]
ldrh.w r5, [fp, #230]
ldrh.w r6, [fp, #934]
ldrh.w r7, [fp, #1638]
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
strh.w r1, [r0, #230]
strh.w r3, [r0, #582]
strh.w r8, [r0, #934]
strh.w r6, [r0, #1286]
strh.w r9, [r0, #1638]
strh.w r5, [r0, #1990]
strh.w r7, [r0, #2342]
ldrh.w r1, [sp, #232]
ldrh.w r2, [sp, #936]
ldrh.w r3, [sp, #1640]
ldrh.w r4, [sp, #2344]
ldrh.w r5, [fp, #232]
ldrh.w r6, [fp, #936]
ldrh.w r7, [fp, #1640]
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
strh.w r1, [r0, #232]
strh.w r3, [r0, #584]
strh.w r8, [r0, #936]
strh.w r6, [r0, #1288]
strh.w r9, [r0, #1640]
strh.w r5, [r0, #1992]
strh.w r7, [r0, #2344]
ldrh.w r1, [sp, #234]
ldrh.w r2, [sp, #938]
ldrh.w r3, [sp, #1642]
ldrh.w r4, [sp, #2346]
ldrh.w r5, [fp, #234]
ldrh.w r6, [fp, #938]
ldrh.w r7, [fp, #1642]
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
strh.w r1, [r0, #234]
strh.w r3, [r0, #586]
strh.w r8, [r0, #938]
strh.w r6, [r0, #1290]
strh.w r9, [r0, #1642]
strh.w r5, [r0, #1994]
strh.w r7, [r0, #2346]
ldrh.w r1, [sp, #236]
ldrh.w r2, [sp, #940]
ldrh.w r3, [sp, #1644]
ldrh.w r4, [sp, #2348]
ldrh.w r5, [fp, #236]
ldrh.w r6, [fp, #940]
ldrh.w r7, [fp, #1644]
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
strh.w r1, [r0, #236]
strh.w r3, [r0, #588]
strh.w r8, [r0, #940]
strh.w r6, [r0, #1292]
strh.w r9, [r0, #1644]
strh.w r5, [r0, #1996]
strh.w r7, [r0, #2348]
ldrh.w r1, [sp, #238]
ldrh.w r2, [sp, #942]
ldrh.w r3, [sp, #1646]
ldrh.w r4, [sp, #2350]
ldrh.w r5, [fp, #238]
ldrh.w r6, [fp, #942]
ldrh.w r7, [fp, #1646]
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
strh.w r1, [r0, #238]
strh.w r3, [r0, #590]
strh.w r8, [r0, #942]
strh.w r6, [r0, #1294]
strh.w r9, [r0, #1646]
strh.w r5, [r0, #1998]
strh.w r7, [r0, #2350]
ldrh.w r1, [sp, #240]
ldrh.w r2, [sp, #944]
ldrh.w r3, [sp, #1648]
ldrh.w r4, [sp, #2352]
ldrh.w r5, [fp, #240]
ldrh.w r6, [fp, #944]
ldrh.w r7, [fp, #1648]
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
strh.w r1, [r0, #240]
strh.w r3, [r0, #592]
strh.w r8, [r0, #944]
strh.w r6, [r0, #1296]
strh.w r9, [r0, #1648]
strh.w r5, [r0, #2000]
strh.w r7, [r0, #2352]
ldrh.w r1, [sp, #242]
ldrh.w r2, [sp, #946]
ldrh.w r3, [sp, #1650]
ldrh.w r4, [sp, #2354]
ldrh.w r5, [fp, #242]
ldrh.w r6, [fp, #946]
ldrh.w r7, [fp, #1650]
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
strh.w r1, [r0, #242]
strh.w r3, [r0, #594]
strh.w r8, [r0, #946]
strh.w r6, [r0, #1298]
strh.w r9, [r0, #1650]
strh.w r5, [r0, #2002]
strh.w r7, [r0, #2354]
ldrh.w r1, [sp, #244]
ldrh.w r2, [sp, #948]
ldrh.w r3, [sp, #1652]
ldrh.w r4, [sp, #2356]
ldrh.w r5, [fp, #244]
ldrh.w r6, [fp, #948]
ldrh.w r7, [fp, #1652]
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
strh.w r1, [r0, #244]
strh.w r3, [r0, #596]
strh.w r8, [r0, #948]
strh.w r6, [r0, #1300]
strh.w r9, [r0, #1652]
strh.w r5, [r0, #2004]
strh.w r7, [r0, #2356]
ldrh.w r1, [sp, #246]
ldrh.w r2, [sp, #950]
ldrh.w r3, [sp, #1654]
ldrh.w r4, [sp, #2358]
ldrh.w r5, [fp, #246]
ldrh.w r6, [fp, #950]
ldrh.w r7, [fp, #1654]
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
strh.w r1, [r0, #246]
strh.w r3, [r0, #598]
strh.w r8, [r0, #950]
strh.w r6, [r0, #1302]
strh.w r9, [r0, #1654]
strh.w r5, [r0, #2006]
strh.w r7, [r0, #2358]
ldrh.w r1, [sp, #248]
ldrh.w r2, [sp, #952]
ldrh.w r3, [sp, #1656]
ldrh.w r4, [sp, #2360]
ldrh.w r5, [fp, #248]
ldrh.w r6, [fp, #952]
ldrh.w r7, [fp, #1656]
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
strh.w r1, [r0, #248]
strh.w r3, [r0, #600]
strh.w r8, [r0, #952]
strh.w r6, [r0, #1304]
strh.w r9, [r0, #1656]
strh.w r5, [r0, #2008]
strh.w r7, [r0, #2360]
ldrh.w r1, [sp, #250]
ldrh.w r2, [sp, #954]
ldrh.w r3, [sp, #1658]
ldrh.w r4, [sp, #2362]
ldrh.w r5, [fp, #250]
ldrh.w r6, [fp, #954]
ldrh.w r7, [fp, #1658]
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
strh.w r1, [r0, #250]
strh.w r3, [r0, #602]
strh.w r8, [r0, #954]
strh.w r6, [r0, #1306]
strh.w r9, [r0, #1658]
strh.w r5, [r0, #2010]
strh.w r7, [r0, #2362]
ldrh.w r1, [sp, #252]
ldrh.w r2, [sp, #956]
ldrh.w r3, [sp, #1660]
ldrh.w r4, [sp, #2364]
ldrh.w r5, [fp, #252]
ldrh.w r6, [fp, #956]
ldrh.w r7, [fp, #1660]
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
strh.w r1, [r0, #252]
strh.w r3, [r0, #604]
strh.w r8, [r0, #956]
strh.w r6, [r0, #1308]
strh.w r9, [r0, #1660]
strh.w r5, [r0, #2012]
strh.w r7, [r0, #2364]
ldrh.w r1, [sp, #254]
ldrh.w r2, [sp, #958]
ldrh.w r3, [sp, #1662]
ldrh.w r4, [sp, #2366]
ldrh.w r5, [fp, #254]
ldrh.w r6, [fp, #958]
ldrh.w r7, [fp, #1662]
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
strh.w r1, [r0, #254]
strh.w r3, [r0, #606]
strh.w r8, [r0, #958]
strh.w r6, [r0, #1310]
strh.w r9, [r0, #1662]
strh.w r5, [r0, #2014]
strh.w r7, [r0, #2366]
ldrh.w r1, [sp, #256]
ldrh.w r2, [sp, #960]
ldrh.w r3, [sp, #1664]
ldrh.w r4, [sp, #2368]
ldrh.w r5, [fp, #256]
ldrh.w r6, [fp, #960]
ldrh.w r7, [fp, #1664]
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
strh.w r1, [r0, #256]
strh.w r3, [r0, #608]
strh.w r8, [r0, #960]
strh.w r6, [r0, #1312]
strh.w r9, [r0, #1664]
strh.w r5, [r0, #2016]
strh.w r7, [r0, #2368]
ldrh.w r1, [sp, #258]
ldrh.w r2, [sp, #962]
ldrh.w r3, [sp, #1666]
ldrh.w r4, [sp, #2370]
ldrh.w r5, [fp, #258]
ldrh.w r6, [fp, #962]
ldrh.w r7, [fp, #1666]
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
strh.w r1, [r0, #258]
strh.w r3, [r0, #610]
strh.w r8, [r0, #962]
strh.w r6, [r0, #1314]
strh.w r9, [r0, #1666]
strh.w r5, [r0, #2018]
strh.w r7, [r0, #2370]
ldrh.w r1, [sp, #260]
ldrh.w r2, [sp, #964]
ldrh.w r3, [sp, #1668]
ldrh.w r4, [sp, #2372]
ldrh.w r5, [fp, #260]
ldrh.w r6, [fp, #964]
ldrh.w r7, [fp, #1668]
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
strh.w r1, [r0, #260]
strh.w r3, [r0, #612]
strh.w r8, [r0, #964]
strh.w r6, [r0, #1316]
strh.w r9, [r0, #1668]
strh.w r5, [r0, #2020]
strh.w r7, [r0, #2372]
ldrh.w r1, [sp, #262]
ldrh.w r2, [sp, #966]
ldrh.w r3, [sp, #1670]
ldrh.w r4, [sp, #2374]
ldrh.w r5, [fp, #262]
ldrh.w r6, [fp, #966]
ldrh.w r7, [fp, #1670]
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
strh.w r1, [r0, #262]
strh.w r3, [r0, #614]
strh.w r8, [r0, #966]
strh.w r6, [r0, #1318]
strh.w r9, [r0, #1670]
strh.w r5, [r0, #2022]
strh.w r7, [r0, #2374]
ldrh.w r1, [sp, #264]
ldrh.w r2, [sp, #968]
ldrh.w r3, [sp, #1672]
ldrh.w r4, [sp, #2376]
ldrh.w r5, [fp, #264]
ldrh.w r6, [fp, #968]
ldrh.w r7, [fp, #1672]
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
strh.w r1, [r0, #264]
strh.w r3, [r0, #616]
strh.w r8, [r0, #968]
strh.w r6, [r0, #1320]
strh.w r9, [r0, #1672]
strh.w r5, [r0, #2024]
strh.w r7, [r0, #2376]
ldrh.w r1, [sp, #266]
ldrh.w r2, [sp, #970]
ldrh.w r3, [sp, #1674]
ldrh.w r4, [sp, #2378]
ldrh.w r5, [fp, #266]
ldrh.w r6, [fp, #970]
ldrh.w r7, [fp, #1674]
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
strh.w r1, [r0, #266]
strh.w r3, [r0, #618]
strh.w r8, [r0, #970]
strh.w r6, [r0, #1322]
strh.w r9, [r0, #1674]
strh.w r5, [r0, #2026]
strh.w r7, [r0, #2378]
ldrh.w r1, [sp, #268]
ldrh.w r2, [sp, #972]
ldrh.w r3, [sp, #1676]
ldrh.w r4, [sp, #2380]
ldrh.w r5, [fp, #268]
ldrh.w r6, [fp, #972]
ldrh.w r7, [fp, #1676]
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
strh.w r1, [r0, #268]
strh.w r3, [r0, #620]
strh.w r8, [r0, #972]
strh.w r6, [r0, #1324]
strh.w r9, [r0, #1676]
strh.w r5, [r0, #2028]
strh.w r7, [r0, #2380]
ldrh.w r1, [sp, #270]
ldrh.w r2, [sp, #974]
ldrh.w r3, [sp, #1678]
ldrh.w r4, [sp, #2382]
ldrh.w r5, [fp, #270]
ldrh.w r6, [fp, #974]
ldrh.w r7, [fp, #1678]
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
strh.w r1, [r0, #270]
strh.w r3, [r0, #622]
strh.w r8, [r0, #974]
strh.w r6, [r0, #1326]
strh.w r9, [r0, #1678]
strh.w r5, [r0, #2030]
strh.w r7, [r0, #2382]
ldrh.w r1, [sp, #272]
ldrh.w r2, [sp, #976]
ldrh.w r3, [sp, #1680]
ldrh.w r4, [sp, #2384]
ldrh.w r5, [fp, #272]
ldrh.w r6, [fp, #976]
ldrh.w r7, [fp, #1680]
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
strh.w r1, [r0, #272]
strh.w r3, [r0, #624]
strh.w r8, [r0, #976]
strh.w r6, [r0, #1328]
strh.w r9, [r0, #1680]
strh.w r5, [r0, #2032]
strh.w r7, [r0, #2384]
ldrh.w r1, [sp, #274]
ldrh.w r2, [sp, #978]
ldrh.w r3, [sp, #1682]
ldrh.w r4, [sp, #2386]
ldrh.w r5, [fp, #274]
ldrh.w r6, [fp, #978]
ldrh.w r7, [fp, #1682]
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
strh.w r1, [r0, #274]
strh.w r3, [r0, #626]
strh.w r8, [r0, #978]
strh.w r6, [r0, #1330]
strh.w r9, [r0, #1682]
strh.w r5, [r0, #2034]
strh.w r7, [r0, #2386]
ldrh.w r1, [sp, #276]
ldrh.w r2, [sp, #980]
ldrh.w r3, [sp, #1684]
ldrh.w r4, [sp, #2388]
ldrh.w r5, [fp, #276]
ldrh.w r6, [fp, #980]
ldrh.w r7, [fp, #1684]
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
strh.w r1, [r0, #276]
strh.w r3, [r0, #628]
strh.w r8, [r0, #980]
strh.w r6, [r0, #1332]
strh.w r9, [r0, #1684]
strh.w r5, [r0, #2036]
strh.w r7, [r0, #2388]
ldrh.w r1, [sp, #278]
ldrh.w r2, [sp, #982]
ldrh.w r3, [sp, #1686]
ldrh.w r4, [sp, #2390]
ldrh.w r5, [fp, #278]
ldrh.w r6, [fp, #982]
ldrh.w r7, [fp, #1686]
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
strh.w r1, [r0, #278]
strh.w r3, [r0, #630]
strh.w r8, [r0, #982]
strh.w r6, [r0, #1334]
strh.w r9, [r0, #1686]
strh.w r5, [r0, #2038]
strh.w r7, [r0, #2390]
ldrh.w r1, [sp, #280]
ldrh.w r2, [sp, #984]
ldrh.w r3, [sp, #1688]
ldrh.w r4, [sp, #2392]
ldrh.w r5, [fp, #280]
ldrh.w r6, [fp, #984]
ldrh.w r7, [fp, #1688]
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
strh.w r1, [r0, #280]
strh.w r3, [r0, #632]
strh.w r8, [r0, #984]
strh.w r6, [r0, #1336]
strh.w r9, [r0, #1688]
strh.w r5, [r0, #2040]
strh.w r7, [r0, #2392]
ldrh.w r1, [sp, #282]
ldrh.w r2, [sp, #986]
ldrh.w r3, [sp, #1690]
ldrh.w r4, [sp, #2394]
ldrh.w r5, [fp, #282]
ldrh.w r6, [fp, #986]
ldrh.w r7, [fp, #1690]
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
strh.w r1, [r0, #282]
strh.w r3, [r0, #634]
strh.w r8, [r0, #986]
strh.w r6, [r0, #1338]
strh.w r9, [r0, #1690]
strh.w r5, [r0, #2042]
strh.w r7, [r0, #2394]
ldrh.w r1, [sp, #284]
ldrh.w r2, [sp, #988]
ldrh.w r3, [sp, #1692]
ldrh.w r4, [sp, #2396]
ldrh.w r5, [fp, #284]
ldrh.w r6, [fp, #988]
ldrh.w r7, [fp, #1692]
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
strh.w r1, [r0, #284]
strh.w r3, [r0, #636]
strh.w r8, [r0, #988]
strh.w r6, [r0, #1340]
strh.w r9, [r0, #1692]
strh.w r5, [r0, #2044]
strh.w r7, [r0, #2396]
ldrh.w r1, [sp, #286]
ldrh.w r2, [sp, #990]
ldrh.w r3, [sp, #1694]
ldrh.w r4, [sp, #2398]
ldrh.w r5, [fp, #286]
ldrh.w r6, [fp, #990]
ldrh.w r7, [fp, #1694]
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
strh.w r1, [r0, #286]
strh.w r3, [r0, #638]
strh.w r8, [r0, #990]
strh.w r6, [r0, #1342]
strh.w r9, [r0, #1694]
strh.w r5, [r0, #2046]
strh.w r7, [r0, #2398]
ldrh.w r1, [sp, #288]
ldrh.w r2, [sp, #992]
ldrh.w r3, [sp, #1696]
ldrh.w r4, [sp, #2400]
ldrh.w r5, [fp, #288]
ldrh.w r6, [fp, #992]
ldrh.w r7, [fp, #1696]
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
strh.w r1, [r0, #288]
strh.w r3, [r0, #640]
strh.w r8, [r0, #992]
strh.w r6, [r0, #1344]
strh.w r9, [r0, #1696]
strh.w r5, [r0, #2048]
strh.w r7, [r0, #2400]
ldrh.w r1, [sp, #290]
ldrh.w r2, [sp, #994]
ldrh.w r3, [sp, #1698]
ldrh.w r4, [sp, #2402]
ldrh.w r5, [fp, #290]
ldrh.w r6, [fp, #994]
ldrh.w r7, [fp, #1698]
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
strh.w r1, [r0, #290]
strh.w r3, [r0, #642]
strh.w r8, [r0, #994]
strh.w r6, [r0, #1346]
strh.w r9, [r0, #1698]
strh.w r5, [r0, #2050]
strh.w r7, [r0, #2402]
ldrh.w r1, [sp, #292]
ldrh.w r2, [sp, #996]
ldrh.w r3, [sp, #1700]
ldrh.w r4, [sp, #2404]
ldrh.w r5, [fp, #292]
ldrh.w r6, [fp, #996]
ldrh.w r7, [fp, #1700]
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
strh.w r1, [r0, #292]
strh.w r3, [r0, #644]
strh.w r8, [r0, #996]
strh.w r6, [r0, #1348]
strh.w r9, [r0, #1700]
strh.w r5, [r0, #2052]
strh.w r7, [r0, #2404]
ldrh.w r1, [sp, #294]
ldrh.w r2, [sp, #998]
ldrh.w r3, [sp, #1702]
ldrh.w r4, [sp, #2406]
ldrh.w r5, [fp, #294]
ldrh.w r6, [fp, #998]
ldrh.w r7, [fp, #1702]
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
strh.w r1, [r0, #294]
strh.w r3, [r0, #646]
strh.w r8, [r0, #998]
strh.w r6, [r0, #1350]
strh.w r9, [r0, #1702]
strh.w r5, [r0, #2054]
strh.w r7, [r0, #2406]
ldrh.w r1, [sp, #296]
ldrh.w r2, [sp, #1000]
ldrh.w r3, [sp, #1704]
ldrh.w r4, [sp, #2408]
ldrh.w r5, [fp, #296]
ldrh.w r6, [fp, #1000]
ldrh.w r7, [fp, #1704]
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
strh.w r1, [r0, #296]
strh.w r3, [r0, #648]
strh.w r8, [r0, #1000]
strh.w r6, [r0, #1352]
strh.w r9, [r0, #1704]
strh.w r5, [r0, #2056]
strh.w r7, [r0, #2408]
ldrh.w r1, [sp, #298]
ldrh.w r2, [sp, #1002]
ldrh.w r3, [sp, #1706]
ldrh.w r4, [sp, #2410]
ldrh.w r5, [fp, #298]
ldrh.w r6, [fp, #1002]
ldrh.w r7, [fp, #1706]
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
strh.w r1, [r0, #298]
strh.w r3, [r0, #650]
strh.w r8, [r0, #1002]
strh.w r6, [r0, #1354]
strh.w r9, [r0, #1706]
strh.w r5, [r0, #2058]
strh.w r7, [r0, #2410]
ldrh.w r1, [sp, #300]
ldrh.w r2, [sp, #1004]
ldrh.w r3, [sp, #1708]
ldrh.w r4, [sp, #2412]
ldrh.w r5, [fp, #300]
ldrh.w r6, [fp, #1004]
ldrh.w r7, [fp, #1708]
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
strh.w r1, [r0, #300]
strh.w r3, [r0, #652]
strh.w r8, [r0, #1004]
strh.w r6, [r0, #1356]
strh.w r9, [r0, #1708]
strh.w r5, [r0, #2060]
strh.w r7, [r0, #2412]
ldrh.w r1, [sp, #302]
ldrh.w r2, [sp, #1006]
ldrh.w r3, [sp, #1710]
ldrh.w r4, [sp, #2414]
ldrh.w r5, [fp, #302]
ldrh.w r6, [fp, #1006]
ldrh.w r7, [fp, #1710]
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
strh.w r1, [r0, #302]
strh.w r3, [r0, #654]
strh.w r8, [r0, #1006]
strh.w r6, [r0, #1358]
strh.w r9, [r0, #1710]
strh.w r5, [r0, #2062]
strh.w r7, [r0, #2414]
ldrh.w r1, [sp, #304]
ldrh.w r2, [sp, #1008]
ldrh.w r3, [sp, #1712]
ldrh.w r4, [sp, #2416]
ldrh.w r5, [fp, #304]
ldrh.w r6, [fp, #1008]
ldrh.w r7, [fp, #1712]
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
strh.w r1, [r0, #304]
strh.w r3, [r0, #656]
strh.w r8, [r0, #1008]
strh.w r6, [r0, #1360]
strh.w r9, [r0, #1712]
strh.w r5, [r0, #2064]
strh.w r7, [r0, #2416]
ldrh.w r1, [sp, #306]
ldrh.w r2, [sp, #1010]
ldrh.w r3, [sp, #1714]
ldrh.w r4, [sp, #2418]
ldrh.w r5, [fp, #306]
ldrh.w r6, [fp, #1010]
ldrh.w r7, [fp, #1714]
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
strh.w r1, [r0, #306]
strh.w r3, [r0, #658]
strh.w r8, [r0, #1010]
strh.w r6, [r0, #1362]
strh.w r9, [r0, #1714]
strh.w r5, [r0, #2066]
strh.w r7, [r0, #2418]
ldrh.w r1, [sp, #308]
ldrh.w r2, [sp, #1012]
ldrh.w r3, [sp, #1716]
ldrh.w r4, [sp, #2420]
ldrh.w r5, [fp, #308]
ldrh.w r6, [fp, #1012]
ldrh.w r7, [fp, #1716]
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
strh.w r1, [r0, #308]
strh.w r3, [r0, #660]
strh.w r8, [r0, #1012]
strh.w r6, [r0, #1364]
strh.w r9, [r0, #1716]
strh.w r5, [r0, #2068]
strh.w r7, [r0, #2420]
ldrh.w r1, [sp, #310]
ldrh.w r2, [sp, #1014]
ldrh.w r3, [sp, #1718]
ldrh.w r4, [sp, #2422]
ldrh.w r5, [fp, #310]
ldrh.w r6, [fp, #1014]
ldrh.w r7, [fp, #1718]
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
strh.w r1, [r0, #310]
strh.w r3, [r0, #662]
strh.w r8, [r0, #1014]
strh.w r6, [r0, #1366]
strh.w r9, [r0, #1718]
strh.w r5, [r0, #2070]
strh.w r7, [r0, #2422]
ldrh.w r1, [sp, #312]
ldrh.w r2, [sp, #1016]
ldrh.w r3, [sp, #1720]
ldrh.w r4, [sp, #2424]
ldrh.w r5, [fp, #312]
ldrh.w r6, [fp, #1016]
ldrh.w r7, [fp, #1720]
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
strh.w r1, [r0, #312]
strh.w r3, [r0, #664]
strh.w r8, [r0, #1016]
strh.w r6, [r0, #1368]
strh.w r9, [r0, #1720]
strh.w r5, [r0, #2072]
strh.w r7, [r0, #2424]
ldrh.w r1, [sp, #314]
ldrh.w r2, [sp, #1018]
ldrh.w r3, [sp, #1722]
ldrh.w r4, [sp, #2426]
ldrh.w r5, [fp, #314]
ldrh.w r6, [fp, #1018]
ldrh.w r7, [fp, #1722]
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
strh.w r1, [r0, #314]
strh.w r3, [r0, #666]
strh.w r8, [r0, #1018]
strh.w r6, [r0, #1370]
strh.w r9, [r0, #1722]
strh.w r5, [r0, #2074]
strh.w r7, [r0, #2426]
ldrh.w r1, [sp, #316]
ldrh.w r2, [sp, #1020]
ldrh.w r3, [sp, #1724]
ldrh.w r4, [sp, #2428]
ldrh.w r5, [fp, #316]
ldrh.w r6, [fp, #1020]
ldrh.w r7, [fp, #1724]
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
strh.w r1, [r0, #316]
strh.w r3, [r0, #668]
strh.w r8, [r0, #1020]
strh.w r6, [r0, #1372]
strh.w r9, [r0, #1724]
strh.w r5, [r0, #2076]
strh.w r7, [r0, #2428]
ldrh.w r1, [sp, #318]
ldrh.w r2, [sp, #1022]
ldrh.w r3, [sp, #1726]
ldrh.w r4, [sp, #2430]
ldrh.w r5, [fp, #318]
ldrh.w r6, [fp, #1022]
ldrh.w r7, [fp, #1726]
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
strh.w r1, [r0, #318]
strh.w r3, [r0, #670]
strh.w r8, [r0, #1022]
strh.w r6, [r0, #1374]
strh.w r9, [r0, #1726]
strh.w r5, [r0, #2078]
strh.w r7, [r0, #2430]
ldrh.w r1, [sp, #320]
ldrh.w r2, [sp, #1024]
ldrh.w r3, [sp, #1728]
ldrh.w r4, [sp, #2432]
ldrh.w r5, [fp, #320]
ldrh.w r6, [fp, #1024]
ldrh.w r7, [fp, #1728]
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
strh.w r1, [r0, #320]
strh.w r3, [r0, #672]
strh.w r8, [r0, #1024]
strh.w r6, [r0, #1376]
strh.w r9, [r0, #1728]
strh.w r5, [r0, #2080]
strh.w r7, [r0, #2432]
ldrh.w r1, [sp, #322]
ldrh.w r2, [sp, #1026]
ldrh.w r3, [sp, #1730]
ldrh.w r4, [sp, #2434]
ldrh.w r5, [fp, #322]
ldrh.w r6, [fp, #1026]
ldrh.w r7, [fp, #1730]
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
strh.w r1, [r0, #322]
strh.w r3, [r0, #674]
strh.w r8, [r0, #1026]
strh.w r6, [r0, #1378]
strh.w r9, [r0, #1730]
strh.w r5, [r0, #2082]
strh.w r7, [r0, #2434]
ldrh.w r1, [sp, #324]
ldrh.w r2, [sp, #1028]
ldrh.w r3, [sp, #1732]
ldrh.w r4, [sp, #2436]
ldrh.w r5, [fp, #324]
ldrh.w r6, [fp, #1028]
ldrh.w r7, [fp, #1732]
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
strh.w r1, [r0, #324]
strh.w r3, [r0, #676]
strh.w r8, [r0, #1028]
strh.w r6, [r0, #1380]
strh.w r9, [r0, #1732]
strh.w r5, [r0, #2084]
strh.w r7, [r0, #2436]
ldrh.w r1, [sp, #326]
ldrh.w r2, [sp, #1030]
ldrh.w r3, [sp, #1734]
ldrh.w r4, [sp, #2438]
ldrh.w r5, [fp, #326]
ldrh.w r6, [fp, #1030]
ldrh.w r7, [fp, #1734]
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
strh.w r1, [r0, #326]
strh.w r3, [r0, #678]
strh.w r8, [r0, #1030]
strh.w r6, [r0, #1382]
strh.w r9, [r0, #1734]
strh.w r5, [r0, #2086]
strh.w r7, [r0, #2438]
ldrh.w r1, [sp, #328]
ldrh.w r2, [sp, #1032]
ldrh.w r3, [sp, #1736]
ldrh.w r4, [sp, #2440]
ldrh.w r5, [fp, #328]
ldrh.w r6, [fp, #1032]
ldrh.w r7, [fp, #1736]
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
strh.w r1, [r0, #328]
strh.w r3, [r0, #680]
strh.w r8, [r0, #1032]
strh.w r6, [r0, #1384]
strh.w r9, [r0, #1736]
strh.w r5, [r0, #2088]
strh.w r7, [r0, #2440]
ldrh.w r1, [sp, #330]
ldrh.w r2, [sp, #1034]
ldrh.w r3, [sp, #1738]
ldrh.w r4, [sp, #2442]
ldrh.w r5, [fp, #330]
ldrh.w r6, [fp, #1034]
ldrh.w r7, [fp, #1738]
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
strh.w r1, [r0, #330]
strh.w r3, [r0, #682]
strh.w r8, [r0, #1034]
strh.w r6, [r0, #1386]
strh.w r9, [r0, #1738]
strh.w r5, [r0, #2090]
strh.w r7, [r0, #2442]
ldrh.w r1, [sp, #332]
ldrh.w r2, [sp, #1036]
ldrh.w r3, [sp, #1740]
ldrh.w r4, [sp, #2444]
ldrh.w r5, [fp, #332]
ldrh.w r6, [fp, #1036]
ldrh.w r7, [fp, #1740]
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
strh.w r1, [r0, #332]
strh.w r3, [r0, #684]
strh.w r8, [r0, #1036]
strh.w r6, [r0, #1388]
strh.w r9, [r0, #1740]
strh.w r5, [r0, #2092]
strh.w r7, [r0, #2444]
ldrh.w r1, [sp, #334]
ldrh.w r2, [sp, #1038]
ldrh.w r3, [sp, #1742]
ldrh.w r4, [sp, #2446]
ldrh.w r5, [fp, #334]
ldrh.w r6, [fp, #1038]
ldrh.w r7, [fp, #1742]
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
strh.w r1, [r0, #334]
strh.w r3, [r0, #686]
strh.w r8, [r0, #1038]
strh.w r6, [r0, #1390]
strh.w r9, [r0, #1742]
strh.w r5, [r0, #2094]
strh.w r7, [r0, #2446]
ldrh.w r1, [sp, #336]
ldrh.w r2, [sp, #1040]
ldrh.w r3, [sp, #1744]
ldrh.w r4, [sp, #2448]
ldrh.w r5, [fp, #336]
ldrh.w r6, [fp, #1040]
ldrh.w r7, [fp, #1744]
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
strh.w r1, [r0, #336]
strh.w r3, [r0, #688]
strh.w r8, [r0, #1040]
strh.w r6, [r0, #1392]
strh.w r9, [r0, #1744]
strh.w r5, [r0, #2096]
strh.w r7, [r0, #2448]
ldrh.w r1, [sp, #338]
ldrh.w r2, [sp, #1042]
ldrh.w r3, [sp, #1746]
ldrh.w r4, [sp, #2450]
ldrh.w r5, [fp, #338]
ldrh.w r6, [fp, #1042]
ldrh.w r7, [fp, #1746]
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
strh.w r1, [r0, #338]
strh.w r3, [r0, #690]
strh.w r8, [r0, #1042]
strh.w r6, [r0, #1394]
strh.w r9, [r0, #1746]
strh.w r5, [r0, #2098]
strh.w r7, [r0, #2450]
ldrh.w r1, [sp, #340]
ldrh.w r2, [sp, #1044]
ldrh.w r3, [sp, #1748]
ldrh.w r4, [sp, #2452]
ldrh.w r5, [fp, #340]
ldrh.w r6, [fp, #1044]
ldrh.w r7, [fp, #1748]
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
strh.w r1, [r0, #340]
strh.w r3, [r0, #692]
strh.w r8, [r0, #1044]
strh.w r6, [r0, #1396]
strh.w r9, [r0, #1748]
strh.w r5, [r0, #2100]
strh.w r7, [r0, #2452]
ldrh.w r1, [sp, #342]
ldrh.w r2, [sp, #1046]
ldrh.w r3, [sp, #1750]
ldrh.w r4, [sp, #2454]
ldrh.w r5, [fp, #342]
ldrh.w r6, [fp, #1046]
ldrh.w r7, [fp, #1750]
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
strh.w r1, [r0, #342]
strh.w r3, [r0, #694]
strh.w r8, [r0, #1046]
strh.w r6, [r0, #1398]
strh.w r9, [r0, #1750]
strh.w r5, [r0, #2102]
strh.w r7, [r0, #2454]
ldrh.w r1, [sp, #344]
ldrh.w r2, [sp, #1048]
ldrh.w r3, [sp, #1752]
ldrh.w r4, [sp, #2456]
ldrh.w r5, [fp, #344]
ldrh.w r6, [fp, #1048]
ldrh.w r7, [fp, #1752]
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
strh.w r1, [r0, #344]
strh.w r3, [r0, #696]
strh.w r8, [r0, #1048]
strh.w r6, [r0, #1400]
strh.w r9, [r0, #1752]
strh.w r5, [r0, #2104]
strh.w r7, [r0, #2456]
ldrh.w r1, [sp, #346]
ldrh.w r2, [sp, #1050]
ldrh.w r3, [sp, #1754]
ldrh.w r4, [sp, #2458]
ldrh.w r5, [fp, #346]
ldrh.w r6, [fp, #1050]
ldrh.w r7, [fp, #1754]
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
strh.w r1, [r0, #346]
strh.w r3, [r0, #698]
strh.w r8, [r0, #1050]
strh.w r6, [r0, #1402]
strh.w r9, [r0, #1754]
strh.w r5, [r0, #2106]
strh.w r7, [r0, #2458]
ldrh.w r1, [sp, #348]
ldrh.w r2, [sp, #1052]
ldrh.w r3, [sp, #1756]
ldrh.w r4, [sp, #2460]
ldrh.w r5, [fp, #348]
ldrh.w r6, [fp, #1052]
ldrh.w r7, [fp, #1756]
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
strh.w r1, [r0, #348]
strh.w r3, [r0, #700]
strh.w r8, [r0, #1052]
strh.w r6, [r0, #1404]
strh.w r9, [r0, #1756]
strh.w r5, [r0, #2108]
strh.w r7, [r0, #2460]
ldrh.w r1, [sp, #350]
ldrh.w r2, [sp, #1054]
ldrh.w r3, [sp, #1758]
ldrh.w r4, [sp, #2462]
ldrh.w r5, [fp, #350]
ldrh.w r6, [fp, #1054]
ldrh.w r7, [fp, #1758]
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
strh.w r1, [r0, #350]
strh.w r3, [r0, #702]
strh.w r8, [r0, #1054]
strh.w r6, [r0, #1406]
strh.w r9, [r0, #1758]
strh.w r5, [r0, #2110]
strh.w r7, [r0, #2462]
ldrh.w r1, [sp, #352]
ldrh.w r2, [sp, #1056]
ldrh.w r3, [sp, #1760]
ldrh.w r4, [sp, #2464]
ldrh.w r5, [fp, #352]
ldrh.w r6, [fp, #1056]
ldrh.w r7, [fp, #1760]
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
ldrh.w sl, [r0, #352]
add.w r1, sl
strh.w r1, [r0, #352]
ldrh.w sl, [r0, #704]
add.w r3, sl
strh.w r3, [r0, #704]
ldrh.w sl, [r0, #1056]
add.w r8, sl
strh.w r8, [r0, #1056]
ldrh.w sl, [r0, #1408]
add.w r6, sl
strh.w r6, [r0, #1408]
ldrh.w sl, [r0, #1760]
add.w r9, sl
strh.w r9, [r0, #1760]
ldrh.w sl, [r0, #2112]
add.w r5, sl
strh.w r5, [r0, #2112]
strh.w r7, [r0, #2464]
ldrh.w r1, [sp, #354]
ldrh.w r2, [sp, #1058]
ldrh.w r3, [sp, #1762]
ldrh.w r4, [sp, #2466]
ldrh.w r5, [fp, #354]
ldrh.w r6, [fp, #1058]
ldrh.w r7, [fp, #1762]
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
ldrh.w sl, [r0, #354]
add.w r1, sl
strh.w r1, [r0, #354]
ldrh.w sl, [r0, #706]
add.w r3, sl
strh.w r3, [r0, #706]
ldrh.w sl, [r0, #1058]
add.w r8, sl
strh.w r8, [r0, #1058]
ldrh.w sl, [r0, #1410]
add.w r6, sl
strh.w r6, [r0, #1410]
ldrh.w sl, [r0, #1762]
add.w r9, sl
strh.w r9, [r0, #1762]
ldrh.w sl, [r0, #2114]
add.w r5, sl
strh.w r5, [r0, #2114]
strh.w r7, [r0, #2466]
ldrh.w r1, [sp, #356]
ldrh.w r2, [sp, #1060]
ldrh.w r3, [sp, #1764]
ldrh.w r4, [sp, #2468]
ldrh.w r5, [fp, #356]
ldrh.w r6, [fp, #1060]
ldrh.w r7, [fp, #1764]
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
ldrh.w sl, [r0, #356]
add.w r1, sl
strh.w r1, [r0, #356]
ldrh.w sl, [r0, #708]
add.w r3, sl
strh.w r3, [r0, #708]
ldrh.w sl, [r0, #1060]
add.w r8, sl
strh.w r8, [r0, #1060]
ldrh.w sl, [r0, #1412]
add.w r6, sl
strh.w r6, [r0, #1412]
ldrh.w sl, [r0, #1764]
add.w r9, sl
strh.w r9, [r0, #1764]
ldrh.w sl, [r0, #2116]
add.w r5, sl
strh.w r5, [r0, #2116]
strh.w r7, [r0, #2468]
ldrh.w r1, [sp, #358]
ldrh.w r2, [sp, #1062]
ldrh.w r3, [sp, #1766]
ldrh.w r4, [sp, #2470]
ldrh.w r5, [fp, #358]
ldrh.w r6, [fp, #1062]
ldrh.w r7, [fp, #1766]
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
ldrh.w sl, [r0, #358]
add.w r1, sl
strh.w r1, [r0, #358]
ldrh.w sl, [r0, #710]
add.w r3, sl
strh.w r3, [r0, #710]
ldrh.w sl, [r0, #1062]
add.w r8, sl
strh.w r8, [r0, #1062]
ldrh.w sl, [r0, #1414]
add.w r6, sl
strh.w r6, [r0, #1414]
ldrh.w sl, [r0, #1766]
add.w r9, sl
strh.w r9, [r0, #1766]
ldrh.w sl, [r0, #2118]
add.w r5, sl
strh.w r5, [r0, #2118]
strh.w r7, [r0, #2470]
ldrh.w r1, [sp, #360]
ldrh.w r2, [sp, #1064]
ldrh.w r3, [sp, #1768]
ldrh.w r4, [sp, #2472]
ldrh.w r5, [fp, #360]
ldrh.w r6, [fp, #1064]
ldrh.w r7, [fp, #1768]
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
ldrh.w sl, [r0, #360]
add.w r1, sl
strh.w r1, [r0, #360]
ldrh.w sl, [r0, #712]
add.w r3, sl
strh.w r3, [r0, #712]
ldrh.w sl, [r0, #1064]
add.w r8, sl
strh.w r8, [r0, #1064]
ldrh.w sl, [r0, #1416]
add.w r6, sl
strh.w r6, [r0, #1416]
ldrh.w sl, [r0, #1768]
add.w r9, sl
strh.w r9, [r0, #1768]
ldrh.w sl, [r0, #2120]
add.w r5, sl
strh.w r5, [r0, #2120]
strh.w r7, [r0, #2472]
ldrh.w r1, [sp, #362]
ldrh.w r2, [sp, #1066]
ldrh.w r3, [sp, #1770]
ldrh.w r4, [sp, #2474]
ldrh.w r5, [fp, #362]
ldrh.w r6, [fp, #1066]
ldrh.w r7, [fp, #1770]
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
ldrh.w sl, [r0, #362]
add.w r1, sl
strh.w r1, [r0, #362]
ldrh.w sl, [r0, #714]
add.w r3, sl
strh.w r3, [r0, #714]
ldrh.w sl, [r0, #1066]
add.w r8, sl
strh.w r8, [r0, #1066]
ldrh.w sl, [r0, #1418]
add.w r6, sl
strh.w r6, [r0, #1418]
ldrh.w sl, [r0, #1770]
add.w r9, sl
strh.w r9, [r0, #1770]
ldrh.w sl, [r0, #2122]
add.w r5, sl
strh.w r5, [r0, #2122]
strh.w r7, [r0, #2474]
ldrh.w r1, [sp, #364]
ldrh.w r2, [sp, #1068]
ldrh.w r3, [sp, #1772]
ldrh.w r4, [sp, #2476]
ldrh.w r5, [fp, #364]
ldrh.w r6, [fp, #1068]
ldrh.w r7, [fp, #1772]
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
ldrh.w sl, [r0, #364]
add.w r1, sl
strh.w r1, [r0, #364]
ldrh.w sl, [r0, #716]
add.w r3, sl
strh.w r3, [r0, #716]
ldrh.w sl, [r0, #1068]
add.w r8, sl
strh.w r8, [r0, #1068]
ldrh.w sl, [r0, #1420]
add.w r6, sl
strh.w r6, [r0, #1420]
ldrh.w sl, [r0, #1772]
add.w r9, sl
strh.w r9, [r0, #1772]
ldrh.w sl, [r0, #2124]
add.w r5, sl
strh.w r5, [r0, #2124]
strh.w r7, [r0, #2476]
ldrh.w r1, [sp, #366]
ldrh.w r2, [sp, #1070]
ldrh.w r3, [sp, #1774]
ldrh.w r4, [sp, #2478]
ldrh.w r5, [fp, #366]
ldrh.w r6, [fp, #1070]
ldrh.w r7, [fp, #1774]
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
ldrh.w sl, [r0, #366]
add.w r1, sl
strh.w r1, [r0, #366]
ldrh.w sl, [r0, #718]
add.w r3, sl
strh.w r3, [r0, #718]
ldrh.w sl, [r0, #1070]
add.w r8, sl
strh.w r8, [r0, #1070]
ldrh.w sl, [r0, #1422]
add.w r6, sl
strh.w r6, [r0, #1422]
ldrh.w sl, [r0, #1774]
add.w r9, sl
strh.w r9, [r0, #1774]
ldrh.w sl, [r0, #2126]
add.w r5, sl
strh.w r5, [r0, #2126]
strh.w r7, [r0, #2478]
ldrh.w r1, [sp, #368]
ldrh.w r2, [sp, #1072]
ldrh.w r3, [sp, #1776]
ldrh.w r4, [sp, #2480]
ldrh.w r5, [fp, #368]
ldrh.w r6, [fp, #1072]
ldrh.w r7, [fp, #1776]
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
ldrh.w sl, [r0, #368]
add.w r1, sl
strh.w r1, [r0, #368]
ldrh.w sl, [r0, #720]
add.w r3, sl
strh.w r3, [r0, #720]
ldrh.w sl, [r0, #1072]
add.w r8, sl
strh.w r8, [r0, #1072]
ldrh.w sl, [r0, #1424]
add.w r6, sl
strh.w r6, [r0, #1424]
ldrh.w sl, [r0, #1776]
add.w r9, sl
strh.w r9, [r0, #1776]
ldrh.w sl, [r0, #2128]
add.w r5, sl
strh.w r5, [r0, #2128]
strh.w r7, [r0, #2480]
ldrh.w r1, [sp, #370]
ldrh.w r2, [sp, #1074]
ldrh.w r3, [sp, #1778]
ldrh.w r4, [sp, #2482]
ldrh.w r5, [fp, #370]
ldrh.w r6, [fp, #1074]
ldrh.w r7, [fp, #1778]
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
ldrh.w sl, [r0, #370]
add.w r1, sl
strh.w r1, [r0, #370]
ldrh.w sl, [r0, #722]
add.w r3, sl
strh.w r3, [r0, #722]
ldrh.w sl, [r0, #1074]
add.w r8, sl
strh.w r8, [r0, #1074]
ldrh.w sl, [r0, #1426]
add.w r6, sl
strh.w r6, [r0, #1426]
ldrh.w sl, [r0, #1778]
add.w r9, sl
strh.w r9, [r0, #1778]
ldrh.w sl, [r0, #2130]
add.w r5, sl
strh.w r5, [r0, #2130]
strh.w r7, [r0, #2482]
ldrh.w r1, [sp, #372]
ldrh.w r2, [sp, #1076]
ldrh.w r3, [sp, #1780]
ldrh.w r4, [sp, #2484]
ldrh.w r5, [fp, #372]
ldrh.w r6, [fp, #1076]
ldrh.w r7, [fp, #1780]
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
ldrh.w sl, [r0, #372]
add.w r1, sl
strh.w r1, [r0, #372]
ldrh.w sl, [r0, #724]
add.w r3, sl
strh.w r3, [r0, #724]
ldrh.w sl, [r0, #1076]
add.w r8, sl
strh.w r8, [r0, #1076]
ldrh.w sl, [r0, #1428]
add.w r6, sl
strh.w r6, [r0, #1428]
ldrh.w sl, [r0, #1780]
add.w r9, sl
strh.w r9, [r0, #1780]
ldrh.w sl, [r0, #2132]
add.w r5, sl
strh.w r5, [r0, #2132]
strh.w r7, [r0, #2484]
ldrh.w r1, [sp, #374]
ldrh.w r2, [sp, #1078]
ldrh.w r3, [sp, #1782]
ldrh.w r4, [sp, #2486]
ldrh.w r5, [fp, #374]
ldrh.w r6, [fp, #1078]
ldrh.w r7, [fp, #1782]
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
ldrh.w sl, [r0, #374]
add.w r1, sl
strh.w r1, [r0, #374]
ldrh.w sl, [r0, #726]
add.w r3, sl
strh.w r3, [r0, #726]
ldrh.w sl, [r0, #1078]
add.w r8, sl
strh.w r8, [r0, #1078]
ldrh.w sl, [r0, #1430]
add.w r6, sl
strh.w r6, [r0, #1430]
ldrh.w sl, [r0, #1782]
add.w r9, sl
strh.w r9, [r0, #1782]
ldrh.w sl, [r0, #2134]
add.w r5, sl
strh.w r5, [r0, #2134]
strh.w r7, [r0, #2486]
ldrh.w r1, [sp, #376]
ldrh.w r2, [sp, #1080]
ldrh.w r3, [sp, #1784]
ldrh.w r4, [sp, #2488]
ldrh.w r5, [fp, #376]
ldrh.w r6, [fp, #1080]
ldrh.w r7, [fp, #1784]
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
ldrh.w sl, [r0, #376]
add.w r1, sl
strh.w r1, [r0, #376]
ldrh.w sl, [r0, #728]
add.w r3, sl
strh.w r3, [r0, #728]
ldrh.w sl, [r0, #1080]
add.w r8, sl
strh.w r8, [r0, #1080]
ldrh.w sl, [r0, #1432]
add.w r6, sl
strh.w r6, [r0, #1432]
ldrh.w sl, [r0, #1784]
add.w r9, sl
strh.w r9, [r0, #1784]
ldrh.w sl, [r0, #2136]
add.w r5, sl
strh.w r5, [r0, #2136]
strh.w r7, [r0, #2488]
ldrh.w r1, [sp, #378]
ldrh.w r2, [sp, #1082]
ldrh.w r3, [sp, #1786]
ldrh.w r4, [sp, #2490]
ldrh.w r5, [fp, #378]
ldrh.w r6, [fp, #1082]
ldrh.w r7, [fp, #1786]
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
ldrh.w sl, [r0, #378]
add.w r1, sl
strh.w r1, [r0, #378]
ldrh.w sl, [r0, #730]
add.w r3, sl
strh.w r3, [r0, #730]
ldrh.w sl, [r0, #1082]
add.w r8, sl
strh.w r8, [r0, #1082]
ldrh.w sl, [r0, #1434]
add.w r6, sl
strh.w r6, [r0, #1434]
ldrh.w sl, [r0, #1786]
add.w r9, sl
strh.w r9, [r0, #1786]
ldrh.w sl, [r0, #2138]
add.w r5, sl
strh.w r5, [r0, #2138]
strh.w r7, [r0, #2490]
ldrh.w r1, [sp, #380]
ldrh.w r2, [sp, #1084]
ldrh.w r3, [sp, #1788]
ldrh.w r4, [sp, #2492]
ldrh.w r5, [fp, #380]
ldrh.w r6, [fp, #1084]
ldrh.w r7, [fp, #1788]
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
ldrh.w sl, [r0, #380]
add.w r1, sl
strh.w r1, [r0, #380]
ldrh.w sl, [r0, #732]
add.w r3, sl
strh.w r3, [r0, #732]
ldrh.w sl, [r0, #1084]
add.w r8, sl
strh.w r8, [r0, #1084]
ldrh.w sl, [r0, #1436]
add.w r6, sl
strh.w r6, [r0, #1436]
ldrh.w sl, [r0, #1788]
add.w r9, sl
strh.w r9, [r0, #1788]
ldrh.w sl, [r0, #2140]
add.w r5, sl
strh.w r5, [r0, #2140]
strh.w r7, [r0, #2492]
ldrh.w r1, [sp, #382]
ldrh.w r2, [sp, #1086]
ldrh.w r3, [sp, #1790]
ldrh.w r4, [sp, #2494]
ldrh.w r5, [fp, #382]
ldrh.w r6, [fp, #1086]
ldrh.w r7, [fp, #1790]
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
ldrh.w sl, [r0, #382]
add.w r1, sl
strh.w r1, [r0, #382]
ldrh.w sl, [r0, #734]
add.w r3, sl
strh.w r3, [r0, #734]
ldrh.w sl, [r0, #1086]
add.w r8, sl
strh.w r8, [r0, #1086]
ldrh.w sl, [r0, #1438]
add.w r6, sl
strh.w r6, [r0, #1438]
ldrh.w sl, [r0, #1790]
add.w r9, sl
strh.w r9, [r0, #1790]
ldrh.w sl, [r0, #2142]
add.w r5, sl
strh.w r5, [r0, #2142]
strh.w r7, [r0, #2494]
ldrh.w r1, [sp, #384]
ldrh.w r2, [sp, #1088]
ldrh.w r3, [sp, #1792]
ldrh.w r4, [sp, #2496]
ldrh.w r5, [fp, #384]
ldrh.w r6, [fp, #1088]
ldrh.w r7, [fp, #1792]
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
ldrh.w sl, [r0, #384]
add.w r1, sl
strh.w r1, [r0, #384]
ldrh.w sl, [r0, #736]
add.w r3, sl
strh.w r3, [r0, #736]
ldrh.w sl, [r0, #1088]
add.w r8, sl
strh.w r8, [r0, #1088]
ldrh.w sl, [r0, #1440]
add.w r6, sl
strh.w r6, [r0, #1440]
ldrh.w sl, [r0, #1792]
add.w r9, sl
strh.w r9, [r0, #1792]
ldrh.w sl, [r0, #2144]
add.w r5, sl
strh.w r5, [r0, #2144]
strh.w r7, [r0, #2496]
ldrh.w r1, [sp, #386]
ldrh.w r2, [sp, #1090]
ldrh.w r3, [sp, #1794]
ldrh.w r4, [sp, #2498]
ldrh.w r5, [fp, #386]
ldrh.w r6, [fp, #1090]
ldrh.w r7, [fp, #1794]
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
ldrh.w sl, [r0, #386]
add.w r1, sl
strh.w r1, [r0, #386]
ldrh.w sl, [r0, #738]
add.w r3, sl
strh.w r3, [r0, #738]
ldrh.w sl, [r0, #1090]
add.w r8, sl
strh.w r8, [r0, #1090]
ldrh.w sl, [r0, #1442]
add.w r6, sl
strh.w r6, [r0, #1442]
ldrh.w sl, [r0, #1794]
add.w r9, sl
strh.w r9, [r0, #1794]
ldrh.w sl, [r0, #2146]
add.w r5, sl
strh.w r5, [r0, #2146]
strh.w r7, [r0, #2498]
ldrh.w r1, [sp, #388]
ldrh.w r2, [sp, #1092]
ldrh.w r3, [sp, #1796]
ldrh.w r4, [sp, #2500]
ldrh.w r5, [fp, #388]
ldrh.w r6, [fp, #1092]
ldrh.w r7, [fp, #1796]
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
ldrh.w sl, [r0, #388]
add.w r1, sl
strh.w r1, [r0, #388]
ldrh.w sl, [r0, #740]
add.w r3, sl
strh.w r3, [r0, #740]
ldrh.w sl, [r0, #1092]
add.w r8, sl
strh.w r8, [r0, #1092]
ldrh.w sl, [r0, #1444]
add.w r6, sl
strh.w r6, [r0, #1444]
ldrh.w sl, [r0, #1796]
add.w r9, sl
strh.w r9, [r0, #1796]
ldrh.w sl, [r0, #2148]
add.w r5, sl
strh.w r5, [r0, #2148]
strh.w r7, [r0, #2500]
ldrh.w r1, [sp, #390]
ldrh.w r2, [sp, #1094]
ldrh.w r3, [sp, #1798]
ldrh.w r4, [sp, #2502]
ldrh.w r5, [fp, #390]
ldrh.w r6, [fp, #1094]
ldrh.w r7, [fp, #1798]
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
ldrh.w sl, [r0, #390]
add.w r1, sl
strh.w r1, [r0, #390]
ldrh.w sl, [r0, #742]
add.w r3, sl
strh.w r3, [r0, #742]
ldrh.w sl, [r0, #1094]
add.w r8, sl
strh.w r8, [r0, #1094]
ldrh.w sl, [r0, #1446]
add.w r6, sl
strh.w r6, [r0, #1446]
ldrh.w sl, [r0, #1798]
add.w r9, sl
strh.w r9, [r0, #1798]
ldrh.w sl, [r0, #2150]
add.w r5, sl
strh.w r5, [r0, #2150]
strh.w r7, [r0, #2502]
ldrh.w r1, [sp, #392]
ldrh.w r2, [sp, #1096]
ldrh.w r3, [sp, #1800]
ldrh.w r4, [sp, #2504]
ldrh.w r5, [fp, #392]
ldrh.w r6, [fp, #1096]
ldrh.w r7, [fp, #1800]
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
ldrh.w sl, [r0, #392]
add.w r1, sl
strh.w r1, [r0, #392]
ldrh.w sl, [r0, #744]
add.w r3, sl
strh.w r3, [r0, #744]
ldrh.w sl, [r0, #1096]
add.w r8, sl
strh.w r8, [r0, #1096]
ldrh.w sl, [r0, #1448]
add.w r6, sl
strh.w r6, [r0, #1448]
ldrh.w sl, [r0, #1800]
add.w r9, sl
strh.w r9, [r0, #1800]
ldrh.w sl, [r0, #2152]
add.w r5, sl
strh.w r5, [r0, #2152]
strh.w r7, [r0, #2504]
ldrh.w r1, [sp, #394]
ldrh.w r2, [sp, #1098]
ldrh.w r3, [sp, #1802]
ldrh.w r4, [sp, #2506]
ldrh.w r5, [fp, #394]
ldrh.w r6, [fp, #1098]
ldrh.w r7, [fp, #1802]
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
ldrh.w sl, [r0, #394]
add.w r1, sl
strh.w r1, [r0, #394]
ldrh.w sl, [r0, #746]
add.w r3, sl
strh.w r3, [r0, #746]
ldrh.w sl, [r0, #1098]
add.w r8, sl
strh.w r8, [r0, #1098]
ldrh.w sl, [r0, #1450]
add.w r6, sl
strh.w r6, [r0, #1450]
ldrh.w sl, [r0, #1802]
add.w r9, sl
strh.w r9, [r0, #1802]
ldrh.w sl, [r0, #2154]
add.w r5, sl
strh.w r5, [r0, #2154]
strh.w r7, [r0, #2506]
ldrh.w r1, [sp, #396]
ldrh.w r2, [sp, #1100]
ldrh.w r3, [sp, #1804]
ldrh.w r4, [sp, #2508]
ldrh.w r5, [fp, #396]
ldrh.w r6, [fp, #1100]
ldrh.w r7, [fp, #1804]
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
ldrh.w sl, [r0, #396]
add.w r1, sl
strh.w r1, [r0, #396]
ldrh.w sl, [r0, #748]
add.w r3, sl
strh.w r3, [r0, #748]
ldrh.w sl, [r0, #1100]
add.w r8, sl
strh.w r8, [r0, #1100]
ldrh.w sl, [r0, #1452]
add.w r6, sl
strh.w r6, [r0, #1452]
ldrh.w sl, [r0, #1804]
add.w r9, sl
strh.w r9, [r0, #1804]
ldrh.w sl, [r0, #2156]
add.w r5, sl
strh.w r5, [r0, #2156]
strh.w r7, [r0, #2508]
ldrh.w r1, [sp, #398]
ldrh.w r2, [sp, #1102]
ldrh.w r3, [sp, #1806]
ldrh.w r4, [sp, #2510]
ldrh.w r5, [fp, #398]
ldrh.w r6, [fp, #1102]
ldrh.w r7, [fp, #1806]
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
ldrh.w sl, [r0, #398]
add.w r1, sl
strh.w r1, [r0, #398]
ldrh.w sl, [r0, #750]
add.w r3, sl
strh.w r3, [r0, #750]
ldrh.w sl, [r0, #1102]
add.w r8, sl
strh.w r8, [r0, #1102]
ldrh.w sl, [r0, #1454]
add.w r6, sl
strh.w r6, [r0, #1454]
ldrh.w sl, [r0, #1806]
add.w r9, sl
strh.w r9, [r0, #1806]
ldrh.w sl, [r0, #2158]
add.w r5, sl
strh.w r5, [r0, #2158]
strh.w r7, [r0, #2510]
ldrh.w r1, [sp, #400]
ldrh.w r2, [sp, #1104]
ldrh.w r3, [sp, #1808]
ldrh.w r4, [sp, #2512]
ldrh.w r5, [fp, #400]
ldrh.w r6, [fp, #1104]
ldrh.w r7, [fp, #1808]
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
ldrh.w sl, [r0, #400]
add.w r1, sl
strh.w r1, [r0, #400]
ldrh.w sl, [r0, #752]
add.w r3, sl
strh.w r3, [r0, #752]
ldrh.w sl, [r0, #1104]
add.w r8, sl
strh.w r8, [r0, #1104]
ldrh.w sl, [r0, #1456]
add.w r6, sl
strh.w r6, [r0, #1456]
ldrh.w sl, [r0, #1808]
add.w r9, sl
strh.w r9, [r0, #1808]
ldrh.w sl, [r0, #2160]
add.w r5, sl
strh.w r5, [r0, #2160]
strh.w r7, [r0, #2512]
ldrh.w r1, [sp, #402]
ldrh.w r2, [sp, #1106]
ldrh.w r3, [sp, #1810]
ldrh.w r4, [sp, #2514]
ldrh.w r5, [fp, #402]
ldrh.w r6, [fp, #1106]
ldrh.w r7, [fp, #1810]
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
ldrh.w sl, [r0, #402]
add.w r1, sl
strh.w r1, [r0, #402]
ldrh.w sl, [r0, #754]
add.w r3, sl
strh.w r3, [r0, #754]
ldrh.w sl, [r0, #1106]
add.w r8, sl
strh.w r8, [r0, #1106]
ldrh.w sl, [r0, #1458]
add.w r6, sl
strh.w r6, [r0, #1458]
ldrh.w sl, [r0, #1810]
add.w r9, sl
strh.w r9, [r0, #1810]
ldrh.w sl, [r0, #2162]
add.w r5, sl
strh.w r5, [r0, #2162]
strh.w r7, [r0, #2514]
ldrh.w r1, [sp, #404]
ldrh.w r2, [sp, #1108]
ldrh.w r3, [sp, #1812]
ldrh.w r4, [sp, #2516]
ldrh.w r5, [fp, #404]
ldrh.w r6, [fp, #1108]
ldrh.w r7, [fp, #1812]
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
ldrh.w sl, [r0, #404]
add.w r1, sl
strh.w r1, [r0, #404]
ldrh.w sl, [r0, #756]
add.w r3, sl
strh.w r3, [r0, #756]
ldrh.w sl, [r0, #1108]
add.w r8, sl
strh.w r8, [r0, #1108]
ldrh.w sl, [r0, #1460]
add.w r6, sl
strh.w r6, [r0, #1460]
ldrh.w sl, [r0, #1812]
add.w r9, sl
strh.w r9, [r0, #1812]
ldrh.w sl, [r0, #2164]
add.w r5, sl
strh.w r5, [r0, #2164]
strh.w r7, [r0, #2516]
ldrh.w r1, [sp, #406]
ldrh.w r2, [sp, #1110]
ldrh.w r3, [sp, #1814]
ldrh.w r4, [sp, #2518]
ldrh.w r5, [fp, #406]
ldrh.w r6, [fp, #1110]
ldrh.w r7, [fp, #1814]
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
ldrh.w sl, [r0, #406]
add.w r1, sl
strh.w r1, [r0, #406]
ldrh.w sl, [r0, #758]
add.w r3, sl
strh.w r3, [r0, #758]
ldrh.w sl, [r0, #1110]
add.w r8, sl
strh.w r8, [r0, #1110]
ldrh.w sl, [r0, #1462]
add.w r6, sl
strh.w r6, [r0, #1462]
ldrh.w sl, [r0, #1814]
add.w r9, sl
strh.w r9, [r0, #1814]
ldrh.w sl, [r0, #2166]
add.w r5, sl
strh.w r5, [r0, #2166]
strh.w r7, [r0, #2518]
ldrh.w r1, [sp, #408]
ldrh.w r2, [sp, #1112]
ldrh.w r3, [sp, #1816]
ldrh.w r4, [sp, #2520]
ldrh.w r5, [fp, #408]
ldrh.w r6, [fp, #1112]
ldrh.w r7, [fp, #1816]
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
ldrh.w sl, [r0, #408]
add.w r1, sl
strh.w r1, [r0, #408]
ldrh.w sl, [r0, #760]
add.w r3, sl
strh.w r3, [r0, #760]
ldrh.w sl, [r0, #1112]
add.w r8, sl
strh.w r8, [r0, #1112]
ldrh.w sl, [r0, #1464]
add.w r6, sl
strh.w r6, [r0, #1464]
ldrh.w sl, [r0, #1816]
add.w r9, sl
strh.w r9, [r0, #1816]
ldrh.w sl, [r0, #2168]
add.w r5, sl
strh.w r5, [r0, #2168]
strh.w r7, [r0, #2520]
ldrh.w r1, [sp, #410]
ldrh.w r2, [sp, #1114]
ldrh.w r3, [sp, #1818]
ldrh.w r4, [sp, #2522]
ldrh.w r5, [fp, #410]
ldrh.w r6, [fp, #1114]
ldrh.w r7, [fp, #1818]
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
ldrh.w sl, [r0, #410]
add.w r1, sl
strh.w r1, [r0, #410]
ldrh.w sl, [r0, #762]
add.w r3, sl
strh.w r3, [r0, #762]
ldrh.w sl, [r0, #1114]
add.w r8, sl
strh.w r8, [r0, #1114]
ldrh.w sl, [r0, #1466]
add.w r6, sl
strh.w r6, [r0, #1466]
ldrh.w sl, [r0, #1818]
add.w r9, sl
strh.w r9, [r0, #1818]
ldrh.w sl, [r0, #2170]
add.w r5, sl
strh.w r5, [r0, #2170]
strh.w r7, [r0, #2522]
ldrh.w r1, [sp, #412]
ldrh.w r2, [sp, #1116]
ldrh.w r3, [sp, #1820]
ldrh.w r4, [sp, #2524]
ldrh.w r5, [fp, #412]
ldrh.w r6, [fp, #1116]
ldrh.w r7, [fp, #1820]
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
ldrh.w sl, [r0, #412]
add.w r1, sl
strh.w r1, [r0, #412]
ldrh.w sl, [r0, #764]
add.w r3, sl
strh.w r3, [r0, #764]
ldrh.w sl, [r0, #1116]
add.w r8, sl
strh.w r8, [r0, #1116]
ldrh.w sl, [r0, #1468]
add.w r6, sl
strh.w r6, [r0, #1468]
ldrh.w sl, [r0, #1820]
add.w r9, sl
strh.w r9, [r0, #1820]
ldrh.w sl, [r0, #2172]
add.w r5, sl
strh.w r5, [r0, #2172]
strh.w r7, [r0, #2524]
ldrh.w r1, [sp, #414]
ldrh.w r2, [sp, #1118]
ldrh.w r3, [sp, #1822]
ldrh.w r4, [sp, #2526]
ldrh.w r5, [fp, #414]
ldrh.w r6, [fp, #1118]
ldrh.w r7, [fp, #1822]
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
ldrh.w sl, [r0, #414]
add.w r1, sl
strh.w r1, [r0, #414]
ldrh.w sl, [r0, #766]
add.w r3, sl
strh.w r3, [r0, #766]
ldrh.w sl, [r0, #1118]
add.w r8, sl
strh.w r8, [r0, #1118]
ldrh.w sl, [r0, #1470]
add.w r6, sl
strh.w r6, [r0, #1470]
ldrh.w sl, [r0, #1822]
add.w r9, sl
strh.w r9, [r0, #1822]
ldrh.w sl, [r0, #2174]
add.w r5, sl
strh.w r5, [r0, #2174]
strh.w r7, [r0, #2526]
ldrh.w r1, [sp, #416]
ldrh.w r2, [sp, #1120]
ldrh.w r3, [sp, #1824]
ldrh.w r4, [sp, #2528]
ldrh.w r5, [fp, #416]
ldrh.w r6, [fp, #1120]
ldrh.w r7, [fp, #1824]
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
ldrh.w sl, [r0, #416]
add.w r1, sl
strh.w r1, [r0, #416]
ldrh.w sl, [r0, #768]
add.w r3, sl
strh.w r3, [r0, #768]
ldrh.w sl, [r0, #1120]
add.w r8, sl
strh.w r8, [r0, #1120]
ldrh.w sl, [r0, #1472]
add.w r6, sl
strh.w r6, [r0, #1472]
ldrh.w sl, [r0, #1824]
add.w r9, sl
strh.w r9, [r0, #1824]
ldrh.w sl, [r0, #2176]
add.w r5, sl
strh.w r5, [r0, #2176]
strh.w r7, [r0, #2528]
ldrh.w r1, [sp, #418]
ldrh.w r2, [sp, #1122]
ldrh.w r3, [sp, #1826]
ldrh.w r4, [sp, #2530]
ldrh.w r5, [fp, #418]
ldrh.w r6, [fp, #1122]
ldrh.w r7, [fp, #1826]
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
ldrh.w sl, [r0, #418]
add.w r1, sl
strh.w r1, [r0, #418]
ldrh.w sl, [r0, #770]
add.w r3, sl
strh.w r3, [r0, #770]
ldrh.w sl, [r0, #1122]
add.w r8, sl
strh.w r8, [r0, #1122]
ldrh.w sl, [r0, #1474]
add.w r6, sl
strh.w r6, [r0, #1474]
ldrh.w sl, [r0, #1826]
add.w r9, sl
strh.w r9, [r0, #1826]
ldrh.w sl, [r0, #2178]
add.w r5, sl
strh.w r5, [r0, #2178]
strh.w r7, [r0, #2530]
ldrh.w r1, [sp, #420]
ldrh.w r2, [sp, #1124]
ldrh.w r3, [sp, #1828]
ldrh.w r4, [sp, #2532]
ldrh.w r5, [fp, #420]
ldrh.w r6, [fp, #1124]
ldrh.w r7, [fp, #1828]
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
ldrh.w sl, [r0, #420]
add.w r1, sl
strh.w r1, [r0, #420]
ldrh.w sl, [r0, #772]
add.w r3, sl
strh.w r3, [r0, #772]
ldrh.w sl, [r0, #1124]
add.w r8, sl
strh.w r8, [r0, #1124]
ldrh.w sl, [r0, #1476]
add.w r6, sl
strh.w r6, [r0, #1476]
ldrh.w sl, [r0, #1828]
add.w r9, sl
strh.w r9, [r0, #1828]
ldrh.w sl, [r0, #2180]
add.w r5, sl
strh.w r5, [r0, #2180]
strh.w r7, [r0, #2532]
ldrh.w r1, [sp, #422]
ldrh.w r2, [sp, #1126]
ldrh.w r3, [sp, #1830]
ldrh.w r4, [sp, #2534]
ldrh.w r5, [fp, #422]
ldrh.w r6, [fp, #1126]
ldrh.w r7, [fp, #1830]
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
ldrh.w sl, [r0, #422]
add.w r1, sl
strh.w r1, [r0, #422]
ldrh.w sl, [r0, #774]
add.w r3, sl
strh.w r3, [r0, #774]
ldrh.w sl, [r0, #1126]
add.w r8, sl
strh.w r8, [r0, #1126]
ldrh.w sl, [r0, #1478]
add.w r6, sl
strh.w r6, [r0, #1478]
ldrh.w sl, [r0, #1830]
add.w r9, sl
strh.w r9, [r0, #1830]
ldrh.w sl, [r0, #2182]
add.w r5, sl
strh.w r5, [r0, #2182]
strh.w r7, [r0, #2534]
ldrh.w r1, [sp, #424]
ldrh.w r2, [sp, #1128]
ldrh.w r3, [sp, #1832]
ldrh.w r4, [sp, #2536]
ldrh.w r5, [fp, #424]
ldrh.w r6, [fp, #1128]
ldrh.w r7, [fp, #1832]
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
ldrh.w sl, [r0, #424]
add.w r1, sl
strh.w r1, [r0, #424]
ldrh.w sl, [r0, #776]
add.w r3, sl
strh.w r3, [r0, #776]
ldrh.w sl, [r0, #1128]
add.w r8, sl
strh.w r8, [r0, #1128]
ldrh.w sl, [r0, #1480]
add.w r6, sl
strh.w r6, [r0, #1480]
ldrh.w sl, [r0, #1832]
add.w r9, sl
strh.w r9, [r0, #1832]
ldrh.w sl, [r0, #2184]
add.w r5, sl
strh.w r5, [r0, #2184]
strh.w r7, [r0, #2536]
ldrh.w r1, [sp, #426]
ldrh.w r2, [sp, #1130]
ldrh.w r3, [sp, #1834]
ldrh.w r4, [sp, #2538]
ldrh.w r5, [fp, #426]
ldrh.w r6, [fp, #1130]
ldrh.w r7, [fp, #1834]
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
ldrh.w sl, [r0, #426]
add.w r1, sl
strh.w r1, [r0, #426]
ldrh.w sl, [r0, #778]
add.w r3, sl
strh.w r3, [r0, #778]
ldrh.w sl, [r0, #1130]
add.w r8, sl
strh.w r8, [r0, #1130]
ldrh.w sl, [r0, #1482]
add.w r6, sl
strh.w r6, [r0, #1482]
ldrh.w sl, [r0, #1834]
add.w r9, sl
strh.w r9, [r0, #1834]
ldrh.w sl, [r0, #2186]
add.w r5, sl
strh.w r5, [r0, #2186]
strh.w r7, [r0, #2538]
ldrh.w r1, [sp, #428]
ldrh.w r2, [sp, #1132]
ldrh.w r3, [sp, #1836]
ldrh.w r4, [sp, #2540]
ldrh.w r5, [fp, #428]
ldrh.w r6, [fp, #1132]
ldrh.w r7, [fp, #1836]
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
ldrh.w sl, [r0, #428]
add.w r1, sl
strh.w r1, [r0, #428]
ldrh.w sl, [r0, #780]
add.w r3, sl
strh.w r3, [r0, #780]
ldrh.w sl, [r0, #1132]
add.w r8, sl
strh.w r8, [r0, #1132]
ldrh.w sl, [r0, #1484]
add.w r6, sl
strh.w r6, [r0, #1484]
ldrh.w sl, [r0, #1836]
add.w r9, sl
strh.w r9, [r0, #1836]
ldrh.w sl, [r0, #2188]
add.w r5, sl
strh.w r5, [r0, #2188]
strh.w r7, [r0, #2540]
ldrh.w r1, [sp, #430]
ldrh.w r2, [sp, #1134]
ldrh.w r3, [sp, #1838]
ldrh.w r4, [sp, #2542]
ldrh.w r5, [fp, #430]
ldrh.w r6, [fp, #1134]
ldrh.w r7, [fp, #1838]
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
ldrh.w sl, [r0, #430]
add.w r1, sl
strh.w r1, [r0, #430]
ldrh.w sl, [r0, #782]
add.w r3, sl
strh.w r3, [r0, #782]
ldrh.w sl, [r0, #1134]
add.w r8, sl
strh.w r8, [r0, #1134]
ldrh.w sl, [r0, #1486]
add.w r6, sl
strh.w r6, [r0, #1486]
ldrh.w sl, [r0, #1838]
add.w r9, sl
strh.w r9, [r0, #1838]
ldrh.w sl, [r0, #2190]
add.w r5, sl
strh.w r5, [r0, #2190]
strh.w r7, [r0, #2542]
ldrh.w r1, [sp, #432]
ldrh.w r2, [sp, #1136]
ldrh.w r3, [sp, #1840]
ldrh.w r4, [sp, #2544]
ldrh.w r5, [fp, #432]
ldrh.w r6, [fp, #1136]
ldrh.w r7, [fp, #1840]
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
ldrh.w sl, [r0, #432]
add.w r1, sl
strh.w r1, [r0, #432]
ldrh.w sl, [r0, #784]
add.w r3, sl
strh.w r3, [r0, #784]
ldrh.w sl, [r0, #1136]
add.w r8, sl
strh.w r8, [r0, #1136]
ldrh.w sl, [r0, #1488]
add.w r6, sl
strh.w r6, [r0, #1488]
ldrh.w sl, [r0, #1840]
add.w r9, sl
strh.w r9, [r0, #1840]
ldrh.w sl, [r0, #2192]
add.w r5, sl
strh.w r5, [r0, #2192]
strh.w r7, [r0, #2544]
ldrh.w r1, [sp, #434]
ldrh.w r2, [sp, #1138]
ldrh.w r3, [sp, #1842]
ldrh.w r4, [sp, #2546]
ldrh.w r5, [fp, #434]
ldrh.w r6, [fp, #1138]
ldrh.w r7, [fp, #1842]
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
ldrh.w sl, [r0, #434]
add.w r1, sl
strh.w r1, [r0, #434]
ldrh.w sl, [r0, #786]
add.w r3, sl
strh.w r3, [r0, #786]
ldrh.w sl, [r0, #1138]
add.w r8, sl
strh.w r8, [r0, #1138]
ldrh.w sl, [r0, #1490]
add.w r6, sl
strh.w r6, [r0, #1490]
ldrh.w sl, [r0, #1842]
add.w r9, sl
strh.w r9, [r0, #1842]
ldrh.w sl, [r0, #2194]
add.w r5, sl
strh.w r5, [r0, #2194]
strh.w r7, [r0, #2546]
ldrh.w r1, [sp, #436]
ldrh.w r2, [sp, #1140]
ldrh.w r3, [sp, #1844]
ldrh.w r4, [sp, #2548]
ldrh.w r5, [fp, #436]
ldrh.w r6, [fp, #1140]
ldrh.w r7, [fp, #1844]
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
ldrh.w sl, [r0, #436]
add.w r1, sl
strh.w r1, [r0, #436]
ldrh.w sl, [r0, #788]
add.w r3, sl
strh.w r3, [r0, #788]
ldrh.w sl, [r0, #1140]
add.w r8, sl
strh.w r8, [r0, #1140]
ldrh.w sl, [r0, #1492]
add.w r6, sl
strh.w r6, [r0, #1492]
ldrh.w sl, [r0, #1844]
add.w r9, sl
strh.w r9, [r0, #1844]
ldrh.w sl, [r0, #2196]
add.w r5, sl
strh.w r5, [r0, #2196]
strh.w r7, [r0, #2548]
ldrh.w r1, [sp, #438]
ldrh.w r2, [sp, #1142]
ldrh.w r3, [sp, #1846]
ldrh.w r4, [sp, #2550]
ldrh.w r5, [fp, #438]
ldrh.w r6, [fp, #1142]
ldrh.w r7, [fp, #1846]
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
ldrh.w sl, [r0, #438]
add.w r1, sl
strh.w r1, [r0, #438]
ldrh.w sl, [r0, #790]
add.w r3, sl
strh.w r3, [r0, #790]
ldrh.w sl, [r0, #1142]
add.w r8, sl
strh.w r8, [r0, #1142]
ldrh.w sl, [r0, #1494]
add.w r6, sl
strh.w r6, [r0, #1494]
ldrh.w sl, [r0, #1846]
add.w r9, sl
strh.w r9, [r0, #1846]
ldrh.w sl, [r0, #2198]
add.w r5, sl
strh.w r5, [r0, #2198]
strh.w r7, [r0, #2550]
ldrh.w r1, [sp, #440]
ldrh.w r2, [sp, #1144]
ldrh.w r3, [sp, #1848]
ldrh.w r4, [sp, #2552]
ldrh.w r5, [fp, #440]
ldrh.w r6, [fp, #1144]
ldrh.w r7, [fp, #1848]
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
ldrh.w sl, [r0, #440]
add.w r1, sl
strh.w r1, [r0, #440]
ldrh.w sl, [r0, #792]
add.w r3, sl
strh.w r3, [r0, #792]
ldrh.w sl, [r0, #1144]
add.w r8, sl
strh.w r8, [r0, #1144]
ldrh.w sl, [r0, #1496]
add.w r6, sl
strh.w r6, [r0, #1496]
ldrh.w sl, [r0, #1848]
add.w r9, sl
strh.w r9, [r0, #1848]
ldrh.w sl, [r0, #2200]
add.w r5, sl
strh.w r5, [r0, #2200]
strh.w r7, [r0, #2552]
ldrh.w r1, [sp, #442]
ldrh.w r2, [sp, #1146]
ldrh.w r3, [sp, #1850]
ldrh.w r4, [sp, #2554]
ldrh.w r5, [fp, #442]
ldrh.w r6, [fp, #1146]
ldrh.w r7, [fp, #1850]
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
ldrh.w sl, [r0, #442]
add.w r1, sl
strh.w r1, [r0, #442]
ldrh.w sl, [r0, #794]
add.w r3, sl
strh.w r3, [r0, #794]
ldrh.w sl, [r0, #1146]
add.w r8, sl
strh.w r8, [r0, #1146]
ldrh.w sl, [r0, #1498]
add.w r6, sl
strh.w r6, [r0, #1498]
ldrh.w sl, [r0, #1850]
add.w r9, sl
strh.w r9, [r0, #1850]
ldrh.w sl, [r0, #2202]
add.w r5, sl
strh.w r5, [r0, #2202]
strh.w r7, [r0, #2554]
ldrh.w r1, [sp, #444]
ldrh.w r2, [sp, #1148]
ldrh.w r3, [sp, #1852]
ldrh.w r4, [sp, #2556]
ldrh.w r5, [fp, #444]
ldrh.w r6, [fp, #1148]
ldrh.w r7, [fp, #1852]
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
ldrh.w sl, [r0, #444]
add.w r1, sl
strh.w r1, [r0, #444]
ldrh.w sl, [r0, #796]
add.w r3, sl
strh.w r3, [r0, #796]
ldrh.w sl, [r0, #1148]
add.w r8, sl
strh.w r8, [r0, #1148]
ldrh.w sl, [r0, #1500]
add.w r6, sl
strh.w r6, [r0, #1500]
ldrh.w sl, [r0, #1852]
add.w r9, sl
strh.w r9, [r0, #1852]
ldrh.w sl, [r0, #2204]
add.w r5, sl
strh.w r5, [r0, #2204]
strh.w r7, [r0, #2556]
ldrh.w r1, [sp, #446]
ldrh.w r2, [sp, #1150]
ldrh.w r3, [sp, #1854]
ldrh.w r4, [sp, #2558]
ldrh.w r5, [fp, #446]
ldrh.w r6, [fp, #1150]
ldrh.w r7, [fp, #1854]
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
ldrh.w sl, [r0, #446]
add.w r1, sl
strh.w r1, [r0, #446]
ldrh.w sl, [r0, #798]
add.w r3, sl
strh.w r3, [r0, #798]
ldrh.w sl, [r0, #1150]
add.w r8, sl
strh.w r8, [r0, #1150]
ldrh.w sl, [r0, #1502]
add.w r6, sl
strh.w r6, [r0, #1502]
ldrh.w sl, [r0, #1854]
add.w r9, sl
strh.w r9, [r0, #1854]
ldrh.w sl, [r0, #2206]
add.w r5, sl
strh.w r5, [r0, #2206]
strh.w r7, [r0, #2558]
ldrh.w r1, [sp, #448]
ldrh.w r2, [sp, #1152]
ldrh.w r3, [sp, #1856]
ldrh.w r4, [sp, #2560]
ldrh.w r5, [fp, #448]
ldrh.w r6, [fp, #1152]
ldrh.w r7, [fp, #1856]
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
ldrh.w sl, [r0, #448]
add.w r1, sl
strh.w r1, [r0, #448]
ldrh.w sl, [r0, #800]
add.w r3, sl
strh.w r3, [r0, #800]
ldrh.w sl, [r0, #1152]
add.w r8, sl
strh.w r8, [r0, #1152]
ldrh.w sl, [r0, #1504]
add.w r6, sl
strh.w r6, [r0, #1504]
ldrh.w sl, [r0, #1856]
add.w r9, sl
strh.w r9, [r0, #1856]
ldrh.w sl, [r0, #2208]
add.w r5, sl
strh.w r5, [r0, #2208]
strh.w r7, [r0, #2560]
ldrh.w r1, [sp, #450]
ldrh.w r2, [sp, #1154]
ldrh.w r3, [sp, #1858]
ldrh.w r4, [sp, #2562]
ldrh.w r5, [fp, #450]
ldrh.w r6, [fp, #1154]
ldrh.w r7, [fp, #1858]
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
ldrh.w sl, [r0, #450]
add.w r1, sl
strh.w r1, [r0, #450]
ldrh.w sl, [r0, #802]
add.w r3, sl
strh.w r3, [r0, #802]
ldrh.w sl, [r0, #1154]
add.w r8, sl
strh.w r8, [r0, #1154]
ldrh.w sl, [r0, #1506]
add.w r6, sl
strh.w r6, [r0, #1506]
ldrh.w sl, [r0, #1858]
add.w r9, sl
strh.w r9, [r0, #1858]
ldrh.w sl, [r0, #2210]
add.w r5, sl
strh.w r5, [r0, #2210]
strh.w r7, [r0, #2562]
ldrh.w r1, [sp, #452]
ldrh.w r2, [sp, #1156]
ldrh.w r3, [sp, #1860]
ldrh.w r4, [sp, #2564]
ldrh.w r5, [fp, #452]
ldrh.w r6, [fp, #1156]
ldrh.w r7, [fp, #1860]
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
ldrh.w sl, [r0, #452]
add.w r1, sl
strh.w r1, [r0, #452]
ldrh.w sl, [r0, #804]
add.w r3, sl
strh.w r3, [r0, #804]
ldrh.w sl, [r0, #1156]
add.w r8, sl
strh.w r8, [r0, #1156]
ldrh.w sl, [r0, #1508]
add.w r6, sl
strh.w r6, [r0, #1508]
ldrh.w sl, [r0, #1860]
add.w r9, sl
strh.w r9, [r0, #1860]
ldrh.w sl, [r0, #2212]
add.w r5, sl
strh.w r5, [r0, #2212]
strh.w r7, [r0, #2564]
ldrh.w r1, [sp, #454]
ldrh.w r2, [sp, #1158]
ldrh.w r3, [sp, #1862]
ldrh.w r4, [sp, #2566]
ldrh.w r5, [fp, #454]
ldrh.w r6, [fp, #1158]
ldrh.w r7, [fp, #1862]
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
ldrh.w sl, [r0, #454]
add.w r1, sl
strh.w r1, [r0, #454]
ldrh.w sl, [r0, #806]
add.w r3, sl
strh.w r3, [r0, #806]
ldrh.w sl, [r0, #1158]
add.w r8, sl
strh.w r8, [r0, #1158]
ldrh.w sl, [r0, #1510]
add.w r6, sl
strh.w r6, [r0, #1510]
ldrh.w sl, [r0, #1862]
add.w r9, sl
strh.w r9, [r0, #1862]
ldrh.w sl, [r0, #2214]
add.w r5, sl
strh.w r5, [r0, #2214]
strh.w r7, [r0, #2566]
ldrh.w r1, [sp, #456]
ldrh.w r2, [sp, #1160]
ldrh.w r3, [sp, #1864]
ldrh.w r4, [sp, #2568]
ldrh.w r5, [fp, #456]
ldrh.w r6, [fp, #1160]
ldrh.w r7, [fp, #1864]
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
ldrh.w sl, [r0, #456]
add.w r1, sl
strh.w r1, [r0, #456]
ldrh.w sl, [r0, #808]
add.w r3, sl
strh.w r3, [r0, #808]
ldrh.w sl, [r0, #1160]
add.w r8, sl
strh.w r8, [r0, #1160]
ldrh.w sl, [r0, #1512]
add.w r6, sl
strh.w r6, [r0, #1512]
ldrh.w sl, [r0, #1864]
add.w r9, sl
strh.w r9, [r0, #1864]
ldrh.w sl, [r0, #2216]
add.w r5, sl
strh.w r5, [r0, #2216]
strh.w r7, [r0, #2568]
ldrh.w r1, [sp, #458]
ldrh.w r2, [sp, #1162]
ldrh.w r3, [sp, #1866]
ldrh.w r4, [sp, #2570]
ldrh.w r5, [fp, #458]
ldrh.w r6, [fp, #1162]
ldrh.w r7, [fp, #1866]
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
ldrh.w sl, [r0, #458]
add.w r1, sl
strh.w r1, [r0, #458]
ldrh.w sl, [r0, #810]
add.w r3, sl
strh.w r3, [r0, #810]
ldrh.w sl, [r0, #1162]
add.w r8, sl
strh.w r8, [r0, #1162]
ldrh.w sl, [r0, #1514]
add.w r6, sl
strh.w r6, [r0, #1514]
ldrh.w sl, [r0, #1866]
add.w r9, sl
strh.w r9, [r0, #1866]
ldrh.w sl, [r0, #2218]
add.w r5, sl
strh.w r5, [r0, #2218]
strh.w r7, [r0, #2570]
ldrh.w r1, [sp, #460]
ldrh.w r2, [sp, #1164]
ldrh.w r3, [sp, #1868]
ldrh.w r4, [sp, #2572]
ldrh.w r5, [fp, #460]
ldrh.w r6, [fp, #1164]
ldrh.w r7, [fp, #1868]
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
ldrh.w sl, [r0, #460]
add.w r1, sl
strh.w r1, [r0, #460]
ldrh.w sl, [r0, #812]
add.w r3, sl
strh.w r3, [r0, #812]
ldrh.w sl, [r0, #1164]
add.w r8, sl
strh.w r8, [r0, #1164]
ldrh.w sl, [r0, #1516]
add.w r6, sl
strh.w r6, [r0, #1516]
ldrh.w sl, [r0, #1868]
add.w r9, sl
strh.w r9, [r0, #1868]
ldrh.w sl, [r0, #2220]
add.w r5, sl
strh.w r5, [r0, #2220]
strh.w r7, [r0, #2572]
ldrh.w r1, [sp, #462]
ldrh.w r2, [sp, #1166]
ldrh.w r3, [sp, #1870]
ldrh.w r4, [sp, #2574]
ldrh.w r5, [fp, #462]
ldrh.w r6, [fp, #1166]
ldrh.w r7, [fp, #1870]
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
ldrh.w sl, [r0, #462]
add.w r1, sl
strh.w r1, [r0, #462]
ldrh.w sl, [r0, #814]
add.w r3, sl
strh.w r3, [r0, #814]
ldrh.w sl, [r0, #1166]
add.w r8, sl
strh.w r8, [r0, #1166]
ldrh.w sl, [r0, #1518]
add.w r6, sl
strh.w r6, [r0, #1518]
ldrh.w sl, [r0, #1870]
add.w r9, sl
strh.w r9, [r0, #1870]
ldrh.w sl, [r0, #2222]
add.w r5, sl
strh.w r5, [r0, #2222]
strh.w r7, [r0, #2574]
ldrh.w r1, [sp, #464]
ldrh.w r2, [sp, #1168]
ldrh.w r3, [sp, #1872]
ldrh.w r4, [sp, #2576]
ldrh.w r5, [fp, #464]
ldrh.w r6, [fp, #1168]
ldrh.w r7, [fp, #1872]
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
ldrh.w sl, [r0, #464]
add.w r1, sl
strh.w r1, [r0, #464]
ldrh.w sl, [r0, #816]
add.w r3, sl
strh.w r3, [r0, #816]
ldrh.w sl, [r0, #1168]
add.w r8, sl
strh.w r8, [r0, #1168]
ldrh.w sl, [r0, #1520]
add.w r6, sl
strh.w r6, [r0, #1520]
ldrh.w sl, [r0, #1872]
add.w r9, sl
strh.w r9, [r0, #1872]
ldrh.w sl, [r0, #2224]
add.w r5, sl
strh.w r5, [r0, #2224]
strh.w r7, [r0, #2576]
ldrh.w r1, [sp, #466]
ldrh.w r2, [sp, #1170]
ldrh.w r3, [sp, #1874]
ldrh.w r4, [sp, #2578]
ldrh.w r5, [fp, #466]
ldrh.w r6, [fp, #1170]
ldrh.w r7, [fp, #1874]
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
ldrh.w sl, [r0, #466]
add.w r1, sl
strh.w r1, [r0, #466]
ldrh.w sl, [r0, #818]
add.w r3, sl
strh.w r3, [r0, #818]
ldrh.w sl, [r0, #1170]
add.w r8, sl
strh.w r8, [r0, #1170]
ldrh.w sl, [r0, #1522]
add.w r6, sl
strh.w r6, [r0, #1522]
ldrh.w sl, [r0, #1874]
add.w r9, sl
strh.w r9, [r0, #1874]
ldrh.w sl, [r0, #2226]
add.w r5, sl
strh.w r5, [r0, #2226]
strh.w r7, [r0, #2578]
ldrh.w r1, [sp, #468]
ldrh.w r2, [sp, #1172]
ldrh.w r3, [sp, #1876]
ldrh.w r4, [sp, #2580]
ldrh.w r5, [fp, #468]
ldrh.w r6, [fp, #1172]
ldrh.w r7, [fp, #1876]
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
ldrh.w sl, [r0, #468]
add.w r1, sl
strh.w r1, [r0, #468]
ldrh.w sl, [r0, #820]
add.w r3, sl
strh.w r3, [r0, #820]
ldrh.w sl, [r0, #1172]
add.w r8, sl
strh.w r8, [r0, #1172]
ldrh.w sl, [r0, #1524]
add.w r6, sl
strh.w r6, [r0, #1524]
ldrh.w sl, [r0, #1876]
add.w r9, sl
strh.w r9, [r0, #1876]
ldrh.w sl, [r0, #2228]
add.w r5, sl
strh.w r5, [r0, #2228]
strh.w r7, [r0, #2580]
ldrh.w r1, [sp, #470]
ldrh.w r2, [sp, #1174]
ldrh.w r3, [sp, #1878]
ldrh.w r4, [sp, #2582]
ldrh.w r5, [fp, #470]
ldrh.w r6, [fp, #1174]
ldrh.w r7, [fp, #1878]
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
ldrh.w sl, [r0, #470]
add.w r1, sl
strh.w r1, [r0, #470]
ldrh.w sl, [r0, #822]
add.w r3, sl
strh.w r3, [r0, #822]
ldrh.w sl, [r0, #1174]
add.w r8, sl
strh.w r8, [r0, #1174]
ldrh.w sl, [r0, #1526]
add.w r6, sl
strh.w r6, [r0, #1526]
ldrh.w sl, [r0, #1878]
add.w r9, sl
strh.w r9, [r0, #1878]
ldrh.w sl, [r0, #2230]
add.w r5, sl
strh.w r5, [r0, #2230]
strh.w r7, [r0, #2582]
ldrh.w r1, [sp, #472]
ldrh.w r2, [sp, #1176]
ldrh.w r3, [sp, #1880]
ldrh.w r4, [sp, #2584]
ldrh.w r5, [fp, #472]
ldrh.w r6, [fp, #1176]
ldrh.w r7, [fp, #1880]
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
ldrh.w sl, [r0, #472]
add.w r1, sl
strh.w r1, [r0, #472]
ldrh.w sl, [r0, #824]
add.w r3, sl
strh.w r3, [r0, #824]
ldrh.w sl, [r0, #1176]
add.w r8, sl
strh.w r8, [r0, #1176]
ldrh.w sl, [r0, #1528]
add.w r6, sl
strh.w r6, [r0, #1528]
ldrh.w sl, [r0, #1880]
add.w r9, sl
strh.w r9, [r0, #1880]
ldrh.w sl, [r0, #2232]
add.w r5, sl
strh.w r5, [r0, #2232]
strh.w r7, [r0, #2584]
ldrh.w r1, [sp, #474]
ldrh.w r2, [sp, #1178]
ldrh.w r3, [sp, #1882]
ldrh.w r4, [sp, #2586]
ldrh.w r5, [fp, #474]
ldrh.w r6, [fp, #1178]
ldrh.w r7, [fp, #1882]
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
ldrh.w sl, [r0, #474]
add.w r1, sl
strh.w r1, [r0, #474]
ldrh.w sl, [r0, #826]
add.w r3, sl
strh.w r3, [r0, #826]
ldrh.w sl, [r0, #1178]
add.w r8, sl
strh.w r8, [r0, #1178]
ldrh.w sl, [r0, #1530]
add.w r6, sl
strh.w r6, [r0, #1530]
ldrh.w sl, [r0, #1882]
add.w r9, sl
strh.w r9, [r0, #1882]
ldrh.w sl, [r0, #2234]
add.w r5, sl
strh.w r5, [r0, #2234]
strh.w r7, [r0, #2586]
ldrh.w r1, [sp, #476]
ldrh.w r2, [sp, #1180]
ldrh.w r3, [sp, #1884]
ldrh.w r4, [sp, #2588]
ldrh.w r5, [fp, #476]
ldrh.w r6, [fp, #1180]
ldrh.w r7, [fp, #1884]
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
ldrh.w sl, [r0, #476]
add.w r1, sl
strh.w r1, [r0, #476]
ldrh.w sl, [r0, #828]
add.w r3, sl
strh.w r3, [r0, #828]
ldrh.w sl, [r0, #1180]
add.w r8, sl
strh.w r8, [r0, #1180]
ldrh.w sl, [r0, #1532]
add.w r6, sl
strh.w r6, [r0, #1532]
ldrh.w sl, [r0, #1884]
add.w r9, sl
strh.w r9, [r0, #1884]
ldrh.w sl, [r0, #2236]
add.w r5, sl
strh.w r5, [r0, #2236]
strh.w r7, [r0, #2588]
ldrh.w r1, [sp, #478]
ldrh.w r2, [sp, #1182]
ldrh.w r3, [sp, #1886]
ldrh.w r4, [sp, #2590]
ldrh.w r5, [fp, #478]
ldrh.w r6, [fp, #1182]
ldrh.w r7, [fp, #1886]
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
ldrh.w sl, [r0, #478]
add.w r1, sl
strh.w r1, [r0, #478]
ldrh.w sl, [r0, #830]
add.w r3, sl
strh.w r3, [r0, #830]
ldrh.w sl, [r0, #1182]
add.w r8, sl
strh.w r8, [r0, #1182]
ldrh.w sl, [r0, #1534]
add.w r6, sl
strh.w r6, [r0, #1534]
ldrh.w sl, [r0, #1886]
add.w r9, sl
strh.w r9, [r0, #1886]
ldrh.w sl, [r0, #2238]
add.w r5, sl
strh.w r5, [r0, #2238]
strh.w r7, [r0, #2590]
ldrh.w r1, [sp, #480]
ldrh.w r2, [sp, #1184]
ldrh.w r3, [sp, #1888]
ldrh.w r4, [sp, #2592]
ldrh.w r5, [fp, #480]
ldrh.w r6, [fp, #1184]
ldrh.w r7, [fp, #1888]
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
ldrh.w sl, [r0, #480]
add.w r1, sl
strh.w r1, [r0, #480]
ldrh.w sl, [r0, #832]
add.w r3, sl
strh.w r3, [r0, #832]
ldrh.w sl, [r0, #1184]
add.w r8, sl
strh.w r8, [r0, #1184]
ldrh.w sl, [r0, #1536]
add.w r6, sl
strh.w r6, [r0, #1536]
ldrh.w sl, [r0, #1888]
add.w r9, sl
strh.w r9, [r0, #1888]
ldrh.w sl, [r0, #2240]
add.w r5, sl
strh.w r5, [r0, #2240]
strh.w r7, [r0, #2592]
ldrh.w r1, [sp, #482]
ldrh.w r2, [sp, #1186]
ldrh.w r3, [sp, #1890]
ldrh.w r4, [sp, #2594]
ldrh.w r5, [fp, #482]
ldrh.w r6, [fp, #1186]
ldrh.w r7, [fp, #1890]
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
ldrh.w sl, [r0, #482]
add.w r1, sl
strh.w r1, [r0, #482]
ldrh.w sl, [r0, #834]
add.w r3, sl
strh.w r3, [r0, #834]
ldrh.w sl, [r0, #1186]
add.w r8, sl
strh.w r8, [r0, #1186]
ldrh.w sl, [r0, #1538]
add.w r6, sl
strh.w r6, [r0, #1538]
ldrh.w sl, [r0, #1890]
add.w r9, sl
strh.w r9, [r0, #1890]
ldrh.w sl, [r0, #2242]
add.w r5, sl
strh.w r5, [r0, #2242]
strh.w r7, [r0, #2594]
ldrh.w r1, [sp, #484]
ldrh.w r2, [sp, #1188]
ldrh.w r3, [sp, #1892]
ldrh.w r4, [sp, #2596]
ldrh.w r5, [fp, #484]
ldrh.w r6, [fp, #1188]
ldrh.w r7, [fp, #1892]
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
ldrh.w sl, [r0, #484]
add.w r1, sl
strh.w r1, [r0, #484]
ldrh.w sl, [r0, #836]
add.w r3, sl
strh.w r3, [r0, #836]
ldrh.w sl, [r0, #1188]
add.w r8, sl
strh.w r8, [r0, #1188]
ldrh.w sl, [r0, #1540]
add.w r6, sl
strh.w r6, [r0, #1540]
ldrh.w sl, [r0, #1892]
add.w r9, sl
strh.w r9, [r0, #1892]
ldrh.w sl, [r0, #2244]
add.w r5, sl
strh.w r5, [r0, #2244]
strh.w r7, [r0, #2596]
ldrh.w r1, [sp, #486]
ldrh.w r2, [sp, #1190]
ldrh.w r3, [sp, #1894]
ldrh.w r4, [sp, #2598]
ldrh.w r5, [fp, #486]
ldrh.w r6, [fp, #1190]
ldrh.w r7, [fp, #1894]
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
ldrh.w sl, [r0, #486]
add.w r1, sl
strh.w r1, [r0, #486]
ldrh.w sl, [r0, #838]
add.w r3, sl
strh.w r3, [r0, #838]
ldrh.w sl, [r0, #1190]
add.w r8, sl
strh.w r8, [r0, #1190]
ldrh.w sl, [r0, #1542]
add.w r6, sl
strh.w r6, [r0, #1542]
ldrh.w sl, [r0, #1894]
add.w r9, sl
strh.w r9, [r0, #1894]
ldrh.w sl, [r0, #2246]
add.w r5, sl
strh.w r5, [r0, #2246]
strh.w r7, [r0, #2598]
ldrh.w r1, [sp, #488]
ldrh.w r2, [sp, #1192]
ldrh.w r3, [sp, #1896]
ldrh.w r4, [sp, #2600]
ldrh.w r5, [fp, #488]
ldrh.w r6, [fp, #1192]
ldrh.w r7, [fp, #1896]
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
ldrh.w sl, [r0, #488]
add.w r1, sl
strh.w r1, [r0, #488]
ldrh.w sl, [r0, #840]
add.w r3, sl
strh.w r3, [r0, #840]
ldrh.w sl, [r0, #1192]
add.w r8, sl
strh.w r8, [r0, #1192]
ldrh.w sl, [r0, #1544]
add.w r6, sl
strh.w r6, [r0, #1544]
ldrh.w sl, [r0, #1896]
add.w r9, sl
strh.w r9, [r0, #1896]
ldrh.w sl, [r0, #2248]
add.w r5, sl
strh.w r5, [r0, #2248]
strh.w r7, [r0, #2600]
ldrh.w r1, [sp, #490]
ldrh.w r2, [sp, #1194]
ldrh.w r3, [sp, #1898]
ldrh.w r4, [sp, #2602]
ldrh.w r5, [fp, #490]
ldrh.w r6, [fp, #1194]
ldrh.w r7, [fp, #1898]
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
ldrh.w sl, [r0, #490]
add.w r1, sl
strh.w r1, [r0, #490]
ldrh.w sl, [r0, #842]
add.w r3, sl
strh.w r3, [r0, #842]
ldrh.w sl, [r0, #1194]
add.w r8, sl
strh.w r8, [r0, #1194]
ldrh.w sl, [r0, #1546]
add.w r6, sl
strh.w r6, [r0, #1546]
ldrh.w sl, [r0, #1898]
add.w r9, sl
strh.w r9, [r0, #1898]
ldrh.w sl, [r0, #2250]
add.w r5, sl
strh.w r5, [r0, #2250]
strh.w r7, [r0, #2602]
ldrh.w r1, [sp, #492]
ldrh.w r2, [sp, #1196]
ldrh.w r3, [sp, #1900]
ldrh.w r4, [sp, #2604]
ldrh.w r5, [fp, #492]
ldrh.w r6, [fp, #1196]
ldrh.w r7, [fp, #1900]
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
ldrh.w sl, [r0, #492]
add.w r1, sl
strh.w r1, [r0, #492]
ldrh.w sl, [r0, #844]
add.w r3, sl
strh.w r3, [r0, #844]
ldrh.w sl, [r0, #1196]
add.w r8, sl
strh.w r8, [r0, #1196]
ldrh.w sl, [r0, #1548]
add.w r6, sl
strh.w r6, [r0, #1548]
ldrh.w sl, [r0, #1900]
add.w r9, sl
strh.w r9, [r0, #1900]
ldrh.w sl, [r0, #2252]
add.w r5, sl
strh.w r5, [r0, #2252]
strh.w r7, [r0, #2604]
ldrh.w r1, [sp, #494]
ldrh.w r2, [sp, #1198]
ldrh.w r3, [sp, #1902]
ldrh.w r4, [sp, #2606]
ldrh.w r5, [fp, #494]
ldrh.w r6, [fp, #1198]
ldrh.w r7, [fp, #1902]
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
ldrh.w sl, [r0, #494]
add.w r1, sl
strh.w r1, [r0, #494]
ldrh.w sl, [r0, #846]
add.w r3, sl
strh.w r3, [r0, #846]
ldrh.w sl, [r0, #1198]
add.w r8, sl
strh.w r8, [r0, #1198]
ldrh.w sl, [r0, #1550]
add.w r6, sl
strh.w r6, [r0, #1550]
ldrh.w sl, [r0, #1902]
add.w r9, sl
strh.w r9, [r0, #1902]
ldrh.w sl, [r0, #2254]
add.w r5, sl
strh.w r5, [r0, #2254]
strh.w r7, [r0, #2606]
ldrh.w r1, [sp, #496]
ldrh.w r2, [sp, #1200]
ldrh.w r3, [sp, #1904]
ldrh.w r4, [sp, #2608]
ldrh.w r5, [fp, #496]
ldrh.w r6, [fp, #1200]
ldrh.w r7, [fp, #1904]
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
ldrh.w sl, [r0, #496]
add.w r1, sl
strh.w r1, [r0, #496]
ldrh.w sl, [r0, #848]
add.w r3, sl
strh.w r3, [r0, #848]
ldrh.w sl, [r0, #1200]
add.w r8, sl
strh.w r8, [r0, #1200]
ldrh.w sl, [r0, #1552]
add.w r6, sl
strh.w r6, [r0, #1552]
ldrh.w sl, [r0, #1904]
add.w r9, sl
strh.w r9, [r0, #1904]
ldrh.w sl, [r0, #2256]
add.w r5, sl
strh.w r5, [r0, #2256]
strh.w r7, [r0, #2608]
ldrh.w r1, [sp, #498]
ldrh.w r2, [sp, #1202]
ldrh.w r3, [sp, #1906]
ldrh.w r4, [sp, #2610]
ldrh.w r5, [fp, #498]
ldrh.w r6, [fp, #1202]
ldrh.w r7, [fp, #1906]
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
ldrh.w sl, [r0, #498]
add.w r1, sl
strh.w r1, [r0, #498]
ldrh.w sl, [r0, #850]
add.w r3, sl
strh.w r3, [r0, #850]
ldrh.w sl, [r0, #1202]
add.w r8, sl
strh.w r8, [r0, #1202]
ldrh.w sl, [r0, #1554]
add.w r6, sl
strh.w r6, [r0, #1554]
ldrh.w sl, [r0, #1906]
add.w r9, sl
strh.w r9, [r0, #1906]
ldrh.w sl, [r0, #2258]
add.w r5, sl
strh.w r5, [r0, #2258]
strh.w r7, [r0, #2610]
ldrh.w r1, [sp, #500]
ldrh.w r2, [sp, #1204]
ldrh.w r3, [sp, #1908]
ldrh.w r4, [sp, #2612]
ldrh.w r5, [fp, #500]
ldrh.w r6, [fp, #1204]
ldrh.w r7, [fp, #1908]
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
ldrh.w sl, [r0, #500]
add.w r1, sl
strh.w r1, [r0, #500]
ldrh.w sl, [r0, #852]
add.w r3, sl
strh.w r3, [r0, #852]
ldrh.w sl, [r0, #1204]
add.w r8, sl
strh.w r8, [r0, #1204]
ldrh.w sl, [r0, #1556]
add.w r6, sl
strh.w r6, [r0, #1556]
ldrh.w sl, [r0, #1908]
add.w r9, sl
strh.w r9, [r0, #1908]
ldrh.w sl, [r0, #2260]
add.w r5, sl
strh.w r5, [r0, #2260]
strh.w r7, [r0, #2612]
ldrh.w r1, [sp, #502]
ldrh.w r2, [sp, #1206]
ldrh.w r3, [sp, #1910]
ldrh.w r4, [sp, #2614]
ldrh.w r5, [fp, #502]
ldrh.w r6, [fp, #1206]
ldrh.w r7, [fp, #1910]
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
ldrh.w sl, [r0, #502]
add.w r1, sl
strh.w r1, [r0, #502]
ldrh.w sl, [r0, #854]
add.w r3, sl
strh.w r3, [r0, #854]
ldrh.w sl, [r0, #1206]
add.w r8, sl
strh.w r8, [r0, #1206]
ldrh.w sl, [r0, #1558]
add.w r6, sl
strh.w r6, [r0, #1558]
ldrh.w sl, [r0, #1910]
add.w r9, sl
strh.w r9, [r0, #1910]
ldrh.w sl, [r0, #2262]
add.w r5, sl
strh.w r5, [r0, #2262]
strh.w r7, [r0, #2614]
ldrh.w r1, [sp, #504]
ldrh.w r2, [sp, #1208]
ldrh.w r3, [sp, #1912]
ldrh.w r4, [sp, #2616]
ldrh.w r5, [fp, #504]
ldrh.w r6, [fp, #1208]
ldrh.w r7, [fp, #1912]
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
ldrh.w sl, [r0, #504]
add.w r1, sl
strh.w r1, [r0, #504]
ldrh.w sl, [r0, #856]
add.w r3, sl
strh.w r3, [r0, #856]
ldrh.w sl, [r0, #1208]
add.w r8, sl
strh.w r8, [r0, #1208]
ldrh.w sl, [r0, #1560]
add.w r6, sl
strh.w r6, [r0, #1560]
ldrh.w sl, [r0, #1912]
add.w r9, sl
strh.w r9, [r0, #1912]
ldrh.w sl, [r0, #2264]
add.w r5, sl
strh.w r5, [r0, #2264]
strh.w r7, [r0, #2616]
ldrh.w r1, [sp, #506]
ldrh.w r2, [sp, #1210]
ldrh.w r3, [sp, #1914]
ldrh.w r4, [sp, #2618]
ldrh.w r5, [fp, #506]
ldrh.w r6, [fp, #1210]
ldrh.w r7, [fp, #1914]
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
ldrh.w sl, [r0, #506]
add.w r1, sl
strh.w r1, [r0, #506]
ldrh.w sl, [r0, #858]
add.w r3, sl
strh.w r3, [r0, #858]
ldrh.w sl, [r0, #1210]
add.w r8, sl
strh.w r8, [r0, #1210]
ldrh.w sl, [r0, #1562]
add.w r6, sl
strh.w r6, [r0, #1562]
ldrh.w sl, [r0, #1914]
add.w r9, sl
strh.w r9, [r0, #1914]
ldrh.w sl, [r0, #2266]
add.w r5, sl
strh.w r5, [r0, #2266]
strh.w r7, [r0, #2618]
ldrh.w r1, [sp, #508]
ldrh.w r2, [sp, #1212]
ldrh.w r3, [sp, #1916]
ldrh.w r4, [sp, #2620]
ldrh.w r5, [fp, #508]
ldrh.w r6, [fp, #1212]
ldrh.w r7, [fp, #1916]
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
ldrh.w sl, [r0, #508]
add.w r1, sl
strh.w r1, [r0, #508]
ldrh.w sl, [r0, #860]
add.w r3, sl
strh.w r3, [r0, #860]
ldrh.w sl, [r0, #1212]
add.w r8, sl
strh.w r8, [r0, #1212]
ldrh.w sl, [r0, #1564]
add.w r6, sl
strh.w r6, [r0, #1564]
ldrh.w sl, [r0, #1916]
add.w r9, sl
strh.w r9, [r0, #1916]
ldrh.w sl, [r0, #2268]
add.w r5, sl
strh.w r5, [r0, #2268]
strh.w r7, [r0, #2620]
ldrh.w r1, [sp, #510]
ldrh.w r2, [sp, #1214]
ldrh.w r3, [sp, #1918]
ldrh.w r4, [sp, #2622]
ldrh.w r5, [fp, #510]
ldrh.w r6, [fp, #1214]
ldrh.w r7, [fp, #1918]
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
ldrh.w sl, [r0, #510]
add.w r1, sl
strh.w r1, [r0, #510]
ldrh.w sl, [r0, #862]
add.w r3, sl
strh.w r3, [r0, #862]
ldrh.w sl, [r0, #1214]
add.w r8, sl
strh.w r8, [r0, #1214]
ldrh.w sl, [r0, #1566]
add.w r6, sl
strh.w r6, [r0, #1566]
ldrh.w sl, [r0, #1918]
add.w r9, sl
strh.w r9, [r0, #1918]
ldrh.w sl, [r0, #2270]
add.w r5, sl
strh.w r5, [r0, #2270]
strh.w r7, [r0, #2622]
ldrh.w r1, [sp, #512]
ldrh.w r2, [sp, #1216]
ldrh.w r3, [sp, #1920]
ldrh.w r4, [sp, #2624]
ldrh.w r5, [fp, #512]
ldrh.w r6, [fp, #1216]
ldrh.w r7, [fp, #1920]
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
ldrh.w sl, [r0, #512]
add.w r1, sl
strh.w r1, [r0, #512]
ldrh.w sl, [r0, #864]
add.w r3, sl
strh.w r3, [r0, #864]
ldrh.w sl, [r0, #1216]
add.w r8, sl
strh.w r8, [r0, #1216]
ldrh.w sl, [r0, #1568]
add.w r6, sl
strh.w r6, [r0, #1568]
ldrh.w sl, [r0, #1920]
add.w r9, sl
strh.w r9, [r0, #1920]
ldrh.w sl, [r0, #2272]
add.w r5, sl
strh.w r5, [r0, #2272]
strh.w r7, [r0, #2624]
ldrh.w r1, [sp, #514]
ldrh.w r2, [sp, #1218]
ldrh.w r3, [sp, #1922]
ldrh.w r4, [sp, #2626]
ldrh.w r5, [fp, #514]
ldrh.w r6, [fp, #1218]
ldrh.w r7, [fp, #1922]
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
ldrh.w sl, [r0, #514]
add.w r1, sl
strh.w r1, [r0, #514]
ldrh.w sl, [r0, #866]
add.w r3, sl
strh.w r3, [r0, #866]
ldrh.w sl, [r0, #1218]
add.w r8, sl
strh.w r8, [r0, #1218]
ldrh.w sl, [r0, #1570]
add.w r6, sl
strh.w r6, [r0, #1570]
ldrh.w sl, [r0, #1922]
add.w r9, sl
strh.w r9, [r0, #1922]
ldrh.w sl, [r0, #2274]
add.w r5, sl
strh.w r5, [r0, #2274]
strh.w r7, [r0, #2626]
ldrh.w r1, [sp, #516]
ldrh.w r2, [sp, #1220]
ldrh.w r3, [sp, #1924]
ldrh.w r4, [sp, #2628]
ldrh.w r5, [fp, #516]
ldrh.w r6, [fp, #1220]
ldrh.w r7, [fp, #1924]
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
ldrh.w sl, [r0, #516]
add.w r1, sl
strh.w r1, [r0, #516]
ldrh.w sl, [r0, #868]
add.w r3, sl
strh.w r3, [r0, #868]
ldrh.w sl, [r0, #1220]
add.w r8, sl
strh.w r8, [r0, #1220]
ldrh.w sl, [r0, #1572]
add.w r6, sl
strh.w r6, [r0, #1572]
ldrh.w sl, [r0, #1924]
add.w r9, sl
strh.w r9, [r0, #1924]
ldrh.w sl, [r0, #2276]
add.w r5, sl
strh.w r5, [r0, #2276]
strh.w r7, [r0, #2628]
ldrh.w r1, [sp, #518]
ldrh.w r2, [sp, #1222]
ldrh.w r3, [sp, #1926]
ldrh.w r4, [sp, #2630]
ldrh.w r5, [fp, #518]
ldrh.w r6, [fp, #1222]
ldrh.w r7, [fp, #1926]
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
ldrh.w sl, [r0, #518]
add.w r1, sl
strh.w r1, [r0, #518]
ldrh.w sl, [r0, #870]
add.w r3, sl
strh.w r3, [r0, #870]
ldrh.w sl, [r0, #1222]
add.w r8, sl
strh.w r8, [r0, #1222]
ldrh.w sl, [r0, #1574]
add.w r6, sl
strh.w r6, [r0, #1574]
ldrh.w sl, [r0, #1926]
add.w r9, sl
strh.w r9, [r0, #1926]
ldrh.w sl, [r0, #2278]
add.w r5, sl
strh.w r5, [r0, #2278]
strh.w r7, [r0, #2630]
ldrh.w r1, [sp, #520]
ldrh.w r2, [sp, #1224]
ldrh.w r3, [sp, #1928]
ldrh.w r4, [sp, #2632]
ldrh.w r5, [fp, #520]
ldrh.w r6, [fp, #1224]
ldrh.w r7, [fp, #1928]
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
ldrh.w sl, [r0, #520]
add.w r1, sl
strh.w r1, [r0, #520]
ldrh.w sl, [r0, #872]
add.w r3, sl
strh.w r3, [r0, #872]
ldrh.w sl, [r0, #1224]
add.w r8, sl
strh.w r8, [r0, #1224]
ldrh.w sl, [r0, #1576]
add.w r6, sl
strh.w r6, [r0, #1576]
ldrh.w sl, [r0, #1928]
add.w r9, sl
strh.w r9, [r0, #1928]
ldrh.w sl, [r0, #2280]
add.w r5, sl
strh.w r5, [r0, #2280]
strh.w r7, [r0, #2632]
ldrh.w r1, [sp, #522]
ldrh.w r2, [sp, #1226]
ldrh.w r3, [sp, #1930]
ldrh.w r4, [sp, #2634]
ldrh.w r5, [fp, #522]
ldrh.w r6, [fp, #1226]
ldrh.w r7, [fp, #1930]
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
ldrh.w sl, [r0, #522]
add.w r1, sl
strh.w r1, [r0, #522]
ldrh.w sl, [r0, #874]
add.w r3, sl
strh.w r3, [r0, #874]
ldrh.w sl, [r0, #1226]
add.w r8, sl
strh.w r8, [r0, #1226]
ldrh.w sl, [r0, #1578]
add.w r6, sl
strh.w r6, [r0, #1578]
ldrh.w sl, [r0, #1930]
add.w r9, sl
strh.w r9, [r0, #1930]
ldrh.w sl, [r0, #2282]
add.w r5, sl
strh.w r5, [r0, #2282]
strh.w r7, [r0, #2634]
ldrh.w r1, [sp, #524]
ldrh.w r2, [sp, #1228]
ldrh.w r3, [sp, #1932]
ldrh.w r4, [sp, #2636]
ldrh.w r5, [fp, #524]
ldrh.w r6, [fp, #1228]
ldrh.w r7, [fp, #1932]
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
ldrh.w sl, [r0, #524]
add.w r1, sl
strh.w r1, [r0, #524]
ldrh.w sl, [r0, #876]
add.w r3, sl
strh.w r3, [r0, #876]
ldrh.w sl, [r0, #1228]
add.w r8, sl
strh.w r8, [r0, #1228]
ldrh.w sl, [r0, #1580]
add.w r6, sl
strh.w r6, [r0, #1580]
ldrh.w sl, [r0, #1932]
add.w r9, sl
strh.w r9, [r0, #1932]
ldrh.w sl, [r0, #2284]
add.w r5, sl
strh.w r5, [r0, #2284]
strh.w r7, [r0, #2636]
ldrh.w r1, [sp, #526]
ldrh.w r2, [sp, #1230]
ldrh.w r3, [sp, #1934]
ldrh.w r4, [sp, #2638]
ldrh.w r5, [fp, #526]
ldrh.w r6, [fp, #1230]
ldrh.w r7, [fp, #1934]
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
ldrh.w sl, [r0, #526]
add.w r1, sl
strh.w r1, [r0, #526]
ldrh.w sl, [r0, #878]
add.w r3, sl
strh.w r3, [r0, #878]
ldrh.w sl, [r0, #1230]
add.w r8, sl
strh.w r8, [r0, #1230]
ldrh.w sl, [r0, #1582]
add.w r6, sl
strh.w r6, [r0, #1582]
ldrh.w sl, [r0, #1934]
add.w r9, sl
strh.w r9, [r0, #1934]
ldrh.w sl, [r0, #2286]
add.w r5, sl
strh.w r5, [r0, #2286]
strh.w r7, [r0, #2638]
ldrh.w r1, [sp, #528]
ldrh.w r2, [sp, #1232]
ldrh.w r3, [sp, #1936]
ldrh.w r4, [sp, #2640]
ldrh.w r5, [fp, #528]
ldrh.w r6, [fp, #1232]
ldrh.w r7, [fp, #1936]
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
ldrh.w sl, [r0, #528]
add.w r1, sl
strh.w r1, [r0, #528]
ldrh.w sl, [r0, #880]
add.w r3, sl
strh.w r3, [r0, #880]
ldrh.w sl, [r0, #1232]
add.w r8, sl
strh.w r8, [r0, #1232]
ldrh.w sl, [r0, #1584]
add.w r6, sl
strh.w r6, [r0, #1584]
ldrh.w sl, [r0, #1936]
add.w r9, sl
strh.w r9, [r0, #1936]
ldrh.w sl, [r0, #2288]
add.w r5, sl
strh.w r5, [r0, #2288]
strh.w r7, [r0, #2640]
ldrh.w r1, [sp, #530]
ldrh.w r2, [sp, #1234]
ldrh.w r3, [sp, #1938]
ldrh.w r4, [sp, #2642]
ldrh.w r5, [fp, #530]
ldrh.w r6, [fp, #1234]
ldrh.w r7, [fp, #1938]
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
ldrh.w sl, [r0, #530]
add.w r1, sl
strh.w r1, [r0, #530]
ldrh.w sl, [r0, #882]
add.w r3, sl
strh.w r3, [r0, #882]
ldrh.w sl, [r0, #1234]
add.w r8, sl
strh.w r8, [r0, #1234]
ldrh.w sl, [r0, #1586]
add.w r6, sl
strh.w r6, [r0, #1586]
ldrh.w sl, [r0, #1938]
add.w r9, sl
strh.w r9, [r0, #1938]
ldrh.w sl, [r0, #2290]
add.w r5, sl
strh.w r5, [r0, #2290]
strh.w r7, [r0, #2642]
ldrh.w r1, [sp, #532]
ldrh.w r2, [sp, #1236]
ldrh.w r3, [sp, #1940]
ldrh.w r4, [sp, #2644]
ldrh.w r5, [fp, #532]
ldrh.w r6, [fp, #1236]
ldrh.w r7, [fp, #1940]
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
ldrh.w sl, [r0, #532]
add.w r1, sl
strh.w r1, [r0, #532]
ldrh.w sl, [r0, #884]
add.w r3, sl
strh.w r3, [r0, #884]
ldrh.w sl, [r0, #1236]
add.w r8, sl
strh.w r8, [r0, #1236]
ldrh.w sl, [r0, #1588]
add.w r6, sl
strh.w r6, [r0, #1588]
ldrh.w sl, [r0, #1940]
add.w r9, sl
strh.w r9, [r0, #1940]
ldrh.w sl, [r0, #2292]
add.w r5, sl
strh.w r5, [r0, #2292]
strh.w r7, [r0, #2644]
ldrh.w r1, [sp, #534]
ldrh.w r2, [sp, #1238]
ldrh.w r3, [sp, #1942]
ldrh.w r4, [sp, #2646]
ldrh.w r5, [fp, #534]
ldrh.w r6, [fp, #1238]
ldrh.w r7, [fp, #1942]
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
ldrh.w sl, [r0, #534]
add.w r1, sl
strh.w r1, [r0, #534]
ldrh.w sl, [r0, #886]
add.w r3, sl
strh.w r3, [r0, #886]
ldrh.w sl, [r0, #1238]
add.w r8, sl
strh.w r8, [r0, #1238]
ldrh.w sl, [r0, #1590]
add.w r6, sl
strh.w r6, [r0, #1590]
ldrh.w sl, [r0, #1942]
add.w r9, sl
strh.w r9, [r0, #1942]
ldrh.w sl, [r0, #2294]
add.w r5, sl
strh.w r5, [r0, #2294]
strh.w r7, [r0, #2646]
ldrh.w r1, [sp, #536]
ldrh.w r2, [sp, #1240]
ldrh.w r3, [sp, #1944]
ldrh.w r4, [sp, #2648]
ldrh.w r5, [fp, #536]
ldrh.w r6, [fp, #1240]
ldrh.w r7, [fp, #1944]
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
ldrh.w sl, [r0, #536]
add.w r1, sl
strh.w r1, [r0, #536]
ldrh.w sl, [r0, #888]
add.w r3, sl
strh.w r3, [r0, #888]
ldrh.w sl, [r0, #1240]
add.w r8, sl
strh.w r8, [r0, #1240]
ldrh.w sl, [r0, #1592]
add.w r6, sl
strh.w r6, [r0, #1592]
ldrh.w sl, [r0, #1944]
add.w r9, sl
strh.w r9, [r0, #1944]
ldrh.w sl, [r0, #2296]
add.w r5, sl
strh.w r5, [r0, #2296]
strh.w r7, [r0, #2648]
ldrh.w r1, [sp, #538]
ldrh.w r2, [sp, #1242]
ldrh.w r3, [sp, #1946]
ldrh.w r4, [sp, #2650]
ldrh.w r5, [fp, #538]
ldrh.w r6, [fp, #1242]
ldrh.w r7, [fp, #1946]
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
ldrh.w sl, [r0, #538]
add.w r1, sl
strh.w r1, [r0, #538]
ldrh.w sl, [r0, #890]
add.w r3, sl
strh.w r3, [r0, #890]
ldrh.w sl, [r0, #1242]
add.w r8, sl
strh.w r8, [r0, #1242]
ldrh.w sl, [r0, #1594]
add.w r6, sl
strh.w r6, [r0, #1594]
ldrh.w sl, [r0, #1946]
add.w r9, sl
strh.w r9, [r0, #1946]
ldrh.w sl, [r0, #2298]
add.w r5, sl
strh.w r5, [r0, #2298]
strh.w r7, [r0, #2650]
ldrh.w r1, [sp, #540]
ldrh.w r2, [sp, #1244]
ldrh.w r3, [sp, #1948]
ldrh.w r4, [sp, #2652]
ldrh.w r5, [fp, #540]
ldrh.w r6, [fp, #1244]
ldrh.w r7, [fp, #1948]
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
ldrh.w sl, [r0, #540]
add.w r1, sl
strh.w r1, [r0, #540]
ldrh.w sl, [r0, #892]
add.w r3, sl
strh.w r3, [r0, #892]
ldrh.w sl, [r0, #1244]
add.w r8, sl
strh.w r8, [r0, #1244]
ldrh.w sl, [r0, #1596]
add.w r6, sl
strh.w r6, [r0, #1596]
ldrh.w sl, [r0, #1948]
add.w r9, sl
strh.w r9, [r0, #1948]
ldrh.w sl, [r0, #2300]
add.w r5, sl
strh.w r5, [r0, #2300]
strh.w r7, [r0, #2652]
ldrh.w r1, [sp, #542]
ldrh.w r2, [sp, #1246]
ldrh.w r3, [sp, #1950]
ldrh.w r4, [sp, #2654]
ldrh.w r5, [fp, #542]
ldrh.w r6, [fp, #1246]
ldrh.w r7, [fp, #1950]
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
ldrh.w sl, [r0, #542]
add.w r1, sl
strh.w r1, [r0, #542]
ldrh.w sl, [r0, #894]
add.w r3, sl
strh.w r3, [r0, #894]
ldrh.w sl, [r0, #1246]
add.w r8, sl
strh.w r8, [r0, #1246]
ldrh.w sl, [r0, #1598]
add.w r6, sl
strh.w r6, [r0, #1598]
ldrh.w sl, [r0, #1950]
add.w r9, sl
strh.w r9, [r0, #1950]
ldrh.w sl, [r0, #2302]
add.w r5, sl
strh.w r5, [r0, #2302]
strh.w r7, [r0, #2654]
ldrh.w r1, [sp, #544]
ldrh.w r2, [sp, #1248]
ldrh.w r3, [sp, #1952]
ldrh.w r4, [sp, #2656]
ldrh.w r5, [fp, #544]
ldrh.w r6, [fp, #1248]
ldrh.w r7, [fp, #1952]
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
ldrh.w sl, [r0, #544]
add.w r1, sl
strh.w r1, [r0, #544]
ldrh.w sl, [r0, #896]
add.w r3, sl
strh.w r3, [r0, #896]
ldrh.w sl, [r0, #1248]
add.w r8, sl
strh.w r8, [r0, #1248]
ldrh.w sl, [r0, #1600]
add.w r6, sl
strh.w r6, [r0, #1600]
ldrh.w sl, [r0, #1952]
add.w r9, sl
strh.w r9, [r0, #1952]
ldrh.w sl, [r0, #2304]
add.w r5, sl
strh.w r5, [r0, #2304]
strh.w r7, [r0, #2656]
ldrh.w r1, [sp, #546]
ldrh.w r2, [sp, #1250]
ldrh.w r3, [sp, #1954]
ldrh.w r4, [sp, #2658]
ldrh.w r5, [fp, #546]
ldrh.w r6, [fp, #1250]
ldrh.w r7, [fp, #1954]
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
ldrh.w sl, [r0, #546]
add.w r1, sl
strh.w r1, [r0, #546]
ldrh.w sl, [r0, #898]
add.w r3, sl
strh.w r3, [r0, #898]
ldrh.w sl, [r0, #1250]
add.w r8, sl
strh.w r8, [r0, #1250]
ldrh.w sl, [r0, #1602]
add.w r6, sl
strh.w r6, [r0, #1602]
ldrh.w sl, [r0, #1954]
add.w r9, sl
strh.w r9, [r0, #1954]
ldrh.w sl, [r0, #2306]
add.w r5, sl
strh.w r5, [r0, #2306]
strh.w r7, [r0, #2658]
ldrh.w r1, [sp, #548]
ldrh.w r2, [sp, #1252]
ldrh.w r3, [sp, #1956]
ldrh.w r4, [sp, #2660]
ldrh.w r5, [fp, #548]
ldrh.w r6, [fp, #1252]
ldrh.w r7, [fp, #1956]
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
ldrh.w sl, [r0, #548]
add.w r1, sl
strh.w r1, [r0, #548]
ldrh.w sl, [r0, #900]
add.w r3, sl
strh.w r3, [r0, #900]
ldrh.w sl, [r0, #1252]
add.w r8, sl
strh.w r8, [r0, #1252]
ldrh.w sl, [r0, #1604]
add.w r6, sl
strh.w r6, [r0, #1604]
ldrh.w sl, [r0, #1956]
add.w r9, sl
strh.w r9, [r0, #1956]
ldrh.w sl, [r0, #2308]
add.w r5, sl
strh.w r5, [r0, #2308]
strh.w r7, [r0, #2660]
ldrh.w r1, [sp, #550]
ldrh.w r2, [sp, #1254]
ldrh.w r3, [sp, #1958]
ldrh.w r4, [sp, #2662]
ldrh.w r5, [fp, #550]
ldrh.w r6, [fp, #1254]
ldrh.w r7, [fp, #1958]
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
ldrh.w sl, [r0, #550]
add.w r1, sl
strh.w r1, [r0, #550]
ldrh.w sl, [r0, #902]
add.w r3, sl
strh.w r3, [r0, #902]
ldrh.w sl, [r0, #1254]
add.w r8, sl
strh.w r8, [r0, #1254]
ldrh.w sl, [r0, #1606]
add.w r6, sl
strh.w r6, [r0, #1606]
ldrh.w sl, [r0, #1958]
add.w r9, sl
strh.w r9, [r0, #1958]
ldrh.w sl, [r0, #2310]
add.w r5, sl
strh.w r5, [r0, #2310]
strh.w r7, [r0, #2662]
ldrh.w r1, [sp, #552]
ldrh.w r2, [sp, #1256]
ldrh.w r3, [sp, #1960]
ldrh.w r4, [sp, #2664]
ldrh.w r5, [fp, #552]
ldrh.w r6, [fp, #1256]
ldrh.w r7, [fp, #1960]
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
ldrh.w sl, [r0, #552]
add.w r1, sl
strh.w r1, [r0, #552]
ldrh.w sl, [r0, #904]
add.w r3, sl
strh.w r3, [r0, #904]
ldrh.w sl, [r0, #1256]
add.w r8, sl
strh.w r8, [r0, #1256]
ldrh.w sl, [r0, #1608]
add.w r6, sl
strh.w r6, [r0, #1608]
ldrh.w sl, [r0, #1960]
add.w r9, sl
strh.w r9, [r0, #1960]
ldrh.w sl, [r0, #2312]
add.w r5, sl
strh.w r5, [r0, #2312]
strh.w r7, [r0, #2664]
ldrh.w r1, [sp, #554]
ldrh.w r2, [sp, #1258]
ldrh.w r3, [sp, #1962]
ldrh.w r4, [sp, #2666]
ldrh.w r5, [fp, #554]
ldrh.w r6, [fp, #1258]
ldrh.w r7, [fp, #1962]
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
ldrh.w sl, [r0, #554]
add.w r1, sl
strh.w r1, [r0, #554]
ldrh.w sl, [r0, #906]
add.w r3, sl
strh.w r3, [r0, #906]
ldrh.w sl, [r0, #1258]
add.w r8, sl
strh.w r8, [r0, #1258]
ldrh.w sl, [r0, #1610]
add.w r6, sl
strh.w r6, [r0, #1610]
ldrh.w sl, [r0, #1962]
add.w r9, sl
strh.w r9, [r0, #1962]
ldrh.w sl, [r0, #2314]
add.w r5, sl
strh.w r5, [r0, #2314]
strh.w r7, [r0, #2666]
ldrh.w r1, [sp, #556]
ldrh.w r2, [sp, #1260]
ldrh.w r3, [sp, #1964]
ldrh.w r4, [sp, #2668]
ldrh.w r5, [fp, #556]
ldrh.w r6, [fp, #1260]
ldrh.w r7, [fp, #1964]
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
ldrh.w sl, [r0, #556]
add.w r1, sl
strh.w r1, [r0, #556]
ldrh.w sl, [r0, #908]
add.w r3, sl
strh.w r3, [r0, #908]
ldrh.w sl, [r0, #1260]
add.w r8, sl
strh.w r8, [r0, #1260]
ldrh.w sl, [r0, #1612]
add.w r6, sl
strh.w r6, [r0, #1612]
ldrh.w sl, [r0, #1964]
add.w r9, sl
strh.w r9, [r0, #1964]
ldrh.w sl, [r0, #2316]
add.w r5, sl
strh.w r5, [r0, #2316]
strh.w r7, [r0, #2668]
ldrh.w r1, [sp, #558]
ldrh.w r2, [sp, #1262]
ldrh.w r3, [sp, #1966]
ldrh.w r4, [sp, #2670]
ldrh.w r5, [fp, #558]
ldrh.w r6, [fp, #1262]
ldrh.w r7, [fp, #1966]
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
ldrh.w sl, [r0, #558]
add.w r1, sl
strh.w r1, [r0, #558]
ldrh.w sl, [r0, #910]
add.w r3, sl
strh.w r3, [r0, #910]
ldrh.w sl, [r0, #1262]
add.w r8, sl
strh.w r8, [r0, #1262]
ldrh.w sl, [r0, #1614]
add.w r6, sl
strh.w r6, [r0, #1614]
ldrh.w sl, [r0, #1966]
add.w r9, sl
strh.w r9, [r0, #1966]
ldrh.w sl, [r0, #2318]
add.w r5, sl
strh.w r5, [r0, #2318]
strh.w r7, [r0, #2670]
ldrh.w r1, [sp, #560]
ldrh.w r2, [sp, #1264]
ldrh.w r3, [sp, #1968]
ldrh.w r4, [sp, #2672]
ldrh.w r5, [fp, #560]
ldrh.w r6, [fp, #1264]
ldrh.w r7, [fp, #1968]
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
ldrh.w sl, [r0, #560]
add.w r1, sl
strh.w r1, [r0, #560]
ldrh.w sl, [r0, #912]
add.w r3, sl
strh.w r3, [r0, #912]
ldrh.w sl, [r0, #1264]
add.w r8, sl
strh.w r8, [r0, #1264]
ldrh.w sl, [r0, #1616]
add.w r6, sl
strh.w r6, [r0, #1616]
ldrh.w sl, [r0, #1968]
add.w r9, sl
strh.w r9, [r0, #1968]
ldrh.w sl, [r0, #2320]
add.w r5, sl
strh.w r5, [r0, #2320]
strh.w r7, [r0, #2672]
ldrh.w r1, [sp, #562]
ldrh.w r2, [sp, #1266]
ldrh.w r3, [sp, #1970]
ldrh.w r4, [sp, #2674]
ldrh.w r5, [fp, #562]
ldrh.w r6, [fp, #1266]
ldrh.w r7, [fp, #1970]
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
ldrh.w sl, [r0, #562]
add.w r1, sl
strh.w r1, [r0, #562]
ldrh.w sl, [r0, #914]
add.w r3, sl
strh.w r3, [r0, #914]
ldrh.w sl, [r0, #1266]
add.w r8, sl
strh.w r8, [r0, #1266]
ldrh.w sl, [r0, #1618]
add.w r6, sl
strh.w r6, [r0, #1618]
ldrh.w sl, [r0, #1970]
add.w r9, sl
strh.w r9, [r0, #1970]
ldrh.w sl, [r0, #2322]
add.w r5, sl
strh.w r5, [r0, #2322]
strh.w r7, [r0, #2674]
ldrh.w r1, [sp, #564]
ldrh.w r2, [sp, #1268]
ldrh.w r3, [sp, #1972]
ldrh.w r4, [sp, #2676]
ldrh.w r5, [fp, #564]
ldrh.w r6, [fp, #1268]
ldrh.w r7, [fp, #1972]
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
ldrh.w sl, [r0, #564]
add.w r1, sl
strh.w r1, [r0, #564]
ldrh.w sl, [r0, #916]
add.w r3, sl
strh.w r3, [r0, #916]
ldrh.w sl, [r0, #1268]
add.w r8, sl
strh.w r8, [r0, #1268]
ldrh.w sl, [r0, #1620]
add.w r6, sl
strh.w r6, [r0, #1620]
ldrh.w sl, [r0, #1972]
add.w r9, sl
strh.w r9, [r0, #1972]
ldrh.w sl, [r0, #2324]
add.w r5, sl
strh.w r5, [r0, #2324]
strh.w r7, [r0, #2676]
ldrh.w r1, [sp, #566]
ldrh.w r2, [sp, #1270]
ldrh.w r3, [sp, #1974]
ldrh.w r4, [sp, #2678]
ldrh.w r5, [fp, #566]
ldrh.w r6, [fp, #1270]
ldrh.w r7, [fp, #1974]
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
ldrh.w sl, [r0, #566]
add.w r1, sl
strh.w r1, [r0, #566]
ldrh.w sl, [r0, #918]
add.w r3, sl
strh.w r3, [r0, #918]
ldrh.w sl, [r0, #1270]
add.w r8, sl
strh.w r8, [r0, #1270]
ldrh.w sl, [r0, #1622]
add.w r6, sl
strh.w r6, [r0, #1622]
ldrh.w sl, [r0, #1974]
add.w r9, sl
strh.w r9, [r0, #1974]
ldrh.w sl, [r0, #2326]
add.w r5, sl
strh.w r5, [r0, #2326]
strh.w r7, [r0, #2678]
ldrh.w r1, [sp, #568]
ldrh.w r2, [sp, #1272]
ldrh.w r3, [sp, #1976]
ldrh.w r4, [sp, #2680]
ldrh.w r5, [fp, #568]
ldrh.w r6, [fp, #1272]
ldrh.w r7, [fp, #1976]
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
ldrh.w sl, [r0, #568]
add.w r1, sl
strh.w r1, [r0, #568]
ldrh.w sl, [r0, #920]
add.w r3, sl
strh.w r3, [r0, #920]
ldrh.w sl, [r0, #1272]
add.w r8, sl
strh.w r8, [r0, #1272]
ldrh.w sl, [r0, #1624]
add.w r6, sl
strh.w r6, [r0, #1624]
ldrh.w sl, [r0, #1976]
add.w r9, sl
strh.w r9, [r0, #1976]
ldrh.w sl, [r0, #2328]
add.w r5, sl
strh.w r5, [r0, #2328]
strh.w r7, [r0, #2680]
ldrh.w r1, [sp, #570]
ldrh.w r2, [sp, #1274]
ldrh.w r3, [sp, #1978]
ldrh.w r4, [sp, #2682]
ldrh.w r5, [fp, #570]
ldrh.w r6, [fp, #1274]
ldrh.w r7, [fp, #1978]
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
ldrh.w sl, [r0, #570]
add.w r1, sl
strh.w r1, [r0, #570]
ldrh.w sl, [r0, #922]
add.w r3, sl
strh.w r3, [r0, #922]
ldrh.w sl, [r0, #1274]
add.w r8, sl
strh.w r8, [r0, #1274]
ldrh.w sl, [r0, #1626]
add.w r6, sl
strh.w r6, [r0, #1626]
ldrh.w sl, [r0, #1978]
add.w r9, sl
strh.w r9, [r0, #1978]
ldrh.w sl, [r0, #2330]
add.w r5, sl
strh.w r5, [r0, #2330]
strh.w r7, [r0, #2682]
ldrh.w r1, [sp, #572]
ldrh.w r2, [sp, #1276]
ldrh.w r3, [sp, #1980]
ldrh.w r4, [sp, #2684]
ldrh.w r5, [fp, #572]
ldrh.w r6, [fp, #1276]
ldrh.w r7, [fp, #1980]
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
ldrh.w sl, [r0, #572]
add.w r1, sl
strh.w r1, [r0, #572]
ldrh.w sl, [r0, #924]
add.w r3, sl
strh.w r3, [r0, #924]
ldrh.w sl, [r0, #1276]
add.w r8, sl
strh.w r8, [r0, #1276]
ldrh.w sl, [r0, #1628]
add.w r6, sl
strh.w r6, [r0, #1628]
ldrh.w sl, [r0, #1980]
add.w r9, sl
strh.w r9, [r0, #1980]
ldrh.w sl, [r0, #2332]
add.w r5, sl
strh.w r5, [r0, #2332]
strh.w r7, [r0, #2684]
ldrh.w r1, [sp, #574]
ldrh.w r2, [sp, #1278]
ldrh.w r3, [sp, #1982]
ldrh.w r4, [sp, #2686]
ldrh.w r5, [fp, #574]
ldrh.w r6, [fp, #1278]
ldrh.w r7, [fp, #1982]
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
ldrh.w sl, [r0, #574]
add.w r1, sl
strh.w r1, [r0, #574]
ldrh.w sl, [r0, #926]
add.w r3, sl
strh.w r3, [r0, #926]
ldrh.w sl, [r0, #1278]
add.w r8, sl
strh.w r8, [r0, #1278]
ldrh.w sl, [r0, #1630]
add.w r6, sl
strh.w r6, [r0, #1630]
ldrh.w sl, [r0, #1982]
add.w r9, sl
strh.w r9, [r0, #1982]
ldrh.w sl, [r0, #2334]
add.w r5, sl
strh.w r5, [r0, #2334]
strh.w r7, [r0, #2686]
ldrh.w r1, [sp, #576]
ldrh.w r2, [sp, #1280]
ldrh.w r3, [sp, #1984]
ldrh.w r4, [sp, #2688]
ldrh.w r5, [fp, #576]
ldrh.w r6, [fp, #1280]
ldrh.w r7, [fp, #1984]
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
ldrh.w sl, [r0, #576]
add.w r1, sl
strh.w r1, [r0, #576]
ldrh.w sl, [r0, #928]
add.w r3, sl
strh.w r3, [r0, #928]
ldrh.w sl, [r0, #1280]
add.w r8, sl
strh.w r8, [r0, #1280]
ldrh.w sl, [r0, #1632]
add.w r6, sl
strh.w r6, [r0, #1632]
ldrh.w sl, [r0, #1984]
add.w r9, sl
strh.w r9, [r0, #1984]
ldrh.w sl, [r0, #2336]
add.w r5, sl
strh.w r5, [r0, #2336]
strh.w r7, [r0, #2688]
ldrh.w r1, [sp, #578]
ldrh.w r2, [sp, #1282]
ldrh.w r3, [sp, #1986]
ldrh.w r4, [sp, #2690]
ldrh.w r5, [fp, #578]
ldrh.w r6, [fp, #1282]
ldrh.w r7, [fp, #1986]
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
ldrh.w sl, [r0, #578]
add.w r1, sl
strh.w r1, [r0, #578]
ldrh.w sl, [r0, #930]
add.w r3, sl
strh.w r3, [r0, #930]
ldrh.w sl, [r0, #1282]
add.w r8, sl
strh.w r8, [r0, #1282]
ldrh.w sl, [r0, #1634]
add.w r6, sl
strh.w r6, [r0, #1634]
ldrh.w sl, [r0, #1986]
add.w r9, sl
strh.w r9, [r0, #1986]
ldrh.w sl, [r0, #2338]
add.w r5, sl
strh.w r5, [r0, #2338]
strh.w r7, [r0, #2690]
ldrh.w r1, [sp, #580]
ldrh.w r2, [sp, #1284]
ldrh.w r3, [sp, #1988]
ldrh.w r4, [sp, #2692]
ldrh.w r5, [fp, #580]
ldrh.w r6, [fp, #1284]
ldrh.w r7, [fp, #1988]
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
ldrh.w sl, [r0, #580]
add.w r1, sl
strh.w r1, [r0, #580]
ldrh.w sl, [r0, #932]
add.w r3, sl
strh.w r3, [r0, #932]
ldrh.w sl, [r0, #1284]
add.w r8, sl
strh.w r8, [r0, #1284]
ldrh.w sl, [r0, #1636]
add.w r6, sl
strh.w r6, [r0, #1636]
ldrh.w sl, [r0, #1988]
add.w r9, sl
strh.w r9, [r0, #1988]
ldrh.w sl, [r0, #2340]
add.w r5, sl
strh.w r5, [r0, #2340]
strh.w r7, [r0, #2692]
ldrh.w r1, [sp, #582]
ldrh.w r2, [sp, #1286]
ldrh.w r3, [sp, #1990]
ldrh.w r4, [sp, #2694]
ldrh.w r5, [fp, #582]
ldrh.w r6, [fp, #1286]
ldrh.w r7, [fp, #1990]
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
ldrh.w sl, [r0, #582]
add.w r1, sl
strh.w r1, [r0, #582]
ldrh.w sl, [r0, #934]
add.w r3, sl
strh.w r3, [r0, #934]
ldrh.w sl, [r0, #1286]
add.w r8, sl
strh.w r8, [r0, #1286]
ldrh.w sl, [r0, #1638]
add.w r6, sl
strh.w r6, [r0, #1638]
ldrh.w sl, [r0, #1990]
add.w r9, sl
strh.w r9, [r0, #1990]
ldrh.w sl, [r0, #2342]
add.w r5, sl
strh.w r5, [r0, #2342]
strh.w r7, [r0, #2694]
ldrh.w r1, [sp, #584]
ldrh.w r2, [sp, #1288]
ldrh.w r3, [sp, #1992]
ldrh.w r4, [sp, #2696]
ldrh.w r5, [fp, #584]
ldrh.w r6, [fp, #1288]
ldrh.w r7, [fp, #1992]
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
ldrh.w sl, [r0, #584]
add.w r1, sl
strh.w r1, [r0, #584]
ldrh.w sl, [r0, #936]
add.w r3, sl
strh.w r3, [r0, #936]
ldrh.w sl, [r0, #1288]
add.w r8, sl
strh.w r8, [r0, #1288]
ldrh.w sl, [r0, #1640]
add.w r6, sl
strh.w r6, [r0, #1640]
ldrh.w sl, [r0, #1992]
add.w r9, sl
strh.w r9, [r0, #1992]
ldrh.w sl, [r0, #2344]
add.w r5, sl
strh.w r5, [r0, #2344]
strh.w r7, [r0, #2696]
ldrh.w r1, [sp, #586]
ldrh.w r2, [sp, #1290]
ldrh.w r3, [sp, #1994]
ldrh.w r4, [sp, #2698]
ldrh.w r5, [fp, #586]
ldrh.w r6, [fp, #1290]
ldrh.w r7, [fp, #1994]
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
ldrh.w sl, [r0, #586]
add.w r1, sl
strh.w r1, [r0, #586]
ldrh.w sl, [r0, #938]
add.w r3, sl
strh.w r3, [r0, #938]
ldrh.w sl, [r0, #1290]
add.w r8, sl
strh.w r8, [r0, #1290]
ldrh.w sl, [r0, #1642]
add.w r6, sl
strh.w r6, [r0, #1642]
ldrh.w sl, [r0, #1994]
add.w r9, sl
strh.w r9, [r0, #1994]
ldrh.w sl, [r0, #2346]
add.w r5, sl
strh.w r5, [r0, #2346]
strh.w r7, [r0, #2698]
ldrh.w r1, [sp, #588]
ldrh.w r2, [sp, #1292]
ldrh.w r3, [sp, #1996]
ldrh.w r4, [sp, #2700]
ldrh.w r5, [fp, #588]
ldrh.w r6, [fp, #1292]
ldrh.w r7, [fp, #1996]
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
ldrh.w sl, [r0, #588]
add.w r1, sl
strh.w r1, [r0, #588]
ldrh.w sl, [r0, #940]
add.w r3, sl
strh.w r3, [r0, #940]
ldrh.w sl, [r0, #1292]
add.w r8, sl
strh.w r8, [r0, #1292]
ldrh.w sl, [r0, #1644]
add.w r6, sl
strh.w r6, [r0, #1644]
ldrh.w sl, [r0, #1996]
add.w r9, sl
strh.w r9, [r0, #1996]
ldrh.w sl, [r0, #2348]
add.w r5, sl
strh.w r5, [r0, #2348]
strh.w r7, [r0, #2700]
ldrh.w r1, [sp, #590]
ldrh.w r2, [sp, #1294]
ldrh.w r3, [sp, #1998]
ldrh.w r4, [sp, #2702]
ldrh.w r5, [fp, #590]
ldrh.w r6, [fp, #1294]
ldrh.w r7, [fp, #1998]
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
ldrh.w sl, [r0, #590]
add.w r1, sl
strh.w r1, [r0, #590]
ldrh.w sl, [r0, #942]
add.w r3, sl
strh.w r3, [r0, #942]
ldrh.w sl, [r0, #1294]
add.w r8, sl
strh.w r8, [r0, #1294]
ldrh.w sl, [r0, #1646]
add.w r6, sl
strh.w r6, [r0, #1646]
ldrh.w sl, [r0, #1998]
add.w r9, sl
strh.w r9, [r0, #1998]
ldrh.w sl, [r0, #2350]
add.w r5, sl
strh.w r5, [r0, #2350]
strh.w r7, [r0, #2702]
ldrh.w r1, [sp, #592]
ldrh.w r2, [sp, #1296]
ldrh.w r3, [sp, #2000]
ldrh.w r4, [sp, #2704]
ldrh.w r5, [fp, #592]
ldrh.w r6, [fp, #1296]
ldrh.w r7, [fp, #2000]
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
ldrh.w sl, [r0, #592]
add.w r1, sl
strh.w r1, [r0, #592]
ldrh.w sl, [r0, #944]
add.w r3, sl
strh.w r3, [r0, #944]
ldrh.w sl, [r0, #1296]
add.w r8, sl
strh.w r8, [r0, #1296]
ldrh.w sl, [r0, #1648]
add.w r6, sl
strh.w r6, [r0, #1648]
ldrh.w sl, [r0, #2000]
add.w r9, sl
strh.w r9, [r0, #2000]
ldrh.w sl, [r0, #2352]
add.w r5, sl
strh.w r5, [r0, #2352]
strh.w r7, [r0, #2704]
ldrh.w r1, [sp, #594]
ldrh.w r2, [sp, #1298]
ldrh.w r3, [sp, #2002]
ldrh.w r4, [sp, #2706]
ldrh.w r5, [fp, #594]
ldrh.w r6, [fp, #1298]
ldrh.w r7, [fp, #2002]
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
ldrh.w sl, [r0, #594]
add.w r1, sl
strh.w r1, [r0, #594]
ldrh.w sl, [r0, #946]
add.w r3, sl
strh.w r3, [r0, #946]
ldrh.w sl, [r0, #1298]
add.w r8, sl
strh.w r8, [r0, #1298]
ldrh.w sl, [r0, #1650]
add.w r6, sl
strh.w r6, [r0, #1650]
ldrh.w sl, [r0, #2002]
add.w r9, sl
strh.w r9, [r0, #2002]
ldrh.w sl, [r0, #2354]
add.w r5, sl
strh.w r5, [r0, #2354]
strh.w r7, [r0, #2706]
ldrh.w r1, [sp, #596]
ldrh.w r2, [sp, #1300]
ldrh.w r3, [sp, #2004]
ldrh.w r4, [sp, #2708]
ldrh.w r5, [fp, #596]
ldrh.w r6, [fp, #1300]
ldrh.w r7, [fp, #2004]
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
ldrh.w sl, [r0, #596]
add.w r1, sl
strh.w r1, [r0, #596]
ldrh.w sl, [r0, #948]
add.w r3, sl
strh.w r3, [r0, #948]
ldrh.w sl, [r0, #1300]
add.w r8, sl
strh.w r8, [r0, #1300]
ldrh.w sl, [r0, #1652]
add.w r6, sl
strh.w r6, [r0, #1652]
ldrh.w sl, [r0, #2004]
add.w r9, sl
strh.w r9, [r0, #2004]
ldrh.w sl, [r0, #2356]
add.w r5, sl
strh.w r5, [r0, #2356]
strh.w r7, [r0, #2708]
ldrh.w r1, [sp, #598]
ldrh.w r2, [sp, #1302]
ldrh.w r3, [sp, #2006]
ldrh.w r4, [sp, #2710]
ldrh.w r5, [fp, #598]
ldrh.w r6, [fp, #1302]
ldrh.w r7, [fp, #2006]
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
ldrh.w sl, [r0, #598]
add.w r1, sl
strh.w r1, [r0, #598]
ldrh.w sl, [r0, #950]
add.w r3, sl
strh.w r3, [r0, #950]
ldrh.w sl, [r0, #1302]
add.w r8, sl
strh.w r8, [r0, #1302]
ldrh.w sl, [r0, #1654]
add.w r6, sl
strh.w r6, [r0, #1654]
ldrh.w sl, [r0, #2006]
add.w r9, sl
strh.w r9, [r0, #2006]
ldrh.w sl, [r0, #2358]
add.w r5, sl
strh.w r5, [r0, #2358]
strh.w r7, [r0, #2710]
ldrh.w r1, [sp, #600]
ldrh.w r2, [sp, #1304]
ldrh.w r3, [sp, #2008]
ldrh.w r4, [sp, #2712]
ldrh.w r5, [fp, #600]
ldrh.w r6, [fp, #1304]
ldrh.w r7, [fp, #2008]
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
ldrh.w sl, [r0, #600]
add.w r1, sl
strh.w r1, [r0, #600]
ldrh.w sl, [r0, #952]
add.w r3, sl
strh.w r3, [r0, #952]
ldrh.w sl, [r0, #1304]
add.w r8, sl
strh.w r8, [r0, #1304]
ldrh.w sl, [r0, #1656]
add.w r6, sl
strh.w r6, [r0, #1656]
ldrh.w sl, [r0, #2008]
add.w r9, sl
strh.w r9, [r0, #2008]
ldrh.w sl, [r0, #2360]
add.w r5, sl
strh.w r5, [r0, #2360]
strh.w r7, [r0, #2712]
ldrh.w r1, [sp, #602]
ldrh.w r2, [sp, #1306]
ldrh.w r3, [sp, #2010]
ldrh.w r4, [sp, #2714]
ldrh.w r5, [fp, #602]
ldrh.w r6, [fp, #1306]
ldrh.w r7, [fp, #2010]
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
ldrh.w sl, [r0, #602]
add.w r1, sl
strh.w r1, [r0, #602]
ldrh.w sl, [r0, #954]
add.w r3, sl
strh.w r3, [r0, #954]
ldrh.w sl, [r0, #1306]
add.w r8, sl
strh.w r8, [r0, #1306]
ldrh.w sl, [r0, #1658]
add.w r6, sl
strh.w r6, [r0, #1658]
ldrh.w sl, [r0, #2010]
add.w r9, sl
strh.w r9, [r0, #2010]
ldrh.w sl, [r0, #2362]
add.w r5, sl
strh.w r5, [r0, #2362]
strh.w r7, [r0, #2714]
ldrh.w r1, [sp, #604]
ldrh.w r2, [sp, #1308]
ldrh.w r3, [sp, #2012]
ldrh.w r4, [sp, #2716]
ldrh.w r5, [fp, #604]
ldrh.w r6, [fp, #1308]
ldrh.w r7, [fp, #2012]
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
ldrh.w sl, [r0, #604]
add.w r1, sl
strh.w r1, [r0, #604]
ldrh.w sl, [r0, #956]
add.w r3, sl
strh.w r3, [r0, #956]
ldrh.w sl, [r0, #1308]
add.w r8, sl
strh.w r8, [r0, #1308]
ldrh.w sl, [r0, #1660]
add.w r6, sl
strh.w r6, [r0, #1660]
ldrh.w sl, [r0, #2012]
add.w r9, sl
strh.w r9, [r0, #2012]
ldrh.w sl, [r0, #2364]
add.w r5, sl
strh.w r5, [r0, #2364]
strh.w r7, [r0, #2716]
ldrh.w r1, [sp, #606]
ldrh.w r2, [sp, #1310]
ldrh.w r3, [sp, #2014]
ldrh.w r4, [sp, #2718]
ldrh.w r5, [fp, #606]
ldrh.w r6, [fp, #1310]
ldrh.w r7, [fp, #2014]
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
ldrh.w sl, [r0, #606]
add.w r1, sl
strh.w r1, [r0, #606]
ldrh.w sl, [r0, #958]
add.w r3, sl
strh.w r3, [r0, #958]
ldrh.w sl, [r0, #1310]
add.w r8, sl
strh.w r8, [r0, #1310]
ldrh.w sl, [r0, #1662]
add.w r6, sl
strh.w r6, [r0, #1662]
ldrh.w sl, [r0, #2014]
add.w r9, sl
strh.w r9, [r0, #2014]
ldrh.w sl, [r0, #2366]
add.w r5, sl
strh.w r5, [r0, #2366]
strh.w r7, [r0, #2718]
ldrh.w r1, [sp, #608]
ldrh.w r2, [sp, #1312]
ldrh.w r3, [sp, #2016]
ldrh.w r4, [sp, #2720]
ldrh.w r5, [fp, #608]
ldrh.w r6, [fp, #1312]
ldrh.w r7, [fp, #2016]
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
ldrh.w sl, [r0, #608]
add.w r1, sl
strh.w r1, [r0, #608]
ldrh.w sl, [r0, #960]
add.w r3, sl
strh.w r3, [r0, #960]
ldrh.w sl, [r0, #1312]
add.w r8, sl
strh.w r8, [r0, #1312]
ldrh.w sl, [r0, #1664]
add.w r6, sl
strh.w r6, [r0, #1664]
ldrh.w sl, [r0, #2016]
add.w r9, sl
strh.w r9, [r0, #2016]
ldrh.w sl, [r0, #2368]
add.w r5, sl
strh.w r5, [r0, #2368]
strh.w r7, [r0, #2720]
ldrh.w r1, [sp, #610]
ldrh.w r2, [sp, #1314]
ldrh.w r3, [sp, #2018]
ldrh.w r4, [sp, #2722]
ldrh.w r5, [fp, #610]
ldrh.w r6, [fp, #1314]
ldrh.w r7, [fp, #2018]
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
ldrh.w sl, [r0, #610]
add.w r1, sl
strh.w r1, [r0, #610]
ldrh.w sl, [r0, #962]
add.w r3, sl
strh.w r3, [r0, #962]
ldrh.w sl, [r0, #1314]
add.w r8, sl
strh.w r8, [r0, #1314]
ldrh.w sl, [r0, #1666]
add.w r6, sl
strh.w r6, [r0, #1666]
ldrh.w sl, [r0, #2018]
add.w r9, sl
strh.w r9, [r0, #2018]
ldrh.w sl, [r0, #2370]
add.w r5, sl
strh.w r5, [r0, #2370]
strh.w r7, [r0, #2722]
ldrh.w r1, [sp, #612]
ldrh.w r2, [sp, #1316]
ldrh.w r3, [sp, #2020]
ldrh.w r4, [sp, #2724]
ldrh.w r5, [fp, #612]
ldrh.w r6, [fp, #1316]
ldrh.w r7, [fp, #2020]
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
ldrh.w sl, [r0, #612]
add.w r1, sl
strh.w r1, [r0, #612]
ldrh.w sl, [r0, #964]
add.w r3, sl
strh.w r3, [r0, #964]
ldrh.w sl, [r0, #1316]
add.w r8, sl
strh.w r8, [r0, #1316]
ldrh.w sl, [r0, #1668]
add.w r6, sl
strh.w r6, [r0, #1668]
ldrh.w sl, [r0, #2020]
add.w r9, sl
strh.w r9, [r0, #2020]
ldrh.w sl, [r0, #2372]
add.w r5, sl
strh.w r5, [r0, #2372]
strh.w r7, [r0, #2724]
ldrh.w r1, [sp, #614]
ldrh.w r2, [sp, #1318]
ldrh.w r3, [sp, #2022]
ldrh.w r4, [sp, #2726]
ldrh.w r5, [fp, #614]
ldrh.w r6, [fp, #1318]
ldrh.w r7, [fp, #2022]
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
ldrh.w sl, [r0, #614]
add.w r1, sl
strh.w r1, [r0, #614]
ldrh.w sl, [r0, #966]
add.w r3, sl
strh.w r3, [r0, #966]
ldrh.w sl, [r0, #1318]
add.w r8, sl
strh.w r8, [r0, #1318]
ldrh.w sl, [r0, #1670]
add.w r6, sl
strh.w r6, [r0, #1670]
ldrh.w sl, [r0, #2022]
add.w r9, sl
strh.w r9, [r0, #2022]
ldrh.w sl, [r0, #2374]
add.w r5, sl
strh.w r5, [r0, #2374]
strh.w r7, [r0, #2726]
ldrh.w r1, [sp, #616]
ldrh.w r2, [sp, #1320]
ldrh.w r3, [sp, #2024]
ldrh.w r4, [sp, #2728]
ldrh.w r5, [fp, #616]
ldrh.w r6, [fp, #1320]
ldrh.w r7, [fp, #2024]
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
ldrh.w sl, [r0, #616]
add.w r1, sl
strh.w r1, [r0, #616]
ldrh.w sl, [r0, #968]
add.w r3, sl
strh.w r3, [r0, #968]
ldrh.w sl, [r0, #1320]
add.w r8, sl
strh.w r8, [r0, #1320]
ldrh.w sl, [r0, #1672]
add.w r6, sl
strh.w r6, [r0, #1672]
ldrh.w sl, [r0, #2024]
add.w r9, sl
strh.w r9, [r0, #2024]
ldrh.w sl, [r0, #2376]
add.w r5, sl
strh.w r5, [r0, #2376]
strh.w r7, [r0, #2728]
ldrh.w r1, [sp, #618]
ldrh.w r2, [sp, #1322]
ldrh.w r3, [sp, #2026]
ldrh.w r4, [sp, #2730]
ldrh.w r5, [fp, #618]
ldrh.w r6, [fp, #1322]
ldrh.w r7, [fp, #2026]
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
ldrh.w sl, [r0, #618]
add.w r1, sl
strh.w r1, [r0, #618]
ldrh.w sl, [r0, #970]
add.w r3, sl
strh.w r3, [r0, #970]
ldrh.w sl, [r0, #1322]
add.w r8, sl
strh.w r8, [r0, #1322]
ldrh.w sl, [r0, #1674]
add.w r6, sl
strh.w r6, [r0, #1674]
ldrh.w sl, [r0, #2026]
add.w r9, sl
strh.w r9, [r0, #2026]
ldrh.w sl, [r0, #2378]
add.w r5, sl
strh.w r5, [r0, #2378]
strh.w r7, [r0, #2730]
ldrh.w r1, [sp, #620]
ldrh.w r2, [sp, #1324]
ldrh.w r3, [sp, #2028]
ldrh.w r4, [sp, #2732]
ldrh.w r5, [fp, #620]
ldrh.w r6, [fp, #1324]
ldrh.w r7, [fp, #2028]
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
ldrh.w sl, [r0, #620]
add.w r1, sl
strh.w r1, [r0, #620]
ldrh.w sl, [r0, #972]
add.w r3, sl
strh.w r3, [r0, #972]
ldrh.w sl, [r0, #1324]
add.w r8, sl
strh.w r8, [r0, #1324]
ldrh.w sl, [r0, #1676]
add.w r6, sl
strh.w r6, [r0, #1676]
ldrh.w sl, [r0, #2028]
add.w r9, sl
strh.w r9, [r0, #2028]
ldrh.w sl, [r0, #2380]
add.w r5, sl
strh.w r5, [r0, #2380]
strh.w r7, [r0, #2732]
ldrh.w r1, [sp, #622]
ldrh.w r2, [sp, #1326]
ldrh.w r3, [sp, #2030]
ldrh.w r4, [sp, #2734]
ldrh.w r5, [fp, #622]
ldrh.w r6, [fp, #1326]
ldrh.w r7, [fp, #2030]
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
ldrh.w sl, [r0, #622]
add.w r1, sl
strh.w r1, [r0, #622]
ldrh.w sl, [r0, #974]
add.w r3, sl
strh.w r3, [r0, #974]
ldrh.w sl, [r0, #1326]
add.w r8, sl
strh.w r8, [r0, #1326]
ldrh.w sl, [r0, #1678]
add.w r6, sl
strh.w r6, [r0, #1678]
ldrh.w sl, [r0, #2030]
add.w r9, sl
strh.w r9, [r0, #2030]
ldrh.w sl, [r0, #2382]
add.w r5, sl
strh.w r5, [r0, #2382]
strh.w r7, [r0, #2734]
ldrh.w r1, [sp, #624]
ldrh.w r2, [sp, #1328]
ldrh.w r3, [sp, #2032]
ldrh.w r4, [sp, #2736]
ldrh.w r5, [fp, #624]
ldrh.w r6, [fp, #1328]
ldrh.w r7, [fp, #2032]
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
ldrh.w sl, [r0, #624]
add.w r1, sl
strh.w r1, [r0, #624]
ldrh.w sl, [r0, #976]
add.w r3, sl
strh.w r3, [r0, #976]
ldrh.w sl, [r0, #1328]
add.w r8, sl
strh.w r8, [r0, #1328]
ldrh.w sl, [r0, #1680]
add.w r6, sl
strh.w r6, [r0, #1680]
ldrh.w sl, [r0, #2032]
add.w r9, sl
strh.w r9, [r0, #2032]
ldrh.w sl, [r0, #2384]
add.w r5, sl
strh.w r5, [r0, #2384]
strh.w r7, [r0, #2736]
ldrh.w r1, [sp, #626]
ldrh.w r2, [sp, #1330]
ldrh.w r3, [sp, #2034]
ldrh.w r4, [sp, #2738]
ldrh.w r5, [fp, #626]
ldrh.w r6, [fp, #1330]
ldrh.w r7, [fp, #2034]
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
ldrh.w sl, [r0, #626]
add.w r1, sl
strh.w r1, [r0, #626]
ldrh.w sl, [r0, #978]
add.w r3, sl
strh.w r3, [r0, #978]
ldrh.w sl, [r0, #1330]
add.w r8, sl
strh.w r8, [r0, #1330]
ldrh.w sl, [r0, #1682]
add.w r6, sl
strh.w r6, [r0, #1682]
ldrh.w sl, [r0, #2034]
add.w r9, sl
strh.w r9, [r0, #2034]
ldrh.w sl, [r0, #2386]
add.w r5, sl
strh.w r5, [r0, #2386]
strh.w r7, [r0, #2738]
ldrh.w r1, [sp, #628]
ldrh.w r2, [sp, #1332]
ldrh.w r3, [sp, #2036]
ldrh.w r4, [sp, #2740]
ldrh.w r5, [fp, #628]
ldrh.w r6, [fp, #1332]
ldrh.w r7, [fp, #2036]
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
ldrh.w sl, [r0, #628]
add.w r1, sl
strh.w r1, [r0, #628]
ldrh.w sl, [r0, #980]
add.w r3, sl
strh.w r3, [r0, #980]
ldrh.w sl, [r0, #1332]
add.w r8, sl
strh.w r8, [r0, #1332]
ldrh.w sl, [r0, #1684]
add.w r6, sl
strh.w r6, [r0, #1684]
ldrh.w sl, [r0, #2036]
add.w r9, sl
strh.w r9, [r0, #2036]
ldrh.w sl, [r0, #2388]
add.w r5, sl
strh.w r5, [r0, #2388]
strh.w r7, [r0, #2740]
ldrh.w r1, [sp, #630]
ldrh.w r2, [sp, #1334]
ldrh.w r3, [sp, #2038]
ldrh.w r4, [sp, #2742]
ldrh.w r5, [fp, #630]
ldrh.w r6, [fp, #1334]
ldrh.w r7, [fp, #2038]
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
ldrh.w sl, [r0, #630]
add.w r1, sl
strh.w r1, [r0, #630]
ldrh.w sl, [r0, #982]
add.w r3, sl
strh.w r3, [r0, #982]
ldrh.w sl, [r0, #1334]
add.w r8, sl
strh.w r8, [r0, #1334]
ldrh.w sl, [r0, #1686]
add.w r6, sl
strh.w r6, [r0, #1686]
ldrh.w sl, [r0, #2038]
add.w r9, sl
strh.w r9, [r0, #2038]
ldrh.w sl, [r0, #2390]
add.w r5, sl
strh.w r5, [r0, #2390]
strh.w r7, [r0, #2742]
ldrh.w r1, [sp, #632]
ldrh.w r2, [sp, #1336]
ldrh.w r3, [sp, #2040]
ldrh.w r4, [sp, #2744]
ldrh.w r5, [fp, #632]
ldrh.w r6, [fp, #1336]
ldrh.w r7, [fp, #2040]
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
ldrh.w sl, [r0, #632]
add.w r1, sl
strh.w r1, [r0, #632]
ldrh.w sl, [r0, #984]
add.w r3, sl
strh.w r3, [r0, #984]
ldrh.w sl, [r0, #1336]
add.w r8, sl
strh.w r8, [r0, #1336]
ldrh.w sl, [r0, #1688]
add.w r6, sl
strh.w r6, [r0, #1688]
ldrh.w sl, [r0, #2040]
add.w r9, sl
strh.w r9, [r0, #2040]
ldrh.w sl, [r0, #2392]
add.w r5, sl
strh.w r5, [r0, #2392]
strh.w r7, [r0, #2744]
ldrh.w r1, [sp, #634]
ldrh.w r2, [sp, #1338]
ldrh.w r3, [sp, #2042]
ldrh.w r4, [sp, #2746]
ldrh.w r5, [fp, #634]
ldrh.w r6, [fp, #1338]
ldrh.w r7, [fp, #2042]
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
ldrh.w sl, [r0, #634]
add.w r1, sl
strh.w r1, [r0, #634]
ldrh.w sl, [r0, #986]
add.w r3, sl
strh.w r3, [r0, #986]
ldrh.w sl, [r0, #1338]
add.w r8, sl
strh.w r8, [r0, #1338]
ldrh.w sl, [r0, #1690]
add.w r6, sl
strh.w r6, [r0, #1690]
ldrh.w sl, [r0, #2042]
add.w r9, sl
strh.w r9, [r0, #2042]
ldrh.w sl, [r0, #2394]
add.w r5, sl
strh.w r5, [r0, #2394]
strh.w r7, [r0, #2746]
ldrh.w r1, [sp, #636]
ldrh.w r2, [sp, #1340]
ldrh.w r3, [sp, #2044]
ldrh.w r4, [sp, #2748]
ldrh.w r5, [fp, #636]
ldrh.w r6, [fp, #1340]
ldrh.w r7, [fp, #2044]
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
ldrh.w sl, [r0, #636]
add.w r1, sl
strh.w r1, [r0, #636]
ldrh.w sl, [r0, #988]
add.w r3, sl
strh.w r3, [r0, #988]
ldrh.w sl, [r0, #1340]
add.w r8, sl
strh.w r8, [r0, #1340]
ldrh.w sl, [r0, #1692]
add.w r6, sl
strh.w r6, [r0, #1692]
ldrh.w sl, [r0, #2044]
add.w r9, sl
strh.w r9, [r0, #2044]
ldrh.w sl, [r0, #2396]
add.w r5, sl
strh.w r5, [r0, #2396]
strh.w r7, [r0, #2748]
ldrh.w r1, [sp, #638]
ldrh.w r2, [sp, #1342]
ldrh.w r3, [sp, #2046]
ldrh.w r4, [sp, #2750]
ldrh.w r5, [fp, #638]
ldrh.w r6, [fp, #1342]
ldrh.w r7, [fp, #2046]
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
ldrh.w sl, [r0, #638]
add.w r1, sl
strh.w r1, [r0, #638]
ldrh.w sl, [r0, #990]
add.w r3, sl
strh.w r3, [r0, #990]
ldrh.w sl, [r0, #1342]
add.w r8, sl
strh.w r8, [r0, #1342]
ldrh.w sl, [r0, #1694]
add.w r6, sl
strh.w r6, [r0, #1694]
ldrh.w sl, [r0, #2046]
add.w r9, sl
strh.w r9, [r0, #2046]
ldrh.w sl, [r0, #2398]
add.w r5, sl
strh.w r5, [r0, #2398]
strh.w r7, [r0, #2750]
ldrh.w r1, [sp, #640]
ldrh.w r2, [sp, #1344]
ldrh.w r3, [sp, #2048]
ldrh.w r4, [sp, #2752]
ldrh.w r5, [fp, #640]
ldrh.w r6, [fp, #1344]
ldrh.w r7, [fp, #2048]
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
ldrh.w sl, [r0, #640]
add.w r1, sl
strh.w r1, [r0, #640]
ldrh.w sl, [r0, #992]
add.w r3, sl
strh.w r3, [r0, #992]
ldrh.w sl, [r0, #1344]
add.w r8, sl
strh.w r8, [r0, #1344]
ldrh.w sl, [r0, #1696]
add.w r6, sl
strh.w r6, [r0, #1696]
ldrh.w sl, [r0, #2048]
add.w r9, sl
strh.w r9, [r0, #2048]
ldrh.w sl, [r0, #2400]
add.w r5, sl
strh.w r5, [r0, #2400]
strh.w r7, [r0, #2752]
ldrh.w r1, [sp, #642]
ldrh.w r2, [sp, #1346]
ldrh.w r3, [sp, #2050]
ldrh.w r4, [sp, #2754]
ldrh.w r5, [fp, #642]
ldrh.w r6, [fp, #1346]
ldrh.w r7, [fp, #2050]
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
ldrh.w sl, [r0, #642]
add.w r1, sl
strh.w r1, [r0, #642]
ldrh.w sl, [r0, #994]
add.w r3, sl
strh.w r3, [r0, #994]
ldrh.w sl, [r0, #1346]
add.w r8, sl
strh.w r8, [r0, #1346]
ldrh.w sl, [r0, #1698]
add.w r6, sl
strh.w r6, [r0, #1698]
ldrh.w sl, [r0, #2050]
add.w r9, sl
strh.w r9, [r0, #2050]
ldrh.w sl, [r0, #2402]
add.w r5, sl
strh.w r5, [r0, #2402]
strh.w r7, [r0, #2754]
ldrh.w r1, [sp, #644]
ldrh.w r2, [sp, #1348]
ldrh.w r3, [sp, #2052]
ldrh.w r4, [sp, #2756]
ldrh.w r5, [fp, #644]
ldrh.w r6, [fp, #1348]
ldrh.w r7, [fp, #2052]
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
ldrh.w sl, [r0, #644]
add.w r1, sl
strh.w r1, [r0, #644]
ldrh.w sl, [r0, #996]
add.w r3, sl
strh.w r3, [r0, #996]
ldrh.w sl, [r0, #1348]
add.w r8, sl
strh.w r8, [r0, #1348]
ldrh.w sl, [r0, #1700]
add.w r6, sl
strh.w r6, [r0, #1700]
ldrh.w sl, [r0, #2052]
add.w r9, sl
strh.w r9, [r0, #2052]
ldrh.w sl, [r0, #2404]
add.w r5, sl
strh.w r5, [r0, #2404]
strh.w r7, [r0, #2756]
ldrh.w r1, [sp, #646]
ldrh.w r2, [sp, #1350]
ldrh.w r3, [sp, #2054]
ldrh.w r4, [sp, #2758]
ldrh.w r5, [fp, #646]
ldrh.w r6, [fp, #1350]
ldrh.w r7, [fp, #2054]
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
ldrh.w sl, [r0, #646]
add.w r1, sl
strh.w r1, [r0, #646]
ldrh.w sl, [r0, #998]
add.w r3, sl
strh.w r3, [r0, #998]
ldrh.w sl, [r0, #1350]
add.w r8, sl
strh.w r8, [r0, #1350]
ldrh.w sl, [r0, #1702]
add.w r6, sl
strh.w r6, [r0, #1702]
ldrh.w sl, [r0, #2054]
add.w r9, sl
strh.w r9, [r0, #2054]
ldrh.w sl, [r0, #2406]
add.w r5, sl
strh.w r5, [r0, #2406]
strh.w r7, [r0, #2758]
ldrh.w r1, [sp, #648]
ldrh.w r2, [sp, #1352]
ldrh.w r3, [sp, #2056]
ldrh.w r4, [sp, #2760]
ldrh.w r5, [fp, #648]
ldrh.w r6, [fp, #1352]
ldrh.w r7, [fp, #2056]
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
ldrh.w sl, [r0, #648]
add.w r1, sl
strh.w r1, [r0, #648]
ldrh.w sl, [r0, #1000]
add.w r3, sl
strh.w r3, [r0, #1000]
ldrh.w sl, [r0, #1352]
add.w r8, sl
strh.w r8, [r0, #1352]
ldrh.w sl, [r0, #1704]
add.w r6, sl
strh.w r6, [r0, #1704]
ldrh.w sl, [r0, #2056]
add.w r9, sl
strh.w r9, [r0, #2056]
ldrh.w sl, [r0, #2408]
add.w r5, sl
strh.w r5, [r0, #2408]
strh.w r7, [r0, #2760]
ldrh.w r1, [sp, #650]
ldrh.w r2, [sp, #1354]
ldrh.w r3, [sp, #2058]
ldrh.w r4, [sp, #2762]
ldrh.w r5, [fp, #650]
ldrh.w r6, [fp, #1354]
ldrh.w r7, [fp, #2058]
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
ldrh.w sl, [r0, #650]
add.w r1, sl
strh.w r1, [r0, #650]
ldrh.w sl, [r0, #1002]
add.w r3, sl
strh.w r3, [r0, #1002]
ldrh.w sl, [r0, #1354]
add.w r8, sl
strh.w r8, [r0, #1354]
ldrh.w sl, [r0, #1706]
add.w r6, sl
strh.w r6, [r0, #1706]
ldrh.w sl, [r0, #2058]
add.w r9, sl
strh.w r9, [r0, #2058]
ldrh.w sl, [r0, #2410]
add.w r5, sl
strh.w r5, [r0, #2410]
strh.w r7, [r0, #2762]
ldrh.w r1, [sp, #652]
ldrh.w r2, [sp, #1356]
ldrh.w r3, [sp, #2060]
ldrh.w r4, [sp, #2764]
ldrh.w r5, [fp, #652]
ldrh.w r6, [fp, #1356]
ldrh.w r7, [fp, #2060]
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
ldrh.w sl, [r0, #652]
add.w r1, sl
strh.w r1, [r0, #652]
ldrh.w sl, [r0, #1004]
add.w r3, sl
strh.w r3, [r0, #1004]
ldrh.w sl, [r0, #1356]
add.w r8, sl
strh.w r8, [r0, #1356]
ldrh.w sl, [r0, #1708]
add.w r6, sl
strh.w r6, [r0, #1708]
ldrh.w sl, [r0, #2060]
add.w r9, sl
strh.w r9, [r0, #2060]
ldrh.w sl, [r0, #2412]
add.w r5, sl
strh.w r5, [r0, #2412]
strh.w r7, [r0, #2764]
ldrh.w r1, [sp, #654]
ldrh.w r2, [sp, #1358]
ldrh.w r3, [sp, #2062]
ldrh.w r4, [sp, #2766]
ldrh.w r5, [fp, #654]
ldrh.w r6, [fp, #1358]
ldrh.w r7, [fp, #2062]
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
ldrh.w sl, [r0, #654]
add.w r1, sl
strh.w r1, [r0, #654]
ldrh.w sl, [r0, #1006]
add.w r3, sl
strh.w r3, [r0, #1006]
ldrh.w sl, [r0, #1358]
add.w r8, sl
strh.w r8, [r0, #1358]
ldrh.w sl, [r0, #1710]
add.w r6, sl
strh.w r6, [r0, #1710]
ldrh.w sl, [r0, #2062]
add.w r9, sl
strh.w r9, [r0, #2062]
ldrh.w sl, [r0, #2414]
add.w r5, sl
strh.w r5, [r0, #2414]
strh.w r7, [r0, #2766]
ldrh.w r1, [sp, #656]
ldrh.w r2, [sp, #1360]
ldrh.w r3, [sp, #2064]
ldrh.w r4, [sp, #2768]
ldrh.w r5, [fp, #656]
ldrh.w r6, [fp, #1360]
ldrh.w r7, [fp, #2064]
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
ldrh.w sl, [r0, #656]
add.w r1, sl
strh.w r1, [r0, #656]
ldrh.w sl, [r0, #1008]
add.w r3, sl
strh.w r3, [r0, #1008]
ldrh.w sl, [r0, #1360]
add.w r8, sl
strh.w r8, [r0, #1360]
ldrh.w sl, [r0, #1712]
add.w r6, sl
strh.w r6, [r0, #1712]
ldrh.w sl, [r0, #2064]
add.w r9, sl
strh.w r9, [r0, #2064]
ldrh.w sl, [r0, #2416]
add.w r5, sl
strh.w r5, [r0, #2416]
strh.w r7, [r0, #2768]
ldrh.w r1, [sp, #658]
ldrh.w r2, [sp, #1362]
ldrh.w r3, [sp, #2066]
ldrh.w r4, [sp, #2770]
ldrh.w r5, [fp, #658]
ldrh.w r6, [fp, #1362]
ldrh.w r7, [fp, #2066]
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
ldrh.w sl, [r0, #658]
add.w r1, sl
strh.w r1, [r0, #658]
ldrh.w sl, [r0, #1010]
add.w r3, sl
strh.w r3, [r0, #1010]
ldrh.w sl, [r0, #1362]
add.w r8, sl
strh.w r8, [r0, #1362]
ldrh.w sl, [r0, #1714]
add.w r6, sl
strh.w r6, [r0, #1714]
ldrh.w sl, [r0, #2066]
add.w r9, sl
strh.w r9, [r0, #2066]
ldrh.w sl, [r0, #2418]
add.w r5, sl
strh.w r5, [r0, #2418]
strh.w r7, [r0, #2770]
ldrh.w r1, [sp, #660]
ldrh.w r2, [sp, #1364]
ldrh.w r3, [sp, #2068]
ldrh.w r4, [sp, #2772]
ldrh.w r5, [fp, #660]
ldrh.w r6, [fp, #1364]
ldrh.w r7, [fp, #2068]
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
ldrh.w sl, [r0, #660]
add.w r1, sl
strh.w r1, [r0, #660]
ldrh.w sl, [r0, #1012]
add.w r3, sl
strh.w r3, [r0, #1012]
ldrh.w sl, [r0, #1364]
add.w r8, sl
strh.w r8, [r0, #1364]
ldrh.w sl, [r0, #1716]
add.w r6, sl
strh.w r6, [r0, #1716]
ldrh.w sl, [r0, #2068]
add.w r9, sl
strh.w r9, [r0, #2068]
ldrh.w sl, [r0, #2420]
add.w r5, sl
strh.w r5, [r0, #2420]
strh.w r7, [r0, #2772]
ldrh.w r1, [sp, #662]
ldrh.w r2, [sp, #1366]
ldrh.w r3, [sp, #2070]
ldrh.w r4, [sp, #2774]
ldrh.w r5, [fp, #662]
ldrh.w r6, [fp, #1366]
ldrh.w r7, [fp, #2070]
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
ldrh.w sl, [r0, #662]
add.w r1, sl
strh.w r1, [r0, #662]
ldrh.w sl, [r0, #1014]
add.w r3, sl
strh.w r3, [r0, #1014]
ldrh.w sl, [r0, #1366]
add.w r8, sl
strh.w r8, [r0, #1366]
ldrh.w sl, [r0, #1718]
add.w r6, sl
strh.w r6, [r0, #1718]
ldrh.w sl, [r0, #2070]
add.w r9, sl
strh.w r9, [r0, #2070]
ldrh.w sl, [r0, #2422]
add.w r5, sl
strh.w r5, [r0, #2422]
strh.w r7, [r0, #2774]
ldrh.w r1, [sp, #664]
ldrh.w r2, [sp, #1368]
ldrh.w r3, [sp, #2072]
ldrh.w r4, [sp, #2776]
ldrh.w r5, [fp, #664]
ldrh.w r6, [fp, #1368]
ldrh.w r7, [fp, #2072]
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
ldrh.w sl, [r0, #664]
add.w r1, sl
strh.w r1, [r0, #664]
ldrh.w sl, [r0, #1016]
add.w r3, sl
strh.w r3, [r0, #1016]
ldrh.w sl, [r0, #1368]
add.w r8, sl
strh.w r8, [r0, #1368]
ldrh.w sl, [r0, #1720]
add.w r6, sl
strh.w r6, [r0, #1720]
ldrh.w sl, [r0, #2072]
add.w r9, sl
strh.w r9, [r0, #2072]
ldrh.w sl, [r0, #2424]
add.w r5, sl
strh.w r5, [r0, #2424]
strh.w r7, [r0, #2776]
ldrh.w r1, [sp, #666]
ldrh.w r2, [sp, #1370]
ldrh.w r3, [sp, #2074]
ldrh.w r4, [sp, #2778]
ldrh.w r5, [fp, #666]
ldrh.w r6, [fp, #1370]
ldrh.w r7, [fp, #2074]
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
ldrh.w sl, [r0, #666]
add.w r1, sl
strh.w r1, [r0, #666]
ldrh.w sl, [r0, #1018]
add.w r3, sl
strh.w r3, [r0, #1018]
ldrh.w sl, [r0, #1370]
add.w r8, sl
strh.w r8, [r0, #1370]
ldrh.w sl, [r0, #1722]
add.w r6, sl
strh.w r6, [r0, #1722]
ldrh.w sl, [r0, #2074]
add.w r9, sl
strh.w r9, [r0, #2074]
ldrh.w sl, [r0, #2426]
add.w r5, sl
strh.w r5, [r0, #2426]
strh.w r7, [r0, #2778]
ldrh.w r1, [sp, #668]
ldrh.w r2, [sp, #1372]
ldrh.w r3, [sp, #2076]
ldrh.w r4, [sp, #2780]
ldrh.w r5, [fp, #668]
ldrh.w r6, [fp, #1372]
ldrh.w r7, [fp, #2076]
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
ldrh.w sl, [r0, #668]
add.w r1, sl
strh.w r1, [r0, #668]
ldrh.w sl, [r0, #1020]
add.w r3, sl
strh.w r3, [r0, #1020]
ldrh.w sl, [r0, #1372]
add.w r8, sl
strh.w r8, [r0, #1372]
ldrh.w sl, [r0, #1724]
add.w r6, sl
strh.w r6, [r0, #1724]
ldrh.w sl, [r0, #2076]
add.w r9, sl
strh.w r9, [r0, #2076]
ldrh.w sl, [r0, #2428]
add.w r5, sl
strh.w r5, [r0, #2428]
strh.w r7, [r0, #2780]
ldrh.w r1, [sp, #670]
ldrh.w r2, [sp, #1374]
ldrh.w r3, [sp, #2078]
ldrh.w r4, [sp, #2782]
ldrh.w r5, [fp, #670]
ldrh.w r6, [fp, #1374]
ldrh.w r7, [fp, #2078]
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
ldrh.w sl, [r0, #670]
add.w r1, sl
strh.w r1, [r0, #670]
ldrh.w sl, [r0, #1022]
add.w r3, sl
strh.w r3, [r0, #1022]
ldrh.w sl, [r0, #1374]
add.w r8, sl
strh.w r8, [r0, #1374]
ldrh.w sl, [r0, #1726]
add.w r6, sl
strh.w r6, [r0, #1726]
ldrh.w sl, [r0, #2078]
add.w r9, sl
strh.w r9, [r0, #2078]
ldrh.w sl, [r0, #2430]
add.w r5, sl
strh.w r5, [r0, #2430]
strh.w r7, [r0, #2782]
ldrh.w r1, [sp, #672]
ldrh.w r2, [sp, #1376]
ldrh.w r3, [sp, #2080]
ldrh.w r4, [sp, #2784]
ldrh.w r5, [fp, #672]
ldrh.w r6, [fp, #1376]
ldrh.w r7, [fp, #2080]
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
ldrh.w sl, [r0, #672]
add.w r1, sl
strh.w r1, [r0, #672]
ldrh.w sl, [r0, #1024]
add.w r3, sl
strh.w r3, [r0, #1024]
ldrh.w sl, [r0, #1376]
add.w r8, sl
strh.w r8, [r0, #1376]
ldrh.w sl, [r0, #1728]
add.w r6, sl
strh.w r6, [r0, #1728]
ldrh.w sl, [r0, #2080]
add.w r9, sl
strh.w r9, [r0, #2080]
ldrh.w sl, [r0, #2432]
add.w r5, sl
strh.w r5, [r0, #2432]
strh.w r7, [r0, #2784]
ldrh.w r1, [sp, #674]
ldrh.w r2, [sp, #1378]
ldrh.w r3, [sp, #2082]
ldrh.w r4, [sp, #2786]
ldrh.w r5, [fp, #674]
ldrh.w r6, [fp, #1378]
ldrh.w r7, [fp, #2082]
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
ldrh.w sl, [r0, #674]
add.w r1, sl
strh.w r1, [r0, #674]
ldrh.w sl, [r0, #1026]
add.w r3, sl
strh.w r3, [r0, #1026]
ldrh.w sl, [r0, #1378]
add.w r8, sl
strh.w r8, [r0, #1378]
ldrh.w sl, [r0, #1730]
add.w r6, sl
strh.w r6, [r0, #1730]
ldrh.w sl, [r0, #2082]
add.w r9, sl
strh.w r9, [r0, #2082]
ldrh.w sl, [r0, #2434]
add.w r5, sl
strh.w r5, [r0, #2434]
strh.w r7, [r0, #2786]
ldrh.w r1, [sp, #676]
ldrh.w r2, [sp, #1380]
ldrh.w r3, [sp, #2084]
ldrh.w r4, [sp, #2788]
ldrh.w r5, [fp, #676]
ldrh.w r6, [fp, #1380]
ldrh.w r7, [fp, #2084]
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
ldrh.w sl, [r0, #676]
add.w r1, sl
strh.w r1, [r0, #676]
ldrh.w sl, [r0, #1028]
add.w r3, sl
strh.w r3, [r0, #1028]
ldrh.w sl, [r0, #1380]
add.w r8, sl
strh.w r8, [r0, #1380]
ldrh.w sl, [r0, #1732]
add.w r6, sl
strh.w r6, [r0, #1732]
ldrh.w sl, [r0, #2084]
add.w r9, sl
strh.w r9, [r0, #2084]
ldrh.w sl, [r0, #2436]
add.w r5, sl
strh.w r5, [r0, #2436]
strh.w r7, [r0, #2788]
ldrh.w r1, [sp, #678]
ldrh.w r2, [sp, #1382]
ldrh.w r3, [sp, #2086]
ldrh.w r4, [sp, #2790]
ldrh.w r5, [fp, #678]
ldrh.w r6, [fp, #1382]
ldrh.w r7, [fp, #2086]
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
ldrh.w sl, [r0, #678]
add.w r1, sl
strh.w r1, [r0, #678]
ldrh.w sl, [r0, #1030]
add.w r3, sl
strh.w r3, [r0, #1030]
ldrh.w sl, [r0, #1382]
add.w r8, sl
strh.w r8, [r0, #1382]
ldrh.w sl, [r0, #1734]
add.w r6, sl
strh.w r6, [r0, #1734]
ldrh.w sl, [r0, #2086]
add.w r9, sl
strh.w r9, [r0, #2086]
ldrh.w sl, [r0, #2438]
add.w r5, sl
strh.w r5, [r0, #2438]
strh.w r7, [r0, #2790]
ldrh.w r1, [sp, #680]
ldrh.w r2, [sp, #1384]
ldrh.w r3, [sp, #2088]
ldrh.w r4, [sp, #2792]
ldrh.w r5, [fp, #680]
ldrh.w r6, [fp, #1384]
ldrh.w r7, [fp, #2088]
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
ldrh.w sl, [r0, #680]
add.w r1, sl
strh.w r1, [r0, #680]
ldrh.w sl, [r0, #1032]
add.w r3, sl
strh.w r3, [r0, #1032]
ldrh.w sl, [r0, #1384]
add.w r8, sl
strh.w r8, [r0, #1384]
ldrh.w sl, [r0, #1736]
add.w r6, sl
strh.w r6, [r0, #1736]
ldrh.w sl, [r0, #2088]
add.w r9, sl
strh.w r9, [r0, #2088]
ldrh.w sl, [r0, #2440]
add.w r5, sl
strh.w r5, [r0, #2440]
strh.w r7, [r0, #2792]
ldrh.w r1, [sp, #682]
ldrh.w r2, [sp, #1386]
ldrh.w r3, [sp, #2090]
ldrh.w r4, [sp, #2794]
ldrh.w r5, [fp, #682]
ldrh.w r6, [fp, #1386]
ldrh.w r7, [fp, #2090]
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
ldrh.w sl, [r0, #682]
add.w r1, sl
strh.w r1, [r0, #682]
ldrh.w sl, [r0, #1034]
add.w r3, sl
strh.w r3, [r0, #1034]
ldrh.w sl, [r0, #1386]
add.w r8, sl
strh.w r8, [r0, #1386]
ldrh.w sl, [r0, #1738]
add.w r6, sl
strh.w r6, [r0, #1738]
ldrh.w sl, [r0, #2090]
add.w r9, sl
strh.w r9, [r0, #2090]
ldrh.w sl, [r0, #2442]
add.w r5, sl
strh.w r5, [r0, #2442]
strh.w r7, [r0, #2794]
ldrh.w r1, [sp, #684]
ldrh.w r2, [sp, #1388]
ldrh.w r3, [sp, #2092]
ldrh.w r4, [sp, #2796]
ldrh.w r5, [fp, #684]
ldrh.w r6, [fp, #1388]
ldrh.w r7, [fp, #2092]
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
ldrh.w sl, [r0, #684]
add.w r1, sl
strh.w r1, [r0, #684]
ldrh.w sl, [r0, #1036]
add.w r3, sl
strh.w r3, [r0, #1036]
ldrh.w sl, [r0, #1388]
add.w r8, sl
strh.w r8, [r0, #1388]
ldrh.w sl, [r0, #1740]
add.w r6, sl
strh.w r6, [r0, #1740]
ldrh.w sl, [r0, #2092]
add.w r9, sl
strh.w r9, [r0, #2092]
ldrh.w sl, [r0, #2444]
add.w r5, sl
strh.w r5, [r0, #2444]
strh.w r7, [r0, #2796]
ldrh.w r1, [sp, #686]
ldrh.w r2, [sp, #1390]
ldrh.w r3, [sp, #2094]
ldrh.w r4, [sp, #2798]
ldrh.w r5, [fp, #686]
ldrh.w r6, [fp, #1390]
ldrh.w r7, [fp, #2094]
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
ldrh.w sl, [r0, #686]
add.w r1, sl
strh.w r1, [r0, #686]
ldrh.w sl, [r0, #1038]
add.w r3, sl
strh.w r3, [r0, #1038]
ldrh.w sl, [r0, #1390]
add.w r8, sl
strh.w r8, [r0, #1390]
ldrh.w sl, [r0, #1742]
add.w r6, sl
strh.w r6, [r0, #1742]
ldrh.w sl, [r0, #2094]
add.w r9, sl
strh.w r9, [r0, #2094]
ldrh.w sl, [r0, #2446]
add.w r5, sl
strh.w r5, [r0, #2446]
strh.w r7, [r0, #2798]
ldrh.w r1, [sp, #688]
ldrh.w r2, [sp, #1392]
ldrh.w r3, [sp, #2096]
ldrh.w r4, [sp, #2800]
ldrh.w r5, [fp, #688]
ldrh.w r6, [fp, #1392]
ldrh.w r7, [fp, #2096]
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
ldrh.w sl, [r0, #688]
add.w r1, sl
strh.w r1, [r0, #688]
ldrh.w sl, [r0, #1040]
add.w r3, sl
strh.w r3, [r0, #1040]
ldrh.w sl, [r0, #1392]
add.w r8, sl
strh.w r8, [r0, #1392]
ldrh.w sl, [r0, #1744]
add.w r6, sl
strh.w r6, [r0, #1744]
ldrh.w sl, [r0, #2096]
add.w r9, sl
strh.w r9, [r0, #2096]
ldrh.w sl, [r0, #2448]
add.w r5, sl
strh.w r5, [r0, #2448]
strh.w r7, [r0, #2800]
ldrh.w r1, [sp, #690]
ldrh.w r2, [sp, #1394]
ldrh.w r3, [sp, #2098]
ldrh.w r4, [sp, #2802]
ldrh.w r5, [fp, #690]
ldrh.w r6, [fp, #1394]
ldrh.w r7, [fp, #2098]
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
ldrh.w sl, [r0, #690]
add.w r1, sl
strh.w r1, [r0, #690]
ldrh.w sl, [r0, #1042]
add.w r3, sl
strh.w r3, [r0, #1042]
ldrh.w sl, [r0, #1394]
add.w r8, sl
strh.w r8, [r0, #1394]
ldrh.w sl, [r0, #1746]
add.w r6, sl
strh.w r6, [r0, #1746]
ldrh.w sl, [r0, #2098]
add.w r9, sl
strh.w r9, [r0, #2098]
ldrh.w sl, [r0, #2450]
add.w r5, sl
strh.w r5, [r0, #2450]
ldrh.w r1, [sp, #692]
ldrh.w r2, [sp, #1396]
ldrh.w r3, [sp, #2100]
ldrh.w r4, [sp, #2804]
ldrh.w r5, [fp, #692]
ldrh.w r6, [fp, #1396]
ldrh.w r7, [fp, #2100]
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
ldrh.w sl, [r0, #692]
add.w r1, sl
strh.w r1, [r0, #692]
ldrh.w sl, [r0, #1044]
add.w r3, sl
strh.w r3, [r0, #1044]
ldrh.w sl, [r0, #1396]
add.w r8, sl
strh.w r8, [r0, #1396]
ldrh.w sl, [r0, #1748]
add.w r6, sl
strh.w r6, [r0, #1748]
ldrh.w sl, [r0, #2100]
add.w r9, sl
strh.w r9, [r0, #2100]
ldrh.w sl, [r0, #2452]
add.w r5, sl
strh.w r5, [r0, #2452]
ldrh.w r1, [sp, #694]
ldrh.w r2, [sp, #1398]
ldrh.w r3, [sp, #2102]
ldrh.w r4, [sp, #2806]
ldrh.w r5, [fp, #694]
ldrh.w r6, [fp, #1398]
ldrh.w r7, [fp, #2102]
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
ldrh.w sl, [r0, #694]
add.w r1, sl
strh.w r1, [r0, #694]
ldrh.w sl, [r0, #1046]
add.w r3, sl
strh.w r3, [r0, #1046]
ldrh.w sl, [r0, #1398]
add.w r8, sl
strh.w r8, [r0, #1398]
ldrh.w sl, [r0, #1750]
add.w r6, sl
strh.w r6, [r0, #1750]
ldrh.w sl, [r0, #2102]
add.w r9, sl
strh.w r9, [r0, #2102]
ldrh.w sl, [r0, #2454]
add.w r5, sl
strh.w r5, [r0, #2454]
ldrh.w r1, [sp, #696]
ldrh.w r2, [sp, #1400]
ldrh.w r3, [sp, #2104]
ldrh.w r4, [sp, #2808]
ldrh.w r5, [fp, #696]
ldrh.w r6, [fp, #1400]
ldrh.w r7, [fp, #2104]
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
ldrh.w sl, [r0, #696]
add.w r1, sl
strh.w r1, [r0, #696]
ldrh.w sl, [r0, #1048]
add.w r3, sl
strh.w r3, [r0, #1048]
ldrh.w sl, [r0, #1400]
add.w r8, sl
strh.w r8, [r0, #1400]
ldrh.w sl, [r0, #1752]
add.w r6, sl
strh.w r6, [r0, #1752]
ldrh.w sl, [r0, #2104]
add.w r9, sl
strh.w r9, [r0, #2104]
ldrh.w sl, [r0, #2456]
add.w r5, sl
strh.w r5, [r0, #2456]
ldrh.w r1, [sp, #698]
ldrh.w r2, [sp, #1402]
ldrh.w r3, [sp, #2106]
ldrh.w r4, [sp, #2810]
ldrh.w r5, [fp, #698]
ldrh.w r6, [fp, #1402]
ldrh.w r7, [fp, #2106]
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
ldrh.w sl, [r0, #698]
add.w r1, sl
strh.w r1, [r0, #698]
ldrh.w sl, [r0, #1050]
add.w r3, sl
strh.w r3, [r0, #1050]
ldrh.w sl, [r0, #1402]
add.w r8, sl
strh.w r8, [r0, #1402]
ldrh.w sl, [r0, #1754]
add.w r6, sl
strh.w r6, [r0, #1754]
ldrh.w sl, [r0, #2106]
add.w r9, sl
strh.w r9, [r0, #2106]
ldrh.w sl, [r0, #2458]
add.w r5, sl
strh.w r5, [r0, #2458]
ldrh.w r1, [sp, #700]
ldrh.w r2, [sp, #1404]
ldrh.w r3, [sp, #2108]
ldrh.w r4, [sp, #2812]
ldrh.w r5, [fp, #700]
ldrh.w r6, [fp, #1404]
ldrh.w r7, [fp, #2108]
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
ldrh.w sl, [r0, #700]
add.w r1, sl
strh.w r1, [r0, #700]
ldrh.w sl, [r0, #1052]
add.w r3, sl
strh.w r3, [r0, #1052]
ldrh.w sl, [r0, #1404]
add.w r8, sl
strh.w r8, [r0, #1404]
ldrh.w sl, [r0, #1756]
add.w r6, sl
strh.w r6, [r0, #1756]
ldrh.w sl, [r0, #2108]
add.w r9, sl
strh.w r9, [r0, #2108]
ldrh.w sl, [r0, #2460]
add.w r5, sl
strh.w r5, [r0, #2460]
mov.w fp, #4928
add.w sp, fp
ldmia.w sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
bx lr
