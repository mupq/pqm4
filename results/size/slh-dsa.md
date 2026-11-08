# Size Evaluation: slh-dsa

- Commit: `7a629261b9cb0c463ff4907255b092a6e2ff4ec4` (mupq `d0d561ccbb20f419e94fc6a95c2b2a05ae35c9b5`)
- Date: Sun Nov  8 09:54:36 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO

## Signature Schemes

| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| slh-dsa-sha2-128f | ref | 6,108 | 0 | 0 | 6,108 |
| slh-dsa-sha2-128s | ref | 6,444 | 0 | 0 | 6,444 |
| slh-dsa-sha2-192f | ref | 6,260 | 0 | 0 | 6,260 |
| slh-dsa-sha2-192s | ref | 6,864 | 0 | 0 | 6,864 |
| slh-dsa-sha2-256f | ref | 6,748 | 0 | 0 | 6,748 |
| slh-dsa-sha2-256s | ref | 7,048 | 0 | 0 | 7,048 |
| slh-dsa-shake-128f | ref | 4,868 | 0 | 0 | 4,868 |
| slh-dsa-shake-128s | ref | 5,216 | 0 | 0 | 5,216 |
| slh-dsa-shake-192f | ref | 5,108 | 0 | 0 | 5,108 |
| slh-dsa-shake-192s | ref | 5,672 | 0 | 0 | 5,672 |
| slh-dsa-shake-256f | ref | 5,556 | 0 | 0 | 5,556 |
| slh-dsa-shake-256s | ref | 5,852 | 0 | 0 | 5,852 |

## Reproducing

```sh
git clone --recursive https://github.com/mupq/pqm4.git && cd pqm4
git checkout 7a629261b9cb0c463ff4907255b092a6e2ff4ec4
git submodule update --init --recursive
python3 -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt
# selects the probe of the board measured here, for setups with several boards attached
export MUPQ_OPENOCD_SERIAL=066BFF575550897767144107
# the serial port of that board on the measuring host
UART=/dev/tty.usbmodem1303
rm -rf obj elf bin bin-host benchmarks
# writes the raw results to benchmarks/size/
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 1 --nospeed --nostack --nohashing slh-dsa-sha2-128f slh-dsa-sha2-128s slh-dsa-sha2-192f slh-dsa-sha2-192s slh-dsa-sha2-256f slh-dsa-sha2-256s slh-dsa-shake-128f slh-dsa-shake-128s slh-dsa-shake-192f slh-dsa-shake-192s slh-dsa-shake-256f slh-dsa-shake-256s
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/slh-dsa/size/converted.md
python3 results/record.py size benchmarks/converted.md results/runs/slh-dsa/size/converted.md slh-dsa-sha2-128f slh-dsa-sha2-128s slh-dsa-sha2-192f slh-dsa-sha2-192s slh-dsa-sha2-256f slh-dsa-sha2-256s slh-dsa-shake-128f slh-dsa-shake-128s slh-dsa-shake-192f slh-dsa-shake-192s slh-dsa-shake-256f slh-dsa-shake-256s
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
