# Memory Evaluation: ml-kem

- Commit: `481b2e305cbd537079ea6855c27b3579074b59d4` (mupq `c6f6403d45aad76e5f682b4465ff41a9e84a33e4`)
- Date: Thu Oct 22 23:26:05 EDT 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO
- Iterations: 1

## Key Encapsulation Schemes

| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| ml-kem-1024 | clean | 15,124 | 18,772 | 20,348 |
| ml-kem-1024 | m4fspeed | 6,436 | 7,500 | 7,484 |
| ml-kem-1024 | m4fstack | 3,332 | 3,372 | 3,356 |
| ml-kem-512 | clean | 6,160 | 8,792 | 9,568 |
| ml-kem-512 | m4fspeed | 4,364 | 5,428 | 5,404 |
| ml-kem-512 | m4fstack | 2,308 | 2,348 | 2,332 |
| ml-kem-768 | clean | 10,256 | 13,392 | 14,488 |
| ml-kem-768 | m4fspeed | 5,404 | 6,468 | 6,452 |
| ml-kem-768 | m4fstack | 2,820 | 2,860 | 2,844 |

## Reproducing

```sh
git clone --recursive https://github.com/mupq/pqm4.git && cd pqm4
git checkout 481b2e305cbd537079ea6855c27b3579074b59d4
git submodule update --init --recursive
python3 -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt
# selects the probe of the board measured here, for setups with several boards attached
export MUPQ_OPENOCD_SERIAL=066BFF575550897767144107
# the serial port of that board on the measuring host
UART=/dev/tty.usbmodem1103
rm -rf obj elf bin bin-host benchmarks
# writes the raw results to benchmarks/stack/
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 1 --nospeed --nohashing --nosize ml-kem-512 ml-kem-768 ml-kem-1024
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/ml-kem/stack/converted.md
python3 results/record.py stack benchmarks/converted.md results/runs/ml-kem/stack/converted.md ml-kem-512 ml-kem-768 ml-kem-1024
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
