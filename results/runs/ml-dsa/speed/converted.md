# Speed Evaluation
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| ml-dsa-44 (100 executions) | clean | AVG: 1,794,242 <br /> MIN: 1,758,149 <br /> MAX: 1,834,091 | AVG: 7,492,483 <br /> MIN: 3,064,633 <br /> MAX: 29,188,755 | AVG: 1,951,884 <br /> MIN: 1,951,562 <br /> MAX: 1,952,292 |
| ml-dsa-44 (100 executions) | m4f | AVG: 1,420,177 <br /> MIN: 1,386,191 <br /> MAX: 1,451,394 | AVG: 3,813,254 <br /> MIN: 1,807,527 <br /> MAX: 14,313,819 | AVG: 1,420,317 <br /> MIN: 1,419,638 <br /> MAX: 1,420,929 |
| ml-dsa-44 (100 executions) | m4fstack | AVG: 1,793,492 <br /> MIN: 1,708,314 <br /> MAX: 1,892,955 | AVG: 12,248,558 <br /> MIN: 3,885,639 <br /> MAX: 49,576,620 | AVG: 3,259,593 <br /> MIN: 3,228,643 <br /> MAX: 3,295,621 |
| ml-dsa-65 (100 executions) | clean | AVG: 3,092,467 <br /> MIN: 3,091,562 <br /> MAX: 3,093,824 | AVG: 11,748,860 <br /> MIN: 4,732,542 <br /> MAX: 53,533,056 | AVG: 3,211,332 <br /> MIN: 3,211,011 <br /> MAX: 3,211,664 |
| ml-dsa-65 (100 executions) | m4f | AVG: 2,520,953 <br /> MIN: 2,519,724 <br /> MAX: 2,522,137 | AVG: 6,312,633 <br /> MIN: 2,918,415 <br /> MAX: 19,383,083 | AVG: 2,415,782 <br /> MIN: 2,414,950 <br /> MAX: 2,416,458 |
| ml-dsa-65 (100 executions) | m4fstack | AVG: 3,429,010 <br /> MIN: 3,424,643 <br /> MAX: 3,435,753 | AVG: 21,159,745 <br /> MIN: 6,708,155 <br /> MAX: 126,753,968 | AVG: 5,767,148 <br /> MIN: 5,728,195 <br /> MAX: 5,798,996 |
| ml-dsa-87 (100 executions) | clean | AVG: 5,148,455 <br /> MIN: 5,106,155 <br /> MAX: 5,204,052 | AVG: 13,361,516 <br /> MIN: 7,441,423 <br /> MAX: 45,223,059 | AVG: 5,364,286 <br /> MIN: 5,363,848 <br /> MAX: 5,364,664 |
| ml-dsa-87 (100 executions) | m4f | AVG: 4,268,327 <br /> MIN: 4,213,199 <br /> MAX: 4,321,980 | AVG: 7,973,867 <br /> MIN: 4,882,964 <br /> MAX: 20,762,879 | AVG: 4,193,890 <br /> MIN: 4,192,858 <br /> MAX: 4,195,005 |
| ml-dsa-87 (100 executions) | m4fstack | AVG: 5,782,202 <br /> MIN: 5,479,647 <br /> MAX: 6,086,260 | AVG: 33,354,321 <br /> MIN: 11,107,104 <br /> MAX: 127,002,740 | AVG: 9,966,871 <br /> MIN: 9,931,340 <br /> MAX: 10,004,227 |
