.syntax unified
.thumb

.cpu cortex-m4
.arch armv7e-m
.fpu fpv4-sp-d16

.global haetae_approx_exp_asm
.type haetae_approx_exp_asm,%function
.align
haetae_approx_exp_asm:
        lsrs    r2, r0, #24
        orr     r2, r2, r1, lsl #8
        push    {r4, r5, r6, r7, r8, r9, r10, fp, lr}
        ldr     r5, haetae_approx_exp_asm_constants
        ldr     r4, haetae_approx_exp_asm_constants+4
        ldr     r7, haetae_approx_exp_asm_constants+8
        sub     r0, r0, r2, lsl #24
        smull   r3, r1, r0, r5
        lsrs    r3, r3, #24
        orr     r3, r3, r1, lsl #8
        asrs    r1, r1, #24
        smlal   r3, r1, r0, r4
        smlal   r3, r1, r2, r5
        adds    r3, r3, #0x00800000
        adc     r1, r1, #0
        lsrs    r3, r3, #24
        orr     r3, r3, r1, lsl #8
        asrs    r1, r1, #24
        smlal   r3, r1, r2, r4
        adds    r3, r3, #4
        adc     r1, r1, #0
        ldr     r4, haetae_approx_exp_asm_constants+12
        lsrs    r3, r3, #3
        orr     r3, r3, r1, lsl #29
        adds    r3, r3, r4
        movw    lr, #46269
        adc     lr, lr, r1, asr #3
        lsr     ip, r3, #24
        orr     ip, ip, lr, lsl #8
        sub     r3, r3, ip, lsl #24
        smull   r6, r10, r3, r0
        asr     lr, lr, #24
        asrs    r1, r0, #31
        mul     r5, r0, lr
        lsrs    r6, r6, #24
        umull   r4, fp, r0, ip
        mla     r5, ip, r1, r5
        orr     r6, r6, r10, lsl #8
        adds    r4, r4, r6
        add     r5, r5, fp
        adc     r5, r5, r10, asr #24
        smlal   r4, r5, r3, r2
        adds    r4, r4, #0x00800000
        adc     r5, r5, #0
        asrs    r1, r2, #31
        mul     lr, r2, lr
        lsrs    r4, r4, #24
        mla     lr, ip, r1, lr
        orr     r4, r4, r5, lsl #8
        umull   ip, r3, r2, ip
        adds    ip, ip, r4
        add     lr, lr, r3
        adc     lr, lr, r5, asr #24
        adds    ip, ip, #4
        adc     lr, lr, #0
        ldr     r1, haetae_approx_exp_asm_constants+16
        lsr     ip, ip, #3
        orr     ip, ip, lr, lsl #29
        adds    ip, ip, r1
        adc     r7, r7, lr, asr #3
        lsr     r1, ip, #24
        orr     r1, r1, r7, lsl #8
        sub     ip, ip, r1, lsl #24
        smull   r3, r4, ip, r0
        lsrs    r3, r3, #24
        orr     r3, r3, r4, lsl #8
        asrs    r4, r4, #24
        smlal   r3, r4, r1, r0
        smlal   r3, r4, ip, r2
        adds    r3, r3, #0x00800000
        adc     r4, r4, #0
        lsrs    r3, r3, #24
        orr     r3, r3, r4, lsl #8
        asrs    r4, r4, #24
        smlal   r3, r4, r1, r2
        adds    r3, r3, #2
        adc     r1, r4, #0
        lsrs    r4, r3, #2
        ldr     r3, haetae_approx_exp_asm_constants+20
        orr     r4, r4, r1, lsl #30
        adds    r4, r4, r3
        movw    r3, #43690
        adc     r3, r3, r1, asr #2
        lsrs    r1, r4, #24
        orr     r1, r1, r3, lsl #8
        sub     r4, r4, r1, lsl #24
        smull   r3, r5, r4, r0
        lsrs    r3, r3, #24
        orr     r3, r3, r5, lsl #8
        asrs    r5, r5, #24
        smlal   r3, r5, r1, r0
        smlal   r3, r5, r4, r2
        adds    r3, r3, #0x00800000
        adc     r4, r5, #0
        lsrs    r3, r3, #24
        orr     r3, r3, r4, lsl #8
        asrs    r4, r4, #24
        smlal   r3, r4, r1, r2
        adds    r3, r3, #2
        adc     r1, r4, #0
        lsrs    r3, r3, #2
        ldr     r4, haetae_approx_exp_asm_constants+24
        orr     r3, r3, r1, lsl #30
        adds    r3, r3, r4
        ldr     r4, haetae_approx_exp_asm_constants+28
        adc     r4, r4, r1, asr #2
        lsrs    r1, r3, #24
        orr     r1, r1, r4, lsl #8
        sub     r4, r3, r1, lsl #24
        smull   r3, r5, r4, r0
        lsrs    r3, r3, #24
        orr     r3, r3, r5, lsl #8
        asrs    r5, r5, #24
        smlal   r3, r5, r1, r0
        smlal   r3, r5, r4, r2
        adds    r3, r3, #0x00800000
        adc     r4, r5, #0
        lsrs    r3, r3, #24
        orr     r3, r3, r4, lsl #8
        asrs    r4, r4, #24
        smlal   r3, r4, r1, r2
        adds    r3, r3, #1
        adc     r1, r4, #0
        lsrs    r3, r3, #1
        ldr     r4, haetae_approx_exp_asm_constants+32
        orr     r3, r3, r1, lsl #31
        adds    r3, r3, r4
        movw    r8, #65535
        adc     r4, r8, r1, asr #1
        lsrs    r1, r3, #24
        orr     r1, r1, r4, lsl #8
        sub     r4, r3, r1, lsl #24
        smull   r3, r5, r4, r0
        lsrs    r3, r3, #24
        orr     r3, r3, r5, lsl #8
        asrs    r5, r5, #24
        smlal   r3, r5, r1, r0
        smlal   r3, r5, r4, r2
        adds    r3, r3, #0x00800000
        adc     r4, r5, #0
        lsrs    r3, r3, #24
        orr     r3, r3, r4, lsl #8
        asrs    r4, r4, #24
        smlal   r3, r4, r1, r2
        adds    r3, r3, #1
        adc     r1, r4, #0
        lsrs    r3, r3, #1
        orr     r3, r3, r1, lsl #31
        movw    r4, #1953
        adds    r3, r3, r4
        ldr     r4, haetae_approx_exp_asm_constants+36
        lsr     r5, r3, #24
        adc     r1, r4, r1, asr #1
        orr     r5, r5, r1, lsl #8
        sub     r3, r3, r5, lsl #24
        smull   r4, r1, r3, r0
        lsrs    r4, r4, #24
        orr     r4, r4, r1, lsl #8
        asrs    r1, r1, #24
        smlal   r4, r1, r5, r0
        smlal   r4, r1, r3, r2
        adds    r0, r4, #0x00800000
        adc     r1, r1, #0
        lsrs    r0, r0, #24
        orr     r0, r0, r1, lsl #8
        asrs    r1, r1, #24
        smlal   r0, r1, r5, r2
        mvn     r9, #3
        adds    r0, r0, r9
        adc     r1, r8, r1
        pop     {r4, r5, r6, r7, r8, r9, r10, fp, pc}

.ltorg
.align
haetae_approx_exp_asm_constants:
        .4byte  16177746
        .4byte  -11978293
        .4byte  -34944
        .4byte  1308119591
        .4byte  -1920242146
        .4byte  1681686157
        .4byte  1451132442
        .4byte  -43691
        .4byte  -315782
        .4byte  -65536
.size haetae_approx_exp_asm,.-haetae_approx_exp_asm