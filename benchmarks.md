# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| babybear (100 executions) | clean | AVG: 4,031,805 <br /> MIN: 4,031,805 <br /> MAX: 4,031,805 | AVG: 5,878,092 <br /> MIN: 5,878,092 <br /> MAX: 5,878,092 | AVG: 11,997,012 <br /> MIN: 11,997,012 <br /> MAX: 11,997,012 |
| babybear (100 executions) | opt | AVG: 596,665 <br /> MIN: 596,665 <br /> MAX: 596,665 | AVG: 752,117 <br /> MIN: 752,117 <br /> MAX: 752,117 | AVG: 1,142,773 <br /> MIN: 1,142,773 <br /> MAX: 1,142,773 |
| babybear-ephem (100 executions) | opt | AVG: 596,664 <br /> MIN: 596,664 <br /> MAX: 596,664 | AVG: 767,860 <br /> MIN: 767,860 <br /> MAX: 767,860 | AVG: 231,728 <br /> MIN: 231,728 <br /> MAX: 231,728 |
| babybear-ephem (100 executions) | ref | AVG: 3,968,935 <br /> MIN: 3,968,935 <br /> MAX: 3,968,935 | AVG: 5,817,861 <br /> MIN: 5,817,861 <br /> MAX: 5,817,861 | AVG: 1,948,755 <br /> MIN: 1,948,755 <br /> MAX: 1,948,755 |
| firesaber (100 executions) | clean | AVG: 3,816,702 <br /> MIN: 3,816,702 <br /> MAX: 3,816,702 | AVG: 4,743,325 <br /> MIN: 4,743,325 <br /> MAX: 4,743,325 | AVG: 5,355,474 <br /> MIN: 5,355,474 <br /> MAX: 5,355,474 |
| firesaber (100 executions) | m4 | AVG: 1,448,776 <br /> MIN: 1,448,776 <br /> MAX: 1,448,776 | AVG: 1,786,930 <br /> MIN: 1,786,930 <br /> MAX: 1,786,930 | AVG: 1,853,339 <br /> MIN: 1,853,339 <br /> MAX: 1,853,339 |
| frodokem640aes (100 executions) | m4 | AVG: 47,050,559 <br /> MIN: 47,050,559 <br /> MAX: 47,050,559 | AVG: 45,883,334 <br /> MIN: 45,883,334 <br /> MAX: 45,883,334 | AVG: 45,366,065 <br /> MIN: 45,366,065 <br /> MAX: 45,366,065 |
| frodokem640shake (100 executions) | m4 | AVG: 79,331,373 <br /> MIN: 79,331,373 <br /> MAX: 79,331,373 | AVG: 79,745,404 <br /> MIN: 79,745,404 <br /> MAX: 79,745,404 | AVG: 79,231,474 <br /> MIN: 79,231,474 <br /> MAX: 79,231,474 |
| frodokem640shake (100 executions) | opt | AVG: 91,087,806 <br /> MIN: 91,087,806 <br /> MAX: 91,087,806 | AVG: 105,377,455 <br /> MIN: 105,377,455 <br /> MAX: 105,377,455 | AVG: 105,133,550 <br /> MIN: 105,133,550 <br /> MAX: 105,133,550 |
| kyber1024 (100 executions) | clean | AVG: 1,891,737 <br /> MIN: 1,890,901 <br /> MAX: 1,892,395 | AVG: 2,254,703 <br /> MIN: 2,253,866 <br /> MAX: 2,255,361 | AVG: 2,407,858 <br /> MIN: 2,407,023 <br /> MAX: 2,408,517 |
| kyber1024 (100 executions) | m4 | AVG: 1,575,052 <br /> MIN: 1,574,351 <br /> MAX: 1,575,691 | AVG: 1,779,848 <br /> MIN: 1,779,192 <br /> MAX: 1,780,463 | AVG: 1,709,348 <br /> MIN: 1,708,692 <br /> MAX: 1,709,962 |
| kyber1024-90s (100 executions) | clean | AVG: 1,478,991 <br /> MIN: 1,478,462 <br /> MAX: 1,479,601 | AVG: 1,730,351 <br /> MIN: 1,729,822 <br /> MAX: 1,730,961 | AVG: 1,985,801 <br /> MIN: 1,985,272 <br /> MAX: 1,986,411 |
| kyber1024-90s (100 executions) | m4 | AVG: 1,162,861 <br /> MIN: 1,162,317 <br /> MAX: 1,163,637 | AVG: 1,254,443 <br /> MIN: 1,253,947 <br /> MAX: 1,255,135 | AVG: 1,280,818 <br /> MIN: 1,280,322 <br /> MAX: 1,281,510 |
| kyber512 (100 executions) | clean | AVG: 649,678 <br /> MIN: 649,462 <br /> MAX: 649,984 | AVG: 884,848 <br /> MIN: 884,632 <br /> MAX: 885,154 | AVG: 985,258 <br /> MIN: 985,042 <br /> MAX: 985,564 |
| kyber512 (100 executions) | m4 | AVG: 514,291 <br /> MIN: 513,992 <br /> MAX: 514,547 | AVG: 652,769 <br /> MIN: 652,470 <br /> MAX: 653,025 | AVG: 621,245 <br /> MIN: 620,946 <br /> MAX: 621,501 |
| kyber512-90s (100 executions) | clean | AVG: 519,419 <br /> MIN: 519,195 <br /> MAX: 519,723 | AVG: 685,156 <br /> MIN: 684,932 <br /> MAX: 685,460 | AVG: 841,407 <br /> MIN: 841,183 <br /> MAX: 841,711 |
| kyber512-90s (100 executions) | m4 | AVG: 379,478 <br /> MIN: 379,206 <br /> MAX: 379,701 | AVG: 436,112 <br /> MIN: 379,227 <br /> MAX: 449,605 | AVG: 465,907 <br /> MIN: 449,131 <br /> MAX: 469,992 |
| kyber768 (100 executions) | clean | AVG: 1,196,692 <br /> MIN: 1,196,142 <br /> MAX: 1,197,186 | AVG: 1,489,909 <br /> MIN: 1,489,359 <br /> MAX: 1,490,403 | AVG: 1,613,744 <br /> MIN: 1,613,194 <br /> MAX: 1,614,238 |
| kyber768 (100 executions) | m4 | AVG: 976,757 <br /> MIN: 976,205 <br /> MAX: 977,165 | AVG: 1,146,556 <br /> MIN: 1,146,021 <br /> MAX: 1,146,937 | AVG: 1,094,849 <br /> MIN: 1,094,314 <br /> MAX: 1,095,229 |
| kyber768-90s (100 executions) | clean | AVG: 943,641 <br /> MIN: 943,343 <br /> MAX: 943,935 | AVG: 1,145,010 <br /> MIN: 1,144,712 <br /> MAX: 1,145,304 | AVG: 1,347,933 <br /> MIN: 1,347,635 <br /> MAX: 1,348,227 |
| kyber768-90s (100 executions) | m4 | AVG: 718,639 <br /> MIN: 718,121 <br /> MAX: 719,201 | AVG: 797,774 <br /> MIN: 797,301 <br /> MAX: 798,285 | AVG: 819,340 <br /> MIN: 818,867 <br /> MAX: 819,851 |
| lac128 (100 executions) | ref | AVG: 2,266,368 <br /> MIN: 2,254,917 <br /> MAX: 2,276,431 | AVG: 3,979,851 <br /> MIN: 3,968,056 <br /> MAX: 3,989,669 | AVG: 6,303,717 <br /> MIN: 6,291,865 <br /> MAX: 6,313,535 |
| lac192 (100 executions) | ref | AVG: 7,532,180 <br /> MIN: 7,525,427 <br /> MAX: 7,539,476 | AVG: 9,986,506 <br /> MIN: 9,979,643 <br /> MAX: 9,993,693 | AVG: 17,452,435 <br /> MIN: 17,445,553 <br /> MAX: 17,459,616 |
| lac256 (100 executions) | ref | AVG: 7,665,769 <br /> MIN: 7,652,402 <br /> MAX: 7,681,209 | AVG: 13,533,851 <br /> MIN: 13,517,064 <br /> MAX: 13,553,209 | AVG: 21,125,257 <br /> MIN: 21,108,384 <br /> MAX: 21,144,510 |
| lightsaber (100 executions) | clean | AVG: 1,051,133 <br /> MIN: 1,051,133 <br /> MAX: 1,051,133 | AVG: 1,537,170 <br /> MIN: 1,537,170 <br /> MAX: 1,537,170 | AVG: 1,860,400 <br /> MIN: 1,860,400 <br /> MAX: 1,860,400 |
| lightsaber (100 executions) | m4 | AVG: 459,965 <br /> MIN: 459,965 <br /> MAX: 459,965 | AVG: 651,273 <br /> MIN: 651,273 <br /> MAX: 651,273 | AVG: 678,810 <br /> MIN: 678,810 <br /> MAX: 678,810 |
| mamabear (100 executions) | clean | AVG: 8,861,427 <br /> MIN: 8,861,427 <br /> MAX: 8,861,427 | AVG: 11,598,380 <br /> MIN: 11,598,380 <br /> MAX: 11,598,380 | AVG: 23,520,327 <br /> MIN: 23,520,327 <br /> MAX: 23,520,327 |
| mamabear (100 executions) | opt | AVG: 1,195,048 <br /> MIN: 1,195,048 <br /> MAX: 1,195,048 | AVG: 1,402,955 <br /> MIN: 1,402,955 <br /> MAX: 1,402,955 | AVG: 1,955,496 <br /> MIN: 1,955,496 <br /> MAX: 1,955,496 |
| mamabear-ephem (100 executions) | opt | AVG: 1,206,350 <br /> MIN: 1,206,350 <br /> MAX: 1,206,350 | AVG: 1,431,341 <br /> MIN: 1,431,341 <br /> MAX: 1,431,341 | AVG: 320,233 <br /> MIN: 320,233 <br /> MAX: 320,233 |
| mamabear-ephem (100 executions) | ref | AVG: 8,783,565 <br /> MIN: 8,783,565 <br /> MAX: 8,783,565 | AVG: 11,525,870 <br /> MIN: 11,525,870 <br /> MAX: 11,525,870 | AVG: 2,876,105 <br /> MIN: 2,876,105 <br /> MAX: 2,876,105 |
| newhope1024cca (100 executions) | clean | AVG: 1,460,167 <br /> MIN: 1,459,836 <br /> MAX: 1,460,406 | AVG: 2,264,773 <br /> MIN: 2,264,441 <br /> MAX: 2,265,011 | AVG: 2,410,906 <br /> MIN: 2,410,574 <br /> MAX: 2,411,144 |
| newhope1024cca (100 executions) | m4 | AVG: 1,161,112 <br /> MIN: 1,160,786 <br /> MAX: 1,161,650 | AVG: 1,777,918 <br /> MIN: 1,777,592 <br /> MAX: 1,778,456 | AVG: 1,760,470 <br /> MIN: 1,760,144 <br /> MAX: 1,761,008 |
| newhope1024cpa (100 executions) | clean | AVG: 1,274,813 <br /> MIN: 1,274,572 <br /> MAX: 1,275,142 | AVG: 1,857,055 <br /> MIN: 1,856,813 <br /> MAX: 1,857,383 | AVG: 327,778 <br /> MIN: 327,778 <br /> MAX: 327,778 |
| newhope1024cpa (100 executions) | m4 | AVG: 975,736 <br /> MIN: 975,452 <br /> MAX: 976,190 | AVG: 1,371,633 <br /> MIN: 1,371,349 <br /> MAX: 1,372,087 | AVG: 162,660 <br /> MIN: 162,660 <br /> MAX: 162,660 |
| newhope512cca (100 executions) | clean | AVG: 719,785 <br /> MIN: 719,577 <br /> MAX: 720,072 | AVG: 1,134,083 <br /> MIN: 1,133,875 <br /> MAX: 1,134,370 | AVG: 1,192,460 <br /> MIN: 1,192,253 <br /> MAX: 1,192,748 |
| newhope512cca (100 executions) | m4 | AVG: 588,683 <br /> MIN: 588,327 <br /> MAX: 588,975 | AVG: 918,558 <br /> MIN: 918,202 <br /> MAX: 918,850 | AVG: 904,800 <br /> MIN: 904,443 <br /> MAX: 905,091 |
| newhope512cpa (100 executions) | clean | AVG: 628,310 <br /> MIN: 628,073 <br /> MAX: 628,508 | AVG: 915,293 <br /> MIN: 915,056 <br /> MAX: 915,491 | AVG: 163,222 <br /> MIN: 163,222 <br /> MAX: 163,222 |
| newhope512cpa (100 executions) | m4 | AVG: 497,229 <br /> MIN: 496,977 <br /> MAX: 497,499 | AVG: 700,489 <br /> MIN: 700,237 <br /> MAX: 700,759 | AVG: 90,403 <br /> MIN: 90,403 <br /> MAX: 90,403 |
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
| papabear (100 executions) | clean | AVG: 15,587,475 <br /> MIN: 15,587,475 <br /> MAX: 15,587,475 | AVG: 19,220,187 <br /> MIN: 19,220,187 <br /> MAX: 19,220,187 | AVG: 38,837,350 <br /> MIN: 38,837,350 <br /> MAX: 38,837,350 |
| papabear (100 executions) | opt | AVG: 2,014,216 <br /> MIN: 2,014,216 <br /> MAX: 2,014,216 | AVG: 2,276,138 <br /> MIN: 2,276,138 <br /> MAX: 2,276,138 | AVG: 3,000,239 <br /> MIN: 3,000,239 <br /> MAX: 3,000,239 |
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
| rollo-I-128 (100 executions) | ref | AVG: 14,204,882 <br /> MIN: 13,951,268 <br /> MAX: 14,326,983 | AVG: 1,362,927 <br /> MIN: 1,359,011 <br /> MAX: 1,368,781 | AVG: 17,078,749 <br /> MIN: 16,943,412 <br /> MAX: 17,215,108 |
| rollo-I-192 (100 executions) | ref | AVG: 18,015,802 <br /> MIN: 17,850,639 <br /> MAX: 18,191,823 | AVG: 1,561,907 <br /> MIN: 1,556,653 <br /> MAX: 1,566,421 | AVG: 38,169,707 <br /> MIN: 37,938,290 <br /> MAX: 38,466,672 |
| rollo-I-256 (100 executions) | ref | AVG: 28,211,833 <br /> MIN: 28,086,462 <br /> MAX: 28,316,829 | AVG: 2,294,035 <br /> MIN: 2,290,722 <br /> MAX: 2,300,610 | AVG: 76,268,605 <br /> MIN: 73,210,489 <br /> MAX: 76,615,737 |
| rollo-II-128 (100 executions) | ref | AVG: 110,973,444 <br /> MIN: 110,710,356 <br /> MAX: 111,218,877 | AVG: 8,959,177 <br /> MIN: 8,954,366 <br /> MAX: 8,965,825 | AVG: 56,666,802 <br /> MIN: 55,566,049 <br /> MAX: 57,118,092 |
| rollo-II-192 (100 executions) | ref | AVG: 118,268,825 <br /> MIN: 117,907,116 <br /> MAX: 118,510,650 | AVG: 9,217,207 <br /> MIN: 9,212,264 <br /> MAX: 9,222,489 | AVG: 78,857,280 <br /> MIN: 77,921,669 <br /> MAX: 79,282,320 |
| rollo-II-256 (100 executions) | ref | AVG: 158,353,913 <br /> MIN: 158,089,220 <br /> MAX: 158,615,286 | AVG: 12,067,870 <br /> MIN: 12,064,123 <br /> MAX: 12,072,323 | AVG: 93,156,495 <br /> MIN: 92,357,579 <br /> MAX: 94,208,177 |
| rollo-III-128 (100 executions) | ref | AVG: 1,376,566 <br /> MIN: 1,374,751 <br /> MAX: 1,379,322 | AVG: 2,705,954 <br /> MIN: 2,702,348 <br /> MAX: 2,712,307 | AVG: 16,854,530 <br /> MIN: 16,441,465 <br /> MAX: 17,026,998 |
| rollo-III-192 (100 executions) | ref | AVG: 1,730,053 <br /> MIN: 1,727,652 <br /> MAX: 1,733,190 | AVG: 3,402,446 <br /> MIN: 3,397,198 <br /> MAX: 3,411,496 | AVG: 42,648,986 <br /> MIN: 42,132,868 <br /> MAX: 42,810,996 |
| rollo-III-256 (100 executions) | ref | AVG: 4,521,615 <br /> MIN: 4,513,947 <br /> MAX: 4,526,054 | AVG: 8,948,193 <br /> MIN: 8,930,747 <br /> MAX: 8,960,505 | AVG: 67,092,647 <br /> MIN: 66,719,258 <br /> MAX: 67,746,529 |
| rqc128 (100 executions) | ref | AVG: 3,592,765 <br /> MIN: 3,566,894 <br /> MAX: 3,614,989 | AVG: 6,609,033 <br /> MIN: 6,582,242 <br /> MAX: 6,631,878 | AVG: 34,552,355 <br /> MIN: 34,415,749 <br /> MAX: 34,716,441 |
| rqc192 (100 executions) | ref | AVG: 7,017,984 <br /> MIN: 6,966,512 <br /> MAX: 9,625,612 | AVG: 12,286,806 <br /> MIN: 12,234,746 <br /> MAX: 14,893,515 | AVG: 72,041,577 <br /> MIN: 71,796,052 <br /> MAX: 77,303,153 |
| rqc256 (100 executions) | ref | AVG: 16,477,730 <br /> MIN: 16,361,795 <br /> MAX: 20,641,013 | AVG: 30,790,364 <br /> MIN: 30,667,653 <br /> MAX: 34,954,382 | AVG: 209,981,220 <br /> MIN: 209,563,013 <br /> MAX: 218,285,685 |
| saber (100 executions) | clean | AVG: 2,228,000 <br /> MIN: 2,228,000 <br /> MAX: 2,228,000 | AVG: 2,942,370 <br /> MIN: 2,942,370 <br /> MAX: 2,942,370 | AVG: 3,426,560 <br /> MIN: 3,426,560 <br /> MAX: 3,426,560 |
| saber (100 executions) | m4 | AVG: 896,035 <br /> MIN: 896,035 <br /> MAX: 896,035 | AVG: 1,161,849 <br /> MIN: 1,161,849 <br /> MAX: 1,161,849 | AVG: 1,204,633 <br /> MIN: 1,204,633 <br /> MAX: 1,204,633 |
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
| dilithium2 (100 executions) | m4 | AVG: 1,321,024 <br /> MIN: 1,320,179 <br /> MAX: 1,333,559 | AVG: 4,532,604 <br /> MIN: 1,816,743 <br /> MAX: 15,928,444 | AVG: 1,380,727 <br /> MIN: 1,380,351 <br /> MAX: 1,381,001 |
| dilithium3 (100 executions) | clean | AVG: 2,733,423 <br /> MIN: 2,732,625 <br /> MAX: 2,734,257 | AVG: 14,885,750 <br /> MIN: 4,809,910 <br /> MAX: 78,585,023 | AVG: 2,946,998 <br /> MIN: 2,946,203 <br /> MAX: 2,947,530 |
| dilithium3 (100 executions) | m4 | AVG: 2,161,469 <br /> MIN: 2,160,789 <br /> MAX: 2,162,172 | AVG: 6,466,018 <br /> MIN: 2,672,040 <br /> MAX: 26,348,899 | AVG: 2,103,914 <br /> MIN: 2,103,465 <br /> MAX: 2,104,240 |
| dilithium4 (100 executions) | clean | AVG: 3,647,486 <br /> MIN: 3,647,083 <br /> MAX: 3,647,892 | AVG: 13,615,651 <br /> MIN: 6,313,249 <br /> MAX: 43,824,110 | AVG: 4,035,259 <br /> MIN: 4,034,802 <br /> MAX: 4,035,897 |
| dilithium4 (100 executions) | m4 | AVG: 2,925,880 <br /> MIN: 2,925,380 <br /> MAX: 2,926,447 | AVG: 7,155,716 <br /> MIN: 3,697,113 <br /> MAX: 22,557,945 | AVG: 2,995,784 <br /> MIN: 2,995,334 <br /> MAX: 2,996,176 |
| falcon-1024 (100 executions) | clean | AVG: 633,596,142 <br /> MIN: 393,348,067 <br /> MAX: 2,302,666,654 | AVG: 139,679,948 <br /> MIN: 139,359,526 <br /> MAX: 140,070,893 | AVG: 1,462,493 <br /> MIN: 1,461,799 <br /> MAX: 1,463,128 |
| falcon-1024 (100 executions) | m4-ct | AVG: 499,400,925 <br /> MIN: 318,742,317 <br /> MAX: 1,253,550,021 | AVG: 85,341,105 <br /> MIN: 85,092,221 <br /> MAX: 85,586,529 | AVG: 978,893 <br /> MIN: 968,448 <br /> MAX: 986,132 |
| falcon-1024 (100 executions) | opt-ct | AVG: 519,707,869 <br /> MIN: 318,742,317 <br /> MAX: 1,294,535,633 | AVG: 85,358,537 <br /> MIN: 84,963,381 <br /> MAX: 85,780,750 | AVG: 980,781 <br /> MIN: 968,297 <br /> MAX: 986,950 |
| falcon-1024 (100 executions) | opt-leaktime | AVG: 402,537,602 <br /> MIN: 290,149,516 <br /> MAX: 815,005,911 | AVG: 76,457,595 <br /> MIN: 75,998,472 <br /> MAX: 77,181,953 | AVG: 978,060 <br /> MIN: 966,969 <br /> MAX: 986,412 |
| falcon-512 (100 executions) | clean | AVG: 244,672,139 <br /> MIN: 147,651,734 <br /> MAX: 703,505,375 | AVG: 63,881,276 <br /> MIN: 63,639,820 <br /> MAX: 64,103,227 | AVG: 737,407 <br /> MIN: 737,035 <br /> MAX: 737,809 |
| falcon-512 (100 executions) | m4-ct | AVG: 189,279,143 <br /> MIN: 115,030,624 <br /> MAX: 665,351,559 | AVG: 39,110,245 <br /> MIN: 38,938,057 <br /> MAX: 39,270,562 | AVG: 474,411 <br /> MIN: 465,785 <br /> MAX: 482,591 |
| falcon-512 (100 executions) | opt-ct | AVG: 188,803,547 <br /> MIN: 115,030,624 <br /> MAX: 411,628,821 | AVG: 39,103,738 <br /> MIN: 38,934,500 <br /> MAX: 39,278,155 | AVG: 474,673 <br /> MIN: 465,603 <br /> MAX: 482,763 |
| falcon-512 (100 executions) | opt-leaktime | AVG: 170,769,754 <br /> MIN: 102,851,611 <br /> MAX: 596,309,536 | AVG: 35,567,071 <br /> MIN: 35,313,000 <br /> MAX: 35,925,279 | AVG: 473,772 <br /> MIN: 465,930 <br /> MAX: 483,269 |
| falcon-512-tree (100 executions) | m4-ct | AVG: 195,637,141 <br /> MIN: 130,194,263 <br /> MAX: 536,085,876 | AVG: 17,872,505 <br /> MIN: 17,732,796 <br /> MAX: 18,110,875 | AVG: 475,187 <br /> MIN: 466,270 <br /> MAX: 482,051 |
| falcon-512-tree (100 executions) | opt-ct | AVG: 201,149,045 <br /> MIN: 130,194,263 <br /> MAX: 538,559,826 | AVG: 17,860,801 <br /> MIN: 17,580,307 <br /> MAX: 18,040,442 | AVG: 475,908 <br /> MIN: 466,133 <br /> MAX: 482,037 |
| falcon-512-tree (100 executions) | opt-leaktime | AVG: 165,270,188 <br /> MIN: 114,439,936 <br /> MAX: 474,389,761 | AVG: 19,297,052 <br /> MIN: 18,964,200 <br /> MAX: 19,590,188 | AVG: 475,015 <br /> MIN: 465,894 <br /> MAX: 482,453 |
| luov-47-42-182-chacha (100 executions) | ref | AVG: 28,433,080 <br /> MIN: 28,266,770 <br /> MAX: 28,666,408 | AVG: 60,235,732 <br /> MIN: 60,203,368 <br /> MAX: 60,287,111 | AVG: 42,150,229 <br /> MIN: 42,141,038 <br /> MAX: 42,164,346 |
| luov-47-42-182-keccak (100 executions) | ref | AVG: 37,012,989 <br /> MIN: 36,806,141 <br /> MAX: 37,215,582 | AVG: 68,234,509 <br /> MIN: 68,178,429 <br /> MAX: 68,275,058 | AVG: 50,742,235 <br /> MIN: 50,724,963 <br /> MAX: 50,755,062 |
| luov-61-60-261-chacha (100 executions) | ref | AVG: 81,045,939 <br /> MIN: 80,626,887 <br /> MAX: 81,412,109 | AVG: 251,945,670 <br /> MIN: 251,883,385 <br /> MAX: 252,007,252 | AVG: 137,405,740 <br /> MIN: 137,386,509 <br /> MAX: 137,424,782 |
| luov-61-60-261-keccak (100 executions) | ref | AVG: 110,888,141 <br /> MIN: 110,507,849 <br /> MAX: 111,225,488 | AVG: 282,283,375 <br /> MIN: 282,217,076 <br /> MAX: 282,361,965 | AVG: 167,305,418 <br /> MIN: 167,283,419 <br /> MAX: 167,328,186 |
| luov-7-57-197-chacha (100 executions) | ref | AVG: 48,115,203 <br /> MIN: 47,802,253 <br /> MAX: 48,446,889 | AVG: 75,576,631 <br /> MIN: 74,750,980 <br /> MAX: 149,130,735 | AVG: 46,865,501 <br /> MIN: 46,841,366 <br /> MAX: 46,879,871 |
| luov-7-57-197-keccak (100 executions) | ref | AVG: 62,524,021 <br /> MIN: 62,272,782 <br /> MAX: 62,822,216 | AVG: 89,733,512 <br /> MIN: 88,779,799 <br /> MAX: 177,189,888 | AVG: 57,939,192 <br /> MIN: 57,905,948 <br /> MAX: 57,957,915 |
| sphincs-haraka-128f-robust (1 executions) | clean | AVG: 125,493,736 <br /> MIN: 125,493,736 <br /> MAX: 125,493,736 | AVG: 4,720,156,509 <br /> MIN: 4,720,156,509 <br /> MAX: 4,720,156,509 | AVG: 196,103,540 <br /> MIN: 196,103,540 <br /> MAX: 196,103,540 |
| sphincs-haraka-128f-simple (1 executions) | clean | AVG: 91,770,060 <br /> MIN: 91,770,060 <br /> MAX: 91,770,060 | AVG: 3,286,409,908 <br /> MIN: 3,286,409,908 <br /> MAX: 3,286,409,908 | AVG: 136,522,968 <br /> MIN: 136,522,968 <br /> MAX: 136,522,968 |
| sphincs-haraka-128s-robust (1 executions) | clean | AVG: 3,994,078,037 <br /> MIN: 3,994,078,037 <br /> MAX: 3,994,078,037 | AVG: 76,355,806,675 <br /> MIN: 76,355,806,675 <br /> MAX: 76,355,806,675 | AVG: 90,503,982 <br /> MIN: 90,503,982 <br /> MAX: 90,503,982 |
| sphincs-haraka-128s-simple (1 executions) | clean | AVG: 2,913,690,564 <br /> MIN: 2,913,690,564 <br /> MAX: 2,913,690,564 | AVG: 52,263,758,103 <br /> MIN: 52,263,758,103 <br /> MAX: 52,263,758,103 | AVG: 62,469,217 <br /> MIN: 62,469,217 <br /> MAX: 62,469,217 |
| sphincs-haraka-192f-robust (1 executions) | clean | AVG: 186,298,605 <br /> MIN: 186,298,605 <br /> MAX: 186,298,605 | AVG: 5,628,829,365 <br /> MIN: 5,628,829,365 <br /> MAX: 5,628,829,365 | AVG: 312,841,777 <br /> MIN: 312,841,777 <br /> MAX: 312,841,777 |
| sphincs-haraka-192f-simple (1 executions) | clean | AVG: 135,187,443 <br /> MIN: 135,187,443 <br /> MAX: 135,187,443 | AVG: 3,878,154,505 <br /> MIN: 3,878,154,505 <br /> MAX: 3,878,154,505 | AVG: 216,987,235 <br /> MIN: 216,987,235 <br /> MAX: 216,987,235 |
| sphincs-haraka-192s-robust (1 executions) | clean | AVG: 5,940,440,596 <br /> MIN: 5,940,440,596 <br /> MAX: 5,940,440,596 | AVG: 190,008,645,997 <br /> MIN: 190,008,645,997 <br /> MAX: 190,008,645,997 | AVG: 139,236,350 <br /> MIN: 139,236,350 <br /> MAX: 139,236,350 |
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
| babybear | clean | 6,140 | 6,092 | 10,140 |
| babybear | opt | 3,104 | 2,976 | 5,112 |
| babybear-ephem | opt | 3,104 | 3,008 | 2,440 |
| babybear-ephem | ref | 6,168 | 6,088 | 4,864 |
| firesaber | clean | 22,848 | 25,600 | 27,088 |
| firesaber | m4 | 20,144 | 23,008 | 24,592 |
| frodokem640aes | m4 | 31,992 | 62,488 | 83,112 |
| frodokem640shake | m4 | 26,528 | 51,904 | 72,600 |
| frodokem640shake | opt | 36,672 | 58,312 | 78,944 |
| kyber1024 | clean | 15,224 | 18,928 | 20,496 |
| kyber1024 | m4 | 4,360 | 3,584 | 3,592 |
| kyber1024-90s | clean | 15,756 | 19,428 | 20,352 |
| kyber1024-90s | m4 | 5,564 | 4,020 | 4,052 |
| kyber512 | clean | 6,480 | 9,168 | 9,904 |
| kyber512 | m4 | 2,952 | 2,552 | 2,560 |
| kyber512-90s | clean | 6,996 | 9,652 | 10,404 |
| kyber512-90s | m4 | 3,460 | 3,012 | 3,036 |
| kyber768 | clean | 10,576 | 13,776 | 14,864 |
| kyber768 | m4 | 3,848 | 3,128 | 3,072 |
| kyber768-90s | clean | 11,092 | 14,260 | 15,364 |
| kyber768-90s | m4 | 5,052 | 3,508 | 3,540 |
| lac128 | ref | 2,916 | 5,116 | 5,952 |
| lac192 | ref | 4,344 | 7,464 | 8,664 |
| lac256 | ref | 4,452 | 8,676 | 10,116 |
| lightsaber | clean | 10,576 | 12,304 | 13,056 |
| lightsaber | m4 | 9,656 | 11,392 | 12,136 |
| mamabear | clean | 6,772 | 6,716 | 11,652 |
| mamabear | opt | 3,592 | 3,464 | 6,072 |
| mamabear-ephem | opt | 3,592 | 3,488 | 2,920 |
| mamabear-ephem | ref | 6,792 | 6,712 | 4,864 |
| newhope1024cca | clean | 11,120 | 17,400 | 19,608 |
| newhope1024cca | m4 | 11,080 | 17,360 | 19,576 |
| newhope1024cpa | clean | 11,096 | 17,288 | 8,308 |
| newhope1024cpa | m4 | 11,096 | 17,264 | 8,344 |
| newhope512cca | clean | 5,992 | 9,208 | 10,328 |
| newhope512cca | m4 | 5,960 | 9,168 | 10,296 |
| newhope512cpa | clean | 5,968 | 9,128 | 4,248 |
| newhope512cpa | m4 | 5,944 | 9,072 | 4,212 |
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
| papabear | clean | 7,492 | 7,244 | 13,060 |
| papabear | opt | 4,072 | 3,944 | 7,032 |
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
| rollo-I-128 | ref | 1,452 | 1,460 | 1,476 |
| rollo-I-192 | ref | 1,452 | 1,476 | 1,492 |
| rollo-I-256 | ref | 1,580 | 1,636 | 1,652 |
| rollo-II-128 | ref | 1,708 | 3,984 | 4,092 |
| rollo-II-192 | ref | 1,708 | 4,372 | 4,588 |
| rollo-II-256 | ref | 1,808 | 5,088 | 5,312 |
| rollo-III-128 | ref | 1,860 | 1,932 | 1,508 |
| rollo-III-192 | ref | 2,076 | 2,180 | 1,540 |
| rollo-III-256 | ref | 2,388 | 2,516 | 2,144 |
| rqc128 | ref | 2,372 | 7,420 | 8,356 |
| rqc192 | ref | 2,916 | 9,044 | 10,516 |
| rqc256 | ref | 3,860 | 16,856 | 19,224 |
| saber | clean | 15,744 | 18,112 | 19,120 |
| saber | m4 | 13,256 | 15,544 | 16,640 |
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
| falcon-1024 | clean | 35,480 | 82,540 | 8,800 |
| falcon-1024 | m4-ct | 1,696 | 2,628 | 512 |
| falcon-1024 | opt-ct | 1,696 | 2,744 | 512 |
| falcon-1024 | opt-leaktime | 1,640 | 2,732 | 512 |
| falcon-512 | clean | 18,600 | 42,516 | 4,704 |
| falcon-512 | m4-ct | 1,592 | 2,540 | 512 |
| falcon-512 | opt-ct | 1,600 | 2,540 | 512 |
| falcon-512 | opt-leaktime | 1,656 | 2,636 | 512 |
| falcon-512-tree | m4-ct | 1,584 | 2,708 | 512 |
| falcon-512-tree | opt-ct | 1,696 | 2,708 | 512 |
| falcon-512-tree | opt-leaktime | 1,544 | 2,852 | 512 |
| luov-47-42-182-chacha | ref | 2,540 | 4,472 | 2,996 |
| luov-47-42-182-keccak | ref | 2,920 | 4,624 | 3,376 |
| luov-61-60-261-chacha | ref | 3,300 | 6,128 | 4,044 |
| luov-61-60-261-keccak | ref | 3,824 | 6,272 | 4,592 |
| luov-7-57-197-chacha | ref | 2,904 | 2,756 | 1,308 |
| luov-7-57-197-keccak | ref | 3,312 | 2,856 | 2,144 |
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
| babybear | clean | 9.7% | 7.3% | 8.6% |
| babybear | opt | 55.2% | 47.5% | 41.9% |
| babybear-ephem | opt | 55.2% | 48.4% | 35.8% |
| babybear-ephem | ref | 8.4% | 6.5% | 4.3% |
| firesaber | clean | 18.7% | 18.6% | 13.8% |
| firesaber | m4 | 49.4% | 49.3% | 40.0% |
| frodokem640aes | m4 | 73.6% | 77.1% | 76.3% |
| frodokem640shake | m4 | 85.5% | 83.4% | 86.1% |
| frodokem640shake | opt | 74.9% | 65.4% | 64.9% |
| kyber1024 | clean | 58.8% | 58.0% | 47.4% |
| kyber1024 | m4 | 70.5% | 73.3% | 66.7% |
| kyber1024-90s | clean | 45.2% | 43.7% | 34.7% |
| kyber1024-90s | m4 | 56.8% | 59.4% | 52.9% |
| kyber512 | clean | 54.6% | 53.5% | 38.9% |
| kyber512 | m4 | 68.9% | 72.5% | 61.6% |
| kyber512-90s | clean | 41.1% | 38.6% | 27.1% |
| kyber512-90s | m4 | 56.5% | 61.0% | 50.8% |
| kyber768 | clean | 57.0% | 56.3% | 44.0% |
| kyber768 | m4 | 69.7% | 73.0% | 64.8% |
| kyber768-90s | clean | 43.3% | 41.6% | 31.4% |
| kyber768-90s | m4 | 56.2% | 58.9% | 50.8% |
| lac128 | ref | 6.1% | 4.6% | 2.9% |
| lac192 | ref | 1.9% | 2.1% | 1.2% |
| lac256 | ref | 3.4% | 2.5% | 1.6% |
| mamabear | clean | 8.2% | 6.6% | 7.6% |
| mamabear | opt | 53.9% | 47.9% | 43.3% |
| mamabear-ephem | opt | 53.4% | 47.9% | 34.3% |
| mamabear-ephem | ref | 7.4% | 6.0% | 3.9% |
| lightsaber | clean | 24.7% | 23.6% | 15.3% |
| lightsaber | m4 | 56.5% | 55.7% | 42.0% |
| newhope1024cca | clean | 59.5% | 59.1% | 47.6% |
| newhope1024cca | m4 | 74.2% | 74.6% | 64.5% |
| newhope1024cpa | clean | 53.9% | 50.2% | 4.3% |
| newhope1024cpa | m4 | 69.6% | 67.0% | 8.5% |
| newhope512cca | clean | 61.4% | 61.5% | 49.9% |
| newhope512cca | m4 | 74.4% | 75.2% | 65.0% |
| newhope512cpa | clean | 56.1% | 52.4% | 8.6% |
| newhope512cpa | m4 | 70.1% | 67.6% | 15.3% |
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
| papabear | clean | 7.5% | 6.3% | 7.1% |
| papabear | opt | 52.7% | 47.9% | 44.0% |
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
| rollo-I-128 | ref | 0.1% | 1.1% | 0.2% |
| rollo-I-192 | ref | 0.1% | 1.0% | 0.1% |
| rollo-I-256 | ref | 0.1% | 0.7% | 0.0% |
| rollo-II-128 | ref | 0.0% | 2.8% | 0.5% |
| rollo-II-192 | ref | 0.0% | 3.2% | 0.4% |
| rollo-II-256 | ref | 0.0% | 3.1% | 0.5% |
| rollo-III-128 | ref | 3.4% | 1.9% | 0.1% |
| rollo-III-192 | ref | 3.6% | 1.9% | 0.1% |
| rollo-III-256 | ref | 1.9% | 1.1% | 0.1% |
| rqc128 | ref | 3.2% | 6.0% | 1.5% |
| rqc192 | ref | 2.6% | 4.7% | 1.1% |
| rqc256 | ref | 1.8% | 3.4% | 0.6% |
| saber | clean | 21.3% | 20.9% | 14.6% |
| saber | m4 | 53.0% | 52.9% | 41.5% |
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
| dilithium2 | m4 | 75.0% | 52.2% | 70.3% |
| dilithium3 | clean | 61.4% | 26.9% | 51.4% |
| dilithium3 | m4 | 77.6% | 53.4% | 72.5% |
| dilithium4 | clean | 62.1% | 30.2% | 54.6% |
| dilithium4 | m4 | 77.4% | 55.9% | 73.9% |
| falcon-1024 | clean | 8.1% | 0.3% | 28.2% |
| falcon-1024 | m4-ct | 10.0% | 0.5% | 34.3% |
| falcon-1024 | opt-ct | 10.8% | 0.5% | 34.3% |
| falcon-1024 | opt-leaktime | 10.8% | 0.5% | 34.3% |
| falcon-512 | clean | 13.6% | 0.4% | 30.5% |
| falcon-512 | m4-ct | 17.5% | 0.5% | 36.0% |
| falcon-512 | opt-ct | 16.7% | 0.5% | 36.0% |
| falcon-512 | opt-leaktime | 17.0% | 0.6% | 36.1% |
| falcon-512-tree | m4-ct | 14.5% | 1.1% | 36.0% |
| falcon-512-tree | opt-ct | 15.0% | 1.2% | 36.0% |
| falcon-512-tree | opt-leaktime | 15.3% | 1.1% | 36.0% |
| luov-47-42-182-chacha | ref | 0.4% | 0.3% | 0.1% |
| luov-47-42-182-keccak | ref | 30.8% | 16.8% | 22.4% |
| luov-61-60-261-chacha | ref | 0.3% | 0.1% | 0.0% |
| luov-61-60-261-keccak | ref | 33.9% | 13.4% | 22.4% |
| luov-7-57-197-chacha | ref | 0.3% | 0.2% | 0.0% |
| luov-7-57-197-keccak | ref | 30.6% | 21.6% | 32.9% |
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
| babybear | clean | 5,079 | 0 | 0 | 5,079 |
| babybear | opt | 5,627 | 0 | 0 | 5,627 |
| babybear-ephem | opt | 4,985 | 0 | 0 | 4,985 |
| babybear-ephem | ref | 4,892 | 0 | 0 | 4,892 |
| firesaber | clean | 11,208 | 0 | 0 | 11,208 |
| firesaber | m4 | 44,184 | 0 | 0 | 44,184 |
| frodokem640aes | m4 | 8,496 | 0 | 0 | 8,496 |
| frodokem640shake | m4 | 8,584 | 0 | 0 | 8,584 |
| frodokem640shake | opt | 6,464 | 0 | 0 | 6,464 |
| kyber1024 | clean | 5,352 | 512 | 0 | 5,864 |
| kyber1024 | m4 | 12,424 | 0 | 0 | 12,424 |
| kyber1024-90s | clean | 5,968 | 0 | 0 | 5,968 |
| kyber1024-90s | m4 | 12,624 | 0 | 0 | 12,624 |
| kyber512 | clean | 4,444 | 512 | 0 | 4,956 |
| kyber512 | m4 | 11,000 | 0 | 0 | 11,000 |
| kyber512-90s | clean | 5,084 | 0 | 0 | 5,084 |
| kyber512-90s | m4 | 11,160 | 0 | 0 | 11,160 |
| kyber768 | clean | 4,600 | 512 | 0 | 5,112 |
| kyber768 | m4 | 11,400 | 0 | 0 | 11,400 |
| kyber768-90s | clean | 5,240 | 0 | 0 | 5,240 |
| kyber768-90s | m4 | 11,572 | 0 | 0 | 11,572 |
| lac128 | ref | 29,708 | 72 | 296 | 30,076 |
| lac192 | ref | 21,196 | 72 | 152 | 21,420 |
| lac256 | ref | 29,876 | 72 | 296 | 30,244 |
| lightsaber | clean | 11,936 | 0 | 0 | 11,936 |
| lightsaber | m4 | 44,916 | 0 | 0 | 44,916 |
| mamabear | clean | 5,571 | 0 | 0 | 5,571 |
| mamabear | opt | 5,623 | 0 | 0 | 5,623 |
| mamabear-ephem | opt | 4,917 | 0 | 0 | 4,917 |
| mamabear-ephem | ref | 4,900 | 0 | 0 | 4,900 |
| newhope1024cca | clean | 10,780 | 0 | 0 | 10,780 |
| newhope1024cca | m4 | 96,976 | 5,120 | 0 | 102,096 |
| newhope1024cpa | clean | 10,384 | 0 | 0 | 10,384 |
| newhope1024cpa | m4 | 96,664 | 5,120 | 0 | 101,784 |
| newhope512cca | clean | 7,016 | 0 | 0 | 7,016 |
| newhope512cca | m4 | 51,396 | 2,560 | 0 | 53,956 |
| newhope512cpa | clean | 6,620 | 0 | 0 | 6,620 |
| newhope512cpa | m4 | 51,084 | 2,560 | 0 | 53,644 |
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
| papabear | clean | 5,559 | 0 | 0 | 5,559 |
| papabear | opt | 5,559 | 0 | 0 | 5,559 |
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
| rollo-I-128 | ref | 18,788 | 0 | 2,072 | 20,860 |
| rollo-I-192 | ref | 18,564 | 0 | 2,072 | 20,636 |
| rollo-I-256 | ref | 18,572 | 0 | 2,072 | 20,644 |
| rollo-II-128 | ref | 19,876 | 0 | 2,072 | 21,948 |
| rollo-II-192 | ref | 19,940 | 0 | 2,072 | 22,012 |
| rollo-II-256 | ref | 20,680 | 0 | 2,072 | 22,752 |
| rollo-III-128 | ref | 19,284 | 0 | 2,072 | 21,356 |
| rollo-III-192 | ref | 19,248 | 0 | 2,072 | 21,320 |
| rollo-III-256 | ref | 22,060 | 0 | 2,072 | 24,132 |
| rqc128 | ref | 22,492 | 0 | 2,072 | 24,564 |
| rqc192 | ref | 23,012 | 0 | 2,072 | 25,084 |
| rqc256 | ref | 25,148 | 0 | 2,072 | 27,220 |
| saber | clean | 11,248 | 0 | 0 | 11,248 |
| saber | m4 | 44,468 | 0 | 0 | 44,468 |
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
| dilithium2 | m4 | 18,124 | 0 | 0 | 18,124 |
| dilithium3 | clean | 11,144 | 0 | 0 | 11,144 |
| dilithium3 | m4 | 17,972 | 0 | 0 | 17,972 |
| dilithium4 | clean | 11,240 | 0 | 0 | 11,240 |
| dilithium4 | m4 | 18,080 | 0 | 0 | 18,080 |
| falcon-1024 | clean | 80,865 | 0 | 0 | 80,865 |
| falcon-1024 | m4-ct | 81,813 | 0 | 79,872 | 161,685 |
| falcon-1024 | opt-ct | 81,813 | 0 | 79,872 | 161,685 |
| falcon-1024 | opt-leaktime | 74,893 | 0 | 79,872 | 154,765 |
| falcon-512 | clean | 80,841 | 0 | 0 | 80,841 |
| falcon-512 | m4-ct | 81,813 | 0 | 39,936 | 121,749 |
| falcon-512 | opt-ct | 81,813 | 0 | 39,936 | 121,749 |
| falcon-512 | opt-leaktime | 74,893 | 0 | 39,936 | 114,829 |
| falcon-512-tree | m4-ct | 81,549 | 0 | 27,648 | 109,197 |
| falcon-512-tree | opt-ct | 81,549 | 0 | 27,648 | 109,197 |
| falcon-512-tree | opt-leaktime | 74,629 | 0 | 27,648 | 102,277 |
| luov-47-42-182-chacha | ref | 10,356 | 0 | 0 | 10,356 |
| luov-47-42-182-keccak | ref | 10,384 | 0 | 0 | 10,384 |
| luov-61-60-261-chacha | ref | 10,452 | 0 | 0 | 10,452 |
| luov-61-60-261-keccak | ref | 10,480 | 0 | 0 | 10,480 |
| luov-7-57-197-chacha | ref | 10,268 | 0 | 0 | 10,268 |
| luov-7-57-197-keccak | ref | 10,272 | 0 | 0 | 10,272 |
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
