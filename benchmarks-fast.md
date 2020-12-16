# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| firesaber (1 executions) | m4f | AVG: 983,233 <br /> MIN: 983,233 <br /> MAX: 983,233 | AVG: 1,199,543 <br /> MIN: 1,199,543 <br /> MAX: 1,199,543 | AVG: 1,146,510 <br /> MIN: 1,146,510 <br /> MAX: 1,146,510 |
| lightsaber (1 executions) | m4f | AVG: 353,408 <br /> MIN: 353,408 <br /> MAX: 353,408 | AVG: 487,132 <br /> MIN: 487,132 <br /> MAX: 487,132 | AVG: 459,243 <br /> MIN: 459,243 <br /> MAX: 459,243 |
| saber (1 executions) | m4f | AVG: 641,331 <br /> MIN: 641,331 <br /> MAX: 641,331 | AVG: 823,414 <br /> MIN: 823,414 <br /> MAX: 823,414 | AVG: 775,916 <br /> MIN: 775,916 <br /> MAX: 775,916 |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| firesaber | m4f | 26,764 | 16,692 | 16,708 |
| lightsaber | m4f | 9,332 | 8,684 | 8,700 |
| saber | m4f | 17,028 | 12,684 | 12,700 |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| firesaber | m4f | 72.7% | 73.4% | 64.6% |
| lightsaber | m4f | 73.3% | 74.4% | 61.9% |
| saber | m4f | 73.9% | 74.6% | 64.3% |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| firesaber | m4f | 10,740 | 0 | 0 | 10,740 |
| lightsaber | m4f | 10,424 | 0 | 0 | 10,424 |
| saber | m4f | 10,972 | 0 | 0 | 10,972 |
