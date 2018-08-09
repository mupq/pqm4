## r5nd\_tiny

A small and fast C language implementation of the Round5 quantum resistant
public key encryption algorithm ring variants.

---


This code originally developed for embedded targets but it has excellent 
performance on higher-end systems as well. This is the implementation 
reported in the paper [*"Shorter Messages and Faster Post-Quantum Encryption 
with Round5 on Cortex M"*](https://round5.org/doc/r5m4text.pdf), which is
also [IACR ePrint 2018/723](https://eprint.iacr.org/2018/723).

Even though that paper focuses on the NIST Category 3 versions 
R5ND\_3KEM and R5ND\_3PKE, this implementation actually supports all six 
ring variants. 

| **Parameter** | **R5ND\_1KEM** | **R5ND\_3KEM** | **R5ND\_5KEM** | **R5ND\_1PKE** | **R5ND\_3PKE** | **R5ND\_5PKE** |
| ------------- | :------------: | :------------: | :------------: | :------------: | :------------: | :------------: |
| Shared Secret | 128 bit        | 192 bit        | 256 bit        | 128 bit        | 192 bit        | 256 bit        |
| Public key    | 538 B          | 780 B          | 1050 B         | 562 B          | 810 B          | 1140 B         |
| Secret key    | 16 B           | 24 B           | 32 B           | 594 B          | 858 B          | 1204 B         |
| Ciphertext    | 632 B          | 904 B          | 1207 B         | 672 B          | 1032 B         | 1376 B         |
| Failure rate  | 2<sup>-76</sup> | 2<sup>-75</sup> | 2<sup>-64</sup> | 2<sup>-129</sup> | 2<sup>-128</sup> | 2<sup>-129</sup> |
| PQ Security	| 2<sup>117</sup> | 2<sup>176</sup> | 2<sup>242</sup> | 2<sup>120</sup> | 2<sup>181</sup> | 2<sup>246</sup> |
| Classical 	| 2<sup>128</sup> | 2<sup>193</sup> | 2<sup>257</sup> | 2<sup>128</sup> | 2<sup>193</sup> | 2<sup>256</sup> |
| Security Category  | CPA, NIST 1    | CPA, NIST 3    | CPA, NIST 5    | CCA, NIST 1    | CCA, NIST 3    | CCA, NIST 5    |

For Round5 security arguments and discussion about non-ring versions,
see the main paper [*"Round5: Compact and Fast Post-Quantum Public-Key 
Encryption"*](https://round5.org/doc/round5paper.pdf).

A Data Encapsulation Mechanism (DEM) is not included. You can use the 
implementations for public key encryption with an AEAD mode such as GCM or 
SIV  -- just derive the KEY (and IV) from the shared secret. This will add 
16 bytes (the authentication tag) to your message length, in addition to the 
"Ciphertext" number given in the table.

Note that Round5 also has non-ring variants. This is an early technology 
demonstrator, not a reference implementation. The current version is 
unlikely to be entirely compatible with the final Round5 specification.


### Comparison on Cortex M4

Round5 is currently the fastest post-quantum encryption algorithm in all
NIST security classes where it is implemented. It also has the shortest 
public keys and messages of any lattice-based NIST PQC candidates. The 
Isogeny-based proposal SIKE requires 15-35% less bytes for key establishment 
but is thousands of times slower, making it completely impractical for 
embedded devices.

Here is a simple engineering and security comparison for key establishment use 
case on Cortex M4. All of the compared algorithms are at NIST Category 3.

* **Xfer:** Total data transferred (public key + ciphertext), in bytes.
* **Time:** Time required for KeyGen() + Encaps() +  Decaps() on Cortex-M4 at 24 MHz. 
* **Code:** Size of implementation in bytes, excluding hash function and other common parts. 
* **Failure:** Decryption failure bound.
* **Post-Quantum:** Claimed quantum complexity.
* **Classical** Claimed classical complexity.

| **Algorithm** | **Xfer** | **Time** | **Code** | **Failure** | **Post-Quantum** | **Classical** |
| ------------- | :------: | :------: | :------: | :------: | :-----: | :------: |
| R5ND\_3KEM    | 1684 B   | 0.124 s  | 4464 B   | 2<sup>-75</sup>	| 2<sup>176</sup> | 2<sup>193</sup>	|
| R5ND\_3PKE    | 1842 B   | 0.169 s  | 5232 B   | 2<sup>-129</sup>	| 2<sup>181</sup> | 2<sup>193</sup>	| 
| Saber         | 2080 B   | 0.172 s  | ?        | 2<sup>-136</sup>	| 2<sup>180</sup> | 2<sup>198</sup>	| 
| Kyber-768     | 2240 B   | 0.210 s  | 7016  B  | 2<sup>-142</sup>	| 2<sup>161</sup> | 2<sup>178</sup>	|
| sntrup4591761 | 2265 B   | 8.718 s  | 71024 B  | 0                | -               | 2<sup>248</sup> |
| NTRU-HRSS17   | 2416 B   | 7.814 s  | 11956 B  | 0                | 2<sup>123</sup> | 2<sup>136</sup> |
| NewHope1024-CCA | 4032 B | 0.264 s  | 12912 B  | 2<sup>-216</sup>	| 2<sup>233</sup> | -	| 
| SIKEp751      | 1160 B   | 685.9 s  | 19112 B  | 0                | 2<sup>124</sup> | 2<sup>186</sup> |


### Code Structure

Most things are controlled by compiler macros (defines) -- you can set
these in `Makefile`, in environment variable `R5INC`, or statically, e.g., 
at top of `api.h`.

Choose exactly one of these (e.g. compile with `make R5INC=-DR5ND_3KEM`):

* `R5ND_1KEM`: CPA, NIST security category 1, parameter set
* `R5ND_3KEM`: CPA, NIST security category 3, parameter set
* `R5ND_5KEM`: CPA, NIST security category 5, parameter set
* `R5ND_1PKE`: CCA, NIST security category 1, parameter set
* `R5ND_3PKE`: CCA, NIST security category 3, parameter set
* `R5ND_5PKE`: CCA, NIST security category 5, parameter set

There is one additional flag:

* `CM_CACHE`: Enable cache timing attack countermeasures (drops speed to
about half). This is not relevant for cacheless embedded systems.

The flags affect call structure, which is as follows:
```
       External Caller          Uses NIST API (api.h)
         /         \
     kem_cca.c   kem_cpa.c      Depending on NOFO_CPA (set by KEM/PKE)
         \         /
          encrypt.c             Basic CPA functionality
         /         \
    ringmul.c  ringmul_cm.c     Depending on CM_CACHE
```

The make process produces a benchmarking executable `r5test`.


### Testing

You can run `./bench_all.sh` which will compile and benchmark all six variants. 
The result is written to `bench.txt`. It will also compare `CHK`-prefixed 
test vector checksums to known answers in `chk_kat_data.txt`.


### Big Small Print

See the `LICENCE` file for licence details. 

**ABSOLUTELY NO WARRANTY.**
The code was mainly written by Markku-Juhani O. Saarinen <mjos@mjos.fi>, 
who was also the main author of the paper. Bug reports can be directed to him.

**TECHNOLOGY DEMONSTRATOR -- EXPERIMENTAL RESEARCH CODE.**
This is not an official implementation of anything, or intended for
production use. All parameters and algorithm details are subject to change.

