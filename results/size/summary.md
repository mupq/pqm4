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
| haetae2 | m4f | 32,716 | 0 | 0 | 32,716 |
| haetae2 | m4fstack | 32,600 | 0 | 0 | 32,600 |
| haetae2 | ref | 25,280 | 0 | 0 | 25,280 |
| haetae3 | m4f | 32,672 | 0 | 0 | 32,672 |
| haetae3 | m4fstack | 33,160 | 0 | 0 | 33,160 |
| haetae3 | ref | 25,376 | 0 | 0 | 25,376 |
| haetae5 | m4f | 32,736 | 0 | 0 | 32,736 |
| haetae5 | m4fstack | 32,568 | 0 | 0 | 32,568 |
| haetae5 | ref | 25,520 | 0 | 0 | 25,520 |
| ml-dsa-44 | clean | 8,288 | 0 | 0 | 8,288 |
| ml-dsa-44 | m4f | 19,456 | 0 | 0 | 19,456 |
| ml-dsa-44 | m4fstack | 24,248 | 0 | 0 | 24,248 |
| ml-dsa-65 | clean | 7,900 | 0 | 0 | 7,900 |
| ml-dsa-65 | m4f | 19,060 | 0 | 0 | 19,060 |
| ml-dsa-65 | m4fstack | 23,632 | 0 | 0 | 23,632 |
| ml-dsa-87 | clean | 8,240 | 0 | 0 | 8,240 |
| ml-dsa-87 | m4f | 19,460 | 0 | 0 | 19,460 |
| ml-dsa-87 | m4fstack | 24,056 | 0 | 0 | 24,056 |
