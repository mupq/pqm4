# Hashing Evaluation: ml-dsa

- Commit: `b6ec2a12f00d2aff83b77d21b37f8777499c1a91` (mupq `0c40d571eac6876bef256b564ce760def433e805`)
- Date: Fri Oct 23 00:37:19 EDT 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO
- Clock: 20 MHz (`CLOCK_BENCHMARK`)
- Iterations: 100

## Signature Schemes

| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| ml-dsa-44 | clean | 63.7% | 33.8% | 55.9% |
| ml-dsa-44 | m4f | 80.1% | 60.8% | 76.7% |
| ml-dsa-44 | m4fstack | 75.3% | 55.0% | 40.6% |
| ml-dsa-65 | clean | 67.1% | 33.3% | 59.7% |
| ml-dsa-65 | m4f | 82.1% | 60.9% | 79.2% |
| ml-dsa-65 | m4fstack | 76.7% | 55.0% | 40.7% |
| ml-dsa-87 | clean | 69.4% | 39.1% | 63.9% |
| ml-dsa-87 | m4f | 83.6% | 64.2% | 81.6% |
| ml-dsa-87 | m4fstack | 76.4% | 54.4% | 42.4% |

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
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 100 --nospeed --nostack --nosize ml-dsa-44 ml-dsa-65 ml-dsa-87
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/ml-dsa/hashing/converted.md
python3 results/record.py hashing benchmarks/converted.md results/runs/ml-dsa/hashing/converted.md ml-dsa-44 ml-dsa-65 ml-dsa-87
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
