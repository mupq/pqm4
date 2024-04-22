/* 
 * Copyright (c) 2023 Junhao Huang (jhhuang_nuaa@126.com)
 *
 * Licensed under the Apache License, Version 2.0(the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * NTT and inverse NTT code from: 
 * Huang, J. et al. 2024. Revisiting Keccak and Dilithium Implementations on ARMv7-M. 
 * IACR Transactions on Cryptographic Hardware and Embedded Systems. 2024, 2 (Mar. 2024), 1–24.
 * DOI:https://doi.org/10.46586/tches.v2024.i2.1-24.
 * https://github.com/UIC-ESLAS/Dilithium-Multi-Moduli/blob/332a32cc02d407020e48a4f9b3a0dc78d4c8b0bc/M4/crypto_sign/dilithium3/m4plant/smallntt_769.S
*/

#ifndef MACROS_SMALLNTT_I
#define MACROS_SMALLNTT_I

// general macros
.macro load a, a0, a1, a2, a3, mem0, mem1, mem2, mem3
  ldr.w \a0, [\a, \mem0]
  ldr.w \a1, [\a, \mem1]
  ldr.w \a2, [\a, \mem2]
  ldr.w \a3, [\a, \mem3]
.endm

.macro store a, a0, a1, a2, a3, mem0, mem1, mem2, mem3
  str.w \a0, [\a, \mem0]
  str.w \a1, [\a, \mem1]
  str.w \a2, [\a, \mem2]
  str.w \a3, [\a, \mem3]
.endm

.macro doubleplant a, tmp, q, qa, plantconst
  smulwb \tmp, \plantconst, \a
  smulwt \a, \plantconst, \a
  smlabt \tmp, \tmp, \q, \qa
  smlabt \a, \a, \q, \qa
  pkhtb \a, \a, \tmp, asr#16
.endm

.macro doublebarrett a, tmp, tmp2, q, barrettconst
  smulbb \tmp, \a, \barrettconst
  smultb \tmp2, \a, \barrettconst
  asr \tmp, \tmp, #26
  asr \tmp2, \tmp2, #26
  smulbb \tmp, \tmp, \q
  smulbb \tmp2, \tmp2, \q
  pkhbt \tmp, \tmp, \tmp2, lsl#16
  usub16 \a, \a, \tmp
.endm

// q locate in the top half of the register
.macro plant_red q, qa, qinv, tmp
  mul \tmp, \tmp, \qinv     
  //tmp*qinv mod 2^2n/ 2^n; in high half
  smlatt \tmp, \tmp, \q, \qa
  // result in high half
.endm

.macro mul_twiddle_plant a, twiddle, tmp, q, qa
	smulwb \tmp, \twiddle, \a
	smulwt \a,   \twiddle, \a
	smlabt \tmp, \tmp, \q, \qa
	smlabt \a, \a, \q, \qa
	pkhtb \a, \a, \tmp, asr#16
.endm

.macro doublebutterfly_plant a0, a1, twiddle, tmp, q, qa
	smulwb \tmp, \twiddle, \a1
	smulwt \a1, \twiddle, \a1
	smlabt \tmp, \tmp, \q, \qa
	smlabt \a1, \a1, \q, \qa
	pkhtb \tmp, \a1, \tmp, asr#16
	usub16 \a1, \a0, \tmp
	uadd16 \a0, \a0, \tmp
.endm

.macro two_doublebutterfly_plant a0, a1, a2, a3, twiddle0, twiddle1, tmp, q, qa
	doublebutterfly_plant \a0, \a1, \twiddle0, \tmp, \q, \qa
	doublebutterfly_plant \a2, \a3, \twiddle1, \tmp, \q, \qa
.endm

#endif