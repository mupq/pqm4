# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| m-lwq-512 (1 executions) | clean | AVG: 636,301 <br /> MIN: 636,301 <br /> MAX: 636,301 | AVG: 857,588 <br /> MIN: 857,588 <br /> MAX: 857,588 | AVG: 980,025 <br /> MIN: 980,025 <br /> MAX: 980,025 |
| ml-kem-512 (1 executions) | clean | AVG: 547,718 <br /> MIN: 547,718 <br /> MAX: 547,718 | AVG: 658,594 <br /> MIN: 658,594 <br /> MAX: 658,594 | AVG: 828,655 <br /> MIN: 828,655 <br /> MAX: 828,655 |
| ml-kem-512 (1 executions) | m4fspeed | AVG: 375,663 <br /> MIN: 375,663 <br /> MAX: 375,663 | AVG: 374,742 <br /> MIN: 374,742 <br /> MAX: 374,742 | AVG: 410,854 <br /> MIN: 410,854 <br /> MAX: 410,854 |
| ml-kem-512 (1 executions) | m4fstack | AVG: 375,771 <br /> MIN: 375,771 <br /> MAX: 375,771 | AVG: 376,782 <br /> MIN: 376,782 <br /> MAX: 376,782 | AVG: 413,140 <br /> MIN: 413,140 <br /> MAX: 413,140 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| m-lwq-512 | clean | 11,536 | 17,608 | 21,136 |
| ml-kem-512 | clean | 6,160 | 8,792 | 9,568 |
| ml-kem-512 | m4fspeed | 4,372 | 5,436 | 5,412 |
| ml-kem-512 | m4fstack | 2,300 | 2,348 | 2,332 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| m-lwq-512 | clean | 48.0% | 41.7% | 31.2% |
| ml-kem-512 | clean | 51.6% | 41.6% | 33.1% |
| ml-kem-512 | m4fspeed | 75.0% | 72.9% | 66.5% |
| ml-kem-512 | m4fstack | 75.0% | 72.5% | 66.2% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| m-lwq-512 | clean | 6,472 | 0 | 0 | 6,472 |
| ml-kem-512 | clean | 5,232 | 0 | 0 | 5,232 |
| ml-kem-512 | m4fspeed | 15,744 | 0 | 0 | 15,744 |
| ml-kem-512 | m4fstack | 13,232 | 0 | 0 | 13,232 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
