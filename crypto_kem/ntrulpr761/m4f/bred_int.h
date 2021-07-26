#ifndef __BRED_INT_H
#define __BRED_INT_H



// return the barrett reduction of C
// Q is modulus, QI = -round(2^32/Q)
__attribute__(( always_inline )) inline int bred(int C, int Q, int QI) { 
  int result;								
  __asm__ volatile ("smmulr %0, %1, %2 \n\t"	/* round(C/Q) */	\
		    "mla %0, %0, %3, %1"				\
		    : "=&r"(result)					\
		    : "r"(C), "r" (QI), "r"(Q)				\
		    );
  return(result);
  }									

    
// return the barrett reduction of 16-bit parts of AB in C 
// Q is modulus, QI = -round(2^32/Q), pos is bb, bt, tb, or tt 
#define bmul(C, A, B, Q, QI, pos)				\
  do {								\
  int scratch;							\
  __asm__ volatile ("smul" #pos " %0, %2, %3 \n\t"              \
"smmulr %1, %0, %4 \n\t"					\
"mla %0, %1, %5, %0"						\
: "=&r"((C)), "=&r"(scratch)					\
  : "r"((A)), "r"((B)), "r"((QI)), "r"((Q))			\
  )								\
} while (0)

// both top and bottom of C are reduced
// Q is modulus, QI = -round(2^32/Q)
    

__attribute__(( always_inline )) inline int bred_16x2(int C, int Q, int QI)
{
  int result;							\
  __asm__ volatile ( "smlawt	%1, %2, %0, %4\n\t"		\
		     "smultb	%1, %1, %3 \n\t"		\
		     "add	%0, %0, %1, LSL #16\n\t"	\
		     "smlawb	%1, %2, %0, %4\n\t"		\
		     "smlatb	%1, %1, %3, %0\n\t"		\
		     "pkhbt	%1, %1, %0"			\
		     :   "+r"((C)), "=&r" (result)		\
		     : "r"((QI)), "r"((Q)), "r"(32768)		\
		     );						
  return(result);
}

// A and B are reduced and made into 32-bit with A bottom 
// Q is modulus, QI = -round(2^32/Q)
__attribute__(( always_inline )) static inline int bred_32x2(int A, int B, int Q, int QI)				
{
  int C, scratch;						\
  __asm__ volatile ( "smmulr	%0, %2, %4\n\t"			\
		     "mla	%0, %0, %5, %2\n\t"		\
		     "smmulr	%1, %3, %4\n\t"			\
		     "mla	%1, %1, %5, %3\n\t"		\
		     "pkhbt	%0, %0, %1, LSL #16"		\
		     : "=&r"((C)), "=&r" (scratch)		\
		     : "r"((A)), "r"((B)), "r"((QI)), "r"((Q))	\
		     );						
  return(C);
}

// both top and bottom of C are reduced
// Q is modulus, QI = round(2^32/Q), not minus
__attribute__(( always_inline )) inline int bround_16x2(int C, int Q, int QII)
{									
  int scratch1;							\
  __asm__ volatile ( "smlawt	%1, %2, %0, %4\n\t"			\
		     "smultb	%1, %1, %3 \n\t"			\
		     "smlawb	%0, %2, %0, %4\n\t"			\
		     "smultb	%0, %0, %3 \n\t"			\
		     "pkhbt	%0, %0, %1, LSL #16"				\
		     : "+r"((C)), "=&r" (scratch1)			\
		     : "r"((QII)), "r"((Q)), "r"(32768)			\
		     );
  return(C);
}

// both top and bottom of C are reduced AND SWAPPED
// Q is modulus, QI = -round(2^32/Q)
__attribute__(( always_inline )) static inline int bred_16x2_rev(int C, int Q, int QI)
{								
    int scr0, scr1;						\
  __asm__ volatile ( "smlawt	%1, %3, %0, %5\n\t"		\
		     "smultb	%1, %1, %4 \n\t"		\
		     "add	%2, %1, %0, ASR #16\n\t"	\
		     "smlawb	%1, %3, %0, %5\n\t"		\
		     "smlatb	%1, %1, %4, %0\n\t"		\
		     "pkhbt	%0, %2, %1, LSL #16"		\
		     : "+r"((C)), "=&r" (scr0), "=&r" (scr1)	\
		     : "r"((QI)), "r"((Q)), "r"(32768)		\
		     );
  return(C);
}
__attribute__(( always_inline )) inline int bred_2xmuladd(int A, int B, int C, int Q, int QI)
{
  int t,result;							\
  __asm__ volatile ( "smlad	%1, %4, %3, %2\n\t"		\
		     "smmulr	%0, %1, %5 \n\t"		\
		     "mla	%0, %0, %6, %1\n\t"	\
		     : "=&r" (result), "=&r" (t)                \
		     : "r"((A)), "r"((B)), "r"((C)), "r"((QI)), "r"((Q))		\
		     );						
  return(result);
}

__attribute__(( always_inline )) inline int bred_2xmuladdx(int A, int B, int C, int Q, int QI)
{
  int t,result;							\
  __asm__ volatile ( "smladx	%1, %4, %3, %2\n\t"		\
		     "smmulr	%0, %1, %5 \n\t"		\
		     "mla	%0, %0, %6, %1\n\t"	\
		     : "=&r" (result), "=&r" (t)                \
		     : "r"((A)), "r"((B)), "r"((C)), "r"((QI)), "r"((Q))		\
		     );						
  return(result);
}

__attribute__(( always_inline )) inline int bred_4xmuladd(int A, int B, int C, int D, int E, int Q, int QI)
{
  int t,result;							\
  __asm__ volatile ( "smlad	%1, %4, %3, %2\n\t"		\
                     "smlad     %1, %5, %6, %1\n\t"             \
		     "smmulr	%0, %1, %7 \n\t"		\
		     "mla	%0, %0, %8, %1\n\t"	\
		     : "=&r" (result), "=&r" (t)                \
		     : "r"((A)), "r"((B)), "r"((C)), "r"((D)), "r"((E)), "r"((QI)), "r"((Q))		\
		     );						
  return(result);
}

__attribute__(( always_inline )) inline int bred_4xmuladdx(int A, int B, int C, int D, int E, int Q, int QI)
{
  int t,result;							\
  __asm__ volatile ( "smladx	%1, %4, %3, %2\n\t"		\
                     "smladx    %1, %5, %6, %1\n\t"             \
		     "smmulr	%0, %1, %7 \n\t"		\
		     "mla	%0, %0, %8, %1\n\t"	\
		     : "=&r" (result), "=&r" (t)                \
		     : "r"((A)), "r"((B)), "r"((C)), "r"((D)), "r"((E)), "r"((QI)), "r"((Q))		\
		     );						
  return(result);
}
#endif
