.macro GLOBFUNC name:req,names:vararg
.global \name
.type \name,%function
.ifnb \names
GLOBFUNC \names
.endif
.endm


	
.macro FUNCTION name:req,names:vararg
GLOBFUNC \name,\names
.func \name,\name
.thumb_func
\name\():
.endm



.macro ENDFUNC name:req
.pool
.size \name,.-\name
.endfunc
.endm



.macro GLOBOBJ name:req,names:vararg
.global \name
.type \name,%object
.ifnb \names
GLOBOBJ \names
.endif
.endm



.macro OBJECT name:req,names:vararg
GLOBOBJ \name,\names
\name\():
.endm



.macro ENDOBJ name:req
.size \name,.-\name
.endm



.macro SECTION name:req
.section \name,"ax",%progbits
.endm



.macro .rodata
.section .rodata
.endm
