# pqm4
Post-quantum crypto library for the ARM Cortex-M4

## Introduction

## Schemes included in pqm4

## Setup/Installation

## Running tests and benchmarks

## API documentation

## Benchmarks

### Speed Evaluation
#### Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | -----------------------|
| saber (10 executions) | ref | AVG: 7,117,132 <br /> MIN: 7,117,132 <br /> MAX: 7,117,132 |  AVG: 9,465,651 <br /> MIN: 9,465,651 <br /> MAX: 9,465,651 | AVG: 12,297,269 <br /> MIN: 12,297,269 <br /> MAX: 12,297,269 |
| kindi256342 (10 executions) | ref | AVG: 22,931,719 <br /> MIN: 22,923,958 <br /> MAX: 22,942,731 |  AVG: 29,654,372 <br /> MIN: 29,633,060 <br /> MAX: 29,667,925 | AVG: 37,818,490 <br /> MIN: 37,794,037 <br /> MAX: 37,832,571 |
| ntruhrss701 (10 executions) | ref | AVG: 196,525,590 <br /> MIN: 196,524,862 <br /> MAX: 196,526,118 |  AVG: 5,165,720 <br /> MIN: 5,165,720 <br /> MAX: 5,165,721 | AVG: 15,069,184 <br /> MIN: 15,069,181 <br /> MAX: 15,069,186 |
| sikep751 (1 executions) | ref | AVG: 3,508,587,479 <br /> MIN: 3,508,587,479 <br /> MAX: 3,508,587,479 |  AVG: 5,685,595,692 <br /> MIN: 5,685,595,692 <br /> MAX: 5,685,595,692 | AVG: 6,109,767,719 <br /> MIN: 6,109,767,719 <br /> MAX: 6,109,767,719 |
| kyber768 (10 executions) | m4 | AVG: 1,196,806 <br /> MIN: 1,196,488 <br /> MAX: 1,197,108 |  AVG: 1,492,378 <br /> MIN: 1,492,076 <br /> MAX: 1,492,665 | AVG: 1,519,696 <br /> MIN: 1,519,394 <br /> MAX: 1,519,983 |
| kyber768 (10 executions) | ref | AVG: 1,376,691 <br /> MIN: 1,376,357 <br /> MAX: 1,376,957 |  AVG: 1,792,437 <br /> MIN: 1,792,120 <br /> MAX: 1,792,690 | AVG: 1,943,727 <br /> MIN: 1,943,410 <br /> MAX: 1,943,980 |
| frodo640-cshake (10 executions) | opt | AVG: 92,559,965 <br /> MIN: 92,559,965 <br /> MAX: 92,559,965 |  AVG: 110,084,381 <br /> MIN: 110,084,381 <br /> MAX: 110,084,381 | AVG: 110,550,496 <br /> MIN: 110,550,496 <br /> MAX: 110,550,496 |
| newhope1024cca (10 executions) | m4 | AVG: 1,258,101 <br /> MIN: 1,257,927 <br /> MAX: 1,258,199 |  AVG: 1,987,650 <br /> MIN: 1,987,475 <br /> MAX: 1,987,748 | AVG: 1,994,661 <br /> MIN: 1,994,486 <br /> MAX: 1,994,759 |
| newhope1024cca (10 executions) | ref | AVG: 1,514,006 <br /> MIN: 1,513,814 <br /> MAX: 1,514,166 |  AVG: 2,391,543 <br /> MIN: 2,391,352 <br /> MAX: 2,391,703 | AVG: 2,534,217 <br /> MIN: 2,534,025 <br /> MAX: 2,534,378 |
#### Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | ----------------|
| dilithium (100 executions) | ref | AVG: 2,865,649 <br /> MIN: 2,864,838 <br /> MAX: 2,866,673 |  AVG: 15,978,458 <br /> MIN: 5,368,086 <br /> MAX: 54,869,061 | AVG: 3,206,216 <br /> MIN: 3,205,732 <br /> MAX: 3,206,654 |
| sphincs-shake256-128s (1 executions) | ref | AVG: 4,571,546,075 <br /> MIN: 4,571,546,075 <br /> MAX: 4,571,546,075 |  AVG: 63,485,024,825 <br /> MIN: 63,485,024,825 <br /> MAX: 63,485,024,825 | AVG: 77,975,424 <br /> MIN: 77,975,424 <br /> MAX: 77,975,424 |

### Memory Evaluation
#### Key Encapsulation Schemes
| scheme | implementation | key generation [bytes] | encapsulation [bytes] | decapsulation [bytes] |
| ------ | -------------- | ----------------------- | ---------------------- | -----------------------|
| saber | ref | 12,824 |  15,096 | 16,192 |
| kindi256342 | ref | 10,632 |  10,736 | 16,912 |
| ntruhrss701 | ref | 10,024 |  8,996 | 10,244 |
| sikep751 | ref | 11,128 |  11,672 | 12,224 |
| kyber768 | m4 | 10,496 |  13,656 | 14,816 |
| kyber768 | ref | 10,496 |  13,656 | 14,816 |
| frodo640-cshake | opt | 36,744 |  58,536 | 68,888 |
| newhope1024cca | m4 | 11,432 |  17,728 | 19,928 |
| newhope1024cca | ref | 11,432 |  17,728 | 19,928 |
#### Signature Schemes
| scheme | implementation | key generation [bytes] | sign [bytes] | verify [bytes] |
| ------ | -------------- | ----------------------- | ------------- | ----------------|
| dilithium | ref | 51,372 |  87,608 | 55,816 |
| sphincs-shake256-128s | ref | 3,224 |  3,352 | 3,008 |


## Adding new schemes and implementations

## License