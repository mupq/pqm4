# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| firesaber (1 executions) | m4f | AVG: 1,008,725 <br /> MIN: 1,008,725 <br /> MAX: 1,008,725 | AVG: 1,229,472 <br /> MIN: 1,229,472 <br /> MAX: 1,229,472 | AVG: 1,179,577 <br /> MIN: 1,179,577 <br /> MAX: 1,179,577 |
| lightsaber (1 executions) | m4f | AVG: 359,233 <br /> MIN: 359,233 <br /> MAX: 359,233 | AVG: 493,887 <br /> MIN: 493,887 <br /> MAX: 493,887 | AVG: 467,395 <br /> MIN: 467,395 <br /> MAX: 467,395 |
| saber (1 executions) | m4f | AVG: 656,077 <br /> MIN: 656,077 <br /> MAX: 656,077 | AVG: 839,496 <br /> MIN: 839,496 <br /> MAX: 839,496 | AVG: 795,157 <br /> MIN: 795,157 <br /> MAX: 795,157 |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| firesaber | m4f | 7,796 | 9,004 | 9,020 |
| lightsaber | m4f | 5,748 | 6,124 | 6,140 |
| saber | m4f | 6,772 | 7,556 | 7,572 |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| firesaber | m4f | 70.9% | 71.7% | 62.8% |
| lightsaber | m4f | 72.1% | 73.4% | 60.9% |
| saber | m4f | 72.2% | 73.2% | 62.8% |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| firesaber | m4f | 10,948 | 0 | 0 | 10,948 |
| lightsaber | m4f | 10,712 | 0 | 0 | 10,712 |
| saber | m4f | 11,324 | 0 | 0 | 11,324 |
