/**************************************************************************//**
 * @file     core_cmSimd.h
 * @brief    CMSIS Cortex-M SIMD Header File
 * @version  V4.10
 * @date     18. March 2015
 *
 * @note
 *
 ******************************************************************************/
/* Copyright (c) 2009 - 2014 ARM LIMITED

   All rights reserved.
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:
   - Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
   - Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in the
     documentation and/or other materials provided with the distribution.
   - Neither the name of ARM nor the names of its contributors may be used
     to endorse or promote products derived from this software without
     specific prior written permission.
   *
   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
   ARE DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDERS AND CONTRIBUTORS BE
   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
   POSSIBILITY OF SUCH DAMAGE.
   ---------------------------------------------------------------------------*/

#include <stdint.h>
#define __STATIC_INLINE static inline
#define __ASM __asm__

#ifndef __CORE_CMSIMD_H
#define __CORE_CMSIMD_H

#ifdef __cplusplus
 extern "C" {
#endif

#define ARM_VEC16

#ifndef ARM_VEC16   

   
#define __PKHBT(ARG1,ARG2,ARG3)          ( ((((uint32_t)(ARG1))          ) & 0x0000FFFFUL) |  \
                                           ((((uint32_t)(ARG2)) << (ARG3)) & 0xFFFF0000UL)  )

#define __PKHTB(ARG1,ARG2,ARG3)          ( ((((uint32_t)(ARG1))          ) & 0xFFFF0000UL) |  \
                                           ((((uint32_t)(ARG2)) >> (ARG3)) & 0x0000FFFFUL)  )

static inline int32_t __SADD16(int32_t x, int32_t y) {
  return(((x & 0xffff0000) + (y & 0xffff0000))
	 | (uint32_t)(uint16_t)((int16_t) x + (int16_t) y));
}
static inline int32_t __SSUB16(int32_t x, int32_t y) {
  return(((x & 0xffff0000) - (y & 0xffff0000))
	 | (uint32_t)(uint16_t)((int16_t) x - (int16_t) y));
}

static inline int32_t __SMULBB(int32_t x, int32_t y) {
  return((int32_t)((int16_t) x) * (int32_t)((int16_t) y));
}
static inline int32_t __SMULBT(int32_t x, int32_t y) {
  return((int32_t)((int16_t) x) * (y >> 16));
}
static inline int32_t __SMULTB(int32_t x, int32_t y) {
  return((x >> 16) * (int32_t)((int16_t) y));
}
static inline int32_t __SMULTT(int32_t x, int32_t y) {
  return((x >> 16)* (y >> 16));
}

static inline int32_t __SMULWB(int32_t x, int32_t y) {
  return(((int64_t)x * (int64_t)(int16_t)y) >> 16);
}
static inline int32_t __SMULWT(int32_t x, int32_t y) {
  return(((int64_t)x * (int64_t)(y >> 16)) >> 16);
}
   
static inline int32_t __SMUAD(int32_t x, int32_t y) {
  return((int32_t)((int16_t) x) * (int32_t)((int16_t) y)
	 + (x >> 16)* (y >> 16));
}
static inline int32_t __SMUADX(int32_t x, int32_t y) {
  return((int32_t)((int16_t) x) * (y >> 16)
	 +(x >> 16) * (int32_t)((int16_t) y));
}
static inline int32_t __SMUSD(int32_t x, int32_t y) {
  return((int32_t)((int16_t) x) * (int32_t)((int16_t) y)
	 - (x >> 16)* (y >> 16));
}
static inline int32_t __SMUSDX(int32_t x, int32_t y) {
  return((int32_t)((int16_t) x) * (y >> 16)
	 -(x >> 16) * (int32_t)((int16_t) y));
}

static inline int32_t __SMLABB(int32_t x, int32_t y, int32_t z) {
  return((int32_t)((int16_t) x) * (int32_t)((int16_t) y) + z);
}
static inline int32_t __SMLABT(int32_t x, int32_t y, int32_t z) {
  return((int32_t)((int16_t) x) * (y >> 16) + z);
}
static inline int32_t __SMLATB(int32_t x, int32_t y, int32_t z) {
  return((x >> 16) * (int32_t)((int16_t) y) + z);
}
static inline int32_t __SMLATT(int32_t x, int32_t y, int32_t z) {
  return((x >> 16)* (y >> 16) + z);
}

static inline int32_t __SMLAWB(int32_t x, int32_t y, int32_t z) {
  return((((int64_t)x * (int64_t)(int16_t)y) >> 16) + z);
}
static inline int32_t __SMLAWT(int32_t x, int32_t y, int32_t z) {
  return((((int64_t)x * (int64_t)(y >> 16)) >> 16) + z);
}

 
static inline int32_t __SMLAD(int32_t x, int32_t y, int32_t z) {
  return((int32_t)((int16_t) x) * (int32_t)((int16_t) y)
	 + (x >> 16)* (y >> 16) + z);
}
static inline int32_t __SMLADX(int32_t x, int32_t y, int32_t z) {
  return((int32_t)((int16_t) x) * (y >> 16)
	 +(x >> 16) * (int32_t)((int16_t) y) + z);
}
static inline int32_t __SMLSD(int32_t x, int32_t y, int32_t z) {
  return((int32_t)((int16_t) x) * (int32_t)((int16_t) y)
	 - (x >> 16)* (y >> 16) + z);
}
static inline int32_t __SMLSDX(int32_t x, int32_t y, int32_t z) {
  return((int32_t)((int16_t) x) * (y >> 16)
	 -(x >> 16) * (int32_t)((int16_t) y) + z);
}


#define __SADD8                           __sadd8
#define __QADD8                           __qadd8
#define __SHADD8                          __shadd8
#define __UADD8                           __uadd8
#define __UQADD8                          __uqadd8
#define __UHADD8                          __uhadd8
#define __SSUB8                           __ssub8
#define __QSUB8                           __qsub8
#define __SHSUB8                          __shsub8
#define __USUB8                           __usub8
#define __UQSUB8                          __uqsub8
#define __UHSUB8                          __uhsub8
#define __QADD16                          __qadd16
#define __SHADD16                         __shadd16
#define __UADD16                          __uadd16
#define __UQADD16                         __uqadd16
#define __UHADD16                         __uhadd16
#define __QSUB16                          __qsub16
#define __SHSUB16                         __shsub16
#define __USUB16                          __usub16
#define __UQSUB16                         __uqsub16
#define __UHSUB16                         __uhsub16
#define __SASX                            __sasx
#define __QASX                            __qasx
#define __SHASX                           __shasx
#define __UASX                            __uasx
#define __UQASX                           __uqasx
#define __UHASX                           __uhasx
#define __SSAX                            __ssax
#define __QSAX                            __qsax
#define __SHSAX                           __shsax
#define __USAX                            __usax
#define __UQSAX                           __uqsax
#define __UHSAX                           __uhsax
#define __USAD8                           __usad8
#define __USADA8                          __usada8
#define __SSAT16                          __ssat16
#define __USAT16                          __usat16
#define __UXTB16                          __uxtb16
#define __UXTAB16                         __uxtab16
#define __SXTB16                          __sxtb16
#define __SXTAB16                         __sxtab16
#define __SMLALD                          __smlald
#define __SMLALDX                         __smlaldx
#define __SMLSLD                          __smlsld
#define __SMLSLDX                         __smlsldx
#define __SEL                             __sel
#define __QADD                            __qadd
#define __QSUB                            __qsub
 

#else   
/* GNU gcc specific functions */
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SADD8(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("sadd8 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __QADD8(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("qadd8 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SHADD8(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("shadd8 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UADD8(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uadd8 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UQADD8(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uqadd8 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UHADD8(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uhadd8 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}


__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SSUB8(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("ssub8 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __QSUB8(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("qsub8 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SHSUB8(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("shsub8 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __USUB8(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("usub8 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UQSUB8(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uqsub8 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UHSUB8(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uhsub8 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}


__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SADD16(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("sadd16 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) : "cc" );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __QADD16(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("qadd16 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SHADD16(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("shadd16 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UADD16(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uadd16 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UQADD16(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uqadd16 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UHADD16(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uhadd16 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SSUB16(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("ssub16 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) : "cc" );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __QSUB16(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("qsub16 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SHSUB16(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("shsub16 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __USUB16(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("usub16 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UQSUB16(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uqsub16 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UHSUB16(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uhsub16 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SASX(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("sasx %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __QASX(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("qasx %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SHASX(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("shasx %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UASX(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uasx %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UQASX(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uqasx %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UHASX(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uhasx %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SSAX(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("ssax %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __QSAX(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("qsax %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SHSAX(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("shsax %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __USAX(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("usax %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UQSAX(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uqsax %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UHSAX(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("uhsax %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __USAD8(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("usad8 %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __USADA8(uint32_t op1, uint32_t op2, uint32_t op3)
{
  uint32_t result;

  __ASM volatile ("usada8 %0, %1, %2, %3" : "=r" (result) : "r" (op1), "r" (op2), "r" (op3) );
  return(result);
}

#define __SSAT16(ARG1,ARG2) \
({                          \
  uint32_t __RES, __ARG1 = (ARG1); \
  __ASM ("ssat16 %0, %1, %2" : "=r" (__RES) :  "I" (ARG2), "r" (__ARG1) ); \
  __RES; \
 })

#define __USAT16(ARG1,ARG2) \
({                          \
  uint32_t __RES, __ARG1 = (ARG1); \
  __ASM ("usat16 %0, %1, %2" : "=r" (__RES) :  "I" (ARG2), "r" (__ARG1) ); \
  __RES; \
 })

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UXTB16(uint32_t op1, int op2)
{
  uint32_t result;

  __ASM volatile ("uxtb16 %0, %1, ror %2" : "=r" (result) : "r"(op1), "I"(op2));
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UXTAB16(uint32_t op1, uint32_t op2, int op3)
{
  uint32_t result;

  __ASM volatile ("uxtab16 %0, %1, %2, ror %3" : "=r" (result) : "r" (op1), "r" (op2), "I" (op3) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SXTB16(uint32_t op1, int op2)
{
  uint32_t result;

  __ASM volatile ("sxtb16 %0, %1, ror %2" : "=r" (result) : "r"(op1), "I"(op2));
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SXTAB16(uint32_t op1, uint32_t op2, int op3)
{
  uint32_t result;

  __ASM volatile ("sxtab16 %0, %1, %2, ror %3" : "=r" (result) : "r" (op1), "r" (op2), "I"(op3) );
  return(result);
}


__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UXTB(uint32_t op1, int op2)
{
  uint32_t result;

  __ASM volatile ("uxtb %0, %1, ror %2" : "=r" (result) : "r"(op1), "I"(op2));
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UXTAB(uint32_t op1, uint32_t op2, int op3)
{
  uint32_t result;

  __ASM volatile ("uxtab16 %0, %1, %2, ror %3" : "=r" (result) : "r" (op1), "r" (op2), "I" (op3) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SXTB(uint32_t op1, int op2)
{
  uint32_t result;

  __ASM volatile ("sxtb %0, %1, ror %2" : "=r" (result) : "r"(op1), "I"(op2));
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SXTAB(uint32_t op1, uint32_t op2, int op3)
{
  uint32_t result;


  
  __ASM volatile ("sxtab %0, %1, %2, ror %3" : "=r" (result) : "r" (op1), "r" (op2), "I"(op3) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UXTH(uint32_t op1, int op2)
{
  uint32_t result;

  __ASM volatile ("uxth %0, %1, ror %2" : "=r" (result) : "r"(op1), "I"(op2));
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __UXTAH(uint32_t op1, uint32_t op2, int op3)
{
  uint32_t result;

  __ASM volatile ("uxtah %0, %1, %2, ror %3" : "=r" (result) : "r" (op1), "r" (op2), "I" (op3) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SXTH(uint32_t op1, int op2)
{
  uint32_t result;

  __ASM volatile ("sxth %0, %1, ror %2" : "=r" (result) : "r"(op1), "I"(op2));
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SXTAH(uint32_t op1, uint32_t op2, int op3)
{
  uint32_t result;

  __ASM volatile ("sxtah %0, %1, %2, ror %3" : "=r" (result) : "r" (op1), "r" (op2), "I"(op3) );
  return(result);
}



__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMUAD  (uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("smuad %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMUADX (uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("smuadx %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMLAD (uint32_t op1, uint32_t op2, uint32_t op3)
{
  uint32_t result;

  __ASM volatile ("smlad %0, %1, %2, %3" : "=r" (result) : "r" (op1), "r" (op2), "r" (op3) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMLADX (uint32_t op1, uint32_t op2, uint32_t op3)
{
  uint32_t result;

  __ASM volatile ("smladx %0, %1, %2, %3" : "=r" (result) : "r" (op1), "r" (op2), "r" (op3) : "cc" );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE int32_t sxt19(uint32_t X) {
  int32_t Y;
  __ASM volatile ("sbfx %0, %1, #0, #19" : "=r" (Y) : "r" (X) : "cc");
  return (Y);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE int32_t sxt6(uint32_t X) {
  int32_t Y;
  __ASM volatile ("sbfx %0, %1, #0, #6" : "=r" (Y) : "r" (X) : "cc");
  return (Y);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint64_t __SMULL (uint32_t op1, uint32_t op2)
{
  union llreg_u{
    uint32_t w32[2];
    uint64_t w64;
  } llr;

#ifndef __ARMEB__   // Little endian
  __ASM volatile ("smull %0, %1, %2, %3" : "=r" (llr.w32[0]), "=r" (llr.w32[1]): "r" (op1), "r" (op2) , "0" (llr.w32[0]), "1" (llr.w32[1]) : "cc");
#else               // Big endian
  __ASM volatile ("smull %0, %1, %2, %3" : "=r" (llr.w32[1]), "=r" (llr.w32[0]): "r" (op1), "r" (op2) , "0" (llr.w32[1]), "1" (llr.w32[0]) : "cc");
#endif

  return(llr.w64);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint64_t __UMULL (uint32_t op1, uint32_t op2)
{
  union llreg_u{
    uint32_t w32[2];
    uint64_t w64;
  } llr;
  llr.w64=0;
#ifndef __ARMEB__   // Little endian
  __ASM volatile ("umull %0, %1, %2, %3" : "=r" (llr.w32[0]), "=r" (llr.w32[1]): "r" (op1), "r" (op2) , "0" (llr.w32[0]), "1" (llr.w32[1]) : "cc");
#else               // Big endian
  __ASM volatile ("umull %0, %1, %2, %3" : "=r" (llr.w32[1]), "=r" (llr.w32[0]): "r" (op1), "r" (op2) , "0" (llr.w32[1]), "1" (llr.w32[0]) : "cc");
#endif

  return(llr.w64);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint64_t __SMLAL (uint32_t op1, uint32_t op2, uint64_t acc)
{
  union llreg_u{
    uint32_t w32[2];
    uint64_t w64;
  } llr;
  llr.w64 = acc;

#ifndef __ARMEB__   // Little endian
  __ASM volatile ("smlal %0, %1, %2, %3" : "=r" (llr.w32[0]), "=r" (llr.w32[1]): "r" (op1), "r" (op2) , "0" (llr.w32[0]), "1" (llr.w32[1]) : "cc");
#else               // Big endian
  __ASM volatile ("smlal %0, %1, %2, %3" : "=r" (llr.w32[1]), "=r" (llr.w32[0]): "r" (op1), "r" (op2) , "0" (llr.w32[1]), "1" (llr.w32[0]) : "cc");
#endif

  return(llr.w64);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint64_t __UMLAL (uint32_t op1, uint32_t op2, uint64_t acc)
{
  union llreg_u{
    uint32_t w32[2];
    uint64_t w64;
  } llr;
  llr.w64 = acc;

#ifndef __ARMEB__   // Little endian
  __ASM volatile ("umlal %0, %1, %2, %3" : "=r" (llr.w32[0]), "=r" (llr.w32[1]): "r" (op1), "r" (op2) , "0" (llr.w32[0]), "1" (llr.w32[1]) : "cc");
#else               // Big endian
  __ASM volatile ("umlal %0, %1, %2, %3" : "=r" (llr.w32[1]), "=r" (llr.w32[0]): "r" (op1), "r" (op2) , "0" (llr.w32[1]), "1" (llr.w32[0]) : "cc");
#endif

  return(llr.w64);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint64_t __UMAAL (uint32_t op1, uint32_t op2, uint64_t acc)
{
  union llreg_u{
    uint32_t w32[2];
    uint64_t w64;
  } llr;
  llr.w64 = acc;

#ifndef __ARMEB__   // Little endian
  __ASM volatile ("umaal %0, %1, %2, %3" : "=r" (llr.w32[0]), "=r" (llr.w32[1]): "r" (op1), "r" (op2) , "0" (llr.w32[0]), "1" (llr.w32[1]) : "cc");
#else               // Big endian
  __ASM volatile ("umaal %0, %1, %2, %3" : "=r" (llr.w32[1]), "=r" (llr.w32[0]): "r" (op1), "r" (op2) , "0" (llr.w32[1]), "1" (llr.w32[0]) : "cc");
#endif

  return(llr.w64);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint64_t __SMLALD (uint32_t op1, uint32_t op2, uint64_t acc)
{
  union llreg_u{
    uint32_t w32[2];
    uint64_t w64;
  } llr;
  llr.w64 = acc;

#ifndef __ARMEB__   // Little endian
  __ASM volatile ("smlald %0, %1, %2, %3" : "=r" (llr.w32[0]), "=r" (llr.w32[1]): "r" (op1), "r" (op2) , "0" (llr.w32[0]), "1" (llr.w32[1]) );
#else               // Big endian
  __ASM volatile ("smlald %0, %1, %2, %3" : "=r" (llr.w32[1]), "=r" (llr.w32[0]): "r" (op1), "r" (op2) , "0" (llr.w32[1]), "1" (llr.w32[0]) );
#endif

  return(llr.w64);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint64_t __SMLALDX (uint32_t op1, uint32_t op2, uint64_t acc)
{
  union llreg_u{
    uint32_t w32[2];
    uint64_t w64;
  } llr;
  llr.w64 = acc;

#ifndef __ARMEB__   // Little endian
  __ASM volatile ("smlaldx %0, %1, %2, %3" : "=r" (llr.w32[0]), "=r" (llr.w32[1]): "r" (op1), "r" (op2) , "0" (llr.w32[0]), "1" (llr.w32[1]) );
#else               // Big endian
  __ASM volatile ("smlaldx %0, %1, %2, %3" : "=r" (llr.w32[1]), "=r" (llr.w32[0]): "r" (op1), "r" (op2) , "0" (llr.w32[1]), "1" (llr.w32[0]) );
#endif

  return(llr.w64);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMUSD  (uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("smusd %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMUSDX (uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("smusdx %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMLSD (uint32_t op1, uint32_t op2, uint32_t op3)
{
  uint32_t result;

  __ASM volatile ("smlsd %0, %1, %2, %3" : "=r" (result) : "r" (op1), "r" (op2), "r" (op3) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMLSDX (uint32_t op1, uint32_t op2, uint32_t op3)
{
  uint32_t result;

  __ASM volatile ("smlsdx %0, %1, %2, %3" : "=r" (result) : "r" (op1), "r" (op2), "r" (op3) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint64_t __SMLSLD (uint32_t op1, uint32_t op2, uint64_t acc)
{
  union llreg_u{
    uint32_t w32[2];
    uint64_t w64;
  } llr;
  llr.w64 = acc;

#ifndef __ARMEB__   // Little endian
  __ASM volatile ("smlsld %0, %1, %2, %3" : "=r" (llr.w32[0]), "=r" (llr.w32[1]): "r" (op1), "r" (op2) , "0" (llr.w32[0]), "1" (llr.w32[1]) );
#else               // Big endian
  __ASM volatile ("smlsld %0, %1, %2, %3" : "=r" (llr.w32[1]), "=r" (llr.w32[0]): "r" (op1), "r" (op2) , "0" (llr.w32[1]), "1" (llr.w32[0]) );
#endif

  return(llr.w64);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint64_t __SMLSLDX (uint32_t op1, uint32_t op2, uint64_t acc)
{
  union llreg_u{
    uint32_t w32[2];
    uint64_t w64;
  } llr;
  llr.w64 = acc;

#ifndef __ARMEB__   // Little endian
  __ASM volatile ("smlsldx %0, %1, %2, %3" : "=r" (llr.w32[0]), "=r" (llr.w32[1]): "r" (op1), "r" (op2) , "0" (llr.w32[0]), "1" (llr.w32[1]) );
#else               // Big endian
  __ASM volatile ("smlsldx %0, %1, %2, %3" : "=r" (llr.w32[1]), "=r" (llr.w32[0]): "r" (op1), "r" (op2) , "0" (llr.w32[1]), "1" (llr.w32[0]) );
#endif

  return(llr.w64);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SEL  (uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("sel %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __QADD(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("qadd %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __QSUB(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("qsub %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMULBB(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("smulbb %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMULBT(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("smulbt %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) : "cc" );
  return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMULTB(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("smultb %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMULTT(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("smultt %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMULWB(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("smulwb %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMULWT(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("smulwt %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMMUL(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("smmul %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) );
  return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMMULR(uint32_t op1, uint32_t op2)
{
  uint32_t result;

  __ASM volatile ("smmulr %0, %1, %2" : "=r" (result) : "r" (op1), "r" (op2) : "cc" );
  return(result);
}



__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMLABB (uint32_t op1, uint32_t op2, uint32_t op3)
{
  uint32_t result;

  __ASM volatile ("smlabb %0, %1, %2, %3" : "=r" (result) : "r" (op1), "r" (op2), "r" (op3) );
  return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMLABT (uint32_t op1, uint32_t op2, uint32_t op3)
{
  uint32_t result;

  __ASM volatile ("smlabt %0, %1, %2, %3" : "=r" (result) : "r" (op1), "r" (op2), "r" (op3) );
  return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMLATB (uint32_t op1, uint32_t op2, uint32_t op3)
{
  uint32_t result;

  __ASM volatile ("smlatb %0, %1, %2, %3" : "=r" (result) : "r" (op1), "r" (op2), "r" (op3) );
  return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMLATT (uint32_t op1, uint32_t op2, uint32_t op3)
{
  uint32_t result;

  __ASM volatile ("smlatt %0, %1, %2, %3" : "=r" (result) : "r" (op1), "r" (op2), "r" (op3) );
  return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMLAWB (uint32_t op1, uint32_t op2, uint32_t op3)
{
  uint32_t result;

  __ASM volatile ("smlawb %0, %1, %2, %3" : "=r" (result) : "r" (op1), "r" (op2), "r" (op3) : "cc" );
  return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMLAWT (uint32_t op1, uint32_t op2, uint32_t op3)
{
  uint32_t result;

  __ASM volatile ("smlawt %0, %1, %2, %3" : "=r" (result) : "r" (op1), "r" (op2), "r" (op3) : "cc" );
  return(result);
}

#define __ARM2I(OP,ARG1,ARG2)				\
  ({							\
    int __RES;						\
    __ASM (#OP " %0, %1, %2"				\
	   : "=r"(__RES) : "r"((ARG1)),"I"((ARG2))	\
	   );						\
    __RES;						\
  })

#define __ARM2IC(OP,ARG1,ARG2)				\
  ({							\
    int __RES;						\
    __ASM (#OP " %0, %1, %2"				\
	   : "=r"(__RES) : "r"((ARG1)),"I"((ARG2))	\
	   : "cc" );					\
    __RES;						\
  })
  

#define __ARM2(OP,ARG1,ARG2)				\
  ({							\
    int __RES;						\
    __ASM (#OP " %0, %1, %2"				\
	   : "=r"(__RES) : "r"((ARG1)),"r"((ARG2))	\
	   );						\
    __RES;						\
  })

#define __ARM2C(OP,ARG1,ARG2)				\
  ({							\
    int __RES;						\
    __ASM (#OP " %0, %1, %2"				\
	   : "=r"(__RES) : "r"((ARG1)),"r"((ARG2))	\
	   : "cc");					\
    __RES;						\
  })

#define __ARM2S(OP,ARG1,ARG2,SHIFT,ARG3)		\
  ({							\
    int __RES;						\
    __ASM (#OP " %0, %1, %2, " #SHIFT " %3"		\
	   : "=r"(__RES)				\
	   : "r"((ARG1)), "r"((ARG2)), "I" ((ARG3))	\
	   );						\
    __RES;						\
  })

#define __ARM2SC(OP,ARG1,ARG2,SHIFT,ARG3)		\
  ({							\
    int __RES;						\
    __ASM (#OP " %0, %1, %2, " #SHIFT " %3"		\
	   : "=r"(__RES)				\
	   : "r"((ARG1)), "r"((ARG2)), "I" ((ARG3))	\
	   : "cc");					\
    __RES;						\
  })



#define __ROR(ARG1,ARG2) \
({                          \
  uint32_t __RES, __ARG1 = (ARG1); \
  __ASM ("ror %0, %1, %2" : "=r" (__RES) :  "r" (__ARG1), "I" (ARG2) : "cc" ); \
  __RES; \
 })

#define __ORR_ROR(ARG1,ARG2,ARG3) \
({                          \
  uint32_t __RES, __ARG1 = (ARG1), __ARG2 = (ARG2); \
  __ASM ("orr %0, %1, %2, ror %3" : "=r" (__RES) :  "r" (__ARG1), "r" (__ARG2), "I" (ARG3) : "cc" ); \
  __RES; \
 })

#define __ORR_LSR(ARG1,ARG2,ARG3) \
({                          \
  uint32_t __RES, __ARG1 = (ARG1), __ARG2 = (ARG2); \
  __ASM ("orr %0, %1, %2, lsr %3" : "=r" (__RES) :  "r" (__ARG1), "r" (__ARG2), "I" (ARG3) : "cc" ); \
  __RES; \
 })

#define __EOR_LSR(ARG1,ARG2,ARG3) \
({                          \
  uint32_t __RES, __ARG1 = (ARG1), __ARG2 = (ARG2); \
  __ASM ("eor %0, %1, %2, lsr %3" : "=r" (__RES) :  "r" (__ARG1), "r" (__ARG2), "I" (ARG3) : "cc" ); \
  __RES; \
 })

#define __SBFX(ARG1,ARG2,ARG3) \
({                          \
  uint32_t __RES, __ARG1 = (ARG1); \
  __ASM ("sbfx %0, %1, %2, %3" : "=r" (__RES) :  "r" (__ARG1), "I" (ARG2), "I" (ARG3) : "cc" ); \
  __RES; \
 })

#define __BFI(ARG0,ARG1,ARG2,ARG3) \
({                          \
  uint32_t __RES, __ARG0 = (ARG0), __ARG1 = (ARG1); \
  __ASM ("bfi %0, %1, %2, %3" : "=r" (__RES) :  "r" (__ARG1), "I" (ARG2), "I" (ARG3), "0" (__ARG0) : "cc" ); \
  __RES; \
 })

#define __BFC(ARG1,ARG2,ARG3)			\
({						    \
  uint32_t __RES, __ARG1 = (ARG1); \
  __ASM ("bfc %0, %1, %2" : "=r" (__RES) :  "I" (ARG2), "I" (ARG3), "0" (__ARG1) : "cc" ); \
  __RES; \
 })

#define __PKHBT(ARG1,ARG2,ARG3) \
({                          \
  uint32_t __RES, __ARG1 = (ARG1), __ARG2 = (ARG2); \
  __ASM ("pkhbt %0, %1, %2, lsl %3" : "=r" (__RES) :  "r" (__ARG1), "r" (__ARG2), "I" (ARG3) : "cc" ); \
  __RES; \
 })

#define __PKHTB(ARG1,ARG2,ARG3) \
({                          \
  uint32_t __RES, __ARG1 = (ARG1), __ARG2 = (ARG2); \
  if (ARG3 == 0) \
    __ASM ("pkhtb %0, %1, %2" : "=r" (__RES) :  "r" (__ARG1), "r" (__ARG2)  ); \
  else \
    __ASM ("pkhtb %0, %1, %2, asr %3" : "=r" (__RES) :  "r" (__ARG1), "r" (__ARG2), "I" (ARG3)  ); \
  __RES; \
 })





__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMMLA (int32_t op1, int32_t op2, int32_t op3)
{
 int32_t result;

 __ASM volatile ("smmla %0, %1, %2, %3" : "=r" (result): "r"  (op1), "r" (op2), "r" (op3) );
 return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMMLS (int32_t op1, int32_t op2, int32_t op3)
{
 int32_t result;

 __ASM volatile ("smmls %0, %1, %2, %3" : "=r" (result): "r"  (op1), "r" (op2), "r" (op3) );
 return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMMLAR (int32_t op1, int32_t op2, int32_t op3)
{
 int32_t result;

 __ASM volatile ("smmlar %0, %1, %2, %3" : "=r" (result): "r"  (op1), "r" (op2), "r" (op3) );
 return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __SMMLSR (int32_t op1, int32_t op2, int32_t op3)
{
 int32_t result;

 __ASM volatile ("smmlsr %0, %1, %2, %3" : "=r" (result): "r"  (op1), "r" (op2), "r" (op3) );
 return(result);
}

__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __MLA (int32_t op1, int32_t op2, int32_t op3)
{
 int32_t result;

 __ASM volatile ("mla %0, %1, %2, %3" : "=r" (result): "r"  (op1), "r" (op2), "r" (op3) );
 return(result);
}
__attribute__( ( always_inline ) ) __STATIC_INLINE uint32_t __MLS (int32_t op1, int32_t op2, int32_t op3)
{
 int32_t result;

 __ASM volatile ("mls %0, %1, %2, %3" : "=r" (result): "r"  (op1), "r" (op2), "r" (op3) : "cc" );
 return(result);
}

#endif
   

#ifdef __cplusplus
}
#endif

#endif /* __CORE_CMSIMD_H */
