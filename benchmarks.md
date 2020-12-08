# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| firesaber (1 executions) | clean | AVG: 3,748,435 <br /> MIN: 3,748,435 <br /> MAX: 3,748,435 | AVG: 4,660,830 <br /> MIN: 4,660,830 <br /> MAX: 4,660,830 | AVG: 5,108,568 <br /> MIN: 5,108,568 <br /> MAX: 5,108,568 |
| firesaber (1 executions) | m4f | AVG: 981,367 <br /> MIN: 981,367 <br /> MAX: 981,367 | AVG: 1,196,359 <br /> MIN: 1,196,359 <br /> MAX: 1,196,359 | AVG: 1,141,368 <br /> MIN: 1,141,368 <br /> MAX: 1,141,368 |
| lightsaber (1 executions) | clean | AVG: 1,034,702 <br /> MIN: 1,034,702 <br /> MAX: 1,034,702 | AVG: 1,512,452 <br /> MIN: 1,512,452 <br /> MAX: 1,512,452 | AVG: 1,824,151 <br /> MIN: 1,824,151 <br /> MAX: 1,824,151 |
| lightsaber (1 executions) | m4f | AVG: 351,863 <br /> MIN: 351,863 <br /> MAX: 351,863 | AVG: 484,963 <br /> MIN: 484,963 <br /> MAX: 484,963 | AVG: 456,085 <br /> MIN: 456,085 <br /> MAX: 456,085 |
| saber (1 executions) | clean | AVG: 2,182,941 <br /> MIN: 2,182,941 <br /> MAX: 2,182,941 | AVG: 2,890,738 <br /> MIN: 2,890,738 <br /> MAX: 2,890,738 | AVG: 3,357,169 <br /> MIN: 3,357,169 <br /> MAX: 3,357,169 |
| saber (1 executions) | m4f | AVG: 638,608 <br /> MIN: 638,608 <br /> MAX: 638,608 | AVG: 820,306 <br /> MIN: 820,306 <br /> MAX: 820,306 | AVG: 770,998 <br /> MIN: 770,998 <br /> MAX: 770,998 |
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
| firesaber | m4f | 72.8% | 73.6% | 64.9% |
| lightsaber | clean | 25.1% | 24.0% | 15.6% |
| lightsaber | m4f | 73.6% | 74.7% | 62.4% |
| saber | clean | 21.7% | 21.3% | 14.9% |
| saber | m4f | 74.1% | 74.9% | 64.7% |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| firesaber | clean | 11,832 | 0 | 0 | 11,832 |
| firesaber | m4f | 9,916 | 0 | 0 | 9,916 |
| lightsaber | clean | 11,952 | 0 | 0 | 11,952 |
| lightsaber | m4f | 9,580 | 0 | 0 | 9,580 |
| saber | clean | 11,868 | 0 | 0 | 11,868 |
| saber | m4f | 9,996 | 0 | 0 | 9,996 |
