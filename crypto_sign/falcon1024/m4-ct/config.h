/*
 * Manual configuration file for the Falcon implementation. Here can
 * be set some compilation-time options.
 *
 * ==========================(LICENSE BEGIN)============================
 *
 * Copyright (c) 2017-2019  Falcon Project
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ===========================(LICENSE END)=============================
 *
 * @author   Thomas Pornin <thomas.pornin@nccgroup.com>
 */

#ifndef FALCON_CONFIG_H__
#define FALCON_CONFIG_H__

/*
 * Each option is a macro which should be defined to either 1 or 0.
 * If any of the options below is left undefined, then a default value
 * will be used by the code, possibly using compile-time autodetection
 * from compiler-defined macros.
 *
 * Explicitly setting a parameter can be done by uncommenting/modifying
 * its definition below, in this file, or equivalently by setting it as
 * a compiler flag.
 */

/*
 * Use the native 'double' C type for floating-point computations. Exact
 * reproducibility of all tests requires that type to faithfully follow
 * IEEE-754 "round-to-nearest" rules.
 *
 * Native double support will use the CPU hardware and/or
 * compiler-provided functions; the latter is typically NOT
 * constant-time, while the former MAY be constant-time, or not. On
 * recent x86 CPU in 64-bit mode, SSE2 opcodes are used and they provide
 * constant-time operations for all the operations used in Falcon,
 * except for some special cases of divisions and square roots, but it
 * can be shown that theses cases imply only negligible leak of
 * information that cannot be leveraged into a full attack.
 *
 * If neither FALCON_FPNATIVE nor FALCON_FPEMU is defined, then use of
 * the native 'double' C type is the default behaviour unless
 * FALCON_ASM_CORTEXM4 is defined to 1, in which case the emulated code
 * will be used.
 *
#define FALCON_FPNATIVE   1
 */

/*
 * Use emulated floating-point implementation.
 *
 * Emulation uses only integer operations with uint32_t and uint64_t
 * types. This is constant-time, provided that the underlying platform
 * offers constant-time opcodes for the following operations:
 *
 *  - Multiplication of two 32-bit unsigned integers into a 64-bit result.
 *  - Left-shift or right-shift of a 32-bit unsigned integer by a
 *    potentially secret shift count in the 0..31 range.
 *
 * Notably, the ARM Cortex M3 does not fulfill the first condition,
 * while the Pentium IV does not fulfill the second.
 *
 * If neither FALCON_FPNATIVE nor FALCON_FPEMU is defined, then use of
 * the native 'double' C type is the default behaviour unless
 * FALCON_ASM_CORTEXM4 is defined to 1, in which case the emulated code
 * will be used.
 *
#define FALCON_FPEMU   1
 */

#define FALCON_FPEMU   1

/*
 * Enable use of assembly for ARM Cortex-M4 CPU. By default, such
 * support will be used based on some autodection on the compiler
 * version and target architecture. Define this variable to 1 to force
 * use of the assembly code, or 0 to disable it regardless of the
 * autodetection.
 *
 * When FALCON_ASM_CORTEXM4 is enabled (whether defined explicitly or
 * autodetected), emulated floating-point code will be used, unless
 * FALCON_FPNATIVE or FALCON_FPEMU is explicitly set to override the
 * choice. Emulated code with ARM assembly is constant-time and provides
 * better performance than emulated code with plain C.
 *
 * The assembly code for the M4 can also work on a Cortex-M3. If the
 * compiler is instructed to target the M3 (e.g. '-mcpu=cortex-m3' with
 * GCC) then FALCON_ASM_CORTEXM4 won't be autodetected, but it can be
 * enabled explicitly. Take care, though, that the M3 multiplication
 * opcode (multiplication of two 32-bit unsigned integers with a 64-bit
 * result) is NOT constant-time.
 *
#define FALCON_ASM_CORTEXM4   1
 */

#define FALCON_ASM_CORTEXM4   1

/*
 * Enable use of AVX2 intrinsics. If enabled, then the code will compile
 * only when targeting x86 with the proper flags (-mavx2), and run only
 * on systems that offer the AVX2 opcodes. Some operations leverage AVX2
 * for better performance.
 *
#define FALCON_AVX2   1
 */

/*
 * Assert that the platform uses little-endian encoding. If enabled,
 * then encoding and decoding of aligned multibyte values will be
 * slightly faster (especially for hashing and random number
 * generation). If not defined explicitly, then autodetection is
 * applied.
 *
#define FALCON_LE   1
 */

/*
 * Assert that the platform tolerates accesses to unaligned multibyte
 * values. If enabled, then some operations are slightly faster. Note
 * that ARM Cortex M4 do _not_ fully tolerate unaligned accesses; for
 * such systems, this option should not be enabled. If not defined
 * explicitly, then autodetection is applied.
 *
#define FALCON_UNALIGNED   1
 */

/*
 * Use a constant-time hash-to-point process. This is relevant only in
 * a contrived scenario where all of the following hold:
 *
 *   - The attacker cannot observe input messages.
 *
 *   - The attacker cannot observe signature values.
 *
 *   - The attacker CAN observe/know nonce values (normally, nonce are
 *     generated randomly by the signer and encoded along with the
 *     signature, so if signature values are not observable, nonces
 *     should be hidden as well).
 *
 *   - The attacker has a list of potential values for the input message
 *     and would like to know which is the right one.
 *
 *   - The attacker has access to a precise side-channel that can observe
 *     the timing/memory access pattern of a system that generates or
 *     verifies the signature.
 *
 * Under this scenario, the attacker might infer from the behaviour of the
 * hash-to-point process enough information to "try" potential messages.
 *
 * Since this situation is arguably improbable (because nonces are normally
 * as equally hidden as the signatures themselves), and the constant-time
 * hash-to-point implementation is significantly slower than the normal
 * one, this function is disabled by default. Set the variable below to 1
 * to enable the constant-time hash-to-point implementation.
 *
#define FALCON_CT_HASH   1
 */

#endif
