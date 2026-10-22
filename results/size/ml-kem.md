# Size Evaluation: ml-kem

- Commit: `c6f0607846c47cdd0533c5fc9c9f6a2f37243e69` (mupq `3bce0c95e9ae11d97daa7285f84bf2e1a90ad451`)
- Date: Thu Oct 22 13:57:29 EDT 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO

## Key Encapsulation Schemes

| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| ml-kem-1024 | clean | 6,040 | 0 | 0 | 6,040 |
| ml-kem-1024 | m4fspeed | 16,792 | 0 | 0 | 16,792 |
| ml-kem-1024 | m4fstack | 14,028 | 0 | 0 | 14,028 |
| ml-kem-512 | clean | 5,064 | 0 | 0 | 5,064 |
| ml-kem-512 | m4fspeed | 15,748 | 0 | 0 | 15,748 |
| ml-kem-512 | m4fstack | 13,224 | 0 | 0 | 13,224 |
| ml-kem-768 | clean | 4,956 | 0 | 0 | 4,956 |
| ml-kem-768 | m4fspeed | 15,756 | 0 | 0 | 15,756 |
| ml-kem-768 | m4fstack | 13,076 | 0 | 0 | 13,076 |

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
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 1 --nospeed --nostack --nohashing ml-kem-512 ml-kem-768 ml-kem-1024
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/ml-kem/size/converted.md
python3 results/record.py size benchmarks/converted.md results/runs/ml-kem/size/converted.md ml-kem-512 ml-kem-768 ml-kem-1024
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
