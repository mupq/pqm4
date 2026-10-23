# Hashing Evaluation (reproduced)
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| ml-kem-1024 | clean | 50.6% | 45.7% | 38.9% |
| ml-kem-1024 | m4fspeed | 75.3% | 75.5% | 71.3% |
| ml-kem-1024 | m4fstack | 75.1% | 74.9% | 70.7% |
| ml-kem-512 | clean | 50.9% | 41.5% | 32.9% |
| ml-kem-512 | m4fspeed | 75.6% | 73.8% | 67.6% |
| ml-kem-512 | m4fstack | 75.6% | 73.5% | 67.3% |
| ml-kem-768 | clean | 49.2% | 43.2% | 35.6% |
| ml-kem-768 | m4fspeed | 74.5% | 74.7% | 69.6% |
| ml-kem-768 | m4fstack | 74.4% | 74.1% | 69.1% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| haetae2 | m4f | 24.7% | 56.9% | 59.3% |
| haetae2 | m4fstack | 40.8% | 49.2% | 58.3% |
| haetae2 | ref | 16.5% | 32.8% | 45.7% |
| haetae3 | m4f | 27.4% | 57.1% | 63.5% |
| haetae3 | m4fstack | 46.5% | 48.7% | 58.7% |
| haetae3 | ref | 17.5% | 33.0% | 51.1% |
| haetae5 | m4f | 31.8% | 57.0% | 65.0% |
| haetae5 | m4fstack | 28.0% | 50.7% | 60.5% |
| haetae5 | ref | 24.0% | 33.2% | 55.0% |
| ml-dsa-44 | clean | 63.7% | 33.8% | 55.9% |
| ml-dsa-44 | m4f | 80.1% | 60.8% | 76.7% |
| ml-dsa-44 | m4fstack | 75.3% | 55.0% | 40.6% |
| ml-dsa-65 | clean | 67.1% | 33.3% | 59.7% |
| ml-dsa-65 | m4f | 82.1% | 60.9% | 79.2% |
| ml-dsa-65 | m4fstack | 76.7% | 55.0% | 40.7% |
| ml-dsa-87 | clean | 69.4% | 39.1% | 63.9% |
| ml-dsa-87 | m4f | 83.6% | 64.2% | 81.6% |
| ml-dsa-87 | m4fstack | 76.4% | 54.4% | 42.4% |
