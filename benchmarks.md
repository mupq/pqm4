# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| bikel1 (100 executions) | m4f | AVG: 25,066,749 <br /> MIN: 25,044,123 <br /> MAX: 25,093,265 | AVG: 3,396,189 <br /> MIN: 3,371,978 <br /> MAX: 3,421,250 | AVG: 51,312,929 <br /> MIN: 51,288,697 <br /> MAX: 51,338,076 |
| bikel1 (100 executions) | opt | AVG: 65,551,522 <br /> MIN: 65,536,266 <br /> MAX: 65,569,190 | AVG: 4,962,977 <br /> MIN: 4,944,655 <br /> MAX: 4,989,740 | AVG: 116,657,625 <br /> MIN: 116,639,290 <br /> MAX: 116,684,485 |
| firesaber (100 executions) | clean | AVG: 3,725,054 <br /> MIN: 3,725,018 <br /> MAX: 3,725,082 | AVG: 4,623,783 <br /> MIN: 4,623,773 <br /> MAX: 4,623,821 | AVG: 5,237,480 <br /> MIN: 5,237,439 <br /> MAX: 5,238,455 |
| firesaber (100 executions) | m4fspeed | AVG: 994,446 <br /> MIN: 994,445 <br /> MAX: 994,479 | AVG: 1,204,260 <br /> MIN: 1,204,257 <br /> MAX: 1,204,291 | AVG: 1,151,016 <br /> MIN: 1,151,014 <br /> MAX: 1,151,048 |
| firesaber (100 executions) | m4fstack | AVG: 1,319,646 <br /> MIN: 1,319,644 <br /> MAX: 1,319,680 | AVG: 1,615,256 <br /> MIN: 1,615,254 <br /> MAX: 1,615,289 | AVG: 1,595,646 <br /> MIN: 1,595,644 <br /> MAX: 1,595,678 |
| frodokem640aes (100 executions) | m4 | AVG: 48,341,743 <br /> MIN: 48,341,710 <br /> MAX: 48,341,749 | AVG: 47,131,691 <br /> MIN: 47,131,687 <br /> MAX: 47,131,697 | AVG: 46,612,335 <br /> MIN: 46,612,315 <br /> MAX: 46,612,355 |
| frodokem640shake (100 executions) | m4 | AVG: 77,984,424 <br /> MIN: 77,835,411 <br /> MAX: 77,989,050 | AVG: 78,893,964 <br /> MIN: 78,893,939 <br /> MAX: 78,893,977 | AVG: 78,341,812 <br /> MIN: 78,341,788 <br /> MAX: 78,341,829 |
| frodokem640shake (100 executions) | opt | AVG: 90,654,791 <br /> MIN: 90,654,775 <br /> MAX: 90,654,814 | AVG: 104,138,444 <br /> MIN: 104,138,419 <br /> MAX: 104,138,534 | AVG: 103,834,288 <br /> MIN: 103,834,251 <br /> MAX: 103,834,338 |
| hqc-rmrs-128 (100 executions) | clean | AVG: 2,967,262 <br /> MIN: 2,924,920 <br /> MAX: 3,153,007 | AVG: 5,415,022 <br /> MIN: 5,325,331 <br /> MAX: 5,590,378 | AVG: 7,845,462 <br /> MIN: 7,713,583 <br /> MAX: 8,205,411 |
| kyber1024 (100 executions) | clean | AVG: 1,637,602 <br /> MIN: 1,635,186 <br /> MAX: 1,649,476 | AVG: 2,010,657 <br /> MIN: 2,008,239 <br /> MAX: 2,022,536 | AVG: 2,148,861 <br /> MIN: 2,146,442 <br /> MAX: 2,160,739 |
| kyber1024 (100 executions) | m4fspeed | AVG: 1,146,506 <br /> MIN: 1,144,173 <br /> MAX: 1,170,735 | AVG: 1,334,375 <br /> MIN: 1,332,046 <br /> MAX: 1,358,608 | AVG: 1,237,498 <br /> MIN: 1,235,169 <br /> MAX: 1,261,731 |
| kyber1024 (100 executions) | m4fstack | AVG: 1,154,566 <br /> MIN: 1,152,611 <br /> MAX: 1,166,824 | AVG: 1,346,343 <br /> MIN: 1,344,384 <br /> MAX: 1,358,597 | AVG: 1,251,026 <br /> MIN: 1,249,067 <br /> MAX: 1,263,280 |
| kyber1024-90s (100 executions) | clean | AVG: 3,002,358 <br /> MIN: 3,000,594 <br /> MAX: 3,017,386 | AVG: 3,278,118 <br /> MIN: 3,276,347 <br /> MAX: 3,293,172 | AVG: 3,511,420 <br /> MIN: 3,509,649 <br /> MAX: 3,526,441 |
| kyber1024-90s (100 executions) | m4fspeed | AVG: 995,987 <br /> MIN: 988,645 <br /> MAX: 1,000,850 | AVG: 1,088,634 <br /> MIN: 1,081,292 <br /> MAX: 1,093,497 | AVG: 1,086,861 <br /> MIN: 1,079,552 <br /> MAX: 1,091,724 |
| kyber1024-90s (100 executions) | m4fstack | AVG: 1,006,908 <br /> MIN: 999,573 <br /> MAX: 1,009,607 | AVG: 1,103,436 <br /> MIN: 1,096,101 <br /> MAX: 1,106,135 | AVG: 1,103,215 <br /> MIN: 1,095,880 <br /> MAX: 1,105,914 |
| kyber512 (100 executions) | clean | AVG: 631,058 <br /> MIN: 630,445 <br /> MAX: 643,862 | AVG: 842,478 <br /> MIN: 841,864 <br /> MAX: 855,281 | AVG: 936,458 <br /> MIN: 935,844 <br /> MAX: 949,261 |
| kyber512 (100 executions) | m4fspeed | AVG: 441,489 <br /> MIN: 440,447 <br /> MAX: 454,135 | AVG: 540,354 <br /> MIN: 539,311 <br /> MAX: 553,000 | AVG: 491,034 <br /> MIN: 489,992 <br /> MAX: 503,681 |
| kyber512 (100 executions) | m4fstack | AVG: 441,712 <br /> MIN: 441,068 <br /> MAX: 454,552 | AVG: 542,251 <br /> MIN: 541,606 <br /> MAX: 555,090 | AVG: 493,434 <br /> MIN: 492,790 <br /> MAX: 506,274 |
| kyber512-90s (100 executions) | clean | AVG: 944,546 <br /> MIN: 944,075 <br /> MAX: 944,961 | AVG: 1,114,167 <br /> MIN: 1,113,662 <br /> MAX: 1,114,581 | AVG: 1,259,241 <br /> MIN: 1,258,736 <br /> MAX: 1,259,655 |
| kyber512-90s (100 executions) | m4fspeed | AVG: 376,946 <br /> MIN: 372,781 <br /> MAX: 381,569 | AVG: 434,013 <br /> MIN: 429,848 <br /> MAX: 438,636 | AVG: 435,784 <br /> MIN: 431,618 <br /> MAX: 440,406 |
| kyber512-90s (100 executions) | m4fstack | AVG: 377,943 <br /> MIN: 370,186 <br /> MAX: 378,865 | AVG: 436,682 <br /> MIN: 428,925 <br /> MAX: 437,604 | AVG: 438,958 <br /> MIN: 431,201 <br /> MAX: 439,880 |
| kyber768 (100 executions) | clean | AVG: 1,051,021 <br /> MIN: 1,049,570 <br /> MAX: 1,063,275 | AVG: 1,349,400 <br /> MIN: 1,347,982 <br /> MAX: 1,361,620 | AVG: 1,463,791 <br /> MIN: 1,462,338 <br /> MAX: 1,476,010 |
| kyber768 (100 executions) | m4fspeed | AVG: 723,575 <br /> MIN: 722,237 <br /> MAX: 736,565 | AVG: 877,501 <br /> MIN: 876,197 <br /> MAX: 890,491 | AVG: 803,740 <br /> MIN: 802,401 <br /> MAX: 816,729 |
| kyber768 (100 executions) | m4fstack | AVG: 728,304 <br /> MIN: 725,897 <br /> MAX: 740,275 | AVG: 884,925 <br /> MIN: 882,518 <br /> MAX: 896,896 | AVG: 812,180 <br /> MIN: 809,773 <br /> MAX: 824,151 |
| kyber768-90s (100 executions) | clean | AVG: 1,811,726 <br /> MIN: 1,810,670 <br /> MAX: 1,827,045 | AVG: 2,034,922 <br /> MIN: 2,033,865 <br /> MAX: 2,050,240 | AVG: 2,222,406 <br /> MIN: 2,221,348 <br /> MAX: 2,237,723 |
| kyber768-90s (100 executions) | m4fspeed | AVG: 632,398 <br /> MIN: 621,252 <br /> MAX: 638,272 | AVG: 711,096 <br /> MIN: 699,950 <br /> MAX: 717,003 | AVG: 710,430 <br /> MIN: 699,284 <br /> MAX: 716,304 |
| kyber768-90s (100 executions) | m4fstack | AVG: 638,129 <br /> MIN: 630,786 <br /> MAX: 643,556 | AVG: 719,513 <br /> MIN: 712,171 <br /> MAX: 724,940 | AVG: 719,862 <br /> MIN: 712,520 <br /> MAX: 725,289 |
| lightsaber (100 executions) | clean | AVG: 1,023,162 <br /> MIN: 1,023,162 <br /> MAX: 1,023,163 | AVG: 1,494,462 <br /> MIN: 1,494,456 <br /> MAX: 1,494,495 | AVG: 1,805,694 <br /> MIN: 1,805,691 <br /> MAX: 1,805,725 |
| lightsaber (100 executions) | m4fspeed | AVG: 352,196 <br /> MIN: 352,196 <br /> MAX: 352,229 | AVG: 481,006 <br /> MIN: 481,005 <br /> MAX: 481,038 | AVG: 452,654 <br /> MIN: 452,653 <br /> MAX: 452,687 |
| lightsaber (100 executions) | m4fstack | AVG: 422,434 <br /> MIN: 422,434 <br /> MAX: 422,467 | AVG: 591,556 <br /> MIN: 591,555 <br /> MAX: 591,588 | AVG: 581,073 <br /> MIN: 581,072 <br /> MAX: 581,106 |
| ntruhps2048509 (100 executions) | clean | AVG: 54,823,162 <br /> MIN: 54,823,152 <br /> MAX: 54,823,191 | AVG: 1,067,060 <br /> MIN: 1,067,059 <br /> MAX: 1,067,093 | AVG: 2,447,633 <br /> MIN: 2,447,627 <br /> MAX: 2,447,662 |
| ntruhps2048509 (100 executions) | m4f | AVG: 2,867,040 <br /> MIN: 2,867,035 <br /> MAX: 2,867,072 | AVG: 565,341 <br /> MIN: 565,340 <br /> MAX: 565,374 | AVG: 538,297 <br /> MIN: 538,296 <br /> MAX: 538,330 |
| ntruhps2048677 (100 executions) | clean | AVG: 100,624,356 <br /> MIN: 100,624,352 <br /> MAX: 100,624,361 | AVG: 1,802,130 <br /> MIN: 1,802,127 <br /> MAX: 1,802,161 | AVG: 4,306,200 <br /> MIN: 4,306,192 <br /> MAX: 4,306,227 |
| ntruhps2048677 (100 executions) | m4f | AVG: 4,599,942 <br /> MIN: 4,599,933 <br /> MAX: 4,599,968 | AVG: 811,676 <br /> MIN: 811,675 <br /> MAX: 811,708 | AVG: 804,287 <br /> MIN: 804,286 <br /> MAX: 804,319 |
| ntruhps4096821 (100 executions) | clean | AVG: 151,720,966 <br /> MIN: 151,720,961 <br /> MAX: 151,721,000 | AVG: 2,356,823 <br /> MIN: 2,356,819 <br /> MAX: 2,356,853 | AVG: 5,693,678 <br /> MIN: 5,693,667 <br /> MAX: 5,693,701 |
| ntruhps4096821 (100 executions) | m4f | AVG: 6,067,154 <br /> MIN: 6,067,143 <br /> MAX: 6,067,179 | AVG: 1,010,199 <br /> MIN: 1,010,198 <br /> MAX: 1,010,232 | AVG: 1,013,226 <br /> MIN: 1,013,224 <br /> MAX: 1,013,258 |
| ntruhrss701 (100 executions) | clean | AVG: 109,446,894 <br /> MIN: 109,446,874 <br /> MAX: 109,446,914 | AVG: 1,515,007 <br /> MIN: 1,515,004 <br /> MAX: 1,515,038 | AVG: 4,363,878 <br /> MIN: 4,363,870 <br /> MAX: 4,363,904 |
| ntruhrss701 (100 executions) | m4f | AVG: 4,210,467 <br /> MIN: 4,210,459 <br /> MAX: 4,210,494 | AVG: 368,351 <br /> MIN: 368,351 <br /> MAX: 368,385 | AVG: 860,213 <br /> MIN: 860,212 <br /> MAX: 860,246 |
| ntrulpr1013 (100 executions) | clean | AVG: 9,052,666 <br /> MIN: 9,052,649 <br /> MAX: 9,052,683 | AVG: 17,456,889 <br /> MIN: 17,456,887 <br /> MAX: 17,456,891 | AVG: 25,211,523 <br /> MIN: 25,211,503 <br /> MAX: 25,211,542 |
| ntrulpr1013 (100 executions) | m4f | AVG: 1,102,228 <br /> MIN: 1,102,226 <br /> MAX: 1,102,262 | AVG: 1,842,328 <br /> MIN: 1,842,325 <br /> MAX: 1,842,359 | AVG: 1,991,243 <br /> MIN: 1,991,240 <br /> MAX: 1,991,274 |
| ntrulpr1277 (100 executions) | clean | AVG: 13,975,045 <br /> MIN: 13,975,018 <br /> MAX: 13,975,053 | AVG: 27,077,837 <br /> MIN: 27,077,816 <br /> MAX: 27,077,852 | AVG: 39,376,240 <br /> MIN: 39,376,226 <br /> MAX: 39,376,266 |
| ntrulpr1277 (100 executions) | m4f | AVG: 1,420,658 <br /> MIN: 1,420,657 <br /> MAX: 1,420,691 | AVG: 2,341,222 <br /> MIN: 2,341,217 <br /> MAX: 2,341,253 | AVG: 2,530,410 <br /> MIN: 2,530,405 <br /> MAX: 2,530,440 |
| ntrulpr653 (100 executions) | clean | AVG: 4,262,181 <br /> MIN: 4,262,173 <br /> MAX: 4,262,207 | AVG: 8,152,021 <br /> MIN: 8,152,005 <br /> MAX: 8,152,040 | AVG: 11,603,045 <br /> MIN: 11,603,022 <br /> MAX: 11,603,057 |
| ntrulpr653 (100 executions) | m4f | AVG: 677,981 <br /> MIN: 677,980 <br /> MAX: 678,013 | AVG: 1,157,987 <br /> MIN: 1,157,986 <br /> MAX: 1,158,021 | AVG: 1,233,059 <br /> MIN: 1,233,056 <br /> MAX: 1,233,091 |
| ntrulpr761 (100 executions) | clean | AVG: 5,637,525 <br /> MIN: 5,637,514 <br /> MAX: 5,637,548 | AVG: 10,818,403 <br /> MIN: 10,818,382 <br /> MAX: 10,818,417 | AVG: 15,498,070 <br /> MIN: 15,498,040 <br /> MAX: 15,498,075 |
| ntrulpr761 (100 executions) | m4f | AVG: 726,507 <br /> MIN: 726,506 <br /> MAX: 726,540 | AVG: 1,312,278 <br /> MIN: 1,312,276 <br /> MAX: 1,312,311 | AVG: 1,393,675 <br /> MIN: 1,393,672 <br /> MAX: 1,393,708 |
| ntrulpr857 (100 executions) | clean | AVG: 7,011,303 <br /> MIN: 7,011,290 <br /> MAX: 7,011,325 | AVG: 13,497,170 <br /> MIN: 13,497,143 <br /> MAX: 13,497,178 | AVG: 19,427,758 <br /> MIN: 19,427,750 <br /> MAX: 19,427,787 |
| ntrulpr857 (100 executions) | m4f | AVG: 921,143 <br /> MIN: 921,142 <br /> MAX: 921,176 | AVG: 1,547,852 <br /> MIN: 1,547,849 <br /> MAX: 1,547,883 | AVG: 1,668,045 <br /> MIN: 1,668,042 <br /> MAX: 1,668,077 |
| ntrulpr953 (100 executions) | clean | AVG: 8,540,005 <br /> MIN: 8,539,989 <br /> MAX: 8,540,025 | AVG: 16,476,839 <br /> MIN: 16,476,806 <br /> MAX: 16,476,842 | AVG: 23,804,413 <br /> MIN: 23,804,398 <br /> MAX: 23,804,435 |
| ntrulpr953 (100 executions) | m4f | AVG: 1,007,380 <br /> MIN: 1,007,379 <br /> MAX: 1,007,412 | AVG: 1,677,959 <br /> MIN: 1,677,956 <br /> MAX: 1,677,991 | AVG: 1,795,115 <br /> MIN: 1,795,112 <br /> MAX: 1,795,146 |
| saber (100 executions) | clean | AVG: 2,136,066 <br /> MIN: 2,136,063 <br /> MAX: 2,136,099 | AVG: 2,808,330 <br /> MIN: 2,808,325 <br /> MAX: 2,808,360 | AVG: 3,279,876 <br /> MIN: 3,279,865 <br /> MAX: 3,280,057 |
| saber (100 executions) | m4fspeed | AVG: 645,222 <br /> MIN: 645,221 <br /> MAX: 645,255 | AVG: 820,799 <br /> MIN: 820,798 <br /> MAX: 820,832 | AVG: 774,055 <br /> MIN: 774,054 <br /> MAX: 774,089 |
| saber (100 executions) | m4fstack | AVG: 820,044 <br /> MIN: 820,043 <br /> MAX: 820,077 | AVG: 1,059,170 <br /> MIN: 1,059,168 <br /> MAX: 1,059,202 | AVG: 1,038,683 <br /> MIN: 1,038,681 <br /> MAX: 1,038,715 |
| sikep434 (3 executions) | m4 | AVG: 48,264,607 <br /> MIN: 48,264,586 <br /> MAX: 48,264,619 | AVG: 78,910,673 <br /> MIN: 78,910,650 <br /> MAX: 78,910,687 | AVG: 84,275,488 <br /> MIN: 84,275,487 <br /> MAX: 84,275,490 |
| sikep434 (3 executions) | opt | AVG: 642,929,598 <br /> MIN: 642,929,525 <br /> MAX: 642,929,648 | AVG: 1,053,016,085 <br /> MIN: 1,053,015,970 <br /> MAX: 1,053,016,185 | AVG: 1,123,128,815 <br /> MIN: 1,123,128,701 <br /> MAX: 1,123,129,014 |
| sikep503 (3 executions) | m4 | AVG: 67,365,114 <br /> MIN: 67,365,114 <br /> MAX: 67,365,114 | AVG: 110,843,233 <br /> MIN: 110,843,213 <br /> MAX: 110,843,246 | AVG: 117,990,911 <br /> MIN: 117,990,909 <br /> MAX: 117,990,915 |
| sikep503 (3 executions) | opt | AVG: 973,165,635 <br /> MIN: 973,165,466 <br /> MAX: 973,165,731 | AVG: 1,603,575,963 <br /> MIN: 1,603,575,924 <br /> MAX: 1,603,576,005 | AVG: 1,705,351,483 <br /> MIN: 1,705,351,462 <br /> MAX: 1,705,351,501 |
| sikep610 (3 executions) | m4 | AVG: 119,448,800 <br /> MIN: 119,448,799 <br /> MAX: 119,448,802 | AVG: 219,578,087 <br /> MIN: 219,578,076 <br /> MAX: 219,578,110 | AVG: 220,969,907 <br /> MIN: 220,969,906 <br /> MAX: 220,969,909 |
| sikep610 (3 executions) | opt | AVG: 1,819,890,092 <br /> MIN: 1,819,890,048 <br /> MAX: 1,819,890,116 | AVG: 3,348,338,910 <br /> MIN: 3,348,338,872 <br /> MAX: 3,348,338,953 | AVG: 3,368,186,884 <br /> MIN: 3,368,186,866 <br /> MAX: 3,368,186,913 |
| sikep751 (3 executions) | m4 | AVG: 204,602,404 <br /> MIN: 204,602,342 <br /> MAX: 204,602,480 | AVG: 331,863,483 <br /> MIN: 331,863,456 <br /> MAX: 331,863,518 | AVG: 356,346,637 <br /> MIN: 356,346,629 <br /> MAX: 356,346,647 |
| sikep751 (3 executions) | opt | AVG: 3,288,104,083 <br /> MIN: 3,288,104,032 <br /> MAX: 3,288,104,117 | AVG: 5,332,588,530 <br /> MIN: 5,332,588,502 <br /> MAX: 5,332,588,553 | AVG: 5,727,763,554 <br /> MIN: 5,727,763,504 <br /> MAX: 5,727,763,632 |
| sntrup1013 (100 executions) | clean | AVG: 247,468,244 <br /> MIN: 245,634,978 <br /> MAX: 337,296,998 | AVG: 8,740,051 <br /> MIN: 8,740,034 <br /> MAX: 8,740,069 | AVG: 26,809,743 <br /> MIN: 26,809,722 <br /> MAX: 26,809,761 |
| sntrup1013 (100 executions) | m4f | AVG: 13,955,859 <br /> MIN: 13,929,581 <br /> MAX: 16,554,582 | AVG: 1,031,757 <br /> MIN: 1,031,756 <br /> MAX: 1,031,789 | AVG: 838,171 <br /> MIN: 838,170 <br /> MAX: 838,204 |
| sntrup1277 (100 executions) | clean | AVG: 393,058,337 <br /> MIN: 385,951,901 <br /> MAX: 528,080,467 | AVG: 13,576,829 <br /> MIN: 13,576,804 <br /> MAX: 13,576,839 | AVG: 42,363,757 <br /> MIN: 42,363,737 <br /> MAX: 42,363,776 |
| sntrup1277 (100 executions) | m4f | AVG: 22,989,117 <br /> MIN: 22,873,302 <br /> MAX: 26,733,435 | AVG: 1,326,335 <br /> MIN: 1,326,333 <br /> MAX: 1,326,368 | AVG: 1,071,964 <br /> MIN: 1,071,962 <br /> MAX: 1,071,996 |
| sntrup653 (100 executions) | clean | AVG: 102,879,347 <br /> MIN: 102,506,263 <br /> MAX: 139,813,864 | AVG: 4,060,121 <br /> MIN: 4,060,114 <br /> MAX: 4,060,148 | AVG: 11,723,295 <br /> MIN: 11,723,272 <br /> MAX: 11,723,307 |
| sntrup653 (100 executions) | m4f | AVG: 6,714,568 <br /> MIN: 6,627,693 <br /> MAX: 7,868,628 | AVG: 631,853 <br /> MIN: 631,851 <br /> MAX: 631,885 | AVG: 486,707 <br /> MIN: 486,706 <br /> MAX: 486,740 |
| sntrup761 (100 executions) | clean | AVG: 141,913,579 <br /> MIN: 141,913,560 <br /> MAX: 141,913,604 | AVG: 5,395,672 <br /> MIN: 5,395,662 <br /> MAX: 5,395,698 | AVG: 15,828,809 <br /> MIN: 15,828,778 <br /> MAX: 15,828,813 |
| sntrup761 (100 executions) | m4f | AVG: 7,951,328 <br /> MIN: 7,951,312 <br /> MAX: 7,951,347 | AVG: 683,652 <br /> MIN: 683,651 <br /> MAX: 683,685 | AVG: 538,141 <br /> MIN: 538,140 <br /> MAX: 538,175 |
| sntrup857 (100 executions) | clean | AVG: 179,091,448 <br /> MIN: 179,091,421 <br /> MAX: 179,091,464 | AVG: 6,742,099 <br /> MIN: 6,742,086 <br /> MAX: 6,742,120 | AVG: 20,002,037 <br /> MIN: 20,002,029 <br /> MAX: 20,002,066 |
| sntrup857 (100 executions) | m4f | AVG: 10,264,255 <br /> MIN: 10,264,235 <br /> MAX: 10,264,271 | AVG: 853,302 <br /> MIN: 853,301 <br /> MAX: 853,335 | AVG: 689,920 <br /> MIN: 689,919 <br /> MAX: 689,952 |
| sntrup953 (100 executions) | clean | AVG: 222,055,140 <br /> MIN: 222,055,124 <br /> MAX: 222,055,172 | AVG: 8,240,747 <br /> MIN: 8,240,732 <br /> MAX: 8,240,767 | AVG: 24,678,459 <br /> MIN: 24,678,442 <br /> MAX: 24,678,479 |
| sntrup953 (100 executions) | m4f | AVG: 12,761,557 <br /> MIN: 12,761,535 <br /> MAX: 12,761,571 | AVG: 943,350 <br /> MIN: 943,350 <br /> MAX: 943,350 | AVG: 744,434 <br /> MIN: 744,432 <br /> MAX: 744,467 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| dilithium2 (100 executions) | clean | AVG: 1,976,311 <br /> MIN: 1,934,124 <br /> MAX: 2,022,613 | AVG: 7,465,108 <br /> MIN: 3,241,343 <br /> MAX: 29,601,126 | AVG: 2,109,292 <br /> MIN: 2,108,823 <br /> MAX: 2,109,692 |
| dilithium2 (10000 executions) | m4f | AVG: 1,597,282 <br /> MIN: 1,543,011 <br /> MAX: 1,644,501 | AVG: 4,119,336 <br /> MIN: 1,983,077 <br /> MAX: 34,081,046 | AVG: 1,572,328 <br /> MIN: 1,571,561 <br /> MAX: 1,572,863 |
| dilithium2aes (100 executions) | clean | AVG: 5,153,665 <br /> MIN: 5,109,045 <br /> MAX: 5,227,715 | AVG: 12,016,668 <br /> MIN: 6,375,642 <br /> MAX: 28,738,015 | AVG: 4,824,282 <br /> MIN: 4,779,372 <br /> MAX: 4,898,600 |
| dilithium3 (100 executions) | clean | AVG: 3,414,513 <br /> MIN: 3,413,395 <br /> MAX: 3,416,061 | AVG: 11,722,059 <br /> MIN: 5,037,981 <br /> MAX: 36,169,675 | AVG: 3,499,388 <br /> MIN: 3,498,955 <br /> MAX: 3,499,805 |
| dilithium3 (10000 executions) | m4f | AVG: 2,829,260 <br /> MIN: 2,827,405 <br /> MAX: 2,842,880 | AVG: 6,652,990 <br /> MIN: 3,235,358 <br /> MAX: 42,043,815 | AVG: 2,691,471 <br /> MIN: 2,690,861 <br /> MAX: 2,691,949 |
| dilithium3aes (100 executions) | clean | AVG: 9,258,325 <br /> MIN: 9,166,749 <br /> MAX: 9,369,734 | AVG: 19,417,325 <br /> MIN: 10,745,071 <br /> MAX: 60,023,085 | AVG: 8,581,938 <br /> MIN: 8,491,758 <br /> MAX: 8,694,807 |
| dilithium5 (10000 executions) | m4f | AVG: 4,826,132 <br /> MIN: 4,737,167 <br /> MAX: 4,901,952 | AVG: 8,817,385 <br /> MIN: 5,433,369 <br /> MAX: 40,315,104 | AVG: 4,705,982 <br /> MIN: 4,705,308 <br /> MAX: 4,706,614 |
| falcon-1024 (100 executions) | clean | AVG: 582,455,197 <br /> MIN: 338,850,289 <br /> MAX: 1,754,663,445 | AVG: 133,655,078 <br /> MIN: 133,335,905 <br /> MAX: 133,985,773 | AVG: 1,526,901 <br /> MIN: 1,526,233 <br /> MAX: 1,527,648 |
| falcon-1024 (100 executions) | m4-ct | AVG: 458,300,837 <br /> MIN: 273,960,881 <br /> MAX: 1,558,842,038 | AVG: 85,160,712 <br /> MIN: 84,941,964 <br /> MAX: 85,410,952 | AVG: 977,811 <br /> MIN: 966,969 <br /> MAX: 985,555 |
| falcon-1024 (100 executions) | opt-ct | AVG: 445,577,914 <br /> MIN: 273,960,881 <br /> MAX: 1,180,316,927 | AVG: 85,152,483 <br /> MIN: 84,871,257 <br /> MAX: 85,396,462 | AVG: 978,443 <br /> MIN: 966,990 <br /> MAX: 985,220 |
| falcon-1024 (100 executions) | opt-leaktime | AVG: 396,490,108 <br /> MIN: 245,602,676 <br /> MAX: 1,076,623,891 | AVG: 76,089,647 <br /> MIN: 75,695,829 <br /> MAX: 76,600,726 | AVG: 977,058 <br /> MIN: 967,423 <br /> MAX: 986,715 |
| falcon-512 (100 executions) | clean | AVG: 211,957,111 <br /> MIN: 130,945,749 <br /> MAX: 492,061,202 | AVG: 61,138,869 <br /> MIN: 60,832,802 <br /> MAX: 61,335,655 | AVG: 765,394 <br /> MIN: 764,968 <br /> MAX: 765,937 |
| falcon-512 (100 executions) | m4-ct | AVG: 163,994,060 <br /> MIN: 102,641,420 <br /> MAX: 517,362,211 | AVG: 39,014,427 <br /> MIN: 38,837,777 <br /> MAX: 39,185,566 | AVG: 473,061 <br /> MIN: 464,925 <br /> MAX: 482,045 |
| falcon-512 (100 executions) | opt-ct | AVG: 162,462,958 <br /> MIN: 102,641,423 <br /> MAX: 410,657,402 | AVG: 38,998,943 <br /> MIN: 38,805,455 <br /> MAX: 39,227,786 | AVG: 473,858 <br /> MIN: 464,522 <br /> MAX: 481,541 |
| falcon-512 (100 executions) | opt-leaktime | AVG: 154,023,655 <br /> MIN: 90,621,912 <br /> MAX: 416,634,647 | AVG: 35,418,669 <br /> MIN: 35,077,960 <br /> MAX: 35,817,105 | AVG: 475,004 <br /> MIN: 464,624 <br /> MAX: 481,707 |
| falcon-512-tree (100 executions) | m4-ct | AVG: 200,716,259 <br /> MIN: 117,772,104 <br /> MAX: 550,287,458 | AVG: 17,709,471 <br /> MIN: 17,507,110 <br /> MAX: 17,939,069 | AVG: 474,694 <br /> MIN: 464,292 <br /> MAX: 480,687 |
| falcon-512-tree (100 executions) | opt-ct | AVG: 198,586,636 <br /> MIN: 117,772,108 <br /> MAX: 467,465,996 | AVG: 17,714,893 <br /> MIN: 17,510,506 <br /> MAX: 17,952,496 | AVG: 474,203 <br /> MIN: 464,503 <br /> MAX: 480,655 |
| falcon-512-tree (100 executions) | opt-leaktime | AVG: 165,284,792 <br /> MIN: 102,064,281 <br /> MAX: 409,882,849 | AVG: 19,254,787 <br /> MIN: 18,900,271 <br /> MAX: 19,544,577 | AVG: 474,008 <br /> MIN: 464,495 <br /> MAX: 480,972 |
| picnic3l1 (100 executions) | opt | AVG: 60,417 <br /> MIN: 60,417 <br /> MAX: 60,465 | AVG: 303,854,132 <br /> MIN: 303,833,000 <br /> MAX: 303,870,270 | AVG: 203,717,449 <br /> MIN: 203,659,962 <br /> MAX: 203,778,545 |
| picnic3l1 (100 executions) | opt-mem | AVG: 60,419 <br /> MIN: 60,419 <br /> MAX: 60,466 | AVG: 310,337,761 <br /> MIN: 310,284,407 <br /> MAX: 310,381,893 | AVG: 204,428,518 <br /> MIN: 204,365,229 <br /> MAX: 204,474,589 |
| picnicl1fs (100 executions) | opt | AVG: 97,504 <br /> MIN: 97,504 <br /> MAX: 97,504 | AVG: 290,644,617 <br /> MIN: 290,643,187 <br /> MAX: 290,645,503 | AVG: 127,240,102 <br /> MIN: 127,230,240 <br /> MAX: 127,250,497 |
| picnicl1full (100 executions) | opt | AVG: 58,122 <br /> MIN: 58,122 <br /> MAX: 58,145 | AVG: 215,002,162 <br /> MIN: 215,001,045 <br /> MAX: 215,003,020 | AVG: 95,473,666 <br /> MIN: 95,458,092 <br /> MAX: 95,487,616 |
| sphincs-haraka-128f-robust (3 executions) | clean | AVG: 105,846,270 <br /> MIN: 105,846,258 <br /> MAX: 105,846,293 | AVG: 2,685,388,480 <br /> MIN: 2,682,943,233 <br /> MAX: 2,689,929,636 | AVG: 172,472,494 <br /> MIN: 170,143,524 <br /> MAX: 174,335,672 |
| sphincs-haraka-128f-simple (3 executions) | clean | AVG: 73,970,415 <br /> MIN: 73,970,405 <br /> MAX: 73,970,435 | AVG: 1,861,103,613 <br /> MIN: 1,860,043,188 <br /> MAX: 1,861,756,199 | AVG: 115,058,935 <br /> MIN: 113,100,792 <br /> MAX: 118,730,462 |
| sphincs-haraka-128s-robust (3 executions) | clean | AVG: 6,739,168,653 <br /> MIN: 6,739,168,651 <br /> MAX: 6,739,168,658 | AVG: 53,499,410,785 <br /> MIN: 53,497,780,342 <br /> MAX: 53,500,226,027 | AVG: 66,075,544 <br /> MIN: 65,260,377 <br /> MAX: 67,705,852 |
| sphincs-haraka-128s-simple (3 executions) | clean | AVG: 4,697,105,419 <br /> MIN: 4,697,105,405 <br /> MAX: 4,697,105,438 | AVG: 36,995,658,276 <br /> MIN: 36,993,536,693 <br /> MAX: 36,996,963,861 | AVG: 43,745,574 <br /> MIN: 41,950,604 <br /> MAX: 45,132,564 |
| sphincs-haraka-192f-robust (3 executions) | clean | AVG: 157,000,403 <br /> MIN: 157,000,390 <br /> MAX: 157,000,427 | AVG: 4,697,019,410 <br /> MIN: 4,694,572,079 <br /> MAX: 4,699,117,109 | AVG: 262,491,722 <br /> MIN: 261,093,062 <br /> MAX: 263,540,743 |
| sphincs-haraka-192f-simple (3 executions) | clean | AVG: 108,980,946 <br /> MIN: 108,980,889 <br /> MAX: 108,981,056 | AVG: 3,128,988,618 <br /> MIN: 3,127,355,454 <br /> MAX: 3,131,520,416 | AVG: 170,287,414 <br /> MIN: 165,632,236 <br /> MAX: 174,942,575 |
| sphincs-haraka-192s-robust (3 executions) | clean | AVG: 10,014,008,298 <br /> MIN: 10,014,008,278 <br /> MAX: 10,014,008,311 | AVG: 105,056,922,735 <br /> MIN: 105,054,757,320 <br /> MAX: 105,058,668,316 | AVG: 103,830,928 <br /> MIN: 103,131,652 <br /> MAX: 104,879,871 |
| sphincs-haraka-192s-simple (3 executions) | clean | AVG: 6,937,852,288 <br /> MIN: 6,937,852,256 <br /> MAX: 6,937,852,314 | AVG: 68,492,226,848 <br /> MIN: 68,491,492,011 <br /> MAX: 68,492,717,226 | AVG: 65,344,777 <br /> MIN: 64,446,161 <br /> MAX: 66,896,631 |
| sphincs-haraka-256f-robust (3 executions) | clean | AVG: 419,681,954 <br /> MIN: 419,681,954 <br /> MAX: 419,681,956 | AVG: 9,850,397,824 <br /> MIN: 9,848,648,639 <br /> MAX: 9,852,147,036 | AVG: 285,552,621 <br /> MIN: 284,619,501 <br /> MAX: 287,068,957 |
| sphincs-haraka-256f-simple (3 executions) | clean | AVG: 289,718,169 <br /> MIN: 289,718,158 <br /> MAX: 289,718,188 | AVG: 6,620,999,794 <br /> MIN: 6,618,631,102 <br /> MAX: 6,622,306,678 | AVG: 185,282,107 <br /> MIN: 183,157,086 <br /> MAX: 188,551,365 |
| sphincs-haraka-256s-robust (3 executions) | clean | AVG: 6,706,134,015 <br /> MIN: 6,706,133,996 <br /> MAX: 6,706,134,029 | AVG: 104,498,811,219 <br /> MIN: 104,495,079,548 <br /> MAX: 104,502,076,680 | AVG: 155,820,204 <br /> MIN: 152,438,629 <br /> MAX: 158,735,384 |
| sphincs-haraka-256s-simple (3 executions) | clean | AVG: 4,625,711,696 <br /> MIN: 4,625,711,692 <br /> MAX: 4,625,711,700 | AVG: 68,392,331,427 <br /> MIN: 68,392,004,226 <br /> MAX: 68,392,739,939 | AVG: 99,503,426 <br /> MIN: 97,951,662 <br /> MAX: 101,626,886 |
| sphincs-sha256-128f-robust (3 executions) | clean | AVG: 30,514,763 <br /> MIN: 30,513,199 <br /> MAX: 30,517,857 | AVG: 750,242,822 <br /> MIN: 749,245,139 <br /> MAX: 751,117,282 | AVG: 43,920,038 <br /> MIN: 42,549,739 <br /> MAX: 45,427,596 |
| sphincs-sha256-128f-simple (3 executions) | clean | AVG: 16,112,474 <br /> MIN: 16,112,452 <br /> MAX: 16,112,486 | AVG: 400,443,378 <br /> MIN: 399,872,395 <br /> MAX: 401,227,289 | AVG: 22,548,002 <br /> MIN: 21,220,896 <br /> MAX: 23,344,299 |
| sphincs-sha256-128s-robust (3 executions) | clean | AVG: 1,953,252,957 <br /> MIN: 1,953,203,029 <br /> MAX: 1,953,283,562 | AVG: 14,682,924,206 <br /> MIN: 14,682,577,057 <br /> MAX: 14,683,447,032 | AVG: 14,800,944 <br /> MIN: 14,287,206 <br /> MAX: 15,314,696 |
| sphincs-sha256-128s-simple (3 executions) | clean | AVG: 1,031,754,884 <br /> MIN: 1,031,697,789 <br /> MAX: 1,031,857,298 | AVG: 7,848,131,084 <br /> MIN: 7,847,374,226 <br /> MAX: 7,848,685,121 | AVG: 7,710,684 <br /> MIN: 7,392,187 <br /> MAX: 8,082,296 |
| sphincs-sha256-192f-robust (3 executions) | clean | AVG: 45,161,761 <br /> MIN: 45,160,801 <br /> MAX: 45,163,648 | AVG: 1,250,907,661 <br /> MIN: 1,250,145,348 <br /> MAX: 1,251,553,620 | AVG: 67,089,973 <br /> MIN: 66,469,940 <br /> MAX: 68,123,479 |
| sphincs-sha256-192f-simple (3 executions) | clean | AVG: 23,719,514 <br /> MIN: 23,719,478 <br /> MAX: 23,719,549 | AVG: 669,328,611 <br /> MIN: 669,178,936 <br /> MAX: 669,551,667 | AVG: 33,644,995 <br /> MIN: 33,075,699 <br /> MAX: 34,249,859 |
| sphincs-sha256-192s-robust (3 executions) | clean | AVG: 2,889,565,189 <br /> MIN: 2,889,565,181 <br /> MAX: 2,889,565,194 | AVG: 26,752,674,216 <br /> MIN: 26,752,212,852 <br /> MAX: 26,753,101,424 | AVG: 23,937,976 <br /> MIN: 23,352,631 <br /> MAX: 24,592,207 |
| sphincs-sha256-192s-simple (3 executions) | clean | AVG: 1,517,383,421 <br /> MIN: 1,517,383,393 <br /> MAX: 1,517,383,438 | AVG: 14,389,146,341 <br /> MIN: 14,388,794,580 <br /> MAX: 14,389,383,836 | AVG: 11,980,389 <br /> MIN: 11,962,594 <br /> MAX: 12,015,965 |
| sphincs-sha256-256f-robust (3 executions) | clean | AVG: 164,849,751 <br /> MIN: 164,849,735 <br /> MAX: 164,849,771 | AVG: 3,446,568,163 <br /> MIN: 3,444,179,128 <br /> MAX: 3,447,826,714 | AVG: 95,785,564 <br /> MIN: 95,024,873 <br /> MAX: 96,308,552 |
| sphincs-sha256-256f-simple (3 executions) | clean | AVG: 62,594,489 <br /> MIN: 62,594,395 <br /> MAX: 62,594,642 | AVG: 1,341,551,848 <br /> MIN: 1,341,225,951 <br /> MAX: 1,341,989,219 | AVG: 35,486,542 <br /> MIN: 34,650,880 <br /> MAX: 35,931,028 |
| sphincs-sha256-256s-robust (3 executions) | clean | AVG: 2,633,046,124 <br /> MIN: 2,633,040,905 <br /> MAX: 2,633,049,685 | AVG: 32,385,483,145 <br /> MIN: 32,384,617,054 <br /> MAX: 32,386,410,035 | AVG: 49,641,286 <br /> MIN: 48,834,691 <br /> MAX: 51,112,106 |
| sphincs-sha256-256s-simple (3 executions) | clean | AVG: 998,095,638 <br /> MIN: 997,347,809 <br /> MAX: 998,589,315 | AVG: 12,862,955,551 <br /> MIN: 12,862,600,996 <br /> MAX: 12,863,573,206 | AVG: 17,548,744 <br /> MIN: 17,018,036 <br /> MAX: 18,185,596 |
| sphincs-shake256-128f-robust (3 executions) | clean | AVG: 113,338,476 <br /> MIN: 113,338,464 <br /> MAX: 113,338,500 | AVG: 2,785,018,905 <br /> MIN: 2,784,114,964 <br /> MAX: 2,786,826,725 | AVG: 160,268,333 <br /> MIN: 157,944,173 <br /> MAX: 162,979,848 |
| sphincs-shake256-128f-simple (3 executions) | clean | AVG: 59,754,709 <br /> MIN: 59,754,686 <br /> MAX: 59,754,722 | AVG: 1,481,251,054 <br /> MIN: 1,479,336,058 <br /> MAX: 1,482,703,829 | AVG: 85,436,452 <br /> MIN: 84,379,828 <br /> MAX: 87,351,601 |
| sphincs-shake256-128s-robust (3 executions) | clean | AVG: 7,255,215,585 <br /> MIN: 7,255,215,557 <br /> MAX: 7,255,215,614 | AVG: 54,570,043,397 <br /> MIN: 54,569,139,474 <br /> MAX: 54,570,689,038 | AVG: 57,484,752 <br /> MIN: 56,193,513 <br /> MAX: 58,905,069 |
| sphincs-shake256-128s-simple (3 executions) | clean | AVG: 3,825,053,911 <br /> MIN: 3,825,053,906 <br /> MAX: 3,825,053,919 | AVG: 29,084,221,948 <br /> MIN: 29,083,561,440 <br /> MAX: 29,084,552,215 | AVG: 29,558,987 <br /> MIN: 29,162,750 <br /> MAX: 29,757,120 |
| sphincs-shake256-192f-robust (3 executions) | clean | AVG: 167,141,787 <br /> MIN: 167,141,764 <br /> MAX: 167,141,800 | AVG: 4,463,872,206 <br /> MIN: 4,461,133,615 <br /> MAX: 4,467,002,050 | AVG: 237,573,255 <br /> MIN: 235,486,783 <br /> MAX: 239,398,861 |
| sphincs-shake256-192f-simple (3 executions) | clean | AVG: 88,327,026 <br /> MIN: 88,327,025 <br /> MAX: 88,327,028 | AVG: 2,409,662,836 <br /> MIN: 2,407,991,965 <br /> MAX: 2,411,200,065 | AVG: 122,523,477 <br /> MIN: 121,453,985 <br /> MAX: 123,659,802 |
| sphincs-shake256-192s-robust (3 executions) | clean | AVG: 10,697,444,146 <br /> MIN: 10,697,444,105 <br /> MAX: 10,697,444,177 | AVG: 93,294,080,159 <br /> MIN: 93,293,428,231 <br /> MAX: 93,294,992,860 | AVG: 83,021,157 <br /> MIN: 82,629,899 <br /> MAX: 83,412,391 |
| sphincs-shake256-192s-simple (3 executions) | clean | AVG: 5,652,487,728 <br /> MIN: 5,652,487,718 <br /> MAX: 5,652,487,744 | AVG: 50,820,128,418 <br /> MIN: 50,818,391,083 <br /> MAX: 50,821,398,019 | AVG: 42,085,525 <br /> MIN: 41,417,100 <br /> MAX: 43,021,304 |
| sphincs-shake256-256f-robust (3 executions) | clean | AVG: 444,889,911 <br /> MIN: 444,889,895 <br /> MAX: 444,889,934 | AVG: 8,993,855,912 <br /> MIN: 8,993,065,785 <br /> MAX: 8,995,436,121 | AVG: 245,607,215 <br /> MIN: 243,105,337 <br /> MAX: 247,845,725 |
| sphincs-shake256-256f-simple (3 executions) | clean | AVG: 235,431,549 <br /> MIN: 235,431,547 <br /> MAX: 235,431,551 | AVG: 4,862,202,181 <br /> MIN: 4,859,430,666 <br /> MAX: 4,864,297,738 | AVG: 126,499,038 <br /> MIN: 125,146,650 <br /> MAX: 128,392,418 |
| sphincs-shake256-256s-robust (3 executions) | clean | AVG: 7,116,955,982 <br /> MIN: 7,116,955,971 <br /> MAX: 7,116,956,001 | AVG: 81,034,023,028 <br /> MIN: 81,032,311,123 <br /> MAX: 81,035,076,510 | AVG: 118,824,499 <br /> MIN: 117,244,769 <br /> MAX: 120,404,198 |
| sphincs-shake256-256s-simple (3 executions) | clean | AVG: 3,764,083,718 <br /> MIN: 3,764,083,699 <br /> MAX: 3,764,083,747 | AVG: 44,854,626,450 <br /> MIN: 44,852,599,234 <br /> MAX: 44,856,247,631 | AVG: 60,503,704 <br /> MIN: 60,030,819 <br /> MAX: 61,246,868 |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| bikel1 | m4f | 44,068 | 32,116 | 91,368 |
| bikel1 | opt | 35,852 | 25,868 | 78,548 |
| firesaber | clean | 19,340 | 19,444 | 20,924 |
| firesaber | m4fspeed | 7,668 | 8,340 | 8,348 |
| firesaber | m4fstack | 4,300 | 3,316 | 3,324 |
| frodokem640aes | m4 | 31,984 | 62,480 | 83,104 |
| frodokem640shake | m4 | 26,408 | 51,784 | 72,408 |
| frodokem640shake | opt | 36,480 | 58,136 | 78,760 |
| hqc-rmrs-128 | clean | 48,828 | 64,412 | 71,148 |
| kyber1024 | clean | 15,076 | 18,748 | 20,324 |
| kyber1024 | m4fspeed | 6,336 | 7,432 | 7,448 |
| kyber1024 | m4fstack | 3,256 | 3,328 | 3,352 |
| kyber1024-90s | clean | 15,340 | 19,020 | 20,596 |
| kyber1024-90s | m4fspeed | 7,076 | 8,172 | 8,188 |
| kyber1024-90s | m4fstack | 4,004 | 4,076 | 4,100 |
| kyber512 | clean | 6,100 | 8,764 | 9,540 |
| kyber512 | m4fspeed | 4,272 | 5,376 | 5,384 |
| kyber512 | m4fstack | 2,212 | 2,300 | 2,316 |
| kyber512-90s | clean | 6,548 | 9,212 | 9,988 |
| kyber512-90s | m4fspeed | 5,012 | 6,116 | 6,124 |
| kyber512-90s | m4fstack | 2,956 | 3,044 | 3,060 |
| kyber768 | clean | 10,196 | 13,364 | 14,460 |
| kyber768 | m4fspeed | 5,312 | 6,424 | 6,440 |
| kyber768 | m4fstack | 2,736 | 2,808 | 2,824 |
| kyber768-90s | clean | 10,652 | 13,820 | 14,916 |
| kyber768-90s | m4fspeed | 6,052 | 7,164 | 7,180 |
| kyber768-90s | m4fstack | 3,476 | 3,548 | 3,564 |
| lightsaber | clean | 9,320 | 9,424 | 10,168 |
| lightsaber | m4fspeed | 5,612 | 6,284 | 6,292 |
| lightsaber | m4fstack | 3,276 | 3,052 | 3,060 |
| ntruhps2048509 | clean | 25,420 | 20,532 | 18,884 |
| ntruhps2048509 | m4f | 21,344 | 14,060 | 14,800 |
| ntruhps2048677 | clean | 34,320 | 27,780 | 25,572 |
| ntruhps2048677 | m4f | 28,456 | 19,972 | 19,728 |
| ntruhps4096821 | clean | 40,984 | 33,060 | 30,460 |
| ntruhps4096821 | m4f | 35,208 | 23,412 | 24,280 |
| ntruhrss701 | clean | 32,908 | 26,164 | 25,972 |
| ntruhrss701 | m4f | 27,512 | 18,316 | 20,560 |
| ntrulpr1013 | clean | 14,288 | 14,544 | 16,536 |
| ntrulpr1013 | m4f | 25,716 | 30,420 | 35,692 |
| ntrulpr1277 | clean | 17,984 | 18,104 | 20,624 |
| ntrulpr1277 | m4f | 44,452 | 50,204 | 56,796 |
| ntrulpr653 | clean | 11,864 | 12,056 | 13,304 |
| ntrulpr653 | m4f | 12,680 | 15,952 | 19,424 |
| ntrulpr761 | clean | 10,768 | 11,064 | 12,552 |
| ntrulpr761 | m4f | 16,224 | 19,912 | 23,944 |
| ntrulpr857 | clean | 15,632 | 15,704 | 17,376 |
| ntrulpr857 | m4f | 24,364 | 28,436 | 32,932 |
| ntrulpr953 | clean | 13,456 | 13,736 | 15,592 |
| ntrulpr953 | m4f | 25,164 | 29,628 | 34,596 |
| saber | clean | 12,904 | 13,008 | 14,112 |
| saber | m4fspeed | 6,644 | 7,316 | 7,324 |
| saber | m4fstack | 3,788 | 3,180 | 3,188 |
| sikep434 | m4 | 6,208 | 6,496 | 6,832 |
| sikep434 | opt | 6,744 | 7,032 | 7,312 |
| sikep503 | m4 | 6,976 | 7,328 | 7,704 |
| sikep503 | opt | 6,656 | 7,008 | 7,384 |
| sikep610 | m4 | 10,520 | 10,920 | 11,384 |
| sikep610 | opt | 10,096 | 10,496 | 10,968 |
| sikep751 | m4 | 12,288 | 12,296 | 12,864 |
| sikep751 | opt | 11,640 | 11,760 | 12,220 |
| sntrup1013 | clean | 16,316 | 12,400 | 14,992 |
| sntrup1013 | m4f | 102,704 | 25,932 | 30,772 |
| sntrup1277 | clean | 20,664 | 15,552 | 18,816 |
| sntrup1277 | m4f | 90,232 | 32,452 | 38,524 |
| sntrup653 | clean | 10,664 | 7,992 | 9,664 |
| sntrup653 | m4f | 91,568 | 12,792 | 16,088 |
| sntrup761 | clean | 12,284 | 9,256 | 11,200 |
| sntrup761 | m4f | 102,544 | 16,368 | 20,008 |
| sntrup857 | clean | 13,928 | 10,504 | 12,592 |
| sntrup857 | m4f | 102,200 | 24,548 | 28,852 |
| sntrup953 | clean | 15,472 | 11,584 | 14,128 |
| sntrup953 | m4f | 89,112 | 25,372 | 29,908 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| dilithium2 | clean | 38,284 | 51,908 | 36,196 |
| dilithium2 | m4f | 38,276 | 49,356 | 36,296 |
| dilithium2aes | clean | 39,764 | 53,388 | 37,676 |
| dilithium3 | clean | 60,812 | 79,664 | 57,700 |
| dilithium3 | m4f | 60,804 | 68,804 | 57,692 |
| dilithium3aes | clean | 62,292 | 81,036 | 59,180 |
| dilithium5 | m4f | 97,776 | 116,016 | 92,872 |
| falcon-1024 | clean | 36,264 | 82,428 | 8,796 |
| falcon-1024 | m4-ct | 1,488 | 2,568 | 496 |
| falcon-1024 | opt-ct | 1,448 | 2,568 | 388 |
| falcon-1024 | opt-leaktime | 1,472 | 2,664 | 388 |
| falcon-512 | clean | 18,368 | 42,404 | 4,700 |
| falcon-512 | m4-ct | 1,488 | 2,592 | 388 |
| falcon-512 | opt-ct | 1,400 | 2,592 | 388 |
| falcon-512 | opt-leaktime | 1,392 | 2,568 | 388 |
| falcon-512-tree | m4-ct | 1,480 | 2,776 | 388 |
| falcon-512-tree | opt-ct | 1,480 | 2,776 | 388 |
| falcon-512-tree | opt-leaktime | 1,464 | 2,792 | 388 |
| picnic3l1 | opt | 800 | 32,244 | 32,236 |
| picnic3l1 | opt-mem | 808 | 24,656 | 32,444 |
| picnicl1fs | opt | 684 | 4,052 | 4,052 |
| picnicl1full | opt | 800 | 4,224 | 3,528 |
| sphincs-haraka-128f-robust | clean | 3,620 | 3,712 | 4,172 |
| sphincs-haraka-128f-simple | clean | 3,612 | 3,676 | 4,164 |
| sphincs-haraka-128s-robust | clean | 3,944 | 3,904 | 3,476 |
| sphincs-haraka-128s-simple | clean | 3,856 | 3,896 | 3,468 |
| sphincs-haraka-192f-robust | clean | 5,036 | 5,184 | 5,396 |
| sphincs-haraka-192f-simple | clean | 5,028 | 5,096 | 5,388 |
| sphincs-haraka-192s-robust | clean | 5,376 | 5,344 | 4,732 |
| sphincs-haraka-192s-simple | clean | 5,368 | 5,336 | 4,724 |
| sphincs-haraka-256f-robust | clean | 7,056 | 7,104 | 7,004 |
| sphincs-haraka-256f-simple | clean | 7,048 | 7,096 | 6,996 |
| sphincs-haraka-256s-robust | clean | 7,408 | 7,248 | 6,624 |
| sphincs-haraka-256s-simple | clean | 7,320 | 7,240 | 6,588 |
| sphincs-sha256-128f-robust | clean | 2,256 | 2,320 | 2,808 |
| sphincs-sha256-128f-simple | clean | 2,104 | 2,168 | 2,656 |
| sphincs-sha256-128s-robust | clean | 2,472 | 2,544 | 2,112 |
| sphincs-sha256-128s-simple | clean | 2,432 | 2,392 | 1,960 |
| sphincs-sha256-192f-robust | clean | 3,680 | 3,832 | 4,040 |
| sphincs-sha256-192f-simple | clean | 3,520 | 3,560 | 3,880 |
| sphincs-sha256-192s-robust | clean | 4,104 | 3,992 | 3,376 |
| sphincs-sha256-192s-simple | clean | 3,944 | 3,832 | 3,216 |
| sphincs-sha256-256f-robust | clean | 5,792 | 5,760 | 5,656 |
| sphincs-sha256-256f-simple | clean | 5,512 | 5,592 | 5,488 |
| sphincs-sha256-256s-robust | clean | 6,064 | 5,904 | 5,360 |
| sphincs-sha256-256s-simple | clean | 5,896 | 5,736 | 5,080 |
| sphincs-shake256-128f-robust | clean | 2,012 | 2,176 | 2,556 |
| sphincs-shake256-128f-simple | clean | 2,012 | 2,068 | 2,556 |
| sphincs-shake256-128s-robust | clean | 2,336 | 2,288 | 1,860 |
| sphincs-shake256-128s-simple | clean | 2,336 | 2,288 | 1,860 |
| sphincs-shake256-192f-robust | clean | 3,436 | 3,576 | 3,788 |
| sphincs-shake256-192f-simple | clean | 3,436 | 3,468 | 3,788 |
| sphincs-shake256-192s-robust | clean | 3,856 | 3,736 | 3,124 |
| sphincs-shake256-192s-simple | clean | 3,856 | 3,736 | 3,124 |
| sphincs-shake256-256f-robust | clean | 5,436 | 5,504 | 5,404 |
| sphincs-shake256-256f-simple | clean | 5,436 | 5,504 | 5,404 |
| sphincs-shake256-256s-robust | clean | 5,816 | 5,648 | 4,996 |
| sphincs-shake256-256s-simple | clean | 5,816 | 5,648 | 4,996 |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| bikel1 | m4f | 0.7% | 15.1% | 1.0% |
| bikel1 | opt | 0.3% | 10.3% | 0.4% |
| firesaber | clean | 19.1% | 18.9% | 14.1% |
| firesaber | m4fspeed | 71.4% | 72.7% | 64.0% |
| firesaber | m4fstack | 53.9% | 54.2% | 46.2% |
| frodokem640aes | m4 | 74.3% | 77.8% | 77.1% |
| frodokem640shake | m4 | 84.7% | 86.3% | 86.0% |
| frodokem640shake | opt | 74.3% | 65.4% | 64.9% |
| hqc-rmrs-128 | clean | 53.7% | 41.4% | 33.3% |
| kyber1024 | clean | 54.4% | 53.8% | 42.7% |
| kyber1024 | m4fspeed | 77.5% | 80.8% | 73.9% |
| kyber1024 | m4fstack | 76.9% | 80.1% | 73.1% |
| kyber1024-90s | clean | 73.8% | 70.5% | 64.0% |
| kyber1024-90s | m4fspeed | 69.3% | 71.9% | 66.0% |
| kyber1024-90s | m4fstack | 68.6% | 71.0% | 65.1% |
| kyber512 | clean | 54.7% | 51.7% | 37.1% |
| kyber512 | m4fspeed | 78.1% | 80.5% | 70.6% |
| kyber512 | m4fstack | 78.0% | 80.2% | 70.2% |
| kyber512-90s | clean | 68.8% | 62.8% | 52.7% |
| kyber512-90s | m4fspeed | 71.0% | 72.8% | 64.2% |
| kyber512-90s | m4fstack | 70.8% | 72.3% | 63.7% |
| kyber768 | clean | 52.8% | 52.4% | 39.7% |
| kyber768 | m4fspeed | 76.5% | 80.3% | 72.0% |
| kyber768 | m4fstack | 76.1% | 79.8% | 71.4% |
| kyber768-90s | clean | 71.5% | 67.4% | 59.5% |
| kyber768-90s | m4fspeed | 68.8% | 71.8% | 64.8% |
| kyber768-90s | m4fstack | 68.3% | 71.1% | 64.0% |
| lightsaber | clean | 24.9% | 23.8% | 15.5% |
| lightsaber | m4fspeed | 72.3% | 74.0% | 61.9% |
| lightsaber | m4fstack | 60.3% | 60.2% | 48.2% |
| ntruhps2048509 | clean | 0.0% | 2.4% | 4.1% |
| ntruhps2048509 | m4f | 0.0% | 4.5% | 18.8% |
| ntruhps2048677 | clean | 0.0% | 2.1% | 3.2% |
| ntruhps2048677 | m4f | 0.0% | 4.6% | 17.2% |
| ntruhps4096821 | clean | 0.0% | 1.6% | 2.9% |
| ntruhps4096821 | m4f | 0.0% | 3.8% | 16.2% |
| ntruhrss701 | clean | 0.0% | 2.5% | 3.5% |
| ntruhrss701 | m4f | 0.0% | 10.2% | 17.6% |
| ntrulpr1013 | clean | 6.5% | 6.9% | 4.3% |
| ntrulpr1013 | m4f | 30.5% | 51.6% | 42.4% |
| ntrulpr1277 | clean | 5.3% | 5.6% | 3.5% |
| ntrulpr1277 | m4f | 29.7% | 50.7% | 41.7% |
| ntrulpr653 | clean | 9.0% | 9.8% | 6.2% |
| ntrulpr653 | m4f | 32.4% | 54.5% | 45.4% |
| ntrulpr761 | clean | 7.9% | 8.5% | 5.4% |
| ntrulpr761 | m4f | 23.8% | 41.0% | 38.6% |
| ntrulpr857 | clean | 7.1% | 7.6% | 4.8% |
| ntrulpr857 | m4f | 30.8% | 52.3% | 43.2% |
| ntrulpr953 | clean | 6.5% | 6.9% | 4.3% |
| ntrulpr953 | m4f | 31.2% | 53.3% | 44.3% |
| saber | clean | 21.9% | 21.4% | 15.1% |
| saber | m4fspeed | 72.6% | 74.0% | 63.9% |
| saber | m4fstack | 57.2% | 57.4% | 47.6% |
| sikep434 | m4 | 0.0% | 0.1% | 0.1% |
| sikep434 | opt | 0.0% | 0.0% | 0.0% |
| sikep503 | m4 | 0.0% | 0.1% | 0.1% |
| sikep503 | opt | 0.0% | 0.0% | 0.0% |
| sikep610 | m4 | 0.0% | 0.1% | 0.1% |
| sikep610 | opt | 0.0% | 0.0% | 0.0% |
| sikep751 | m4 | 0.0% | 0.0% | 0.0% |
| sikep751 | opt | 0.0% | 0.0% | 0.0% |
| sntrup1013 | clean | 0.0% | 3.0% | 0.6% |
| sntrup1013 | m4f | 0.8% | 27.8% | 20.4% |
| sntrup1277 | clean | 0.0% | 2.4% | 0.5% |
| sntrup1277 | m4f | 0.7% | 26.2% | 18.4% |
| sntrup653 | clean | 0.1% | 4.2% | 1.0% |
| sntrup653 | m4f | 1.1% | 29.9% | 24.2% |
| sntrup761 | clean | 0.1% | 3.7% | 0.8% |
| sntrup761 | m4f | 0.0% | 0.0% | 0.0% |
| sntrup857 | clean | 0.1% | 3.2% | 0.7% |
| sntrup857 | m4f | 1.0% | 27.3% | 19.6% |
| sntrup953 | clean | 0.0% | 2.9% | 0.7% |
| sntrup953 | m4f | 0.8% | 28.5% | 21.8% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| dilithium2 | clean | 67.1% | 37.3% | 60.1% |
| dilithium2 | m4f | 82.8% | 65.2% | 80.4% |
| dilithium2aes | clean | 2.7% | 3.3% | 5.0% |
| dilithium3 | clean | 70.5% | 37.0% | 63.6% |
| dilithium3 | m4f | 85.0% | 64.4% | 82.6% |
| dilithium3aes | clean | 2.2% | 2.5% | 3.5% |
| dilithium5 | m4f | 86.0% | 69.1% | 84.5% |
| falcon-1024 | clean | 8.4% | 0.3% | 26.9% |
| falcon-1024 | m4-ct | 10.6% | 0.5% | 34.2% |
| falcon-1024 | opt-ct | 11.1% | 0.5% | 34.3% |
| falcon-1024 | opt-leaktime | 13.1% | 0.5% | 34.1% |
| falcon-512 | clean | 14.9% | 0.4% | 29.3% |
| falcon-512 | m4-ct | 18.5% | 0.5% | 35.8% |
| falcon-512 | opt-ct | 16.7% | 0.5% | 36.0% |
| falcon-512 | opt-leaktime | 19.8% | 0.6% | 35.8% |
| falcon-512-tree | m4-ct | 18.0% | 1.1% | 35.8% |
| falcon-512-tree | opt-ct | 16.5% | 1.1% | 35.9% |
| falcon-512-tree | opt-leaktime | 19.3% | 1.1% | 35.8% |
| picnic3l1 | opt | 0.0% | 69.5% | 84.0% |
| picnic3l1 | opt-mem | 0.0% | 71.0% | 85.5% |
| picnicl1fs | opt | 0.0% | 28.3% | 29.7% |
| picnicl1full | opt | 0.0% | 38.0% | 39.4% |
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
| sphincs-sha256-128f-robust | clean | 88.2% | 88.1% | 88.3% |
| sphincs-sha256-128f-simple | clean | 85.8% | 85.7% | 85.7% |
| sphincs-sha256-128s-robust | clean | 88.2% | 88.1% | 88.2% |
| sphincs-sha256-128s-simple | clean | 85.8% | 85.7% | 85.6% |
| sphincs-sha256-192f-robust | clean | 87.7% | 87.9% | 88.1% |
| sphincs-sha256-192f-simple | clean | 85.4% | 85.7% | 85.7% |
| sphincs-sha256-192s-robust | clean | 87.8% | 88.0% | 88.3% |
| sphincs-sha256-192s-simple | clean | 85.4% | 85.8% | 86.1% |
| sphincs-sha256-256f-robust | clean | 91.3% | 91.3% | 91.7% |
| sphincs-sha256-256f-simple | clean | 85.1% | 85.4% | 85.5% |
| sphincs-sha256-256s-robust | clean | 91.4% | 91.5% | 91.9% |
| sphincs-sha256-256s-simple | clean | 85.5% | 85.9% | 86.1% |
| sphincs-shake256-128f-robust | clean | 97.4% | 97.4% | 97.4% |
| sphincs-shake256-128f-simple | clean | 95.7% | 95.7% | 95.6% |
| sphincs-shake256-128s-robust | clean | 97.4% | 97.4% | 97.4% |
| sphincs-shake256-128s-simple | clean | 95.7% | 95.7% | 95.6% |
| sphincs-shake256-192f-robust | clean | 97.4% | 97.3% | 97.4% |
| sphincs-shake256-192f-simple | clean | 95.6% | 95.6% | 95.6% |
| sphincs-shake256-192s-robust | clean | 97.4% | 97.3% | 97.4% |
| sphincs-shake256-192s-simple | clean | 95.7% | 95.6% | 95.5% |
| sphincs-shake256-256f-robust | clean | 97.3% | 97.3% | 97.4% |
| sphincs-shake256-256f-simple | clean | 95.6% | 95.6% | 95.6% |
| sphincs-shake256-256s-robust | clean | 97.4% | 97.2% | 97.4% |
| sphincs-shake256-256s-simple | clean | 95.7% | 95.5% | 95.6% |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| bikel1 | m4f | 181,560 | 24 | 49 | 181,633 |
| bikel1 | opt | 35,051 | 24 | 1 | 35,076 |
| firesaber | clean | 10,220 | 0 | 0 | 10,220 |
| firesaber | m4fspeed | 18,792 | 0 | 0 | 18,792 |
| firesaber | m4fstack | 19,536 | 0 | 0 | 19,536 |
| frodokem640aes | m4 | 8,568 | 0 | 0 | 8,568 |
| frodokem640shake | m4 | 8,644 | 0 | 0 | 8,644 |
| frodokem640shake | opt | 6,796 | 0 | 0 | 6,796 |
| hqc-rmrs-128 | clean | 18,436 | 0 | 0 | 18,436 |
| kyber1024 | clean | 6,084 | 0 | 0 | 6,084 |
| kyber1024 | m4fspeed | 18,324 | 0 | 0 | 18,324 |
| kyber1024 | m4fstack | 15,452 | 0 | 0 | 15,452 |
| kyber1024-90s | clean | 6,468 | 0 | 0 | 6,468 |
| kyber1024-90s | m4fspeed | 18,832 | 0 | 0 | 18,832 |
| kyber1024-90s | m4fstack | 15,744 | 0 | 0 | 15,744 |
| kyber512 | clean | 4,900 | 0 | 0 | 4,900 |
| kyber512 | m4fspeed | 17,220 | 0 | 0 | 17,220 |
| kyber512 | m4fstack | 14,624 | 0 | 0 | 14,624 |
| kyber512-90s | clean | 5,144 | 0 | 0 | 5,144 |
| kyber512-90s | m4fspeed | 17,728 | 0 | 0 | 17,728 |
| kyber512-90s | m4fstack | 14,900 | 0 | 0 | 14,900 |
| kyber768 | clean | 4,912 | 0 | 0 | 4,912 |
| kyber768 | m4fspeed | 17,532 | 0 | 0 | 17,532 |
| kyber768 | m4fstack | 14,528 | 0 | 0 | 14,528 |
| kyber768-90s | clean | 5,176 | 0 | 0 | 5,176 |
| kyber768-90s | m4fspeed | 18,064 | 0 | 0 | 18,064 |
| kyber768-90s | m4fstack | 14,784 | 0 | 0 | 14,784 |
| lightsaber | clean | 10,368 | 0 | 0 | 10,368 |
| lightsaber | m4fspeed | 18,900 | 0 | 0 | 18,900 |
| lightsaber | m4fstack | 19,712 | 0 | 0 | 19,712 |
| ntruhps2048509 | clean | 64,644 | 0 | 0 | 64,644 |
| ntruhps2048509 | m4f | 191,916 | 0 | 0 | 191,916 |
| ntruhps2048677 | clean | 17,304 | 0 | 0 | 17,304 |
| ntruhps2048677 | m4f | 281,696 | 0 | 0 | 281,696 |
| ntruhps4096821 | clean | 17,064 | 0 | 0 | 17,064 |
| ntruhps4096821 | m4f | 370,192 | 0 | 0 | 370,192 |
| ntruhrss701 | clean | 16,724 | 0 | 0 | 16,724 |
| ntruhrss701 | m4f | 264,688 | 0 | 0 | 264,688 |
| ntrulpr1013 | clean | 8,536 | 0 | 0 | 8,536 |
| ntrulpr1013 | m4f | 36,396 | 0 | 0 | 36,396 |
| ntrulpr1277 | clean | 7,928 | 0 | 0 | 7,928 |
| ntrulpr1277 | m4f | 56,524 | 0 | 0 | 56,524 |
| ntrulpr653 | clean | 7,532 | 0 | 0 | 7,532 |
| ntrulpr653 | m4f | 21,496 | 0 | 0 | 21,496 |
| ntrulpr761 | clean | 7,988 | 0 | 0 | 7,988 |
| ntrulpr761 | m4f | 35,481 | 0 | 0 | 35,481 |
| ntrulpr857 | clean | 8,276 | 0 | 0 | 8,276 |
| ntrulpr857 | m4f | 143,432 | 0 | 0 | 143,432 |
| ntrulpr953 | clean | 8,488 | 0 | 0 | 8,488 |
| ntrulpr953 | m4f | 132,444 | 0 | 0 | 132,444 |
| saber | clean | 10,128 | 0 | 0 | 10,128 |
| saber | m4fspeed | 18,708 | 0 | 0 | 18,708 |
| saber | m4fstack | 19,428 | 0 | 0 | 19,428 |
| sikep434 | m4 | 29,604 | 0 | 0 | 29,604 |
| sikep434 | opt | 28,236 | 0 | 0 | 28,236 |
| sikep503 | m4 | 31,580 | 0 | 0 | 31,580 |
| sikep503 | opt | 26,436 | 0 | 0 | 26,436 |
| sikep610 | m4 | 29,424 | 0 | 0 | 29,424 |
| sikep610 | opt | 19,424 | 0 | 0 | 19,424 |
| sikep751 | m4 | 33,016 | 0 | 0 | 33,016 |
| sikep751 | opt | 21,068 | 0 | 0 | 21,068 |
| sntrup1013 | clean | 14,432 | 0 | 0 | 14,432 |
| sntrup1013 | m4f | 388,372 | 0 | 0 | 388,372 |
| sntrup1277 | clean | 13,288 | 0 | 0 | 13,288 |
| sntrup1277 | m4f | 455,956 | 0 | 0 | 455,956 |
| sntrup653 | clean | 12,488 | 0 | 0 | 12,488 |
| sntrup653 | m4f | 237,580 | 0 | 0 | 237,580 |
| sntrup761 | clean | 13,228 | 0 | 0 | 13,228 |
| sntrup761 | m4f | 350,545 | 0 | 0 | 350,545 |
| sntrup857 | clean | 13,632 | 0 | 0 | 13,632 |
| sntrup857 | m4f | 597,996 | 0 | 0 | 597,996 |
| sntrup953 | clean | 14,388 | 0 | 0 | 14,388 |
| sntrup953 | m4f | 545,612 | 0 | 0 | 545,612 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| dilithium2 | clean | 7,948 | 0 | 0 | 7,948 |
| dilithium2 | m4f | 18,440 | 0 | 0 | 18,440 |
| dilithium2aes | clean | 14,982 | 0 | 0 | 14,982 |
| dilithium3 | clean | 7,444 | 0 | 0 | 7,444 |
| dilithium3 | m4f | 19,912 | 0 | 0 | 19,912 |
| dilithium3aes | clean | 14,470 | 0 | 0 | 14,470 |
| dilithium5 | m4f | 18,236 | 0 | 0 | 18,236 |
| falcon-1024 | clean | 82,285 | 0 | 0 | 82,285 |
| falcon-1024 | m4-ct | 81,265 | 0 | 79,872 | 161,137 |
| falcon-1024 | opt-ct | 81,265 | 0 | 79,872 | 161,137 |
| falcon-1024 | opt-leaktime | 74,461 | 0 | 79,872 | 154,333 |
| falcon-512 | clean | 82,253 | 0 | 0 | 82,253 |
| falcon-512 | m4-ct | 81,265 | 0 | 39,936 | 121,201 |
| falcon-512 | opt-ct | 81,265 | 0 | 39,936 | 121,201 |
| falcon-512 | opt-leaktime | 74,461 | 0 | 39,936 | 114,397 |
| falcon-512-tree | m4-ct | 81,005 | 0 | 27,648 | 108,653 |
| falcon-512-tree | opt-ct | 81,005 | 0 | 27,648 | 108,653 |
| falcon-512-tree | opt-leaktime | 74,201 | 0 | 27,648 | 101,849 |
| picnic3l1 | opt | 80,392 | 1,092 | 13 | 81,497 |
| picnic3l1 | opt-mem | 92,928 | 1,092 | 13 | 94,033 |
| picnicl1fs | opt | 54,962 | 1,072 | 0 | 56,034 |
| picnicl1full | opt | 104,956 | 1,072 | 0 | 106,028 |
| sphincs-haraka-128f-robust | clean | 16,600 | 0 | 0 | 16,600 |
| sphincs-haraka-128f-simple | clean | 16,448 | 0 | 0 | 16,448 |
| sphincs-haraka-128s-robust | clean | 16,912 | 0 | 0 | 16,912 |
| sphincs-haraka-128s-simple | clean | 16,764 | 0 | 0 | 16,764 |
| sphincs-haraka-192f-robust | clean | 16,656 | 0 | 0 | 16,656 |
| sphincs-haraka-192f-simple | clean | 16,472 | 0 | 0 | 16,472 |
| sphincs-haraka-192s-robust | clean | 17,172 | 0 | 0 | 17,172 |
| sphincs-haraka-192s-simple | clean | 16,988 | 0 | 0 | 16,988 |
| sphincs-haraka-256f-robust | clean | 17,048 | 0 | 0 | 17,048 |
| sphincs-haraka-256f-simple | clean | 16,804 | 0 | 0 | 16,804 |
| sphincs-haraka-256s-robust | clean | 17,340 | 0 | 0 | 17,340 |
| sphincs-haraka-256s-simple | clean | 17,096 | 0 | 0 | 17,096 |
| sphincs-sha256-128f-robust | clean | 4,756 | 0 | 0 | 4,756 |
| sphincs-sha256-128f-simple | clean | 4,508 | 0 | 0 | 4,508 |
| sphincs-sha256-128s-robust | clean | 5,068 | 0 | 0 | 5,068 |
| sphincs-sha256-128s-simple | clean | 4,820 | 0 | 0 | 4,820 |
| sphincs-sha256-192f-robust | clean | 5,040 | 0 | 0 | 5,040 |
| sphincs-sha256-192f-simple | clean | 4,672 | 0 | 0 | 4,672 |
| sphincs-sha256-192s-robust | clean | 5,564 | 0 | 0 | 5,564 |
| sphincs-sha256-192s-simple | clean | 5,192 | 0 | 0 | 5,192 |
| sphincs-sha256-256f-robust | clean | 5,528 | 0 | 0 | 5,528 |
| sphincs-sha256-256f-simple | clean | 5,060 | 0 | 0 | 5,060 |
| sphincs-sha256-256s-robust | clean | 5,816 | 0 | 0 | 5,816 |
| sphincs-sha256-256s-simple | clean | 5,344 | 0 | 0 | 5,344 |
| sphincs-shake256-128f-robust | clean | 4,028 | 0 | 0 | 4,028 |
| sphincs-shake256-128f-simple | clean | 3,888 | 0 | 0 | 3,888 |
| sphincs-shake256-128s-robust | clean | 4,340 | 0 | 0 | 4,340 |
| sphincs-shake256-128s-simple | clean | 4,196 | 0 | 0 | 4,196 |
| sphincs-shake256-192f-robust | clean | 4,128 | 0 | 0 | 4,128 |
| sphincs-shake256-192f-simple | clean | 3,956 | 0 | 0 | 3,956 |
| sphincs-shake256-192s-robust | clean | 4,644 | 0 | 0 | 4,644 |
| sphincs-shake256-192s-simple | clean | 4,472 | 0 | 0 | 4,472 |
| sphincs-shake256-256f-robust | clean | 4,532 | 0 | 0 | 4,532 |
| sphincs-shake256-256f-simple | clean | 4,320 | 0 | 0 | 4,320 |
| sphincs-shake256-256s-robust | clean | 4,820 | 0 | 0 | 4,820 |
| sphincs-shake256-256s-simple | clean | 4,612 | 0 | 0 | 4,612 |
