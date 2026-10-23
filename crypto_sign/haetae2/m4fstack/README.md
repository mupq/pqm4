# Low-Stack HAETAE for the Cortex-M4 (`m4fstack`)

Stack-optimised Cortex-M4 implementation of the HAETAE signature scheme
(KpqC), following the **HAETAE 1.2.0** specification and reference
implementation.  It is the implementation of

> Y. Kim, C. van Vredendaal, G. Banegas, S. C. Seo,
> *Low-Stack HAETAE for Memory-Constrained Microcontrollers*, TCHES 2026,

ported from HAETAE v3.0 to 1.2.0.

## Compatibility

The outputs are byte-identical to the HAETAE 1.2.0 reference
implementation:

- the pqm4 test vectors equal those of `mupq/crypto_sign/haetae{2,3,5}/ref`
  (HAETAE 1.2.0) for all three parameter sets, and
- the official HAETAE 1.2.0 KAT files (`PQCsignKAT_haetae_mode{2,3,5}.rsp`)
  are reproduced through the `*_internal` functions.

## API

`api.h` provides the pqm4 API (`crypto_sign_keypair`, `crypto_sign`,
`crypto_sign_open`, `crypto_sign_signature`, `crypto_sign_verify`), which
uses an empty context string, together with the HAETAE 1.2.0 API:
`crypto_sign_signature_ctx`, `crypto_sign_ctx`, `crypto_sign_verify_ctx`,
`crypto_sign_open_ctx` (context string of at most 255 bytes, hedged
signing with 32 bytes from `randombytes`), and the deterministic
`crypto_sign_keypair_internal`, `crypto_sign_signature_internal` and
`crypto_sign_verify_internal` used for KATs.

## Memory

pqm4 stack benchmark on `mps2-an386` (arm-none-eabi-gcc 13.2, `-O3`), in
bytes; buffers passed by the caller (keys, signature, message) are not
included.

| scheme  | KeyGen | Sign  | Verify | `.text` |
|---------|-------:|------:|-------:|--------:|
| haetae2 |  4,832 | 5,876 |  4,840 |  33,180 |
| haetae3 |  4,832 | 6,060 |  4,864 |  33,944 |
| haetae5 |  3,800 | 6,044 |  4,856 |  33,268 |

`.data` and `.bss` are empty.

## Design

- **KeyGen** samples `s1`, `s2` and the matrix one polynomial at a time and
  computes the singular-value test from a running sum of FFT magnitudes.
- **Sign** never stores the masking vector `y`.  A two-pass hyperball
  sampler first computes the scaling factor and then regenerates each
  polynomial of `y` from its seed when it is needed: Pass A computes the
  challenge from `A*round(y)` (two rows at a time, `A` sampled on the fly),
  Pass B computes `z` and the rejection tests, and Pass C recomputes
  `A*round(y)` row by row and encodes the hint and `HighBits(z1)` with
  reverse-order streaming rANS, one coefficient at a time, into small
  buffers that are then copied into the signature.
- **Verify** decodes the signature as a stream and processes the matrix row
  by row.
- The SampleGauss83 CDT lookup (83-bit table with 166 entries) is a
  straight-line assembly routine (`sample_gauss83.S`), and the NTT is the
  Cortex-M4 assembly of the pqm4 HAETAE `m4f` implementation
  (`ntt332.S`).

## Side channels

The CDT lookup (`sample_gauss83.S`), the accumulators of the rejection
tests and the sign `(-1)^b` are branch-free and have no secret-dependent
memory accesses.  As in the reference implementation, the rejection loops
(KeyGen, hyperball, Gaussian and signature rejection) are not
constant-time.  Unlike the reference, which multiplies `c*s` with the NTT,
modes 2 and 3 use a sparse multiplication that branches on the positions
of the challenge coefficients; the challenge of an accepted signature is
public, those of rejected attempts are not published.

## Changes with respect to the TCHES 2026 artifact

- HAETAE 1.2.0: context strings and hedged signing, 1-byte-per-coefficient
  high bits in the challenge input for modes 2 and 3, the corrected
  fixed-point squaring, and the new Gaussian sampler (CDT83 and a degree-10
  exponential approximation).
- The hyperball norm test in Pass A is computed on the fixed-point vector
  before rounding, as in the reference; an inverted early rejection and an
  early exit on `||z1[0]||^2` (never observed to trigger) were removed; the
  `||2z - y||^2` accumulator is branch-free.
- KeyGen passes `s1` and `s2` to the secret-key packing by pointer instead
  of by value, which saves 1 KB of stack.
- Dead code of the artifact configuration knobs was removed and all
  exported symbols are namespaced.

## Licence

See `LICENSE`: Apache-2.0 for this implementation; code from the HAETAE
reference implementation (MIT), the pqm4 NTT (CC0) and the rANS coder
(public domain) keep their licences.
