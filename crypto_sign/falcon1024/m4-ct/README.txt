Falcon implementation for PQM4 (or even mupq in general).


There are multiple variants. Each variant is selected with the choice of
api.h (four choices: api512dyn.h, api512tree.h, api1024dyn.h,
api1024tree.h), and additional compile-time macro that are documented in
config.h and can be set either in config.h, or through command-line
flags passed to the C compiler.

Choice of api.h:

    api512dyn.h
        "Normal" Falcon-512. Private key is reasonably compact. The
        Falcon LDL tree is internally recomputed for each signature.

    api512tree.h
        Falcon-512 is key expansion. The Falcon LDL tree is computed
        as part of the keygen, and returned as private key. This
        speeds up signature generation, but also greatly enlarges
        the private key size.

    api1024dyn.h
        "Normal" Falcon-1024.

    api1024tree.h
        Falcon-1024 with key expansion.

Compile-time options (config.h):

    FALCON_FPEMU
        Set to 1 to enable use of the internal constant-time emulation
        of floating-point operations.

    FALCON_FPNATIVE
        Set to 1 to use the native 'double' type and floating-point
        operations. On architectures that lack a FPU, this will use the
        compiler-provided floating-point emulation routines, which are
        usually not constant-time (and sometimes return values which
        do not follow IEEE-754 rounding rules).

    FALCON_ASM_CORTEXM4
        Set to 1 to use the M4 assembly routine for the constant-time
        emulation of floating-point operations. These are faster than
        the generic routines in C activated by FALCON_FPEMU.

There is some internal autodetection that tries to select the right
values automatically, but it's safer to explicitly select things:

    To use the native 'double' type:
        -DFALCON_FPNATIVE=1

    To use the generic FP emulation code:
        -DFALCON_FPEMU=1 -DFALCON_ASM_CORTEXM4=0

    To use the M4 assembly code for FP emulation:
        -DFALCON_FPEMU=1 -DFALCON_ASM_CORTEXM4=1

The code relying on the native 'double' type requires an implementation
that follows IEEE-754 rules with a 64-bit type. It works on 64-bit x86
and PowerPC / POWER systems. On 32-bit x86, it tends to fail because the
80387 FPU is used with more precision; on such a system, use
'-msse2 -mfpmath=sse' to force use of the SSE2 unit (this might be the
default on some systems, e.g. Darwin / macOS).


IMPORTANT NOTES
===============

  * The PQM4 API is implemented in pqm4.c. Since the M4 stack is usually
    small (usual default is 4 kB), temporary buffers are statically
    allocated. This implies that the crypto_sign_keypair(), crypto_sign()
    and crypto_sign_open() functions are not thread-safe or reentrant.
    Also, the static allocation is "forever".

    See the comments for the 'tmp' variable in pqm4.c; this gives the
    relevant sizes.

  * When using expanded keys, the private key contains 64-bit values
    (floating-point, i.e. 'double' or 'uint64_t' depending on the kind
    of floating-point emulation that is used). On many systems, this
    implies some alignment requirements. I.e. crypto_sign_keypair() and
    crypto_sign() then require the 'sk' pointer to be suitably aligned.
    On an ARM Cortex M4, 32-bit alignment is required (while the basic
    RAM access opcodes tolerate unaligned accesses, the 'ldm' and 'stm'
    opcodes need 32-bit aligned pointers).

  * When using the native 'double' type, the code has a dependency on
    the sqrt() function. On x86, the relevant SSE2 opcode is inlined,
    but the library function is still (potentially) invoked in case the
    operand is negative, so that proper error management is performed.
    This case does not happen in Falcon, but the library function is
    still referenced, and explicitly linking with '-lm' may be
    necessary.

  * When using the native 'double' type, do _NOT_ enable -ffast-math.
    The internal rounding function relies on the usual trick:
        when x >= 0, round(x) = (x + 2**52) - 2**52

    This trick works only as long as each addition is rounded as per
    the IEEE-754 rules to the exact precision of the 64-bit type.
    When -ffast-math is enabled, the compiler may assume commutativity
    and "optimize" that expression into 'round(x) = x', which does not
    work at all.


TESTS
=====

In the 'tests/' directory is a generator for known-answer tests, and the
expected file. The code comes from the NIST, but was modified to avoid a
dependency on OpenSSL. When compiling the C source file against the
selected Falcon implementation, an executable is produced, that, when
executed, generates an '*.req' and an '*.rsp' files. The .req file is
redundant (the .rsp file contains all the information, and some more).

The expected .rsp files are provided as:
    KAT512dyn.rsp        Falcon-512, no expanded key
    KAT512tree.rsp       Falcon-512, with expanded key
    KAT1024dyn.rsp       Falcon-1024, no expanded key
    KAT1024tree.rsp      Falcon-1024, with expanded key


Normally, all computations are exact and the files are exactly
reproducible. However, some discrepancies may occur with the '*tree'
files in the following cases:

  - On big-endian architectures, the bytes in sk[] will be in a
    different order. This is a side effect of putting the raw bytes
    of the expanded key in sk[] (this could be fixed with some
    reencoding pass, but this was not implemented yet).

  - If a non-exact IEEE-754 implementation is used, some of the
    low bits of the values may be changed. This may happen if the
    underlying implementation is not strictly faithful to rounding.

As long as only the 'sk' lines are changed, then the public keys
and signature values are unimpacted.
