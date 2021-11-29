#include <inttypes.h>

extern int jump64divsteps_mod2(int minusdelta, uint32_t *M1, uint32_t *f, uint32_t *g);
int jump1024divsteps_mod2_64(int minusdelta, uint32_t *M, uint32_t *f, uint32_t *g);

extern void __update_fg_64x512_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_VS_64x64_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x128_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x192_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x256_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x320_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x384_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x448_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x512_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_VS_64x544_mod2(uint32_t *V, uint32_t *S, uint32_t *M1);
extern void __update_fg_64x448_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x384_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x320_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x256_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x192_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x128_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);
extern void __update_fg_64x64_mod2(uint32_t *f, uint32_t *g, uint32_t *M1);

int jump1024divsteps_mod2_64(int minusdelta, uint32_t *M, uint32_t *f, uint32_t *g){
	uint32_t V[68]={0};
	uint32_t S[68]={0};
	uint32_t M1[48]; // 64 coefficients * 6
	uint32_t *ptr = M;
	*(S) = 1;
	// 1: 8
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x512_mod2(f, g, M1+16);
	__update_VS_64x64_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x512_mod2(f, g, M1+16);
	__update_VS_64x64_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x512_mod2(f, g, M1+16);
	__update_VS_64x128_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x512_mod2(f, g, M1+16);
	__update_VS_64x192_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x512_mod2(f, g, M1+16);
	__update_VS_64x256_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x512_mod2(f, g, M1+16);
	__update_VS_64x320_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x512_mod2(f, g, M1+16);
	__update_VS_64x384_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x512_mod2(f, g, M1+16);
	__update_VS_64x448_mod2(V, S, M1+16);
	// 2
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x512_mod2(f, g, M1+16);
	__update_VS_64x512_mod2(V, S, M1+16);
	// 3
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x448_mod2(f, g, M1+16);
	__update_VS_64x512_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x384_mod2(f, g, M1+16);
	__update_VS_64x512_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x320_mod2(f, g, M1+16);
	__update_VS_64x512_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x256_mod2(f, g, M1+16);
	__update_VS_64x512_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x192_mod2(f, g, M1+16);
	__update_VS_64x512_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x128_mod2(f, g, M1+16);
	__update_VS_64x512_mod2(V, S, M1+16);
	minusdelta = jump64divsteps_mod2(minusdelta,M1,f,g);
	__update_fg_64x64_mod2(f, g, M1+16);
	__update_VS_64x544_mod2(V, S, M1+16);
	
	for (int i = 0; i < 68; i++)
	{
	    *ptr++ = V[i];
	}
	return minusdelta;
}
