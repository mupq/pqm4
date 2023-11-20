.syntax unified
.thumb

.cpu cortex-m4
.arch armv7e-m
.fpu fpv4-sp-d16


// This code uses UMULL - which is constant time on the M4, but not on the M3
// Make sure that this code is never used on an M3
smlad r0,r0,r0,r0


// ################################################################
// ############          CONFIGURATION          ###################
// ################################################################

#define CDT_GAUSS16 cdt_gauss16

// ################################################################
// ############        END CONFIGURATION        ###################
// ################################################################


//void haetae_fast_sample_gauss16(const uint64_t rand16);
.global haetae_fast_sample_gauss16
.type haetae_fast_sample_gauss16,%function
.align
haetae_fast_sample_gauss16:
    //bind aliases
    rand16x2      .req R0
    accum         .req R1
    ptr_cdt       .req R2
    ptr_end_cdt   .req R7
    ones          .req R8
    zeros         .req R9

    //preserve registers
    push {R4-R9, R14}
    orr     rand16x2, rand16x2, rand16x2, lsl #16
    mov     accum, #0x00000000
    ldr     ptr_cdt, =#CDT_GAUSS16
    mov     ones, #0x00010001
    mov     zeros, #0x00000000
    add     ptr_end_cdt, ptr_cdt, #(2*8*8)
    b       haetae_fast_sample_gauss16_check
.align
haetae_fast_sample_gauss16_loop:
    ldm     ptr_cdt!, {R3-R6}
    usub16  R3, R3, rand16x2
    sel     R3, zeros, ones
    uadd16  accum, accum, R3
    usub16  R4, R4, rand16x2
    sel     R4, zeros, ones
    uadd16  accum, accum, R4
    usub16  R5, R5, rand16x2
    sel     R5, zeros, ones
    uadd16  accum, accum, R5
    usub16  R6, R6, rand16x2
    sel     R6, zeros, ones
    uadd16  accum, accum, R6
haetae_fast_sample_gauss16_check:
    cmp     ptr_cdt, ptr_end_cdt
    blo     haetae_fast_sample_gauss16_loop

    add     r0, accum, accum, lsr #16
    uxth    r0, r0
//    movs    r1, #0        // output type changed to fp8_4 (aka int32_t)

    //restore registers
    pop {R4-R9, PC}

    //unbind aliases
    .unreq rand16x2
    .unreq accum
    .unreq ptr_cdt
    .unreq ptr_end_cdt
    .unreq ones
    .unreq zeros

.ltorg  //

.type cdt_gauss16, %object
.align 4
cdt_gauss16:
.2byte   3266,  6520,  9748, 12938, 16079, 19159, 22168, 25096
.2byte  27934, 30674, 33309, 35833, 38241, 40531, 42698, 44742
.2byte  46663, 48460, 50135, 51690, 53128, 54454, 55670, 56781
.2byte  57794, 58712, 59541, 60287, 60956, 61554, 62085, 62556
.2byte  62972, 63337, 63657, 63936, 64178, 64388, 64569, 64724
.2byte  64857, 64970, 65066, 65148, 65216, 65273, 65321, 65361
.2byte  65394, 65422, 65444, 65463, 65478, 65490, 65500, 65508
.2byte  65514, 65519, 65523, 65527, 65529, 65531, 65533, 65534
.size cdt_gauss16,.-cdt_gauss16
