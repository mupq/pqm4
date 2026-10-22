# Speed Evaluation: ml-kem

- Commit: `c6f0607846c47cdd0533c5fc9c9f6a2f37243e69` (mupq `3bce0c95e9ae11d97daa7285f84bf2e1a90ad451`)
- Date: Thu Oct 22 13:54:50 EDT 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO
- Clock: 20 MHz (`CLOCK_BENCHMARK`)
- Iterations: 10

## Key Encapsulation Schemes

| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| ml-kem-1024 (10 executions) | clean | AVG: 1,515,462 <br /> MIN: 1,514,948 <br /> MAX: 1,515,898 | AVG: 1,704,063 <br /> MIN: 1,703,545 <br /> MAX: 1,704,510 | AVG: 2,005,820 <br /> MIN: 2,005,326 <br /> MAX: 2,006,257 |
| ml-kem-1024 (10 executions) | m4fspeed | AVG: 1,020,220 <br /> MIN: 1,015,344 <br /> MAX: 1,027,294 | AVG: 1,032,632 <br /> MIN: 1,027,772 <br /> MAX: 1,039,742 | AVG: 1,095,125 <br /> MIN: 1,090,265 <br /> MAX: 1,102,235 |
| ml-kem-1024 (10 executions) | m4fstack | AVG: 1,019,474 <br /> MIN: 1,017,932 <br /> MAX: 1,029,582 | AVG: 1,037,220 <br /> MIN: 1,035,674 <br /> MAX: 1,047,325 | AVG: 1,100,434 <br /> MIN: 1,098,889 <br /> MAX: 1,110,540 |
| ml-kem-512 (10 executions) | clean | AVG: 583,211 <br /> MIN: 583,026 <br /> MAX: 583,535 | AVG: 695,449 <br /> MIN: 695,264 <br /> MAX: 695,774 | AVG: 878,186 <br /> MIN: 878,000 <br /> MAX: 878,510 |
| ml-kem-512 (10 executions) | m4fspeed | AVG: 393,211 <br /> MIN: 391,735 <br /> MAX: 403,379 | AVG: 390,426 <br /> MIN: 388,950 <br /> MAX: 400,594 | AVG: 426,685 <br /> MIN: 425,209 <br /> MAX: 436,853 |
| ml-kem-512 (10 executions) | m4fstack | AVG: 391,765 <br /> MIN: 391,555 <br /> MAX: 391,929 | AVG: 391,161 <br /> MIN: 390,951 <br /> MAX: 391,325 | AVG: 427,465 <br /> MIN: 427,255 <br /> MAX: 427,629 |
| ml-kem-768 (10 executions) | clean | AVG: 972,292 <br /> MIN: 971,908 <br /> MAX: 972,806 | AVG: 1,132,541 <br /> MIN: 1,132,154 <br /> MAX: 1,133,056 | AVG: 1,374,228 <br /> MIN: 1,373,840 <br /> MAX: 1,374,742 |
| ml-kem-768 (10 executions) | m4fspeed | AVG: 639,674 <br /> MIN: 639,041 <br /> MAX: 640,072 | AVG: 654,024 <br /> MIN: 653,391 <br /> MAX: 654,434 | AVG: 701,758 <br /> MIN: 701,125 <br /> MAX: 702,168 |
| ml-kem-768 (10 executions) | m4fstack | AVG: 643,022 <br /> MIN: 640,435 <br /> MAX: 652,051 | AVG: 661,195 <br /> MIN: 658,609 <br /> MAX: 670,222 | AVG: 709,430 <br /> MIN: 706,846 <br /> MAX: 718,459 |

## Reproducing

```sh
git clone --recursive https://github.com/mupq/pqm4.git && cd pqm4
git checkout c6f0607846c47cdd0533c5fc9c9f6a2f37243e69
git submodule update --init --recursive
python3 -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt
# finds the serial port of the board, ttyACM on Linux and tty.usbmodem on macOS
UART=$(find /dev -maxdepth 1 \( -name 'ttyACM*' -o -name 'tty.usbmodem*' \) | head -n 1)
rm -rf obj elf bin bin-host benchmarks
# writes the raw results to benchmarks/speed/
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 10 --nostack --nohashing --nosize ml-kem-512 ml-kem-768 ml-kem-1024
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/ml-kem/speed/converted.md
python3 results/record.py speed benchmarks/converted.md results/runs/ml-kem/speed/converted.md ml-kem-512 ml-kem-768 ml-kem-1024
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
