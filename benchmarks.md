# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| bikel1 (100 executions) | m4f | AVG: 25,070,739 <br /> MIN: 25,047,564 <br /> MAX: 25,088,572 | AVG: 3,397,213 <br /> MIN: 3,380,225 <br /> MAX: 3,418,051 | AVG: 50,059,790 <br /> MIN: 50,042,788 <br /> MAX: 50,080,604 |
| bikel1 (100 executions) | opt | AVG: 65,550,348 <br /> MIN: 65,532,113 <br /> MAX: 65,577,439 | AVG: 4,961,328 <br /> MIN: 4,945,330 <br /> MAX: 4,981,466 | AVG: 114,729,824 <br /> MIN: 114,713,904 <br /> MAX: 114,749,929 |
| firesaber (100 executions) | clean | AVG: 3,724,997 <br /> MIN: 3,724,997 <br /> MAX: 3,724,997 | AVG: 4,623,896 <br /> MIN: 4,623,896 <br /> MAX: 4,623,896 | AVG: 5,238,458 <br /> MIN: 5,238,458 <br /> MAX: 5,238,458 |
| firesaber (100 executions) | m4f | AVG: 1,002,430 <br /> MIN: 1,002,430 <br /> MAX: 1,002,430 | AVG: 1,214,469 <br /> MIN: 1,214,469 <br /> MAX: 1,214,469 | AVG: 1,167,203 <br /> MIN: 1,167,203 <br /> MAX: 1,167,203 |
| frodokem640aes (100 executions) | m4 | AVG: 48,346,481 <br /> MIN: 48,346,481 <br /> MAX: 48,346,481 | AVG: 47,131,526 <br /> MIN: 47,131,526 <br /> MAX: 47,131,526 | AVG: 46,601,827 <br /> MIN: 46,601,827 <br /> MAX: 46,601,827 |
| frodokem640shake (100 executions) | m4 | AVG: 77,447,284 <br /> MIN: 77,447,284 <br /> MAX: 77,447,284 | AVG: 78,906,283 <br /> MIN: 78,906,283 <br /> MAX: 78,906,283 | AVG: 78,355,428 <br /> MIN: 78,355,428 <br /> MAX: 78,355,428 |
| frodokem640shake (100 executions) | opt | AVG: 91,075,486 <br /> MIN: 91,075,486 <br /> MAX: 91,075,486 | AVG: 104,149,387 <br /> MIN: 104,149,387 <br /> MAX: 104,149,387 | AVG: 103,855,521 <br /> MIN: 103,855,521 <br /> MAX: 103,855,521 |
| hqc-rmrs-128 (100 executions) | clean | AVG: 2,966,161 <br /> MIN: 2,927,452 <br /> MAX: 3,155,724 | AVG: 5,378,879 <br /> MIN: 5,324,609 <br /> MAX: 5,589,240 | AVG: 7,812,032 <br /> MIN: 7,718,725 <br /> MAX: 8,075,300 |
| kyber1024 (100 executions) | clean | AVG: 1,639,631 <br /> MIN: 1,635,622 <br /> MAX: 1,662,531 | AVG: 2,012,891 <br /> MIN: 2,008,880 <br /> MAX: 2,035,803 | AVG: 2,151,025 <br /> MIN: 2,147,014 <br /> MAX: 2,173,937 |
| kyber1024 (100 executions) | m4 | AVG: 1,196,251 <br /> MIN: 1,193,148 <br /> MAX: 1,208,087 | AVG: 1,382,600 <br /> MIN: 1,379,661 <br /> MAX: 1,394,331 | AVG: 1,304,206 <br /> MIN: 1,301,267 <br /> MAX: 1,315,937 |
| kyber1024-90s (100 executions) | clean | AVG: 3,001,555 <br /> MIN: 3,000,189 <br /> MAX: 3,016,962 | AVG: 3,277,396 <br /> MIN: 3,276,032 <br /> MAX: 3,292,791 | AVG: 3,510,655 <br /> MIN: 3,509,291 <br /> MAX: 3,526,050 |
| kyber1024-90s (100 executions) | m4 | AVG: 1,039,985 <br /> MIN: 1,032,544 <br /> MAX: 1,044,994 | AVG: 1,137,394 <br /> MIN: 1,129,926 <br /> MAX: 1,142,380 | AVG: 1,154,090 <br /> MIN: 1,146,622 <br /> MAX: 1,159,076 |
| kyber512 (100 executions) | clean | AVG: 631,526 <br /> MIN: 630,728 <br /> MAX: 644,093 | AVG: 843,042 <br /> MIN: 842,244 <br /> MAX: 855,609 | AVG: 936,959 <br /> MIN: 936,161 <br /> MAX: 949,526 |
| kyber512 (100 executions) | m4 | AVG: 455,441 <br /> MIN: 454,611 <br /> MAX: 467,942 | AVG: 555,947 <br /> MIN: 555,116 <br /> MAX: 568,448 | AVG: 516,170 <br /> MIN: 515,339 <br /> MAX: 528,671 |
| kyber512-90s (100 executions) | clean | AVG: 945,098 <br /> MIN: 944,671 <br /> MAX: 945,545 | AVG: 1,114,732 <br /> MIN: 1,114,305 <br /> MAX: 1,115,179 | AVG: 1,259,733 <br /> MIN: 1,259,306 <br /> MAX: 1,260,180 |
| kyber512-90s (100 executions) | m4 | AVG: 390,809 <br /> MIN: 386,747 <br /> MAX: 395,007 | AVG: 449,428 <br /> MIN: 445,366 <br /> MAX: 453,626 | AVG: 460,732 <br /> MIN: 456,670 <br /> MAX: 464,930 |
| kyber768 (100 executions) | clean | AVG: 1,049,095 <br /> MIN: 1,047,718 <br /> MAX: 1,061,626 | AVG: 1,347,653 <br /> MIN: 1,346,276 <br /> MAX: 1,360,184 | AVG: 1,461,991 <br /> MIN: 1,460,614 <br /> MAX: 1,474,522 |
| kyber768 (100 executions) | m4 | AVG: 751,487 <br /> MIN: 749,643 <br /> MAX: 763,599 | AVG: 907,348 <br /> MIN: 905,512 <br /> MAX: 919,453 | AVG: 847,584 <br /> MIN: 845,748 <br /> MAX: 859,689 |
| kyber768-90s (100 executions) | clean | AVG: 1,813,146 <br /> MIN: 1,812,111 <br /> MAX: 1,828,455 | AVG: 2,036,376 <br /> MIN: 2,035,341 <br /> MAX: 2,051,685 | AVG: 2,223,802 <br /> MIN: 2,222,767 <br /> MAX: 2,239,111 |
| kyber768-90s (100 executions) | m4 | AVG: 661,310 <br /> MIN: 656,781 <br /> MAX: 665,749 | AVG: 741,792 <br /> MIN: 737,263 <br /> MAX: 746,231 | AVG: 755,115 <br /> MIN: 750,586 <br /> MAX: 759,554 |
| lightsaber (100 executions) | clean | AVG: 1,023,220 <br /> MIN: 1,023,220 <br /> MAX: 1,023,220 | AVG: 1,494,630 <br /> MIN: 1,494,630 <br /> MAX: 1,494,630 | AVG: 1,805,783 <br /> MIN: 1,805,783 <br /> MAX: 1,805,783 |
| lightsaber (100 executions) | m4f | AVG: 355,058 <br /> MIN: 355,058 <br /> MAX: 355,058 | AVG: 484,733 <br /> MIN: 484,733 <br /> MAX: 484,733 | AVG: 460,133 <br /> MIN: 460,133 <br /> MAX: 460,133 |
| ntruhps2048509 (100 executions) | clean | AVG: 68,756,837 <br /> MIN: 68,756,837 <br /> MAX: 68,756,837 | AVG: 1,062,050 <br /> MIN: 1,062,050 <br /> MAX: 1,062,050 | AVG: 2,433,557 <br /> MIN: 2,433,557 <br /> MAX: 2,433,557 |
| ntruhps2048509 (100 executions) | m4f | AVG: 79,658,904 <br /> MIN: 79,658,904 <br /> MAX: 79,658,904 | AVG: 563,499 <br /> MIN: 563,499 <br /> MAX: 563,499 | AVG: 536,107 <br /> MIN: 536,107 <br /> MAX: 536,107 |
| ntruhps2048677 (100 executions) | clean | AVG: 122,979,463 <br /> MIN: 122,979,463 <br /> MAX: 122,979,463 | AVG: 1,795,198 <br /> MIN: 1,795,198 <br /> MAX: 1,795,198 | AVG: 4,285,233 <br /> MIN: 4,285,233 <br /> MAX: 4,285,233 |
| ntruhps2048677 (100 executions) | m4f | AVG: 143,734,165 <br /> MIN: 143,734,165 <br /> MAX: 143,734,165 | AVG: 820,153 <br /> MIN: 820,153 <br /> MAX: 820,153 | AVG: 812,273 <br /> MIN: 812,273 <br /> MAX: 812,273 |
| ntruhps4096821 (100 executions) | clean | AVG: 181,263,287 <br /> MIN: 181,263,287 <br /> MAX: 181,263,287 | AVG: 2,346,238 <br /> MIN: 2,346,238 <br /> MAX: 2,346,238 | AVG: 5,666,273 <br /> MIN: 5,666,273 <br /> MAX: 5,666,273 |
| ntruhps4096821 (100 executions) | m4f | AVG: 208,836,269 <br /> MIN: 208,836,269 <br /> MAX: 208,836,269 | AVG: 1,027,435 <br /> MIN: 1,027,435 <br /> MAX: 1,027,435 | AVG: 1,030,713 <br /> MIN: 1,030,713 <br /> MAX: 1,030,713 |
| ntruhrss701 (100 executions) | clean | AVG: 132,453,629 <br /> MIN: 132,453,629 <br /> MAX: 132,453,629 | AVG: 1,509,081 <br /> MIN: 1,509,081 <br /> MAX: 1,509,081 | AVG: 4,345,484 <br /> MIN: 4,345,484 <br /> MAX: 4,345,484 |
| ntruhrss701 (100 executions) | m4f | AVG: 153,104,410 <br /> MIN: 153,104,410 <br /> MAX: 153,104,410 | AVG: 375,974 <br /> MIN: 375,974 <br /> MAX: 375,974 | AVG: 867,459 <br /> MIN: 867,459 <br /> MAX: 867,459 |
| ntrulpr653 (100 executions) | clean | AVG: 4,261,295 <br /> MIN: 4,261,295 <br /> MAX: 4,261,295 | AVG: 8,149,361 <br /> MIN: 8,149,361 <br /> MAX: 8,149,361 | AVG: 11,600,821 <br /> MIN: 11,600,821 <br /> MAX: 11,600,821 |
| ntrulpr761 (100 executions) | clean | AVG: 5,637,569 <br /> MIN: 5,637,569 <br /> MAX: 5,637,569 | AVG: 10,817,077 <br /> MIN: 10,817,077 <br /> MAX: 10,817,077 | AVG: 15,498,054 <br /> MIN: 15,498,054 <br /> MAX: 15,498,054 |
| ntrulpr761 (100 executions) | m4f | AVG: 736,506 <br /> MIN: 736,506 <br /> MAX: 736,506 | AVG: 1,292,342 <br /> MIN: 1,292,342 <br /> MAX: 1,292,342 | AVG: 1,385,467 <br /> MIN: 1,385,467 <br /> MAX: 1,385,467 |
| ntrulpr857 (100 executions) | clean | AVG: 7,009,465 <br /> MIN: 7,009,465 <br /> MAX: 7,009,465 | AVG: 13,491,411 <br /> MIN: 13,491,411 <br /> MAX: 13,491,411 | AVG: 19,423,047 <br /> MIN: 19,423,047 <br /> MAX: 19,423,047 |
| saber (100 executions) | clean | AVG: 2,136,096 <br /> MIN: 2,136,096 <br /> MAX: 2,136,096 | AVG: 2,812,895 <br /> MIN: 2,812,895 <br /> MAX: 2,812,895 | AVG: 3,280,174 <br /> MIN: 3,280,174 <br /> MAX: 3,280,174 |
| saber (100 executions) | m4f | AVG: 651,697 <br /> MIN: 651,697 <br /> MAX: 651,697 | AVG: 828,435 <br /> MIN: 828,435 <br /> MAX: 828,435 | AVG: 786,349 <br /> MIN: 786,349 <br /> MAX: 786,349 |
| sikep434 (1 executions) | m4 | AVG: 48,264,134 <br /> MIN: 48,264,134 <br /> MAX: 48,264,134 | AVG: 78,908,984 <br /> MIN: 78,908,984 <br /> MAX: 78,908,984 | AVG: 84,274,632 <br /> MIN: 84,274,632 <br /> MAX: 84,274,632 |
| sikep434 (1 executions) | opt | AVG: 643,285,957 <br /> MIN: 643,285,957 <br /> MAX: 643,285,957 | AVG: 1,053,596,894 <br /> MIN: 1,053,596,894 <br /> MAX: 1,053,596,894 | AVG: 1,123,750,465 <br /> MIN: 1,123,750,465 <br /> MAX: 1,123,750,465 |
| sikep503 (1 executions) | m4 | AVG: 67,365,372 <br /> MIN: 67,365,372 <br /> MAX: 67,365,372 | AVG: 110,843,674 <br /> MIN: 110,843,674 <br /> MAX: 110,843,674 | AVG: 117,991,005 <br /> MIN: 117,991,005 <br /> MAX: 117,991,005 |
| sikep503 (1 executions) | opt | AVG: 972,881,218 <br /> MIN: 972,881,218 <br /> MAX: 972,881,218 | AVG: 1,603,112,960 <br /> MIN: 1,603,112,960 <br /> MAX: 1,603,112,960 | AVG: 1,704,855,601 <br /> MIN: 1,704,855,601 <br /> MAX: 1,704,855,601 |
| sikep610 (1 executions) | m4 | AVG: 119,480,644 <br /> MIN: 119,480,644 <br /> MAX: 119,480,644 | AVG: 219,629,402 <br /> MIN: 219,629,402 <br /> MAX: 219,629,402 | AVG: 221,027,330 <br /> MIN: 221,027,330 <br /> MAX: 221,027,330 |
| sikep610 (1 executions) | opt | AVG: 1,816,217,327 <br /> MIN: 1,816,217,327 <br /> MAX: 1,816,217,327 | AVG: 3,341,631,313 <br /> MIN: 3,341,631,313 <br /> MAX: 3,341,631,313 | AVG: 3,361,412,879 <br /> MIN: 3,361,412,879 <br /> MAX: 3,361,412,879 |
| sikep751 (1 executions) | m4 | AVG: 204,646,704 <br /> MIN: 204,646,704 <br /> MAX: 204,646,704 | AVG: 331,931,929 <br /> MIN: 331,931,929 <br /> MAX: 331,931,929 | AVG: 356,423,657 <br /> MIN: 356,423,657 <br /> MAX: 356,423,657 |
| sikep751 (1 executions) | opt | AVG: 3,289,104,172 <br /> MIN: 3,289,104,172 <br /> MAX: 3,289,104,172 | AVG: 5,334,202,259 <br /> MIN: 5,334,202,259 <br /> MAX: 5,334,202,259 | AVG: 5,729,505,288 <br /> MIN: 5,729,505,288 <br /> MAX: 5,729,505,288 |
| sntrup653 (100 executions) | clean | AVG: 107,405,469 <br /> MIN: 105,063,567 <br /> MAX: 144,095,282 | AVG: 4,058,274 <br /> MIN: 4,058,274 <br /> MAX: 4,058,274 | AVG: 11,719,058 <br /> MIN: 11,719,058 <br /> MAX: 11,719,059 |
| sntrup761 (100 executions) | clean | AVG: 140,173,342 <br /> MIN: 140,173,342 <br /> MAX: 140,173,342 | AVG: 5,393,588 <br /> MIN: 5,393,588 <br /> MAX: 5,393,588 | AVG: 15,823,569 <br /> MIN: 15,823,569 <br /> MAX: 15,823,569 |
| sntrup761 (100 executions) | m4f | AVG: 10,831,090 <br /> MIN: 10,831,090 <br /> MAX: 10,831,090 | AVG: 698,943 <br /> MIN: 698,943 <br /> MAX: 698,943 | AVG: 565,268 <br /> MIN: 565,268 <br /> MAX: 565,268 |
| sntrup857 (100 executions) | clean | AVG: 177,605,105 <br /> MIN: 177,605,105 <br /> MAX: 177,605,105 | AVG: 6,739,718 <br /> MIN: 6,739,718 <br /> MAX: 6,739,718 | AVG: 19,262,019 <br /> MIN: 19,262,019 <br /> MAX: 19,262,019 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| dilithium2 (100 executions) | clean | AVG: 1,975,279 <br /> MIN: 1,921,770 <br /> MAX: 2,010,588 | AVG: 7,170,340 <br /> MIN: 3,240,726 <br /> MAX: 23,429,095 | AVG: 2,109,422 <br /> MIN: 2,108,990 <br /> MAX: 2,109,763 |
| dilithium2 (100 executions) | m4 | AVG: 1,600,809 <br /> MIN: 1,547,421 <br /> MAX: 1,648,907 | AVG: 4,207,602 <br /> MIN: 2,029,358 <br /> MAX: 14,968,504 | AVG: 1,578,514 <br /> MIN: 1,578,139 <br /> MAX: 1,578,904 |
| dilithium2aes (100 executions) | clean | AVG: 5,148,731 <br /> MIN: 5,090,658 <br /> MAX: 5,209,097 | AVG: 12,718,320 <br /> MIN: 6,389,923 <br /> MAX: 66,895,489 | AVG: 4,819,539 <br /> MIN: 4,761,415 <br /> MAX: 4,880,141 |
| dilithium3 (100 executions) | clean | AVG: 3,415,237 <br /> MIN: 3,414,276 <br /> MAX: 3,416,697 | AVG: 12,586,899 <br /> MIN: 5,038,683 <br /> MAX: 89,476,401 | AVG: 3,499,530 <br /> MIN: 3,499,124 <br /> MAX: 3,499,843 |
| dilithium3 (100 executions) | m4 | AVG: 2,835,417 <br /> MIN: 2,834,255 <br /> MAX: 2,836,490 | AVG: 6,386,989 <br /> MIN: 3,286,023 <br /> MAX: 22,539,544 | AVG: 2,700,031 <br /> MIN: 2,699,655 <br /> MAX: 2,700,389 |
| dilithium3aes (100 executions) | clean | AVG: 9,263,203 <br /> MIN: 9,180,641 <br /> MAX: 9,384,111 | AVG: 20,937,197 <br /> MIN: 10,725,528 <br /> MAX: 58,225,793 | AVG: 8,587,681 <br /> MIN: 8,505,770 <br /> MAX: 8,708,887 |
| falcon-1024 (100 executions) | clean | AVG: 613,493,213 <br /> MIN: 338,190,520 <br /> MAX: 1,433,610,022 | AVG: 133,608,249 <br /> MIN: 133,247,333 <br /> MAX: 134,008,063 | AVG: 1,527,183 <br /> MIN: 1,526,425 <br /> MAX: 1,527,836 |
| falcon-1024 (100 executions) | m4-ct | AVG: 461,278,532 <br /> MIN: 273,257,439 <br /> MAX: 1,324,184,068 | AVG: 85,062,972 <br /> MIN: 84,816,972 <br /> MAX: 85,328,827 | AVG: 977,664 <br /> MIN: 967,775 <br /> MAX: 985,271 |
| falcon-1024 (100 executions) | opt-ct | AVG: 460,290,414 <br /> MIN: 273,257,439 <br /> MAX: 1,386,040,651 | AVG: 85,063,943 <br /> MIN: 84,792,792 <br /> MAX: 85,378,122 | AVG: 979,097 <br /> MIN: 967,315 <br /> MAX: 985,821 |
| falcon-1024 (100 executions) | opt-leaktime | AVG: 390,953,090 <br /> MIN: 244,960,675 <br /> MAX: 792,602,988 | AVG: 76,099,686 <br /> MIN: 75,690,808 <br /> MAX: 76,571,511 | AVG: 978,760 <br /> MIN: 966,714 <br /> MAX: 985,685 |
| falcon-512 (100 executions) | clean | AVG: 213,472,223 <br /> MIN: 130,739,222 <br /> MAX: 588,351,410 | AVG: 61,115,414 <br /> MIN: 60,885,769 <br /> MAX: 61,391,105 | AVG: 765,608 <br /> MIN: 765,258 <br /> MAX: 766,029 |
| falcon-512 (100 executions) | m4-ct | AVG: 179,426,815 <br /> MIN: 102,417,917 <br /> MAX: 591,518,379 | AVG: 38,961,010 <br /> MIN: 38,769,436 <br /> MAX: 39,124,021 | AVG: 473,834 <br /> MIN: 464,760 <br /> MAX: 480,534 |
| falcon-512 (100 executions) | opt-ct | AVG: 181,428,173 <br /> MIN: 102,417,917 <br /> MAX: 545,572,847 | AVG: 38,961,970 <br /> MIN: 38,767,693 <br /> MAX: 39,113,247 | AVG: 472,453 <br /> MIN: 464,438 <br /> MAX: 481,294 |
| falcon-512 (100 executions) | opt-leaktime | AVG: 153,155,262 <br /> MIN: 90,345,128 <br /> MAX: 430,238,536 | AVG: 35,427,605 <br /> MIN: 35,142,625 <br /> MAX: 35,771,835 | AVG: 473,079 <br /> MIN: 463,997 <br /> MAX: 481,653 |
| falcon-512-tree (100 executions) | m4-ct | AVG: 182,467,425 <br /> MIN: 117,548,598 <br /> MAX: 545,790,200 | AVG: 17,684,296 <br /> MIN: 17,508,469 <br /> MAX: 17,929,745 | AVG: 474,262 <br /> MIN: 465,075 <br /> MAX: 481,307 |
| falcon-512-tree (100 executions) | opt-ct | AVG: 186,679,945 <br /> MIN: 117,548,598 <br /> MAX: 346,168,892 | AVG: 17,678,724 <br /> MIN: 17,510,840 <br /> MAX: 17,947,805 | AVG: 473,014 <br /> MIN: 464,746 <br /> MAX: 480,416 |
| falcon-512-tree (100 executions) | opt-leaktime | AVG: 155,237,015 <br /> MIN: 101,894,150 <br /> MAX: 520,917,834 | AVG: 19,195,813 <br /> MIN: 18,916,665 <br /> MAX: 19,585,312 | AVG: 473,869 <br /> MIN: 464,256 <br /> MAX: 481,504 |
| sphincs-haraka-128f-robust (1 executions) | clean | AVG: 104,795,658 <br /> MIN: 104,795,658 <br /> MAX: 104,795,658 | AVG: 3,883,182,669 <br /> MIN: 3,883,182,669 <br /> MAX: 3,883,182,669 | AVG: 162,489,529 <br /> MIN: 162,489,529 <br /> MAX: 162,489,529 |
| sphincs-haraka-128f-simple (1 executions) | clean | AVG: 72,831,224 <br /> MIN: 72,831,224 <br /> MAX: 72,831,224 | AVG: 2,622,953,404 <br /> MIN: 2,622,953,404 <br /> MAX: 2,622,953,404 | AVG: 107,468,816 <br /> MIN: 107,468,816 <br /> MAX: 107,468,816 |
| sphincs-haraka-128s-robust (1 executions) | clean | AVG: 3,336,358,505 <br /> MIN: 3,336,358,505 <br /> MAX: 3,336,358,505 | AVG: 62,525,107,548 <br /> MIN: 62,525,107,548 <br /> MAX: 62,525,107,548 | AVG: 74,236,481 <br /> MIN: 74,236,481 <br /> MAX: 74,236,481 |
| sphincs-haraka-128s-simple (1 executions) | clean | AVG: 2,312,526,495 <br /> MIN: 2,312,526,495 <br /> MAX: 2,312,526,495 | AVG: 41,766,982,516 <br /> MIN: 41,766,982,516 <br /> MAX: 41,766,982,516 | AVG: 45,896,556 <br /> MIN: 45,896,556 <br /> MAX: 45,896,556 |
| sphincs-haraka-192f-simple (1 executions) | clean | AVG: 107,283,123 <br /> MIN: 107,283,123 <br /> MAX: 107,283,123 | AVG: 3,084,533,722 <br /> MIN: 3,084,533,722 <br /> MAX: 3,084,533,722 | AVG: 171,466,727 <br /> MIN: 171,466,727 <br /> MAX: 171,466,727 |
| sphincs-haraka-192s-robust (1 executions) | clean | AVG: 4,957,480,170 <br /> MIN: 4,957,480,170 <br /> MAX: 4,957,480,170 | AVG: 154,255,437,004 <br /> MIN: 154,255,437,004 <br /> MAX: 154,255,437,004 | AVG: 111,908,490 <br /> MIN: 111,908,490 <br /> MAX: 111,908,490 |
| sphincs-haraka-256f-robust (1 executions) | clean | AVG: 415,510,566 <br /> MIN: 415,510,566 <br /> MAX: 415,510,566 | AVG: 11,573,807,667 <br /> MIN: 11,573,807,667 <br /> MAX: 11,573,807,667 | AVG: 279,193,509 <br /> MIN: 279,193,509 <br /> MAX: 279,193,509 |
| sphincs-haraka-256f-simple (1 executions) | clean | AVG: 285,187,749 <br /> MIN: 285,187,749 <br /> MAX: 285,187,749 | AVG: 7,636,702,736 <br /> MIN: 7,636,702,736 <br /> MAX: 7,636,702,736 | AVG: 179,311,694 <br /> MIN: 179,311,694 <br /> MAX: 179,311,694 |
| sphincs-haraka-256s-simple (1 executions) | clean | AVG: 4,553,902,972 <br /> MIN: 4,553,902,972 <br /> MAX: 4,553,902,972 | AVG: 67,656,693,152 <br /> MIN: 67,656,693,152 <br /> MAX: 67,656,693,152 | AVG: 100,890,231 <br /> MIN: 100,890,231 <br /> MAX: 100,890,231 |
| sphincs-sha256-128f-robust (1 executions) | clean | AVG: 30,464,014 <br /> MIN: 30,464,014 <br /> MAX: 30,464,014 | AVG: 914,426,746 <br /> MIN: 914,426,746 <br /> MAX: 914,426,746 | AVG: 42,006,086 <br /> MIN: 42,006,086 <br /> MAX: 42,006,086 |
| sphincs-sha256-128f-simple (1 executions) | clean | AVG: 15,885,662 <br /> MIN: 15,885,662 <br /> MAX: 15,885,662 | AVG: 501,309,954 <br /> MIN: 501,309,954 <br /> MAX: 501,309,954 | AVG: 21,218,308 <br /> MIN: 21,218,308 <br /> MAX: 21,218,308 |
| sphincs-sha256-128s-robust (1 executions) | clean | AVG: 974,779,202 <br /> MIN: 974,779,202 <br /> MAX: 974,779,202 | AVG: 13,495,840,716 <br /> MIN: 13,495,840,716 <br /> MAX: 13,495,840,716 | AVG: 17,676,349 <br /> MIN: 17,676,349 <br /> MAX: 17,676,349 |
| sphincs-sha256-128s-simple (1 executions) | clean | AVG: 508,320,830 <br /> MIN: 508,320,830 <br /> MAX: 508,320,830 | AVG: 7,570,183,329 <br /> MIN: 7,570,183,329 <br /> MAX: 7,570,183,329 | AVG: 8,274,451 <br /> MIN: 8,274,451 <br /> MAX: 8,274,451 |
| sphincs-sha256-192f-robust (1 executions) | clean | AVG: 45,108,263 <br /> MIN: 45,108,263 <br /> MAX: 45,108,263 | AVG: 1,248,705,250 <br /> MIN: 1,248,705,250 <br /> MAX: 1,248,705,250 | AVG: 67,226,291 <br /> MIN: 67,226,291 <br /> MAX: 67,226,291 |
| sphincs-sha256-192f-simple (1 executions) | clean | AVG: 23,383,420 <br /> MIN: 23,383,420 <br /> MAX: 23,383,420 | AVG: 660,023,178 <br /> MIN: 660,023,178 <br /> MAX: 660,023,178 | AVG: 33,954,777 <br /> MIN: 33,954,777 <br /> MAX: 33,954,777 |
| sphincs-sha256-192s-robust (1 executions) | clean | AVG: 1,444,147,943 <br /> MIN: 1,444,147,943 <br /> MAX: 1,444,147,943 | AVG: 32,991,540,547 <br /> MIN: 32,991,540,547 <br /> MAX: 32,991,540,547 | AVG: 26,627,461 <br /> MIN: 26,627,461 <br /> MAX: 26,627,461 |
| sphincs-sha256-192s-simple (1 executions) | clean | AVG: 748,345,791 <br /> MIN: 748,345,791 <br /> MAX: 748,345,791 | AVG: 18,273,807,755 <br /> MIN: 18,273,807,755 <br /> MAX: 18,273,807,755 | AVG: 13,491,632 <br /> MIN: 13,491,632 <br /> MAX: 13,491,632 |
| sphincs-sha256-256f-robust (1 executions) | clean | AVG: 164,750,583 <br /> MIN: 164,750,583 <br /> MAX: 164,750,583 | AVG: 3,844,604,224 <br /> MIN: 3,844,604,224 <br /> MAX: 3,844,604,224 | AVG: 100,523,021 <br /> MIN: 100,523,021 <br /> MAX: 100,523,021 |
| sphincs-sha256-256f-simple (1 executions) | clean | AVG: 61,612,267 <br /> MIN: 61,612,267 <br /> MAX: 61,612,267 | AVG: 1,491,694,480 <br /> MIN: 1,491,694,480 <br /> MAX: 1,491,694,480 | AVG: 33,991,289 <br /> MIN: 33,991,289 <br /> MAX: 33,991,289 |
| sphincs-sha256-256s-robust (1 executions) | clean | AVG: 2,636,534,294 <br /> MIN: 2,636,534,294 <br /> MAX: 2,636,534,294 | AVG: 32,410,362,073 <br /> MIN: 32,410,362,073 <br /> MAX: 32,410,362,073 | AVG: 49,622,387 <br /> MIN: 49,622,387 <br /> MAX: 49,622,387 |
| sphincs-sha256-256s-simple (1 executions) | clean | AVG: 984,061,394 <br /> MIN: 984,061,394 <br /> MAX: 984,061,394 | AVG: 12,706,959,637 <br /> MIN: 12,706,959,637 <br /> MAX: 12,706,959,637 | AVG: 17,319,181 <br /> MIN: 17,319,181 <br /> MAX: 17,319,181 |
| sphincs-shake256-128f-robust (1 executions) | clean | AVG: 113,325,128 <br /> MIN: 113,325,128 <br /> MAX: 113,325,128 | AVG: 3,404,326,969 <br /> MIN: 3,404,326,969 <br /> MAX: 3,404,326,969 | AVG: 155,028,536 <br /> MIN: 155,028,536 <br /> MAX: 155,028,536 |
| sphincs-shake256-128f-simple (1 executions) | clean | AVG: 59,589,749 <br /> MIN: 59,589,749 <br /> MAX: 59,589,749 | AVG: 1,880,325,765 <br /> MIN: 1,880,325,765 <br /> MAX: 1,880,325,765 | AVG: 78,301,963 <br /> MIN: 78,301,963 <br /> MAX: 78,301,963 |
| sphincs-shake256-128s-robust (1 executions) | clean | AVG: 3,627,174,475 <br /> MIN: 3,627,174,475 <br /> MAX: 3,627,174,475 | AVG: 50,407,754,967 <br /> MIN: 50,407,754,967 <br /> MAX: 50,407,754,967 | AVG: 62,722,529 <br /> MIN: 62,722,529 <br /> MAX: 62,722,529 |
| sphincs-shake256-128s-simple (1 executions) | clean | AVG: 1,907,247,035 <br /> MIN: 1,907,247,035 <br /> MAX: 1,907,247,035 | AVG: 28,297,736,924 <br /> MIN: 28,297,736,924 <br /> MAX: 28,297,736,924 | AVG: 31,610,914 <br /> MIN: 31,610,914 <br /> MAX: 31,610,914 |
| sphincs-shake256-192f-simple (1 executions) | clean | AVG: 88,072,016 <br /> MIN: 88,072,016 <br /> MAX: 88,072,016 | AVG: 2,405,837,129 <br /> MIN: 2,405,837,129 <br /> MAX: 2,405,837,129 | AVG: 121,881,005 <br /> MIN: 121,881,005 <br /> MAX: 121,881,005 |
| sphincs-shake256-192s-simple (1 executions) | clean | AVG: 2,818,671,430 <br /> MIN: 2,818,671,430 <br /> MAX: 2,818,671,430 | AVG: 59,475,243,561 <br /> MIN: 59,475,243,561 <br /> MAX: 59,475,243,561 | AVG: 46,789,843 <br /> MIN: 46,789,843 <br /> MAX: 46,789,843 |
| sphincs-shake256-256f-robust (1 executions) | clean | AVG: 444,775,129 <br /> MIN: 444,775,129 <br /> MAX: 444,775,129 | AVG: 9,843,897,351 <br /> MIN: 9,843,897,351 <br /> MAX: 9,843,897,351 | AVG: 241,683,545 <br /> MIN: 241,683,545 <br /> MAX: 241,683,545 |
| sphincs-shake256-256f-simple (1 executions) | clean | AVG: 234,689,106 <br /> MIN: 234,689,106 <br /> MAX: 234,689,106 | AVG: 5,370,233,903 <br /> MIN: 5,370,233,903 <br /> MAX: 5,370,233,903 | AVG: 125,259,197 <br /> MIN: 125,259,197 <br /> MAX: 125,259,197 |
| sphincs-shake256-256s-robust (1 executions) | clean | AVG: 7,116,770,676 <br /> MIN: 7,116,770,676 <br /> MAX: 7,116,770,676 | AVG: 81,030,278,196 <br /> MIN: 81,030,278,196 <br /> MAX: 81,030,278,196 | AVG: 121,576,965 <br /> MIN: 121,576,965 <br /> MAX: 121,576,965 |
| sphincs-shake256-256s-simple (1 executions) | clean | AVG: 3,755,095,315 <br /> MIN: 3,755,095,315 <br /> MAX: 3,755,095,315 | AVG: 44,759,824,973 <br /> MIN: 44,759,824,973 <br /> MAX: 44,759,824,973 | AVG: 65,144,191 <br /> MIN: 65,144,191 <br /> MAX: 65,144,191 |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| bikel1 | m4f | 44,076 | 32,116 | 91,344 |
| bikel1 | opt | 35,860 | 25,868 | 77,780 |
| firesaber | clean | 19,340 | 19,444 | 20,924 |
| firesaber | m4f | 7,252 | 7,204 | 7,220 |
| frodokem640aes | m4 | 31,992 | 62,488 | 83,096 |
| frodokem640shake | m4 | 26,416 | 51,792 | 72,408 |
| frodokem640shake | opt | 36,480 | 58,136 | 78,760 |
| hqc-rmrs-128 | clean | 48,828 | 64,412 | 71,156 |
| kyber1024 | clean | 15,076 | 18,748 | 20,324 |
| kyber1024 | m4 | 3,612 | 3,292 | 3,324 |
| kyber1024-90s | clean | 15,340 | 19,020 | 20,596 |
| kyber1024-90s | m4 | 4,636 | 4,000 | 4,032 |
| kyber512 | clean | 6,108 | 8,772 | 9,548 |
| kyber512 | m4 | 2,220 | 2,308 | 2,324 |
| kyber512-90s | clean | 6,548 | 9,212 | 9,988 |
| kyber512-90s | m4 | 2,904 | 2,992 | 3,008 |
| kyber768 | clean | 10,204 | 13,372 | 14,468 |
| kyber768 | m4 | 3,100 | 2,780 | 2,804 |
| kyber768-90s | clean | 10,652 | 13,820 | 14,916 |
| kyber768-90s | m4 | 3,432 | 3,504 | 3,520 |
| lightsaber | clean | 9,328 | 9,432 | 10,176 |
| lightsaber | m4f | 5,196 | 5,156 | 5,172 |
| ntruhps2048509 | clean | 25,532 | 20,644 | 18,996 |
| ntruhps2048509 | m4f | 21,392 | 14,068 | 14,800 |
| ntruhps2048677 | clean | 34,296 | 27,756 | 25,548 |
| ntruhps2048677 | m4f | 28,504 | 19,980 | 19,728 |
| ntruhps4096821 | clean | 40,960 | 33,036 | 30,440 |
| ntruhps4096821 | m4f | 34,504 | 23,140 | 23,952 |
| ntruhrss701 | clean | 32,920 | 26,140 | 25,948 |
| ntruhrss701 | m4f | 27,560 | 18,324 | 20,560 |
| ntrulpr653 | clean | 11,864 | 12,048 | 13,312 |
| ntrulpr761 | clean | 10,784 | 12,376 | 13,864 |
| ntrulpr761 | m4f | 13,168 | 20,000 | 24,032 |
| ntrulpr857 | clean | 15,640 | 15,704 | 17,376 |
| saber | clean | 12,904 | 13,008 | 14,104 |
| saber | m4f | 6,228 | 6,180 | 6,196 |
| sikep434 | m4 | 6,216 | 6,504 | 6,840 |
| sikep434 | opt | 6,752 | 7,040 | 7,376 |
| sikep503 | m4 | 6,992 | 7,344 | 7,720 |
| sikep503 | opt | 6,664 | 7,016 | 7,392 |
| sikep610 | m4 | 10,504 | 10,904 | 11,368 |
| sikep610 | opt | 10,072 | 10,472 | 10,936 |
| sikep751 | m4 | 12,272 | 12,272 | 12,840 |
| sikep751 | opt | 11,616 | 11,728 | 12,296 |
| sntrup653 | clean | 10,648 | 8,096 | 9,656 |
| sntrup761 | clean | 12,280 | 9,256 | 11,200 |
| sntrup761 | m4f | 61,508 | 13,320 | 16,952 |
| sntrup857 | clean | 13,912 | 10,400 | 12,696 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| dilithium2 | clean | 38,284 | 51,908 | 36,196 |
| dilithium2 | m4 | 38,276 | 51,900 | 36,188 |
| dilithium2aes | clean | 39,756 | 53,380 | 37,668 |
| dilithium3 | clean | 60,812 | 79,556 | 57,700 |
| dilithium3 | m4 | 60,804 | 79,548 | 57,728 |
| dilithium3aes | clean | 62,284 | 81,028 | 59,172 |
| falcon-1024 | clean | 36,296 | 82,484 | 8,796 |
| falcon-1024 | m4-ct | 1,504 | 2,568 | 388 |
| falcon-1024 | opt-ct | 1,504 | 2,568 | 388 |
| falcon-1024 | opt-leaktime | 1,512 | 2,672 | 388 |
| falcon-512 | clean | 18,368 | 42,460 | 4,700 |
| falcon-512 | m4-ct | 1,504 | 2,592 | 388 |
| falcon-512 | opt-ct | 1,400 | 2,480 | 388 |
| falcon-512 | opt-leaktime | 1,408 | 2,576 | 388 |
| falcon-512-tree | m4-ct | 1,496 | 2,776 | 388 |
| falcon-512-tree | opt-ct | 1,392 | 2,776 | 388 |
| falcon-512-tree | opt-leaktime | 1,480 | 2,792 | 388 |
| sphincs-haraka-128f-robust | clean | 3,612 | 3,704 | 4,068 |
| sphincs-haraka-128f-simple | clean | 3,604 | 3,696 | 4,060 |
| sphincs-haraka-128s-robust | clean | 3,824 | 3,872 | 3,380 |
| sphincs-haraka-128s-simple | clean | 3,816 | 3,864 | 3,372 |
| sphincs-haraka-192f-robust | clean | 5,048 | 5,080 | 5,396 |
| sphincs-haraka-192f-simple | clean | 5,012 | 5,072 | 5,388 |
| sphincs-haraka-192s-robust | clean | 5,392 | 5,296 | 4,732 |
| sphincs-haraka-192s-simple | clean | 5,304 | 5,288 | 4,752 |
| sphincs-haraka-256f-robust | clean | 7,040 | 7,008 | 6,660 |
| sphincs-haraka-256f-simple | clean | 7,032 | 7,080 | 6,652 |
| sphincs-haraka-256s-robust | clean | 7,320 | 7,232 | 6,624 |
| sphincs-haraka-256s-simple | clean | 7,384 | 7,224 | 6,588 |
| sphincs-sha256-128f-robust | clean | 2,256 | 2,320 | 2,712 |
| sphincs-sha256-128f-simple | clean | 2,096 | 2,160 | 2,552 |
| sphincs-sha256-128s-robust | clean | 2,440 | 2,520 | 2,024 |
| sphincs-sha256-128s-simple | clean | 2,280 | 2,360 | 1,864 |
| sphincs-sha256-192f-robust | clean | 3,672 | 3,816 | 4,048 |
| sphincs-sha256-192f-simple | clean | 3,504 | 3,536 | 3,880 |
| sphincs-sha256-192s-robust | clean | 3,976 | 3,952 | 3,384 |
| sphincs-sha256-192s-simple | clean | 3,768 | 3,784 | 3,216 |
| sphincs-sha256-256f-robust | clean | 5,712 | 5,751 | 5,432 |
| sphincs-sha256-256f-simple | clean | 5,496 | 5,576 | 5,144 |
| sphincs-sha256-256s-robust | clean | 5,984 | 5,896 | 5,256 |
| sphincs-sha256-256s-simple | clean | 5,808 | 5,720 | 5,080 |
| sphincs-shake256-128f-robust | clean | 2,004 | 2,168 | 2,452 |
| sphincs-shake256-128f-simple | clean | 2,004 | 2,060 | 2,452 |
| sphincs-shake256-128s-robust | clean | 2,188 | 2,256 | 1,792 |
| sphincs-shake256-128s-simple | clean | 2,224 | 2,256 | 1,764 |
| sphincs-shake256-192f-robust | clean | 3,420 | 3,552 | 3,788 |
| sphincs-shake256-192f-simple | clean | 3,420 | 3,552 | 3,788 |
| sphincs-shake256-192s-robust | clean | 3,720 | 3,688 | 3,124 |
| sphincs-shake256-192s-simple | clean | 3,720 | 3,688 | 3,124 |
| sphincs-shake256-256f-robust | clean | 5,456 | 5,488 | 5,060 |
| sphincs-shake256-256f-simple | clean | 5,420 | 5,488 | 5,060 |
| sphincs-shake256-256s-robust | clean | 5,728 | 5,632 | 4,996 |
| sphincs-shake256-256s-simple | clean | 5,728 | 5,632 | 4,996 |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| bikel1 | m4f | 0.7% | 15.1% | 1.0% |
| bikel1 | opt | 0.3% | 10.3% | 0.4% |
| firesaber | clean | 19.1% | 18.9% | 14.1% |
| firesaber | m4f | 70.9% | 72.1% | 63.1% |
| frodokem640aes | m4 | 74.3% | 77.8% | 77.1% |
| frodokem640shake | m4 | 85.1% | 86.3% | 86.0% |
| frodokem640shake | opt | 74.0% | 65.4% | 64.9% |
| hqc-rmrs-128 | clean | 53.6% | 41.2% | 33.0% |
| kyber1024 | clean | 54.4% | 53.7% | 42.7% |
| kyber1024 | m4 | 74.4% | 78.1% | 70.2% |
| kyber1024-90s | clean | 73.8% | 70.5% | 64.0% |
| kyber1024-90s | m4 | 66.5% | 69.0% | 62.3% |
| kyber512 | clean | 54.7% | 51.7% | 37.1% |
| kyber512 | m4 | 75.8% | 78.3% | 67.3% |
| kyber512-90s | clean | 68.7% | 62.7% | 52.6% |
| kyber512-90s | m4 | 68.5% | 70.3% | 60.8% |
| kyber768 | clean | 52.9% | 52.5% | 39.7% |
| kyber768 | m4 | 73.8% | 77.8% | 68.4% |
| kyber768-90s | clean | 71.4% | 67.4% | 59.4% |
| kyber768-90s | m4 | 66.0% | 69.0% | 61.1% |
| lightsaber | clean | 24.9% | 23.8% | 15.5% |
| lightsaber | m4f | 71.7% | 73.5% | 60.9% |
| ntruhps2048509 | clean | 0.0% | 2.4% | 4.2% |
| ntruhps2048509 | m4f | 0.0% | 4.5% | 18.9% |
| ntruhps2048677 | clean | 0.0% | 2.1% | 3.2% |
| ntruhps2048677 | m4f | 0.0% | 4.6% | 17.0% |
| ntruhps4096821 | clean | 0.0% | 1.6% | 2.9% |
| ntruhps4096821 | m4f | 0.0% | 3.7% | 15.9% |
| ntruhrss701 | clean | 0.0% | 2.5% | 3.5% |
| ntruhrss701 | m4f | 0.0% | 10.0% | 17.5% |
| ntrulpr653 | clean | 9.0% | 9.8% | 6.2% |
| ntrulpr761 | clean | 7.9% | 8.5% | 5.4% |
| ntrulpr761 | m4f | 23.5% | 41.6% | 38.8% |
| ntrulpr857 | clean | 7.1% | 7.6% | 4.8% |
| saber | clean | 21.9% | 21.4% | 15.1% |
| saber | m4f | 71.9% | 73.4% | 62.9% |
| sikep434 | m4 | 0.0% | 0.1% | 0.1% |
| sikep434 | opt | 0.0% | 0.0% | 0.0% |
| sikep503 | m4 | 0.0% | 0.1% | 0.1% |
| sikep503 | opt | 0.0% | 0.0% | 0.0% |
| sikep610 | m4 | 0.0% | 0.1% | 0.1% |
| sikep610 | opt | 0.0% | 0.0% | 0.0% |
| sikep751 | m4 | 0.0% | 0.0% | 0.0% |
| sikep751 | opt | 0.0% | 0.0% | 0.0% |
| sntrup653 | clean | 0.1% | 4.2% | 1.0% |
| sntrup761 | clean | 0.1% | 3.7% | 0.8% |
| sntrup761 | m4f | 0.0% | 0.0% | 0.0% |
| sntrup857 | clean | 0.1% | 3.2% | 0.7% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| dilithium2 | clean | 67.1% | 37.2% | 60.1% |
| dilithium2 | m4 | 82.7% | 64.3% | 80.1% |
| dilithium2aes | clean | 2.7% | 3.6% | 5.0% |
| dilithium3 | clean | 70.5% | 37.3% | 63.6% |
| dilithium3 | m4 | 84.9% | 64.3% | 82.3% |
| dilithium3aes | clean | 2.2% | 2.2% | 3.5% |
| falcon-1024 | clean | 8.8% | 0.3% | 26.9% |
| falcon-1024 | m4-ct | 9.6% | 0.5% | 34.2% |
| falcon-1024 | opt-ct | 11.0% | 0.5% | 34.2% |
| falcon-1024 | opt-leaktime | 12.4% | 0.5% | 34.2% |
| falcon-512 | clean | 14.2% | 0.4% | 29.3% |
| falcon-512 | m4-ct | 18.7% | 0.5% | 35.8% |
| falcon-512 | opt-ct | 17.7% | 0.5% | 36.0% |
| falcon-512 | opt-leaktime | 17.1% | 0.6% | 35.8% |
| falcon-512-tree | m4-ct | 15.6% | 1.1% | 35.8% |
| falcon-512-tree | opt-ct | 15.5% | 1.1% | 35.8% |
| falcon-512-tree | opt-leaktime | 17.0% | 1.1% | 36.0% |
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
| sphincs-sha256-128f-robust | clean | 89.0% | 88.6% | 89.0% |
| sphincs-sha256-128f-simple | clean | 87.5% | 86.9% | 87.5% |
| sphincs-sha256-128s-robust | clean | 89.0% | 88.4% | 89.0% |
| sphincs-sha256-128s-simple | clean | 87.5% | 86.7% | 87.4% |
| sphincs-sha256-192f-robust | clean | 88.5% | 88.6% | 88.8% |
| sphincs-sha256-192f-simple | clean | 87.3% | 87.4% | 87.6% |
| sphincs-sha256-192s-robust | clean | 88.5% | 89.0% | 89.0% |
| sphincs-sha256-192s-simple | clean | 87.3% | 87.8% | 87.8% |
| sphincs-sha256-256f-robust | clean | 91.9% | 91.9% | 92.2% |
| sphincs-sha256-256f-simple | clean | 87.0% | 87.2% | 87.3% |
| sphincs-sha256-256s-robust | clean | 91.9% | 92.0% | 92.4% |
| sphincs-sha256-256s-simple | clean | 87.2% | 87.4% | 87.7% |
| sphincs-shake256-128f-robust | clean | 97.6% | 97.4% | 97.6% |
| sphincs-shake256-128f-simple | clean | 96.1% | 95.9% | 96.0% |
| sphincs-shake256-128s-robust | clean | 97.6% | 97.3% | 97.6% |
| sphincs-shake256-128s-simple | clean | 96.1% | 95.9% | 96.0% |
| sphincs-shake256-192f-robust | clean | 97.5% | 97.4% | 97.5% |
| sphincs-shake256-192f-simple | clean | 96.0% | 96.0% | 96.0% |
| sphincs-shake256-192s-robust | clean | 97.5% | 97.2% | 97.5% |
| sphincs-shake256-192s-simple | clean | 96.0% | 95.7% | 96.0% |
| sphincs-shake256-256f-robust | clean | 97.5% | 97.4% | 97.5% |
| sphincs-shake256-256f-simple | clean | 96.0% | 95.9% | 96.0% |
| sphincs-shake256-256s-robust | clean | 97.5% | 97.3% | 97.5% |
| sphincs-shake256-256s-simple | clean | 96.0% | 95.9% | 96.0% |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| bikel1 | m4f | 181,532 | 24 | 49 | 181,605 |
| bikel1 | opt | 35,047 | 24 | 1 | 35,072 |
| firesaber | clean | 10,220 | 0 | 0 | 10,220 |
| firesaber | m4f | 9,548 | 0 | 0 | 9,548 |
| frodokem640aes | m4 | 8,564 | 0 | 0 | 8,564 |
| frodokem640shake | m4 | 8,640 | 0 | 0 | 8,640 |
| frodokem640shake | opt | 6,796 | 0 | 0 | 6,796 |
| hqc-rmrs-128 | clean | 18,460 | 0 | 0 | 18,460 |
| kyber1024 | clean | 6,084 | 0 | 0 | 6,084 |
| kyber1024 | m4 | 11,740 | 0 | 0 | 11,740 |
| kyber1024-90s | clean | 6,468 | 0 | 0 | 6,468 |
| kyber1024-90s | m4 | 11,988 | 0 | 0 | 11,988 |
| kyber512 | clean | 4,900 | 0 | 0 | 4,900 |
| kyber512 | m4 | 10,720 | 0 | 0 | 10,720 |
| kyber512-90s | clean | 5,148 | 0 | 0 | 5,148 |
| kyber512-90s | m4 | 10,908 | 0 | 0 | 10,908 |
| kyber768 | clean | 4,912 | 0 | 0 | 4,912 |
| kyber768 | m4 | 10,892 | 0 | 0 | 10,892 |
| kyber768-90s | clean | 5,172 | 0 | 0 | 5,172 |
| kyber768-90s | m4 | 10,836 | 0 | 0 | 10,836 |
| lightsaber | clean | 10,380 | 0 | 0 | 10,380 |
| lightsaber | m4f | 9,660 | 0 | 0 | 9,660 |
| ntruhps2048509 | clean | 64,644 | 0 | 0 | 64,644 |
| ntruhps2048509 | m4f | 91,704 | 0 | 0 | 91,704 |
| ntruhps2048677 | clean | 17,304 | 0 | 0 | 17,304 |
| ntruhps2048677 | m4f | 142,264 | 0 | 0 | 142,264 |
| ntruhps4096821 | clean | 17,064 | 0 | 0 | 17,064 |
| ntruhps4096821 | m4f | 167,356 | 0 | 0 | 167,356 |
| ntruhrss701 | clean | 16,724 | 0 | 0 | 16,724 |
| ntruhrss701 | m4f | 145,352 | 0 | 0 | 145,352 |
| ntrulpr653 | clean | 7,608 | 0 | 0 | 7,608 |
| ntrulpr761 | clean | 8,096 | 0 | 0 | 8,096 |
| ntrulpr761 | m4f | 130,949 | 128 | 0 | 131,077 |
| ntrulpr857 | clean | 8,336 | 0 | 0 | 8,336 |
| saber | clean | 10,128 | 0 | 0 | 10,128 |
| saber | m4f | 9,396 | 0 | 0 | 9,396 |
| sikep434 | m4 | 30,212 | 0 | 0 | 30,212 |
| sikep434 | opt | 28,232 | 0 | 0 | 28,232 |
| sikep503 | m4 | 32,548 | 0 | 0 | 32,548 |
| sikep503 | opt | 26,432 | 0 | 0 | 26,432 |
| sikep610 | m4 | 29,668 | 0 | 0 | 29,668 |
| sikep610 | opt | 19,420 | 0 | 0 | 19,420 |
| sikep751 | m4 | 33,280 | 0 | 0 | 33,280 |
| sikep751 | opt | 21,064 | 0 | 0 | 21,064 |
| sntrup653 | clean | 12,416 | 0 | 0 | 12,416 |
| sntrup761 | clean | 13,156 | 0 | 0 | 13,156 |
| sntrup761 | m4f | 162,749 | 152 | 3,608 | 166,509 |
| sntrup857 | clean | 13,532 | 0 | 0 | 13,532 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |

| dilithium2 | clean | 7,944 | 0 | 0 | 7,944 |
| dilithium2 | m4 | 10,604 | 0 | 0 | 10,604 |
| dilithium2aes | clean | 14,974 | 0 | 0 | 14,974 |
| dilithium3 | clean | 7,444 | 0 | 0 | 7,444 |
| dilithium3 | m4 | 10,076 | 0 | 0 | 10,076 |
| dilithium3aes | clean | 14,466 | 0 | 0 | 14,466 |
| falcon-1024 | clean | 82,225 | 0 | 0 | 82,225 |
| falcon-1024 | m4-ct | 81,213 | 0 | 79,872 | 161,085 |
| falcon-1024 | opt-ct | 81,213 | 0 | 79,872 | 161,085 |
| falcon-1024 | opt-leaktime | 74,381 | 0 | 79,872 | 154,253 |
| falcon-512 | clean | 82,193 | 0 | 0 | 82,193 |
| falcon-512 | m4-ct | 81,053 | 0 | 39,936 | 120,989 |
| falcon-512 | opt-ct | 81,213 | 0 | 39,936 | 121,149 |
| falcon-512 | opt-leaktime | 74,381 | 0 | 39,936 | 114,317 |
| falcon-512-tree | m4-ct | 80,953 | 0 | 27,648 | 108,601 |
| falcon-512-tree | opt-ct | 80,953 | 0 | 27,648 | 108,601 |
| falcon-512-tree | opt-leaktime | 74,121 | 0 | 27,648 | 101,769 |
| sphincs-haraka-128f-robust | clean | 16,792 | 0 | 0 | 16,792 |
| sphincs-haraka-128f-simple | clean | 16,640 | 0 | 0 | 16,640 |
| sphincs-haraka-128s-robust | clean | 17,104 | 0 | 0 | 17,104 |
| sphincs-haraka-128s-simple | clean | 16,952 | 0 | 0 | 16,952 |
| sphincs-haraka-192f-robust | clean | 16,660 | 0 | 0 | 16,660 |
| sphincs-haraka-192f-simple | clean | 16,476 | 0 | 0 | 16,476 |
| sphincs-haraka-192s-robust | clean | 16,864 | 0 | 0 | 16,864 |
| sphincs-haraka-192s-simple | clean | 16,680 | 0 | 0 | 16,680 |
| sphincs-haraka-256f-robust | clean | 17,144 | 0 | 0 | 17,144 |
| sphincs-haraka-256f-simple | clean | 16,904 | 0 | 0 | 16,904 |
| sphincs-haraka-256s-robust | clean | 17,344 | 0 | 0 | 17,344 |
| sphincs-haraka-256s-simple | clean | 17,100 | 0 | 0 | 17,100 |
| sphincs-sha256-128f-robust | clean | 4,948 | 0 | 0 | 4,948 |
| sphincs-sha256-128f-simple | clean | 4,700 | 0 | 0 | 4,700 |
| sphincs-sha256-128s-robust | clean | 5,260 | 0 | 0 | 5,260 |
| sphincs-sha256-128s-simple | clean | 5,012 | 0 | 0 | 5,012 |
| sphincs-sha256-192f-robust | clean | 5,040 | 0 | 0 | 5,040 |
| sphincs-sha256-192f-simple | clean | 4,672 | 0 | 0 | 4,672 |
| sphincs-sha256-192s-robust | clean | 5,252 | 0 | 0 | 5,252 |
| sphincs-sha256-192s-simple | clean | 4,884 | 0 | 0 | 4,884 |
| sphincs-sha256-256f-robust | clean | 5,620 | 0 | 0 | 5,620 |
| sphincs-sha256-256f-simple | clean | 5,152 | 0 | 0 | 5,152 |
| sphincs-sha256-256s-robust | clean | 5,816 | 0 | 0 | 5,816 |
| sphincs-sha256-256s-simple | clean | 5,344 | 0 | 0 | 5,344 |
| sphincs-shake256-128f-robust | clean | 4,216 | 0 | 0 | 4,216 |
| sphincs-shake256-128f-simple | clean | 4,076 | 0 | 0 | 4,076 |
| sphincs-shake256-128s-robust | clean | 4,532 | 0 | 0 | 4,532 |
| sphincs-shake256-128s-simple | clean | 4,392 | 0 | 0 | 4,392 |
| sphincs-shake256-192f-robust | clean | 4,128 | 0 | 0 | 4,128 |
| sphincs-shake256-192f-simple | clean | 3,956 | 0 | 0 | 3,956 |
| sphincs-shake256-192s-robust | clean | 4,336 | 0 | 0 | 4,336 |
| sphincs-shake256-192s-simple | clean | 4,164 | 0 | 0 | 4,164 |
| sphincs-shake256-256f-robust | clean | 4,628 | 0 | 0 | 4,628 |
| sphincs-shake256-256f-simple | clean | 4,416 | 0 | 0 | 4,416 |
| sphincs-shake256-256s-robust | clean | 4,820 | 0 | 0 | 4,820 |
| sphincs-shake256-256s-simple | clean | 4,612 | 0 | 0 | 4,612 |
