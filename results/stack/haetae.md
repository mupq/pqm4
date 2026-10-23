# Memory Evaluation: haetae

- Commit: `5b20c72c14568ba469b4ada7711bdd93a5aae8f6` (mupq `0c40d571eac6876bef256b564ce760def433e805`)
- Date: Fri Oct 23 00:04:25 EDT 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO
- Iterations: 1

## Signature Schemes

| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| haetae2 | m4f | 25,160 | 51,984 | 38,120 |
| haetae2 | m4fstack | 4,896 | 5,984 | 4,824 |
| haetae2 | ref | 24,192 | 85,784 | 38,168 |
| haetae3 | m4f | 42,504 | 78,000 | 60,944 |
| haetae3 | m4fstack | 4,944 | 6,160 | 4,968 |
| haetae3 | ref | 41,600 | 129,208 | 60,992 |
| haetae5 | m4f | 53,752 | 99,864 | 76,576 |
| haetae5 | m4fstack | 3,800 | 6,152 | 4,856 |
| haetae5 | ref | 52,756 | 162,296 | 76,728 |

## Reproducing

```sh
git clone --recursive https://github.com/mupq/pqm4.git && cd pqm4
git checkout 5b20c72c14568ba469b4ada7711bdd93a5aae8f6
git submodule update --init --recursive
python3 -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt
# selects the probe of the board measured here, for setups with several boards attached
export MUPQ_OPENOCD_SERIAL=066BFF575550897767144107
# the serial port of that board on the measuring host
UART=/dev/tty.usbmodem1103
rm -rf obj elf bin bin-host benchmarks
# writes the raw results to benchmarks/stack/
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 1 --nospeed --nohashing --nosize haetae2 haetae3 haetae5
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/haetae/stack/converted.md
python3 results/record.py stack benchmarks/converted.md results/runs/haetae/stack/converted.md haetae2 haetae3 haetae5
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
