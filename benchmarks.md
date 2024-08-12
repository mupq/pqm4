# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| bikel1 (10 executions) | m4f | AVG: 27,382,389 <br /> MIN: 27,382,366 <br /> MAX: 27,382,406 | AVG: 3,363,252 <br /> MIN: 3,363,238 <br /> MAX: 3,363,291 | AVG: 56,744,036 <br /> MIN: 56,744,013 <br /> MAX: 56,744,062 |
| bikel1 (10 executions) | opt | AVG: 76,272,765 <br /> MIN: 76,272,741 <br /> MAX: 76,272,809 | AVG: 5,295,900 <br /> MIN: 5,295,877 <br /> MAX: 5,295,931 | AVG: 138,514,606 <br /> MIN: 138,514,541 <br /> MAX: 138,514,711 |
| bikel3 (10 executions) | m4f | AVG: 66,285,221 <br /> MIN: 66,285,184 <br /> MAX: 66,285,235 | AVG: 8,441,498 <br /> MIN: 8,441,478 <br /> MAX: 8,441,521 | AVG: 150,282,952 <br /> MIN: 150,282,849 <br /> MAX: 150,282,974 |
| bikel3 (10 executions) | opt | AVG: 248,083,316 <br /> MIN: 248,083,286 <br /> MAX: 248,083,345 | AVG: 16,405,238 <br /> MIN: 16,405,236 <br /> MAX: 16,405,241 | AVG: 423,262,047 <br /> MIN: 423,261,952 <br /> MAX: 423,262,086 |
| hqc-128 (10 executions) | clean | AVG: 52,705,201 <br /> MIN: 52,705,180 <br /> MAX: 52,705,224 | AVG: 105,650,897 <br /> MIN: 105,650,877 <br /> MAX: 105,650,927 | AVG: 159,569,179 <br /> MIN: 159,569,176 <br /> MAX: 159,569,183 |
| hqc-192 (10 executions) | clean | AVG: 161,458,617 <br /> MIN: 161,458,590 <br /> MAX: 161,458,638 | AVG: 323,146,261 <br /> MIN: 323,146,250 <br /> MAX: 323,146,292 | AVG: 486,156,251 <br /> MIN: 486,156,214 <br /> MAX: 486,156,266 |
| hqc-256 (10 executions) | clean | AVG: 295,934,078 <br /> MIN: 295,934,057 <br /> MAX: 295,934,104 | AVG: 591,853,870 <br /> MIN: 591,853,850 <br /> MAX: 591,853,898 | AVG: 891,163,005 <br /> MIN: 891,162,988 <br /> MAX: 891,163,038 |
| kyber1024 (10 executions) | clean | AVG: 1,540,394 <br /> MIN: 1,537,580 <br /> MAX: 1,549,267 | AVG: 1,712,150 <br /> MIN: 1,709,337 <br /> MAX: 1,721,019 | AVG: 2,024,408 <br /> MIN: 2,021,583 <br /> MAX: 2,033,304 |
| kyber1024 (10 executions) | m4fspeed | AVG: 1,006,341 <br /> MIN: 1,004,590 <br /> MAX: 1,016,692 | AVG: 1,029,398 <br /> MIN: 1,027,642 <br /> MAX: 1,039,752 | AVG: 1,091,847 <br /> MIN: 1,090,091 <br /> MAX: 1,102,201 |
| kyber1024 (10 executions) | m4fstack | AVG: 1,009,603 <br /> MIN: 1,007,702 <br /> MAX: 1,019,835 | AVG: 1,038,001 <br /> MIN: 1,036,100 <br /> MAX: 1,048,226 | AVG: 1,101,208 <br /> MIN: 1,099,307 <br /> MAX: 1,111,470 |
| kyber512 (10 executions) | clean | AVG: 597,372 <br /> MIN: 596,106 <br /> MAX: 607,563 | AVG: 702,227 <br /> MIN: 700,957 <br /> MAX: 712,416 | AVG: 890,274 <br /> MIN: 889,008 <br /> MAX: 900,467 |
| kyber512 (10 executions) | m4fspeed | AVG: 387,341 <br /> MIN: 386,762 <br /> MAX: 387,769 | AVG: 391,098 <br /> MIN: 390,520 <br /> MAX: 391,527 | AVG: 428,365 <br /> MIN: 427,786 <br /> MAX: 428,794 |
| kyber512 (10 executions) | m4fstack | AVG: 386,853 <br /> MIN: 386,573 <br /> MAX: 387,221 | AVG: 392,801 <br /> MIN: 392,521 <br /> MAX: 393,166 | AVG: 430,140 <br /> MIN: 429,861 <br /> MAX: 430,504 |
| kyber768 (10 executions) | clean | AVG: 989,247 <br /> MIN: 987,825 <br /> MAX: 999,577 | AVG: 1,138,807 <br /> MIN: 1,137,381 <br /> MAX: 1,149,131 | AVG: 1,388,568 <br /> MIN: 1,387,146 <br /> MAX: 1,398,896 |
| kyber768 (10 executions) | m4fspeed | AVG: 631,912 <br /> MIN: 631,599 <br /> MAX: 632,459 | AVG: 656,455 <br /> MIN: 656,155 <br /> MAX: 656,969 | AVG: 705,524 <br /> MIN: 705,223 <br /> MAX: 706,037 |
| kyber768 (10 executions) | m4fstack | AVG: 634,213 <br /> MIN: 632,786 <br /> MAX: 644,273 | AVG: 662,556 <br /> MIN: 661,130 <br /> MAX: 672,615 | AVG: 712,081 <br /> MIN: 710,655 <br /> MAX: 722,140 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| aimer128f (10 executions) | mem_opt | AVG: 564,325 <br /> MIN: 564,324 <br /> MAX: 564,326 | AVG: 46,875,341 <br /> MIN: 46,874,593 <br /> MAX: 46,876,276 | AVG: 26,989,249 <br /> MIN: 26,988,505 <br /> MAX: 26,989,828 |
| aimer128f (10 executions) | ref | AVG: 564,323 <br /> MIN: 564,323 <br /> MAX: 564,324 | AVG: 28,991,142 <br /> MIN: 28,991,115 <br /> MAX: 28,991,171 | AVG: 26,994,617 <br /> MIN: 26,994,234 <br /> MAX: 26,994,927 |
| aimer128s (10 executions) | mem_opt | AVG: 564,323 <br /> MIN: 564,323 <br /> MAX: 564,325 | AVG: 374,834,586 <br /> MIN: 374,834,473 <br /> MAX: 374,834,973 | AVG: 227,230,761 <br /> MIN: 227,230,441 <br /> MAX: 227,230,833 |
| aimer192f (10 executions) | mem_opt | AVG: 1,397,043 <br /> MIN: 1,397,043 <br /> MAX: 1,397,043 | AVG: 117,993,511 <br /> MIN: 117,991,579 <br /> MAX: 117,995,094 | AVG: 76,372,135 <br /> MIN: 76,370,763 <br /> MAX: 76,373,839 |
| aimer192f (10 executions) | ref | AVG: 1,397,040 <br /> MIN: 1,397,040 <br /> MAX: 1,397,041 | AVG: 81,884,026 <br /> MIN: 81,883,991 <br /> MAX: 81,884,035 | AVG: 76,458,825 <br /> MIN: 76,456,517 <br /> MAX: 76,460,984 |
| aimer192s (10 executions) | mem_opt | AVG: 1,397,047 <br /> MIN: 1,397,039 <br /> MAX: 1,397,079 | AVG: 916,637,185 <br /> MIN: 916,637,133 <br /> MAX: 916,637,425 | AVG: 629,249,382 <br /> MIN: 629,249,345 <br /> MAX: 629,249,415 |
| aimer256f (10 executions) | mem_opt | AVG: 3,344,254 <br /> MIN: 3,344,250 <br /> MAX: 3,344,255 | AVG: 233,973,308 <br /> MIN: 233,969,892 <br /> MAX: 233,976,707 | AVG: 170,620,601 <br /> MIN: 170,617,448 <br /> MAX: 170,623,743 |
| aimer256f (10 executions) | ref | AVG: 3,344,258 <br /> MIN: 3,344,255 <br /> MAX: 3,344,292 | AVG: 164,484,408 <br /> MIN: 164,483,962 <br /> MAX: 164,484,481 | AVG: 170,648,722 <br /> MIN: 170,647,189 <br /> MAX: 170,651,027 |
| aimer256s (10 executions) | mem_opt | AVG: 3,344,262 <br /> MIN: 3,344,252 <br /> MAX: 3,344,293 | AVG: 1,752,719,642 <br /> MIN: 1,752,719,422 <br /> MAX: 1,752,720,844 | AVG: 1,361,337,862 <br /> MIN: 1,361,336,718 <br /> MAX: 1,361,338,013 |
| ascon-sign-128f-robust (10 executions) | ref | AVG: 122,506,162 <br /> MIN: 122,506,099 <br /> MAX: 122,506,254 | AVG: 2,855,797,836 <br /> MIN: 2,855,797,243 <br /> MAX: 2,855,798,602 | AVG: 174,707,763 <br /> MIN: 169,973,472 <br /> MAX: 179,525,137 |
| ascon-sign-128f-simple (10 executions) | ref | AVG: 69,376,878 <br /> MIN: 69,376,875 <br /> MAX: 69,376,883 | AVG: 1,629,111,557 <br /> MIN: 1,629,111,334 <br /> MAX: 1,629,112,028 | AVG: 97,798,317 <br /> MIN: 95,509,050 <br /> MAX: 98,714,007 |
| ascon-sign-128s-robust (10 executions) | ref | AVG: 7,842,366,557 <br /> MIN: 7,842,366,432 <br /> MAX: 7,842,366,620 | AVG: 59,267,552,580 <br /> MIN: 59,267,543,517 <br /> MAX: 59,267,565,672 | AVG: 60,232,378 <br /> MIN: 57,865,239 <br /> MAX: 62,848,708 |
| ascon-sign-128s-simple (10 executions) | ref | AVG: 4,441,129,007 <br /> MIN: 4,441,128,624 <br /> MAX: 4,441,129,583 | AVG: 33,877,719,255 <br /> MIN: 33,877,704,467 <br /> MAX: 33,877,739,518 | AVG: 33,665,713 <br /> MIN: 31,101,669 <br /> MAX: 34,993,483 |
| ascon-sign-192f-robust (10 executions) | ref | AVG: 222,614,206 <br /> MIN: 222,614,156 <br /> MAX: 222,614,345 | AVG: 5,712,962,198 <br /> MIN: 5,712,960,682 <br /> MAX: 5,712,963,829 | AVG: 321,026,499 <br /> MIN: 315,341,414 <br /> MAX: 327,745,233 |
| ascon-sign-192f-simple (10 executions) | ref | AVG: 128,167,067 <br /> MIN: 128,167,038 <br /> MAX: 128,167,083 | AVG: 3,345,487,807 <br /> MIN: 3,345,484,178 <br /> MAX: 3,345,492,588 | AVG: 179,328,421 <br /> MIN: 175,094,665 <br /> MAX: 183,794,127 |
| ascon-sign-192s-robust (10 executions) | ref | AVG: 14,249,838,562 <br /> MIN: 14,249,837,693 <br /> MAX: 14,249,840,118 | AVG: 126,646,612,223 <br /> MIN: 126,646,594,160 <br /> MAX: 126,646,651,564 | AVG: 111,451,290 <br /> MIN: 108,763,808 <br /> MAX: 114,965,691 |
| ascon-sign-192s-simple (10 executions) | ref | AVG: 8,204,011,592 <br /> MIN: 8,204,011,246 <br /> MAX: 8,204,011,971 | AVG: 74,760,768,141 <br /> MIN: 74,760,751,354 <br /> MAX: 74,760,789,761 | AVG: 61,679,880 <br /> MIN: 58,983,014 <br /> MAX: 64,202,741 |
| biscuit128f (10 executions) | ref | AVG: 1,054,719 <br /> MIN: 1,054,719 <br /> MAX: 1,054,720 | AVG: 274,072,426 <br /> MIN: 274,072,411 <br /> MAX: 274,072,461 | AVG: 254,371,114 <br /> MIN: 254,371,087 <br /> MAX: 254,371,140 |
| biscuit192f (10 executions) | ref | AVG: 1,886,203 <br /> MIN: 1,886,199 <br /> MAX: 1,886,238 | AVG: 765,314,258 <br /> MIN: 765,314,227 <br /> MAX: 765,314,291 | AVG: 713,412,502 <br /> MIN: 713,412,394 <br /> MAX: 713,412,608 |
| biscuit256f (10 executions) | ref | AVG: 3,301,990 <br /> MIN: 3,301,983 <br /> MAX: 3,302,022 | AVG: 1,747,187,940 <br /> MIN: 1,747,187,918 <br /> MAX: 1,747,187,973 | AVG: 1,678,998,604 <br /> MIN: 1,678,998,013 <br /> MAX: 1,678,998,987 |
| cross-sha2-r-sdp-1-fast (10 executions) | ref | AVG: 5,614,888 <br /> MIN: 5,590,276 <br /> MAX: 5,650,611 | AVG: 216,566,013 <br /> MIN: 215,745,202 <br /> MAX: 217,395,250 | AVG: 143,008,126 <br /> MIN: 141,803,162 <br /> MAX: 144,002,548 |
| cross-sha2-r-sdp-3-fast (10 executions) | ref | AVG: 8,201,340 <br /> MIN: 8,148,672 <br /> MAX: 8,208,465 | AVG: 241,899,820 <br /> MIN: 241,815,860 <br /> MAX: 242,049,039 | AVG: 123,896,179 <br /> MIN: 123,524,606 <br /> MAX: 124,545,760 |
| cross-sha2-r-sdpg-1-fast (10 executions) | ref | AVG: 2,151,163 <br /> MIN: 2,115,797 <br /> MAX: 2,174,685 | AVG: 116,162,852 <br /> MIN: 116,120,174 <br /> MAX: 116,181,821 | AVG: 87,741,423 <br /> MIN: 87,209,686 <br /> MAX: 88,267,494 |
| cross-sha2-r-sdpg-1-small (10 executions) | ref | AVG: 2,151,212 <br /> MIN: 2,115,845 <br /> MAX: 2,174,734 | AVG: 391,718,680 <br /> MIN: 391,662,566 <br /> MAX: 391,774,957 | AVG: 368,397,996 <br /> MIN: 367,703,173 <br /> MAX: 369,416,443 |
| cross-sha2-r-sdpg-3-fast (10 executions) | ref | AVG: 3,049,185 <br /> MIN: 2,996,960 <br /> MAX: 3,055,381 | AVG: 136,242,875 <br /> MIN: 136,234,139 <br /> MAX: 136,299,163 | AVG: 84,236,165 <br /> MIN: 83,659,318 <br /> MAX: 85,067,521 |
| cross-sha2-r-sdpg-5-fast (10 executions) | ref | AVG: 4,302,017 <br /> MIN: 4,249,738 <br /> MAX: 4,308,343 | AVG: 221,761,047 <br /> MIN: 221,758,357 <br /> MAX: 221,762,936 | AVG: 134,821,310 <br /> MIN: 134,547,992 <br /> MAX: 135,025,658 |
| cross-sha3-r-sdp-1-fast (10 executions) | ref | AVG: 967,965 <br /> MIN: 963,482 <br /> MAX: 978,861 | AVG: 58,864,285 <br /> MIN: 58,853,041 <br /> MAX: 58,876,854 | AVG: 30,641,221 <br /> MIN: 30,631,654 <br /> MAX: 30,661,122 |
| cross-sha3-r-sdp-3-fast (10 executions) | ref | AVG: 2,195,040 <br /> MIN: 2,191,401 <br /> MAX: 2,205,040 | AVG: 90,064,203 <br /> MIN: 90,034,522 <br /> MAX: 90,080,511 | AVG: 48,561,804 <br /> MIN: 48,542,657 <br /> MAX: 48,577,008 |
| cross-sha3-r-sdpg-1-fast (10 executions) | ref | AVG: 290,136 <br /> MIN: 287,742 <br /> MAX: 297,758 | AVG: 29,963,868 <br /> MIN: 29,960,918 <br /> MAX: 29,974,902 | AVG: 20,093,649 <br /> MIN: 20,078,626 <br /> MAX: 20,103,416 |
| cross-sha3-r-sdpg-1-small (10 executions) | ref | AVG: 290,135 <br /> MIN: 287,741 <br /> MAX: 297,757 | AVG: 102,853,622 <br /> MIN: 102,847,774 <br /> MAX: 102,861,948 | AVG: 75,137,510 <br /> MIN: 75,126,803 <br /> MAX: 75,159,685 |
| cross-sha3-r-sdpg-3-fast (10 executions) | ref | AVG: 627,948 <br /> MIN: 625,525 <br /> MAX: 637,639 | AVG: 43,573,841 <br /> MIN: 43,565,461 <br /> MAX: 43,582,933 | AVG: 27,513,830 <br /> MIN: 27,493,024 <br /> MAX: 27,525,746 |
| cross-sha3-r-sdpg-5-fast (10 executions) | ref | AVG: 1,146,280 <br /> MIN: 1,142,409 <br /> MAX: 1,153,794 | AVG: 93,557,878 <br /> MIN: 93,547,167 <br /> MAX: 93,566,329 | AVG: 59,948,216 <br /> MIN: 59,857,434 <br /> MAX: 60,043,852 |
| dilithium2 (1000 executions) | clean | AVG: 1,874,167 <br /> MIN: 1,827,645 <br /> MAX: 1,914,566 | AVG: 7,493,877 <br /> MIN: 3,321,630 <br /> MAX: 40,762,756 | AVG: 2,062,795 <br /> MIN: 2,062,255 <br /> MAX: 2,063,222 |
| dilithium2 (1000 executions) | m4f | AVG: 1,425,723 <br /> MIN: 1,379,410 <br /> MAX: 1,466,445 | AVG: 3,835,095 <br /> MIN: 1,813,682 <br /> MAX: 16,068,642 | AVG: 1,421,307 <br /> MIN: 1,420,219 <br /> MAX: 1,422,056 |
| dilithium2 (1000 executions) | m4fstack | AVG: 1,801,523 <br /> MIN: 1,684,895 <br /> MAX: 1,902,114 | AVG: 12,170,976 <br /> MIN: 3,900,911 <br /> MAX: 86,281,518 | AVG: 3,241,353 <br /> MIN: 3,194,028 <br /> MAX: 3,281,144 |
| dilithium3 (1000 executions) | clean | AVG: 3,205,551 <br /> MIN: 3,204,090 <br /> MAX: 3,207,411 | AVG: 12,696,585 <br /> MIN: 5,097,364 <br /> MAX: 74,392,293 | AVG: 3,376,992 <br /> MIN: 3,376,581 <br /> MAX: 3,377,393 |
| dilithium3 (1000 executions) | m4f | AVG: 2,515,915 <br /> MIN: 2,514,307 <br /> MAX: 2,517,413 | AVG: 6,054,094 <br /> MIN: 2,917,316 <br /> MAX: 27,829,552 | AVG: 2,415,526 <br /> MIN: 2,414,696 <br /> MAX: 2,416,440 |
| dilithium3 (1000 executions) | m4fstack | AVG: 3,412,759 <br /> MIN: 3,406,659 <br /> MAX: 3,419,247 | AVG: 23,673,016 <br /> MIN: 6,733,971 <br /> MAX: 145,803,146 | AVG: 5,733,307 <br /> MIN: 5,688,893 <br /> MAX: 5,778,120 |
| dilithium5 (1000 executions) | clean | AVG: 5,341,477 <br /> MIN: 5,286,872 <br /> MAX: 5,395,822 | AVG: 15,710,371 <br /> MIN: 7,953,367 <br /> MAX: 75,940,093 | AVG: 5,609,679 <br /> MIN: 5,609,217 <br /> MAX: 5,610,183 |
| dilithium5 (1000 executions) | m4f | AVG: 4,275,033 <br /> MIN: 4,220,989 <br /> MAX: 4,350,945 | AVG: 8,349,360 <br /> MIN: 4,882,552 <br /> MAX: 29,688,762 | AVG: 4,192,692 <br /> MIN: 4,191,427 <br /> MAX: 4,193,764 |
| dilithium5 (1000 executions) | m4fstack | AVG: 5,816,287 <br /> MIN: 5,474,236 <br /> MAX: 6,115,061 | AVG: 33,452,872 <br /> MIN: 11,170,780 <br /> MAX: 185,259,803 | AVG: 9,912,851 <br /> MIN: 9,845,789 <br /> MAX: 9,981,834 |
| falcon-1024 (10 executions) | clean | AVG: 602,066,436 <br /> MIN: 377,135,260 <br /> MAX: 1,488,065,363 | AVG: 136,241,759 <br /> MIN: 136,017,549 <br /> MAX: 136,556,585 | AVG: 1,678,109 <br /> MIN: 1,677,732 <br /> MAX: 1,678,566 |
| falcon-1024 (10 executions) | m4-ct | AVG: 408,725,773 <br /> MIN: 314,885,208 <br /> MAX: 712,370,124 | AVG: 87,706,019 <br /> MIN: 87,549,942 <br /> MAX: 87,839,508 | AVG: 990,541 <br /> MIN: 984,448 <br /> MAX: 997,160 |
| falcon-1024 (10 executions) | opt-ct | AVG: 448,194,494 <br /> MIN: 301,446,952 <br /> MAX: 784,390,745 | AVG: 87,699,336 <br /> MIN: 87,550,679 <br /> MAX: 87,857,833 | AVG: 992,822 <br /> MIN: 983,184 <br /> MAX: 998,271 |
| falcon-1024 (10 executions) | opt-leaktime | AVG: 371,539,477 <br /> MIN: 261,831,977 <br /> MAX: 576,613,448 | AVG: 80,134,413 <br /> MIN: 79,844,667 <br /> MAX: 80,338,608 | AVG: 992,815 <br /> MIN: 982,774 <br /> MAX: 998,600 |
| falcon-1024-tree (10 executions) | opt-ct | AVG: 469,168,139 <br /> MIN: 341,160,847 <br /> MAX: 733,947,155 | AVG: 39,197,559 <br /> MIN: 39,095,597 <br /> MAX: 39,392,055 | AVG: 995,190 <br /> MIN: 984,826 <br /> MAX: 998,305 |
| falcon-1024-tree (10 executions) | opt-leaktime | AVG: 418,213,501 <br /> MIN: 284,879,287 <br /> MAX: 699,555,143 | AVG: 42,181,577 <br /> MIN: 41,844,047 <br /> MAX: 42,456,098 | AVG: 991,791 <br /> MIN: 983,935 <br /> MAX: 997,742 |
| falcon-512 (10 executions) | clean | AVG: 229,742,458 <br /> MIN: 134,930,383 <br /> MAX: 358,460,785 | AVG: 62,255,726 <br /> MIN: 62,124,149 <br /> MAX: 62,424,751 | AVG: 834,970 <br /> MIN: 834,402 <br /> MAX: 835,533 |
| falcon-512 (10 executions) | m4-ct | AVG: 146,357,328 <br /> MIN: 106,015,844 <br /> MAX: 250,638,532 | AVG: 40,191,597 <br /> MIN: 40,123,901 <br /> MAX: 40,381,630 | AVG: 482,280 <br /> MIN: 472,137 <br /> MAX: 485,160 |
| falcon-512 (10 executions) | opt-ct | AVG: 168,942,163 <br /> MIN: 106,015,882 <br /> MAX: 258,726,842 | AVG: 40,136,012 <br /> MIN: 40,046,972 <br /> MAX: 40,195,851 | AVG: 481,102 <br /> MIN: 472,809 <br /> MAX: 485,947 |
| falcon-512 (10 executions) | opt-leaktime | AVG: 130,638,983 <br /> MIN: 94,352,160 <br /> MAX: 240,934,147 | AVG: 37,196,341 <br /> MIN: 36,969,717 <br /> MAX: 37,564,986 | AVG: 476,152 <br /> MIN: 471,514 <br /> MAX: 484,487 |
| falcon-512-tree (10 executions) | m4-ct | AVG: 187,840,863 <br /> MIN: 121,618,909 <br /> MAX: 531,189,026 | AVG: 18,199,972 <br /> MIN: 18,111,179 <br /> MAX: 18,297,541 | AVG: 479,819 <br /> MIN: 472,890 <br /> MAX: 485,685 |
| falcon-512-tree (10 executions) | opt-ct | AVG: 179,501,018 <br /> MIN: 121,618,960 <br /> MAX: 347,996,956 | AVG: 18,222,471 <br /> MIN: 18,064,774 <br /> MAX: 18,329,860 | AVG: 479,635 <br /> MIN: 472,057 <br /> MAX: 484,767 |
| falcon-512-tree (10 executions) | opt-leaktime | AVG: 203,618,838 <br /> MIN: 106,760,540 <br /> MAX: 425,495,750 | AVG: 20,110,699 <br /> MIN: 19,752,157 <br /> MAX: 20,375,122 | AVG: 480,119 <br /> MIN: 472,263 <br /> MAX: 485,743 |
| falcon-padded-1024 (10 executions) | clean | AVG: 464,867,653 <br /> MIN: 351,942,875 <br /> MAX: 908,060,882 | AVG: 136,157,961 <br /> MIN: 135,988,344 <br /> MAX: 136,430,038 | AVG: 1,677,719 <br /> MIN: 1,677,506 <br /> MAX: 1,677,932 |
| falcon-padded-512 (10 executions) | clean | AVG: 241,548,154 <br /> MIN: 164,862,595 <br /> MAX: 348,699,388 | AVG: 62,231,774 <br /> MIN: 62,096,573 <br /> MAX: 62,365,088 | AVG: 834,766 <br /> MIN: 834,480 <br /> MAX: 834,957 |
| haetae2 (100 executions) | m4f | AVG: 6,743,278 <br /> MIN: 1,555,292 <br /> MAX: 25,393,506 | AVG: 21,993,963 <br /> MIN: 4,721,290 <br /> MAX: 86,765,689 | AVG: 918,459 <br /> MIN: 918,244 <br /> MAX: 918,668 |
| haetae2 (100 executions) | ref | AVG: 9,363,639 <br /> MIN: 1,716,264 <br /> MAX: 41,895,014 | AVG: 31,631,089 <br /> MIN: 6,247,382 <br /> MAX: 216,853,925 | AVG: 1,104,080 <br /> MIN: 1,103,874 <br /> MAX: 1,104,329 |
| haetae3 (100 executions) | m4f | AVG: 12,925,388 <br /> MIN: 2,752,846 <br /> MAX: 52,240,529 | AVG: 30,891,994 <br /> MIN: 7,467,529 <br /> MAX: 160,522,018 | AVG: 1,760,745 <br /> MIN: 1,760,408 <br /> MAX: 1,761,081 |
| haetae3 (100 executions) | ref | AVG: 20,247,658 <br /> MIN: 3,023,325 <br /> MAX: 101,863,701 | AVG: 41,078,691 <br /> MIN: 9,771,906 <br /> MAX: 168,213,225 | AVG: 1,998,105 <br /> MIN: 1,997,691 <br /> MAX: 1,998,406 |
| haetae5 (100 executions) | m4f | AVG: 19,064,310 <br /> MIN: 3,530,778 <br /> MAX: 94,189,003 | AVG: 44,679,058 <br /> MIN: 9,277,906 <br /> MAX: 182,948,586 | AVG: 2,323,830 <br /> MIN: 2,323,454 <br /> MAX: 2,324,229 |
| haetae5 (100 executions) | ref | AVG: 18,169,623 <br /> MIN: 3,864,921 <br /> MAX: 64,304,046 | AVG: 63,180,459 <br /> MIN: 12,011,324 <br /> MAX: 264,538,555 | AVG: 2,461,679 <br /> MIN: 2,461,294 <br /> MAX: 2,462,068 |
| hawk1024 (100 executions) | ref | AVG: 246,017,495 <br /> MIN: 183,762,252 <br /> MAX: 662,190,563 | AVG: 4,309,675 <br /> MIN: 4,309,595 <br /> MAX: 4,309,759 | AVG: 2,782,441 <br /> MIN: 2,780,257 <br /> MAX: 2,784,348 |
| hawk256 (100 executions) | ref | AVG: 15,758,436 <br /> MIN: 11,600,791 <br /> MAX: 35,345,186 | AVG: 1,042,002 <br /> MIN: 954,957 <br /> MAX: 2,294,025 | AVG: 627,815 <br /> MIN: 627,480 <br /> MAX: 628,077 |
| hawk512 (100 executions) | ref | AVG: 53,733,289 <br /> MIN: 45,271,209 <br /> MAX: 174,603,165 | AVG: 1,972,051 <br /> MIN: 1,971,984 <br /> MAX: 1,972,127 | AVG: 1,293,829 <br /> MIN: 1,292,946 <br /> MAX: 1,294,494 |
| mayo1 (10 executions) | m4f | AVG: 5,242,008 <br /> MIN: 5,241,998 <br /> MAX: 5,242,042 | AVG: 9,100,704 <br /> MIN: 9,100,681 <br /> MAX: 9,100,722 | AVG: 4,952,860 <br /> MIN: 4,952,848 <br /> MAX: 4,952,890 |
| mayo1 (10 executions) | ref | AVG: 7,977,004 <br /> MIN: 7,976,973 <br /> MAX: 7,977,015 | AVG: 18,005,446 <br /> MIN: 18,005,440 <br /> MAX: 18,005,487 | AVG: 6,294,480 <br /> MIN: 6,294,464 <br /> MAX: 6,294,503 |
| mayo2 (10 executions) | m4f | AVG: 11,917,959 <br /> MIN: 11,917,940 <br /> MAX: 11,917,980 | AVG: 11,979,613 <br /> MIN: 11,979,582 <br /> MAX: 11,979,624 | AVG: 5,130,148 <br /> MIN: 5,130,131 <br /> MAX: 5,130,180 |
| mayo2 (10 executions) | ref | AVG: 18,432,706 <br /> MIN: 18,432,701 <br /> MAX: 18,432,740 | AVG: 23,546,659 <br /> MIN: 23,546,640 <br /> MAX: 23,546,680 | AVG: 5,494,246 <br /> MIN: 5,494,236 <br /> MAX: 5,494,276 |
| mayo3 (10 executions) | m4f | AVG: 18,946,738 <br /> MIN: 18,946,737 <br /> MAX: 18,946,740 | AVG: 32,477,408 <br /> MIN: 32,477,407 <br /> MAX: 32,477,411 | AVG: 16,852,927 <br /> MIN: 16,852,799 <br /> MAX: 16,853,047 |
| meds13220 (10 executions) | ref | AVG: 47,801,890 <br /> MIN: 47,796,259 <br /> MAX: 47,805,424 | AVG: 1,774,401,869 <br /> MIN: 1,773,011,038 <br /> MAX: 1,779,733,959 | AVG: 1,767,764,521 <br /> MIN: 1,766,326,468 <br /> MAX: 1,773,152,168 |
| meds55604 (10 executions) | ref | AVG: 253,603,604 <br /> MIN: 253,590,695 <br /> MAX: 253,615,749 | AVG: 8,009,948,412 <br /> MIN: 8,009,909,000 <br /> MAX: 8,009,995,748 | AVG: 8,320,756,990 <br /> MIN: 8,320,682,364 <br /> MAX: 8,320,835,448 |
| mirith_IIIa_fast (10 executions) | ref | AVG: 3,009,088 <br /> MIN: 3,009,084 <br /> MAX: 3,009,123 | AVG: 891,195,817 <br /> MIN: 891,191,657 <br /> MAX: 891,198,221 | AVG: 831,725,932 <br /> MIN: 831,697,264 <br /> MAX: 831,742,620 |
| mirith_IIIb_fast (10 executions) | ref | AVG: 4,565,011 <br /> MIN: 4,565,007 <br /> MAX: 4,565,046 | AVG: 1,298,812,706 <br /> MIN: 1,298,810,546 <br /> MAX: 1,298,815,343 | AVG: 1,214,260,655 <br /> MIN: 1,214,247,570 <br /> MAX: 1,214,277,229 |
| mirith_Ia_fast (10 executions) | ref | AVG: 1,303,728 <br /> MIN: 1,303,721 <br /> MAX: 1,303,764 | AVG: 296,732,107 <br /> MIN: 296,728,990 <br /> MAX: 296,734,109 | AVG: 276,059,526 <br /> MIN: 276,031,297 <br /> MAX: 276,080,171 |
| mirith_Ib_fast (10 executions) | ref | AVG: 2,514,924 <br /> MIN: 2,514,920 <br /> MAX: 2,514,964 | AVG: 565,778,762 <br /> MIN: 565,776,437 <br /> MAX: 565,781,372 | AVG: 528,408,968 <br /> MIN: 528,400,758 <br /> MAX: 528,415,550 |
| mirith_Va_fast (10 executions) | ref | AVG: 6,254,885 <br /> MIN: 6,254,885 <br /> MAX: 6,254,887 | AVG: 2,373,353,150 <br /> MIN: 2,373,347,664 <br /> MAX: 2,373,358,665 | AVG: 2,233,960,878 <br /> MIN: 2,233,908,923 <br /> MAX: 2,234,010,721 |
| mirith_Vb_fast (10 executions) | ref | AVG: 8,807,561 <br /> MIN: 8,807,538 <br /> MAX: 8,807,580 | AVG: 3,406,388,587 <br /> MIN: 3,406,385,114 <br /> MAX: 3,406,391,954 | AVG: 3,205,119,426 <br /> MIN: 3,205,069,724 <br /> MAX: 3,205,181,151 |
| mirith_hypercube_IIIa_fast (10 executions) | ref | AVG: 3,009,085 <br /> MIN: 3,009,081 <br /> MAX: 3,009,121 | AVG: 323,235,292 <br /> MIN: 323,169,167 <br /> MAX: 323,309,072 | AVG: 313,483,184 <br /> MIN: 313,455,293 <br /> MAX: 313,507,476 |
| mirith_hypercube_IIIa_short (10 executions) | ref | AVG: 3,009,092 <br /> MIN: 3,009,084 <br /> MAX: 3,009,125 | AVG: 718,708,882 <br /> MIN: 718,706,940 <br /> MAX: 718,725,922 | AVG: 730,959,561 <br /> MIN: 730,953,898 <br /> MAX: 730,965,347 |
| mirith_hypercube_IIIb_fast (10 executions) | ref | AVG: 4,565,028 <br /> MIN: 4,565,013 <br /> MAX: 4,565,053 | AVG: 450,970,203 <br /> MIN: 450,912,625 <br /> MAX: 451,011,870 | AVG: 441,590,516 <br /> MIN: 441,574,663 <br /> MAX: 441,613,045 |
| mirith_hypercube_IIIb_short (10 executions) | ref | AVG: 4,565,027 <br /> MIN: 4,565,008 <br /> MAX: 4,565,047 | AVG: 845,096,869 <br /> MIN: 845,094,881 <br /> MAX: 845,114,293 | AVG: 860,321,543 <br /> MIN: 860,312,205 <br /> MAX: 860,325,520 |
| mirith_hypercube_Ia_fast (10 executions) | opt | AVG: 995,563 <br /> MIN: 995,419 <br /> MAX: 995,752 | AVG: 58,999,862 <br /> MIN: 58,972,041 <br /> MAX: 59,042,031 | AVG: 53,599,779 <br /> MIN: 53,565,299 <br /> MAX: 53,623,234 |
| mirith_hypercube_Ia_fast (10 executions) | ref | AVG: 1,303,715 <br /> MIN: 1,303,715 <br /> MAX: 1,303,718 | AVG: 116,964,064 <br /> MIN: 116,941,316 <br /> MAX: 116,990,779 | AVG: 111,505,597 <br /> MIN: 111,482,197 <br /> MAX: 111,525,936 |
| mirith_hypercube_Ia_short (10 executions) | ref | AVG: 1,303,722 <br /> MIN: 1,303,721 <br /> MAX: 1,303,724 | AVG: 370,999,431 <br /> MIN: 370,999,393 <br /> MAX: 370,999,483 | AVG: 364,000,112 <br /> MIN: 363,996,085 <br /> MAX: 364,002,214 |
| mirith_hypercube_Ib_fast (10 executions) | opt | AVG: 1,879,815 <br /> MIN: 1,879,488 <br /> MAX: 1,880,127 | AVG: 83,825,209 <br /> MIN: 83,797,728 <br /> MAX: 83,857,763 | AVG: 78,145,476 <br /> MIN: 78,137,727 <br /> MAX: 78,153,192 |
| mirith_hypercube_Ib_fast (10 executions) | ref | AVG: 2,514,929 <br /> MIN: 2,514,917 <br /> MAX: 2,514,959 | AVG: 205,510,181 <br /> MIN: 205,497,961 <br /> MAX: 205,547,801 | AVG: 199,772,762 <br /> MIN: 199,769,009 <br /> MAX: 199,782,994 |
| mirith_hypercube_Ib_short (10 executions) | ref | AVG: 2,514,920 <br /> MIN: 2,514,920 <br /> MAX: 2,514,923 | AVG: 447,351,952 <br /> MIN: 447,351,902 <br /> MAX: 447,351,992 | AVG: 440,279,587 <br /> MIN: 440,278,101 <br /> MAX: 440,281,382 |
| mirith_hypercube_Va_fast (10 executions) | ref | AVG: 6,254,896 <br /> MIN: 6,254,886 <br /> MAX: 6,254,922 | AVG: 808,070,687 <br /> MIN: 808,007,911 <br /> MAX: 808,157,180 | AVG: 792,058,628 <br /> MIN: 792,006,360 <br /> MAX: 792,098,565 |
| mirith_hypercube_Vb_fast (10 executions) | ref | AVG: 8,807,565 <br /> MIN: 8,807,542 <br /> MAX: 8,807,583 | AVG: 1,134,272,446 <br /> MIN: 1,134,201,632 <br /> MAX: 1,134,368,110 | AVG: 1,117,085,816 <br /> MIN: 1,117,059,819 <br /> MAX: 1,117,104,354 |
| mqom_cat1_gf251_fast (10 executions) | ref | AVG: 7,780,082 <br /> MIN: 7,761,398 <br /> MAX: 7,795,766 | AVG: 149,063,790 <br /> MIN: 149,045,955 <br /> MAX: 149,079,787 | AVG: 136,742,778 <br /> MIN: 136,613,266 <br /> MAX: 136,821,602 |
| mqom_cat1_gf31_fast (10 executions) | ref | AVG: 8,472,628 <br /> MIN: 8,471,619 <br /> MAX: 8,473,585 | AVG: 243,796,920 <br /> MIN: 243,782,136 <br /> MAX: 243,811,088 | AVG: 244,346,110 <br /> MIN: 244,239,828 <br /> MAX: 244,424,317 |
| ov-Ip (10 executions) | m4f | AVG: 139,186,121 <br /> MIN: 139,186,115 <br /> MAX: 139,186,154 | AVG: 2,465,106 <br /> MIN: 2,465,096 <br /> MAX: 2,465,133 | AVG: 993,538 <br /> MIN: 979,943 <br /> MAX: 997,098 |
| ov-Ip (10 executions) | ref | AVG: 350,783,613 <br /> MIN: 350,783,583 <br /> MAX: 350,783,641 | AVG: 6,479,343 <br /> MIN: 6,479,329 <br /> MAX: 6,479,364 | AVG: 1,301,328 <br /> MIN: 1,301,328 <br /> MAX: 1,301,329 |
| ov-Ip-pkc (10 executions) | m4fspeed | AVG: 175,417,340 <br /> MIN: 175,417,323 <br /> MAX: 175,417,366 | AVG: 2,484,348 <br /> MIN: 2,484,345 <br /> MAX: 2,484,383 | AVG: 11,197,952 <br /> MIN: 11,185,489 <br /> MAX: 11,202,816 |
| ov-Ip-pkc (10 executions) | m4fstack | AVG: 175,417,332 <br /> MIN: 175,417,319 <br /> MAX: 175,417,363 | AVG: 2,484,355 <br /> MIN: 2,484,351 <br /> MAX: 2,484,391 | AVG: 12,047,546 <br /> MIN: 12,033,622 <br /> MAX: 12,049,099 |
| ov-Ip-pkc (10 executions) | ref | AVG: 375,129,899 <br /> MIN: 375,129,876 <br /> MAX: 375,129,925 | AVG: 6,924,383 <br /> MIN: 6,924,364 <br /> MAX: 6,924,403 | AVG: 11,429,702 <br /> MIN: 11,429,685 <br /> MAX: 11,429,720 |
| ov-Ip-pkc-skc (10 executions) | m4fspeed | AVG: 175,417,478 <br /> MIN: 175,417,464 <br /> MAX: 175,417,508 | AVG: 89,193,259 <br /> MIN: 89,193,250 <br /> MAX: 89,193,291 | AVG: 11,987,533 <br /> MIN: 11,972,791 <br /> MAX: 11,991,175 |
| ov-Ip-pkc-skc (10 executions) | m4fstack | AVG: 175,417,481 <br /> MIN: 175,417,467 <br /> MAX: 175,417,513 | AVG: 89,193,257 <br /> MIN: 89,193,252 <br /> MAX: 89,193,294 | AVG: 12,046,865 <br /> MIN: 12,036,910 <br /> MAX: 12,049,102 |
| ov-Ip-pkc-skc (10 executions) | ref | AVG: 375,129,970 <br /> MIN: 375,129,961 <br /> MAX: 375,129,979 | AVG: 241,521,035 <br /> MIN: 241,521,010 <br /> MAX: 241,521,062 | AVG: 12,160,652 <br /> MIN: 12,160,649 <br /> MAX: 12,160,655 |
| perk-128-fast-3 (10 executions) | m4 | AVG: 600,370 <br /> MIN: 588,589 <br /> MAX: 617,172 | AVG: 176,603,058 <br /> MIN: 172,398,218 <br /> MAX: 179,515,947 | AVG: 80,954,403 <br /> MIN: 80,639,115 <br /> MAX: 81,369,755 |
| perk-128-fast-3 (10 executions) | ref | AVG: 704,259 <br /> MIN: 693,368 <br /> MAX: 736,117 | AVG: 217,778,838 <br /> MIN: 217,461,187 <br /> MAX: 218,268,228 | AVG: 96,466,250 <br /> MIN: 96,183,326 <br /> MAX: 96,888,788 |
| perk-128-fast-5 (10 executions) | m4 | AVG: 731,441 <br /> MIN: 731,364 <br /> MAX: 731,540 | AVG: 169,489,946 <br /> MIN: 165,666,000 <br /> MAX: 172,125,278 | AVG: 78,073,374 <br /> MIN: 77,727,738 <br /> MAX: 78,357,997 |
| perk-128-fast-5 (10 executions) | ref | AVG: 913,665 <br /> MIN: 909,095 <br /> MAX: 954,075 | AVG: 215,313,534 <br /> MIN: 214,778,346 <br /> MAX: 215,586,755 | AVG: 93,670,132 <br /> MIN: 93,146,285 <br /> MAX: 93,977,473 |
| perk-128-short-3 (10 executions) | m4 | AVG: 590,902 <br /> MIN: 588,605 <br /> MAX: 599,700 | AVG: 953,694,810 <br /> MIN: 909,659,772 <br /> MAX: 990,039,092 | AVG: 460,190,199 <br /> MIN: 458,863,203 <br /> MAX: 461,050,669 |
| perk-128-short-5 (10 executions) | m4 | AVG: 731,445 <br /> MIN: 731,335 <br /> MAX: 731,531 | AVG: 897,819,203 <br /> MIN: 874,104,462 <br /> MAX: 910,961,959 | AVG: 428,108,291 <br /> MIN: 426,956,727 <br /> MAX: 428,829,873 |
| perk-192-fast-3 (10 executions) | m4 | AVG: 1,417,042 <br /> MIN: 1,416,960 <br /> MAX: 1,417,171 | AVG: 417,178,570 <br /> MIN: 409,941,430 <br /> MAX: 430,893,116 | AVG: 194,559,724 <br /> MIN: 193,854,854 <br /> MAX: 195,157,065 |
| perk-192-fast-5 (10 executions) | m4 | AVG: 1,674,275 <br /> MIN: 1,664,390 <br /> MAX: 1,675,499 | AVG: 398,534,166 <br /> MIN: 393,310,316 <br /> MAX: 407,792,875 | AVG: 186,556,828 <br /> MIN: 185,719,616 <br /> MAX: 187,993,601 |
| perk-192-short-3 (10 executions) | m4 | AVG: 1,421,844 <br /> MIN: 1,416,962 <br /> MAX: 1,464,701 | AVG: 2,361,914,331 <br /> MIN: 2,294,967,247 <br /> MAX: 2,446,192,375 | AVG: 1,177,027,799 <br /> MIN: 1,172,107,658 <br /> MAX: 1,180,352,563 |
| perk-192-short-5 (10 executions) | m4 | AVG: 1,675,264 <br /> MIN: 1,674,747 <br /> MAX: 1,675,426 | AVG: 2,199,500,885 <br /> MIN: 2,155,317,947 <br /> MAX: 2,244,259,412 | AVG: 1,098,396,172 <br /> MIN: 1,096,382,473 <br /> MAX: 1,100,817,952 |
| perk-256-fast-3 (10 executions) | m4 | AVG: 2,473,015 <br /> MIN: 2,472,888 <br /> MAX: 2,473,216 | AVG: 878,427,616 <br /> MIN: 863,486,856 <br /> MAX: 896,605,165 | AVG: 418,401,493 <br /> MIN: 416,315,010 <br /> MAX: 421,403,946 |
| perk-256-fast-5 (10 executions) | m4 | AVG: 2,885,058 <br /> MIN: 2,878,858 <br /> MAX: 2,939,569 | AVG: 826,739,240 <br /> MIN: 816,655,441 <br /> MAX: 839,215,281 | AVG: 397,855,320 <br /> MIN: 396,898,494 <br /> MAX: 398,693,053 |
| perk-256-short-3 (10 executions) | m4 | AVG: 2,478,803 <br /> MIN: 2,472,893 <br /> MAX: 2,531,188 | AVG: 5,056,839,759 <br /> MIN: 5,015,570,985 <br /> MAX: 5,098,913,929 | AVG: 2,638,814,692 <br /> MIN: 2,626,576,274 <br /> MAX: 2,645,713,279 |
| perk-256-short-5 (10 executions) | m4 | AVG: 2,889,949 <br /> MIN: 2,878,822 <br /> MAX: 2,988,248 | AVG: 4,678,162,399 <br /> MIN: 4,520,673,553 <br /> MAX: 4,740,505,898 | AVG: 2,453,866,153 <br /> MIN: 2,446,870,524 <br /> MAX: 2,460,260,204 |
| snova-24-5-16-4-esk (10 executions) | ref | AVG: 24,840,838 <br /> MIN: 24,840,391 <br /> MAX: 24,841,191 | AVG: 139,251,354 <br /> MIN: 139,235,721 <br /> MAX: 139,274,512 | AVG: 88,454,046 <br /> MIN: 88,453,528 <br /> MAX: 88,454,429 |
| snova-24-5-16-4-ssk (10 executions) | ref | AVG: 24,772,323 <br /> MIN: 24,771,821 <br /> MAX: 24,772,994 | AVG: 174,094,748 <br /> MIN: 160,180,156 <br /> MAX: 299,202,162 | AVG: 88,453,756 <br /> MIN: 88,453,293 <br /> MAX: 88,454,408 |
| snova-25-8-16-3-esk (10 executions) | ref | AVG: 35,280,792 <br /> MIN: 35,280,693 <br /> MAX: 35,280,867 | AVG: 71,674,196 <br /> MIN: 65,171,606 <br /> MAX: 130,098,735 | AVG: 42,542,485 <br /> MIN: 42,542,403 <br /> MAX: 42,542,553 |
| snova-25-8-16-3-ssk (10 executions) | ref | AVG: 35,195,324 <br /> MIN: 35,195,216 <br /> MAX: 35,195,579 | AVG: 112,654,217 <br /> MIN: 93,165,980 <br /> MAX: 158,103,540 | AVG: 42,542,507 <br /> MIN: 42,542,396 <br /> MAX: 42,542,732 |
| snova-28-17-16-2-esk (10 executions) | ref | AVG: 51,177,590 <br /> MIN: 51,177,548 <br /> MAX: 51,177,647 | AVG: 23,387,139 <br /> MIN: 21,270,788 <br /> MAX: 42,311,786 | AVG: 19,180,389 <br /> MIN: 19,180,360 <br /> MAX: 19,180,440 |
| snova-28-17-16-2-ssk (10 executions) | ref | AVG: 51,065,038 <br /> MIN: 51,064,999 <br /> MAX: 51,065,086 | AVG: 52,865,514 <br /> MIN: 50,757,388 <br /> MAX: 71,788,606 | AVG: 19,180,379 <br /> MIN: 19,180,357 <br /> MAX: 19,180,425 |
| snova-37-8-16-4-ssk (10 executions) | ref | AVG: 122,023,801 <br /> MIN: 122,023,399 <br /> MAX: 122,024,216 | AVG: 533,063,912 <br /> MIN: 533,033,960 <br /> MAX: 533,090,127 | AVG: 335,806,349 <br /> MIN: 335,805,890 <br /> MAX: 335,806,820 |
| sphincs-a-sha2-128f (10 executions) | ref | AVG: 30,278,936 <br /> MIN: 30,278,762 <br /> MAX: 30,279,211 | AVG: 382,270,810 <br /> MIN: 382,269,421 <br /> MAX: 382,271,497 | AVG: 35,695,646 <br /> MIN: 35,693,840 <br /> MAX: 35,698,828 |
| sphincs-a-sha2-128s (10 executions) | ref | AVG: 814,836,852 <br /> MIN: 814,834,574 <br /> MAX: 814,838,039 | AVG: 6,981,930,727 <br /> MIN: 6,981,924,687 <br /> MAX: 6,981,936,443 | AVG: 187,090,082 <br /> MIN: 187,087,928 <br /> MAX: 187,093,600 |
| sphincs-a-sha2-192f (10 executions) | ref | AVG: 45,930,664 <br /> MIN: 45,930,481 <br /> MAX: 45,930,983 | AVG: 634,374,072 <br /> MIN: 634,373,011 <br /> MAX: 634,375,225 | AVG: 35,145,783 <br /> MIN: 35,144,266 <br /> MAX: 35,146,607 |
| sphincs-a-shake-128f (10 executions) | ref | AVG: 61,578,406 <br /> MIN: 61,578,107 <br /> MAX: 61,578,885 | AVG: 1,188,147,363 <br /> MIN: 1,188,146,489 <br /> MAX: 1,188,148,063 | AVG: 76,330,135 <br /> MIN: 76,328,602 <br /> MAX: 76,331,478 |
| sphincs-a-shake-128s (10 executions) | ref | AVG: 2,342,298,427 <br /> MIN: 2,342,296,403 <br /> MAX: 2,342,299,607 | AVG: 22,926,754,899 <br /> MIN: 22,926,752,978 <br /> MAX: 22,926,758,555 | AVG: 241,835,141 <br /> MIN: 241,830,735 <br /> MAX: 241,838,908 |
| sphincs-a-shake-192f (10 executions) | ref | AVG: 110,027,677 <br /> MIN: 110,027,323 <br /> MAX: 110,027,950 | AVG: 1,814,954,350 <br /> MIN: 1,814,953,585 <br /> MAX: 1,814,955,913 | AVG: 64,022,276 <br /> MIN: 64,020,853 <br /> MAX: 64,023,988 |
| sphincs-sha2-128f-simple (10 executions) | clean | AVG: 15,742,990 <br /> MIN: 15,742,958 <br /> MAX: 15,742,996 | AVG: 368,575,228 <br /> MIN: 368,575,193 <br /> MAX: 368,575,246 | AVG: 21,923,628 <br /> MIN: 21,369,867 <br /> MAX: 22,456,717 |
| sphincs-sha2-128s-simple (10 executions) | clean | AVG: 1,007,731,522 <br /> MIN: 1,007,731,504 <br /> MAX: 1,007,731,551 | AVG: 7,657,558,168 <br /> MIN: 7,657,558,117 <br /> MAX: 7,657,558,212 | AVG: 7,471,794 <br /> MIN: 7,228,491 <br /> MAX: 7,797,915 |
| sphincs-sha2-192f-simple (10 executions) | clean | AVG: 23,570,224 <br /> MIN: 23,570,214 <br /> MAX: 23,570,257 | AVG: 666,398,438 <br /> MIN: 666,398,401 <br /> MAX: 666,398,468 | AVG: 35,457,937 <br /> MIN: 35,087,854 <br /> MAX: 35,973,969 |
| sphincs-sha2-192s-simple (10 executions) | clean | AVG: 1,509,654,951 <br /> MIN: 1,509,654,914 <br /> MAX: 1,509,654,968 | AVG: 15,452,089,990 <br /> MIN: 15,452,089,934 <br /> MAX: 15,452,090,071 | AVG: 13,494,855 <br /> MIN: 12,947,211 <br /> MAX: 14,303,224 |
| sphincs-sha2-256f-simple (10 executions) | clean | AVG: 62,583,556 <br /> MIN: 62,583,533 <br /> MAX: 62,583,577 | AVG: 1,377,768,608 <br /> MIN: 1,377,768,561 <br /> MAX: 1,377,768,713 | AVG: 37,302,611 <br /> MIN: 36,599,268 <br /> MAX: 38,058,007 |
| sphincs-sha2-256s-simple (10 executions) | clean | AVG: 1,001,040,810 <br /> MIN: 1,001,040,779 <br /> MAX: 1,001,040,845 | AVG: 14,326,202,444 <br /> MIN: 14,326,202,404 <br /> MAX: 14,326,202,506 | AVG: 19,637,153 <br /> MIN: 18,985,943 <br /> MAX: 20,132,079 |
| sphincs-shake-128f-simple (10 executions) | clean | AVG: 50,505,025 <br /> MIN: 50,505,022 <br /> MAX: 50,505,030 | AVG: 1,182,422,563 <br /> MIN: 1,182,422,491 <br /> MAX: 1,182,422,621 | AVG: 70,501,834 <br /> MIN: 68,595,319 <br /> MAX: 71,605,565 |
| sphincs-shake-128s-simple (10 executions) | clean | AVG: 3,231,401,965 <br /> MIN: 3,231,401,936 <br /> MAX: 3,231,402,005 | AVG: 24,553,696,412 <br /> MIN: 24,553,696,311 <br /> MAX: 24,553,696,516 | AVG: 24,366,771 <br /> MIN: 22,962,144 <br /> MAX: 25,470,425 |
| sphincs-shake-192f-simple (10 executions) | clean | AVG: 74,890,591 <br /> MIN: 74,890,566 <br /> MAX: 74,890,617 | AVG: 1,937,690,056 <br /> MIN: 1,937,690,000 <br /> MAX: 1,937,690,169 | AVG: 103,305,801 <br /> MIN: 101,234,011 <br /> MAX: 104,969,964 |
| sphincs-shake-192s-simple (10 executions) | clean | AVG: 4,793,551,013 <br /> MIN: 4,793,550,980 <br /> MAX: 4,793,551,045 | AVG: 43,114,327,277 <br /> MIN: 43,114,327,182 <br /> MAX: 43,114,327,407 | AVG: 35,026,412 <br /> MIN: 33,413,152 <br /> MAX: 36,300,013 |
| sphincs-shake-256f-simple (10 executions) | clean | AVG: 200,110,912 <br /> MIN: 200,110,878 <br /> MAX: 200,110,926 | AVG: 4,026,533,198 <br /> MIN: 4,026,533,128 <br /> MAX: 4,026,533,250 | AVG: 108,394,619 <br /> MIN: 106,138,946 <br /> MAX: 111,648,895 |
| sphincs-shake-256s-simple (10 executions) | clean | AVG: 3,201,898,694 <br /> MIN: 3,201,898,656 <br /> MAX: 3,201,898,741 | AVG: 38,175,697,620 <br /> MIN: 38,175,697,525 <br /> MAX: 38,175,697,766 | AVG: 52,912,174 <br /> MIN: 51,224,772 <br /> MAX: 53,979,746 |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| bikel1 | m4f | 43,976 | 32,192 | 91,372 |
| bikel1 | opt | 35,748 | 25,836 | 78,540 |
| bikel3 | m4f | 85,744 | 62,944 | 175,128 |
| bikel3 | opt | 69,444 | 50,556 | 155,388 |
| hqc-128 | clean | 33,644 | 51,428 | 55,892 |
| hqc-192 | clean | 65,668 | 101,636 | 110,660 |
| hqc-256 | clean | 103,756 | 161,508 | 175,972 |
| kyber1024 | clean | 15,136 | 18,784 | 20,360 |
| kyber1024 | m4fspeed | 6,436 | 7,500 | 7,484 |
| kyber1024 | m4fstack | 3,332 | 3,372 | 3,356 |
| kyber512 | clean | 6,168 | 8,800 | 9,576 |
| kyber512 | m4fspeed | 4,364 | 5,436 | 5,412 |
| kyber512 | m4fstack | 2,292 | 2,348 | 2,332 |
| kyber768 | clean | 10,272 | 13,408 | 14,504 |
| kyber768 | m4fspeed | 5,396 | 6,468 | 6,452 |
| kyber768 | m4fstack | 2,820 | 2,860 | 2,844 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| aimer128f | mem_opt | 8,728 | 13,864 | 15,440 |
| aimer128f | ref | 8,728 | 123,376 | 15,448 |
| aimer128s | mem_opt | 8,728 | 27,324 | 34,624 |
| aimer192f | mem_opt | 19,192 | 29,976 | 31,608 |
| aimer192f | ref | 19,192 | 273,104 | 31,608 |
| aimer192s | mem_opt | 19,192 | 43,220 | 60,384 |
| aimer256f | mem_opt | 50,040 | 77,164 | 78,568 |
| aimer256f | ref | 50,040 | 573,284 | 78,716 |
| aimer256s | mem_opt | 50,040 | 76,140 | 117,044 |
| ascon-sign-128f-robust | ref | 3,260 | 2,772 | 2,992 |
| ascon-sign-128f-simple | ref | 2,632 | 2,144 | 2,448 |
| ascon-sign-128s-robust | ref | 3,452 | 2,916 | 2,240 |
| ascon-sign-128s-simple | ref | 2,824 | 2,268 | 1,752 |
| ascon-sign-192f-robust | ref | 6,092 | 4,924 | 4,504 |
| ascon-sign-192f-simple | ref | 4,808 | 3,640 | 3,704 |
| ascon-sign-192s-robust | ref | 6,380 | 5,116 | 4,332 |
| ascon-sign-192s-simple | ref | 5,096 | 3,812 | 3,048 |
| biscuit128f | ref | 600 | 137,348 | 14,560 |
| biscuit192f | ref | 640 | 265,964 | 20,796 |
| biscuit256f | ref | 720 | 477,468 | 33,108 |
| cross-sha2-r-sdp-1-fast | ref | 5,200 | 218,304 | 105,604 |
| cross-sha2-r-sdp-3-fast | ref | 9,920 | 324,764 | 158,132 |
| cross-sha2-r-sdpg-1-fast | ref | 2,760 | 130,824 | 69,536 |
| cross-sha2-r-sdpg-1-small | ref | 2,760 | 466,288 | 245,480 |
| cross-sha2-r-sdpg-3-fast | ref | 4,536 | 205,148 | 108,452 |
| cross-sha2-r-sdpg-5-fast | ref | 7,408 | 398,612 | 213,684 |
| cross-sha3-r-sdp-1-fast | ref | 4,672 | 218,400 | 105,576 |
| cross-sha3-r-sdp-3-fast | ref | 9,336 | 324,688 | 157,792 |
| cross-sha3-r-sdpg-1-fast | ref | 2,328 | 130,928 | 69,560 |
| cross-sha3-r-sdpg-1-small | ref | 2,328 | 466,400 | 245,512 |
| cross-sha3-r-sdpg-3-fast | ref | 4,032 | 205,080 | 108,236 |
| cross-sha3-r-sdpg-5-fast | ref | 6,824 | 398,600 | 213,436 |
| dilithium2 | clean | 38,304 | 51,968 | 36,192 |
| dilithium2 | m4f | 38,296 | 49,416 | 9,012 |
| dilithium2 | m4fstack | 4,408 | 5,072 | 2,704 |
| dilithium3 | clean | 60,832 | 79,616 | 57,728 |
| dilithium3 | m4f | 60,824 | 68,864 | 9,880 |
| dilithium3 | m4fstack | 4,408 | 6,608 | 2,704 |
| dilithium5 | clean | 97,696 | 122,724 | 92,940 |
| dilithium5 | m4f | 97,688 | 116,076 | 11,944 |
| dilithium5 | m4fstack | 4,408 | 8,136 | 2,712 |
| falcon-1024 | clean | 35,076 | 84,604 | 8,776 |
| falcon-1024 | m4-ct | 1,156 | 2,508 | 376 |
| falcon-1024 | opt-ct | 1,204 | 2,508 | 376 |
| falcon-1024 | opt-leaktime | 1,252 | 2,580 | 444 |
| falcon-1024-tree | opt-ct | 1,148 | 2,884 | 376 |
| falcon-1024-tree | opt-leaktime | 1,196 | 2,988 | 376 |
| falcon-512 | clean | 18,180 | 43,548 | 4,680 |
| falcon-512 | m4-ct | 1,148 | 2,428 | 376 |
| falcon-512 | opt-ct | 1,244 | 2,428 | 376 |
| falcon-512 | opt-leaktime | 1,148 | 2,492 | 376 |
| falcon-512-tree | m4-ct | 1,172 | 2,636 | 376 |
| falcon-512-tree | opt-ct | 1,156 | 2,636 | 376 |
| falcon-512-tree | opt-leaktime | 1,196 | 2,828 | 376 |
| falcon-padded-1024 | clean | 34,988 | 84,596 | 8,776 |
| falcon-padded-512 | clean | 18,092 | 43,540 | 4,680 |
| haetae2 | m4f | 19,756 | 55,568 | 23,296 |
| haetae2 | ref | 26,092 | 54,444 | 29,696 |
| haetae3 | m4f | 29,596 | 83,420 | 31,784 |
| haetae3 | ref | 43,492 | 80,428 | 48,424 |
| haetae5 | m4f | 34,084 | 103,964 | 37,300 |
| haetae5 | ref | 54,868 | 100,228 | 62,024 |
| hawk1024 | ref | 27,972 | 7,980 | 11,468 |
| hawk256 | ref | 7,900 | 3,320 | 3,712 |
| hawk512 | ref | 14,580 | 4,856 | 6,272 |
| mayo1 | m4f | 74,444 | 113,468 | 440,676 |
| mayo1 | ref | 74,444 | 218,644 | 399,348 |
| mayo2 | m4f | 111,532 | 124,644 | 278,444 |
| mayo2 | ref | 111,532 | 238,324 | 270,260 |
| mayo3 | m4f | 244,748 | 340,668 | 469,780 |
| meds13220 | ref | 44,000 | 180,404 | 47,716 |
| meds55604 | ref | 162,196 | 392,852 | 160,324 |
| mirith_IIIa_fast | ref | 21,832 | 266,480 | 46,156 |
| mirith_IIIb_fast | ref | 32,872 | 298,208 | 59,172 |
| mirith_Ia_fast | ref | 10,208 | 122,424 | 22,836 |
| mirith_Ib_fast | ref | 19,064 | 151,016 | 33,764 |
| mirith_Va_fast | ref | 45,000 | 484,464 | 85,252 |
| mirith_Vb_fast | ref | 62,864 | 535,176 | 106,004 |
| mirith_hypercube_IIIa_fast | ref | 21,832 | 167,024 | 42,692 |
| mirith_hypercube_IIIa_short | ref | 21,832 | 486,448 | 56,596 |
| mirith_hypercube_IIIb_fast | ref | 32,872 | 189,520 | 55,244 |
| mirith_hypercube_IIIb_short | ref | 32,872 | 509,056 | 68,632 |
| mirith_hypercube_Ia_fast | opt | 10,216 | 76,944 | 20,864 |
| mirith_hypercube_Ia_fast | ref | 10,208 | 76,944 | 20,864 |
| mirith_hypercube_Ia_short | ref | 10,208 | 217,624 | 31,212 |
| mirith_hypercube_Ib_fast | opt | 19,072 | 96,928 | 31,316 |
| mirith_hypercube_Ib_fast | ref | 19,064 | 96,928 | 31,316 |
| mirith_hypercube_Ib_short | ref | 19,064 | 237,408 | 41,220 |
| mirith_hypercube_Va_fast | ref | 45,000 | 308,440 | 81,056 |
| mirith_hypercube_Vb_fast | ref | 62,864 | 344,832 | 101,220 |
| mqom_cat1_gf251_fast | ref | 184,356 | 399,396 | 252,684 |
| mqom_cat1_gf31_fast | ref | 262,888 | 612,816 | 421,596 |
| ov-Ip | m4f | 15,676 | 5,216 | 2,512 |
| ov-Ip | ref | 15,724 | 12,728 | 6,236 |
| ov-Ip-pkc | m4fspeed | 142,244 | 5,216 | 280,944 |
| ov-Ip-pkc | m4fstack | 142,244 | 5,216 | 6,548 |
| ov-Ip-pkc | ref | 15,724 | 12,728 | 284,560 |
| ov-Ip-pkc-skc | m4fspeed | 380,164 | 243,128 | 281,028 |
| ov-Ip-pkc-skc | m4fstack | 380,164 | 243,128 | 6,548 |
| ov-Ip-pkc-skc | ref | 253,628 | 253,580 | 284,560 |
| perk-128-fast-3 | m4 | 7,696 | 24,020 | 20,684 |
| perk-128-fast-3 | ref | 7,728 | 313,412 | 313,284 |
| perk-128-fast-5 | m4 | 9,032 | 25,160 | 21,752 |
| perk-128-fast-5 | ref | 9,032 | 305,688 | 305,480 |
| perk-128-short-3 | m4 | 7,696 | 27,780 | 25,228 |
| perk-128-short-5 | m4 | 9,032 | 28,616 | 26,056 |
| perk-192-fast-3 | m4 | 14,952 | 47,720 | 41,352 |
| perk-192-fast-5 | m4 | 16,864 | 48,776 | 42,416 |
| perk-192-short-3 | m4 | 14,952 | 51,344 | 46,656 |
| perk-192-short-5 | m4 | 16,864 | 51,888 | 47,256 |
| perk-256-fast-3 | m4 | 25,504 | 80,304 | 69,912 |
| perk-256-fast-5 | m4 | 28,064 | 80,896 | 70,640 |
| perk-256-short-3 | m4 | 25,504 | 82,264 | 74,784 |
| perk-256-short-5 | m4 | 28,064 | 82,056 | 74,808 |
| snova-24-5-16-4-esk | ref | 169,008 | 89,984 | 118,152 |
| snova-24-5-16-4-ssk | ref | 169,008 | 169,104 | 118,152 |
| snova-25-8-16-3-esk | ref | 190,696 | 87,400 | 122,656 |
| snova-25-8-16-3-ssk | ref | 190,696 | 190,836 | 122,656 |
| snova-28-17-16-2-esk | ref | 309,216 | 127,232 | 199,684 |
| snova-28-17-16-2-ssk | ref | 309,216 | 309,356 | 199,684 |
| snova-37-8-16-4-ssk | ref | 640,324 | 640,428 | 411,516 |
| sphincs-a-sha2-128f | ref | 281,168 | 280,772 | 280,656 |
| sphincs-a-sha2-128s | ref | 585,984 | 585,732 | 585,396 |
| sphincs-a-sha2-192f | ref | 504,084 | 502,636 | 502,356 |
| sphincs-a-shake-128f | ref | 281,072 | 280,676 | 280,560 |
| sphincs-a-shake-128s | ref | 585,888 | 585,636 | 585,264 |
| sphincs-a-shake-192f | ref | 503,544 | 502,092 | 501,816 |
| sphincs-sha2-128f-simple | clean | 2,856 | 2,468 | 2,664 |
| sphincs-sha2-128s-simple | clean | 3,084 | 2,556 | 1,968 |
| sphincs-sha2-192f-simple | clean | 5,468 | 4,404 | 4,356 |
| sphincs-sha2-192s-simple | clean | 5,796 | 4,540 | 3,700 |
| sphincs-sha2-256f-simple | clean | 8,460 | 6,412 | 5,980 |
| sphincs-sha2-256s-simple | clean | 8,756 | 6,540 | 5,580 |
| sphincs-shake-128f-simple | clean | 2,760 | 2,372 | 2,568 |
| sphincs-shake-128s-simple | clean | 2,988 | 2,460 | 1,872 |
| sphincs-shake-192f-simple | clean | 4,928 | 3,860 | 3,816 |
| sphincs-shake-192s-simple | clean | 5,252 | 3,996 | 3,160 |
| sphincs-shake-256f-simple | clean | 7,928 | 5,876 | 5,448 |
| sphincs-shake-256s-simple | clean | 8,220 | 6,004 | 5,048 |
| tuov_v | ref | 503,544 | 502,092 | 501,816 |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| bikel1 | m4f | 0.2% | 15.9% | 0.9% |
| bikel1 | opt | 0.1% | 10.1% | 0.4% |
| bikel3 | m4f | 0.1% | 12.2% | 0.7% |
| bikel3 | opt | 0.0% | 6.3% | 0.2% |
| hqc-128 | clean | 0.4% | 0.8% | 0.5% |
| hqc-192 | clean | 0.3% | 0.5% | 0.3% |
| hqc-256 | clean | 0.2% | 0.4% | 0.3% |
| kyber1024 | clean | 49.9% | 45.6% | 38.6% |
| kyber1024 | m4fspeed | 76.1% | 75.5% | 71.2% |
| kyber1024 | m4fstack | 75.8% | 74.9% | 70.6% |
| kyber512 | clean | 49.8% | 41.1% | 32.5% |
| kyber512 | m4fspeed | 76.5% | 73.5% | 67.1% |
| kyber512 | m4fstack | 76.5% | 73.1% | 66.8% |
| kyber768 | clean | 48.5% | 43.2% | 35.4% |
| kyber768 | m4fspeed | 75.4% | 74.4% | 69.2% |
| kyber768 | m4fstack | 75.3% | 73.8% | 68.7% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| aimer128f | mem_opt | 50.6% | 66.1% | 49.6% |
| aimer128f | ref | 50.6% | 48.8% | 49.6% |
| aimer128s | mem_opt | 50.6% | 67.9% | 50.2% |
| aimer192f | mem_opt | 53.5% | 56.4% | 40.5% |
| aimer192f | ref | 53.5% | 39.8% | 40.5% |
| aimer192s | mem_opt | 53.5% | 58.1% | 40.9% |
| aimer256f | mem_opt | 58.9% | 40.6% | 27.0% |
| aimer256f | ref | 58.9% | 28.0% | 27.0% |
| aimer256s | mem_opt | 58.9% | 42.4% | 27.2% |
| ascon-sign-128f-robust | ref | 0.0% | 0.0% | 0.0% |
| ascon-sign-128f-simple | ref | 0.0% | 0.0% | 0.0% |
| ascon-sign-128s-robust | ref | 0.0% | 0.0% | 0.0% |
| ascon-sign-128s-simple | ref | 0.0% | 0.0% | 0.0% |
| ascon-sign-192f-robust | ref | 0.0% | 0.0% | 0.0% |
| ascon-sign-192f-simple | ref | 0.0% | 0.0% | 0.0% |
| ascon-sign-192s-robust | ref | 0.0% | 0.0% | 0.0% |
| ascon-sign-192s-simple | ref | 0.0% | 0.0% | 0.0% |
| biscuit128f | ref | 54.3% | 9.7% | 8.9% |
| biscuit192f | ref | 54.0% | 6.0% | 5.5% |
| biscuit256f | ref | 54.0% | 4.4% | 4.2% |
| cross-sha2-r-sdp-1-fast | ref | 90.2% | 86.3% | 91.0% |
| cross-sha2-r-sdp-3-fast | ref | 86.5% | 79.8% | 81.7% |
| cross-sha2-r-sdpg-1-fast | ref | 92.9% | 90.9% | 92.1% |
| cross-sha2-r-sdpg-1-small | ref | 92.9% | 90.6% | 92.9% |
| cross-sha2-r-sdpg-3-fast | ref | 90.5% | 87.2% | 86.9% |
| cross-sha2-r-sdpg-5-fast | ref | 88.0% | 83.0% | 82.4% |
| cross-sha3-r-sdp-1-fast | ref | 67.1% | 61.2% | 72.0% |
| cross-sha3-r-sdp-3-fast | ref | 67.7% | 57.5% | 62.4% |
| cross-sha3-r-sdpg-1-fast | ref | 71.8% | 74.8% | 77.1% |
| cross-sha3-r-sdpg-1-small | ref | 71.8% | 74.7% | 78.4% |
| cross-sha3-r-sdpg-3-fast | ref | 71.7% | 68.2% | 68.7% |
| cross-sha3-r-sdpg-5-fast | ref | 71.1% | 66.1% | 66.8% |
| dilithium2 | clean | 61.0% | 30.9% | 52.9% |
| dilithium2 | m4f | 79.9% | 60.7% | 76.6% |
| dilithium2 | m4fstack | 74.8% | 55.2% | 40.8% |
| dilithium3 | clean | 64.7% | 31.3% | 56.8% |
| dilithium3 | m4f | 82.3% | 60.7% | 79.2% |
| dilithium3 | m4fstack | 77.1% | 54.6% | 41.0% |
| dilithium5 | clean | 67.0% | 35.7% | 61.1% |
| dilithium5 | m4f | 83.5% | 65.3% | 81.6% |
| dilithium5 | m4fstack | 76.1% | 54.5% | 42.6% |
| falcon-1024 | clean | 8.9% | 0.3% | 23.7% |
| falcon-1024 | m4-ct | 8.6% | 0.4% | 32.2% |
| falcon-1024 | opt-ct | 9.8% | 0.4% | 32.2% |
| falcon-1024 | opt-leaktime | 10.9% | 0.5% | 32.2% |
| falcon-1024-tree | opt-ct | 9.2% | 0.9% | 32.3% |
| falcon-1024-tree | opt-leaktime | 10.6% | 0.9% | 32.3% |
| falcon-512 | clean | 7.9% | 0.4% | 26.0% |
| falcon-512 | m4-ct | 13.7% | 0.5% | 33.9% |
| falcon-512 | opt-ct | 14.0% | 0.5% | 33.2% |
| falcon-512 | opt-leaktime | 17.3% | 0.5% | 33.6% |
| falcon-512-tree | m4-ct | 12.6% | 1.1% | 33.7% |
| falcon-512-tree | opt-ct | 14.6% | 1.1% | 34.2% |
| falcon-512-tree | opt-leaktime | 20.5% | 1.0% | 34.3% |
| falcon-padded-1024 | clean | 7.3% | 0.3% | 23.7% |
| falcon-padded-512 | clean | 16.0% | 0.4% | 26.0% |
| haetae2 | m4f | 12.4% | 56.7% | 54.1% |
| haetae2 | ref | 10.6% | 42.4% | 45.1% |
| haetae3 | m4f | 14.6% | 56.6% | 57.1% |
| haetae3 | ref | 14.4% | 42.4% | 50.3% |
| haetae5 | m4f | 15.7% | 56.6% | 57.5% |
| haetae5 | ref | 15.7% | 42.8% | 54.3% |
| hawk1024 | ref | 1.7% | 49.3% | 8.3% |
| hawk256 | ref | 32.8% | 54.6% | 10.7% |
| hawk512 | ref | 2.6% | 48.7% | 8.6% |
| mayo1 | m4f | 59.5% | 35.0% | 63.0% |
| mayo1 | ref | 39.1% | 17.7% | 49.6% |
| mayo2 | m4f | 35.2% | 35.5% | 81.2% |
| mayo2 | ref | 22.8% | 18.1% | 75.8% |
| mayo3 | m4f | 55.4% | 32.6% | 62.2% |
| meds13220 | ref | 2.5% | 5.1% | 4.8% |
| meds55604 | ref | 1.6% | 3.0% | 2.9% |
| mirith_IIIa_fast | ref | 64.3% | 6.7% | 6.5% |
| mirith_IIIb_fast | ref | 64.5% | 4.7% | 4.6% |
| mirith_Ia_fast | ref | 61.4% | 10.1% | 9.7% |
| mirith_Ib_fast | ref | 61.2% | 6.6% | 6.4% |
| mirith_Va_fast | ref | 64.8% | 4.3% | 4.4% |
| mirith_Vb_fast | ref | 64.5% | 3.1% | 3.2% |
| mirith_hypercube_IIIa_fast | ref | 64.3% | 18.7% | 17.1% |
| mirith_hypercube_IIIa_short | ref | 64.3% | 54.7% | 56.1% |
| mirith_hypercube_IIIb_fast | ref | 64.5% | 13.7% | 12.4% |
| mirith_hypercube_IIIb_short | ref | 64.5% | 47.3% | 48.4% |
| mirith_hypercube_Ia_fast | opt | 78.1% | 51.5% | 49.1% |
| mirith_hypercube_Ia_fast | ref | 61.4% | 26.7% | 24.3% |
| mirith_hypercube_Ia_short | ref | 61.4% | 66.7% | 67.1% |
| mirith_hypercube_Ib_fast | opt | 79.5% | 44.8% | 42.3% |
| mirith_hypercube_Ib_fast | ref | 61.2% | 18.7% | 17.0% |
| mirith_hypercube_Ib_short | ref | 61.2% | 56.6% | 56.8% |
| mirith_hypercube_Va_fast | ref | 64.8% | 13.4% | 12.3% |
| mirith_hypercube_Vb_fast | ref | 64.5% | 11.0% | 10.1% |
| mqom_cat1_gf251_fast | ref | 73.5% | 33.0% | 33.1% |
| mqom_cat1_gf31_fast | ref | 64.6% | 19.8% | 19.2% |
| ov-Ip | m4f | 7.5% | 0.9% | 1.1% |
| ov-Ip | ref | 3.0% | 0.3% | 0.9% |
| ov-Ip-pkc | m4fspeed | 6.4% | 0.9% | 81.5% |
| ov-Ip-pkc | m4fstack | 6.4% | 0.9% | 81.4% |
| ov-Ip-pkc | ref | 3.0% | 0.3% | 80.0% |
| ov-Ip-pkc-skc | m4fspeed | 6.4% | 12.5% | 81.7% |
| ov-Ip-pkc-skc | m4fstack | 6.4% | 12.5% | 81.4% |
| ov-Ip-pkc-skc | ref | 3.0% | 4.7% | 80.7% |
| perk-128-fast-3 | m4 | 68.9% | 67.0% | 71.6% |
| perk-128-fast-3 | ref | 58.8% | 28.4% | 61.5% |
| perk-128-fast-5 | m4 | 62.8% | 65.8% | 70.6% |
| perk-128-fast-5 | ref | 50.5% | 27.2% | 60.1% |
| perk-128-short-3 | m4 | 68.8% | 65.7% | 69.8% |
| perk-128-short-5 | m4 | 62.7% | 64.6% | 68.6% |
| perk-192-fast-3 | m4 | 73.2% | 67.4% | 72.2% |
| perk-192-fast-5 | m4 | 67.7% | 66.5% | 71.3% |
| perk-192-short-3 | m4 | 73.3% | 64.3% | 66.1% |
| perk-192-short-5 | m4 | 67.5% | 63.3% | 64.8% |
| perk-256-fast-3 | m4 | 74.4% | 69.9% | 74.9% |
| perk-256-fast-5 | m4 | 68.2% | 69.1% | 74.1% |
| perk-256-short-3 | m4 | 74.1% | 65.0% | 65.5% |
| perk-256-short-5 | m4 | 68.3% | 63.7% | 64.0% |
| snova-24-5-16-4-esk | ref | 12.2% | 0.0% | 3.4% |
| snova-24-5-16-4-ssk | ref | 12.2% | 1.9% | 3.4% |
| snova-25-8-16-3-esk | ref | 9.6% | 0.1% | 8.0% |
| snova-25-8-16-3-ssk | ref | 9.7% | 3.5% | 8.0% |
| snova-28-17-16-2-esk | ref | 10.6% | 0.2% | 28.1% |
| snova-28-17-16-2-ssk | ref | 10.6% | 10.7% | 28.1% |
| snova-37-8-16-4-ssk | ref | 8.8% | 2.0% | 3.4% |
| sphincs-a-sha2-128f | ref | 43.3% | 86.6% | 48.2% |
| sphincs-a-sha2-128s | ref | 72.9% | 88.3% | 11.7% |
| sphincs-a-sha2-192f | ref | 57.5% | 88.3% | 46.0% |
| sphincs-a-shake-128f | ref | 72.3% | 96.2% | 76.0% |
| sphincs-a-shake-128s | ref | 90.9% | 96.9% | 31.8% |
| sphincs-a-shake-192f | ref | 82.6% | 96.5% | 70.7% |
| sphincs-sha2-128f-simple | clean | 90.8% | 90.7% | 90.6% |
| sphincs-sha2-128s-simple | clean | 90.8% | 90.7% | 90.4% |
| sphincs-sha2-192f-simple | clean | 90.2% | 90.8% | 90.7% |
| sphincs-sha2-192s-simple | clean | 90.3% | 91.1% | 91.5% |
| sphincs-sha2-256f-simple | clean | 90.2% | 90.7% | 90.9% |
| sphincs-sha2-256s-simple | clean | 90.2% | 91.3% | 91.3% |
| sphincs-shake-128f-simple | clean | 97.6% | 97.6% | 97.5% |
| sphincs-shake-128s-simple | clean | 97.6% | 97.6% | 97.5% |
| sphincs-shake-192f-simple | clean | 97.5% | 97.4% | 97.4% |
| sphincs-shake-192s-simple | clean | 97.5% | 97.4% | 97.4% |
| sphincs-shake-256f-simple | clean | 97.5% | 97.4% | 97.4% |
| sphincs-shake-256s-simple | clean | 97.5% | 97.3% | 97.4% |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| bikel1 | m4f | 181,088 | 24 | 49 | 181,161 |
| bikel1 | opt | 34,451 | 24 | 1 | 34,476 |
| bikel3 | m4f | 198,034 | 24 | 49 | 198,107 |
| bikel3 | opt | 43,091 | 24 | 1 | 43,116 |
| hqc-128 | clean | 18,628 | 0 | 0 | 18,628 |
| hqc-192 | clean | 21,104 | 0 | 0 | 21,104 |
| hqc-256 | clean | 26,260 | 0 | 0 | 26,260 |
| kyber1024 | clean | 6,264 | 0 | 0 | 6,264 |
| kyber1024 | m4fspeed | 16,884 | 0 | 0 | 16,884 |
| kyber1024 | m4fstack | 14,092 | 0 | 0 | 14,092 |
| kyber512 | clean | 5,132 | 0 | 0 | 5,132 |
| kyber512 | m4fspeed | 15,796 | 0 | 0 | 15,796 |
| kyber512 | m4fstack | 13,280 | 0 | 0 | 13,280 |
| kyber768 | clean | 5,136 | 0 | 0 | 5,136 |
| kyber768 | m4fspeed | 15,964 | 0 | 0 | 15,964 |
| kyber768 | m4fstack | 13,288 | 0 | 0 | 13,288 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| aimer128f | mem_opt | 17,476 | 0 | 0 | 17,476 |
| aimer128f | ref | 17,076 | 0 | 0 | 17,076 |
| aimer128s | mem_opt | 17,452 | 0 | 0 | 17,452 |
| aimer192f | mem_opt | 25,384 | 0 | 0 | 25,384 |
| aimer192f | ref | 24,956 | 0 | 0 | 24,956 |
| aimer192s | mem_opt | 25,288 | 0 | 0 | 25,288 |
| aimer256f | mem_opt | 27,804 | 0 | 0 | 27,804 |
| aimer256f | ref | 27,304 | 0 | 0 | 27,304 |
| aimer256s | mem_opt | 27,636 | 0 | 0 | 27,636 |
| ascon-sign-128f-robust | ref | 17,664 | 0 | 0 | 17,664 |
| ascon-sign-128f-simple | ref | 17,596 | 0 | 0 | 17,596 |
| ascon-sign-128s-robust | ref | 17,972 | 0 | 0 | 17,972 |
| ascon-sign-128s-simple | ref | 17,904 | 0 | 0 | 17,904 |
| ascon-sign-192f-robust | ref | 17,960 | 0 | 0 | 17,960 |
| ascon-sign-192f-simple | ref | 17,912 | 0 | 0 | 17,912 |
| ascon-sign-192s-robust | ref | 18,472 | 0 | 0 | 18,472 |
| ascon-sign-192s-simple | ref | 18,424 | 0 | 0 | 18,424 |
| biscuit128f | ref | 7,580 | 0 | 0 | 7,580 |
| biscuit192f | ref | 7,780 | 0 | 0 | 7,780 |
| biscuit256f | ref | 8,216 | 0 | 0 | 8,216 |
| cross-sha2-r-sdp-1-fast | ref | 14,244 | 0 | 104 | 14,348 |
| cross-sha2-r-sdp-3-fast | ref | 14,744 | 0 | 128 | 14,872 |
| cross-sha2-r-sdpg-1-fast | ref | 18,409 | 0 | 104 | 18,513 |
| cross-sha2-r-sdpg-1-small | ref | 18,674 | 0 | 104 | 18,778 |
| cross-sha2-r-sdpg-3-fast | ref | 19,609 | 0 | 128 | 19,737 |
| cross-sha2-r-sdpg-5-fast | ref | 18,669 | 0 | 152 | 18,821 |
| cross-sha3-r-sdp-1-fast | ref | 14,472 | 0 | 208 | 14,680 |
| cross-sha3-r-sdp-3-fast | ref | 14,884 | 0 | 208 | 15,092 |
| cross-sha3-r-sdpg-1-fast | ref | 18,605 | 0 | 208 | 18,813 |
| cross-sha3-r-sdpg-1-small | ref | 18,846 | 0 | 208 | 19,054 |
| cross-sha3-r-sdpg-3-fast | ref | 19,689 | 0 | 208 | 19,897 |
| cross-sha3-r-sdpg-5-fast | ref | 18,593 | 0 | 208 | 18,801 |
| dilithium2 | clean | 8,064 | 0 | 0 | 8,064 |
| dilithium2 | m4f | 19,180 | 0 | 0 | 19,180 |
| dilithium2 | m4fstack | 24,184 | 0 | 0 | 24,184 |
| dilithium3 | clean | 7,580 | 0 | 0 | 7,580 |
| dilithium3 | m4f | 19,188 | 0 | 0 | 19,188 |
| dilithium3 | m4fstack | 23,448 | 0 | 0 | 23,448 |
| dilithium5 | clean | 7,808 | 0 | 0 | 7,808 |
| dilithium5 | m4f | 19,096 | 0 | 0 | 19,096 |
| dilithium5 | m4fstack | 23,820 | 0 | 0 | 23,820 |
| falcon-1024 | clean | 82,703 | 0 | 0 | 82,703 |
| falcon-1024 | m4-ct | 81,825 | 0 | 79,872 | 161,697 |
| falcon-1024 | opt-ct | 81,825 | 0 | 79,872 | 161,697 |
| falcon-1024 | opt-leaktime | 75,429 | 0 | 79,872 | 155,301 |
| falcon-1024-tree | opt-ct | 81,569 | 0 | 55,296 | 136,865 |
| falcon-1024-tree | opt-leaktime | 75,173 | 0 | 55,296 | 130,469 |
| falcon-512 | clean | 82,663 | 0 | 0 | 82,663 |
| falcon-512 | m4-ct | 81,825 | 0 | 39,936 | 121,761 |
| falcon-512 | opt-ct | 81,825 | 0 | 39,936 | 121,761 |
| falcon-512 | opt-leaktime | 75,429 | 0 | 39,936 | 115,365 |
| falcon-512-tree | m4-ct | 81,569 | 0 | 27,648 | 109,217 |
| falcon-512-tree | opt-ct | 81,569 | 0 | 27,648 | 109,217 |
| falcon-512-tree | opt-leaktime | 75,173 | 0 | 27,648 | 102,821 |
| falcon-padded-1024 | clean | 82,643 | 0 | 0 | 82,643 |
| falcon-padded-512 | clean | 82,599 | 0 | 0 | 82,599 |
| haetae2 | m4f | 35,708 | 0 | 0 | 35,708 |
| haetae2 | ref | 25,568 | 0 | 0 | 25,568 |
| haetae3 | m4f | 35,936 | 0 | 0 | 35,936 |
| haetae3 | ref | 25,980 | 0 | 0 | 25,980 |
| haetae5 | m4f | 35,692 | 0 | 0 | 35,692 |
| haetae5 | ref | 25,688 | 0 | 0 | 25,688 |
| hawk1024 | ref | 102,031 | 0 | 0 | 102,031 |
| hawk256 | ref | 102,015 | 0 | 0 | 102,015 |
| hawk512 | ref | 102,027 | 0 | 0 | 102,027 |
| mayo1 | m4f | 19,300 | 8 | 0 | 19,308 |
| mayo1 | ref | 26,436 | 8 | 0 | 26,444 |
| mayo2 | m4f | 17,292 | 8 | 0 | 17,300 |
| mayo2 | ref | 24,404 | 8 | 0 | 24,412 |
| mayo3 | m4f | 23,612 | 8 | 0 | 23,620 |
| meds13220 | ref | 16,844 | 0 | 0 | 16,844 |
| meds55604 | ref | 9,012 | 0 | 0 | 9,012 |
| mirith_IIIa_fast | ref | 7,720 | 256 | 0 | 7,976 |
| mirith_IIIb_fast | ref | 7,760 | 256 | 0 | 8,016 |
| mirith_Ia_fast | ref | 7,610 | 256 | 0 | 7,866 |
| mirith_Ib_fast | ref | 7,602 | 256 | 0 | 7,858 |
| mirith_Va_fast | ref | 7,890 | 256 | 0 | 8,146 |
| mirith_Vb_fast | ref | 7,914 | 256 | 0 | 8,170 |
| mirith_hypercube_IIIa_fast | ref | 8,966 | 256 | 0 | 9,222 |
| mirith_hypercube_IIIa_short | ref | 9,139 | 256 | 0 | 9,395 |
| mirith_hypercube_IIIb_fast | ref | 9,002 | 256 | 0 | 9,258 |
| mirith_hypercube_IIIb_short | ref | 9,159 | 256 | 0 | 9,415 |
| mirith_hypercube_Ia_fast | opt | 10,932 | 0 | 0 | 10,932 |
| mirith_hypercube_Ia_fast | ref | 8,844 | 256 | 0 | 9,100 |
| mirith_hypercube_Ia_short | ref | 8,781 | 256 | 0 | 9,037 |
| mirith_hypercube_Ib_fast | opt | 10,908 | 0 | 0 | 10,908 |
| mirith_hypercube_Ib_fast | ref | 8,820 | 256 | 0 | 9,076 |
| mirith_hypercube_Ib_short | ref | 8,825 | 256 | 0 | 9,081 |
| mirith_hypercube_Va_fast | ref | 9,140 | 256 | 0 | 9,396 |
| mirith_hypercube_Vb_fast | ref | 9,160 | 256 | 0 | 9,416 |
| mqom_cat1_gf251_fast | ref | 16,865 | 0 | 0 | 16,865 |
| mqom_cat1_gf31_fast | ref | 23,718 | 0 | 0 | 23,718 |
| ov-Ip | m4f | 118,939 | 0 | 0 | 118,939 |
| ov-Ip | ref | 29,215 | 0 | 0 | 29,215 |
| ov-Ip-pkc | m4fspeed | 119,131 | 0 | 0 | 119,131 |
| ov-Ip-pkc | m4fstack | 119,059 | 0 | 0 | 119,059 |
| ov-Ip-pkc | ref | 29,423 | 0 | 0 | 29,423 |
| ov-Ip-pkc-skc | m4fspeed | 119,175 | 0 | 0 | 119,175 |
| ov-Ip-pkc-skc | m4fstack | 119,103 | 0 | 0 | 119,103 |
| ov-Ip-pkc-skc | ref | 29,467 | 0 | 0 | 29,467 |
| perk-128-fast-3 | m4 | 13,421 | 4 | 0 | 13,425 |
| perk-128-fast-3 | ref | 11,053 | 4 | 0 | 11,057 |
| perk-128-fast-5 | m4 | 13,493 | 4 | 0 | 13,497 |
| perk-128-fast-5 | ref | 11,129 | 4 | 0 | 11,133 |
| perk-128-short-3 | m4 | 26,313 | 4 | 0 | 26,317 |
| perk-128-short-5 | m4 | 26,461 | 4 | 0 | 26,465 |
| perk-192-fast-3 | m4 | 12,253 | 4 | 0 | 12,257 |
| perk-192-fast-5 | m4 | 12,277 | 4 | 0 | 12,281 |
| perk-192-short-3 | m4 | 24,189 | 4 | 0 | 24,193 |
| perk-192-short-5 | m4 | 24,913 | 4 | 0 | 24,917 |
| perk-256-fast-3 | m4 | 12,337 | 4 | 0 | 12,341 |
| perk-256-fast-5 | m4 | 12,337 | 4 | 0 | 12,341 |
| perk-256-short-3 | m4 | 31,905 | 4 | 0 | 31,909 |
| perk-256-short-5 | m4 | 32,989 | 4 | 0 | 32,993 |
| snova-24-5-16-4-esk | ref | 52,132 | 0 | 336 | 52,468 |
| snova-24-5-16-4-ssk | ref | 52,132 | 0 | 336 | 52,468 |
| snova-25-8-16-3-esk | ref | 28,240 | 0 | 299 | 28,539 |
| snova-25-8-16-3-ssk | ref | 28,240 | 0 | 299 | 28,539 |
| snova-28-17-16-2-esk | ref | 16,436 | 0 | 280 | 16,716 |
| snova-28-17-16-2-ssk | ref | 16,436 | 0 | 280 | 16,716 |
| snova-37-8-16-4-ssk | ref | 52,440 | 0 | 336 | 52,776 |
| sphincs-a-sha2-128f | ref | 6,343 | 0 | 0 | 6,343 |
| sphincs-a-sha2-128s | ref | 6,899 | 0 | 0 | 6,899 |
| sphincs-a-sha2-192f | ref | 6,867 | 0 | 0 | 6,867 |
| sphincs-a-shake-128f | ref | 5,552 | 0 | 0 | 5,552 |
| sphincs-a-shake-128s | ref | 6,108 | 0 | 0 | 6,108 |
| sphincs-a-shake-192f | ref | 5,916 | 0 | 0 | 5,916 |
| sphincs-sha2-128f-simple | clean | 4,956 | 0 | 0 | 4,956 |
| sphincs-sha2-128s-simple | clean | 5,264 | 0 | 0 | 5,264 |
| sphincs-sha2-192f-simple | clean | 5,444 | 0 | 0 | 5,444 |
| sphincs-sha2-192s-simple | clean | 5,968 | 0 | 0 | 5,968 |
| sphincs-sha2-256f-simple | clean | 5,728 | 0 | 0 | 5,728 |
| sphincs-sha2-256s-simple | clean | 6,084 | 0 | 0 | 6,084 |
| sphincs-shake-128f-simple | clean | 4,184 | 0 | 0 | 4,184 |
| sphincs-shake-128s-simple | clean | 4,492 | 0 | 0 | 4,492 |
| sphincs-shake-192f-simple | clean | 4,472 | 0 | 0 | 4,472 |
| sphincs-shake-192s-simple | clean | 4,984 | 0 | 0 | 4,984 |
| sphincs-shake-256f-simple | clean | 4,720 | 0 | 0 | 4,720 |
| sphincs-shake-256s-simple | clean | 5,076 | 0 | 0 | 5,076 |
