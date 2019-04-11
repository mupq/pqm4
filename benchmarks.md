# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| kyber768 (2 executions) | m4 | AVG: 1,098,748 <br /> MIN: 1,098,710 <br /> MAX: 1,098,786 | AVG: 1,384,692 <br /> MIN: 1,384,654 <br /> MAX: 1,384,731 | AVG: 1,417,052 <br /> MIN: 1,417,014 <br /> MAX: 1,417,090 |
| kyber768 (2 executions) | ref | AVG: 1,269,379 <br /> MIN: 1,269,047 <br /> MAX: 1,269,712 | AVG: 1,677,068 <br /> MIN: 1,676,737 <br /> MAX: 1,677,400 | AVG: 1,827,778 <br /> MIN: 1,827,445 <br /> MAX: 1,828,111 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| kyber768 | m4 | 10,544 | 13,720 | 14,880 |
| kyber768 | ref | 10,544 | 13,720 | 14,880 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| kyber768 | m4 | 68.9% | 66.8% | 56.3% |
| kyber768 | ref | 59.6% | 55.2% | 43.6% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
