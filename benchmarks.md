# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| frodokem640aes (100 executions) | m4 | AVG: 220,307,317 <br /> MIN: 220,241,077 <br /> MAX: 220,386,311 | AVG: 223,739,226 <br /> MIN: 223,672,948 <br /> MAX: 223,818,372 | AVG: 218,784,713 <br /> MIN: 218,718,418 <br /> MAX: 218,863,869 |
| frodokem640cshake (100 executions) | m4 | AVG: 81,905,542 <br /> MIN: 81,905,542 <br /> MAX: 81,905,542 | AVG: 86,239,829 <br /> MIN: 86,239,829 <br /> MAX: 86,239,829 | AVG: 86,385,540 <br /> MIN: 86,385,540 <br /> MAX: 86,385,540 |
| frodokem640cshake (100 executions) | opt | AVG: 94,173,002 <br /> MIN: 94,173,002 <br /> MAX: 94,173,002 | AVG: 107,084,620 <br /> MIN: 107,084,620 <br /> MAX: 107,084,620 | AVG: 107,482,437 <br /> MIN: 107,482,437 <br /> MAX: 107,482,437 |
| kyber1024 (100 executions) | m4 | AVG: 1,729,819 <br /> MIN: 1,729,068 <br /> MAX: 1,730,683 | AVG: 2,083,028 <br /> MIN: 2,082,278 <br /> MAX: 2,083,893 | AVG: 2,134,685 <br /> MIN: 2,133,934 <br /> MAX: 2,135,550 |
| kyber1024 (100 executions) | ref | AVG: 1,957,251 <br /> MIN: 1,956,503 <br /> MAX: 1,958,004 | AVG: 2,463,004 <br /> MIN: 2,462,257 <br /> MAX: 2,463,758 | AVG: 2,663,791 <br /> MIN: 2,663,043 <br /> MAX: 2,664,544 |
| kyber512 (100 executions) | m4 | AVG: 665,609 <br /> MIN: 665,182 <br /> MAX: 665,980 | AVG: 903,352 <br /> MIN: 902,925 <br /> MAX: 903,723 | AVG: 933,528 <br /> MIN: 933,102 <br /> MAX: 933,900 |
| kyber512 (100 executions) | ref | AVG: 779,417 <br /> MIN: 779,036 <br /> MAX: 779,771 | AVG: 1,108,241 <br /> MIN: 1,107,860 <br /> MAX: 1,108,595 | AVG: 1,226,180 <br /> MIN: 1,225,798 <br /> MAX: 1,226,534 |
| kyber768 (100 executions) | m4 | AVG: 1,098,604 <br /> MIN: 1,098,197 <br /> MAX: 1,099,128 | AVG: 1,384,549 <br /> MIN: 1,384,141 <br /> MAX: 1,385,073 | AVG: 1,416,908 <br /> MIN: 1,416,501 <br /> MAX: 1,417,432 |
| kyber768 (100 executions) | ref | AVG: 1,269,336 <br /> MIN: 1,268,667 <br /> MAX: 1,270,035 | AVG: 1,677,026 <br /> MIN: 1,676,357 <br /> MAX: 1,677,725 | AVG: 1,827,734 <br /> MIN: 1,827,065 <br /> MAX: 1,828,433 |
| newhope1024cca (100 executions) | m4 | AVG: 1,220,539 <br /> MIN: 1,220,182 <br /> MAX: 1,220,822 | AVG: 1,902,086 <br /> MIN: 1,901,730 <br /> MAX: 1,902,370 | AVG: 1,925,924 <br /> MIN: 1,925,566 <br /> MAX: 1,926,207 |
| newhope1024cca (100 executions) | ref | AVG: 1,466,552 <br /> MIN: 1,466,131 <br /> MAX: 1,466,899 | AVG: 2,273,026 <br /> MIN: 2,272,605 <br /> MAX: 2,273,374 | AVG: 2,421,633 <br /> MIN: 2,421,212 <br /> MAX: 2,421,980 |
| ntruhps2048509 (100 executions) | clean | AVG: 111,432,235 <br /> MIN: 111,432,235 <br /> MAX: 111,432,235 | AVG: 2,879,179 <br /> MIN: 2,879,179 <br /> MAX: 2,879,179 | AVG: 7,230,769 <br /> MIN: 7,230,769 <br /> MAX: 7,230,769 |
| ntruhrss701 (100 executions) | m4 | AVG: 145,962,064 <br /> MIN: 145,962,064 <br /> MAX: 145,962,064 | AVG: 403,677 <br /> MIN: 403,677 <br /> MAX: 403,677 | AVG: 819,323 <br /> MIN: 819,323 <br /> MAX: 819,323 |
| ntruhrss701 (100 executions) | ref | AVG: 189,381,286 <br /> MIN: 189,381,286 <br /> MAX: 189,381,286 | AVG: 4,655,513 <br /> MIN: 4,655,513 <br /> MAX: 4,655,513 | AVG: 13,571,758 <br /> MIN: 13,571,758 <br /> MAX: 13,571,758 |
| saber (100 executions) | m4 | AVG: 894,655 <br /> MIN: 894,655 <br /> MAX: 894,655 | AVG: 1,161,220 <br /> MIN: 1,161,220 <br /> MAX: 1,161,220 | AVG: 1,204,173 <br /> MIN: 1,204,173 <br /> MAX: 1,204,173 |
| saber (100 executions) | ref | AVG: 5,907,650 <br /> MIN: 5,907,650 <br /> MAX: 5,907,650 | AVG: 7,843,989 <br /> MIN: 7,843,989 <br /> MAX: 7,843,989 | AVG: 9,554,128 <br /> MIN: 9,554,128 <br /> MAX: 9,554,128 |
| sikep751 (2 executions) | ref | AVG: 3,394,424,419 <br /> MIN: 3,394,424,419 <br /> MAX: 3,394,424,419 | AVG: 5,500,863,298 <br /> MIN: 5,500,863,298 <br /> MAX: 5,500,863,298 | AVG: 5,911,088,796 <br /> MIN: 5,911,088,796 <br /> MAX: 5,911,088,796 |
| sntrup4591761 (100 executions) | ref | AVG: 133,607,176 <br /> MIN: 133,607,176 <br /> MAX: 133,607,176 | AVG: 9,683,945 <br /> MIN: 9,683,945 <br /> MAX: 9,683,945 | AVG: 28,586,566 <br /> MIN: 28,586,566 <br /> MAX: 28,586,566 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| dilithium (100 executions) | m4 | AVG: 2,304,135 <br /> MIN: 2,303,305 <br /> MAX: 2,304,977 | AVG: 8,738,743 <br /> MIN: 3,118,472 <br /> MAX: 32,461,889 | AVG: 2,297,215 <br /> MIN: 2,296,811 <br /> MAX: 2,297,662 |
| dilithium (100 executions) | ref | AVG: 2,755,209 <br /> MIN: 2,754,546 <br /> MAX: 2,756,003 | AVG: 15,593,609 <br /> MIN: 5,001,347 <br /> MAX: 47,568,719 | AVG: 3,015,099 <br /> MIN: 3,014,727 <br /> MAX: 3,015,472 |
| qTesla-I (100 executions) | ref | AVG: 16,181,905 <br /> MIN: 7,759,886 <br /> MAX: 55,665,081 | AVG: 6,528,971 <br /> MIN: 1,408,282 <br /> MAX: 38,101,487 | AVG: 1,038,204 <br /> MIN: 1,031,357 <br /> MAX: 1,066,061 |
| qTesla-III-size (100 executions) | ref | AVG: 52,911,984 <br /> MIN: 22,057,621 <br /> MAX: 147,552,103 | AVG: 25,535,653 <br /> MIN: 3,263,517 <br /> MAX: 85,027,845 | AVG: 2,268,587 <br /> MIN: 2,263,927 <br /> MAX: 2,296,947 |
| qTesla-III-speed (100 executions) | ref | AVG: 34,440,396 <br /> MIN: 19,783,861 <br /> MAX: 112,913,102 | AVG: 10,958,955 <br /> MIN: 3,242,541 <br /> MAX: 39,136,486 | AVG: 2,197,445 <br /> MIN: 2,187,892 <br /> MAX: 2,228,424 |
| sphincs-shake256-128f-simple (1 executions) | clean | AVG: 65,678,196 <br /> MIN: 65,678,196 <br /> MAX: 65,678,196 | AVG: 2,070,781,593 <br /> MIN: 2,070,781,593 <br /> MAX: 2,070,781,593 | AVG: 83,111,329 <br /> MIN: 83,111,329 <br /> MAX: 83,111,329 |

# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| frodokem640aes | m4 | 31,240 | 51,568 | 61,944 |
| frodokem640cshake | m4 | 26,304 | 41,504 | 51,880 |
| frodokem640cshake | opt | 36,560 | 58,272 | 68,640 |
| kyber1024 | m4 | 15,664 | 19,352 | 20,864 |
| kyber1024 | ref | 15,664 | 19,352 | 20,864 |
| kyber512 | m4 | 6,456 | 9,120 | 9,928 |
| kyber512 | ref | 6,456 | 9,120 | 9,928 |
| kyber768 | m4 | 10,544 | 13,720 | 14,880 |
| kyber768 | ref | 10,544 | 13,720 | 14,880 |
| newhope1024cca | m4 | 11,152 | 17,448 | 19,680 |
| newhope1024cca | ref | 11,152 | 17,448 | 19,680 |
| ntruhps2048509 | clean | 11,768 | 6,920 | 5,184 |
| ntruhrss701 | m4 | 23,396 | 19,492 | 22,140 |
| ntruhrss701 | ref | 10,032 | 8,956 | 10,204 |
| saber | m4 | 13,248 | 15,528 | 16,624 |
| saber | ref | 12,616 | 14,928 | 15,992 |
| sikep751 | ref | 11,544 | 11,704 | 12,256 |
| sntrup4591761 | ref | 14,640 | 7,232 | 12,576 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| dilithium | m4 | 50,896 | 86,720 | 54,904 |
| dilithium | ref | 50,896 | 86,752 | 54,936 |
| qTesla-I | ref | 22,512 | 29,336 | 23,128 |
| qTesla-III-size | ref | 44,016 | 58,152 | 45,732 |
| qTesla-III-speed | ref | 44,024 | 58,144 | 45,712 |
| sphincs-shake256-128f-simple | clean | 2,200 | 2,304 | 2,664 |

# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| frodokem640aes | m4 | 96.4% | 95.3% | 95.2% |
| frodokem640cshake | m4 | 90.4% | 88.9% | 88.7% |
| frodokem640cshake | opt | 79.8% | 71.6% | 71.3% |
| kyber1024 | m4 | 69.3% | 67.5% | 58.7% |
| kyber1024 | ref | 61.3% | 57.1% | 47.0% |
| kyber512 | m4 | 68.3% | 66.2% | 54.4% |
| kyber512 | ref | 58.3% | 54.0% | 41.4% |
| kyber768 | m4 | 68.9% | 66.8% | 56.3% |
| kyber768 | ref | 59.6% | 55.2% | 43.6% |
| newhope1024cca | m4 | 71.2% | 70.3% | 59.5% |
| newhope1024cca | ref | 59.3% | 58.9% | 47.4% |
| ntruhps2048509 | clean | 0.0% | 0.9% | 1.4% |
| ntruhrss701 | m4 | 0.1% | 26.5% | 8.2% |
| ntruhrss701 | ref | 0.0% | 2.3% | 0.5% |
| saber | m4 | 53.1% | 52.9% | 41.5% |
| saber | ref | 8.0% | 7.8% | 5.2% |
| sikep751 | ref | 0.0% | 0.0% | 0.0% |
| sntrup4591761 | ref | 0.0% | 0.3% | 0.1% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| dilithium | m4 | 73.4% | 42.3% | 66.7% |
| dilithium | ref | 61.4% | 25.4% | 50.8% |
| qTesla-I | ref | 63.5% | 27.8% | 32.4% |
| qTesla-III-size | ref | 66.2% | 23.0% | 27.5% |
| qTesla-III-speed | ref | 73.3% | 24.1% | 28.3% |
| sphincs-shake256-128f-simple | clean | 96.4% | 96.2% | 99.1% |

# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| frodokem1344shake | clean | 5,820 | 0 | 0 | 5,820 |
| frodokem640aes | m4 | 15,660 | 28 | 0 | 15,688 |
| frodokem640shake | clean | 6,048 | 0 | 0 | 6,048 |
| frodokem640shake | m4 | 15,720 | 28 | 0 | 15,748 |
| frodokem640shake | opt | 13,904 | 28 | 0 | 13,932 |
| frodokem976shake | clean | 5,692 | 0 | 0 | 5,692 |
| kyber1024 | m4 | 12,638 | 0 | 0 | 12,638 |
| kyber1024 | ref | 5,404 | 0 | 0 | 5,404 |
| kyber512 | m4 | 12,522 | 0 | 0 | 12,522 |
| kyber512 | ref | 5,288 | 0 | 0 | 5,288 |
| kyber768 | clean | 5,312 | 0 | 0 | 5,312 |
| kyber768 | m4 | 12,562 | 0 | 0 | 12,562 |
| kyber768 | ref | 5,328 | 0 | 0 | 5,328 |
| newhope1024cca | m4 | 7,068 | 6,144 | 0 | 13,212 |
| newhope1024cca | ref | 5,684 | 6,144 | 0 | 11,828 |
| ntruhps2048509 | clean | 6,864 | 0 | 0 | 6,864 |
| ntruhrss701 | m4 | 132,436 | 0 | 0 | 132,436 |
| ntruhrss701 | ref | 6,992 | 0 | 0 | 6,992 |
| saber | m4 | 44,504 | 0 | 0 | 44,504 |
| saber | ref | 5,620 | 0 | 0 | 5,620 |
| sikep751 | ref | 21,040 | 0 | 0 | 21,040 |
| sntrup4591761 | ref | 6,464 | 0 | 0 | 6,464 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| dilithium | m4 | 14,864 | 0 | 0 | 14,864 |
| dilithium | ref | 9,788 | 0 | 0 | 9,788 |
| qTesla-I | ref | 16,176 | 0 | 0 | 16,176 |
| qTesla-III-size | ref | 24,804 | 0 | 0 | 24,804 |
| qTesla-III-speed | ref | 23,716 | 0 | 0 | 23,716 |
| sphincs-shake256-128f-simple | clean | 3,932 | 0 | 0 | 3,932 |
