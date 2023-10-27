# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| ov-Ip (100 executions) | m4f | AVG: 138,685,787 <br /> MIN: 138,685,772 <br /> MAX: 138,685,828 | AVG: 2,488,529 <br /> MIN: 2,464,562 <br /> MAX: 4,861,007 | AVG: 993,529 <br /> MIN: 970,257 <br /> MAX: 996,849 |
| ov-Ip (100 executions) | ref | AVG: 350,266,803 <br /> MIN: 350,266,761 <br /> MAX: 350,267,118 | AVG: 6,548,206 <br /> MIN: 6,484,449 <br /> MAX: 12,858,979 | AVG: 1,309,303 <br /> MIN: 1,309,301 <br /> MAX: 1,309,336 |
| ov-Ip-pkc (100 executions) | m4fspeed | AVG: 174,887,930 <br /> MIN: 174,887,906 <br /> MAX: 174,887,957 | AVG: 2,556,235 <br /> MIN: 2,483,862 <br /> MAX: 4,896,138 | AVG: 10,699,967 <br /> MIN: 10,679,534 <br /> MAX: 10,703,471 |
| ov-Ip-pkc (100 executions) | m4fstack | AVG: 174,887,935 <br /> MIN: 174,887,911 <br /> MAX: 174,887,964 | AVG: 2,483,868 <br /> MIN: 2,483,862 <br /> MAX: 2,483,903 | AVG: 11,521,985 <br /> MIN: 11,494,511 <br /> MAX: 11,525,897 |
| ov-Ip-pkc (100 executions) | ref | AVG: 374,601,982 <br /> MIN: 374,601,950 <br /> MAX: 374,602,024 | AVG: 6,933,668 <br /> MIN: 6,933,653 <br /> MAX: 6,933,693 | AVG: 10,946,959 <br /> MIN: 10,946,937 <br /> MAX: 10,947,004 |
| ov-Ip-pkc-skc (100 executions) | m4fspeed | AVG: 174,888,071 <br /> MIN: 174,888,044 <br /> MAX: 174,888,099 | AVG: 88,664,377 <br /> MIN: 88,664,362 <br /> MAX: 88,664,408 | AVG: 11,458,067 <br /> MIN: 11,429,199 <br /> MAX: 11,462,352 |
| ov-Ip-pkc-skc (100 executions) | m4fstack | AVG: 174,888,061 <br /> MIN: 174,888,040 <br /> MAX: 174,888,089 | AVG: 88,664,370 <br /> MIN: 88,664,359 <br /> MAX: 88,664,402 | AVG: 11,521,533 <br /> MIN: 11,491,491 <br /> MAX: 11,525,897 |
| ov-Ip-pkc-skc (100 executions) | ref | AVG: 374,602,058 <br /> MIN: 374,602,033 <br /> MAX: 374,602,092 | AVG: 241,007,574 <br /> MIN: 241,007,551 <br /> MAX: 241,007,605 | AVG: 11,657,933 <br /> MIN: 11,657,906 <br /> MAX: 11,657,948 |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| ov-Ip | m4f | 1,488 | 5,252 | 2,548 |
| ov-Ip | ref | 1,536 | 3,640 | 6,160 |
| ov-Ip-pkc | m4fspeed | 142,288 | 5,252 | 280,980 |
| ov-Ip-pkc | m4fstack | 133,152 | 5,252 | 6,560 |
| ov-Ip-pkc | ref | 15,752 | 12,872 | 284,704 |
| ov-Ip-pkc-skc | m4fspeed | 371,072 | 243,164 | 280,980 |
| ov-Ip-pkc-skc | m4fstack | 371,072 | 243,164 | 6,560 |
| ov-Ip-pkc-skc | ref | 253,656 | 253,616 | 284,704 |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| ov-Ip | m4f | 7.2% | 0.9% | 1.1% |
| ov-Ip | ref | 2.8% | 0.3% | 0.9% |
| ov-Ip-pkc | m4fspeed | 6.1% | 0.9% | 90.8% |
| ov-Ip-pkc | m4fstack | 6.1% | 0.9% | 90.7% |
| ov-Ip-pkc | ref | 2.8% | 0.3% | 88.8% |
| ov-Ip-pkc-skc | m4fspeed | 6.1% | 12.1% | 91.2% |
| ov-Ip-pkc-skc | m4fstack | 6.1% | 12.1% | 90.7% |
| ov-Ip-pkc-skc | ref | 2.8% | 4.4% | 89.6% |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| ov-Ip | m4f | 116,847 | 0 | 0 | 116,847 |
| ov-Ip | ref | 28,599 | 0 | 0 | 28,599 |
| ov-Ip-pkc | m4fspeed | 117,039 | 0 | 0 | 117,039 |
| ov-Ip-pkc | m4fstack | 116,967 | 0 | 0 | 116,967 |
| ov-Ip-pkc | ref | 28,807 | 0 | 0 | 28,807 |
| ov-Ip-pkc-skc | m4fspeed | 117,083 | 0 | 0 | 117,083 |
| ov-Ip-pkc-skc | m4fstack | 117,011 | 0 | 0 | 117,011 |
| ov-Ip-pkc-skc | ref | 28,851 | 0 | 0 | 28,851 |
