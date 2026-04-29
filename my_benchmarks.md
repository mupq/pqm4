# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| m-lwq-1024 (10 executions) | clean | AVG: 1,813,610 <br /> MIN: 1,812,201 <br /> MAX: 1,822,987 | AVG: 2,153,457 <br /> MIN: 2,152,007 <br /> MAX: 2,162,813 | AVG: 2,371,340 <br /> MIN: 2,369,830 <br /> MAX: 2,380,708 |
| m-lwq-512 (10 executions) | clean | AVG: 636,173 <br /> MIN: 635,768 <br /> MAX: 636,597 | AVG: 857,447 <br /> MIN: 857,043 <br /> MAX: 857,825 | AVG: 979,838 <br /> MIN: 979,452 <br /> MAX: 980,209 |
| m-lwq-768 (10 executions) | clean | AVG: 1,148,715 <br /> MIN: 1,147,144 <br /> MAX: 1,158,620 | AVG: 1,431,081 <br /> MIN: 1,429,499 <br /> MAX: 1,440,947 | AVG: 1,601,247 <br /> MIN: 1,599,668 <br /> MAX: 1,611,098 |
| ml-kem-512 (10 executions) | clean | AVG: 547,623 <br /> MIN: 547,476 <br /> MAX: 547,778 | AVG: 658,499 <br /> MIN: 658,352 <br /> MAX: 658,654 | AVG: 828,560 <br /> MIN: 828,413 <br /> MAX: 828,715 |
| ml-kem-512 (10 executions) | m4fspeed | AVG: 376,074 <br /> MIN: 375,626 <br /> MAX: 376,433 | AVG: 375,153 <br /> MIN: 374,705 <br /> MAX: 375,512 | AVG: 411,265 <br /> MIN: 410,817 <br /> MAX: 411,624 |
| ml-kem-512 (10 executions) | m4fstack | AVG: 375,922 <br /> MIN: 375,446 <br /> MAX: 376,206 | AVG: 376,934 <br /> MIN: 376,459 <br /> MAX: 377,219 | AVG: 413,292 <br /> MIN: 412,817 <br /> MAX: 413,577 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| m-lwq-1024 | clean | 24,496 | 38,744 | 43,664 |
| m-lwq-512 | clean | 11,536 | 17,608 | 21,136 |
| m-lwq-768 | clean | 17,504 | 27,136 | 31,376 |
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
| m-lwq-1024 | clean | 46.6% | 41.7% | 34.4% |
| m-lwq-512 | clean | 48.0% | 41.7% | 31.2% |
| m-lwq-768 | clean | 47.0% | 41.4% | 33.1% |
| ml-kem-512 | clean | 51.6% | 41.6% | 33.1% |
| ml-kem-512 | m4fspeed | 75.0% | 72.9% | 66.6% |
| ml-kem-512 | m4fstack | 75.0% | 72.5% | 66.2% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| m-lwq-1024 | clean | 6,696 | 0 | 0 | 6,696 |
| m-lwq-512 | clean | 6,472 | 0 | 0 | 6,472 |
| m-lwq-768 | clean | 6,632 | 0 | 0 | 6,632 |
| ml-kem-512 | clean | 5,232 | 0 | 0 | 5,232 |
| ml-kem-512 | m4fspeed | 15,744 | 0 | 0 | 15,744 |
| ml-kem-512 | m4fstack | 13,232 | 0 | 0 | 13,232 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
