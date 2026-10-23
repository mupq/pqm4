# Hashing Evaluation: haetae

- Commit: `b6ec2a12f00d2aff83b77d21b37f8777499c1a91` (mupq `0c40d571eac6876bef256b564ce760def433e805`)
- Date: Fri Oct 23 02:35:28 EDT 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO
- Clock: 20 MHz (`CLOCK_BENCHMARK`)
- Iterations: 100

## Signature Schemes

| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| haetae2 | m4f | 24.7% | 56.9% | 59.3% |
| haetae2 | m4fstack | 40.8% | 49.2% | 58.3% |
| haetae2 | ref | 16.5% | 32.8% | 45.7% |
| haetae3 | m4f | 27.4% | 57.1% | 63.5% |
| haetae3 | m4fstack | 46.5% | 48.7% | 58.7% |
| haetae3 | ref | 17.5% | 33.0% | 51.1% |
| haetae5 | m4f | 31.8% | 57.0% | 65.0% |
| haetae5 | m4fstack | 28.0% | 50.7% | 60.5% |
| haetae5 | ref | 24.0% | 33.2% | 55.0% |

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
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 100 --nospeed --nostack --nosize haetae2 haetae3 haetae5
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/haetae/hashing/converted.md
python3 results/record.py hashing benchmarks/converted.md results/runs/haetae/hashing/converted.md haetae2 haetae3 haetae5
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
