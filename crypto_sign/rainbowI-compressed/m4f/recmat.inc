.macro recmat_inner xiyi, lutgf, recmat, tmp0, tmp1, tmp2, tmp3
    ldrb.w \xiyi, [\lutgf, \xiyi]
    add.w \xiyi, sp, \xiyi, lsl#4 // log_2(M)
    ldr.w \tmp0, [\xiyi, #0]
    ldr.w \tmp1, [\xiyi, #4]
    ldr.w \tmp3, [\recmat, #4]
    ldr.w \tmp2, [\recmat], #8
    eor.w \tmp0, \tmp0, \tmp2
	str.w \tmp0, [\xiyi, #0]
	eor.w \tmp1, \tmp1, \tmp3
	str.w \tmp1, [\xiyi, #4]

    ldr.w \tmp0, [\xiyi, #8]
    ldr.w \tmp1, [\xiyi, #12]
    ldr.w \tmp3, [\recmat, #4]
    ldr.w \tmp2, [\recmat], #8

    eor.w \tmp0, \tmp0, \tmp2
	str.w \tmp0, [\xiyi, #8]
	eor.w \tmp1, \tmp1, \tmp3
	str.w \tmp1, [\xiyi, #12]
.endm

