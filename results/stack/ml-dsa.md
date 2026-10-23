# Memory Evaluation: ml-dsa

- Commit: `481b2e305cbd537079ea6855c27b3579074b59d4` (mupq `c6f6403d45aad76e5f682b4465ff41a9e84a33e4`)
- Date: Thu Oct 22 23:26:46 EDT 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO
- Iterations: 1

## Signature Schemes

| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| ml-dsa-44 | clean | 38,304 | 51,976 | 36,304 |
| ml-dsa-44 | m4f | 38,296 | 44,816 | 8,912 |
| ml-dsa-44 | m4fstack | 4,408 | 5,072 | 2,712 |
| ml-dsa-65 | clean | 60,832 | 79,624 | 57,736 |
| ml-dsa-65 | m4f | 60,824 | 68,872 | 9,888 |
| ml-dsa-65 | m4fstack | 4,408 | 6,608 | 2,712 |
| ml-dsa-87 | clean | 97,696 | 122,736 | 92,840 |
| ml-dsa-87 | m4f | 97,688 | 107,888 | 12,056 |
| ml-dsa-87 | m4fstack | 4,408 | 8,144 | 2,720 |

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
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 1 --nospeed --nohashing --nosize ml-dsa-44 ml-dsa-65 ml-dsa-87
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/ml-dsa/stack/converted.md
python3 results/record.py stack benchmarks/converted.md results/runs/ml-dsa/stack/converted.md ml-dsa-44 ml-dsa-65 ml-dsa-87
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
