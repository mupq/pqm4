# Speed Evaluation: ml-kem

- Commit: `b6ec2a12f00d2aff83b77d21b37f8777499c1a91` (mupq `0c40d571eac6876bef256b564ce760def433e805`)
- Date: Fri Oct 23 00:14:49 EDT 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO
- Clock: 20 MHz (`CLOCK_BENCHMARK`)
- Iterations: 100

## Key Encapsulation Schemes

| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| ml-kem-1024 (100 executions) | clean | AVG: 1,517,067 <br /> MIN: 1,515,072 <br /> MAX: 1,548,853 | AVG: 1,705,691 <br /> MIN: 1,703,680 <br /> MAX: 1,737,510 | AVG: 2,007,443 <br /> MIN: 2,005,428 <br /> MAX: 2,039,291 |
| ml-kem-1024 (100 executions) | m4fspeed | AVG: 1,017,013 <br /> MIN: 1,014,573 <br /> MAX: 1,027,925 | AVG: 1,029,420 <br /> MIN: 1,026,989 <br /> MAX: 1,040,299 | AVG: 1,091,920 <br /> MIN: 1,089,489 <br /> MAX: 1,102,829 |
| ml-kem-1024 (100 executions) | m4fstack | AVG: 1,020,260 <br /> MIN: 1,017,644 <br /> MAX: 1,040,413 | AVG: 1,038,001 <br /> MIN: 1,035,409 <br /> MAX: 1,058,154 | AVG: 1,101,216 <br /> MIN: 1,098,597 <br /> MAX: 1,121,369 |
| ml-kem-512 (100 executions) | clean | AVG: 583,383 <br /> MIN: 582,847 <br /> MAX: 594,401 | AVG: 695,625 <br /> MIN: 695,089 <br /> MAX: 706,640 | AVG: 878,365 <br /> MIN: 877,830 <br /> MAX: 889,381 |
| ml-kem-512 (100 executions) | m4fspeed | AVG: 392,904 <br /> MIN: 391,714 <br /> MAX: 403,743 | AVG: 390,121 <br /> MIN: 388,912 <br /> MAX: 400,960 | AVG: 426,378 <br /> MIN: 425,170 <br /> MAX: 437,217 |
| ml-kem-512 (100 executions) | m4fstack | AVG: 392,413 <br /> MIN: 391,116 <br /> MAX: 403,022 | AVG: 391,815 <br /> MIN: 390,519 <br /> MAX: 402,425 | AVG: 428,123 <br /> MIN: 426,828 <br /> MAX: 438,733 |
| ml-kem-768 (100 executions) | clean | AVG: 972,920 <br /> MIN: 971,844 <br /> MAX: 994,562 | AVG: 1,133,175 <br /> MIN: 1,132,097 <br /> MAX: 1,154,819 | AVG: 1,374,860 <br /> MIN: 1,373,782 <br /> MAX: 1,396,504 |
| ml-kem-768 (100 executions) | m4fspeed | AVG: 640,783 <br /> MIN: 639,082 <br /> MAX: 650,963 | AVG: 655,155 <br /> MIN: 653,462 <br /> MAX: 665,380 | AVG: 702,887 <br /> MIN: 701,194 <br /> MAX: 713,081 |
| ml-kem-768 (100 executions) | m4fstack | AVG: 641,405 <br /> MIN: 639,760 <br /> MAX: 652,416 | AVG: 659,574 <br /> MIN: 657,930 <br /> MAX: 670,586 | AVG: 707,809 <br /> MIN: 706,166 <br /> MAX: 718,822 |

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
# writes the raw results to benchmarks/speed/
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 100 --nostack --nohashing --nosize ml-kem-512 ml-kem-768 ml-kem-1024
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/ml-kem/speed/converted.md
python3 results/record.py speed benchmarks/converted.md results/runs/ml-kem/speed/converted.md ml-kem-512 ml-kem-768 ml-kem-1024
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
