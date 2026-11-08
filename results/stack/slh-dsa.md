# Memory Evaluation: slh-dsa

- Commit: `7a629261b9cb0c463ff4907255b092a6e2ff4ec4` (mupq `d0d561ccbb20f419e94fc6a95c2b2a05ae35c9b5`)
- Date: Sun Nov  8 09:55:24 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO
- Iterations: 1

## Signature Schemes

| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| slh-dsa-sha2-128f | ref | 2,864 | 2,736 | 3,016 |
| slh-dsa-sha2-128s | ref | 3,088 | 2,824 | 2,320 |
| slh-dsa-sha2-192f | ref | 5,460 | 4,600 | 4,692 |
| slh-dsa-sha2-192s | ref | 5,784 | 4,736 | 4,036 |
| slh-dsa-sha2-256f | ref | 8,452 | 6,608 | 6,316 |
| slh-dsa-sha2-256s | ref | 8,744 | 6,736 | 5,916 |
| slh-dsa-shake-128f | ref | 2,768 | 2,712 | 2,920 |
| slh-dsa-shake-128s | ref | 2,992 | 2,800 | 2,224 |
| slh-dsa-shake-192f | ref | 4,936 | 4,144 | 4,168 |
| slh-dsa-shake-192s | ref | 5,256 | 4,280 | 3,512 |
| slh-dsa-shake-256f | ref | 7,936 | 6,160 | 5,800 |
| slh-dsa-shake-256s | ref | 8,224 | 6,288 | 5,504 |

## Reproducing

```sh
git clone --recursive https://github.com/mupq/pqm4.git && cd pqm4
git checkout 7a629261b9cb0c463ff4907255b092a6e2ff4ec4
git submodule update --init --recursive
python3 -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt
# this run used two boards in parallel, each from its own checkout at the same commit
# with one board, run both benchmarks.py steps below on it, one after the other
rm -rf obj elf bin bin-host benchmarks
# selects the probe of the first board, for setups with several boards attached
export MUPQ_OPENOCD_SERIAL=066BFF575550897767144107
# the serial port of that board on the measuring host
UART=/dev/tty.usbmodem1303
# writes the raw results of six parameter sets to benchmarks/stack/
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 1 --nospeed --nohashing --nosize slh-dsa-sha2-128f slh-dsa-sha2-256f slh-dsa-shake-192f slh-dsa-sha2-192s slh-dsa-sha2-256s slh-dsa-shake-192s
# selects the probe of the second board
export MUPQ_OPENOCD_SERIAL=066EFF363732594D43255352
# the serial port of that board on the measuring host
UART=/dev/tty.usbmodem1103
# writes the raw results of the other six parameter sets to benchmarks/stack/
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 1 --nospeed --nohashing --nosize slh-dsa-sha2-192f slh-dsa-shake-128f slh-dsa-shake-256f slh-dsa-sha2-128s slh-dsa-shake-128s slh-dsa-shake-256s
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/slh-dsa/stack/converted.md
python3 results/record.py stack benchmarks/converted.md results/runs/slh-dsa/stack/converted.md slh-dsa-sha2-128f slh-dsa-sha2-128s slh-dsa-sha2-192f slh-dsa-sha2-192s slh-dsa-sha2-256f slh-dsa-sha2-256s slh-dsa-shake-128f slh-dsa-shake-128s slh-dsa-shake-192f slh-dsa-shake-192s slh-dsa-shake-256f slh-dsa-shake-256s
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
