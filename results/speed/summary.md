# Speed Evaluation (reproduced)
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
| ml-dsa-44 (100 executions) | clean | AVG: 1,794,242 <br /> MIN: 1,758,149 <br /> MAX: 1,834,091 | AVG: 7,492,483 <br /> MIN: 3,064,633 <br /> MAX: 29,188,755 | AVG: 1,951,884 <br /> MIN: 1,951,562 <br /> MAX: 1,952,292 |
| ml-dsa-44 (100 executions) | m4f | AVG: 1,420,177 <br /> MIN: 1,386,191 <br /> MAX: 1,451,394 | AVG: 3,813,254 <br /> MIN: 1,807,527 <br /> MAX: 14,313,819 | AVG: 1,420,317 <br /> MIN: 1,419,638 <br /> MAX: 1,420,929 |
| ml-dsa-44 (100 executions) | m4fstack | AVG: 1,793,492 <br /> MIN: 1,708,314 <br /> MAX: 1,892,955 | AVG: 12,248,558 <br /> MIN: 3,885,639 <br /> MAX: 49,576,620 | AVG: 3,259,593 <br /> MIN: 3,228,643 <br /> MAX: 3,295,621 |
| ml-dsa-65 (100 executions) | clean | AVG: 3,092,467 <br /> MIN: 3,091,562 <br /> MAX: 3,093,824 | AVG: 11,748,860 <br /> MIN: 4,732,542 <br /> MAX: 53,533,056 | AVG: 3,211,332 <br /> MIN: 3,211,011 <br /> MAX: 3,211,664 |
| ml-dsa-65 (100 executions) | m4f | AVG: 2,520,953 <br /> MIN: 2,519,724 <br /> MAX: 2,522,137 | AVG: 6,312,633 <br /> MIN: 2,918,415 <br /> MAX: 19,383,083 | AVG: 2,415,782 <br /> MIN: 2,414,950 <br /> MAX: 2,416,458 |
| ml-dsa-65 (100 executions) | m4fstack | AVG: 3,429,010 <br /> MIN: 3,424,643 <br /> MAX: 3,435,753 | AVG: 21,159,745 <br /> MIN: 6,708,155 <br /> MAX: 126,753,968 | AVG: 5,767,148 <br /> MIN: 5,728,195 <br /> MAX: 5,798,996 |
| ml-dsa-87 (100 executions) | clean | AVG: 5,148,455 <br /> MIN: 5,106,155 <br /> MAX: 5,204,052 | AVG: 13,361,516 <br /> MIN: 7,441,423 <br /> MAX: 45,223,059 | AVG: 5,364,286 <br /> MIN: 5,363,848 <br /> MAX: 5,364,664 |
| ml-dsa-87 (100 executions) | m4f | AVG: 4,268,327 <br /> MIN: 4,213,199 <br /> MAX: 4,321,980 | AVG: 7,973,867 <br /> MIN: 4,882,964 <br /> MAX: 20,762,879 | AVG: 4,193,890 <br /> MIN: 4,192,858 <br /> MAX: 4,195,005 |
| ml-dsa-87 (100 executions) | m4fstack | AVG: 5,782,202 <br /> MIN: 5,479,647 <br /> MAX: 6,086,260 | AVG: 33,354,321 <br /> MIN: 11,107,104 <br /> MAX: 127,002,740 | AVG: 9,966,871 <br /> MIN: 9,931,340 <br /> MAX: 10,004,227 |
