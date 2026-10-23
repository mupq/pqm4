# Hashing Evaluation: ml-kem

- Commit: `b6ec2a12f00d2aff83b77d21b37f8777499c1a91` (mupq `0c40d571eac6876bef256b564ce760def433e805`)
- Date: Fri Oct 23 00:17:44 EDT 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO
- Clock: 20 MHz (`CLOCK_BENCHMARK`)
- Iterations: 100

## Key Encapsulation Schemes

| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| ml-kem-1024 | clean | 50.6% | 45.7% | 38.9% |
| ml-kem-1024 | m4fspeed | 75.3% | 75.5% | 71.3% |
| ml-kem-1024 | m4fstack | 75.1% | 74.9% | 70.7% |
| ml-kem-512 | clean | 50.9% | 41.5% | 32.9% |
| ml-kem-512 | m4fspeed | 75.6% | 73.8% | 67.6% |
| ml-kem-512 | m4fstack | 75.6% | 73.5% | 67.3% |
| ml-kem-768 | clean | 49.2% | 43.2% | 35.6% |
| ml-kem-768 | m4fspeed | 74.5% | 74.7% | 69.6% |
| ml-kem-768 | m4fstack | 74.4% | 74.1% | 69.1% |

## Reproducing

```sh
git clone --recursive https://github.com/mupq/pqm4.git && cd pqm4
git checkout b6ec2a12f00d2aff83b77d21b37f8777499c1a91
git submodule update --init --recursive
python3 -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt
# selects the probe of the board measured here, for setups with several boards attached
export MUPQ_OPENOCD_SERIAL=066BFF575550897767144107
# the serial port of that board on the measuring host
UART=/dev/tty.usbmodem1103
rm -rf obj elf bin bin-host benchmarks
# writes the raw results to benchmarks/hashing/
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 100 --nospeed --nostack --nosize ml-kem-512 ml-kem-768 ml-kem-1024
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/ml-kem/hashing/converted.md
python3 results/record.py hashing benchmarks/converted.md results/runs/ml-kem/hashing/converted.md ml-kem-512 ml-kem-768 ml-kem-1024
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
