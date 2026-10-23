# HAETAE for the Cortex-M4 (`m4f`)

Speed-optimised Cortex-M4 implementation of the HAETAE signature scheme
(KpqC), based on the **HAETAE 1.2.0** reference implementation
(`mupq/crypto_sign/haetae{2,3,5}/ref`).  For a low-stack implementation see
`crypto_sign/haetae{2,3,5}/m4fstack`.

## Compatibility

The outputs are byte-identical to the HAETAE 1.2.0 reference
implementation.  The only intended difference: the KeyGen singular-value
test is computed in 64 bits instead of `int32_t`, so for secrets on which
the reference's arithmetic would overflow (undefined behaviour; never
observed for honestly generated keys) the result can differ.  Checked:
- the pqm4 test vectors equal those of `mupq/crypto_sign/haetae{2,3,5}/ref`
  for all three parameter sets, and
- the official HAETAE 1.2.0 KAT files (`PQCsignKAT_haetae_mode{2,3,5}.rsp`)
  are reproduced through the `*_internal` functions.

The API (`api.h`) is that of the reference: the pqm4 API with an empty
context string, the context-string functions `crypto_sign_*_ctx` and the
deterministic `*_internal` functions.

## Optimisations

- NTT and inverse NTT in assembly (`ntt332.S`, from the pqm4 Dilithium
  implementation).  `ntt()` returns the same values as the reference;
  `invntt_tomont()` can return a different representative of a result close
  to `+-q/2`, which does not change any output (see `ntt.h`).
- SampleGauss83 (83-bit CDT with 166 entries) as a straight-line,
  constant-time assembly routine (`sample_gauss83.S`, generated from the
  reference tables).
- The rest of the Gaussian sampler, the degree-10 exponential approximation
  (`smulh48`) and the hyperball scaling (`fixpoint_mul_rnd13`) with 32-bit
  limbs and `UMAAL`; the identities used are stated in the comments of
  `sampler.c` and `fixpoint.h`.
- The FFT of the KeyGen singular-value test in assembly (`fft.S`, `SMMULR`).
- Signing computes `c*s` one polynomial at a time, the norm of `2z - y`
  without storing it, and shares the hyperball samples with `z` and
  `round(z)`.

## Memory

pqm4 stack benchmark on `mps2-an386` (arm-none-eabi-gcc 13.2, `-O3`), in
bytes; buffers passed by the caller (keys, signature, message) are not
included.  `.text` is the code size of the implementation (pqm4 size
benchmark, without the platform and the common SHAKE code).

| scheme  | KeyGen |  Sign  | Verify | `.text` |
|---------|-------:|-------:|-------:|--------:|
| haetae2 | 25,096 | 51,924 | 38,128 |  33,564 |
| haetae3 | 42,496 | 77,908 | 60,952 |  33,864 |
| haetae5 | 53,752 | 99,772 | 76,592 |  33,828 |

## Side channels

The new code (assembly routines, Gaussian sampler arithmetic) has no
secret-dependent branches or memory accesses.  As in the reference
implementation, the rejection loops (KeyGen, hyperball, Gaussian and
signature rejection), the challenge generation and the rANS encoding are
not constant-time.

## Changes to the reference code

Besides the optimisations: `memcpy` with a `NULL` context of length 0 is
avoided and `ctx == NULL` with `ctxlen > 0` is rejected, `crypto_sign_ctx`
sets `*smlen = 0` on error, the rANS decoder takes `const` input, `smulh48`
no longer shifts a negative value to the left, and file-local helpers and tables are
`static` (`brv8`, `start_cube`, `sample_gauss`, ...).

## Licence

See `LICENSE`: MIT (HAETAE reference implementation, Team HAETAE, and the
Cortex-M4 modifications and new files, YoungBeom Kim); `ntt332.S` and
`ntt332_macros.i` are CC0, `rans_byte.h` is public domain.
