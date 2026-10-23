# Size Evaluation: haetae

- Commit: `5b20c72c14568ba469b4ada7711bdd93a5aae8f6` (mupq `0c40d571eac6876bef256b564ce760def433e805`)
- Date: Fri Oct 23 00:05:31 EDT 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO

## Signature Schemes

| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| haetae2 | m4f | 32,716 | 0 | 0 | 32,716 |
| haetae2 | m4fstack | 32,600 | 0 | 0 | 32,600 |
| haetae2 | ref | 25,280 | 0 | 0 | 25,280 |
| haetae3 | m4f | 32,672 | 0 | 0 | 32,672 |
| haetae3 | m4fstack | 33,160 | 0 | 0 | 33,160 |
| haetae3 | ref | 25,376 | 0 | 0 | 25,376 |
| haetae5 | m4f | 32,736 | 0 | 0 | 32,736 |
| haetae5 | m4fstack | 32,568 | 0 | 0 | 32,568 |
| haetae5 | ref | 25,520 | 0 | 0 | 25,520 |

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
# writes the raw results to benchmarks/size/
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 1 --nospeed --nostack --nohashing haetae2 haetae3 haetae5
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/haetae/size/converted.md
python3 results/record.py size benchmarks/converted.md results/runs/haetae/size/converted.md haetae2 haetae3 haetae5
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
