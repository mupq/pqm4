#define int32_MINMAX(a,b) \
do { \
  int32 temp1; \
  asm( \
    "cmp %0,%1\n\t" \
    "mov %2,%0\n\t" \
    "itt gt\n\t" \
    "movgt %0,%1\n\t" \
    "movgt %1,%2\n\t" \
    : "+r"(a), "+r"(b), "=r"(temp1) \
    : \
    : "cc" \
  ); \
} while(0)
