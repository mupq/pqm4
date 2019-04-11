# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| kyber768 (1 executions) | m4 | AVG: 1,098,786 <br /> MIN: 1,098,786 <br /> MAX: 1,098,786 | AVG: 1,384,731 <br /> MIN: 1,384,731 <br /> MAX: 1,384,731 | AVG: 1,417,090 <br /> MIN: 1,417,090 <br /> MAX: 1,417,090 |
| kyber768 (1 executions) | ref | AVG: 1,269,712 <br /> MIN: 1,269,712 <br /> MAX: 1,269,712 | AVG: 1,677,400 <br /> MIN: 1,677,400 <br /> MAX: 1,677,400 | AVG: 1,828,111 <br /> MIN: 1,828,111 <br /> MAX: 1,828,111 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| kyber768 | m4 | 68.8% | 66.8% | 56.3% |
| kyber768 | ref | 59.6% | 55.2% | 43.6% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
