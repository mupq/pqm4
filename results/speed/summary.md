# Speed Evaluation (reproduced)
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
