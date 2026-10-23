# Memory Evaluation (reproduced)
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| ml-kem-1024 | clean | 15,124 | 18,772 | 20,348 |
| ml-kem-1024 | m4fspeed | 6,436 | 7,500 | 7,484 |
| ml-kem-1024 | m4fstack | 3,332 | 3,372 | 3,356 |
| ml-kem-512 | clean | 6,160 | 8,792 | 9,568 |
| ml-kem-512 | m4fspeed | 4,364 | 5,428 | 5,404 |
| ml-kem-512 | m4fstack | 2,308 | 2,348 | 2,332 |
| ml-kem-768 | clean | 10,256 | 13,392 | 14,488 |
| ml-kem-768 | m4fspeed | 5,404 | 6,468 | 6,452 |
| ml-kem-768 | m4fstack | 2,820 | 2,860 | 2,844 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| ml-dsa-44 | clean | 38,304 | 51,976 | 36,200 |
| ml-dsa-44 | m4f | 38,296 | 44,816 | 8,912 |
| ml-dsa-44 | m4fstack | 4,408 | 5,072 | 2,712 |
| ml-dsa-65 | clean | 60,832 | 79,624 | 57,736 |
| ml-dsa-65 | m4f | 60,824 | 68,872 | 9,888 |
| ml-dsa-65 | m4fstack | 4,408 | 6,608 | 2,712 |
| ml-dsa-87 | clean | 97,696 | 122,736 | 92,944 |
| ml-dsa-87 | m4f | 97,688 | 107,888 | 12,056 |
| ml-dsa-87 | m4fstack | 4,408 | 8,144 | 2,720 |
