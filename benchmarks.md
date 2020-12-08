# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| firesaber (1 executions) | clean | AVG: 3,748,435 <br /> MIN: 3,748,435 <br /> MAX: 3,748,435 | AVG: 4,660,830 <br /> MIN: 4,660,830 <br /> MAX: 4,660,830 | AVG: 5,108,568 <br /> MIN: 5,108,568 <br /> MAX: 5,108,568 |
| firesaber (1 executions) | m4f | AVG: 978,537 <br /> MIN: 978,537 <br /> MAX: 978,537 | AVG: 1,193,409 <br /> MIN: 1,193,409 <br /> MAX: 1,193,409 | AVG: 1,138,295 <br /> MIN: 1,138,295 <br /> MAX: 1,138,295 |
| lightsaber (1 executions) | clean | AVG: 1,034,702 <br /> MIN: 1,034,702 <br /> MAX: 1,034,702 | AVG: 1,512,452 <br /> MIN: 1,512,452 <br /> MAX: 1,512,452 | AVG: 1,824,151 <br /> MIN: 1,824,151 <br /> MAX: 1,824,151 |
| lightsaber (1 executions) | m4f | AVG: 351,155 <br /> MIN: 351,155 <br /> MAX: 351,155 | AVG: 483,551 <br /> MIN: 483,551 <br /> MAX: 483,551 | AVG: 453,969 <br /> MIN: 453,969 <br /> MAX: 453,969 |
| saber (1 executions) | clean | AVG: 2,182,941 <br /> MIN: 2,182,941 <br /> MAX: 2,182,941 | AVG: 2,890,738 <br /> MIN: 2,890,738 <br /> MAX: 2,890,738 | AVG: 3,357,169 <br /> MIN: 3,357,169 <br /> MAX: 3,357,169 |
| saber (1 executions) | m4f | AVG: 637,570 <br /> MIN: 637,570 <br /> MAX: 637,570 | AVG: 818,618 <br /> MIN: 818,618 <br /> MAX: 818,618 | AVG: 769,216 <br /> MIN: 769,216 <br /> MAX: 769,216 |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| firesaber | clean | 22,696 | 25,552 | 27,032 |
| firesaber | m4f | 26,764 | 16,692 | 16,708 |
| lightsaber | clean | 10,536 | 12,272 | 13,016 |
| lightsaber | m4f | 9,332 | 8,684 | 8,700 |
| saber | clean | 15,696 | 18,056 | 19,056 |
| saber | m4f | 17,028 | 12,684 | 12,700 |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| firesaber | clean | 19.1% | 18.9% | 14.5% |
| firesaber | m4f | 73.1% | 73.8% | 65.0% |
| lightsaber | clean | 25.1% | 24.0% | 15.6% |
| lightsaber | m4f | 73.8% | 74.9% | 62.6% |
| saber | clean | 21.7% | 21.3% | 14.9% |
| saber | m4f | 74.3% | 75.1% | 64.9% |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| firesaber | clean | 11,832 | 0 | 0 | 11,832 |
| firesaber | m4f | 9,928 | 0 | 0 | 9,928 |
| lightsaber | clean | 11,952 | 0 | 0 | 11,952 |
| lightsaber | m4f | 9,596 | 0 | 0 | 9,596 |
| saber | clean | 11,868 | 0 | 0 | 11,868 |
| saber | m4f | 10,008 | 0 | 0 | 10,008 |
