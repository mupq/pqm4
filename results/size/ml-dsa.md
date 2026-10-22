# Size Evaluation: ml-dsa

- Commit: `c6f0607846c47cdd0533c5fc9c9f6a2f37243e69` (mupq `3bce0c95e9ae11d97daa7285f84bf2e1a90ad451`)
- Date: Thu Oct 22 13:58:23 EDT 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO

## Signature Schemes

| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| ml-dsa-44 | clean | 8,052 | 0 | 0 | 8,052 |
| ml-dsa-44 | m4f | 19,456 | 0 | 0 | 19,456 |
| ml-dsa-44 | m4fstack | 24,248 | 0 | 0 | 24,248 |
| ml-dsa-65 | clean | 7,664 | 0 | 0 | 7,664 |
| ml-dsa-65 | m4f | 19,060 | 0 | 0 | 19,060 |
| ml-dsa-65 | m4fstack | 23,632 | 0 | 0 | 23,632 |
| ml-dsa-87 | clean | 7,988 | 0 | 0 | 7,988 |
| ml-dsa-87 | m4f | 19,460 | 0 | 0 | 19,460 |
| ml-dsa-87 | m4fstack | 24,056 | 0 | 0 | 24,056 |

## Reproducing

```sh
git clone --recursive https://github.com/mupq/pqm4.git && cd pqm4
git checkout c6f0607846c47cdd0533c5fc9c9f6a2f37243e69
git submodule update --init --recursive
python3 -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt
# finds the serial port of the board, ttyACM on Linux and tty.usbmodem on macOS
UART=$(find /dev -maxdepth 1 \( -name 'ttyACM*' -o -name 'tty.usbmodem*' \) | head -n 1)
rm -rf obj elf bin bin-host benchmarks
# writes the raw results to benchmarks/size/
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 1 --nospeed --nostack --nohashing ml-dsa-44 ml-dsa-65 ml-dsa-87
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/ml-dsa/size/converted.md
python3 results/record.py size benchmarks/converted.md results/runs/ml-dsa/size/converted.md ml-dsa-44 ml-dsa-65 ml-dsa-87
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
