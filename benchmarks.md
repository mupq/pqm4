# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| babybear (100 executions) | opt | AVG: 596,665 <br /> MIN: 596,665 <br /> MAX: 596,665 | AVG: 752,117 <br /> MIN: 752,117 <br /> MAX: 752,117 | AVG: 1,142,773 <br /> MIN: 1,142,773 <br /> MAX: 1,142,773 |
| babybear (100 executions) | ref | AVG: 3,968,931 <br /> MIN: 3,968,931 <br /> MAX: 3,968,931 | AVG: 5,802,693 <br /> MIN: 5,802,693 <br /> MAX: 5,802,693 | AVG: 11,704,641 <br /> MIN: 11,704,641 <br /> MAX: 11,704,641 |
| babybear-ephem (100 executions) | opt | AVG: 596,664 <br /> MIN: 596,664 <br /> MAX: 596,664 | AVG: 767,860 <br /> MIN: 767,860 <br /> MAX: 767,860 | AVG: 231,728 <br /> MIN: 231,728 <br /> MAX: 231,728 |
| babybear-ephem (100 executions) | ref | AVG: 3,968,935 <br /> MIN: 3,968,935 <br /> MAX: 3,968,935 | AVG: 5,817,861 <br /> MIN: 5,817,861 <br /> MAX: 5,817,861 | AVG: 1,948,755 <br /> MIN: 1,948,755 <br /> MAX: 1,948,755 |
| firesaber (100 executions) | m4 | AVG: 1,448,776 <br /> MIN: 1,448,776 <br /> MAX: 1,448,776 | AVG: 1,786,930 <br /> MIN: 1,786,930 <br /> MAX: 1,786,930 | AVG: 1,853,339 <br /> MIN: 1,853,339 <br /> MAX: 1,853,339 |
| firesaber (100 executions) | ref | AVG: 3,815,672 <br /> MIN: 3,815,672 <br /> MAX: 3,815,672 | AVG: 4,745,405 <br /> MIN: 4,745,405 <br /> MAX: 4,745,405 | AVG: 5,402,295 <br /> MIN: 5,402,295 <br /> MAX: 5,402,295 |
| frodokem640aes (100 executions) | m4 | AVG: 41,840,515 <br /> MIN: 41,840,515 <br /> MAX: 41,840,515 | AVG: 45,248,630 <br /> MIN: 45,248,630 <br /> MAX: 45,248,630 | AVG: 45,394,452 <br /> MIN: 45,394,452 <br /> MAX: 45,394,452 |
| frodokem640shake (100 executions) | m4 | AVG: 81,901,706 <br /> MIN: 81,901,706 <br /> MAX: 81,901,706 | AVG: 86,306,119 <br /> MIN: 86,306,119 <br /> MAX: 86,306,119 | AVG: 86,446,661 <br /> MIN: 86,446,661 <br /> MAX: 86,446,661 |
| frodokem640shake (100 executions) | opt | AVG: 90,411,528 <br /> MIN: 90,411,528 <br /> MAX: 90,411,528 | AVG: 106,349,880 <br /> MIN: 106,349,880 <br /> MAX: 106,349,880 | AVG: 106,095,374 <br /> MIN: 106,095,374 <br /> MAX: 106,095,374 |
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
| mamabear (100 executions) | opt | AVG: 1,195,048 <br /> MIN: 1,195,048 <br /> MAX: 1,195,048 | AVG: 1,402,955 <br /> MIN: 1,402,955 <br /> MAX: 1,402,955 | AVG: 1,955,496 <br /> MIN: 1,955,496 <br /> MAX: 1,955,496 |
| mamabear (100 executions) | ref | AVG: 8,774,109 <br /> MIN: 8,774,109 <br /> MAX: 8,774,109 | AVG: 11,501,206 <br /> MIN: 11,501,206 <br /> MAX: 11,501,206 | AVG: 23,131,816 <br /> MIN: 23,131,816 <br /> MAX: 23,131,816 |
| mamabear-ephem (100 executions) | opt | AVG: 1,206,350 <br /> MIN: 1,206,350 <br /> MAX: 1,206,350 | AVG: 1,431,341 <br /> MIN: 1,431,341 <br /> MAX: 1,431,341 | AVG: 320,233 <br /> MIN: 320,233 <br /> MAX: 320,233 |
| mamabear-ephem (100 executions) | ref | AVG: 8,783,565 <br /> MIN: 8,783,565 <br /> MAX: 8,783,565 | AVG: 11,525,870 <br /> MIN: 11,525,870 <br /> MAX: 11,525,870 | AVG: 2,876,105 <br /> MIN: 2,876,105 <br /> MAX: 2,876,105 |
| newhope1024cca (100 executions) | clean | AVG: 1,460,167 <br /> MIN: 1,459,836 <br /> MAX: 1,460,406 | AVG: 2,264,773 <br /> MIN: 2,264,441 <br /> MAX: 2,265,011 | AVG: 2,410,906 <br /> MIN: 2,410,574 <br /> MAX: 2,411,144 |
| newhope1024cca (100 executions) | m4 | AVG: 1,219,908 <br /> MIN: 1,219,630 <br /> MAX: 1,220,245 | AVG: 1,903,231 <br /> MIN: 1,902,954 <br /> MAX: 1,903,568 | AVG: 1,927,505 <br /> MIN: 1,927,227 <br /> MAX: 1,927,843 |
| newhope1024cpa (100 executions) | clean | AVG: 1,274,813 <br /> MIN: 1,274,572 <br /> MAX: 1,275,142 | AVG: 1,857,055 <br /> MIN: 1,856,813 <br /> MAX: 1,857,383 | AVG: 327,778 <br /> MIN: 327,778 <br /> MAX: 327,778 |
| newhope1024cpa (100 executions) | m4 | AVG: 1,034,955 <br /> MIN: 1,034,659 <br /> MAX: 1,035,274 | AVG: 1,495,457 <br /> MIN: 1,495,161 <br /> MAX: 1,495,776 | AVG: 206,112 <br /> MIN: 206,112 <br /> MAX: 206,112 |
| newhope512cca (100 executions) | clean | AVG: 719,785 <br /> MIN: 719,577 <br /> MAX: 720,072 | AVG: 1,134,083 <br /> MIN: 1,133,875 <br /> MAX: 1,134,370 | AVG: 1,192,460 <br /> MIN: 1,192,253 <br /> MAX: 1,192,748 |
| newhope512cpa (100 executions) | clean | AVG: 628,310 <br /> MIN: 628,073 <br /> MAX: 628,508 | AVG: 915,293 <br /> MIN: 915,056 <br /> MAX: 915,491 | AVG: 163,222 <br /> MIN: 163,222 <br /> MAX: 163,222 |
| ntruhps2048509 (100 executions) | clean | AVG: 107,331,110 <br /> MIN: 107,331,110 <br /> MAX: 107,331,110 | AVG: 2,876,597 <br /> MIN: 2,876,597 <br /> MAX: 2,876,597 | AVG: 7,495,670 <br /> MIN: 7,495,670 <br /> MAX: 7,495,670 |
| ntruhps2048509 (100 executions) | m4 | AVG: 77,698,713 <br /> MIN: 77,698,713 <br /> MAX: 77,698,713 | AVG: 645,329 <br /> MIN: 645,329 <br /> MAX: 645,329 | AVG: 542,439 <br /> MIN: 542,439 <br /> MAX: 542,439 |
| ntruhps2048677 (100 executions) | clean | AVG: 196,228,850 <br /> MIN: 196,228,850 <br /> MAX: 196,228,850 | AVG: 4,909,724 <br /> MIN: 4,909,724 <br /> MAX: 4,909,724 | AVG: 13,157,491 <br /> MIN: 13,157,491 <br /> MAX: 13,157,491 |
| ntruhps2048677 (100 executions) | m4 | AVG: 144,383,491 <br /> MIN: 144,383,491 <br /> MAX: 144,383,491 | AVG: 955,902 <br /> MIN: 955,902 <br /> MAX: 955,902 | AVG: 836,959 <br /> MIN: 836,959 <br /> MAX: 836,959 |
| ntruhps4096821 (100 executions) | clean | AVG: 289,736,570 <br /> MIN: 289,736,570 <br /> MAX: 289,736,570 | AVG: 7,046,106 <br /> MIN: 7,046,106 <br /> MAX: 7,046,106 | AVG: 19,262,764 <br /> MIN: 19,262,764 <br /> MAX: 19,262,764 |
| ntruhps4096821 (100 executions) | m4 | AVG: 211,758,452 <br /> MIN: 211,758,452 <br /> MAX: 211,758,452 | AVG: 1,205,662 <br /> MIN: 1,205,662 <br /> MAX: 1,205,662 | AVG: 1,066,879 <br /> MIN: 1,066,879 <br /> MAX: 1,066,879 |
| ntruhrss701 (100 executions) | clean | AVG: 208,992,073 <br /> MIN: 208,992,073 <br /> MAX: 208,992,073 | AVG: 4,656,818 <br /> MIN: 4,656,818 <br /> MAX: 4,656,818 | AVG: 14,142,725 <br /> MIN: 14,142,725 <br /> MAX: 14,142,725 |
| ntruhrss701 (100 executions) | m4 | AVG: 154,676,705 <br /> MIN: 154,676,705 <br /> MAX: 154,676,705 | AVG: 402,784 <br /> MIN: 402,784 <br /> MAX: 402,784 | AVG: 890,231 <br /> MIN: 890,231 <br /> MAX: 890,231 |
| ntrulpr653 (100 executions) | ref | AVG: 54,824,768 <br /> MIN: 54,824,768 <br /> MAX: 54,824,768 | AVG: 109,094,505 <br /> MIN: 109,094,505 <br /> MAX: 109,094,505 | AVG: 163,062,035 <br /> MIN: 163,062,035 <br /> MAX: 163,062,035 |
| ntrulpr761 (100 executions) | ref | AVG: 74,265,583 <br /> MIN: 74,265,583 <br /> MAX: 74,265,583 | AVG: 147,846,761 <br /> MIN: 147,846,761 <br /> MAX: 147,846,761 | AVG: 221,088,122 <br /> MIN: 221,088,122 <br /> MAX: 221,088,122 |
| ntrulpr857 (100 executions) | ref | AVG: 94,016,969 <br /> MIN: 94,016,969 <br /> MAX: 94,016,969 | AVG: 187,235,730 <br /> MIN: 187,235,730 <br /> MAX: 187,235,730 | AVG: 280,075,965 <br /> MIN: 280,075,965 <br /> MAX: 280,075,965 |
| papabear (100 executions) | opt | AVG: 2,014,216 <br /> MIN: 2,014,216 <br /> MAX: 2,014,216 | AVG: 2,276,138 <br /> MIN: 2,276,138 <br /> MAX: 2,276,138 | AVG: 3,000,239 <br /> MIN: 3,000,239 <br /> MAX: 3,000,239 |
| papabear (100 executions) | ref | AVG: 15,478,896 <br /> MIN: 15,478,896 <br /> MAX: 15,478,896 | AVG: 19,098,191 <br /> MIN: 19,098,191 <br /> MAX: 19,098,191 | AVG: 38,361,009 <br /> MIN: 38,361,009 <br /> MAX: 38,361,009 |
| papabear-ephem (100 executions) | opt | AVG: 2,029,284 <br /> MIN: 2,029,284 <br /> MAX: 2,029,284 | AVG: 2,308,148 <br /> MIN: 2,308,148 <br /> MAX: 2,308,148 | AVG: 411,623 <br /> MIN: 411,623 <br /> MAX: 411,623 |
| papabear-ephem (100 executions) | ref | AVG: 15,490,269 <br /> MIN: 15,490,269 <br /> MAX: 15,490,269 | AVG: 19,126,020 <br /> MIN: 19,126,020 <br /> MAX: 19,126,020 | AVG: 3,803,444 <br /> MIN: 3,803,444 <br /> MAX: 3,803,444 |
| saber (100 executions) | m4 | AVG: 896,035 <br /> MIN: 896,035 <br /> MAX: 896,035 | AVG: 1,161,849 <br /> MIN: 1,161,849 <br /> MAX: 1,161,849 | AVG: 1,204,633 <br /> MIN: 1,204,633 <br /> MAX: 1,204,633 |
| saber (100 executions) | ref | AVG: 2,226,935 <br /> MIN: 2,226,935 <br /> MAX: 2,226,935 | AVG: 2,936,240 <br /> MIN: 2,936,240 <br /> MAX: 2,936,240 | AVG: 3,424,601 <br /> MIN: 3,424,601 <br /> MAX: 3,424,601 |
| sikep434 (1 executions) | opt | AVG: 650,735,516 <br /> MIN: 650,735,516 <br /> MAX: 650,735,516 | AVG: 1,065,631,547 <br /> MIN: 1,065,631,547 <br /> MAX: 1,065,631,547 | AVG: 1,136,703,605 <br /> MIN: 1,136,703,605 <br /> MAX: 1,136,703,605 |
| sikep503 (1 executions) | opt | AVG: 985,032,805 <br /> MIN: 985,032,805 <br /> MAX: 985,032,805 | AVG: 1,623,893,046 <br /> MIN: 1,623,893,046 <br /> MAX: 1,623,893,046 | AVG: 1,726,538,272 <br /> MIN: 1,726,538,272 <br /> MAX: 1,726,538,272 |
| sikep610 (1 executions) | opt | AVG: 1,819,652,559 <br /> MIN: 1,819,652,559 <br /> MAX: 1,819,652,559 | AVG: 3,348,669,891 <br /> MIN: 3,348,669,891 <br /> MAX: 3,348,669,891 | AVG: 3,368,114,366 <br /> MIN: 3,368,114,366 <br /> MAX: 3,368,114,366 |
| sikep751 (1 executions) | opt | AVG: 3,296,225,272 <br /> MIN: 3,296,225,272 <br /> MAX: 3,296,225,272 | AVG: 5,347,056,677 <br /> MIN: 5,347,056,677 <br /> MAX: 5,347,056,677 | AVG: 5,742,522,048 <br /> MIN: 5,742,522,048 <br /> MAX: 5,742,522,048 |
| sntrup653 (100 executions) | ref | AVG: 566,054,965 <br /> MIN: 558,628,717 <br /> MAX: 806,170,326 | AVG: 54,942,173 <br /> MIN: 54,942,173 <br /> MAX: 54,942,184 | AVG: 166,481,625 <br /> MIN: 166,481,625 <br /> MAX: 166,481,642 |
| sntrup761 (100 executions) | ref | AVG: 757,107,092 <br /> MIN: 757,107,092 <br /> MAX: 757,107,092 | AVG: 74,398,441 <br /> MIN: 74,398,441 <br /> MAX: 74,398,441 | AVG: 225,554,771 <br /> MIN: 225,554,771 <br /> MAX: 225,554,771 |
| sntrup857 (100 executions) | ref | AVG: 961,965,366 <br /> MIN: 961,965,366 <br /> MAX: 961,965,366 | AVG: 94,154,502 <br /> MIN: 94,154,502 <br /> MAX: 94,154,502 | AVG: 286,203,168 <br /> MIN: 286,203,168 <br /> MAX: 286,203,168 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| dilithium2 (100 executions) | clean | AVG: 1,752,194 <br /> MIN: 1,751,051 <br /> MAX: 1,764,500 | AVG: 9,342,087 <br /> MIN: 3,486,474 <br /> MAX: 26,959,258 | AVG: 2,035,881 <br /> MIN: 2,035,522 <br /> MAX: 2,036,394 |
| dilithium2 (100 executions) | m4 | AVG: 1,400,412 <br /> MIN: 1,399,149 <br /> MAX: 1,425,295 | AVG: 6,157,001 <br /> MIN: 2,000,255 <br /> MAX: 33,459,692 | AVG: 1,461,284 <br /> MIN: 1,460,880 <br /> MAX: 1,461,658 |
| dilithium3 (100 executions) | clean | AVG: 2,733,423 <br /> MIN: 2,732,625 <br /> MAX: 2,734,257 | AVG: 14,885,750 <br /> MIN: 4,809,910 <br /> MAX: 78,585,023 | AVG: 2,946,998 <br /> MIN: 2,946,203 <br /> MAX: 2,947,530 |
| dilithium3 (100 executions) | m4 | AVG: 2,282,485 <br /> MIN: 2,281,621 <br /> MAX: 2,283,222 | AVG: 9,289,499 <br /> MIN: 2,927,627 <br /> MAX: 35,651,483 | AVG: 2,228,898 <br /> MIN: 2,228,423 <br /> MAX: 2,229,477 |
| dilithium4 (100 executions) | clean | AVG: 3,647,486 <br /> MIN: 3,647,083 <br /> MAX: 3,647,892 | AVG: 13,615,651 <br /> MIN: 6,313,249 <br /> MAX: 43,824,110 | AVG: 4,035,259 <br /> MIN: 4,034,802 <br /> MAX: 4,035,897 |
| dilithium4 (100 executions) | m4 | AVG: 3,097,421 <br /> MIN: 3,097,005 <br /> MAX: 3,097,731 | AVG: 8,468,805 <br /> MIN: 4,033,922 <br /> MAX: 20,081,029 | AVG: 3,173,500 <br /> MIN: 3,172,863 <br /> MAX: 3,174,125 |
| luov-48-43-222-chacha (100 executions) | ref | AVG: 41,347,565 <br /> MIN: 41,077,732 <br /> MAX: 41,585,440 | AVG: 123,878,410 <br /> MIN: 123,825,414 <br /> MAX: 123,912,572 | AVG: 95,330,045 <br /> MIN: 95,317,535 <br /> MAX: 95,343,473 |
| luov-48-43-222-keccak (100 executions) | ref | AVG: 53,900,163 <br /> MIN: 53,649,451 <br /> MAX: 54,074,274 | AVG: 135,960,322 <br /> MIN: 135,913,707 <br /> MAX: 136,018,359 | AVG: 107,793,279 <br /> MIN: 107,783,143 <br /> MAX: 107,803,188 |
| luov-64-61-302-chacha (100 executions) | ref | AVG: 109,063,798 <br /> MIN: 108,677,813 <br /> MAX: 109,472,193 | AVG: 405,205,796 <br /> MIN: 405,092,541 <br /> MAX: 405,292,253 | AVG: 269,012,028 <br /> MIN: 268,981,066 <br /> MAX: 269,034,087 |
| luov-64-61-302-keccak (100 executions) | ref | AVG: 148,680,619 <br /> MIN: 148,155,686 <br /> MAX: 149,194,782 | AVG: 441,086,753 <br /> MIN: 441,025,976 <br /> MAX: 441,153,566 | AVG: 318,677,042 <br /> MIN: 318,656,650 <br /> MAX: 318,699,951 |
| luov-8-58-237-chacha (100 executions) | ref | AVG: 66,072,054 <br /> MIN: 65,711,390 <br /> MAX: 66,460,756 | AVG: 101,874,776 <br /> MIN: 99,834,968 <br /> MAX: 199,249,932 | AVG: 77,433,705 <br /> MIN: 77,416,684 <br /> MAX: 77,440,674 |
| luov-8-58-237-keccak (100 executions) | ref | AVG: 87,785,091 <br /> MIN: 87,463,523 <br /> MAX: 88,201,213 | AVG: 119,711,856 <br /> MIN: 119,664,894 <br /> MAX: 119,739,349 | AVG: 81,240,915 <br /> MIN: 81,226,737 <br /> MAX: 81,247,471 |
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
| babybear | opt | 3,104 | 2,976 | 5,112 |
| babybear | ref | 6,168 | 6,088 | 10,192 |
| babybear-ephem | opt | 3,104 | 3,008 | 2,440 |
| babybear-ephem | ref | 6,168 | 6,088 | 4,864 |
| firesaber | m4 | 20,144 | 23,008 | 24,592 |
| firesaber | ref | 20,144 | 23,008 | 24,488 |
| frodokem640aes | m4 | 31,760 | 52,088 | 62,456 |
| frodokem640shake | m4 | 26,384 | 41,584 | 51,952 |
| frodokem640shake | opt | 36,704 | 58,360 | 78,976 |
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
| mamabear | opt | 3,592 | 3,464 | 6,072 |
| mamabear | ref | 6,792 | 6,712 | 11,600 |
| mamabear-ephem | opt | 3,592 | 3,488 | 2,920 |
| mamabear-ephem | ref | 6,792 | 6,712 | 4,864 |
| newhope1024cca | clean | 11,120 | 17,400 | 19,608 |
| newhope1024cca | m4 | 11,152 | 17,400 | 19,640 |
| newhope1024cpa | clean | 11,096 | 17,288 | 8,308 |
| newhope1024cpa | m4 | 11,128 | 17,288 | 8,328 |
| newhope512cca | clean | 5,992 | 9,208 | 10,328 |
| newhope512cpa | clean | 5,968 | 9,128 | 4,248 |
| ntruhps2048509 | clean | 11,784 | 6,896 | 5,192 |
| ntruhps2048509 | m4 | 21,412 | 15,452 | 14,828 |
| ntruhps2048677 | clean | 15,608 | 9,104 | 6,840 |
| ntruhps2048677 | m4 | 28,524 | 20,604 | 19,756 |
| ntruhps4096821 | clean | 18,880 | 10,992 | 8,344 |
| ntruhps4096821 | m4 | 34,532 | 24,924 | 23,980 |
| ntruhrss701 | clean | 14,216 | 7,420 | 8,612 |
| ntruhrss701 | m4 | 27,580 | 19,372 | 20,580 |
| ntrulpr653 | ref | 12,204 | 19,652 | 23,068 |
| ntrulpr761 | ref | 14,044 | 22,492 | 26,524 |
| ntrulpr857 | ref | 15,692 | 25,068 | 29,628 |
| papabear | opt | 4,072 | 3,944 | 7,032 |
| papabear | ref | 7,416 | 7,344 | 13,008 |
| papabear-ephem | opt | 4,072 | 3,968 | 3,400 |
| papabear-ephem | ref | 7,416 | 7,336 | 4,864 |
| saber | m4 | 13,256 | 15,544 | 16,640 |
| saber | ref | 13,624 | 15,912 | 17,008 |
| sikep434 | opt | 6,776 | 7,088 | 7,424 |
| sikep503 | opt | 6,848 | 7,232 | 7,600 |
| sikep610 | opt | 10,080 | 10,512 | 10,968 |
| sikep751 | opt | 11,624 | 11,768 | 12,328 |
| sntrup653 | ref | 13,976 | 14,004 | 16,700 |
| sntrup761 | ref | 16,248 | 16,028 | 19,156 |
| sntrup857 | ref | 18,264 | 17,908 | 21,444 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| dilithium2 | clean | 36,424 | 61,312 | 40,664 |
| dilithium2 | m4 | 36,424 | 61,312 | 40,664 |
| dilithium3 | clean | 50,752 | 81,792 | 55,000 |
| dilithium3 | m4 | 50,752 | 81,792 | 55,000 |
| dilithium4 | clean | 67,136 | 104,408 | 71,472 |
| dilithium4 | m4 | 67,136 | 104,408 | 71,472 |
| luov-48-43-222-chacha | ref | 2,968 | 4,720 | 2,732 |
| luov-48-43-222-keccak | ref | 3,240 | 4,872 | 3,120 |
| luov-64-61-302-chacha | ref | 3,736 | 6,896 | 4,504 |
| luov-64-61-302-keccak | ref | 4,152 | 7,144 | 4,928 |
| luov-8-58-237-chacha | ref | 3,216 | 3,224 | 1,440 |
| luov-8-58-237-keccak | ref | 3,632 | 3,216 | 2,144 |
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
| babybear | opt | 55.2% | 47.5% | 41.9% |
| babybear | ref | 8.4% | 6.2% | 6.5% |
| babybear-ephem | opt | 55.2% | 48.4% | 35.8% |
| babybear-ephem | ref | 8.4% | 6.5% | 4.3% |
| firesaber | m4 | 49.4% | 49.3% | 40.0% |
| firesaber | ref | 18.8% | 18.6% | 13.7% |
| frodokem640aes | m4 | 81.0% | 78.3% | 78.0% |
| frodokem640shake | m4 | 90.4% | 88.8% | 88.7% |
| frodokem640shake | opt | 75.6% | 65.0% | 64.4% |
| kyber1024 | clean | 58.8% | 58.0% | 47.4% |
| kyber1024 | m4 | 70.5% | 73.3% | 66.7% |
| kyber512 | clean | 54.6% | 53.5% | 38.9% |
| kyber512 | m4 | 68.9% | 72.5% | 61.6% |
| kyber768 | clean | 57.0% | 56.3% | 44.0% |
| kyber768 | m4 | 69.7% | 73.0% | 64.8% |
| lac128 | ref | 6.1% | 4.6% | 2.9% |
| lac192 | ref | 1.9% | 2.1% | 1.2% |
| lac256 | ref | 3.4% | 2.5% | 1.6% |
| mamabear | opt | 53.9% | 47.9% | 43.3% |
| mamabear | ref | 7.4% | 5.9% | 6.1% |
| mamabear-ephem | opt | 53.4% | 47.9% | 34.3% |
| mamabear-ephem | ref | 7.4% | 6.0% | 3.9% |
| lightsaber | m4 | 56.5% | 55.7% | 42.0% |
| lightsaber | ref | 24.7% | 23.6% | 15.3% |
| newhope1024cca | clean | 59.5% | 59.1% | 47.6% |
| newhope1024cca | m4 | 71.2% | 70.3% | 59.5% |
| newhope1024cpa | clean | 53.9% | 50.2% | 4.3% |
| newhope1024cpa | m4 | 66.3% | 62.2% | 6.8% |
| newhope512cca | clean | 61.4% | 61.5% | 49.9% |
| newhope512cpa | clean | 56.1% | 52.4% | 8.6% |
| ntruhps2048509 | clean | 0.0% | 0.9% | 1.4% |
| ntruhps2048509 | m4 | 0.0% | 4.1% | 19.0% |
| ntruhps2048677 | clean | 0.0% | 0.8% | 1.1% |
| ntruhps2048677 | m4 | 0.0% | 4.1% | 16.8% |
| ntruhps4096821 | clean | 0.0% | 0.6% | 0.9% |
| ntruhps4096821 | m4 | 0.0% | 3.2% | 15.6% |
| ntruhrss701 | clean | 0.0% | 0.8% | 1.1% |
| ntruhrss701 | m4 | 0.0% | 9.7% | 17.3% |
| ntrulpr653 | ref | 0.5% | 0.5% | 0.3% |
| ntrulpr761 | ref | 0.4% | 0.4% | 0.2% |
| ntrulpr857 | ref | 0.3% | 0.4% | 0.2% |
| papabear | opt | 52.7% | 47.9% | 44.0% |
| papabear | ref | 6.9% | 5.8% | 6.0% |
| papabear-ephem | opt | 52.3% | 47.9% | 33.2% |
| papabear-ephem | ref | 6.9% | 5.8% | 3.6% |
| saber | m4 | 53.0% | 52.9% | 41.5% |
| saber | ref | 21.3% | 20.9% | 14.6% |
| sikep434 | opt | 0.0% | 0.0% | 0.0% |
| sikep503 | opt | 0.0% | 0.0% | 0.0% |
| sikep610 | opt | 0.0% | 0.0% | 0.0% |
| sikep751 | opt | 0.0% | 0.0% | 0.0% |
| sntrup653 | ref | 0.0% | 0.5% | 0.1% |
| sntrup761 | ref | 0.0% | 0.5% | 0.1% |
| sntrup857 | ref | 0.0% | 0.4% | 0.1% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| dilithium2 | clean | 56.6% | 25.1% | 47.1% |
| dilithium2 | m4 | 70.8% | 44.4% | 65.6% |
| dilithium3 | clean | 61.4% | 26.9% | 51.4% |
| dilithium3 | m4 | 73.5% | 45.6% | 68.0% |
| dilithium4 | clean | 62.1% | 30.2% | 54.6% |
| dilithium4 | m4 | 73.1% | 49.8% | 69.4% |
| luov-48-43-222-chacha | ref | 0.3% | 0.1% | 0.0% |
| luov-48-43-222-keccak | ref | 30.7% | 12.2% | 15.3% |
| luov-64-61-302-chacha | ref | 0.2% | 0.1% | 0.0% |
| luov-64-61-302-keccak | ref | 33.3% | 11.3% | 15.5% |
| luov-8-58-237-chacha | ref | 0.3% | 0.2% | 0.0% |
| luov-8-58-237-keccak | ref | 30.6% | 22.5% | 32.9% |
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
| babybear | opt | 5,627 | 0 | 0 | 5,627 |
| babybear | ref | 4,922 | 0 | 0 | 4,922 |
| babybear-ephem | opt | 4,985 | 0 | 0 | 4,985 |
| babybear-ephem | ref | 4,892 | 0 | 0 | 4,892 |
| firesaber | m4 | 44,184 | 0 | 0 | 44,184 |
| firesaber | ref | 12,244 | 0 | 0 | 12,244 |
| frodokem640aes | m4 | 15,616 | 28 | 0 | 15,644 |
| frodokem640shake | m4 | 15,648 | 28 | 0 | 15,676 |
| frodokem640shake | opt | 6,664 | 0 | 0 | 6,664 |
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
| mamabear | opt | 5,623 | 0 | 0 | 5,623 |
| mamabear | ref | 5,414 | 0 | 0 | 5,414 |
| mamabear-ephem | opt | 4,917 | 0 | 0 | 4,917 |
| mamabear-ephem | ref | 4,900 | 0 | 0 | 4,900 |
| newhope1024cca | clean | 10,780 | 0 | 0 | 10,780 |
| newhope1024cca | m4 | 12,176 | 0 | 0 | 12,176 |
| newhope1024cpa | clean | 10,384 | 0 | 0 | 10,384 |
| newhope1024cpa | m4 | 11,780 | 0 | 0 | 11,780 |
| newhope512cca | clean | 7,016 | 0 | 0 | 7,016 |
| newhope512cpa | clean | 6,620 | 0 | 0 | 6,620 |
| ntruhps2048509 | clean | 6,916 | 0 | 0 | 6,916 |
| ntruhps2048509 | m4 | 89,140 | 0 | 0 | 89,140 |
| ntruhps2048677 | clean | 6,960 | 0 | 0 | 6,960 |
| ntruhps2048677 | m4 | 129,504 | 0 | 0 | 129,504 |
| ntruhps4096821 | clean | 6,684 | 0 | 0 | 6,684 |
| ntruhps4096821 | m4 | 154,460 | 0 | 0 | 154,460 |
| ntruhrss701 | clean | 6,828 | 0 | 0 | 6,828 |
| ntruhrss701 | m4 | 132,224 | 0 | 0 | 132,224 |
| ntrulpr653 | ref | 4,516 | 0 | 0 | 4,516 |
| ntrulpr761 | ref | 4,632 | 0 | 0 | 4,632 |
| ntrulpr857 | ref | 4,696 | 0 | 0 | 4,696 |
| papabear | opt | 5,559 | 0 | 0 | 5,559 |
| papabear | ref | 5,398 | 0 | 0 | 5,398 |
| papabear-ephem | opt | 4,877 | 0 | 0 | 4,877 |
| papabear-ephem | ref | 4,908 | 0 | 0 | 4,908 |
| saber | m4 | 44,468 | 0 | 0 | 44,468 |
| saber | ref | 12,524 | 0 | 0 | 12,524 |
| sikep434 | opt | 30,368 | 0 | 0 | 30,368 |
| sikep503 | opt | 31,376 | 0 | 0 | 31,376 |
| sikep610 | opt | 20,064 | 0 | 0 | 20,064 |
| sikep751 | opt | 21,692 | 0 | 0 | 21,692 |
| sntrup653 | ref | 6,028 | 0 | 0 | 6,028 |
| sntrup761 | ref | 6,164 | 0 | 0 | 6,164 |
| sntrup857 | ref | 6,148 | 0 | 0 | 6,148 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| dilithium2 | clean | 11,336 | 0 | 0 | 11,336 |
| dilithium2 | m4 | 13,948 | 0 | 0 | 13,948 |
| dilithium3 | clean | 11,144 | 0 | 0 | 11,144 |
| dilithium3 | m4 | 13,756 | 0 | 0 | 13,756 |
| dilithium4 | clean | 11,240 | 0 | 0 | 11,240 |
| dilithium4 | m4 | 13,852 | 0 | 0 | 13,852 |
| luov-48-43-222-chacha | ref | 405,722 | 36 | 0 | 405,758 |
| luov-48-43-222-keccak | ref | 405,730 | 36 | 0 | 405,766 |
| luov-64-61-302-chacha | ref | 405,412 | 36 | 0 | 405,448 |
| luov-64-61-302-keccak | ref | 405,452 | 36 | 0 | 405,488 |
| luov-8-58-237-chacha | ref | 404,920 | 36 | 0 | 404,956 |
| luov-8-58-237-keccak | ref | 404,924 | 36 | 0 | 404,960 |
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
