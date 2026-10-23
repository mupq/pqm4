# Hashing Evaluation: ml-kem

- Commit: `c6f0607846c47cdd0533c5fc9c9f6a2f37243e69` (mupq `3bce0c95e9ae11d97daa7285f84bf2e1a90ad451`)
- Date: Thu Oct 22 13:55:48 EDT 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO
- Clock: 20 MHz (`CLOCK_BENCHMARK`)
- Iterations: 10

## Key Encapsulation Schemes

| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| ml-kem-1024 | clean | 50.6% | 45.7% | 38.9% |
| ml-kem-1024 | m4fspeed | 75.3% | 75.5% | 71.2% |
| ml-kem-1024 | m4fstack | 75.1% | 75.0% | 70.7% |
| ml-kem-512 | clean | 51.0% | 41.5% | 32.9% |
| ml-kem-512 | m4fspeed | 75.6% | 73.8% | 67.5% |
| ml-kem-512 | m4fstack | 75.6% | 73.5% | 67.3% |
| ml-kem-768 | clean | 49.2% | 43.3% | 35.7% |
| ml-kem-768 | m4fspeed | 74.5% | 74.6% | 69.5% |
| ml-kem-768 | m4fstack | 74.5% | 74.2% | 69.1% |

## Reproducing

```sh
git clone --recursive https://github.com/mupq/pqm4.git && cd pqm4
git checkout c6f0607846c47cdd0533c5fc9c9f6a2f37243e69
git submodule update --init --recursive
python3 -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt
# finds the serial port of the board, ttyACM on Linux and tty.usbmodem on macOS
UART=$(find /dev -maxdepth 1 \( -name 'ttyACM*' -o -name 'tty.usbmodem*' \) | head -n 1)
rm -rf obj elf bin bin-host benchmarks
# writes the raw results to benchmarks/hashing/
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 10 --nospeed --nostack --nosize ml-kem-512 ml-kem-768 ml-kem-1024
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/ml-kem/hashing/converted.md
python3 results/record.py hashing benchmarks/converted.md results/runs/ml-kem/hashing/converted.md ml-kem-512 ml-kem-768 ml-kem-1024
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
