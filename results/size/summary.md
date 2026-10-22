# Size Evaluation (reproduced)
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| ml-kem-1024 | clean | 6,040 | 0 | 0 | 6,040 |
| ml-kem-1024 | m4fspeed | 16,792 | 0 | 0 | 16,792 |
| ml-kem-1024 | m4fstack | 14,028 | 0 | 0 | 14,028 |
| ml-kem-512 | clean | 5,064 | 0 | 0 | 5,064 |
| ml-kem-512 | m4fspeed | 15,748 | 0 | 0 | 15,748 |
| ml-kem-512 | m4fstack | 13,224 | 0 | 0 | 13,224 |
| ml-kem-768 | clean | 4,956 | 0 | 0 | 4,956 |
| ml-kem-768 | m4fspeed | 15,756 | 0 | 0 | 15,756 |
| ml-kem-768 | m4fstack | 13,076 | 0 | 0 | 13,076 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| ml-dsa-44 | clean | 8,052 | 0 | 0 | 8,052 |
| ml-dsa-44 | m4f | 19,456 | 0 | 0 | 19,456 |
| ml-dsa-44 | m4fstack | 24,248 | 0 | 0 | 24,248 |
| ml-dsa-65 | clean | 7,664 | 0 | 0 | 7,664 |
| ml-dsa-65 | m4f | 19,060 | 0 | 0 | 19,060 |
| ml-dsa-65 | m4fstack | 23,632 | 0 | 0 | 23,632 |
| ml-dsa-87 | clean | 7,988 | 0 | 0 | 7,988 |
| ml-dsa-87 | m4f | 19,460 | 0 | 0 | 19,460 |
| ml-dsa-87 | m4fstack | 24,056 | 0 | 0 | 24,056 |
