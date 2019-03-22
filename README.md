# pqm4
Post-quantum crypto library for the ARM Cortex-M4

## Work in progress

This is the v2 version of pqm4, which will abstract away a lot of things into the
mupq parent project. Please make sure you have all the submodules when you work in this
directory

## Introduction
The **pqm4** library, benchmarking and testing framework started as a result of the 
[PQCRYPTO](https://pqcrypto.eu.org) project funded by the European Commission in the H2020 program. 
It currently contains implementations post-quantum key-encapsulation mechanisms
and post-quantum signature schemes targeting the ARM Cortex-M4 family of microcontrollers.
The design goals of the library are to offer
* a simple build system that generates an individual static library 
  for each implementation of each scheme, which can simply be linked into
  any software project;
* automated functional testing on a widely available development board;
* automated generation of test vectors and comparison against output
  of a reference implementation running host-side (i.e., on the computer the
  development board is connected to);
* automated benchmarking for speed and stack usage; and
* easy integration of new schemes and implementations into the framework.

## pqm4 in second round of NISTPQC 

As a result of the [Oxford PQC Workshop](https://www.maths.ox.ac.uk/events/conferences/oxford-post-quantum-cryptography-workshop), **pqm4** was extended to further support benchmarking for the second round of the NIST PQC competition. 
Alongside simplifying the build and benchmarking system, the following changes were implemented:
* move platform independent code to [mupq](https://github.com/mupq/mupq) to allow re-use of this code for other benchmarking projects like [pqriscv](https://github.com/mupq/pqriscv) 
* integration of [PQClean](https://github.com/PQClean/PQClean) as a source for round 2 clean reference implementations
* reporting of cycles spent in SHA-2, SHA-3, and AES 
* reporting of code-size for all schemes 


## Schemes included in pqm4
Currently **pqm4** contains implementations of the following post-quantum KEMs:
* [FrodoKEM-640-AES](https://frodokem.org/)
* [FrodoKEM-640-cSHAKE](https://frodokem.org/)
* [Kyber-512](https://pq-crystals.org/kyber/)
* [Kyber-768](https://pq-crystals.org/kyber/)
* [Kyber-1024](https://pq-crystals.org/kyber/)
* [NewHope-1024-CCA-KEM](https://newhopecrypto.org)
* [NTRU-HRSS-KEM-701](https://csrc.nist.gov/CSRC/media/Projects/Post-Quantum-Cryptography/documents/round-1/submissions/NTRU_HRSS_KEM.zip)
* [Saber](https://csrc.nist.gov/CSRC/media/Projects/Post-Quantum-Cryptography/documents/round-1/submissions/SABER.zip)
* [SIKE-p571](https://csrc.nist.gov/CSRC/media/Projects/Post-Quantum-Cryptography/documents/round-1/submissions/SIKE.zip)
* [Streamlined NTRU Prime 4591761](https://ntruprime.cr.yp.to/)

Currently **pqm4** contains implementations of the following post-quantum signature schemes:
* [Dilithium-III](https://pq-crystals.org/dilithium/)
* [qTesla-I](https://qTesla.org/)
* [qTesla-III-size](https://qTesla.org/)
* [qTesla-III-speed](https://qTesla.org/)
* [SPHINCS+-SHAKE256-128s](https://sphincs.org)

The schemes were selected according to the following criteria:
* Restrict to [NIST round 1 candidates](https://csrc.nist.gov/Projects/Post-Quantum-Cryptography/Round-1-Submissions).
* First focus on schemes and implementations resulting from the [PQCRYPTO project](https://pqcrypto.eu.org).
* Choose parameters targeting NIST security level 3 by default, but
  * choose parameters targeting a *higher* security level if there are no level-3 parameters, and
  * choose parameters targeting a *lower* security level if level-3 parameters exceed the development board's resources (in particular RAM).
* Restrict to schemes that have at least implementation of one parameter set that does not exceed the development board's resources.

For most of the schemes there are multiple implementations. 
The naming scheme for these implementations is as follows:
* `ref`: the reference implementation submitted to NIST,
* `opt`: an optimized implementation in plain C (e.g., the optimized implementation submitted to NIST),
* `m4`: an implementation with Cortex-M4 specific optimizations (typically in assembly).

## Setup/Installation
The testing and benchmarking framework of **pqm4** targets the 
[STM32F4 Discovery board](http://www.st.com/en/evaluation-tools/stm32f4discovery.html)
featuring an ARM Cortex-M4 CPU, 1MB of Flash, and 192KB of RAM.
Connecting the development to the host computer requires a 
mini-USB cable and a USB-TTL converter together with a 2-pin dupont / jumper cable.

### Installing the ARM toolchain
The **pqm4** build system assumes that you have the [arm-none-eabi toolchain](https://launchpad.net/gcc-arm-embedded)
toolchain installed.
On most Linux systems, the correct toolchain gets installed when you install the `arm-none-eabi-gcc` (or `gcc-arm-none-eabi`) package.  
On some Linux distributions, you will also have to explicitly install `libnewlib-arm-none-eabi` .

### Installing stlink
To flash binaries onto the development board, **pqm4** is using [stlink](https://github.com/texane/stlink). 
Depending on your operating system, stlink may be available in your package manager -- if not, please
refer to the stlink Github page for instructions on how to [compile it from source](https://github.com/texane/stlink/blob/master/doc/compiling.md) 
(in that case, be careful to use libusb-1.0.0-dev, not libusb-0.1).

### Installing pyserial
The host-side Python code requires the [pyserial](https://github.com/pyserial/pyserial) module. 
Your package repository might offer `python-serial` or `python-pyserial` directly 
(as of writing, this is the case for Ubuntu, Debian and Arch). 
Alternatively, this can be easily installed from PyPA by calling `pip install -r requirements.txt` 
(or `pip3`, depending on your system). 
If you do not have `pip` installed yet, you can typically find it as `python3-pip` using your package manager. 

### Connecting the board to the host
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
Finally, obtain the **pqm4** library and the submodule libopencm3:
```
git clone https://github.com/mupq/pqm4.git
cd pqm4
git submodule init
git submodule update
cd libopencm3 && make
```

## API documentation
The **pqm4** library uses the [NIST API](https://csrc.nist.gov/CSRC/media/Projects/Post-Quantum-Cryptography/documents/example-files/api-notes.pdf). It is mandated for all included schemes.

KEMs need to define `CRYPTO_SECRETKEYBYTES`, `CRYPTO_PUBLICKEYBYTES`, `CRYPTO_BYTES`, and `CRYPTO_CIPHERTEXTBYTES` and implement 
```c
int crypto_kem_keypair(unsigned char *pk, unsigned char *sk);
int crypto_kem_enc(unsigned char *ct, unsigned char *ss, const unsigned char *pk);
int crypto_kem_dec(unsigned char *ss, const unsigned char *ct, const unsigned char *sk);
```

Signature schemes need to define `CRYPTO_SECRETKEYBYTES`, `CRYPTO_PUBLICKEYBYTES`, and `CRYPTO_BYTES` and implement
```c
int crypto_sign_keypair(unsigned char *pk, unsigned char *sk);
int crypto_sign(unsigned char *sm, unsigned long long *smlen, 
		const unsigned char *msg, unsigned long long len, 
                const unsigned char *sk);
int crypto_sign_open(unsigned char *m, unsigned long long *mlen,
                     const unsigned char *sm, unsigned long long smlen,
                     const unsigned char *pk);
```

## Running tests and benchmarks
Executing `make` compiles five binaries for each implemenation which can be used to test and benchmark the schemes. For example, for the reference implementation of  [NewHope-1024-CCA-KEM](https://newhopecrypto.org) the following binaries are assembled: 
 - `bin/crypto_kem_newhope1024cca_ref_test.bin` tests if the scheme works as expected. For KEMs this tests if Alice and Bob derive the same shared key and for signature schemes it tests if a generated signature can be verified correctly. Several failure cases are also checked, see [crypto_kem/test.c](crypto_kem/test.c) and [crypto_sign/test.c](crypto_sign/test.c) for details.  
 - `bin/crypto_kem_newhope1024cca_ref_speed.bin` measures the runtime of `crypto_kem_keypair`, `crypto_kem_enc`, and `crypto_kem_dec` for KEMs and `crypto_sign_keypair`, `crypto_sign`, and `crypto_sign_open` for signatures. See [crypto_kem/speed.c](crypto_kem/speed.c) and [crypto_sign/speed.c](crypto_sign/speed.c).   
 - `bin/crypto_kem_newhope1024cca_ref_stack.bin` measures the stack consumption of each of the procedures involved. The memory allocated outside of the procedures (e.g., public keys, private keys, ciphertexts, signatures) is not included. See [crypto_kem/stack.c](crypto_kem/stack.c) and [crypto_sign/stack.c](crypto_sign/stack.c).    
 - `bin/crypto_kem_newhope1024cca_ref_testvectors.bin` uses a deterministic random number generator to generate testvectors for the implementation. These can be used to cross-check different implemenatations of the same scheme. See [crypto_kem/testvectors.c](crypto_kem/testvectors.c) and [crypto_sign/testvectors.c](crypto_sign/testvectors.c).   
- `bin-host/crypto_kem_newhope1024cca_ref_testvectors` uses the same deterministic random number generator to create the testvectors on your host. See [crypto_kem/testvectors-host.c](crypto_kem/testvectors-host.c) and [crypto_sign/testvectors-host.c](crypto_sign/testvectors-host.c). 

The binaries can be flashed to your board using `st-flash`, e.g., `st-flash write bin/crypto_kem_newhope1024cca_ref_test.bin 0x8000000`. To receive the output, run `python3 hostside/host_unidirectional.py`. 

The **pqm4** framework automates testing and benchmarking for all schemes using Python3 scripts: 
- `python3 test.py`: flashes all test binaries to the boards and checks that no errors occur. 
- `python3 testvectors.py`: flashes all testvector binaries to the boards and writes the testvectors to `testvectors/`. Additionally, it executes the reference implementations on your host machine. Afterwards, it checks the testvectors of different implementations of the same scheme for consistency. 
- `python3 benchmarks.py`: flashes the stack and speed binaries and writes the results to `benchmarks/stack/` and `benchmarks/speed/`. You may want to execute this several times for certain schemes for which the execution time varies significantly. 

In case you don't want to include all schemes, pass a list of schemes you want to include to any of the scripts, e.g., `python3 test.py newhope1024cca sphincs-shake256-128s`. 

The benchmark results (in `benchmarks/`) created by 
`python3 benchmarks.py` can be automatically converted to the markdown table below using `python3 benchmarks_to_md.py`

## Benchmarks
The tables below list cycle counts and stack usage of the implementations currently included in **pqm4**.
All cycle counts were obtained at 24MHz to avoid wait cycles due to the speed of the memory controller.
For most schemes we report minimum, maximum, and average cycle counts of 100 executions.
For schemes with no cycle count variation we only did 10 executions. 
For some particularly slow schemes we reduce the number of executions; the number of
executions is reported in parentheses.

The following numbers were obtained with `arm-none-eabi-gcc 8.2.0` and libopencm3
[@8b1ac58](https://github.com/libopencm3/libopencm3/commit/8b1ac585dfd6eb13938f2090bff6a78b836a0452)


### Speed Evaluation
#### Key Encapsulation Schemes
*TODO*
#### Signature Schemes
*TODO*
### Memory Evaluation
#### Key Encapsulation Schemes
*TODO*
#### Signature Schemes
*TODO*

## Adding new schemes and implementations
The **pqm4** build system is designed to make it very easy to add new schemes
and implementations, if these implementations follow the NIST/SUPERCOP API. 
In the following we consider the example of adding the reference implementation
of [NewHope-512-CPA-KEM](https://newhopecrypto.org) to **pqm4**:

1. Create a subdirectory for the new scheme under `crypto_kem/`; in the following we assume that this subdirectory is called `newhope512cpa`.
1. Create a subdirectory `ref` under `crypto_kem/newhope512cpa/`.
1. Copy all files of the reference implementation into this new subdirectory `crypto_kem/newhope512cpa/ref/`,
   except for the file implementing the `randombytes` function (typically `PQCgenKAT_kem.c`).
1. In the subdirectory `crypto_kem/newhope512cpa/ref/` write a Makefile with default target `libpqm4.a`.
   For our example, this Makefile could look as follows:
   
   ```Makefile
   CC      = arm-none-eabi-gcc
   CFLAGS  = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
   AR      = arm-none-eabi-gcc-ar 
   
   OBJECTS = cpapke.o kem.o ntt.o poly.o precomp.o reduce.o verify.o
   HEADERS = api.h cpapke.h ntt.h params.h poly.h reduce.h verify.h 

   libpqm4.a: $(OBJECTS)
     $(AR) rcs $@ $(OBJECTS)

   %.o: %.c $(HEADERS)
     $(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<
   ```
   
   Note that this setup easily allows each implementation of each scheme to be built with
   different compiler flags. Also note the `-I$(INCPATH)` flag. The variable `$(INCPATH)`
   is provided externally from the **pqm4** build system and provides access to header files
   defining the `randombytes` function and FIPS202 (Keccak) functions (see below).
1. If the implementation added is a pure C implementation that can also run on the host,
   then add an additional target called `libpqhost.a`to the Makefile, for example as follows:
   
   ```Makefile
   CC_HOST      = gcc
   CFLAGS_HOST  = -Wall -Wextra -O3
   AR_HOST      = gcc-ar
   OBJECTS_HOST = $(patsubst %.o,%_host.o,$(OBJECTS))
   
   libpqhost.a: $(OBJECTS_HOST)
     $(AR_HOST) rcs $@ $(OBJECTS_HOST)
   
   %_host.o: %.c $(HEADERS)
     $(CC_HOST) -I$(INCPATH) $(CFLAGS_HOST) -c -o $@ $<
   ```
   
1. For some schemes you may have a *reference* implementation that exceeds the resource limits
   of the STM32F4 Discovery board. This reference implementation is still useful for **pqm4**,
   because it can run on the host to generate test vectors for comparison. 
   If the implementation you're adding is such a host-side-only reference implementation, place
   a file called `.m4ignore` in the subdirectory containing the implementation.
   In that case the Makefile is not required to contain the `libpqm4` target.

The procedure for adding a signature scheme is the same, except that it starts with creating a
new subdirectory under `crypto_sign/`.

### Using optimized FIPS202 (Keccak, SHA3, SHAKE)
   Many schemes submitted to NIST use SHA-3, SHAKE or cSHAKE for hashing. 
   This is why **pqm4** comes with highly optimized Keccak code that is accessible
   from all KEM and signature implementations. 
   Functions from the FIPS202 standard (and related publication SP 800-185) are defined in `common/fips202.h` as follows:
   ```c
  void shake128_absorb(uint64_t *state, const unsigned char *input, unsigned int inlen);
  void shake128_squeezeblocks(unsigned char *output, unsigned long long nblocks, uint64_t *state);
  void shake128(unsigned char *output, unsigned long long outlen, const unsigned char *input,  unsigned long long inlen);

  void cshake128_simple_absorb(uint64_t *state, uint16_t cstm, const unsigned char *in, unsigned long long inlen);
  void cshake128_simple_squeezeblocks(unsigned char *output, unsigned long long nblocks, uint64_t *state);
  void cshake128_simple(unsigned char *output, unsigned long long outlen, uint16_t cstm, const unsigned char *in, unsigned long long inlen);

  void shake256_absorb(uint64_t *state, const unsigned char *input, unsigned int inlen);
  void shake256_squeezeblocks(unsigned char *output, unsigned long long nblocks, uint64_t *state);
  void shake256(unsigned char *output, unsigned long long outlen, const unsigned char *input,  unsigned long long inlen);

  void cshake256_simple_absorb(uint64_t *state, uint16_t cstm, const unsigned char *in, unsigned long long inlen);
  void cshake256_simple_squeezeblocks(unsigned char *output, unsigned long long nblocks, uint64_t *state);
  void cshake256_simple(unsigned char *output, unsigned long long outlen, uint16_t cstm, const unsigned char *in, unsigned long long inlen);

  void sha3_256(unsigned char *output, const unsigned char *input,  unsigned long long inlen);
  void sha3_512(unsigned char *output, const unsigned char *input,  unsigned long long inlen);
   ```
   Implementations that want to make use of these optimized routines simply include 
   `fips202.h`. The API for `sha3_256` and `sha3_512` follows the 
   [SUPERCOP hash API](http://bench.cr.yp.to/call-hash.html).
   The API for `shake256` and `shake512` is very similar, except that it supports variable-length output.
   The SHAKE and cSHAKE functions are also accessible via the absorb-squeezeblocks functions, which offer incremental
   output generation (but not incremental input handling).

## Using optimized SHA384 and SHA512

  Some schemes submitted to NIST make use of SHA384 or SHA512 for hashing.
  We've experimented with assembly-optimized SHA512, but found that the speed-up
  achievable with this compared to the C implementation from
  [SUPERCOP](http://bench.cr.yp.to/) is negligible
  when compiled using `arm-none-eabi-gcc-8.2.0`.
  For older compiler versions (e.g. `5.4.1`) hand-optimized assembly implementations
  were significantly faster.
  We've therefore decided to only include a C version of SHA384 and SHA512.
  The available functions are:
   ```c
  int sha384(unsigned char *output, const unsigned char *input, unsigned long long inlen);
  int sha512(unsigned char *output, const unsigned char *input, unsigned long long inlen);
   ```
  Implementations can make use of this by including `sha2.h`.

## Bibliography

When referring to this framework in academic literature, please consider using the following bibTeX excerpt:

```
@misc{PQM4,
  title = {{PQM4}: Post-quantum crypto library for the {ARM} {Cortex-M4}},
  author = {Matthias J. Kannwischer and Joost Rijneveld and Peter Schwabe and Ko Stoffelen},
  note = {\url{https://github.com/mupq/pqm4}}
}
```

## License
Different parts of **pqm4** have different licenses. Specifically,
* the files under `common/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files under `crypto_kem/frodo640-aes/` are under [MIT License](https://raw.githubusercontent.com/Microsoft/PQCrypto-LWEKE/master/LICENSE);
* the files under `crypto_kem/frodo640-cshake/` are under [MIT License](https://raw.githubusercontent.com/Microsoft/PQCrypto-LWEKE/master/LICENSE);
* the files under `crypto_kem/kindi/` are covered by the corresponding [IP statements submitted to NIST](https://csrc.nist.gov/CSRC/media/Projects/Post-Quantum-Cryptography/documents/round-1/ip-statements/Kindi-Statements.pdf);
* the files under `crypto_kem/kyber512/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files under `crypto_kem/kyber768/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files under `crypto_kem/kyber1024/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files under `crypto_kem/newhope1024cca/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files under `crypto_kem/ntruhrss701/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files under `crypto_kem/ntru-kem-743/` are in the [public domain](https://raw.githubusercontent.com/NTRUOpenSourceProject/ntru-crypto/master/LICENSE.md);
* the files under `crypto_kem/rlizard-1024-11/` are covered by the corresponding [IP statements submitted to NIST](https://csrc.nist.gov/CSRC/media/Projects/Post-Quantum-Cryptography/documents/round-1/ip-statements/Lizard-Statements.pdf);
* the files under `crypto_kem/saber/` are in the [public domain](https://eprint.iacr.org/2018/682.pdf);
* the files under `crypto_kem/sikep751/` are under [MIT License](https://raw.githubusercontent.com/Microsoft/PQCrypto-SIKE/master/LICENSE);
* the files under `crypto_kem/sntrup4591761/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files under `crypto_sign/dilithium/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files under `crypto_sign/qTesla-I/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files under `crypto_sign/qTesla-III-size/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files under `crypto_sign/qTesla-III-speed/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files under `crypto_sign/sphincs-shake256-128s/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files under `hostside/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files under the submodule directory `libopencm3/` are under [LGPL3](https://raw.githubusercontent.com/libopencm3/libopencm3/master/COPYING.LGPL3);
* the files `speed.c`, `stack.c`, `test.c`, `testvectors.c`, and `testvectors-host.c` in `crypto_kem/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/);
* the files `speed.c`, `stack.c`, `test.c`, `testvectors.c`, and `testvectors-host.c` in `crypto_sign/` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/); and
* the files `benchmarks.py`, `benchmarks_to_md.py`, `Makefile`, `README.md`, `test.py`, `testvectors.py`, and `utils.py` are in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/).
