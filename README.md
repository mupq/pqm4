# pqm4
Post-quantum crypto library for the ARM Cortex-M4

## Introduction
The **pqm4** library, benchmarking and testing framework started as a result of the 
[PQCRYPTO](https://pqcrypto.eu.org) project funded by the European Commission in the H2020 program. 
It currently contains implementations post-quantum key-encapsulation mechanisms
and post-quantum signature schemes targeting the ARM Cortex-M4 family of microcontrollers.
The design goals of the library are to offer
* automated functional testing on a widely available development board;
* automated generation of test vectors and comparison against output
  of a reference implementation running host-side (i.e., on the computer the
  development board is connected to);
* automated benchmarking for speed, stack usage, and code-size;
* automated profiling of cycles spent in symmetric primitives (SHA-2, SHA-3, AES);
* integration of clean implementations from [PQClean](https://github.com/PQClean/PQClean); and
* easy integration of new schemes and implementations into the framework.

## Previous NIST PQC

The master branch of **pqm4** contains schemes that either [selected for standardization by NIST](https://csrc.nist.gov/Projects/post-quantum-cryptography/selected-algorithms-2022) or part of the [4th round of the NIST PQC competition](https://csrc.nist.gov/Projects/post-quantum-cryptography/round-4-submissions).

Implementations for previous NIST PQC rounds are available here:
- Round 3: https://github.com/mupq/pqm4/releases/tag/Round3
- Round 2: https://github.com/mupq/pqm4/releases/tag/Round2
- Round 1: https://github.com/mupq/pqm4/releases/tag/Round1

## Changes in Round 2
For the second round of the NIST PQC, **pqm4** was extended (see [#78](https://github.com/mupq/pqm4/pull/78)) with the following features:
- common code was moved to [mupq](https://github.com/mupq/mupq) for reuse in [pqriscv](https://github.com/mupq/pqriscv),
- much simpler build process,
- automated profiling of cycles spent in symmetric primitives (SHA-2, SHA-3, AES),
- reporting of code-size,
- integration of clean implementations from [PQClean](https://github.com/PQClean/PQClean).

## Schemes included in pqm4

For most of the schemes there are multiple implementations. 
The naming scheme for these implementations is as follows:
* `clean`: clean reference implementation from [PQClean](https://github.com/PQClean/PQClean),
* `ref`: the reference implementation submitted to NIST (will be replaced by `clean` in the long term),
* `opt`: an optimized implementation in plain C (e.g., the optimized implementation submitted to NIST),
* `m4`: an implementation with Cortex-M4 specific optimizations (typically in assembly).
* `m4f`: an implementation with Cortex-M4F specific optimizations (typically assembly using floating-point registers).

## Setup/Installation
The testing and benchmarking framework of **pqm4** targets several development
boards, all featuring an ARM Cortex-M4 chip:

* `stm32f4discovery` (default): The [STM32F4 Discovery board](https://www.st.com/en/evaluation-tools/stm32f4discovery.html)
  featuring 1MB of Flash, and 192KB of RAM. Connecting the
  development to the host computer requires a mini-USB cable and a USB-TTL
  converter together with a 2-pin dupont / jumper cable.
* `nucleo-l476rg`: The [NUCLEO-L476RG board](https://www.st.com/en/evaluation-tools/nucleo-l476rg.html)
  featuring 1MB of Flash and 128KB of RAM. This board does not require a
  separate USB serial interface converter.
* `cw308t-stm32f3`: The ChipWhisperer [CW308-STM32F3 target board](https://rtfm.newae.com/Targets/UFO%20Targets/CW308T-STM32F/)
  (in the F3 configuration) featuring 256KB of Flash and 40KB of RAM.
* `nucleo-l4r5zi`: The [NUCLEO-L4R5ZI board](https://www.st.com/en/evaluation-tools/nucleo-l4r5zi.html)
  featuring 2MB of Flash and 640KB of RAM. This board does not require a
  separate USB serial interface converter.
* `mps2-an386`: The ARM MPS2(+) FPGA prototyping board when used with the
  ARM-Cortex M4 bitstream (see [ARM AN386](https://developer.arm.com/documentation/dai0386/c))
  featuring two 4MB RAM blocks, one used in lieu of Flash one as RAM. This board
  can also be simulated with the QEMU 5.2 simulator (the cycle counts are,
  however, meaningless in this case).

### Installing the ARM toolchain
The **pqm4** build system assumes that you have the [arm-none-eabi toolchain](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
toolchain installed.
On most Linux systems, the correct toolchain gets installed when you install the `arm-none-eabi-gcc` (or `gcc-arm-none-eabi`) package.  
On some Linux distributions, you will also have to explicitly install `libnewlib-arm-none-eabi` .

### Installing stlink
To flash binaries onto most development boards, **pqm4** is using [stlink](https://github.com/texane/stlink). 
Depending on your operating system, stlink may be available in your package manager -- if not, please
refer to the stlink Github page for instructions on how to [compile it from source](https://github.com/texane/stlink/blob/master/doc/compiling.md) 
(in that case, be careful to use libusb-1.0.0-dev, not libusb-0.1).

### Installing OpenOCD
For the `nucleo-l4r5zi` board [OpenOCD](http://openocd.org) (tested with version 0.11) is used for flashing binaries.
Depending on your operating system, OpenOCD may be available in your package manager -- if not, please
refer to the OpenOCD README for instructions on how to [compile it from source](http://openocd.org/doc-release/README).

### Python3
The benchmarking scripts used in **pqm4** require Python >= 3.6.

### Installing pyserial
The host-side Python code for most platforms requires the [pyserial](https://github.com/pyserial/pyserial) module.
Your package repository might offer `python3-serial` (Debian, Ubuntu) or `python-pyserial` (Arch) or `python3-pyserial` (Fedora, openSUSE) or `pyserial` (Slack, CentOS, Gentoo) or `py3-pyserial` (Alpine) directly.
Alternatively, this can be easily installed from PyPA by calling `pip3 install -r requirements.txt`.
If you do not have `pip3` installed yet, you can typically find it as `python3-pip` (Debian, Ubuntu) or `python-pip` (Arch) using your package manager.

### Installing ChipWhisperer
The host-side Python code for the `cw308t-stm32f3` board requires the [chipwhisperer](https://chipwhisperer.readthedocs.io/en/latest/installing.html#install-repo-pypi) module.
If you don't target this board, you can skip the installation.

### Installing QEMU >=5.2
The `mps2-an386` platform is simulated with the [QEMU](https://www.qemu.org/)
ARM system emulator. You'll need at least the version 5.2, which is fairly
recent at the time of writing and may not be available on your favourite Linux
distro. If you don't target this platform, you can skip the installation.

### Connecting the STM32F4 Discovery board to the host
Connect the board to your host machine using the mini-USB port. 
This provides it with power, and allows you to flash binaries onto the board. 
It should show up in `lsusb` as `STMicroelectronics ST-LINK/V2`.

If you are using a UART-USB connector that has a PL2303 chip on board (which appears to be the most common), 
the driver should be loaded in your kernel by default. If it is not, it is typically called `pl2303`. 
On macOS, you will still need to [install it](http://www.prolific.com.tw/US/ShowProduct.aspx?p_id=229&pcid=41) (and reboot). 
When you plug in the device, it should show up as `Prolific Technology, Inc. PL2303 Serial Port` when you type `lsusb`.

Using dupont / jumper cables, connect the `TX`/`TXD` pin of the USB connector to the `PA3` pin on the board, and connect `RX`/`RXD` to `PA2`. 
Depending on your setup, you may also want to connect the `GND` pins.

### Downloading pqm4 and libopencm3
Finally, obtain the **pqm4** library and the submodules:
```
git clone --recursive https://github.com/mupq/pqm4.git
```

Now you may pick your platform and compile the code (adapt the `PLATFORM`
variable to your chosen platform and the number of threads in `-j4` to your PC accordingly):
```
make -j4 PLATFORM=stm32f4discovery
```

## API documentation
The **pqm4** library uses the NIST/SUPERCOP/[PQClean
API](https://github.com/PQClean/PQClean). It is mandated for all included
schemes.

KEMs need to define `CRYPTO_SECRETKEYBYTES`, `CRYPTO_PUBLICKEYBYTES`, `CRYPTO_BYTES`, and `CRYPTO_CIPHERTEXTBYTES` and implement 
```c
int crypto_kem_keypair(unsigned char *pk, unsigned char *sk);
int crypto_kem_enc(unsigned char *ct, unsigned char *ss, const unsigned char *pk);
int crypto_kem_dec(unsigned char *ss, const unsigned char *ct, const unsigned char *sk);
```

Signature schemes need to define `CRYPTO_SECRETKEYBYTES`, `CRYPTO_PUBLICKEYBYTES`, and `CRYPTO_BYTES` and implement
```c
int crypto_sign_keypair(unsigned char *pk, unsigned char *sk);
int crypto_sign(unsigned char *sm, size_t *smlen, 
                const unsigned char *msg, size_t len,
                const unsigned char *sk);
int crypto_sign_open(unsigned char *m, size_t *mlen,
                     const unsigned char *sm, size_t smlen,
                     const unsigned char *pk);
```


## Running tests and benchmarks
The build system compiles six binaries for each implemenation which can be used to test and benchmark the schemes. For example, for the reference implementation of [Kyber768](https://pq-crystals.org/kyber/) the following binaries are assembled: 
 - `bin/crypto_kem_kyber768_m4_test.bin` tests if the scheme works as expected. For KEMs this tests if Alice and Bob derive the same shared key and for signature schemes it tests if a generated signature can be verified correctly. Several failure cases are also checked, see [mupq/crypto_kem/test.c](https://github.com/mupq/mupq/blob/master/crypto_kem/test.c) and [mupq/crypto_sign/test.c](https://github.com/mupq/mupq/blob/master/crypto_sign/test.c) for details.
 - `bin/crypto_kem_kyber768_m4_speed.bin` measures the runtime of `crypto_kem_keypair`, `crypto_kem_enc`, and `crypto_kem_dec` for KEMs and `crypto_sign_keypair`, `crypto_sign`, and `crypto_sign_open` for signatures. See [mupq/crypto_kem/speed.c](https://github.com/mupq/mupq/blob/master/crypto_kem/speed.c) and [mupq/crypto_sign/speed.c](https://github.com/mupq/mupq/blob/master/crypto_sign/speed.c).
 - `bin/crypto_kem_kyber768_m4_hashing.bin` measures the cycles spent in SHA-2, SHA-3, and AES of `crypto_kem_keypair`, `crypto_kem_enc`, and `crypto_kem_dec` for KEMs and `crypto_sign_keypair`, `crypto_sign`, and `crypto_sign_open` for signatures. See [mupq/crypto_kem/hashing.c](https://github.com/mupq/mupq/blob/master/crypto_kem/speed.c) and [mupq/crypto_sign/speed.c](https://github.com/mupq/mupq/blob/master/crypto_sign/speed.c).
 - `bin/crypto_kem_kyber768_m4_stack.bin` measures the stack consumption of each of the procedures involved. The memory allocated outside of the procedures (e.g., public keys, private keys, ciphertexts, signatures) is not included. See [mupq/crypto_kem/stack.c](https://github.com/mupq/mupq/blob/master/crypto_kem/stack.c) and [mupq/crypto_sign/stack.c](https://github.com/mupq/mupq/blob/master/crypto_sign/stack.c).
 - `bin/crypto_kem_kyber768_m4_testvectors.bin` uses a deterministic random number generator to generate testvectors for the implementation. These can be used to cross-check different implemenatations of the same scheme. See [mupq/crypto_kem/testvectors.c](https://github.com/mupq/mupq/blob/master/crypto_kem/testvectors.c) and [mupq/crypto_sign/testvectors.c](https://github.com/mupq/mupq/blob/master/crypto_sign/testvectors.c).
- `bin-host/crypto_kem_kyber768_m4_testvectors` uses the same deterministic random number generator to create the testvectors on your host. See [mupq/crypto_kem/testvectors-host.c](https://github.com/mupq/mupq/blob/master/crypto_kem/testvectors-host.c) and [mupq/crypto_sign/testvectors-host.c](https://github.com/mupq/mupq/blob/master/crypto_sign/testvectors-host.c).
- An `elf` file for each binary is generated in the `elf/` folder if desired.

The `elf` files or binaries can be flashed to your board using an appropriate
tool. For example, the `stm32f4discovery` platform uses `st-flash`, e.g., `st-flash write bin/crypto_kem_kyber768_m4_test.bin 0x8000000`. To receive the output, run `python3 hostside/host_unidirectional.py`. 

If you target the `mps2-an386` platform, you can also run the `elf` file using
the QEMU ARM emulator:
```
qemu-system-arm -M mps2-an386 -nographic -semihosting -kernel elf/crypto_kem_kyber512_m4_test.elf
```
The emulator should exit automatically when the test / benchmark completes. If
you run into an error, you can exit QEMU pressing CTRL+A and then X.

The **pqm4** framework automates testing and benchmarking for all schemes using Python3 scripts: 
- `python3 test.py`: flashes all test binaries to the boards and checks that no errors occur. 
- `python3 testvectors.py`: flashes all testvector binaries to the boards and writes the testvectors to `testvectors/`. Additionally, it executes the reference implementations on your host machine. Afterwards, it checks the testvectors of different implementations of the same scheme for consistency. 
- `python3 benchmarks.py`: flashes the stack and speed binaries and writes the results to `benchmarks/stack/` and `benchmarks/speed/`. You may want to execute this several times for certain schemes for which the execution time varies significantly.

The scripts take a number of command line arguments, which you'll need to adapt:
- `--platform <platformname>` or `-p <platformname>`: Sets the target platform (default `stm32f4discovery`).
- `--opt {speed,size,debug}` or `-o {speed,size,debug}`: Sets optimization flags for compilation (default `speed`).
- `--lto` or `-l`: Use link-time optimization during compilation.
- `--no-aio`: Use link-time optimization during compilation.

If you change any of these values, you'll need to run `make clean` (the build
system will remind you).

In case you don't want to include all schemes, pass a list of schemes you want to include to any of the scripts, e.g., `python3 test.py kyber768 sphincs-shake256-128f-simple`. 
In case you want to exclude certain schemes pass `--exclude`, e.g., `python3 test.py --exclude saber`.

The benchmark results (in `benchmarks/`) created by 
`python3 benchmarks.py` can be automatically converted to a markdown table using `python3 convert_benchmarks.py md` or to csv using `python3 convert_benchmarks.py csv`.

## Benchmarks
The current benchmark results can be found in [benchmarks.csv](benchmarks.csv) or [benchmarks.md](benchmarks.md).

All cycle counts were obtained at 24MHz to avoid wait cycles due to the speed of the memory controller.
For most schemes we report minimum, maximum, and average cycle counts of 100 executions.
For some particularly slow schemes we reduce the number of executions; the number of
executions is reported in parentheses.

The numbers were obtained with `arm-none-eabi-gcc (Arm GNU Toolchain 11.3.Rel1) 11.3.1 20220712` from [Arm](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads).

The code-size measurements only include the code that is provided by the scheme implementation, i.e., exclude common code like hashing or C standard library functions.
The measurements are performed with `arm-none-eabi-size`.
The size contributions to the `.text`, `.data`, and `.bss` sections are also listed separately.


## Adding new schemes and implementations
The **pqm4** build system is designed to make it very easy to add new schemes
and implementations, if these implementations follow the NIST/SUPERCOP/PQClean API.

In case you want to contribute a reference implementation, please open a pull request to [PQClean](https://github.com/PQClean/PQClean).
In case you want to contribute an optimized C implementation, please open a pull request to [mupq](https://github.com/mupq/mupq).
In case you want to add an implementation optimized for the Cortex-M4, please open a pull request here.

In the following we consider the example of adding an M4-optimized implementation
of [NewHope-512-CPA-KEM](https://newhopecrypto.org) to **pqm4**:

1. Create a subdirectory for the new scheme under `crypto_kem/`; in the following we assume that this subdirectory is called `newhope512cpa`.
1. Create a subdirectory `m4` under `crypto_kem/newhope512cpa/`.
1. Copy all files of the implementation into this new subdirectory `crypto_kem/newhope512cpa/m4/`,
   except for the file implementing the `randombytes` function (typically `PQCgenKAT_kem.c`).

The procedure for adding a signature scheme is the same, except that it starts with creating a
new subdirectory under `crypto_sign/`.

### Using optimized FIPS202 (Keccak, SHA3, SHAKE)
   Many schemes submitted to NIST use SHA-3, SHAKE or cSHAKE for hashing. 
   This is why **pqm4** comes with highly optimized Keccak code that is accessible
   from all KEM and signature implementations. 
   Functions from the FIPS202 standard are defined in `mupq/common/fips202.h` as follows:

   ```c
  void shake128_absorb(shake128ctx *state, const uint8_t *input, size_t inlen);
  void shake128_squeezeblocks(uint8_t *output, size_t nblocks, shake128ctx *state);
  void shake128(uint8_t *output, size_t outlen, const uint8_t *input, size_t inlen);

  void shake128_inc_init(shake128incctx *state);
  void shake128_inc_absorb(shake128incctx *state, const uint8_t *input, size_t inlen);
  void shake128_inc_finalize(shake128incctx *state);
  void shake128_inc_squeeze(uint8_t *output, size_t outlen, shake128incctx *state);

  void shake256_absorb(shake256ctx *state, const uint8_t *input, size_t inlen);
  void shake256_squeezeblocks(uint8_t *output, size_t nblocks, shake256ctx *state);
  void shake256(uint8_t *output, size_t outlen, const uint8_t *input, size_t inlen);

  void shake256_inc_init(shake256incctx *state);
  void shake256_inc_absorb(shake256incctx *state, const uint8_t *input, size_t inlen);
  void shake256_inc_finalize(shake256incctx *state);
  void shake256_inc_squeeze(uint8_t *output, size_t outlen, shake256incctx *state);

  void sha3_256_inc_init(sha3_256incctx *state);
  void sha3_256_inc_absorb(sha3_256incctx *state, const uint8_t *input, size_t inlen);
  void sha3_256_inc_finalize(uint8_t *output, sha3_256incctx *state);

  void sha3_256(uint8_t *output, const uint8_t *input, size_t inlen);

  void sha3_512_inc_init(sha3_512incctx *state);
  void sha3_512_inc_absorb(sha3_512incctx *state, const uint8_t *input, size_t inlen);
  void sha3_512_inc_finalize(uint8_t *output, sha3_512incctx *state);

  void sha3_512(uint8_t *output, const uint8_t *input, size_t inlen);
   ```

  Functions from the related publication SP 800-185 (cSHAKE) are defined in `mupq/common/sp800-185.h`:

  ```c
  void cshake128_inc_init(shake128incctx *state, const uint8_t *name, size_t namelen, const uint8_t *cstm, size_t cstmlen);
  void cshake128_inc_absorb(shake128incctx *state, const uint8_t *input, size_t inlen);
  void cshake128_inc_finalize(shake128incctx *state);
  void cshake128_inc_squeeze(uint8_t *output, size_t outlen, shake128incctx *state);

  void cshake128(uint8_t *output, size_t outlen, const uint8_t *name, size_t namelen, const uint8_t *cstm, size_t cstmlen, const uint8_t *input, size_t inlen);

  void cshake256_inc_init(shake256incctx *state, const uint8_t *name, size_t namelen, const uint8_t *cstm, size_t cstmlen);
  void cshake256_inc_absorb(shake256incctx *state, const uint8_t *input, size_t inlen);
  void cshake256_inc_finalize(shake256incctx *state);
  void cshake256_inc_squeeze(uint8_t *output, size_t outlen, shake256incctx *state);

  void cshake256(uint8_t *output, size_t outlen, const uint8_t *name, size_t namelen, const uint8_t* cstm, size_t cstmlen, const uint8_t *input, size_t inlen);
  ```

   Implementations that want to make use of these optimized routines simply include 
   `fips202.h` (or `sp800-185.h`). The API for `sha3_256` and `sha3_512` follows the 
   [SUPERCOP hash API](https://bench.cr.yp.to/call-hash.html).
   The API for `shake128` and `shake256` is very similar, except that it supports variable-length output.
   The SHAKE functions are also accessible via the absorb-squeezeblocks functions, which offer incremental
   output generation (but not incremental input handling).
   The variants with `_inc_` offer both incremental input handling and output generation.

## Using optimized SHA-2

  Some schemes submitted to NIST use SHA-224, SHA-256, SHA-384, or SHA-512 for hashing.
  We've experimented with assembly-optimized SHA-512, but found that the speed-up
  achievable with this compared to the C implementation from
  [SUPERCOP](https://bench.cr.yp.to/) is negligible
  when compiled using `arm-none-eabi-gcc-8.3.0`.
  For older compiler versions (e.g. `5.4.1`) hand-optimized assembly implementations
  were significantly faster.
  We've therefore decided to only include a C version of the SHA-2 variants.
  The available functions are:
   ```c
  void sha224_inc_init(sha224ctx *state);
  void sha224_inc_blocks(sha224ctx *state, const uint8_t *in, size_t inblocks);
  void sha224_inc_finalize(uint8_t *out, sha224ctx *state, const uint8_t *in, size_t inlen);
  void sha224(uint8_t *out, const uint8_t *in, size_t inlen);

  void sha256_inc_init(sha256ctx *state);
  void sha256_inc_blocks(sha256ctx *state, const uint8_t *in, size_t inblocks);
  void sha256_inc_finalize(uint8_t *out, sha256ctx *state, const uint8_t *in, size_t inlen);
  void sha256(uint8_t *out, const uint8_t *in, size_t inlen);

  void sha384_inc_init(sha384ctx *state);
  void sha384_inc_blocks(sha384ctx *state, const uint8_t *in, size_t inblocks);
  void sha384_inc_finalize(uint8_t *out, sha384ctx *state, const uint8_t *in, size_t inlen);
  void sha384(uint8_t *out, const uint8_t *in, size_t inlen);

  void sha512_inc_init(sha512ctx *state);
  void sha512_inc_blocks(sha512ctx *state, const uint8_t *in, size_t inblocks);
  void sha512_inc_finalize(uint8_t *out, sha512ctx *state, const uint8_t *in, size_t inlen);
  void sha512(uint8_t *out, const uint8_t *in, size_t inlen);
  ```
  Implementations can use these by including `sha2.h`.

## Using optimized AES

  Some schemes submitted to NIST make use of AES as a subroutine.
  We included assembly-optimized implementations of AES-128 and AES-256 in ECB mode and in CTR mode.

  Up until January 2021, pqm4 relied on the [t-table implementation](https://github.com/Ko-/aes-armcortexm) by Schwabe and Stoffelen published at [SAC2016](https://eprint.iacr.org/2016/714.pdf).
  On Cortex-M4 platforms with a data cache, this implementation may be vulnerable to cache attacks.
  Hence, pqm4 is now using the [bitsliced implementation](https://github.com/aadomn/aes) by Adomnicai and Peyrin published in [TCHES2021/1](https://eprint.iacr.org/2020/1123.pdf).

  The functions that can be used are stated in `common/aes.h` as follows:
  ```c
  void aes128_ecb_keyexp(aes128ctx *r, const unsigned char *key);
  void aes128_ctr_keyexp(aes128ctx *r, const unsigned char *key);
  void aes128_ecb(unsigned char *out, const unsigned char *in, size_t nblocks, const aes128ctx *ctx);
  void aes128_ctr(unsigned char *out, size_t outlen, const unsigned char *iv, const aes128ctx *ctx);

  void aes256_ecb_keyexp(aes256ctx *r, const unsigned char *key);
  void aes256_ctr_keyexp(aes256ctx *r, const unsigned char *key);
  void aes256_ecb(unsigned char *out, const unsigned char *in, size_t nblocks, const aes256ctx *ctx);
  void aes256_ctr(unsigned char *out, size_t outlen, const unsigned char *iv, const aes256ctx *ctx);
  ```
  Implementations can use these by including `aes.h`.

  Some post-quantum schemes use AES with only public inputs (e.g., Kyber and FrodoKEM) and, consequently, do not need a constant-time AES implementation.
  As those schemes would be unfairly penalized by swiching to a slower constant-time implementation, we additionally provide the t-table implementation.
  The functions that can be used are stated in `common/aes-publicinputs.h` as follows:
 ```c
  void aes128_ecb_keyexp_publicinputs(aes128ctx_publicinputs *r, const unsigned char *key);
  void aes128_ctr_keyexp_publicinputs(aes128ctx_publicinputs *r, const unsigned char *key);
  void aes128_ecb_publicinputs(unsigned char *out, const unsigned char *in, size_t nblocks, const aes128ctx_publicinputs *ctx);
  void aes128_ctr_publicinputs(unsigned char *out, size_t outlen, const unsigned char *iv, const aes128ctx_publicinputs *ctx);

  void aes192_ecb_keyexp_publicinputs(aes192ctx_publicinputs *r, const unsigned char *key);
  void aes192_ctr_keyexp_publicinputs(aes192ctx_publicinputs *r, const unsigned char *key);
  void aes192_ecb_publicinputs(unsigned char *out, const unsigned char *in, size_t nblocks, const aes192ctx_publicinputs *ctx);
  void aes192_ctr_publicinputs(unsigned char *out, size_t outlen, const unsigned char *iv, const aes192ctx_publicinputs *ctx);

  void aes256_ecb_keyexp_publicinputs(aes256ctx_publicinputs *r, const unsigned char *key);
  void aes256_ctr_keyexp_publicinputs(aes256ctx_publicinputs *r, const unsigned char *key);
  void aes256_ecb_publicinputs(unsigned char *out, const unsigned char *in, size_t nblocks, const aes256ctx_publicinputs *ctx);
  void aes256_ctr_publicinputs(unsigned char *out, size_t outlen, const unsigned char *iv, const aes256ctx_publicinputs *ctx);
 ```

## Bibliography

When referring to this framework in academic literature, please consider using the following bibTeX excerpt:

```
@misc{PQM4,
  title = {{PQM4}: Post-quantum crypto library for the {ARM} {Cortex-M4}},
  author = {Matthias J. Kannwischer and Richard Petri and Joost Rijneveld and Peter Schwabe and Ko Stoffelen},
  note = {\url{https://github.com/mupq/pqm4}}
}
```

## License
Different parts of **pqm4** have different licenses. 
Each subdirectory containing implementations contains a LICENSE or COPYING file stating 
under what license that specific implementation is released. 
The files in common contain licensing information at the top of the file (and 
are currently either public domain or MIT). 
All other code in this repository is released under the conditions of [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

