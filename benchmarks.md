# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| firesaber (100 executions) | m4 | AVG: 1,448,776 <br /> MIN: 1,448,776 <br /> MAX: 1,448,776 | AVG: 1,786,930 <br /> MIN: 1,786,930 <br /> MAX: 1,786,930 | AVG: 1,853,339 <br /> MIN: 1,853,339 <br /> MAX: 1,853,339 |
| firesaber (100 executions) | ref | AVG: 3,815,672 <br /> MIN: 3,815,672 <br /> MAX: 3,815,672 | AVG: 4,745,405 <br /> MIN: 4,745,405 <br /> MAX: 4,745,405 | AVG: 5,402,295 <br /> MIN: 5,402,295 <br /> MAX: 5,402,295 |
| frodokem640aes (100 executions) | m4 | AVG: 41,840,515 <br /> MIN: 41,840,515 <br /> MAX: 41,840,515 | AVG: 45,248,630 <br /> MIN: 45,248,630 <br /> MAX: 45,248,630 | AVG: 45,394,452 <br /> MIN: 45,394,452 <br /> MAX: 45,394,452 |
| frodokem640shake (100 executions) | m4 | AVG: 81,901,706 <br /> MIN: 81,901,706 <br /> MAX: 81,901,706 | AVG: 86,306,119 <br /> MIN: 86,306,119 <br /> MAX: 86,306,119 | AVG: 86,446,661 <br /> MIN: 86,446,661 <br /> MAX: 86,446,661 |
| frodokem640shake (100 executions) | opt | AVG: 94,170,349 <br /> MIN: 94,170,349 <br /> MAX: 94,170,349 | AVG: 107,936,133 <br /> MIN: 107,936,133 <br /> MAX: 107,936,133 | AVG: 108,301,160 <br /> MIN: 108,301,160 <br /> MAX: 108,301,160 |
| kyber1024 (100 executions) | clean | AVG: 1,891,737 <br /> MIN: 1,890,901 <br /> MAX: 1,892,395 | AVG: 2,254,703 <br /> MIN: 2,253,866 <br /> MAX: 2,255,361 | AVG: 2,407,858 <br /> MIN: 2,407,023 <br /> MAX: 2,408,517 |
| kyber1024 (100 executions) | m4 | AVG: 1,575,052 <br /> MIN: 1,574,351 <br /> MAX: 1,575,691 | AVG: 1,779,848 <br /> MIN: 1,779,192 <br /> MAX: 1,780,463 | AVG: 1,709,348 <br /> MIN: 1,708,692 <br /> MAX: 1,709,962 |
| kyber512 (100 executions) | clean | AVG: 649,678 <br /> MIN: 649,462 <br /> MAX: 649,984 | AVG: 884,848 <br /> MIN: 884,632 <br /> MAX: 885,154 | AVG: 985,258 <br /> MIN: 985,042 <br /> MAX: 985,564 |
| kyber512 (100 executions) | m4 | AVG: 514,291 <br /> MIN: 513,992 <br /> MAX: 514,547 | AVG: 652,769 <br /> MIN: 652,470 <br /> MAX: 653,025 | AVG: 621,245 <br /> MIN: 620,946 <br /> MAX: 621,501 |
| kyber768 (100 executions) | clean | AVG: 1,196,692 <br /> MIN: 1,196,142 <br /> MAX: 1,197,186 | AVG: 1,489,909 <br /> MIN: 1,489,359 <br /> MAX: 1,490,403 | AVG: 1,613,744 <br /> MIN: 1,613,194 <br /> MAX: 1,614,238 |
| kyber768 (100 executions) | m4 | AVG: 976,757 <br /> MIN: 976,205 <br /> MAX: 977,165 | AVG: 1,146,556 <br /> MIN: 1,146,021 <br /> MAX: 1,146,937 | AVG: 1,094,849 <br /> MIN: 1,094,314 <br /> MAX: 1,095,229 |
| lac128 (100 executions) | ref | AVG: 2,266,368 <br /> MIN: 2,254,917 <br /> MAX: 2,276,431 | AVG: 3,979,851 <br /> MIN: 3,968,056 <br /> MAX: 3,989,669 | AVG: 6,303,717 <br /> MIN: 6,291,865 <br /> MAX: 6,313,535 |
| lac192 (100 executions) | ref | AVG: 7,532,180 <br /> MIN: 7,525,427 <br /> MAX: 7,539,476 | AVG: 9,986,506 <br /> MIN: 9,979,643 <br /> MAX: 9,993,693 | AVG: 17,452,435 <br /> MIN: 17,445,553 <br /> MAX: 17,459,616 |
| lac256 (100 executions) | ref | AVG: 7,665,769 <br /> MIN: 7,652,402 <br /> MAX: 7,681,209 | AVG: 13,533,851 <br /> MIN: 13,517,064 <br /> MAX: 13,553,209 | AVG: 21,125,257 <br /> MIN: 21,108,384 <br /> MAX: 21,144,510 |
| lightsaber (100 executions) | m4 | AVG: 459,965 <br /> MIN: 459,965 <br /> MAX: 459,965 | AVG: 651,273 <br /> MIN: 651,273 <br /> MAX: 651,273 | AVG: 678,810 <br /> MIN: 678,810 <br /> MAX: 678,810 |
| lightsaber (100 executions) | ref | AVG: 1,051,530 <br /> MIN: 1,051,530 <br /> MAX: 1,051,530 | AVG: 1,538,646 <br /> MIN: 1,538,646 <br /> MAX: 1,538,646 | AVG: 1,861,934 <br /> MIN: 1,861,934 <br /> MAX: 1,861,934 |
| newhope1024cca (100 executions) | m4 | AVG: 1,219,655 <br /> MIN: 1,219,347 <br /> MAX: 1,219,902 | AVG: 1,901,160 <br /> MIN: 1,900,853 <br /> MAX: 1,901,408 | AVG: 1,926,151 <br /> MIN: 1,925,843 <br /> MAX: 1,926,398 |
| newhope1024cca (100 executions) | ref | AVG: 1,458,103 <br /> MIN: 1,457,793 <br /> MAX: 1,458,423 | AVG: 2,260,746 <br /> MIN: 2,260,436 <br /> MAX: 2,261,066 | AVG: 2,406,717 <br /> MIN: 2,406,407 <br /> MAX: 2,407,038 |
| ntruhps2048509 (100 executions) | clean | AVG: 107,331,110 <br /> MIN: 107,331,110 <br /> MAX: 107,331,110 | AVG: 2,876,597 <br /> MIN: 2,876,597 <br /> MAX: 2,876,597 | AVG: 7,495,670 <br /> MIN: 7,495,670 <br /> MAX: 7,495,670 |
| ntruhps2048677 (100 executions) | clean | AVG: 196,228,850 <br /> MIN: 196,228,850 <br /> MAX: 196,228,850 | AVG: 4,909,724 <br /> MIN: 4,909,724 <br /> MAX: 4,909,724 | AVG: 13,157,491 <br /> MIN: 13,157,491 <br /> MAX: 13,157,491 |
| ntruhps4096821 (100 executions) | clean | AVG: 289,736,570 <br /> MIN: 289,736,570 <br /> MAX: 289,736,570 | AVG: 7,046,106 <br /> MIN: 7,046,106 <br /> MAX: 7,046,106 | AVG: 19,262,764 <br /> MIN: 19,262,764 <br /> MAX: 19,262,764 |
| ntruhrss701 (100 executions) | clean | AVG: 208,992,073 <br /> MIN: 208,992,073 <br /> MAX: 208,992,073 | AVG: 4,656,818 <br /> MIN: 4,656,818 <br /> MAX: 4,656,818 | AVG: 14,142,725 <br /> MIN: 14,142,725 <br /> MAX: 14,142,725 |
| ntruhrss701 (100 executions) | m4 | AVG: 151,375,242 <br /> MIN: 151,375,242 <br /> MAX: 151,375,242 | AVG: 404,638 <br /> MIN: 404,638 <br /> MAX: 404,638 | AVG: 822,834 <br /> MIN: 822,834 <br /> MAX: 822,834 |
| saber (100 executions) | m4 | AVG: 896,035 <br /> MIN: 896,035 <br /> MAX: 896,035 | AVG: 1,161,849 <br /> MIN: 1,161,849 <br /> MAX: 1,161,849 | AVG: 1,204,633 <br /> MIN: 1,204,633 <br /> MAX: 1,204,633 |
| saber (100 executions) | ref | AVG: 2,226,935 <br /> MIN: 2,226,935 <br /> MAX: 2,226,935 | AVG: 2,936,240 <br /> MIN: 2,936,240 <br /> MAX: 2,936,240 | AVG: 3,424,601 <br /> MIN: 3,424,601 <br /> MAX: 3,424,601 |
| sikep751 (1 executions) | ref | AVG: 3,297,085,829 <br /> MIN: 3,297,085,829 <br /> MAX: 3,297,085,829 | AVG: 5,344,139,655 <br /> MIN: 5,344,139,655 <br /> MAX: 5,344,139,655 | AVG: 5,742,073,708 <br /> MIN: 5,742,073,708 <br /> MAX: 5,742,073,708 |
| sntrup4591761 (100 executions) | ref | AVG: 133,300,321 <br /> MIN: 133,300,321 <br /> MAX: 133,300,321 | AVG: 9,393,837 <br /> MIN: 9,393,837 <br /> MAX: 9,393,837 | AVG: 27,432,946 <br /> MIN: 27,432,946 <br /> MAX: 27,432,946 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| dilithium (100 executions) | m4 | AVG: 2,302,877 <br /> MIN: 2,302,131 <br /> MAX: 2,303,775 | AVG: 9,456,759 <br /> MIN: 3,118,360 <br /> MAX: 45,556,652 | AVG: 2,296,615 <br /> MIN: 2,296,063 <br /> MAX: 2,296,962 |
| dilithium (100 executions) | ref | AVG: 2,753,926 <br /> MIN: 2,753,249 <br /> MAX: 2,755,062 | AVG: 16,545,038 <br /> MIN: 5,001,347 <br /> MAX: 112,367,034 | AVG: 3,014,547 <br /> MIN: 3,014,142 <br /> MAX: 3,014,999 |
| qTesla-I (100 executions) | ref | AVG: 17,620,191 <br /> MIN: 7,796,886 <br /> MAX: 51,360,640 | AVG: 7,988,638 <br /> MIN: 1,406,175 <br /> MAX: 37,213,645 | AVG: 1,051,553 <br /> MIN: 1,047,049 <br /> MAX: 1,074,466 |
| qTesla-III-size (100 executions) | ref | AVG: 55,273,328 <br /> MIN: 22,103,613 <br /> MAX: 178,866,064 | AVG: 23,659,201 <br /> MIN: 3,184,719 <br /> MAX: 115,077,824 | AVG: 2,257,931 <br /> MIN: 2,250,078 <br /> MAX: 2,286,733 |
| qTesla-III-speed (100 executions) | ref | AVG: 32,775,258 <br /> MIN: 19,878,936 <br /> MAX: 113,404,261 | AVG: 9,477,183 <br /> MIN: 3,133,995 <br /> MAX: 41,726,976 | AVG: 2,209,618 <br /> MIN: 2,204,032 <br /> MAX: 2,236,124 |
| sphincs-shake256-128f-simple (1 executions) | clean | AVG: 65,652,221 <br /> MIN: 65,652,221 <br /> MAX: 65,652,221 | AVG: 2,069,365,694 <br /> MIN: 2,069,365,694 <br /> MAX: 2,069,365,694 | AVG: 82,204,019 <br /> MIN: 82,204,019 <br /> MAX: 82,204,019 |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| firesaber | m4 | 20,144 | 23,008 | 24,592 |
| firesaber | ref | 20,144 | 23,008 | 24,488 |
| frodokem640aes | m4 | 31,760 | 52,088 | 62,456 |
| frodokem640shake | m4 | 26,384 | 41,584 | 51,952 |
| frodokem640shake | opt | 36,640 | 58,352 | 68,720 |
| kyber1024 | clean | 15,224 | 18,928 | 20,496 |
| kyber1024 | m4 | 4,360 | 3,584 | 3,592 |
| kyber512 | clean | 6,480 | 9,168 | 9,904 |
| kyber512 | m4 | 2,952 | 2,552 | 2,560 |
| kyber768 | clean | 10,576 | 13,776 | 14,864 |
| kyber768 | m4 | 3,848 | 3,128 | 3,072 |
| lac128 | ref | 2,916 | 5,116 | 5,952 |
| lac192 | ref | 4,344 | 7,464 | 8,664 |
| lac256 | ref | 4,452 | 8,676 | 10,116 |
| lightsaber | m4 | 9,656 | 11,392 | 12,136 |
| lightsaber | ref | 10,024 | 11,672 | 12,504 |
| newhope1024cca | m4 | 11,192 | 17,448 | 19,688 |
| newhope1024cca | ref | 11,192 | 17,448 | 19,656 |
| ntruhps2048509 | clean | 11,784 | 6,896 | 5,192 |
| ntruhps2048677 | clean | 15,608 | 9,104 | 6,840 |
| ntruhps4096821 | clean | 18,880 | 10,992 | 8,344 |
| ntruhrss701 | clean | 14,216 | 7,420 | 8,612 |
| ntruhrss701 | m4 | 23,396 | 19,500 | 22,148 |
| saber | m4 | 13,256 | 15,544 | 16,640 |
| saber | ref | 13,624 | 15,912 | 17,008 |
| sikep751 | ref | 11,624 | 11,776 | 12,352 |
| sntrup4591761 | ref | 14,656 | 7,304 | 12,656 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| dilithium | m4 | 50,960 | 86,720 | 55,008 |
| dilithium | ref | 50,960 | 86,784 | 54,904 |
| qTesla-I | ref | 22,592 | 29,440 | 23,096 |
| qTesla-III-size | ref | 44,088 | 58,248 | 45,752 |
| qTesla-III-speed | ref | 44,088 | 58,144 | 45,736 |
| sphincs-shake256-128f-simple | clean | 2,208 | 2,368 | 2,664 |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| firesaber | m4 | 49.4% | 49.3% | 40.0% |
| firesaber | ref | 18.8% | 18.6% | 13.7% |
| frodokem640aes | m4 | 81.0% | 78.3% | 78.0% |
| frodokem640shake | m4 | 90.4% | 88.8% | 88.7% |
| frodokem640shake | opt | 79.8% | 71.0% | 70.8% |
| kyber1024 | clean | 58.8% | 58.0% | 47.4% |
| kyber1024 | m4 | 70.5% | 73.3% | 66.7% |
| kyber512 | clean | 54.6% | 53.5% | 38.9% |
| kyber512 | m4 | 68.9% | 72.5% | 61.6% |
| kyber768 | clean | 57.0% | 56.3% | 44.0% |
| kyber768 | m4 | 69.7% | 73.0% | 64.8% |
| lac128 | ref | 6.1% | 4.6% | 2.9% |
| lac192 | ref | 1.9% | 2.1% | 1.2% |
| lac256 | ref | 3.4% | 2.5% | 1.6% |
| lightsaber | m4 | 56.5% | 55.7% | 42.0% |
| lightsaber | ref | 24.7% | 23.6% | 15.3% |
| newhope1024cca | m4 | 71.2% | 70.4% | 59.5% |
| newhope1024cca | ref | 59.6% | 59.2% | 47.7% |
| ntruhps2048509 | clean | 0.0% | 0.9% | 1.4% |
| ntruhps2048677 | clean | 0.0% | 0.8% | 1.1% |
| ntruhps4096821 | clean | 0.0% | 0.6% | 0.9% |
| ntruhrss701 | clean | 0.0% | 0.8% | 1.1% |
| ntruhrss701 | m4 | 0.1% | 26.4% | 8.1% |
| saber | m4 | 53.0% | 52.9% | 41.5% |
| saber | ref | 21.3% | 20.9% | 14.6% |
| sikep751 | ref | 0.0% | 0.0% | 0.0% |
| sntrup4591761 | ref | 0.0% | 0.3% | 0.1% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| dilithium | m4 | 73.4% | 42.5% | 66.7% |
| dilithium | ref | 61.4% | 25.1% | 50.9% |
| qTesla-I | ref | 63.3% | 28.2% | 32.0% |
| qTesla-III-size | ref | 65.9% | 23.4% | 27.7% |
| qTesla-III-speed | ref | 73.0% | 24.9% | 28.2% |
| sphincs-shake256-128f-simple | clean | 96.4% | 96.0% | 96.3% |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| firesaber | m4 | 44,184 | 0 | 0 | 44,184 |
| firesaber | ref | 12,244 | 0 | 0 | 12,244 |
| frodokem640aes | m4 | 15,616 | 28 | 0 | 15,644 |
| frodokem640shake | m4 | 15,648 | 28 | 0 | 15,676 |
| frodokem640shake | opt | 13,908 | 28 | 0 | 13,936 |
| kyber1024 | clean | 5,352 | 512 | 0 | 5,864 |
| kyber1024 | m4 | 12,424 | 0 | 0 | 12,424 |
| kyber512 | clean | 4,444 | 512 | 0 | 4,956 |
| kyber512 | m4 | 11,000 | 0 | 0 | 11,000 |
| kyber768 | clean | 4,600 | 512 | 0 | 5,112 |
| kyber768 | m4 | 11,400 | 0 | 0 | 11,400 |
| lac128 | ref | 29,708 | 72 | 296 | 30,076 |
| lac192 | ref | 21,196 | 72 | 152 | 21,420 |
| lac256 | ref | 29,876 | 72 | 296 | 30,244 |
| lightsaber | m4 | 44,916 | 0 | 0 | 44,916 |
| lightsaber | ref | 12,976 | 0 | 0 | 12,976 |
| newhope1024cca | m4 | 7,048 | 6,144 | 0 | 13,192 |
| newhope1024cca | ref | 5,652 | 6,144 | 0 | 11,796 |
| ntruhps2048509 | clean | 6,916 | 0 | 0 | 6,916 |
| ntruhps2048677 | clean | 6,960 | 0 | 0 | 6,960 |
| ntruhps4096821 | clean | 6,684 | 0 | 0 | 6,684 |
| ntruhrss701 | clean | 6,828 | 0 | 0 | 6,828 |
| ntruhrss701 | m4 | 132,488 | 0 | 0 | 132,488 |
| saber | m4 | 44,468 | 0 | 0 | 44,468 |
| saber | ref | 12,524 | 0 | 0 | 12,524 |
| sikep751 | ref | 20,992 | 0 | 0 | 20,992 |
| sntrup4591761 | ref | 6,452 | 0 | 0 | 6,452 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| dilithium | m4 | 14,776 | 0 | 0 | 14,776 |
| dilithium | ref | 9,700 | 0 | 0 | 9,700 |
| qTesla-I | ref | 16,348 | 0 | 0 | 16,348 |
| qTesla-III-size | ref | 24,912 | 0 | 0 | 24,912 |
| qTesla-III-speed | ref | 23,812 | 0 | 0 | 23,812 |
| sphincs-shake256-128f-simple | clean | 3,896 | 0 | 0 | 3,896 |
