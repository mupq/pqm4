# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| bikel1 (100 executions) | m4f | AVG: 24,974,536 <br /> MIN: 24,950,520 <br /> MAX: 24,991,477 | AVG: 3,394,030 <br /> MIN: 3,378,190 <br /> MAX: 3,414,910 | AVG: 51,214,664 <br /> MIN: 51,198,795 <br /> MAX: 51,235,513 |
| bikel1 (100 executions) | opt | AVG: 68,198,074 <br /> MIN: 68,181,729 <br /> MAX: 68,218,850 | AVG: 5,085,537 <br /> MIN: 5,068,825 <br /> MAX: 5,101,896 | AVG: 121,429,912 <br /> MIN: 121,416,187 <br /> MAX: 121,446,269 |
| hqc-rmrs-128 (100 executions) | clean | AVG: 2,883,811 <br /> MIN: 2,850,356 <br /> MAX: 3,090,278 | AVG: 5,236,720 <br /> MIN: 5,150,902 <br /> MAX: 5,554,288 | AVG: 7,594,631 <br /> MIN: 7,482,072 <br /> MAX: 7,890,446 |
| kyber1024 (100 executions) | clean | AVG: 1,649,604 <br /> MIN: 1,646,417 <br /> MAX: 1,686,328 | AVG: 2,016,366 <br /> MIN: 2,013,177 <br /> MAX: 2,053,070 | AVG: 2,159,906 <br /> MIN: 2,156,716 <br /> MAX: 2,196,609 |
| kyber1024 (100 executions) | m4fspeed | AVG: 1,122,936 <br /> MIN: 1,120,610 <br /> MAX: 1,147,966 | AVG: 1,315,737 <br /> MIN: 1,313,449 <br /> MAX: 1,340,766 | AVG: 1,209,901 <br /> MIN: 1,207,648 <br /> MAX: 1,234,899 |
| kyber1024 (100 executions) | m4fstack | AVG: 1,126,561 <br /> MIN: 1,124,115 <br /> MAX: 1,138,795 | AVG: 1,323,943 <br /> MIN: 1,321,497 <br /> MAX: 1,336,212 | AVG: 1,219,060 <br /> MIN: 1,216,614 <br /> MAX: 1,231,295 |
| kyber1024-90s (100 executions) | clean | AVG: 3,008,837 <br /> MIN: 3,007,295 <br /> MAX: 3,024,024 | AVG: 3,275,730 <br /> MIN: 3,274,235 <br /> MAX: 3,290,907 | AVG: 3,516,691 <br /> MIN: 3,515,163 <br /> MAX: 3,531,901 |
| kyber1024-90s (100 executions) | m4fspeed | AVG: 973,196 <br /> MIN: 961,657 <br /> MAX: 978,853 | AVG: 1,068,184 <br /> MIN: 1,056,648 <br /> MAX: 1,073,886 | AVG: 1,059,775 <br /> MIN: 1,048,239 <br /> MAX: 1,065,477 |
| kyber1024-90s (100 executions) | m4fstack | AVG: 979,692 <br /> MIN: 972,492 <br /> MAX: 985,031 | AVG: 1,079,272 <br /> MIN: 1,072,072 <br /> MAX: 1,084,611 | AVG: 1,071,817 <br /> MIN: 1,064,616 <br /> MAX: 1,077,155 |
| kyber512 (100 executions) | clean | AVG: 636,181 <br /> MIN: 635,670 <br /> MAX: 648,917 | AVG: 843,945 <br /> MIN: 843,433 <br /> MAX: 856,680 | AVG: 940,320 <br /> MIN: 939,808 <br /> MAX: 953,055 |
| kyber512 (100 executions) | m4fspeed | AVG: 434,438 <br /> MIN: 433,217 <br /> MAX: 446,786 | AVG: 530,469 <br /> MIN: 529,247 <br /> MAX: 542,816 | AVG: 476,712 <br /> MIN: 475,491 <br /> MAX: 489,060 |
| kyber512 (100 executions) | m4fstack | AVG: 433,718 <br /> MIN: 433,191 <br /> MAX: 446,122 | AVG: 531,676 <br /> MIN: 531,150 <br /> MAX: 544,080 | AVG: 478,166 <br /> MIN: 477,640 <br /> MAX: 490,570 |
| kyber512-90s (100 executions) | clean | AVG: 948,446 <br /> MIN: 947,802 <br /> MAX: 964,084 | AVG: 1,112,852 <br /> MIN: 1,112,208 <br /> MAX: 1,128,491 | AVG: 1,261,630 <br /> MIN: 1,260,986 <br /> MAX: 1,277,269 |
| kyber512-90s (100 executions) | m4fspeed | AVG: 369,011 <br /> MIN: 364,769 <br /> MAX: 373,816 | AVG: 421,685 <br /> MIN: 417,443 <br /> MAX: 426,490 | AVG: 420,333 <br /> MIN: 416,092 <br /> MAX: 425,139 |
| kyber512-90s (100 executions) | m4fstack | AVG: 369,736 <br /> MIN: 361,461 <br /> MAX: 370,708 | AVG: 424,339 <br /> MIN: 416,065 <br /> MAX: 425,312 | AVG: 423,234 <br /> MIN: 414,960 <br /> MAX: 424,207 |
| kyber768 (100 executions) | clean | AVG: 1,059,876 <br /> MIN: 1,057,827 <br /> MAX: 1,071,809 | AVG: 1,352,934 <br /> MIN: 1,350,884 <br /> MAX: 1,364,866 | AVG: 1,471,055 <br /> MIN: 1,469,005 <br /> MAX: 1,482,987 |
| kyber768 (100 executions) | m4fspeed | AVG: 706,531 <br /> MIN: 703,969 <br /> MAX: 718,271 | AVG: 863,343 <br /> MIN: 860,765 <br /> MAX: 875,091 | AVG: 783,369 <br /> MIN: 780,788 <br /> MAX: 795,114 |
| kyber768 (100 executions) | m4fstack | AVG: 707,275 <br /> MIN: 705,435 <br /> MAX: 719,983 | AVG: 867,363 <br /> MIN: 865,520 <br /> MAX: 880,070 | AVG: 788,053 <br /> MIN: 786,210 <br /> MAX: 800,760 |
| kyber768-90s (100 executions) | clean | AVG: 1,816,649 <br /> MIN: 1,815,810 <br /> MAX: 1,831,510 | AVG: 2,032,562 <br /> MIN: 2,031,722 <br /> MAX: 2,047,390 | AVG: 2,225,597 <br /> MIN: 2,224,757 <br /> MAX: 2,240,425 |
| kyber768-90s (100 executions) | m4fspeed | AVG: 614,455 <br /> MIN: 610,716 <br /> MAX: 619,096 | AVG: 694,064 <br /> MIN: 690,330 <br /> MAX: 698,723 | AVG: 688,999 <br /> MIN: 685,265 <br /> MAX: 693,658 |
| kyber768-90s (100 executions) | m4fstack | AVG: 617,709 <br /> MIN: 613,688 <br /> MAX: 622,666 | AVG: 700,599 <br /> MIN: 696,577 <br /> MAX: 705,555 | AVG: 696,202 <br /> MIN: 692,181 <br /> MAX: 701,159 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| dilithium2 (10000 executions) | clean | AVG: 1,944,539 <br /> MIN: 1,890,031 <br /> MAX: 1,991,828 | AVG: 7,144,383 <br /> MIN: 3,140,649 <br /> MAX: 63,849,339 | AVG: 2,064,129 <br /> MIN: 2,063,522 <br /> MAX: 2,064,634 |
| dilithium2 (10000 executions) | m4f | AVG: 1,597,999 <br /> MIN: 1,543,482 <br /> MAX: 1,644,972 | AVG: 4,111,596 <br /> MIN: 1,975,193 <br /> MAX: 28,355,968 | AVG: 1,571,804 <br /> MIN: 1,571,197 <br /> MAX: 1,572,305 |
| dilithium2aes (10000 executions) | clean | AVG: 4,995,899 <br /> MIN: 4,936,813 <br /> MAX: 5,118,217 | AVG: 11,648,989 <br /> MIN: 6,130,462 <br /> MAX: 61,958,375 | AVG: 4,669,616 <br /> MIN: 4,610,387 <br /> MAX: 4,791,733 |
| dilithium3 (10000 executions) | clean | AVG: 3,365,142 <br /> MIN: 3,363,198 <br /> MAX: 3,378,304 | AVG: 11,634,591 <br /> MIN: 4,892,049 <br /> MAX: 79,793,644 | AVG: 3,430,286 <br /> MIN: 3,429,812 <br /> MAX: 3,430,778 |
| dilithium3 (10000 executions) | m4f | AVG: 2,830,024 <br /> MIN: 2,828,027 <br /> MAX: 2,832,150 | AVG: 6,588,465 <br /> MIN: 3,224,221 <br /> MAX: 46,880,624 | AVG: 2,691,283 <br /> MIN: 2,690,800 <br /> MAX: 2,691,739 |
| dilithium3aes (10000 executions) | clean | AVG: 8,980,662 <br /> MIN: 8,870,698 <br /> MAX: 9,135,481 | AVG: 19,843,507 <br /> MIN: 10,319,280 <br /> MAX: 112,310,317 | AVG: 8,314,038 <br /> MIN: 8,205,198 <br /> MAX: 8,468,692 |
| dilithium5 (10000 executions) | m4f | AVG: 4,826,422 <br /> MIN: 4,737,706 <br /> MAX: 4,914,744 | AVG: 8,779,067 <br /> MIN: 5,416,181 <br /> MAX: 52,012,847 | AVG: 4,705,693 <br /> MIN: 4,705,090 <br /> MAX: 4,706,259 |
| falcon-1024 (100 executions) | clean | AVG: 589,059,133 <br /> MIN: 334,912,351 <br /> MAX: 1,243,184,474 | AVG: 133,598,726 <br /> MIN: 133,189,548 <br /> MAX: 133,921,649 | AVG: 1,547,336 <br /> MIN: 1,546,772 <br /> MAX: 1,548,051 |
| falcon-1024 (100 executions) | m4-ct | AVG: 480,071,949 <br /> MIN: 271,647,441 <br /> MAX: 1,227,690,897 | AVG: 85,125,001 <br /> MIN: 84,882,111 <br /> MAX: 85,556,430 | AVG: 994,972 <br /> MIN: 983,996 <br /> MAX: 1,002,867 |
| falcon-1024 (100 executions) | opt-ct | AVG: 437,448,136 <br /> MIN: 271,659,962 <br /> MAX: 1,092,676,507 | AVG: 85,113,093 <br /> MIN: 84,848,956 <br /> MAX: 85,473,992 | AVG: 994,270 <br /> MIN: 984,187 <br /> MAX: 1,002,619 |
| falcon-1024 (100 executions) | opt-leaktime | AVG: 413,908,640 <br /> MIN: 243,261,195 <br /> MAX: 1,126,577,305 | AVG: 76,314,462 <br /> MIN: 75,745,413 <br /> MAX: 76,892,801 | AVG: 994,634 <br /> MIN: 982,708 <br /> MAX: 1,002,471 |
| falcon-512 (100 executions) | clean | AVG: 217,740,948 <br /> MIN: 129,494,100 <br /> MAX: 511,780,471 | AVG: 61,102,456 <br /> MIN: 60,847,251 <br /> MAX: 61,330,321 | AVG: 774,876 <br /> MIN: 774,536 <br /> MAX: 775,376 |
| falcon-512 (100 executions) | m4-ct | AVG: 155,757,768 <br /> MIN: 101,804,738 <br /> MAX: 436,771,421 | AVG: 38,979,435 <br /> MIN: 38,774,219 <br /> MAX: 39,146,132 | AVG: 481,452 <br /> MIN: 472,089 <br /> MAX: 488,157 |
| falcon-512 (100 executions) | opt-ct | AVG: 169,979,748 <br /> MIN: 101,804,734 <br /> MAX: 511,094,390 | AVG: 38,995,196 <br /> MIN: 38,771,533 <br /> MAX: 39,280,349 | AVG: 481,457 <br /> MIN: 472,109 <br /> MAX: 488,208 |
| falcon-512 (100 executions) | opt-leaktime | AVG: 154,344,796 <br /> MIN: 89,719,505 <br /> MAX: 442,643,356 | AVG: 35,503,133 <br /> MIN: 35,166,340 <br /> MAX: 35,923,860 | AVG: 480,806 <br /> MIN: 472,450 <br /> MAX: 489,614 |
| falcon-512-tree (100 executions) | m4-ct | AVG: 179,772,454 <br /> MIN: 116,934,668 <br /> MAX: 497,881,688 | AVG: 17,649,735 <br /> MIN: 17,489,319 <br /> MAX: 17,847,797 | AVG: 480,619 <br /> MIN: 471,367 <br /> MAX: 488,548 |
| falcon-512-tree (100 executions) | opt-ct | AVG: 185,495,778 <br /> MIN: 116,934,665 <br /> MAX: 591,766,146 | AVG: 17,664,284 <br /> MIN: 17,480,589 <br /> MAX: 17,824,518 | AVG: 482,085 <br /> MIN: 472,168 <br /> MAX: 488,509 |
| falcon-512-tree (100 executions) | opt-leaktime | AVG: 157,683,545 <br /> MIN: 101,416,387 <br /> MAX: 370,593,247 | AVG: 19,162,650 <br /> MIN: 18,816,478 <br /> MAX: 19,426,978 | AVG: 481,577 <br /> MIN: 472,170 <br /> MAX: 488,230 |
| sphincs-haraka-128f-robust (3 executions) | clean | AVG: 106,427,973 <br /> MIN: 106,427,961 <br /> MAX: 106,427,997 | AVG: 2,699,060,638 <br /> MIN: 2,698,241,211 <br /> MAX: 2,699,997,157 | AVG: 174,647,895 <br /> MIN: 173,477,158 <br /> MAX: 176,638,141 |
| sphincs-haraka-128f-simple (3 executions) | clean | AVG: 74,934,480 <br /> MIN: 74,934,458 <br /> MAX: 74,934,492 | AVG: 1,887,299,882 <br /> MIN: 1,887,134,522 <br /> MAX: 1,887,382,565 | AVG: 118,143,703 <br /> MIN: 113,925,327 <br /> MAX: 123,851,044 |
| sphincs-haraka-128s-robust (3 executions) | clean | AVG: 6,775,943,571 <br /> MIN: 6,775,943,546 <br /> MAX: 6,775,943,591 | AVG: 53,822,326,627 <br /> MIN: 53,821,272,834 <br /> MAX: 53,824,434,213 | AVG: 68,158,360 <br /> MIN: 65,114,417 <br /> MAX: 72,841,330 |
| sphincs-haraka-128s-simple (3 executions) | clean | AVG: 4,758,339,537 <br /> MIN: 4,758,339,511 <br /> MAX: 4,758,339,556 | AVG: 37,472,069,032 <br /> MIN: 37,470,580,002 <br /> MAX: 37,474,550,750 | AVG: 44,603,270 <br /> MIN: 44,272,388 <br /> MAX: 44,768,737 |
| sphincs-haraka-192f-robust (3 executions) | clean | AVG: 157,886,973 <br /> MIN: 157,886,961 <br /> MAX: 157,886,995 | AVG: 4,729,109,673 <br /> MIN: 4,724,305,900 <br /> MAX: 4,731,687,311 | AVG: 261,039,514 <br /> MIN: 258,813,178 <br /> MAX: 263,734,554 |
| sphincs-haraka-192f-simple (3 executions) | clean | AVG: 110,403,519 <br /> MIN: 110,403,498 <br /> MAX: 110,403,532 | AVG: 3,167,446,164 <br /> MIN: 3,164,466,253 <br /> MAX: 3,169,681,094 | AVG: 171,820,185 <br /> MIN: 169,915,924 <br /> MAX: 174,138,430 |
| sphincs-haraka-192s-robust (3 executions) | clean | AVG: 10,070,301,104 <br /> MIN: 10,070,301,092 <br /> MAX: 10,070,301,120 | AVG: 105,836,052,151 <br /> MIN: 105,833,943,123 <br /> MAX: 105,838,864,162 | AVG: 102,385,564 <br /> MIN: 100,510,789 <br /> MAX: 104,729,057 |
| sphincs-haraka-192s-simple (3 executions) | clean | AVG: 7,028,359,469 <br /> MIN: 7,028,359,462 <br /> MAX: 7,028,359,475 | AVG: 69,349,184,156 <br /> MIN: 69,348,190,870 <br /> MAX: 69,350,922,453 | AVG: 64,929,339 <br /> MIN: 63,356,226 <br /> MAX: 65,840,010 |
| sphincs-haraka-256f-robust (3 executions) | clean | AVG: 422,110,917 <br /> MIN: 422,110,915 <br /> MAX: 422,110,921 | AVG: 9,925,037,310 <br /> MIN: 9,919,761,990 <br /> MAX: 9,929,258,109 | AVG: 282,995,607 <br /> MIN: 280,533,063 <br /> MAX: 286,865,365 |
| sphincs-haraka-256f-simple (3 executions) | clean | AVG: 293,499,115 <br /> MIN: 293,499,091 <br /> MAX: 293,499,129 | AVG: 6,701,863,848 <br /> MIN: 6,699,462,526 <br /> MAX: 6,705,176,025 | AVG: 183,796,029 <br /> MIN: 182,221,816 <br /> MAX: 186,447,361 |
| sphincs-haraka-256s-robust (3 executions) | clean | AVG: 6,739,159,318 <br /> MIN: 6,739,159,309 <br /> MAX: 6,739,159,328 | AVG: 105,302,624,797 <br /> MIN: 105,300,748,903 <br /> MAX: 105,304,266,285 | AVG: 156,467,817 <br /> MIN: 154,826,875 <br /> MAX: 159,398,072 |
| sphincs-haraka-256s-simple (3 executions) | clean | AVG: 4,683,144,675 <br /> MIN: 4,683,144,642 <br /> MAX: 4,683,144,705 | AVG: 69,202,732,323 <br /> MIN: 69,201,324,370 <br /> MAX: 69,205,052,507 | AVG: 101,719,411 <br /> MIN: 100,063,540 <br /> MAX: 104,037,675 |
| sphincs-sha256-128f-robust (3 executions) | clean | AVG: 29,123,270 <br /> MIN: 29,123,249 <br /> MAX: 29,123,282 | AVG: 716,257,523 <br /> MIN: 715,884,705 <br /> MAX: 716,674,437 | AVG: 42,248,922 <br /> MIN: 41,497,196 <br /> MAX: 42,869,922 |
| sphincs-sha256-128f-simple (3 executions) | clean | AVG: 15,388,375 <br /> MIN: 15,388,352 <br /> MAX: 15,388,387 | AVG: 382,533,954 <br /> MIN: 382,308,022 <br /> MAX: 382,976,925 | AVG: 21,150,671 <br /> MIN: 20,677,650 <br /> MAX: 21,741,991 |
| sphincs-sha256-128s-robust (3 executions) | clean | AVG: 1,864,047,221 <br /> MIN: 1,864,042,048 <br /> MAX: 1,864,050,532 | AVG: 14,012,634,889 <br /> MIN: 14,012,400,685 <br /> MAX: 14,012,822,953 | AVG: 14,847,302 <br /> MIN: 14,422,375 <br /> MAX: 15,206,848 |
| sphincs-sha256-128s-simple (3 executions) | clean | AVG: 985,367,046 <br /> MIN: 985,355,790 <br /> MAX: 985,385,031 | AVG: 7,495,603,716 <br /> MIN: 7,495,252,193 <br /> MAX: 7,496,247,958 | AVG: 7,165,875 <br /> MIN: 6,861,584 <br /> MAX: 7,419,441 |
| sphincs-sha256-192f-robust (3 executions) | clean | AVG: 43,116,184 <br /> MIN: 43,116,173 <br /> MAX: 43,116,205 | AVG: 1,195,381,634 <br /> MIN: 1,193,980,671 <br /> MAX: 1,196,819,904 | AVG: 64,857,703 <br /> MIN: 64,364,605 <br /> MAX: 65,153,579 |
| sphincs-sha256-192f-simple (3 executions) | clean | AVG: 22,645,923 <br /> MIN: 22,645,911 <br /> MAX: 22,645,947 | AVG: 639,321,913 <br /> MIN: 639,157,877 <br /> MAX: 639,638,579 | AVG: 32,940,330 <br /> MIN: 31,955,780 <br /> MAX: 33,534,443 |
| sphincs-sha256-192s-robust (3 executions) | clean | AVG: 2,758,781,668 <br /> MIN: 2,758,721,187 <br /> MAX: 2,758,814,880 | AVG: 25,556,205,325 <br /> MIN: 25,555,467,827 <br /> MAX: 25,556,897,376 | AVG: 23,195,383 <br /> MIN: 22,702,335 <br /> MAX: 23,589,803 |
| sphincs-sha256-192s-simple (3 executions) | clean | AVG: 1,450,073,477 <br /> MIN: 1,449,766,386 <br /> MAX: 1,450,529,270 | AVG: 13,764,196,955 <br /> MIN: 13,762,891,584 <br /> MAX: 13,765,362,825 | AVG: 11,763,703 <br /> MIN: 11,695,761 <br /> MAX: 11,899,525 |
| sphincs-sha256-256f-robust (3 executions) | clean | AVG: 158,034,870 <br /> MIN: 158,034,868 <br /> MAX: 158,034,873 | AVG: 3,305,447,599 <br /> MIN: 3,303,450,474 <br /> MAX: 3,306,582,779 | AVG: 94,366,505 <br /> MIN: 92,087,788 <br /> MAX: 96,189,482 |
| sphincs-sha256-256f-simple (3 executions) | clean | AVG: 59,808,433 <br /> MIN: 59,807,808 <br /> MAX: 59,808,748 | AVG: 1,281,329,322 <br /> MIN: 1,280,242,352 <br /> MAX: 1,282,332,972 | AVG: 32,947,097 <br /> MIN: 32,522,594 <br /> MAX: 33,490,507 |
| sphincs-sha256-256s-robust (3 executions) | clean | AVG: 2,524,393,357 <br /> MIN: 2,524,337,328 <br /> MAX: 2,524,432,487 | AVG: 31,056,826,302 <br /> MIN: 31,055,874,069 <br /> MAX: 31,057,485,164 | AVG: 47,434,569 <br /> MIN: 46,022,129 <br /> MAX: 48,212,821 |
| sphincs-sha256-256s-simple (3 executions) | clean | AVG: 952,799,879 <br /> MIN: 952,642,357 <br /> MAX: 953,062,293 | AVG: 12,304,132,668 <br /> MIN: 12,303,657,740 <br /> MAX: 12,304,436,252 | AVG: 16,715,346 <br /> MIN: 16,326,849 <br /> MAX: 17,137,621 |
| sphincs-shake256-128f-robust (3 executions) | clean | AVG: 113,347,070 <br /> MIN: 113,347,058 <br /> MAX: 113,347,093 | AVG: 2,788,974,930 <br /> MIN: 2,787,812,662 <br /> MAX: 2,790,137,173 | AVG: 158,730,948 <br /> MIN: 156,406,568 <br /> MAX: 160,667,913 |
| sphincs-shake256-128f-simple (3 executions) | clean | AVG: 59,759,081 <br /> MIN: 59,759,080 <br /> MAX: 59,759,082 | AVG: 1,483,676,214 <br /> MIN: 1,483,213,924 <br /> MAX: 1,484,204,563 | AVG: 83,065,165 <br /> MIN: 81,414,021 <br /> MAX: 84,584,221 |
| sphincs-shake256-128s-robust (3 executions) | clean | AVG: 7,255,773,038 <br /> MIN: 7,255,773,014 <br /> MAX: 7,255,773,057 | AVG: 54,573,950,176 <br /> MIN: 54,572,529,688 <br /> MAX: 54,575,241,560 | AVG: 53,615,181 <br /> MIN: 51,549,111 <br /> MAX: 55,423,008 |
| sphincs-shake256-128s-simple (3 executions) | clean | AVG: 3,825,341,548 <br /> MIN: 3,825,341,531 <br /> MAX: 3,825,341,564 | AVG: 29,086,410,120 <br /> MIN: 29,085,749,525 <br /> MAX: 29,087,533,088 | AVG: 29,495,105 <br /> MIN: 28,966,755 <br /> MAX: 30,155,531 |
| sphincs-shake256-192f-robust (3 executions) | clean | AVG: 167,154,323 <br /> MIN: 167,154,303 <br /> MAX: 167,154,334 | AVG: 4,461,897,673 <br /> MIN: 4,458,767,619 <br /> MAX: 4,464,636,487 | AVG: 240,590,626 <br /> MIN: 238,634,394 <br /> MAX: 243,329,332 |
| sphincs-shake256-192f-simple (3 executions) | clean | AVG: 88,333,405 <br /> MIN: 88,333,405 <br /> MAX: 88,333,406 | AVG: 2,409,188,992 <br /> MIN: 2,408,787,940 <br /> MAX: 2,409,991,046 | AVG: 123,334,622 <br /> MIN: 122,866,683 <br /> MAX: 123,668,857 |
| sphincs-shake256-192s-robust (3 executions) | clean | AVG: 10,698,254,977 <br /> MIN: 10,698,254,964 <br /> MAX: 10,698,254,997 | AVG: 93,298,513,700 <br /> MIN: 93,295,644,767 <br /> MAX: 93,301,121,760 | AVG: 81,201,582 <br /> MIN: 77,549,977 <br /> MAX: 83,809,891 |
| sphincs-shake256-192s-simple (3 executions) | clean | AVG: 5,652,907,918 <br /> MIN: 5,652,907,897 <br /> MAX: 5,652,907,934 | AVG: 50,824,666,973 <br /> MIN: 50,823,330,463 <br /> MAX: 50,826,137,107 | AVG: 41,687,543 <br /> MIN: 40,818,602 <br /> MAX: 42,623,345 |
| sphincs-shake256-256f-robust (3 executions) | clean | AVG: 444,922,977 <br /> MIN: 444,922,967 <br /> MAX: 444,922,998 | AVG: 8,993,352,645 <br /> MIN: 8,987,821,428 <br /> MAX: 9,000,464,222 | AVG: 243,254,884 <br /> MIN: 240,752,880 <br /> MAX: 244,703,467 |
| sphincs-shake256-256f-simple (3 executions) | clean | AVG: 235,448,503 <br /> MIN: 235,448,502 <br /> MAX: 235,448,505 | AVG: 4,865,464,381 <br /> MIN: 4,864,247,499 <br /> MAX: 4,867,289,711 | AVG: 127,387,108 <br /> MIN: 125,561,248 <br /> MAX: 129,010,103 |
| sphincs-shake256-256s-robust (3 executions) | clean | AVG: 7,117,488,480 <br /> MIN: 7,117,488,473 <br /> MAX: 7,117,488,486 | AVG: 81,040,359,080 <br /> MIN: 81,037,593,485 <br /> MAX: 81,043,519,709 | AVG: 124,099,579 <br /> MIN: 123,967,874 <br /> MAX: 124,362,934 |
| sphincs-shake256-256s-simple (3 executions) | clean | AVG: 3,764,358,451 <br /> MIN: 3,764,358,431 <br /> MAX: 3,764,358,466 | AVG: 44,857,260,081 <br /> MIN: 44,856,516,353 <br /> MAX: 44,858,138,896 | AVG: 62,264,803 <br /> MIN: 61,656,689 <br /> MAX: 62,670,229 |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| bikel1 | m4f | 44,084 | 32,132 | 91,384 |
| bikel1 | opt | 36,000 | 25,908 | 78,588 |
| hqc-rmrs-128 | clean | 48,852 | 64,436 | 71,172 |
| kyber1024 | clean | 15,100 | 18,772 | 20,348 |
| kyber1024 | m4fspeed | 6,400 | 7,496 | 7,512 |
| kyber1024 | m4fstack | 3,296 | 3,368 | 3,392 |
| kyber1024-90s | clean | 15,364 | 19,044 | 20,620 |
| kyber1024-90s | m4fspeed | 7,156 | 8,252 | 8,268 |
| kyber1024-90s | m4fstack | 4,060 | 4,132 | 4,156 |
| kyber512 | clean | 6,116 | 8,780 | 9,556 |
| kyber512 | m4fspeed | 4,320 | 5,424 | 5,432 |
| kyber512 | m4fstack | 2,248 | 2,336 | 2,352 |
| kyber512-90s | clean | 6,572 | 9,236 | 10,012 |
| kyber512-90s | m4fspeed | 5,076 | 6,180 | 6,188 |
| kyber512-90s | m4fstack | 3,012 | 3,100 | 3,116 |
| kyber768 | clean | 10,212 | 13,380 | 14,476 |
| kyber768 | m4fspeed | 5,344 | 6,456 | 6,472 |
| kyber768 | m4fstack | 2,784 | 2,856 | 2,872 |
| kyber768-90s | clean | 10,676 | 13,844 | 14,940 |
| kyber768-90s | m4fspeed | 6,108 | 7,220 | 7,236 |
| kyber768-90s | m4fstack | 3,540 | 3,612 | 3,628 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| dilithium2 | clean | 38,308 | 51,932 | 36,220 |
| dilithium2 | m4f | 38,408 | 49,380 | 36,212 |
| dilithium2aes | clean | 39,776 | 53,400 | 37,688 |
| dilithium3 | clean | 60,844 | 79,588 | 57,732 |
| dilithium3 | m4f | 60,836 | 68,836 | 57,724 |
| dilithium3aes | clean | 62,312 | 81,056 | 59,200 |
| dilithium5 | m4f | 97,692 | 115,932 | 92,788 |
| falcon-1024 | clean | 36,296 | 82,532 | 8,820 |
| falcon-1024 | m4-ct | 1,400 | 2,644 | 412 |
| falcon-1024 | opt-ct | 1,384 | 2,644 | 520 |
| falcon-1024 | opt-leaktime | 1,368 | 2,716 | 412 |
| falcon-512 | clean | 18,416 | 42,508 | 4,724 |
| falcon-512 | m4-ct | 1,312 | 2,556 | 412 |
| falcon-512 | opt-ct | 1,344 | 2,556 | 412 |
| falcon-512 | opt-leaktime | 1,296 | 2,620 | 412 |
| falcon-512-tree | m4-ct | 1,408 | 2,796 | 412 |
| falcon-512-tree | opt-ct | 1,384 | 2,796 | 412 |
| falcon-512-tree | opt-leaktime | 1,344 | 2,804 | 412 |
| sphincs-haraka-128f-robust | clean | 3,636 | 3,728 | 4,188 |
| sphincs-haraka-128f-simple | clean | 3,628 | 3,720 | 4,180 |
| sphincs-haraka-128s-robust | clean | 3,960 | 3,920 | 3,492 |
| sphincs-haraka-128s-simple | clean | 3,872 | 3,912 | 3,484 |
| sphincs-haraka-192f-robust | clean | 5,044 | 5,192 | 5,412 |
| sphincs-haraka-192f-simple | clean | 5,064 | 5,184 | 5,404 |
| sphincs-haraka-192s-robust | clean | 5,392 | 5,352 | 4,748 |
| sphincs-haraka-192s-simple | clean | 5,456 | 5,344 | 4,740 |
| sphincs-haraka-256f-robust | clean | 7,044 | 7,120 | 7,020 |
| sphincs-haraka-256f-simple | clean | 7,036 | 7,032 | 7,012 |
| sphincs-haraka-256s-robust | clean | 7,424 | 7,264 | 6,640 |
| sphincs-haraka-256s-simple | clean | 7,416 | 7,256 | 6,632 |
| sphincs-sha256-128f-robust | clean | 2,276 | 2,340 | 2,828 |
| sphincs-sha256-128f-simple | clean | 2,124 | 2,188 | 2,676 |
| sphincs-sha256-128s-robust | clean | 2,492 | 2,560 | 2,132 |
| sphincs-sha256-128s-simple | clean | 2,340 | 2,408 | 1,980 |
| sphincs-sha256-192f-robust | clean | 3,692 | 3,840 | 4,060 |
| sphincs-sha256-192f-simple | clean | 3,532 | 3,680 | 3,900 |
| sphincs-sha256-192s-robust | clean | 4,004 | 4,000 | 3,396 |
| sphincs-sha256-192s-simple | clean | 3,952 | 3,840 | 3,236 |
| sphincs-sha256-256f-robust | clean | 5,700 | 5,776 | 5,676 |
| sphincs-sha256-256f-simple | clean | 5,532 | 5,500 | 5,508 |
| sphincs-sha256-256s-robust | clean | 6,080 | 5,920 | 5,268 |
| sphincs-sha256-256s-simple | clean | 5,804 | 5,752 | 5,100 |
| sphincs-shake256-128f-robust | clean | 2,036 | 2,200 | 2,580 |
| sphincs-shake256-128f-simple | clean | 2,036 | 2,092 | 2,580 |
| sphincs-shake256-128s-robust | clean | 2,360 | 2,312 | 1,896 |
| sphincs-shake256-128s-simple | clean | 2,360 | 2,312 | 1,884 |
| sphincs-shake256-192f-robust | clean | 3,452 | 3,592 | 3,812 |
| sphincs-shake256-192f-simple | clean | 3,452 | 3,484 | 3,812 |
| sphincs-shake256-192s-robust | clean | 3,872 | 3,752 | 3,148 |
| sphincs-shake256-192s-simple | clean | 3,872 | 3,752 | 3,148 |
| sphincs-shake256-256f-robust | clean | 5,460 | 5,528 | 5,428 |
| sphincs-shake256-256f-simple | clean | 5,460 | 5,528 | 5,428 |
| sphincs-shake256-256s-robust | clean | 5,840 | 5,672 | 5,020 |
| sphincs-shake256-256s-simple | clean | 5,840 | 5,672 | 5,020 |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| bikel1 | m4f | 0.7% | 15.1% | 1.0% |
| bikel1 | opt | 0.3% | 10.1% | 0.4% |
| hqc-rmrs-128 | clean | 54.7% | 42.3% | 33.8% |
| kyber1024 | clean | 54.0% | 53.6% | 42.5% |
| kyber1024 | m4fspeed | 79.1% | 81.9% | 75.6% |
| kyber1024 | m4fstack | 78.8% | 81.4% | 75.0% |
| kyber1024-90s | clean | 73.6% | 70.4% | 63.8% |
| kyber1024-90s | m4fspeed | 70.7% | 72.9% | 67.5% |
| kyber1024-90s | m4fstack | 70.2% | 72.2% | 66.8% |
| kyber512 | clean | 54.3% | 51.6% | 36.9% |
| kyber512 | m4fspeed | 79.4% | 82.0% | 72.7% |
| kyber512 | m4fstack | 79.4% | 81.7% | 72.4% |
| kyber512-90s | clean | 68.4% | 62.6% | 52.5% |
| kyber512-90s | m4fspeed | 72.2% | 74.2% | 66.2% |
| kyber512-90s | m4fstack | 72.1% | 73.8% | 65.7% |
| kyber768 | clean | 52.4% | 52.3% | 39.5% |
| kyber768 | m4fspeed | 78.4% | 81.8% | 74.0% |
| kyber768 | m4fstack | 78.3% | 81.3% | 73.5% |
| kyber768-90s | clean | 71.2% | 67.3% | 59.3% |
| kyber768-90s | m4fspeed | 70.6% | 73.1% | 66.5% |
| kyber768-90s | m4fstack | 70.3% | 72.5% | 65.9% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| dilithium2 | clean | 68.2% | 38.8% | 61.4% |
| dilithium2 | m4f | 82.8% | 65.5% | 80.5% |
| dilithium2aes | clean | 2.8% | 3.6% | 5.2% |
| dilithium3 | clean | 71.6% | 38.7% | 64.9% |
| dilithium3 | m4f | 85.0% | 64.8% | 82.6% |
| dilithium3aes | clean | 2.3% | 2.4% | 3.7% |
| dilithium5 | m4f | 86.0% | 69.2% | 84.5% |
| falcon-1024 | clean | 8.2% | 0.3% | 26.9% |
| falcon-1024 | m4-ct | 11.0% | 0.5% | 34.0% |
| falcon-1024 | opt-ct | 11.0% | 0.5% | 34.0% |
| falcon-1024 | opt-leaktime | 12.8% | 0.5% | 34.0% |
| falcon-512 | clean | 13.1% | 0.4% | 29.3% |
| falcon-512 | m4-ct | 18.3% | 0.5% | 35.7% |
| falcon-512 | opt-ct | 18.3% | 0.5% | 35.7% |
| falcon-512 | opt-leaktime | 19.6% | 0.6% | 35.8% |
| falcon-512-tree | m4-ct | 15.9% | 1.2% | 35.7% |
| falcon-512-tree | opt-ct | 16.2% | 1.2% | 35.6% |
| falcon-512-tree | opt-leaktime | 16.8% | 1.1% | 35.9% |
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
| sphincs-sha256-128f-robust | clean | 87.7% | 87.7% | 87.8% |
| sphincs-sha256-128f-simple | clean | 85.3% | 85.2% | 85.1% |
| sphincs-sha256-128s-robust | clean | 87.7% | 87.6% | 87.7% |
| sphincs-sha256-128s-simple | clean | 85.3% | 85.1% | 85.0% |
| sphincs-sha256-192f-robust | clean | 87.2% | 87.4% | 87.6% |
| sphincs-sha256-192f-simple | clean | 84.9% | 85.1% | 85.1% |
| sphincs-sha256-192s-robust | clean | 87.3% | 87.5% | 87.9% |
| sphincs-sha256-192s-simple | clean | 84.9% | 85.2% | 85.6% |
| sphincs-sha256-256f-robust | clean | 90.9% | 91.0% | 91.3% |
| sphincs-sha256-256f-simple | clean | 84.6% | 84.8% | 84.9% |
| sphincs-sha256-256s-robust | clean | 91.1% | 91.1% | 91.6% |
| sphincs-sha256-256s-simple | clean | 84.9% | 85.4% | 85.6% |
| sphincs-shake256-128f-robust | clean | 97.4% | 97.4% | 97.5% |
| sphincs-shake256-128f-simple | clean | 95.7% | 95.7% | 95.7% |
| sphincs-shake256-128s-robust | clean | 97.5% | 97.4% | 97.4% |
| sphincs-shake256-128s-simple | clean | 95.7% | 95.7% | 95.6% |
| sphincs-shake256-192f-robust | clean | 97.4% | 97.3% | 97.4% |
| sphincs-shake256-192f-simple | clean | 95.7% | 95.6% | 95.6% |
| sphincs-shake256-192s-robust | clean | 97.4% | 97.3% | 97.4% |
| sphincs-shake256-192s-simple | clean | 95.7% | 95.6% | 95.6% |
| sphincs-shake256-256f-robust | clean | 97.4% | 97.3% | 97.4% |
| sphincs-shake256-256f-simple | clean | 95.6% | 95.6% | 95.6% |
| sphincs-shake256-256s-robust | clean | 97.4% | 97.2% | 97.4% |
| sphincs-shake256-256s-simple | clean | 95.7% | 95.6% | 95.6% |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| bikel1 | m4f | 177,664 | 24 | 49 | 177,737 |
| bikel1 | opt | 34,947 | 24 | 1 | 34,972 |
| hqc-rmrs-128 | clean | 17,116 | 0 | 0 | 17,116 |
| kyber1024 | clean | 6,068 | 0 | 0 | 6,068 |
| kyber1024 | m4fspeed | 16,496 | 0 | 0 | 16,496 |
| kyber1024 | m4fstack | 13,752 | 0 | 0 | 13,752 |
| kyber1024-90s | clean | 6,424 | 0 | 0 | 6,424 |
| kyber1024-90s | m4fspeed | 16,948 | 0 | 0 | 16,948 |
| kyber1024-90s | m4fstack | 13,996 | 0 | 0 | 13,996 |
| kyber512 | clean | 4,872 | 0 | 0 | 4,872 |
| kyber512 | m4fspeed | 15,332 | 0 | 0 | 15,332 |
| kyber512 | m4fstack | 12,820 | 0 | 0 | 12,820 |
| kyber512-90s | clean | 5,088 | 0 | 0 | 5,088 |
| kyber512-90s | m4fspeed | 15,784 | 0 | 0 | 15,784 |
| kyber512-90s | m4fstack | 13,052 | 0 | 0 | 13,052 |
| kyber768 | clean | 4,888 | 0 | 0 | 4,888 |
| kyber768 | m4fspeed | 15,540 | 0 | 0 | 15,540 |
| kyber768 | m4fstack | 12,836 | 0 | 0 | 12,836 |
| kyber768-90s | clean | 5,120 | 0 | 0 | 5,120 |
| kyber768-90s | m4fspeed | 16,000 | 0 | 0 | 16,000 |
| kyber768-90s | m4fstack | 13,068 | 0 | 0 | 13,068 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| dilithium2 | clean | 7,888 | 0 | 0 | 7,888 |
| dilithium2 | m4f | 18,480 | 0 | 0 | 18,480 |
| dilithium2aes | clean | 14,954 | 0 | 0 | 14,954 |
| dilithium3 | clean | 7,384 | 0 | 0 | 7,384 |
| dilithium3 | m4f | 19,924 | 0 | 0 | 19,924 |
| dilithium3aes | clean | 14,442 | 0 | 0 | 14,442 |
| dilithium5 | m4f | 18,248 | 0 | 0 | 18,248 |
| falcon-1024 | clean | 82,281 | 0 | 0 | 82,281 |
| falcon-1024 | m4-ct | 83,069 | 0 | 79,872 | 162,941 |
| falcon-1024 | opt-ct | 83,069 | 0 | 79,872 | 162,941 |
| falcon-1024 | opt-leaktime | 76,261 | 0 | 79,872 | 156,133 |
| falcon-512 | clean | 82,249 | 0 | 0 | 82,249 |
| falcon-512 | m4-ct | 83,069 | 0 | 39,936 | 123,005 |
| falcon-512 | opt-ct | 83,069 | 0 | 39,936 | 123,005 |
| falcon-512 | opt-leaktime | 76,261 | 0 | 39,936 | 116,197 |
| falcon-512-tree | m4-ct | 82,821 | 0 | 27,648 | 110,469 |
| falcon-512-tree | opt-ct | 82,821 | 0 | 27,648 | 110,469 |
| falcon-512-tree | opt-leaktime | 76,013 | 0 | 27,648 | 103,661 |
| sphincs-haraka-128f-robust | clean | 16,428 | 0 | 0 | 16,428 |
| sphincs-haraka-128f-simple | clean | 16,276 | 0 | 0 | 16,276 |
| sphincs-haraka-128s-robust | clean | 16,700 | 0 | 0 | 16,700 |
| sphincs-haraka-128s-simple | clean | 16,552 | 0 | 0 | 16,552 |
| sphincs-haraka-192f-robust | clean | 16,484 | 0 | 0 | 16,484 |
| sphincs-haraka-192f-simple | clean | 16,300 | 0 | 0 | 16,300 |
| sphincs-haraka-192s-robust | clean | 17,020 | 0 | 0 | 17,020 |
| sphincs-haraka-192s-simple | clean | 16,836 | 0 | 0 | 16,836 |
| sphincs-haraka-256f-robust | clean | 16,868 | 0 | 0 | 16,868 |
| sphincs-haraka-256f-simple | clean | 16,624 | 0 | 0 | 16,624 |
| sphincs-haraka-256s-robust | clean | 17,196 | 0 | 0 | 17,196 |
| sphincs-haraka-256s-simple | clean | 16,952 | 0 | 0 | 16,952 |
| sphincs-sha256-128f-robust | clean | 4,740 | 0 | 0 | 4,740 |
| sphincs-sha256-128f-simple | clean | 4,504 | 0 | 0 | 4,504 |
| sphincs-sha256-128s-robust | clean | 5,012 | 0 | 0 | 5,012 |
| sphincs-sha256-128s-simple | clean | 4,776 | 0 | 0 | 4,776 |
| sphincs-sha256-192f-robust | clean | 5,020 | 0 | 0 | 5,020 |
| sphincs-sha256-192f-simple | clean | 4,668 | 0 | 0 | 4,668 |
| sphincs-sha256-192s-robust | clean | 5,564 | 0 | 0 | 5,564 |
| sphincs-sha256-192s-simple | clean | 5,208 | 0 | 0 | 5,208 |
| sphincs-sha256-256f-robust | clean | 5,488 | 0 | 0 | 5,488 |
| sphincs-sha256-256f-simple | clean | 5,048 | 0 | 0 | 5,048 |
| sphincs-sha256-256s-robust | clean | 5,812 | 0 | 0 | 5,812 |
| sphincs-sha256-256s-simple | clean | 5,368 | 0 | 0 | 5,368 |
| sphincs-shake256-128f-robust | clean | 4,024 | 0 | 0 | 4,024 |
| sphincs-shake256-128f-simple | clean | 3,884 | 0 | 0 | 3,884 |
| sphincs-shake256-128s-robust | clean | 4,296 | 0 | 0 | 4,296 |
| sphincs-shake256-128s-simple | clean | 4,152 | 0 | 0 | 4,152 |
| sphincs-shake256-192f-robust | clean | 4,124 | 0 | 0 | 4,124 |
| sphincs-shake256-192f-simple | clean | 3,952 | 0 | 0 | 3,952 |
| sphincs-shake256-192s-robust | clean | 4,660 | 0 | 0 | 4,660 |
| sphincs-shake256-192s-simple | clean | 4,488 | 0 | 0 | 4,488 |
| sphincs-shake256-256f-robust | clean | 4,520 | 0 | 0 | 4,520 |
| sphincs-shake256-256f-simple | clean | 4,308 | 0 | 0 | 4,308 |
| sphincs-shake256-256s-robust | clean | 4,844 | 0 | 0 | 4,844 |
| sphincs-shake256-256s-simple | clean | 4,636 | 0 | 0 | 4,636 |
