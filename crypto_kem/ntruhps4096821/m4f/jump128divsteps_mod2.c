#include <stdint.h>

extern int jump64divsteps_mod2(int minusdelta, uint32_t *M, uint32_t *f, uint32_t *g);
int jump128divsteps_mod2(int minusdelta, uint32_t *M, uint32_t *f, uint32_t *g);
extern void __gf_polymul_64x64_2x2_x2p2_mod2(uint32_t *V, uint32_t *M, uint32_t  *fh, uint32_t *gh);
extern void __gf_polymul_64x64_2x2_x_2x2_mod2(uint32_t *M, uint32_t *M1, uint32_t *M2);

int jump128divsteps_mod2(int minusdelta, uint32_t *M, uint32_t *f, uint32_t *g){
  uint32_t M1[48], M2[48], fg[32];

  minusdelta = jump64divsteps_mod2(minusdelta, M1, f, g);
  __gf_polymul_64x64_2x2_x2p2_mod2(fg, M1, f+8, g+8);
  minusdelta = jump64divsteps_mod2(minusdelta, M2, fg, fg+16);
  // __gf_polymul_64x64_2x2_x2p2_mod2(M, M2, fg+8, fg+24);
  __gf_polymul_64x64_2x2_x_2x2_mod2(M+32, M1+16, M2+16);
  return minusdelta;
}
