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
| newhope1024cca (100 executions) | clean | AVG: 1,460,167 <br /> MIN: 1,459,836 <br /> MAX: 1,460,406 | AVG: 2,264,773 <br /> MIN: 2,264,441 <br /> MAX: 2,265,011 | AVG: 2,410,906 <br /> MIN: 2,410,574 <br /> MAX: 2,411,144 |
| newhope1024cca (100 executions) | m4 | AVG: 1,219,908 <br /> MIN: 1,219,630 <br /> MAX: 1,220,245 | AVG: 1,903,231 <br /> MIN: 1,902,954 <br /> MAX: 1,903,568 | AVG: 1,927,505 <br /> MIN: 1,927,227 <br /> MAX: 1,927,843 |
| newhope1024cpa (100 executions) | clean | AVG: 1,274,813 <br /> MIN: 1,274,572 <br /> MAX: 1,275,142 | AVG: 1,857,055 <br /> MIN: 1,856,813 <br /> MAX: 1,857,383 | AVG: 327,778 <br /> MIN: 327,778 <br /> MAX: 327,778 |
| newhope1024cpa (100 executions) | m4 | AVG: 1,034,955 <br /> MIN: 1,034,659 <br /> MAX: 1,035,274 | AVG: 1,495,457 <br /> MIN: 1,495,161 <br /> MAX: 1,495,776 | AVG: 206,112 <br /> MIN: 206,112 <br /> MAX: 206,112 |
| newhope512cca (100 executions) | clean | AVG: 719,785 <br /> MIN: 719,577 <br /> MAX: 720,072 | AVG: 1,134,083 <br /> MIN: 1,133,875 <br /> MAX: 1,134,370 | AVG: 1,192,460 <br /> MIN: 1,192,253 <br /> MAX: 1,192,748 |
| newhope512cpa (100 executions) | clean | AVG: 628,310 <br /> MIN: 628,073 <br /> MAX: 628,508 | AVG: 915,293 <br /> MIN: 915,056 <br /> MAX: 915,491 | AVG: 163,222 <br /> MIN: 163,222 <br /> MAX: 163,222 |
| ntruhps2048509 (100 executions) | clean | AVG: 107,331,110 <br /> MIN: 107,331,110 <br /> MAX: 107,331,110 | AVG: 2,876,597 <br /> MIN: 2,876,597 <br /> MAX: 2,876,597 | AVG: 7,495,670 <br /> MIN: 7,495,670 <br /> MAX: 7,495,670 |
| ntruhps2048677 (100 executions) | clean | AVG: 196,228,850 <br /> MIN: 196,228,850 <br /> MAX: 196,228,850 | AVG: 4,909,724 <br /> MIN: 4,909,724 <br /> MAX: 4,909,724 | AVG: 13,157,491 <br /> MIN: 13,157,491 <br /> MAX: 13,157,491 |
| ntruhps4096821 (100 executions) | clean | AVG: 289,736,570 <br /> MIN: 289,736,570 <br /> MAX: 289,736,570 | AVG: 7,046,106 <br /> MIN: 7,046,106 <br /> MAX: 7,046,106 | AVG: 19,262,764 <br /> MIN: 19,262,764 <br /> MAX: 19,262,764 |
| ntruhrss701 (100 executions) | clean | AVG: 208,992,073 <br /> MIN: 208,992,073 <br /> MAX: 208,992,073 | AVG: 4,656,818 <br /> MIN: 4,656,818 <br /> MAX: 4,656,818 | AVG: 14,142,725 <br /> MIN: 14,142,725 <br /> MAX: 14,142,725 |
| ntruhrss701 (100 executions) | m4 | AVG: 151,375,242 <br /> MIN: 151,375,242 <br /> MAX: 151,375,242 | AVG: 404,638 <br /> MIN: 404,638 <br /> MAX: 404,638 | AVG: 822,834 <br /> MIN: 822,834 <br /> MAX: 822,834 |
| saber (100 executions) | m4 | AVG: 896,035 <br /> MIN: 896,035 <br /> MAX: 896,035 | AVG: 1,161,849 <br /> MIN: 1,161,849 <br /> MAX: 1,161,849 | AVG: 1,204,633 <br /> MIN: 1,204,633 <br /> MAX: 1,204,633 |
| saber (100 executions) | ref | AVG: 2,226,935 <br /> MIN: 2,226,935 <br /> MAX: 2,226,935 | AVG: 2,936,240 <br /> MIN: 2,936,240 <br /> MAX: 2,936,240 | AVG: 3,424,601 <br /> MIN: 3,424,601 <br /> MAX: 3,424,601 |
| sikep434 (1 executions) | opt | AVG: 650,735,516 <br /> MIN: 650,735,516 <br /> MAX: 650,735,516 | AVG: 1,065,631,547 <br /> MIN: 1,065,631,547 <br /> MAX: 1,065,631,547 | AVG: 1,136,703,605 <br /> MIN: 1,136,703,605 <br /> MAX: 1,136,703,605 |
| sikep503 (1 executions) | opt | AVG: 985,032,805 <br /> MIN: 985,032,805 <br /> MAX: 985,032,805 | AVG: 1,623,893,046 <br /> MIN: 1,623,893,046 <br /> MAX: 1,623,893,046 | AVG: 1,726,538,272 <br /> MIN: 1,726,538,272 <br /> MAX: 1,726,538,272 |
| sikep610 (1 executions) | opt | AVG: 1,819,652,559 <br /> MIN: 1,819,652,559 <br /> MAX: 1,819,652,559 | AVG: 3,348,669,891 <br /> MIN: 3,348,669,891 <br /> MAX: 3,348,669,891 | AVG: 3,368,114,366 <br /> MIN: 3,368,114,366 <br /> MAX: 3,368,114,366 |
| sikep751 (1 executions) | opt | AVG: 3,296,225,272 <br /> MIN: 3,296,225,272 <br /> MAX: 3,296,225,272 | AVG: 5,347,056,677 <br /> MIN: 5,347,056,677 <br /> MAX: 5,347,056,677 | AVG: 5,742,522,048 <br /> MIN: 5,742,522,048 <br /> MAX: 5,742,522,048 |
| sntrup4591761 (100 executions) | ref | AVG: 133,300,321 <br /> MIN: 133,300,321 <br /> MAX: 133,300,321 | AVG: 9,393,837 <br /> MIN: 9,393,837 <br /> MAX: 9,393,837 | AVG: 27,432,946 <br /> MIN: 27,432,946 <br /> MAX: 27,432,946 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| dilithium (100 executions) | m4 | AVG: 2,302,877 <br /> MIN: 2,302,131 <br /> MAX: 2,303,775 | AVG: 9,456,759 <br /> MIN: 3,118,360 <br /> MAX: 45,556,652 | AVG: 2,296,615 <br /> MIN: 2,296,063 <br /> MAX: 2,296,962 |
| dilithium (100 executions) | ref | AVG: 2,753,926 <br /> MIN: 2,753,249 <br /> MAX: 2,755,062 | AVG: 16,545,038 <br /> MIN: 5,001,347 <br /> MAX: 112,367,034 | AVG: 3,014,547 <br /> MIN: 3,014,142 <br /> MAX: 3,014,999 |
| qTesla-I (100 executions) | ref | AVG: 17,620,191 <br /> MIN: 7,796,886 <br /> MAX: 51,360,640 | AVG: 7,988,638 <br /> MIN: 1,406,175 <br /> MAX: 37,213,645 | AVG: 1,051,553 <br /> MIN: 1,047,049 <br /> MAX: 1,074,466 |
| qTesla-III-size (100 executions) | ref | AVG: 55,273,328 <br /> MIN: 22,103,613 <br /> MAX: 178,866,064 | AVG: 23,659,201 <br /> MIN: 3,184,719 <br /> MAX: 115,077,824 | AVG: 2,257,931 <br /> MIN: 2,250,078 <br /> MAX: 2,286,733 |
| qTesla-III-speed (100 executions) | ref | AVG: 32,775,258 <br /> MIN: 19,878,936 <br /> MAX: 113,404,261 | AVG: 9,477,183 <br /> MIN: 3,133,995 <br /> MAX: 41,726,976 | AVG: 2,209,618 <br /> MIN: 2,204,032 <br /> MAX: 2,236,124 |
| sphincs-haraka-128f-robust (1 executions) | clean | AVG: 125,493,736 <br /> MIN: 125,493,736 <br /> MAX: 125,493,736 | AVG: 4,720,156,509 <br /> MIN: 4,720,156,509 <br /> MAX: 4,720,156,509 | AVG: 196,103,540 <br /> MIN: 196,103,540 <br /> MAX: 196,103,540 |
| sphincs-haraka-128f-simple (1 executions) | clean | AVG: 91,770,060 <br /> MIN: 91,770,060 <br /> MAX: 91,770,060 | AVG: 3,286,409,908 <br /> MIN: 3,286,409,908 <br /> MAX: 3,286,409,908 | AVG: 136,522,968 <br /> MIN: 136,522,968 <br /> MAX: 136,522,968 |
| sphincs-haraka-128s-robust (1 executions) | clean | AVG: 3,994,078,037 <br /> MIN: 3,994,078,037 <br /> MAX: 3,994,078,037 | AVG: 76,355,806,675 <br /> MIN: 76,355,806,675 <br /> MAX: 76,355,806,675 | AVG: 90,503,982 <br /> MIN: 90,503,982 <br /> MAX: 90,503,982 |
| sphincs-haraka-128s-simple (1 executions) | clean | AVG: 2,913,690,564 <br /> MIN: 2,913,690,564 <br /> MAX: 2,913,690,564 | AVG: 52,263,758,103 <br /> MIN: 52,263,758,103 <br /> MAX: 52,263,758,103 | AVG: 62,469,217 <br /> MIN: 62,469,217 <br /> MAX: 62,469,217 |
| sphincs-haraka-192f-robust (1 executions) | clean | AVG: 186,298,605 <br /> MIN: 186,298,605 <br /> MAX: 186,298,605 | AVG: 5,628,829,365 <br /> MIN: 5,628,829,365 <br /> MAX: 5,628,829,365 | AVG: 312,841,777 <br /> MIN: 312,841,777 <br /> MAX: 312,841,777 |
| sphincs-haraka-192f-simple (1 executions) | clean | AVG: 135,187,443 <br /> MIN: 135,187,443 <br /> MAX: 135,187,443 | AVG: 3,878,154,505 <br /> MIN: 3,878,154,505 <br /> MAX: 3,878,154,505 | AVG: 216,987,235 <br /> MIN: 216,987,235 <br /> MAX: 216,987,235 |
| sphincs-haraka-192s-robust (1 executions) | clean | AVG: 5,940,452,620 <br /> MIN: 5,940,452,620 <br /> MAX: 5,940,452,620 | AVG: 5,940,452,620 <br /> MIN: 5,940,452,620 <br /> MAX: 5,940,452,620 | AVG: 190,010,600,183 <br /> MIN: 190,010,600,183 <br /> MAX: 190,010,600,183 |
| sphincs-haraka-192s-simple (1 executions) | clean | AVG: 4,303,035,491 <br /> MIN: 4,303,035,491 <br /> MAX: 4,303,035,491 | AVG: 115,536,324,243 <br /> MIN: 115,536,324,243 <br /> MAX: 115,536,324,243 | AVG: 86,699,644 <br /> MIN: 86,699,644 <br /> MAX: 86,699,644 |
| sphincs-haraka-256f-robust (1 executions) | clean | AVG: 498,410,260 <br /> MIN: 498,410,260 <br /> MAX: 498,410,260 | AVG: 14,072,875,513 <br /> MIN: 14,072,875,513 <br /> MAX: 14,072,875,513 | AVG: 333,271,171 <br /> MIN: 333,271,171 <br /> MAX: 333,271,171 |
| sphincs-haraka-256f-simple (1 executions) | clean | AVG: 359,364,375 <br /> MIN: 359,364,375 <br /> MAX: 359,364,375 | AVG: 9,598,675,448 <br /> MIN: 9,598,675,448 <br /> MAX: 9,598,675,448 | AVG: 231,877,653 <br /> MIN: 231,877,653 <br /> MAX: 231,877,653 |
| sphincs-haraka-256s-robust (1 executions) | clean | AVG: 7,963,824,050 <br /> MIN: 7,963,824,050 <br /> MAX: 7,963,824,050 | AVG: 126,866,112,920 <br /> MIN: 126,866,112,920 <br /> MAX: 126,866,112,920 | AVG: 182,132,900 <br /> MIN: 182,132,900 <br /> MAX: 182,132,900 |
| sphincs-haraka-256s-simple (1 executions) | clean | AVG: 5,738,088,144 <br /> MIN: 5,738,088,144 <br /> MAX: 5,738,088,144 | AVG: 84,936,048,049 <br /> MIN: 84,936,048,049 <br /> MAX: 84,936,048,049 | AVG: 122,757,191 <br /> MIN: 122,757,191 <br /> MAX: 122,757,191 |
| sphincs-sha256-128f-robust (1 executions) | clean | AVG: 31,756,635 <br /> MIN: 31,756,635 <br /> MAX: 31,756,635 | AVG: 952,977,815 <br /> MIN: 952,977,815 <br /> MAX: 952,977,815 | AVG: 42,386,275 <br /> MIN: 42,386,275 <br /> MAX: 42,386,275 |
| sphincs-sha256-128f-simple (1 executions) | clean | AVG: 16,552,135 <br /> MIN: 16,552,135 <br /> MAX: 16,552,135 | AVG: 521,963,206 <br /> MIN: 521,963,206 <br /> MAX: 521,963,206 | AVG: 20,850,719 <br /> MIN: 20,850,719 <br /> MAX: 20,850,719 |
| sphincs-sha256-128s-robust (1 executions) | clean | AVG: 1,016,232,559 <br /> MIN: 1,016,232,559 <br /> MAX: 1,016,232,559 | AVG: 14,062,448,255 <br /> MIN: 14,062,448,255 <br /> MAX: 14,062,448,255 | AVG: 17,573,655 <br /> MIN: 17,573,655 <br /> MAX: 17,573,655 |
| sphincs-sha256-128s-simple (1 executions) | clean | AVG: 529,857,276 <br /> MIN: 529,857,276 <br /> MAX: 529,857,276 | AVG: 7,879,641,509 <br /> MIN: 7,879,641,509 <br /> MAX: 7,879,641,509 | AVG: 9,001,108 <br /> MIN: 9,001,108 <br /> MAX: 9,001,108 |
| sphincs-sha256-192f-robust (1 executions) | clean | AVG: 46,992,024 <br /> MIN: 46,992,024 <br /> MAX: 46,992,024 | AVG: 1,301,607,186 <br /> MIN: 1,301,607,186 <br /> MAX: 1,301,607,186 | AVG: 70,469,375 <br /> MIN: 70,469,375 <br /> MAX: 70,469,375 |
| sphincs-sha256-192f-simple (1 executions) | clean | AVG: 24,355,501 <br /> MIN: 24,355,501 <br /> MAX: 24,355,501 | AVG: 687,693,467 <br /> MIN: 687,693,467 <br /> MAX: 687,693,467 | AVG: 35,097,457 <br /> MIN: 35,097,457 <br /> MAX: 35,097,457 |
| sphincs-sha256-192s-robust (1 executions) | clean | AVG: 1,503,938,303 <br /> MIN: 1,503,938,303 <br /> MAX: 1,503,938,303 | AVG: 34,385,423,488 <br /> MIN: 34,385,423,488 <br /> MAX: 34,385,423,488 | AVG: 26,669,148 <br /> MIN: 26,669,148 <br /> MAX: 26,669,148 |
| sphincs-sha256-192s-simple (1 executions) | clean | AVG: 779,440,632 <br /> MIN: 779,440,632 <br /> MAX: 779,440,632 | AVG: 19,040,306,594 <br /> MIN: 19,040,306,594 <br /> MAX: 19,040,306,594 | AVG: 13,893,351 <br /> MIN: 13,893,351 <br /> MAX: 13,893,351 |
| sphincs-sha256-256f-robust (1 executions) | clean | AVG: 172,077,921 <br /> MIN: 172,077,921 <br /> MAX: 172,077,921 | AVG: 4,015,978,844 <br /> MIN: 4,015,978,844 <br /> MAX: 4,015,978,844 | AVG: 99,321,414 <br /> MIN: 99,321,414 <br /> MAX: 99,321,414 |
| sphincs-sha256-256f-simple (1 executions) | clean | AVG: 64,184,968 <br /> MIN: 64,184,968 <br /> MAX: 64,184,968 | AVG: 1,554,168,401 <br /> MIN: 1,554,168,401 <br /> MAX: 1,554,168,401 | AVG: 36,182,488 <br /> MIN: 36,182,488 <br /> MAX: 36,182,488 |
| sphincs-sha256-256s-robust (1 executions) | clean | AVG: 2,752,951,213 <br /> MIN: 2,752,951,213 <br /> MAX: 2,752,951,213 | AVG: 33,843,524,630 <br /> MIN: 33,843,524,630 <br /> MAX: 33,843,524,630 | AVG: 51,684,917 <br /> MIN: 51,684,917 <br /> MAX: 51,684,917 |
| sphincs-sha256-256s-simple (1 executions) | clean | AVG: 1,026,709,354 <br /> MIN: 1,026,709,354 <br /> MAX: 1,026,709,354 | AVG: 13,261,223,456 <br /> MIN: 13,261,223,456 <br /> MAX: 13,261,223,456 | AVG: 18,016,773 <br /> MIN: 18,016,773 <br /> MAX: 18,016,773 |
| sphincs-shake256-128f-robust (1 executions) | clean | AVG: 125,414,981 <br /> MIN: 125,414,981 <br /> MAX: 125,414,981 | AVG: 3,768,632,975 <br /> MIN: 3,768,632,975 <br /> MAX: 3,768,632,975 | AVG: 170,079,038 <br /> MIN: 170,079,038 <br /> MAX: 170,079,038 |
| sphincs-shake256-128f-simple (1 executions) | clean | AVG: 65,652,221 <br /> MIN: 65,652,221 <br /> MAX: 65,652,221 | AVG: 2,071,760,810 <br /> MIN: 2,071,760,810 <br /> MAX: 2,071,760,810 | AVG: 86,340,855 <br /> MIN: 86,340,855 <br /> MAX: 86,340,855 |
| sphincs-shake256-128s-robust (1 executions) | clean | AVG: 4,014,132,491 <br /> MIN: 4,014,132,491 <br /> MAX: 4,014,132,491 | AVG: 55,743,252,284 <br /> MIN: 55,743,252,284 <br /> MAX: 55,743,252,284 | AVG: 67,161,474 <br /> MIN: 67,161,474 <br /> MAX: 67,161,474 |
| sphincs-shake256-128s-simple (1 executions) | clean | AVG: 2,101,290,023 <br /> MIN: 2,101,290,023 <br /> MAX: 2,101,290,023 | AVG: 31,171,364,976 <br /> MIN: 31,171,364,976 <br /> MAX: 31,171,364,976 | AVG: 36,490,062 <br /> MIN: 36,490,062 <br /> MAX: 36,490,062 |
| sphincs-shake256-192f-robust (1 executions) | clean | AVG: 183,459,272 <br /> MIN: 183,459,272 <br /> MAX: 183,459,272 | AVG: 4,900,079,285 <br /> MIN: 4,900,079,285 <br /> MAX: 4,900,079,285 | AVG: 259,335,291 <br /> MIN: 259,335,291 <br /> MAX: 259,335,291 |
| sphincs-shake256-192f-simple (1 executions) | clean | AVG: 96,097,954 <br /> MIN: 96,097,954 <br /> MAX: 96,097,954 | AVG: 2,618,217,124 <br /> MIN: 2,618,217,124 <br /> MAX: 2,618,217,124 | AVG: 135,957,606 <br /> MIN: 135,957,606 <br /> MAX: 135,957,606 |
| sphincs-shake256-192s-robust (1 executions) | clean | AVG: 5,871,537,061 <br /> MIN: 5,871,537,061 <br /> MAX: 5,871,537,061 | AVG: 113,206,409,590 <br /> MIN: 113,206,409,590 <br /> MAX: 113,206,409,590 | AVG: 101,442,435 <br /> MIN: 101,442,435 <br /> MAX: 101,442,435 |
| sphincs-shake256-192s-simple (1 executions) | clean | AVG: 3,075,539,641 <br /> MIN: 3,075,539,641 <br /> MAX: 3,075,539,641 | AVG: 64,888,702,756 <br /> MIN: 64,888,702,756 <br /> MAX: 64,888,702,756 | AVG: 52,870,591 <br /> MIN: 52,870,591 <br /> MAX: 52,870,591 |
| sphincs-shake256-256f-robust (1 executions) | clean | AVG: 484,212,750 <br /> MIN: 484,212,750 <br /> MAX: 484,212,750 | AVG: 10,711,617,658 <br /> MIN: 10,711,617,658 <br /> MAX: 10,711,617,658 | AVG: 264,321,983 <br /> MIN: 264,321,983 <br /> MAX: 264,321,983 |
| sphincs-shake256-256f-simple (1 executions) | clean | AVG: 253,708,675 <br /> MIN: 253,708,675 <br /> MAX: 253,708,675 | AVG: 5,805,228,113 <br /> MIN: 5,805,228,113 <br /> MAX: 5,805,228,113 | AVG: 135,723,122 <br /> MIN: 135,723,122 <br /> MAX: 135,723,122 |
| sphincs-shake256-256s-robust (1 executions) | clean | AVG: 7,746,063,229 <br /> MIN: 7,746,063,229 <br /> MAX: 7,746,063,229 | AVG: 88,108,495,856 <br /> MIN: 88,108,495,856 <br /> MAX: 88,108,495,856 | AVG: 127,277,532 <br /> MIN: 127,277,532 <br /> MAX: 127,277,532 |
| sphincs-shake256-256s-simple (1 executions) | clean | AVG: 4,058,075,714 <br /> MIN: 4,058,075,714 <br /> MAX: 4,058,075,714 | AVG: 48,363,054,240 <br /> MIN: 48,363,054,240 <br /> MAX: 48,363,054,240 | AVG: 64,507,752 <br /> MIN: 64,507,752 <br /> MAX: 64,507,752 |
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
| newhope1024cca | clean | 11,120 | 17,400 | 19,608 |
| newhope1024cca | m4 | 11,152 | 17,400 | 19,640 |
| newhope1024cpa | clean | 11,096 | 17,288 | 8,308 |
| newhope1024cpa | m4 | 11,128 | 17,288 | 8,328 |
| newhope512cca | clean | 5,992 | 9,208 | 10,328 |
| newhope512cpa | clean | 5,968 | 9,128 | 4,248 |
| ntruhps2048509 | clean | 11,784 | 6,896 | 5,192 |
| ntruhps2048677 | clean | 15,608 | 9,104 | 6,840 |
| ntruhps4096821 | clean | 18,880 | 10,992 | 8,344 |
| ntruhrss701 | clean | 14,216 | 7,420 | 8,612 |
| ntruhrss701 | m4 | 23,396 | 19,500 | 22,148 |
| saber | m4 | 13,256 | 15,544 | 16,640 |
| saber | ref | 13,624 | 15,912 | 17,008 |
| sikep434 | opt | 6,776 | 7,088 | 7,424 |
| sikep503 | opt | 6,848 | 7,232 | 7,600 |
| sikep610 | opt | 10,080 | 10,512 | 10,968 |
| sikep751 | opt | 11,624 | 11,768 | 12,328 |
| sntrup4591761 | ref | 14,656 | 7,304 | 12,656 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| dilithium | m4 | 50,960 | 86,720 | 55,008 |
| dilithium | ref | 50,960 | 86,784 | 54,904 |
| qTesla-I | ref | 22,592 | 29,440 | 23,096 |
| qTesla-III-size | ref | 44,088 | 58,248 | 45,752 |
| qTesla-III-speed | ref | 44,088 | 58,144 | 45,736 |
| sphincs-haraka-128f-robust | clean | 2,424 | 2,400 | 2,772 |
| sphincs-haraka-128f-simple | clean | 2,316 | 2,400 | 2,772 |
| sphincs-haraka-128s-robust | clean | 2,608 | 2,568 | 2,092 |
| sphincs-haraka-128s-simple | clean | 2,608 | 2,568 | 2,120 |
| sphincs-haraka-192f-robust | clean | 3,768 | 3,872 | 4,128 |
| sphincs-haraka-192f-simple | clean | 3,768 | 3,872 | 4,100 |
| sphincs-haraka-192s-robust | clean | 4,112 | 4,008 | 3,472 |
| sphincs-haraka-192s-simple | clean | 4,112 | 4,008 | 3,472 |
| sphincs-haraka-256f-robust | clean | 5,752 | 5,792 | 5,364 |
| sphincs-haraka-256f-simple | clean | 5,832 | 5,792 | 5,392 |
| sphincs-haraka-256s-robust | clean | 6,104 | 5,936 | 5,336 |
| sphincs-haraka-256s-simple | clean | 6,104 | 5,936 | 5,416 |
| sphincs-sha256-128f-robust | clean | 2,248 | 2,408 | 2,704 |
| sphincs-sha256-128f-simple | clean | 2,192 | 2,248 | 2,544 |
| sphincs-sha256-128s-robust | clean | 2,464 | 2,496 | 2,024 |
| sphincs-sha256-128s-simple | clean | 2,304 | 2,336 | 1,872 |
| sphincs-sha256-192f-robust | clean | 3,784 | 3,808 | 4,040 |
| sphincs-sha256-192f-simple | clean | 3,512 | 3,640 | 3,872 |
| sphincs-sha256-192s-robust | clean | 4,048 | 3,944 | 3,384 |
| sphincs-sha256-192s-simple | clean | 3,880 | 3,776 | 3,216 |
| sphincs-sha256-256f-robust | clean | 5,776 | 5,736 | 5,360 |
| sphincs-sha256-256f-simple | clean | 5,600 | 5,560 | 5,184 |
| sphincs-sha256-256s-robust | clean | 6,048 | 5,880 | 5,360 |
| sphincs-sha256-256s-simple | clean | 5,872 | 5,704 | 5,080 |
| sphincs-shake256-128f-robust | clean | 2,272 | 2,368 | 2,664 |
| sphincs-shake256-128f-simple | clean | 2,208 | 2,368 | 2,664 |
| sphincs-shake256-128s-robust | clean | 2,424 | 2,456 | 2,000 |
| sphincs-shake256-128s-simple | clean | 2,424 | 2,456 | 2,000 |
| sphincs-shake256-192f-robust | clean | 3,744 | 3,768 | 4,000 |
| sphincs-shake256-192f-simple | clean | 3,640 | 3,768 | 3,999 |
| sphincs-shake256-192s-robust | clean | 4,008 | 3,904 | 3,448 |
| sphincs-shake256-192s-simple | clean | 4,008 | 3,904 | 3,448 |
| sphincs-shake256-256f-robust | clean | 5,736 | 5,696 | 5,320 |
| sphincs-shake256-256f-simple | clean | 5,736 | 5,696 | 5,320 |
| sphincs-shake256-256s-robust | clean | 6,008 | 5,840 | 5,320 |
| sphincs-shake256-256s-simple | clean | 6,008 | 5,840 | 5,320 |
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
| newhope1024cca | clean | 59.5% | 59.1% | 47.6% |
| newhope1024cca | m4 | 71.2% | 70.3% | 59.5% |
| newhope1024cpa | clean | 53.9% | 50.2% | 4.3% |
| newhope1024cpa | m4 | 66.3% | 62.2% | 6.8% |
| newhope512cca | clean | 61.4% | 61.5% | 49.9% |
| newhope512cpa | clean | 56.1% | 52.4% | 8.6% |
| ntruhps2048509 | clean | 0.0% | 0.9% | 1.4% |
| ntruhps2048677 | clean | 0.0% | 0.8% | 1.1% |
| ntruhps4096821 | clean | 0.0% | 0.6% | 0.9% |
| ntruhrss701 | clean | 0.0% | 0.8% | 1.1% |
| ntruhrss701 | m4 | 0.1% | 26.4% | 8.1% |
| saber | m4 | 53.0% | 52.9% | 41.5% |
| saber | ref | 21.3% | 20.9% | 14.6% |
| sikep434 | opt | 0.0% | 0.0% | 0.0% |
| sikep503 | opt | 0.0% | 0.0% | 0.0% |
| sikep610 | opt | 0.0% | 0.0% | 0.0% |
| sikep751 | opt | 0.0% | 0.0% | 0.0% |
| sntrup4591761 | ref | 0.0% | 0.3% | 0.1% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| dilithium | m4 | 73.4% | 42.5% | 66.7% |
| dilithium | ref | 61.4% | 25.1% | 50.9% |
| qTesla-I | ref | 63.3% | 28.2% | 32.0% |
| qTesla-III-size | ref | 65.9% | 23.4% | 27.7% |
| qTesla-III-speed | ref | 73.0% | 24.9% | 28.2% |
| sphincs-haraka-128f-robust | clean | 0.0% | 0.0% | 0.0% |
| sphincs-haraka-128f-simple | clean | 0.0% | 0.0% | 0.0% |
| sphincs-haraka-128s-robust | clean | 0.0% | 0.0% | 0.0% |
| sphincs-haraka-128s-simple | clean | 0.0% | 0.0% | 0.0% |
| sphincs-haraka-192f-robust | clean | 0.0% | 0.0% | 0.0% |
| sphincs-haraka-192f-simple | clean | 0.0% | 0.0% | 0.0% |
| sphincs-haraka-192s-robust | clean | 0.0% | 0.0% | 0.0% |
| sphincs-haraka-192s-simple | clean | 0.0% | 0.0% | 0.0% |
| sphincs-haraka-256f-robust | clean | 0.0% | 0.0% | 0.0% |
| sphincs-haraka-256f-simple | clean | 0.0% | 0.0% | 0.0% |
| sphincs-haraka-256s-robust | clean | 0.0% | 0.0% | 0.0% |
| sphincs-haraka-256s-simple | clean | 0.0% | 0.0% | 0.0% |
| sphincs-sha256-128f-robust | clean | 89.7% | 89.1% | 89.8% |
| sphincs-sha256-128f-simple | clean | 88.2% | 88.6% | 88.2% |
| sphincs-sha256-128s-robust | clean | 89.0% | 89.2% | 89.7% |
| sphincs-sha256-128s-simple | clean | 88.2% | 87.3% | 88.1% |
| sphincs-sha256-192f-robust | clean | 89.3% | 89.4% | 86.3% |
| sphincs-sha256-192f-simple | clean | 88.0% | 89.1% | 88.2% |
| sphincs-sha256-192s-robust | clean | 89.3% | 89.9% | 89.8% |
| sphincs-sha256-192s-simple | clean | 87.7% | 88.3% | 88.5% |
| sphincs-sha256-256f-robust | clean | 92.5% | 92.7% | 92.8% |
| sphincs-sha256-256f-simple | clean | 87.8% | 87.9% | 88.1% |
| sphincs-sha256-256s-robust | clean | 92.4% | 92.5% | 93.0% |
| sphincs-sha256-256s-simple | clean | 87.4% | 88.1% | 88.3% |
| sphincs-shake256-128f-robust | clean | 95.8% | 97.5% | 97.8% |
| sphincs-shake256-128f-simple | clean | 96.4% | 96.2% | 90.6% |
| sphincs-shake256-128s-robust | clean | 97.6% | 97.5% | 97.8% |
| sphincs-shake256-128s-simple | clean | 96.3% | 96.2% | 96.3% |
| sphincs-shake256-192f-robust | clean | 96.4% | 97.5% | 97.7% |
| sphincs-shake256-192f-simple | clean | 96.3% | 96.2% | 96.3% |
| sphincs-shake256-192s-robust | clean | 97.7% | 97.4% | 97.7% |
| sphincs-shake256-192s-simple | clean | 96.2% | 96.0% | 96.3% |
| sphincs-shake256-256f-robust | clean | 97.6% | 97.6% | 97.6% |
| sphincs-shake256-256f-simple | clean | 96.3% | 96.2% | 96.2% |
| sphincs-shake256-256s-robust | clean | 97.6% | 97.5% | 97.6% |
| sphincs-shake256-256s-simple | clean | 96.3% | 96.1% | 96.2% |
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
| newhope1024cca | clean | 10,780 | 0 | 0 | 10,780 |
| newhope1024cca | m4 | 12,176 | 0 | 0 | 12,176 |
| newhope1024cpa | clean | 10,384 | 0 | 0 | 10,384 |
| newhope1024cpa | m4 | 11,780 | 0 | 0 | 11,780 |
| newhope512cca | clean | 7,016 | 0 | 0 | 7,016 |
| newhope512cpa | clean | 6,620 | 0 | 0 | 6,620 |
| ntruhps2048509 | clean | 6,916 | 0 | 0 | 6,916 |
| ntruhps2048677 | clean | 6,960 | 0 | 0 | 6,960 |
| ntruhps4096821 | clean | 6,684 | 0 | 0 | 6,684 |
| ntruhrss701 | clean | 6,828 | 0 | 0 | 6,828 |
| ntruhrss701 | m4 | 132,488 | 0 | 0 | 132,488 |
| saber | m4 | 44,468 | 0 | 0 | 44,468 |
| saber | ref | 12,524 | 0 | 0 | 12,524 |
| sikep434 | opt | 30,368 | 0 | 0 | 30,368 |
| sikep503 | opt | 31,376 | 0 | 0 | 31,376 |
| sikep610 | opt | 20,064 | 0 | 0 | 20,064 |
| sikep751 | opt | 21,692 | 0 | 0 | 21,692 |
| sntrup4591761 | ref | 6,452 | 0 | 0 | 6,452 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| dilithium | m4 | 14,776 | 0 | 0 | 14,776 |
| dilithium | ref | 9,700 | 0 | 0 | 9,700 |
| qTesla-I | ref | 16,348 | 0 | 0 | 16,348 |
| qTesla-III-size | ref | 24,912 | 0 | 0 | 24,912 |
| qTesla-III-speed | ref | 23,812 | 0 | 0 | 23,812 |
| sphincs-haraka-128f-robust | clean | 17,192 | 0 | 1,280 | 18,472 |
| sphincs-haraka-128f-simple | clean | 17,028 | 0 | 1,280 | 18,308 |
| sphincs-haraka-128s-robust | clean | 17,500 | 0 | 1,280 | 18,780 |
| sphincs-haraka-128s-simple | clean | 17,336 | 0 | 1,280 | 18,616 |
| sphincs-haraka-192f-robust | clean | 17,140 | 0 | 1,280 | 18,420 |
| sphincs-haraka-192f-simple | clean | 16,940 | 0 | 1,280 | 18,220 |
| sphincs-haraka-192s-robust | clean | 17,432 | 0 | 1,280 | 18,712 |
| sphincs-haraka-192s-simple | clean | 17,232 | 0 | 1,280 | 18,512 |
| sphincs-haraka-256f-robust | clean | 17,528 | 0 | 1,280 | 18,808 |
| sphincs-haraka-256f-simple | clean | 17,240 | 0 | 1,280 | 18,520 |
| sphincs-haraka-256s-robust | clean | 17,736 | 0 | 1,280 | 19,016 |
| sphincs-haraka-256s-simple | clean | 17,448 | 0 | 1,280 | 18,728 |
| sphincs-sha256-128f-robust | clean | 4,860 | 0 | 40 | 4,900 |
| sphincs-sha256-128f-simple | clean | 4,628 | 0 | 40 | 4,668 |
| sphincs-sha256-128s-robust | clean | 5,160 | 0 | 40 | 5,200 |
| sphincs-sha256-128s-simple | clean | 4,928 | 0 | 40 | 4,968 |
| sphincs-sha256-192f-robust | clean | 4,948 | 0 | 40 | 4,988 |
| sphincs-sha256-192f-simple | clean | 4,636 | 0 | 40 | 4,676 |
| sphincs-sha256-192s-robust | clean | 5,244 | 0 | 40 | 5,284 |
| sphincs-sha256-192s-simple | clean | 4,932 | 0 | 40 | 4,972 |
| sphincs-sha256-256f-robust | clean | 5,468 | 0 | 40 | 5,508 |
| sphincs-sha256-256f-simple | clean | 5,044 | 0 | 40 | 5,084 |
| sphincs-sha256-256s-robust | clean | 5,676 | 0 | 40 | 5,716 |
| sphincs-sha256-256s-simple | clean | 5,252 | 0 | 40 | 5,292 |
| sphincs-shake256-128f-robust | clean | 4,096 | 0 | 0 | 4,096 |
| sphincs-shake256-128f-simple | clean | 3,896 | 0 | 0 | 3,896 |
| sphincs-shake256-128s-robust | clean | 4,404 | 0 | 0 | 4,404 |
| sphincs-shake256-128s-simple | clean | 4,204 | 0 | 0 | 4,204 |
| sphincs-shake256-192f-robust | clean | 4,108 | 0 | 0 | 4,108 |
| sphincs-shake256-192f-simple | clean | 3,856 | 0 | 0 | 3,856 |
| sphincs-shake256-192s-robust | clean | 4,400 | 0 | 0 | 4,400 |
| sphincs-shake256-192s-simple | clean | 4,148 | 0 | 0 | 4,148 |
| sphincs-shake256-256f-robust | clean | 4,480 | 0 | 0 | 4,480 |
| sphincs-shake256-256f-simple | clean | 4,172 | 0 | 0 | 4,172 |
| sphincs-shake256-256s-robust | clean | 4,684 | 0 | 0 | 4,684 |
| sphincs-shake256-256s-simple | clean | 4,380 | 0 | 0 | 4,380 |
