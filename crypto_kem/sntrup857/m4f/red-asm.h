#ifndef _RED_ASM_H_
#define _RED_ASM_H_ 1

// macros for reduction mod qq	

	.macro	mr_hi, res32, qq, neg_qqinv, scr
	smulbb	\scr, \res32, \neg_qqinv
	smlabb	\res32, \qq, \scr, \res32
	.endm
	
	.macro	mr_16x2, r0, r1, qq, neg_qqinv, scr, res
	mr_hi	\r0, \qq, \neg_qqinv, \scr
	mr_hi	\r1, \qq, \neg_qqinv, \scr
    	.ifb	\res
	pkhtb	\r0, \r1, \r0, ASR #16
	.else	
	pkhtb	\res, \r1, \r0, ASR #16
	.endif
	.endm

	.macro	br_lo, res, mq, q32inv, _2p15, scr
	smlawb	\scr, \q32inv, \res, \_2p15
	smlatb	\res, \scr, \mq, \res
	.endm
	// note that high half of res is undefined
	// must save with strh

	.macro	br_16x2, res, mq, q32inv, _2p15, scr1, scr2, newres
	smlawb	\scr1, \q32inv, \res, \_2p15
	smlatb	\scr2, \scr1, \mq, \res
	smlawt	\scr1, \q32inv, \res, \_2p15
	smultb	\scr1, \scr1, \mq
	add	\scr1, \res, \scr1, LSL #16 
	.ifb	\newres
	pkhbt	\res, \scr2, \scr1
	.else	
	pkhbt	\newres, \scr2, \scr1
	.endif
	.endm	

	.macro	br_32, res, mq, q32inv, scr, newres
	smmulr	\scr, \res, \q32inv
	.ifb	\newres
	mla	\res, \mq, \scr, \res
	.else	
	mla	\newres, \mq, \scr, \res
	.endif
	.endm

	  
	.macro	br_32x2, res0, res1, mq, q32inv, scr
	smmulr	\scr, \res0, \q32inv
	mla	\res0, \mq, \scr, \res0
	smmulr	\scr, \res1, \q32inv
	mla	\res1, \mq, \scr, \res1
	pkhbt   \res0, \res0, \res1, LSL #16  
	.endm  
	  

#endif
