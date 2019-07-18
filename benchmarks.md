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
| frodokem640aes (100 executions) | m4 | AVG: 47,050,559 <br /> MIN: 47,050,559 <br /> MAX: 47,050,559 | AVG: 45,883,334 <br /> MIN: 45,883,334 <br /> MAX: 45,883,334 | AVG: 45,366,065 <br /> MIN: 45,366,065 <br /> MAX: 45,366,065 |
| frodokem640shake (100 executions) | m4 | AVG: 79,331,373 <br /> MIN: 79,331,373 <br /> MAX: 79,331,373 | AVG: 79,745,404 <br /> MIN: 79,745,404 <br /> MAX: 79,745,404 | AVG: 79,231,474 <br /> MIN: 79,231,474 <br /> MAX: 79,231,474 |
| frodokem640shake (100 executions) | opt | AVG: 91,087,806 <br /> MIN: 91,087,806 <br /> MAX: 91,087,806 | AVG: 105,377,455 <br /> MIN: 105,377,455 <br /> MAX: 105,377,455 | AVG: 105,133,550 <br /> MIN: 105,133,550 <br /> MAX: 105,133,550 |
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
| r5n1-1kemcca-0d (100 executions) | m4 | AVG: 5,553,096 <br /> MIN: 5,528,895 <br /> MAX: 5,584,754 | AVG: 4,437,003 <br /> MIN: 4,405,596 <br /> MAX: 4,472,572 | AVG: 5,279,762 <br /> MIN: 5,237,652 <br /> MAX: 5,312,018 |
| r5n1-1kemcca-0d (100 executions) | opt | AVG: 5,388,610 <br /> MIN: 5,368,672 <br /> MAX: 5,413,369 | AVG: 5,692,748 <br /> MIN: 5,674,149 <br /> MAX: 5,706,188 | AVG: 6,535,000 <br /> MIN: 6,512,276 <br /> MAX: 6,564,933 |
| r5n1-1kemcca-0d-sneik (100 executions) | m4 | AVG: 4,690,949 <br /> MIN: 4,683,669 <br /> MAX: 4,699,309 | AVG: 3,270,847 <br /> MIN: 3,249,060 <br /> MAX: 3,293,286 | AVG: 3,650,559 <br /> MIN: 3,627,413 <br /> MAX: 3,675,346 |
| r5n1-1kemcca-0d-sneik (100 executions) | opt | AVG: 4,616,510 <br /> MIN: 4,610,675 <br /> MAX: 4,626,207 | AVG: 4,756,084 <br /> MIN: 4,745,225 <br /> MAX: 4,763,583 | AVG: 5,174,603 <br /> MIN: 5,163,035 <br /> MAX: 5,188,883 |
| r5n1-3kemcca-0d (100 executions) | m4 | AVG: 8,891,809 <br /> MIN: 8,872,866 <br /> MAX: 8,918,344 | AVG: 7,424,266 <br /> MIN: 7,388,964 <br /> MAX: 7,481,433 | AVG: 8,449,118 <br /> MIN: 8,411,011 <br /> MAX: 8,504,217 |
| r5n1-3kemcca-0d (100 executions) | opt | AVG: 8,614,772 <br /> MIN: 8,599,297 <br /> MAX: 8,646,754 | AVG: 9,366,074 <br /> MIN: 9,346,133 <br /> MAX: 9,396,630 | AVG: 10,390,737 <br /> MIN: 10,365,155 <br /> MAX: 10,436,552 |
| r5n1-3kemcca-0d-sneik (100 executions) | m4 | AVG: 7,809,290 <br /> MIN: 7,801,462 <br /> MAX: 7,818,039 | AVG: 6,593,661 <br /> MIN: 6,565,082 <br /> MAX: 6,628,817 | AVG: 7,101,979 <br /> MIN: 7,070,458 <br /> MAX: 7,135,035 |
| r5n1-3kemcca-0d-sneik (100 executions) | opt | AVG: 7,650,296 <br /> MIN: 7,642,603 <br /> MAX: 7,660,745 | AVG: 9,115,311 <br /> MIN: 9,108,152 <br /> MAX: 9,124,440 | AVG: 9,670,411 <br /> MIN: 9,659,421 <br /> MAX: 9,679,382 |
| r5n1-5kemcca-0d (100 executions) | m4 | AVG: 32,784,752 <br /> MIN: 32,719,356 <br /> MAX: 32,866,917 | AVG: 21,838,175 <br /> MIN: 21,718,583 <br /> MAX: 21,929,039 | AVG: 25,468,525 <br /> MIN: 25,332,047 <br /> MAX: 25,615,365 |
| r5n1-5kemcca-0d (100 executions) | opt | AVG: 31,668,323 <br /> MIN: 31,601,218 <br /> MAX: 31,732,915 | AVG: 30,323,237 <br /> MIN: 30,243,723 <br /> MAX: 30,380,873 | AVG: 33,960,444 <br /> MIN: 33,854,399 <br /> MAX: 34,050,103 |
| r5n1-5kemcca-0d-sneik (100 executions) | m4 | AVG: 30,314,113 <br /> MIN: 30,280,467 <br /> MAX: 30,342,784 | AVG: 19,777,686 <br /> MIN: 19,687,342 <br /> MAX: 19,850,406 | AVG: 21,557,440 <br /> MIN: 21,444,697 <br /> MAX: 21,652,359 |
| r5n1-5kemcca-0d-sneik (100 executions) | opt | AVG: 29,524,911 <br /> MIN: 29,482,326 <br /> MAX: 29,561,499 | AVG: 29,343,146 <br /> MIN: 29,315,436 <br /> MAX: 29,382,415 | AVG: 31,355,544 <br /> MIN: 31,309,866 <br /> MAX: 31,397,514 |
| r5nd-1kemcca-0d (100 executions) | m4 | AVG: 304,296 <br /> MIN: 301,317 <br /> MAX: 308,338 | AVG: 456,780 <br /> MIN: 452,979 <br /> MAX: 460,278 | AVG: 540,076 <br /> MIN: 536,700 <br /> MAX: 543,587 |
| r5nd-1kemcca-0d (100 executions) | opt | AVG: 385,047 <br /> MIN: 382,804 <br /> MAX: 386,718 | AVG: 553,492 <br /> MIN: 550,881 <br /> MAX: 555,237 | AVG: 652,222 <br /> MIN: 649,476 <br /> MAX: 654,859 |
| r5nd-1kemcca-0d-sneik (100 executions) | m4 | AVG: 194,377 <br /> MIN: 190,889 <br /> MAX: 198,046 | AVG: 294,350 <br /> MIN: 191,562 <br /> MAX: 304,501 | AVG: 348,016 <br /> MIN: 299,103 <br /> MAX: 354,611 |
| r5nd-1kemcca-0d-sneik (100 executions) | opt | AVG: 289,227 <br /> MIN: 287,104 <br /> MAX: 291,136 | AVG: 428,528 <br /> MIN: 289,030 <br /> MAX: 432,195 | AVG: 497,356 <br /> MIN: 427,519 <br /> MAX: 500,444 |
| r5nd-1kemcca-5d (100 executions) | m4 | AVG: 341,725 <br /> MIN: 338,738 <br /> MAX: 346,915 | AVG: 541,305 <br /> MIN: 537,714 <br /> MAX: 545,321 | AVG: 724,861 <br /> MIN: 717,831 <br /> MAX: 730,985 |
| r5nd-1kemcca-5d (100 executions) | opt | AVG: 441,336 <br /> MIN: 438,163 <br /> MAX: 444,859 | AVG: 715,940 <br /> MIN: 712,443 <br /> MAX: 719,170 | AVG: 974,817 <br /> MIN: 968,864 <br /> MAX: 981,257 |
| r5nd-1kemcca-5d-sneik (100 executions) | m4 | AVG: 234,928 <br /> MIN: 231,907 <br /> MAX: 237,547 | AVG: 396,238 <br /> MIN: 235,242 <br /> MAX: 401,178 | AVG: 529,570 <br /> MIN: 398,170 <br /> MAX: 535,344 |
| r5nd-1kemcca-5d-sneik (100 executions) | opt | AVG: 347,346 <br /> MIN: 345,355 <br /> MAX: 348,707 | AVG: 600,114 <br /> MIN: 596,389 <br /> MAX: 602,869 | AVG: 812,236 <br /> MIN: 808,255 <br /> MAX: 816,623 |
| r5nd-3kemcca-0d (100 executions) | m4 | AVG: 1,014,871 <br /> MIN: 1,006,750 <br /> MAX: 1,032,856 | AVG: 1,443,502 <br /> MIN: 1,428,564 <br /> MAX: 1,462,606 | AVG: 1,876,446 <br /> MIN: 1,857,387 <br /> MAX: 1,904,893 |
| r5nd-3kemcca-0d (100 executions) | opt | AVG: 1,390,259 <br /> MIN: 1,383,328 <br /> MAX: 1,405,827 | AVG: 2,014,897 <br /> MIN: 2,004,897 <br /> MAX: 2,030,421 | AVG: 2,643,688 <br /> MIN: 2,631,305 <br /> MAX: 2,671,949 |
| r5nd-3kemcca-0d-sneik (100 executions) | m4 | AVG: 781,124 <br /> MIN: 773,703 <br /> MAX: 789,415 | AVG: 1,240,140 <br /> MIN: 1,230,369 <br /> MAX: 1,252,957 | AVG: 1,545,374 <br /> MIN: 1,533,305 <br /> MAX: 1,559,568 |
| r5nd-3kemcca-0d-sneik (100 executions) | opt | AVG: 1,184,997 <br /> MIN: 1,180,390 <br /> MAX: 1,188,684 | AVG: 1,900,960 <br /> MIN: 1,895,436 <br /> MAX: 1,906,232 | AVG: 2,413,390 <br /> MIN: 2,406,473 <br /> MAX: 2,421,042 |
| r5nd-3kemcca-5d (100 executions) | m4 | AVG: 674,743 <br /> MIN: 668,121 <br /> MAX: 680,580 | AVG: 1,011,757 <br /> MIN: 1,006,492 <br /> MAX: 1,016,326 | AVG: 1,303,079 <br /> MIN: 1,296,571 <br /> MAX: 1,311,190 |
| r5nd-3kemcca-5d (100 executions) | opt | AVG: 903,289 <br /> MIN: 900,332 <br /> MAX: 907,829 | AVG: 1,390,057 <br /> MIN: 1,376,058 <br /> MAX: 1,393,573 | AVG: 1,830,592 <br /> MIN: 1,818,562 <br /> MAX: 1,837,349 |
| r5nd-3kemcca-5d-sneik (100 executions) | m4 | AVG: 488,951 <br /> MIN: 483,711 <br /> MAX: 495,979 | AVG: 854,551 <br /> MIN: 850,891 <br /> MAX: 858,762 | AVG: 1,069,093 <br /> MIN: 1,063,550 <br /> MAX: 1,075,318 |
| r5nd-3kemcca-5d-sneik (100 executions) | opt | AVG: 741,196 <br /> MIN: 738,284 <br /> MAX: 744,000 | AVG: 1,302,493 <br /> MIN: 1,299,620 <br /> MAX: 1,306,334 | AVG: 1,673,018 <br /> MIN: 1,668,991 <br /> MAX: 1,679,577 |
| r5nd-5kemcca-0d (100 executions) | m4 | AVG: 1,356,508 <br /> MIN: 1,334,463 <br /> MAX: 1,375,504 | AVG: 1,945,123 <br /> MIN: 1,921,246 <br /> MAX: 1,960,484 | AVG: 2,498,516 <br /> MIN: 2,463,644 <br /> MAX: 2,517,480 |
| r5nd-5kemcca-0d (100 executions) | opt | AVG: 1,903,143 <br /> MIN: 1,886,302 <br /> MAX: 1,911,439 | AVG: 2,782,242 <br /> MIN: 2,760,871 <br /> MAX: 2,793,586 | AVG: 3,627,662 <br /> MIN: 3,598,807 <br /> MAX: 3,644,682 |
| r5nd-5kemcca-0d-sneik (100 executions) | m4 | AVG: 1,123,751 <br /> MIN: 1,111,035 <br /> MAX: 1,133,015 | AVG: 1,753,377 <br /> MIN: 1,741,799 <br /> MAX: 1,766,219 | AVG: 2,182,486 <br /> MIN: 2,169,353 <br /> MAX: 2,198,074 |
| r5nd-5kemcca-0d-sneik (100 executions) | opt | AVG: 1,711,895 <br /> MIN: 1,705,415 <br /> MAX: 1,721,259 | AVG: 2,712,382 <br /> MIN: 2,708,610 <br /> MAX: 2,716,955 | AVG: 3,447,723 <br /> MIN: 3,436,071 <br /> MAX: 3,455,796 |
| r5nd-5kemcca-5d (100 executions) | m4 | AVG: 1,228,319 <br /> MIN: 1,206,833 <br /> MAX: 1,241,541 | AVG: 1,782,156 <br /> MIN: 1,766,463 <br /> MAX: 1,792,894 | AVG: 2,332,469 <br /> MIN: 2,306,142 <br /> MAX: 2,351,536 |
| r5nd-5kemcca-5d (100 executions) | opt | AVG: 1,710,318 <br /> MIN: 1,697,009 <br /> MAX: 1,719,162 | AVG: 2,571,737 <br /> MIN: 2,557,935 <br /> MAX: 2,579,964 | AVG: 3,426,802 <br /> MIN: 3,402,743 <br /> MAX: 3,441,638 |
| r5nd-5kemcca-5d-sneik (100 executions) | m4 | AVG: 1,002,690 <br /> MIN: 992,802 <br /> MAX: 1,012,147 | AVG: 1,581,058 <br /> MIN: 1,573,205 <br /> MAX: 1,591,395 | AVG: 2,007,861 <br /> MIN: 1,999,794 <br /> MAX: 2,017,819 |
| r5nd-5kemcca-5d-sneik (100 executions) | opt | AVG: 1,526,381 <br /> MIN: 1,522,133 <br /> MAX: 1,531,972 | AVG: 2,468,323 <br /> MIN: 2,460,371 <br /> MAX: 2,475,035 | AVG: 3,215,298 <br /> MIN: 3,206,919 <br /> MAX: 3,224,380 |
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
| falcon1024 (100 executions) | m4-ct | AVG: 480,910,965 <br /> MIN: 318,710,413 <br /> MAX: 995,619,272 | AVG: 83,482,883 <br /> MIN: 83,258,612 <br /> MAX: 83,659,383 | AVG: 977,140 <br /> MIN: 966,990 <br /> MAX: 985,312 |
| falcon1024 (100 executions) | opt-ct | AVG: 690,147,063 <br /> MIN: 393,308,866 <br /> MAX: 1,952,834,094 | AVG: 136,596,407 <br /> MIN: 136,419,138 <br /> MAX: 136,826,634 | AVG: 978,558 <br /> MIN: 967,484 <br /> MAX: 985,578 |
| falcon1024 (100 executions) | opt-leaktime | AVG: 446,074,512 <br /> MIN: 290,113,568 <br /> MAX: 961,301,420 | AVG: 72,915,615 <br /> MIN: 72,598,158 <br /> MAX: 73,227,996 | AVG: 978,401 <br /> MIN: 967,573 <br /> MAX: 985,409 |
| falcon512 (100 executions) | m4-ct | AVG: 197,793,925 <br /> MIN: 115,046,457 <br /> MAX: 578,436,945 | AVG: 38,090,446 <br /> MIN: 37,971,516 <br /> MAX: 38,244,753 | AVG: 474,052 <br /> MIN: 465,554 <br /> MAX: 481,949 |
| falcon512 (100 executions) | opt-ct | AVG: 229,088,624 <br /> MIN: 147,666,429 <br /> MAX: 812,925,530 | AVG: 62,225,400 <br /> MIN: 62,051,681 <br /> MAX: 62,393,401 | AVG: 473,964 <br /> MIN: 465,996 <br /> MAX: 481,597 |
| falcon512 (100 executions) | opt-leaktime | AVG: 166,773,689 <br /> MIN: 102,904,024 <br /> MAX: 358,074,358 | AVG: 33,709,488 <br /> MIN: 33,475,429 <br /> MAX: 33,923,052 | AVG: 475,227 <br /> MIN: 465,282 <br /> MAX: 482,730 |
| falcon512-tree (100 executions) | m4-ct | AVG: 201,459,670 <br /> MIN: 130,210,248 <br /> MAX: 454,050,554 | AVG: 17,181,744 <br /> MIN: 17,062,306 <br /> MAX: 17,295,452 | AVG: 475,278 <br /> MIN: 465,806 <br /> MAX: 481,258 |
| falcon512-tree (100 executions) | opt-ct | AVG: 267,136,946 <br /> MIN: 173,342,269 <br /> MAX: 527,937,744 | AVG: 27,257,531 <br /> MIN: 27,124,430 <br /> MAX: 27,416,575 | AVG: 474,934 <br /> MIN: 465,123 <br /> MAX: 481,855 |
| falcon512-tree (100 executions) | opt-leaktime | AVG: 187,864,184 <br /> MIN: 114,425,808 <br /> MAX: 555,918,408 | AVG: 17,778,541 <br /> MIN: 17,608,010 <br /> MAX: 17,944,731 | AVG: 473,928 <br /> MIN: 465,072 <br /> MAX: 481,948 |
| luov-48-43-222-chacha (100 executions) | ref | AVG: 41,347,565 <br /> MIN: 41,077,732 <br /> MAX: 41,585,440 | AVG: 123,878,410 <br /> MIN: 123,825,414 <br /> MAX: 123,912,572 | AVG: 95,330,045 <br /> MIN: 95,317,535 <br /> MAX: 95,343,473 |
| luov-48-43-222-keccak (100 executions) | ref | AVG: 53,900,163 <br /> MIN: 53,649,451 <br /> MAX: 54,074,274 | AVG: 135,960,322 <br /> MIN: 135,913,707 <br /> MAX: 136,018,359 | AVG: 107,793,279 <br /> MIN: 107,783,143 <br /> MAX: 107,803,188 |
| luov-64-61-302-chacha (100 executions) | ref | AVG: 109,063,798 <br /> MIN: 108,677,813 <br /> MAX: 109,472,193 | AVG: 405,205,796 <br /> MIN: 405,092,541 <br /> MAX: 405,292,253 | AVG: 269,012,028 <br /> MIN: 268,981,066 <br /> MAX: 269,034,087 |
| luov-64-61-302-keccak (100 executions) | ref | AVG: 148,680,619 <br /> MIN: 148,155,686 <br /> MAX: 149,194,782 | AVG: 441,086,753 <br /> MIN: 441,025,976 <br /> MAX: 441,153,566 | AVG: 318,677,042 <br /> MIN: 318,656,650 <br /> MAX: 318,699,951 |
| luov-8-58-237-chacha (100 executions) | ref | AVG: 66,072,054 <br /> MIN: 65,711,390 <br /> MAX: 66,460,756 | AVG: 101,874,776 <br /> MIN: 99,834,968 <br /> MAX: 199,249,932 | AVG: 77,433,705 <br /> MIN: 77,416,684 <br /> MAX: 77,440,674 |
| luov-8-58-237-keccak (100 executions) | ref | AVG: 87,785,091 <br /> MIN: 87,463,523 <br /> MAX: 88,201,213 | AVG: 119,711,856 <br /> MIN: 119,664,894 <br /> MAX: 119,739,349 | AVG: 81,240,915 <br /> MIN: 81,226,737 <br /> MAX: 81,247,471 |
| qTesla-I (100 executions) | ref | AVG: 6,748,008 <br /> MIN: 4,718,221 <br /> MAX: 15,145,360 | AVG: 5,830,914 <br /> MIN: 1,066,990 <br /> MAX: 25,186,007 | AVG: 787,773 <br /> MIN: 784,665 <br /> MAX: 812,221 |
| qTesla-II (100 executions) | ref | AVG: 111,498,880 <br /> MIN: 84,950,740 <br /> MAX: 179,001,129 | AVG: 18,734,861 <br /> MIN: 4,469,357 <br /> MAX: 87,168,944 | AVG: 3,227,979 <br /> MIN: 3,222,264 <br /> MAX: 3,276,264 |
| qTesla-III (100 executions) | ref | AVG: 19,834,717 <br /> MIN: 12,853,165 <br /> MAX: 83,232,862 | AVG: 6,846,333 <br /> MIN: 2,357,125 <br /> MAX: 41,571,316 | AVG: 1,651,066 <br /> MIN: 1,648,681 <br /> MAX: 1,677,254 |
| qTesla-V (100 executions) | ref | AVG: 114,962,361 <br /> MIN: 40,526,204 <br /> MAX: 538,341,171 | AVG: 24,436,890 <br /> MIN: 5,656,004 <br /> MAX: 93,661,870 | AVG: 3,736,553 <br /> MIN: 3,720,942 <br /> MAX: 3,828,317 |
| qTesla-V-size (100 executions) | ref | AVG: 2,648,199,757 <br /> MIN: 2,519,641,787 <br /> MAX: 3,004,394,141 | AVG: 42,516,447 <br /> MIN: 9,783,877 <br /> MAX: 182,213,541 | AVG: 7,102,967 <br /> MIN: 7,081,486 <br /> MAX: 7,160,993 |
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
| frodokem640aes | m4 | 31,992 | 62,488 | 83,112 |
| frodokem640shake | m4 | 26,528 | 51,904 | 72,600 |
| frodokem640shake | opt | 36,672 | 58,312 | 78,944 |
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
| r5n1-1kemcca-0d | m4 | 19,168 | 24,416 | 29,672 |
| r5n1-1kemcca-0d | opt | 19,168 | 24,416 | 29,672 |
| r5n1-1kemcca-0d-sneik | m4 | 18,704 | 24,096 | 29,352 |
| r5n1-1kemcca-0d-sneik | opt | 18,856 | 24,248 | 29,504 |
| r5n1-3kemcca-0d | m4 | 26,576 | 35,552 | 44,440 |
| r5n1-3kemcca-0d | opt | 26,576 | 35,552 | 44,440 |
| r5n1-3kemcca-0d-sneik | m4 | 26,128 | 35,224 | 44,112 |
| r5n1-3kemcca-0d-sneik | opt | 26,280 | 35,376 | 44,264 |
| r5n1-5kemcca-0d | m4 | 40,272 | 54,696 | 65,535 |
| r5n1-5kemcca-0d | opt | 40,272 | 54,696 | 57,343 |
| r5n1-5kemcca-0d-sneik | m4 | 39,808 | 54,368 | 65,535 |
| r5n1-5kemcca-0d-sneik | opt | 39,960 | 54,520 | 68,840 |
| r5nd-1kemcca-0d | m4 | 4,704 | 5,528 | 6,224 |
| r5nd-1kemcca-0d | opt | 4,704 | 5,528 | 6,224 |
| r5nd-1kemcca-0d-sneik | m4 | 4,208 | 5,096 | 5,792 |
| r5nd-1kemcca-0d-sneik | opt | 4,360 | 5,248 | 5,944 |
| r5nd-1kemcca-5d | m4 | 4,055 | 4,879 | 5,447 |
| r5nd-1kemcca-5d | opt | 4,056 | 4,880 | 5,448 |
| r5nd-1kemcca-5d-sneik | m4 | 3,560 | 4,520 | 5,088 |
| r5nd-1kemcca-5d-sneik | opt | 3,712 | 4,672 | 5,240 |
| r5nd-3kemcca-0d | m4 | 6,280 | 8,024 | 9,000 |
| r5nd-3kemcca-0d | opt | 6,280 | 7,992 | 9,000 |
| r5nd-3kemcca-0d-sneik | m4 | 5,792 | 7,640 | 8,648 |
| r5nd-3kemcca-0d-sneik | opt | 5,944 | 7,792 | 8,800 |
| r5nd-3kemcca-5d | m4 | 5,808 | 7,080 | 7,960 |
| r5nd-3kemcca-5d | opt | 5,808 | 7,080 | 7,960 |
| r5nd-3kemcca-5d-sneik | m4 | 5,320 | 6,736 | 7,616 |
| r5nd-3kemcca-5d-sneik | opt | 5,472 | 6,888 | 7,768 |
| r5nd-5kemcca-0d | m4 | 7,760 | 10,080 | 11,416 |
| r5nd-5kemcca-0d | opt | 7,760 | 10,080 | 11,384 |
| r5nd-5kemcca-0d-sneik | m4 | 7,272 | 9,728 | 11,032 |
| r5nd-5kemcca-0d-sneik | opt | 7,424 | 9,880 | 11,184 |
| r5nd-5kemcca-5d | m4 | 7,264 | 8,872 | 9,968 |
| r5nd-5kemcca-5d | opt | 7,264 | 8,872 | 9,968 |
| r5nd-5kemcca-5d-sneik | m4 | 6,776 | 8,520 | 9,616 |
| r5nd-5kemcca-5d-sneik | opt | 6,928 | 8,672 | 9,768 |
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
| falcon1024 | m4-ct | 1,680 | 2,680 | 512 |
| falcon1024 | opt-ct | 1,680 | 2,612 | 512 |
| falcon1024 | opt-leaktime | 1,632 | 2,716 | 512 |
| falcon512 | m4-ct | 1,680 | 2,484 | 512 |
| falcon512 | opt-ct | 1,680 | 2,524 | 512 |
| falcon512 | opt-leaktime | 1,640 | 2,728 | 512 |
| falcon512-tree | m4-ct | 1,656 | 2,452 | 512 |
| falcon512-tree | opt-ct | 1,664 | 2,492 | 512 |
| falcon512-tree | opt-leaktime | 1,632 | 2,776 | 512 |
| luov-48-43-222-chacha | ref | 2,968 | 4,720 | 2,732 |
| luov-48-43-222-keccak | ref | 3,240 | 4,872 | 3,120 |
| luov-64-61-302-chacha | ref | 3,736 | 6,896 | 4,504 |
| luov-64-61-302-keccak | ref | 4,152 | 7,144 | 4,928 |
| luov-8-58-237-chacha | ref | 3,216 | 3,224 | 1,440 |
| luov-8-58-237-keccak | ref | 3,632 | 3,216 | 2,144 |
| qTesla-I | ref | 17,632 | 19,224 | 15,024 |
| qTesla-II | ref | 19,080 | 34,792 | 26,240 |
| qTesla-III | ref | 30,200 | 37,376 | 29,080 |
| qTesla-V | ref | 55,744 | 77,240 | 60,848 |
| qTesla-V-size | ref | 47,552 | 68,928 | 52,096 |
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
| frodokem640aes | m4 | 73.6% | 77.1% | 76.3% |
| frodokem640shake | m4 | 85.5% | 83.4% | 86.1% |
| frodokem640shake | opt | 74.9% | 65.4% | 64.9% |
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
| r5n1-1kemcca-0d | m4 | 20.5% | 93.5% | 46.1% |
| r5n1-1kemcca-0d | opt | 21.1% | 33.6% | 37.8% |
| r5n1-1kemcca-0d-sneik | m4 | 0.0% | 0.0% | 0.0% |
| r5n1-1kemcca-0d-sneik | opt | 0.0% | 0.0% | 0.0% |
| r5n1-3kemcca-0d | m4 | 16.6% | 41.2% | 43.7% |
| r5n1-3kemcca-0d | opt | 17.0% | 32.9% | 35.9% |
| r5n1-3kemcca-0d-sneik | m4 | 0.0% | 0.0% | 0.0% |
| r5n1-3kemcca-0d-sneik | opt | 0.0% | 0.0% | 0.0% |
| r5n1-5kemcca-0d | m4 | 11.6% | 18.1% | 34.6% |
| r5n1-5kemcca-0d | opt | 12.0% | 20.9% | 26.5% |
| r5n1-5kemcca-0d-sneik | m4 | 0.0% | 0.0% | 0.0% |
| r5n1-5kemcca-0d-sneik | opt | 0.0% | 0.0% | 0.0% |
| r5nd-1kemcca-0d | m4 | 46.6% | 56.4% | 54.6% |
| r5nd-1kemcca-0d | opt | 36.9% | 46.8% | 45.6% |
| r5nd-1kemcca-0d-sneik | m4 | 0.0% | 0.0% | 0.0% |
| r5nd-1kemcca-0d-sneik | opt | 0.0% | 0.0% | 0.0% |
| r5nd-1kemcca-5d | m4 | 40.4% | 42.6% | 40.2% |
| r5nd-1kemcca-5d | opt | 31.6% | 32.5% | 30.3% |
| r5nd-1kemcca-5d-sneik | m4 | 0.0% | 0.0% | 0.0% |
| r5nd-1kemcca-5d-sneik | opt | 0.0% | 0.0% | 0.0% |
| r5nd-3kemcca-0d | m4 | 30.9% | 34.9% | 35.4% |
| r5nd-3kemcca-0d | opt | 22.8% | 25.2% | 25.5% |
| r5nd-3kemcca-0d-sneik | m4 | 0.0% | 0.0% | 0.0% |
| r5nd-3kemcca-0d-sneik | opt | 0.0% | 0.0% | 0.0% |
| r5nd-3kemcca-5d | m4 | 36.7% | 40.7% | 39.0% |
| r5nd-3kemcca-5d | opt | 27.7% | 29.9% | 28.1% |
| r5nd-3kemcca-5d-sneik | m4 | 0.0% | 0.0% | 0.0% |
| r5nd-3kemcca-5d-sneik | opt | 0.0% | 0.0% | 0.0% |
| r5nd-5kemcca-0d | m4 | 27.1% | 30.9% | 31.1% |
| r5nd-5kemcca-0d | opt | 19.6% | 22.1% | 22.0% |
| r5nd-5kemcca-0d-sneik | m4 | 0.0% | 0.0% | 0.0% |
| r5nd-5kemcca-0d-sneik | opt | 0.0% | 0.0% | 0.0% |
| r5nd-5kemcca-5d | m4 | 28.8% | 31.9% | 32.0% |
| r5nd-5kemcca-5d | opt | 21.1% | 22.4% | 22.2% |
| r5nd-5kemcca-5d-sneik | m4 | 0.0% | 0.0% | 0.0% |
| r5nd-5kemcca-5d-sneik | opt | 0.0% | 0.0% | 0.0% |
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
| falcon1024 | m4-ct | 11.2% | 0.5% | 36.4% |
| falcon1024 | opt-ct | 7.9% | 0.3% | 34.2% |
| falcon1024 | opt-leaktime | 11.6% | 0.6% | 34.2% |
| falcon512 | m4-ct | 15.3% | 0.5% | 35.9% |
| falcon512 | opt-ct | 13.0% | 0.4% | 40.4% |
| falcon512 | opt-leaktime | 18.4% | 0.6% | 35.8% |
| falcon512-tree | m4-ct | 12.8% | 1.2% | 35.9% |
| falcon512-tree | opt-ct | 12.0% | 0.8% | 35.8% |
| falcon512-tree | opt-leaktime | 16.0% | 1.1% | 35.8% |
| luov-48-43-222-chacha | ref | 0.3% | 0.1% | 0.0% |
| luov-48-43-222-keccak | ref | 30.7% | 12.2% | 15.3% |
| luov-64-61-302-chacha | ref | 0.2% | 0.1% | 0.0% |
| luov-64-61-302-keccak | ref | 33.3% | 11.3% | 15.5% |
| luov-8-58-237-chacha | ref | 0.3% | 0.2% | 0.0% |
| luov-8-58-237-keccak | ref | 30.6% | 22.5% | 32.9% |
| qTesla-I | ref | 18.7% | 39.5% | 44.3% |
| qTesla-II | ref | 5.9% | 11.7% | 14.8% |
| qTesla-III | ref | 27.6% | 34.8% | 39.4% |
| qTesla-V | ref | 28.7% | 30.0% | 41.1% |
| qTesla-V-size | ref | 1.7% | 12.2% | 16.6% |
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
| frodokem640aes | m4 | 8,496 | 0 | 0 | 8,496 |
| frodokem640shake | m4 | 8,584 | 0 | 0 | 8,584 |
| frodokem640shake | opt | 6,464 | 0 | 0 | 6,464 |
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
| r5n1-1kemcca-0d | m4 | 3,297 | 0 | 0 | 3,297 |
| r5n1-1kemcca-0d | opt | 4,055 | 0 | 0 | 4,055 |
| r5n1-1kemcca-0d-sneik | m4 | 4,808 | 0 | 0 | 4,808 |
| r5n1-1kemcca-0d-sneik | opt | 6,591 | 0 | 0 | 6,591 |
| r5n1-3kemcca-0d | m4 | 3,425 | 0 | 0 | 3,425 |
| r5n1-3kemcca-0d | opt | 4,539 | 0 | 0 | 4,539 |
| r5n1-3kemcca-0d-sneik | m4 | 4,916 | 0 | 0 | 4,916 |
| r5n1-3kemcca-0d-sneik | opt | 7,055 | 0 | 0 | 7,055 |
| r5n1-5kemcca-0d | m4 | 3,473 | 0 | 0 | 3,473 |
| r5n1-5kemcca-0d | opt | 4,615 | 0 | 0 | 4,615 |
| r5n1-5kemcca-0d-sneik | m4 | 4,972 | 0 | 0 | 4,972 |
| r5n1-5kemcca-0d-sneik | opt | 7,139 | 0 | 0 | 7,139 |
| r5nd-1kemcca-0d | m4 | 2,651 | 0 | 0 | 2,651 |
| r5nd-1kemcca-0d | opt | 2,685 | 0 | 0 | 2,685 |
| r5nd-1kemcca-0d-sneik | m4 | 4,146 | 0 | 0 | 4,146 |
| r5nd-1kemcca-0d-sneik | opt | 5,205 | 0 | 0 | 5,205 |
| r5nd-1kemcca-5d | m4 | 5,623 | 0 | 0 | 5,623 |
| r5nd-1kemcca-5d | opt | 5,713 | 0 | 0 | 5,713 |
| r5nd-1kemcca-5d-sneik | m4 | 7,114 | 0 | 0 | 7,114 |
| r5nd-1kemcca-5d-sneik | opt | 8,229 | 0 | 0 | 8,229 |
| r5nd-3kemcca-0d | m4 | 2,879 | 0 | 0 | 2,879 |
| r5nd-3kemcca-0d | opt | 2,961 | 0 | 0 | 2,961 |
| r5nd-3kemcca-0d-sneik | m4 | 4,374 | 0 | 0 | 4,374 |
| r5nd-3kemcca-0d-sneik | opt | 5,481 | 0 | 0 | 5,481 |
| r5nd-3kemcca-5d | m4 | 6,975 | 0 | 0 | 6,975 |
| r5nd-3kemcca-5d | opt | 7,005 | 0 | 0 | 7,005 |
| r5nd-3kemcca-5d-sneik | m4 | 8,470 | 0 | 0 | 8,470 |
| r5nd-3kemcca-5d-sneik | opt | 9,525 | 0 | 0 | 9,525 |
| r5nd-5kemcca-0d | m4 | 2,927 | 0 | 0 | 2,927 |
| r5nd-5kemcca-0d | opt | 3,005 | 0 | 0 | 3,005 |
| r5nd-5kemcca-0d-sneik | m4 | 4,410 | 0 | 0 | 4,410 |
| r5nd-5kemcca-0d-sneik | opt | 5,513 | 0 | 0 | 5,513 |
| r5nd-5kemcca-5d | m4 | 4,507 | 0 | 0 | 4,507 |
| r5nd-5kemcca-5d | opt | 4,545 | 0 | 0 | 4,545 |
| r5nd-5kemcca-5d-sneik | m4 | 6,002 | 0 | 0 | 6,002 |
| r5nd-5kemcca-5d-sneik | opt | 7,065 | 0 | 0 | 7,065 |
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
| falcon1024 | m4-ct | 77,335 | 0 | 79,872 | 157,207 |
| falcon1024 | opt-ct | 76,203 | 0 | 79,872 | 156,075 |
| falcon1024 | opt-leaktime | 71,947 | 0 | 79,872 | 151,819 |
| falcon512 | m4-ct | 77,335 | 0 | 39,936 | 117,271 |
| falcon512 | opt-ct | 76,203 | 0 | 39,936 | 116,139 |
| falcon512 | opt-leaktime | 71,947 | 0 | 39,936 | 111,883 |
| falcon512-tree | m4-ct | 77,067 | 0 | 27,648 | 104,715 |
| falcon512-tree | opt-ct | 75,935 | 0 | 27,648 | 103,583 |
| falcon512-tree | opt-leaktime | 71,679 | 0 | 27,648 | 99,327 |
| luov-48-43-222-chacha | ref | 405,722 | 36 | 0 | 405,758 |
| luov-48-43-222-keccak | ref | 405,730 | 36 | 0 | 405,766 |
| luov-64-61-302-chacha | ref | 405,412 | 36 | 0 | 405,448 |
| luov-64-61-302-keccak | ref | 405,452 | 36 | 0 | 405,488 |
| luov-8-58-237-chacha | ref | 404,920 | 36 | 0 | 404,956 |
| luov-8-58-237-keccak | ref | 404,924 | 36 | 0 | 404,960 |
| qTesla-I | ref | 13,512 | 0 | 0 | 13,512 |
| qTesla-II | ref | 18,832 | 0 | 7,204 | 26,036 |
| qTesla-III | ref | 17,400 | 0 | 0 | 17,400 |
| qTesla-V | ref | 29,536 | 0 | 0 | 29,536 |
| qTesla-V-size | ref | 22,892 | 0 | 14,372 | 37,264 |
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
