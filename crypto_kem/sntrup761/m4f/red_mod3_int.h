#ifndef __red_ub3_int
#define __red_ub3_int

// return the unsigned bytes mod3 reduction of A+B
__attribute__(( always_inline )) static inline int add_ub3(int A, int B) { 
  int result, scratch;								
  __asm__ volatile ("uadd8 %0, %2, %3 \n\t"	/* A+B            */	\
		    "usub8 %1, %0, %4 \n\t"	/* A+B-3          */    \
		    "sel %0, %1, %0"		/* sel(A+B-3,A+B) */	\
		    : "=&r"(result), "=r"(scratch)			\
		    : "r"(A), "r"(B), "r"(0x03030303)			\
		    );
  return(result);
  }

__attribute__(( always_inline )) static inline int sub_ub3(int A, int B) { 
  int result, scratch;								
  __asm__ volatile ("usub8 %1, %4, %3 \n\t"     /* 3-B            */    \
		    "uadd8 %0, %1, %2 \n\t"	/* A-B+3          */	\
		    "usub8 %1, %0, %4 \n\t"	/* A-B            */    \
		    "sel %0, %1, %0"		/* sel(A-B,A-B+3) */	\
		    : "=&r"(result), "=r"(scratch)			\
		    : "r"(A), "r"(B), "r"(0x03030303)			\
		    );
  return(result);
  }

// return the unsigned bytes mod3 reduction of A, range up to 5
__attribute__(( always_inline )) static inline int red_ub3_5(int A) { 
  int result;								
  __asm__ volatile ("usub8 %0, %1, %2 \n\t"	/* A-3            */	\
		    "sel %0, %0, %1"		/* pick A-3 if +  */	\
		    : "=&r"(result)					\
		    : "r"(A), "r"(0x03030303)				\
		    );
  return(result);
  }

// return unsigned bytes mod3 reduction of A, up to 14, B up to 5
__attribute__(( always_inline )) static inline int red_ub3_14(int A) { 
  int result;								
  __asm__ volatile ("and %0, %1, %2\n\t"	/* A mod 4        */	\
		    "bic %1, %1, %2\n\t"	/* A and 0xfc     */	\
		    "add %0, %1, %1, LSR #2\n\t"/* B=A%4+A//4     */	\
		    "usub8 %0, %1, %2 \n\t"	/* B-3            */	\
		    "sel %0, %0, %1"		/* pick B-3 if +  */	\
		    : "=&r"(result), "+r"(A)				\
		    : "r"(0x03030303)					\
		    );
  return(result);
  }


// return unsigned bytes mod3 reduction of A, A up to 47, B up to 11
__attribute__(( always_inline )) static inline int red_ub3_47(int A) { 
  int result;								
  __asm__ volatile ("and %0, %1, %2\n\t"	/* A mod 4    */        \
		    "bic %1, %1, %2\n\t"	/* A and 0xfc */	\
		    "add %1, %1, %1, LSR #2\n\t"/* B=A%4+A//4 */	\
		    "and %0, %1, %2\n\t"	/* B mod 4    */        \
		    "bic %1, %1, %2\n\t"	/* B and 0xfc */	\
		    "add %0, %1, %1, LSR #2\n\t"/* B%4 + B//4 */	\
		    "usub8 %0, %1, %2 \n\t"	/* C-3        */	\
		    "sel %0, %0, %1"		/* sel(C-3,C) */	\
		    : "=&r"(result), "+r"(A)				\
		    : "r"(0x03030303)					\
		    );
  return(result);
  }

// return unsigned bytes mod3 reduction of A, B up to 30
#ifdef thumb2
__attribute__(( always_inline )) static inline int red_ub3_255(int A) { 
  int result;								
  __asm__ volatile ("and %0, %1, 0x0F0F0F0F\n\t"/* A %   16     */      \
		    "bic %1, %1, 0x0F0F0F0F\n\t"/* A // 16      */	\
		    "add %1, %1, %1, LSR #4\n\t"/* B=A%16+A//16 */	\
		    "and %0, %1, %2\n\t"	/* B mod 4      */	\
		    "bic %1, %1, %2\n\t"	/* B and 0xfc   */	\
		    "add %1, %1, %1, LSR #2\n\t"/* C=A%4+A//4   */	\
		    "and %0, %1, %2\n\t"	/* C mod 4      */	\
		    "bic %1, %1, %2\n\t"	/* C and 0xfc   */	\
		    "add %0, %1, %1, LSR #2\n\t"/* D=C%4+C//4   */	\
		    "usub8 %0, %1, %2 \n\t"	/* D-3          */	\
		    "sel %0, %0, %1"		/* sel(D-3,D)   */	\
		    : "=&r"(result), "+r"(A)				\
		    : "r"(0x03030303)					\
		    );
  return(result);
}
#define red_ub3_179(A) red_ub3_255(A)
#else // can't use the constant 0x0f0f0f0f, B up to 66, C to 18
__attribute__(( always_inline )) static inline int red_ub3_255(int B) { 
  int result;								
  __asm__ volatile ("and %0, %1, %2\n\t"	/* A mod 4    */        \
		    "bic %1, %1, %2\n\t"	/* A and 0xfc */	\
		    "add %1, %1, %1, LSR #2\n\t"/* B=A%4+A//4 */	\
		    "and %0, %1, %2\n\t"	/* B mod 4    */        \
		    "bic %1, %1, %2\n\t"	/* B and 0xfc */	\
		    "add %1, %1, %1, LSR #2\n\t"/* C=B%4+B//4 */	\
		    "and %0, %1, %2\n\t"	/* C mod 4    */        \
		    "bic %1, %1, %2\n\t"	/* C and 0xfc */	\
		    "add %1, %1, %1, LSR #2\n\t"/* D=C%4+C//4 */	\
		    "and %0, %1, %2\n\t"	/* D mod 4    */        \
		    "bic %1, %1, %2\n\t"	/* D and 0xfc */	\
		    "add %0, %1, %1, LSR #2\n\t"/* E=D%4+D//4 */	\
		    "usub8 %0, %1, %2 \n\t"	/* E-3        */	\
		    "sel %0, %0, %1"		/* sel(E-3,E) */	\
		    : "=&r"(result), "+r"(B)				\
		    : "r"(0x03030303)					\
		    );
  return(result);
}
// can't use the constant 0x0f0f0f0f, C to 47
__attribute__(( always_inline )) static inline int red_ub3_179(int B) { 
  int result;								
  __asm__ volatile ("and %0, %1, %2\n\t"	/* B mod 4    */        \
		    "bic %1, %1, %2\n\t"	/* B and 0xfc */	\
		    "add %1, %1, %1, LSR #2\n\t"/* C=B%4+B//4 */	\
		    "and %0, %1, %2\n\t"	/* C mod 4    */        \
		    "bic %1, %1, %2\n\t"	/* C and 0xfc */	\
		    "add %1, %1, %1, LSR #2\n\t"/* D=C%4+C//4 */	\
		    "and %0, %1, %2\n\t"	/* D mod 4    */        \
		    "bic %1, %1, %2\n\t"	/* D and 0xfc */	\
		    "add %0, %1, %1, LSR #2\n\t"/* E=D%4+D//4 */	\
		    "usub8 %0, %1, %2 \n\t"	/* E-3        */	\
		    "sel %0, %0, %1"		/* sel(E-3,E) */	\
		    : "=&r"(result), "+r"(B)				\
		    : "r"(0x03030303)					\
		    );
  return(result);
}
#endif

#endif
