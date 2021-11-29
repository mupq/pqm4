#include <inttypes.h>

extern int jump64divsteps_mod2(int minusdelta, uint32_t *M1, uint32_t *f, uint32_t *g);
int jump1376divsteps_mod2_64(int minusdelta, uint32_t *M, uint32_t *f, uint32_t *g);

extern void __update_fg_64x688_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_VS_64x64_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x128_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x192_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x256_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x320_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x384_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x448_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x512_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x576_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x640_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x688_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_fg_64x672_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x608_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x544_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x480_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x416_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x352_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x288_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x224_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x160_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x96_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern int jump32divsteps_mod2(int minusdelta, uint32_t *M1, uint32_t *f, uint32_t *g);
extern void __update_fg_32x32_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_VS_32x704_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);

int jump1376divsteps_mod2_64(int minusdelta, uint32_t *M, uint32_t *f, uint32_t *g){
	uint32_t V[88]={0};
	uint32_t S[88]={0};
	uint32_t M1[48]; // 64 coefficients * 6
	uint32_t *ptr = M;
	*(S) = 1;
	// 1: 10
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x688_mod2(f, g, M1+16);
	__update_VS_64x64_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x688_mod2(f, g, M1+16);
	__update_VS_64x64_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x688_mod2(f, g, M1+16);
	__update_VS_64x128_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x688_mod2(f, g, M1+16);
	__update_VS_64x192_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x688_mod2(f, g, M1+16);
	__update_VS_64x256_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x688_mod2(f, g, M1+16);
	__update_VS_64x320_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x688_mod2(f, g, M1+16);
	__update_VS_64x384_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x688_mod2(f, g, M1+16);
	__update_VS_64x448_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x688_mod2(f, g, M1+16);
	__update_VS_64x512_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x688_mod2(f, g, M1+16);
	__update_VS_64x576_mod2(V, S, M1+16);
	// 2
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x688_mod2(f, g, M1+16);
	__update_VS_64x640_mod2(V, S, M1+16);
	// 3
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x672_mod2(f, g, M1+16);
	__update_VS_64x688_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x608_mod2(f, g, M1+16);
	__update_VS_64x688_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x544_mod2(f, g, M1+16);
	__update_VS_64x688_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x480_mod2(f, g, M1+16);
	__update_VS_64x688_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x416_mod2(f, g, M1+16);
	__update_VS_64x688_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x352_mod2(f, g, M1+16);
	__update_VS_64x688_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x288_mod2(f, g, M1+16);
	__update_VS_64x688_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x224_mod2(f, g, M1+16);
	__update_VS_64x688_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x160_mod2(f, g, M1+16);
	__update_VS_64x688_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x96_mod2(f, g, M1+16);
	__update_VS_64x688_mod2(V, S, M1+16);
	// 4
	minusdelta = jump32divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_32x32_mod2(f, g, M1+8);
	__update_VS_32x704_mod2(V, S, M1+8);
	
	for (int i = 0; i < 88; i++)
	{
	    *ptr++ = V[i];
	}
	return minusdelta;
}
