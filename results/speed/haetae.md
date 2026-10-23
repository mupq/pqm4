# Speed Evaluation: haetae

- Commit: `b6ec2a12f00d2aff83b77d21b37f8777499c1a91` (mupq `0c40d571eac6876bef256b564ce760def433e805`)
- Date: Fri Oct 23 00:55:06 EDT 2026
- Platform: `nucleo-l4r5zi`
- Toolchain: arm-none-eabi-gcc (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627
- Build: `--opt speed` (`-O3 -g3`), each implementation compiled as one translation unit (`AIO=1`), no LTO
- Clock: 20 MHz (`CLOCK_BENCHMARK`)
- Iterations: 100

## Signature Schemes

| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| haetae2 (100 executions) | m4f | AVG: 5,061,784 <br /> MIN: 903,681 <br /> MAX: 20,333,396 | AVG: 38,018,344 <br /> MIN: 6,618,562 <br /> MAX: 177,197,020 | AVG: 838,410 <br /> MIN: 838,201 <br /> MAX: 838,661 |
| haetae2 (100 executions) | m4fstack | AVG: 15,019,222 <br /> MIN: 1,206,393 <br /> MAX: 82,389,318 | AVG: 145,448,001 <br /> MIN: 39,743,019 <br /> MAX: 744,912,495 | AVG: 852,905 <br /> MIN: 852,709 <br /> MAX: 853,130 |
| haetae2 (100 executions) | ref | AVG: 8,485,602 <br /> MIN: 1,224,643 <br /> MAX: 52,050,259 | AVG: 58,469,168 <br /> MIN: 11,254,907 <br /> MAX: 280,111,107 | AVG: 1,090,269 <br /> MIN: 1,090,024 <br /> MAX: 1,090,485 |
| haetae3 (100 executions) | m4f | AVG: 9,422,127 <br /> MIN: 1,702,480 <br /> MAX: 41,008,150 | AVG: 47,398,513 <br /> MIN: 10,217,665 <br /> MAX: 372,684,999 | AVG: 1,581,201 <br /> MIN: 1,580,858 <br /> MAX: 1,581,513 |
| haetae3 (100 executions) | m4fstack | AVG: 23,509,509 <br /> MIN: 2,320,267 <br /> MAX: 182,350,386 | AVG: 202,778,050 <br /> MIN: 74,640,779 <br /> MAX: 1,118,208,588 | AVG: 1,713,104 <br /> MIN: 1,712,784 <br /> MAX: 1,713,595 |
| haetae3 (100 executions) | ref | AVG: 14,002,440 <br /> MIN: 2,232,802 <br /> MAX: 86,488,399 | AVG: 79,252,075 <br /> MIN: 17,206,732 <br /> MAX: 265,692,302 | AVG: 1,966,599 <br /> MIN: 1,966,281 <br /> MAX: 1,966,997 |
| haetae5 (100 executions) | m4f | AVG: 10,655,084 <br /> MIN: 2,205,272 <br /> MAX: 41,193,015 | AVG: 72,212,456 <br /> MIN: 12,631,669 <br /> MAX: 338,132,597 | AVG: 2,053,876 <br /> MIN: 2,053,527 <br /> MAX: 2,054,253 |
| haetae5 (100 executions) | m4fstack | AVG: 13,149,587 <br /> MIN: 3,189,871 <br /> MAX: 65,365,911 | AVG: 321,326,924 <br /> MIN: 96,670,507 <br /> MAX: 1,421,080,284 | AVG: 2,208,187 <br /> MIN: 2,207,614 <br /> MAX: 2,208,576 |
| haetae5 (100 executions) | ref | AVG: 12,661,926 <br /> MIN: 2,883,213 <br /> MAX: 50,300,472 | AVG: 100,559,058 <br /> MIN: 21,074,017 <br /> MAX: 344,712,605 | AVG: 2,429,293 <br /> MIN: 2,428,986 <br /> MAX: 2,429,757 |

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
python3 benchmarks.py -p nucleo-l4r5zi -u "$UART" -i 100 --nostack --nohashing --nosize haetae2 haetae3 haetae5
# reads benchmarks/, writes benchmarks/converted.md
python3 convert_benchmarks.py md > benchmarks/converted.md
# reads benchmarks/converted.md, writes results/runs/haetae/speed/converted.md
python3 results/record.py speed benchmarks/converted.md results/runs/haetae/speed/converted.md haetae2 haetae3 haetae5
# reads results/runs/, writes summary.md and the family pages under results/
python3 results/build.py results/runs results
```
