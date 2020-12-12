# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| firesaber (100 executions) | clean | AVG: 3,723,480 <br /> MIN: 3,723,480 <br /> MAX: 3,723,480 | AVG: 4,622,127 <br /> MIN: 4,622,127 <br /> MAX: 4,622,127 | AVG: 5,233,205 <br /> MIN: 5,233,205 <br /> MAX: 5,233,205 |
| firesaber (100 executions) | m4f | AVG: 1,007,477 <br /> MIN: 1,007,477 <br /> MAX: 1,007,477 | AVG: 1,256,353 <br /> MIN: 1,256,353 <br /> MAX: 1,256,353 | AVG: 1,231,994 <br /> MIN: 1,231,994 <br /> MAX: 1,231,994 |
| frodokem640aes (100 executions) | m4 | AVG: 48,348,105 <br /> MIN: 48,348,105 <br /> MAX: 48,348,105 | AVG: 47,130,922 <br /> MIN: 47,130,922 <br /> MAX: 47,130,922 | AVG: 46,594,383 <br /> MIN: 46,594,383 <br /> MAX: 46,594,383 |
| frodokem640shake (100 executions) | m4 | AVG: 79,325,705 <br /> MIN: 79,325,705 <br /> MAX: 79,325,705 | AVG: 79,699,757 <br /> MIN: 79,699,757 <br /> MAX: 79,699,757 | AVG: 79,145,449 <br /> MIN: 79,145,449 <br /> MAX: 79,145,449 |
| frodokem640shake (100 executions) | opt | AVG: 91,896,318 <br /> MIN: 91,896,318 <br /> MAX: 91,896,318 | AVG: 104,912,447 <br /> MIN: 104,912,447 <br /> MAX: 104,912,447 | AVG: 104,638,561 <br /> MIN: 104,638,561 <br /> MAX: 104,638,561 |
| hqc-rmrs-128 (100 executions) | clean | AVG: 2,958,761 <br /> MIN: 2,926,873 <br /> MAX: 3,154,607 | AVG: 5,389,782 <br /> MIN: 5,323,042 <br /> MAX: 5,587,198 | AVG: 7,814,315 <br /> MIN: 7,715,362 <br /> MAX: 8,070,658 |
| kyber1024 (100 executions) | clean | AVG: 1,657,144 <br /> MIN: 1,654,880 <br /> MAX: 1,681,921 | AVG: 2,033,986 <br /> MIN: 2,031,721 <br /> MAX: 2,058,777 | AVG: 2,170,110 <br /> MIN: 2,167,845 <br /> MAX: 2,194,901 |
| kyber1024 (100 executions) | m4 | AVG: 1,216,669 <br /> MIN: 1,212,098 <br /> MAX: 1,252,093 | AVG: 1,406,588 <br /> MIN: 1,402,081 <br /> MAX: 1,441,945 | AVG: 1,326,182 <br /> MIN: 1,321,675 <br /> MAX: 1,361,539 |
| kyber1024-90s (100 executions) | clean | AVG: 3,001,553 <br /> MIN: 3,000,212 <br /> MAX: 3,016,252 | AVG: 3,277,401 <br /> MIN: 3,276,089 <br /> MAX: 3,292,099 | AVG: 3,510,669 <br /> MIN: 3,509,357 <br /> MAX: 3,525,367 |
| kyber1024-90s (100 executions) | m4 | AVG: 1,040,158 <br /> MIN: 1,032,023 <br /> MAX: 1,045,096 | AVG: 1,137,576 <br /> MIN: 1,129,396 <br /> MAX: 1,142,542 | AVG: 1,154,265 <br /> MIN: 1,146,085 <br /> MAX: 1,159,231 |
| kyber512 (100 executions) | clean | AVG: 639,281 <br /> MIN: 638,221 <br /> MAX: 651,734 | AVG: 853,692 <br /> MIN: 852,632 <br /> MAX: 866,145 | AVG: 945,783 <br /> MIN: 944,723 <br /> MAX: 958,236 |
| kyber512 (100 executions) | m4 | AVG: 463,343 <br /> MIN: 462,340 <br /> MAX: 475,943 | AVG: 566,744 <br /> MIN: 565,741 <br /> MAX: 579,344 | AVG: 525,141 <br /> MIN: 524,138 <br /> MAX: 537,741 |
| kyber512-90s (100 executions) | clean | AVG: 945,590 <br /> MIN: 944,948 <br /> MAX: 945,965 | AVG: 1,115,224 <br /> MIN: 1,114,582 <br /> MAX: 1,115,599 | AVG: 1,260,218 <br /> MIN: 1,259,576 <br /> MAX: 1,260,593 |
| kyber512-90s (100 executions) | m4 | AVG: 390,549 <br /> MIN: 382,560 <br /> MAX: 395,061 | AVG: 449,172 <br /> MIN: 441,183 <br /> MAX: 453,684 | AVG: 460,470 <br /> MIN: 452,481 <br /> MAX: 464,982 |
| kyber768 (100 executions) | clean | AVG: 1,060,755 <br /> MIN: 1,059,689 <br /> MAX: 1,073,727 | AVG: 1,363,334 <br /> MIN: 1,362,268 <br /> MAX: 1,376,306 | AVG: 1,475,756 <br /> MIN: 1,474,690 <br /> MAX: 1,488,728 |
| kyber768 (100 executions) | m4 | AVG: 763,979 <br /> MIN: 761,596 <br /> MAX: 788,310 | AVG: 923,856 <br /> MIN: 921,477 <br /> MAX: 948,186 | AVG: 862,176 <br /> MIN: 859,797 <br /> MAX: 886,506 |
| kyber768-90s (100 executions) | clean | AVG: 1,813,167 <br /> MIN: 1,812,309 <br /> MAX: 1,828,332 | AVG: 2,036,400 <br /> MIN: 2,035,542 <br /> MAX: 2,051,565 | AVG: 2,223,819 <br /> MIN: 2,222,961 <br /> MAX: 2,238,984 |
| kyber768-90s (100 executions) | m4 | AVG: 660,765 <br /> MIN: 656,834 <br /> MAX: 665,216 | AVG: 741,256 <br /> MIN: 737,325 <br /> MAX: 745,707 | AVG: 754,570 <br /> MIN: 750,639 <br /> MAX: 759,021 |
| lightsaber (100 executions) | clean | AVG: 1,026,004 <br /> MIN: 1,026,004 <br /> MAX: 1,026,004 | AVG: 1,498,300 <br /> MIN: 1,498,300 <br /> MAX: 1,498,300 | AVG: 1,806,894 <br /> MIN: 1,806,894 <br /> MAX: 1,806,894 |
| lightsaber (100 executions) | m4f | AVG: 361,687 <br /> MIN: 361,687 <br /> MAX: 361,687 | AVG: 513,581 <br /> MIN: 513,581 <br /> MAX: 513,581 | AVG: 498,590 <br /> MIN: 498,590 <br /> MAX: 498,590 |
| ntruhps2048509 (100 executions) | clean | AVG: 68,795,185 <br /> MIN: 68,795,185 <br /> MAX: 68,795,185 | AVG: 1,062,964 <br /> MIN: 1,062,964 <br /> MAX: 1,062,964 | AVG: 2,435,439 <br /> MIN: 2,435,439 <br /> MAX: 2,435,439 |
| ntruhps2048509 (100 executions) | m4f | AVG: 79,658,656 <br /> MIN: 79,658,656 <br /> MAX: 79,658,656 | AVG: 564,411 <br /> MIN: 564,411 <br /> MAX: 564,411 | AVG: 537,473 <br /> MIN: 537,473 <br /> MAX: 537,473 |
| ntruhps2048677 (100 executions) | clean | AVG: 123,029,086 <br /> MIN: 123,029,086 <br /> MAX: 123,029,086 | AVG: 1,796,535 <br /> MIN: 1,796,535 <br /> MAX: 1,796,535 | AVG: 4,287,726 <br /> MIN: 4,287,726 <br /> MAX: 4,287,726 |
| ntruhps2048677 (100 executions) | m4f | AVG: 143,734,184 <br /> MIN: 143,734,184 <br /> MAX: 143,734,184 | AVG: 821,524 <br /> MIN: 821,524 <br /> MAX: 821,524 | AVG: 815,516 <br /> MIN: 815,516 <br /> MAX: 815,516 |
| ntruhps4096821 (100 executions) | clean | AVG: 181,325,162 <br /> MIN: 181,325,162 <br /> MAX: 181,325,162 | AVG: 2,347,265 <br /> MIN: 2,347,265 <br /> MAX: 2,347,265 | AVG: 5,668,286 <br /> MIN: 5,668,286 <br /> MAX: 5,668,286 |
| ntruhps4096821 (100 executions) | m4f | AVG: 208,835,863 <br /> MIN: 208,835,863 <br /> MAX: 208,835,863 | AVG: 1,028,465 <br /> MIN: 1,028,465 <br /> MAX: 1,028,465 | AVG: 1,032,726 <br /> MIN: 1,032,726 <br /> MAX: 1,032,726 |
| ntruhrss701 (100 executions) | clean | AVG: 132,506,447 <br /> MIN: 132,506,447 <br /> MAX: 132,506,447 | AVG: 1,510,371 <br /> MIN: 1,510,371 <br /> MAX: 1,510,371 | AVG: 4,347,522 <br /> MIN: 4,347,522 <br /> MAX: 4,347,522 |
| ntruhrss701 (100 executions) | m4f | AVG: 153,104,418 <br /> MIN: 153,104,418 <br /> MAX: 153,104,418 | AVG: 377,377 <br /> MIN: 377,377 <br /> MAX: 377,377 | AVG: 869,701 <br /> MIN: 869,701 <br /> MAX: 869,701 |
| ntrulpr653 (100 executions) | clean | AVG: 4,097,458 <br /> MIN: 4,097,458 <br /> MAX: 4,097,458 | AVG: 7,821,693 <br /> MIN: 7,821,693 <br /> MAX: 7,821,693 | AVG: 11,273,153 <br /> MIN: 11,273,153 <br /> MAX: 11,273,153 |
| ntrulpr761 (100 executions) | clean | AVG: 5,637,574 <br /> MIN: 5,637,574 <br /> MAX: 5,637,574 | AVG: 10,817,090 <br /> MIN: 10,817,090 <br /> MAX: 10,817,090 | AVG: 15,498,061 <br /> MIN: 15,498,061 <br /> MAX: 15,498,061 |
| ntrulpr761 (100 executions) | m4f | AVG: 824,669 <br /> MIN: 824,669 <br /> MAX: 824,669 | AVG: 1,508,936 <br /> MIN: 1,508,936 <br /> MAX: 1,508,936 | AVG: 1,691,312 <br /> MIN: 1,691,312 <br /> MAX: 1,691,312 |
| ntrulpr857 (100 executions) | clean | AVG: 6,794,314 <br /> MIN: 6,794,314 <br /> MAX: 6,794,314 | AVG: 13,061,118 <br /> MIN: 13,061,118 <br /> MAX: 13,061,118 | AVG: 18,992,752 <br /> MIN: 18,992,752 <br /> MAX: 18,992,752 |
| saber (100 executions) | clean | AVG: 2,132,294 <br /> MIN: 2,132,294 <br /> MAX: 2,132,294 | AVG: 2,814,441 <br /> MIN: 2,814,441 <br /> MAX: 2,814,441 | AVG: 3,279,418 <br /> MIN: 3,279,418 <br /> MAX: 3,279,418 |
| saber (100 executions) | m4f | AVG: 654,407 <br /> MIN: 654,407 <br /> MAX: 654,407 | AVG: 862,856 <br /> MIN: 862,856 <br /> MAX: 862,856 | AVG: 835,122 <br /> MIN: 835,122 <br /> MAX: 835,122 |
| sikep434 (100 executions) | m4 | AVG: 48,264,129 <br /> MIN: 48,264,129 <br /> MAX: 48,264,129 | AVG: 78,911,465 <br /> MIN: 78,911,465 <br /> MAX: 78,911,465 | AVG: 84,276,911 <br /> MIN: 84,276,911 <br /> MAX: 84,276,911 |
| sikep434 (100 executions) | opt | AVG: 643,140,813 <br /> MIN: 643,140,813 <br /> MAX: 643,140,813 | AVG: 1,053,374,539 <br /> MIN: 1,053,374,539 <br /> MAX: 1,053,374,539 | AVG: 1,123,506,035 <br /> MIN: 1,123,506,035 <br /> MAX: 1,123,506,035 |
| sikep503 (100 executions) | m4 | AVG: 67,365,363 <br /> MIN: 67,365,363 <br /> MAX: 67,365,363 | AVG: 110,846,067 <br /> MIN: 110,846,067 <br /> MAX: 110,846,067 | AVG: 117,993,160 <br /> MIN: 117,993,160 <br /> MAX: 117,993,160 |
| sikep503 (100 executions) | opt | AVG: 972,733,846 <br /> MIN: 972,733,846 <br /> MAX: 972,733,846 | AVG: 1,602,886,599 <br /> MIN: 1,602,886,599 <br /> MAX: 1,602,886,599 | AVG: 1,704,605,781 <br /> MIN: 1,704,605,781 <br /> MAX: 1,704,605,781 |
| sikep610 (100 executions) | m4 | AVG: 119,480,622 <br /> MIN: 119,480,622 <br /> MAX: 119,480,622 | AVG: 219,632,058 <br /> MIN: 219,632,058 <br /> MAX: 219,632,058 | AVG: 221,029,700 <br /> MIN: 221,029,700 <br /> MAX: 221,029,700 |
| sikep610 (100 executions) | opt | AVG: 1,815,959,387 <br /> MIN: 1,815,959,387 <br /> MAX: 1,815,959,387 | AVG: 3,341,196,195 <br /> MIN: 3,341,196,195 <br /> MAX: 3,341,196,195 | AVG: 3,360,955,305 <br /> MIN: 3,360,955,305 <br /> MAX: 3,360,955,305 |
| sikep751 (100 executions) | m4 | AVG: 204,646,661 <br /> MIN: 204,646,661 <br /> MAX: 204,646,661 | AVG: 331,934,480 <br /> MIN: 331,934,480 <br /> MAX: 331,934,480 | AVG: 356,425,812 <br /> MIN: 356,425,812 <br /> MAX: 356,425,812 |
| sikep751 (100 executions) | opt | AVG: 3,288,678,781 <br /> MIN: 3,288,678,781 <br /> MAX: 3,288,678,781 | AVG: 5,333,567,877 <br /> MIN: 5,333,567,877 <br /> MAX: 5,333,567,877 | AVG: 5,728,790,883 <br /> MIN: 5,728,790,883 <br /> MAX: 5,728,790,883 |
| sntrup653 (100 executions) | clean | AVG: 107,454,880 <br /> MIN: 105,111,497 <br /> MAX: 144,167,887 | AVG: 4,058,297 <br /> MIN: 4,058,297 <br /> MAX: 4,058,297 | AVG: 11,719,072 <br /> MIN: 11,719,072 <br /> MAX: 11,719,073 |
| sntrup761 (100 executions) | clean | AVG: 140,229,196 <br /> MIN: 140,229,196 <br /> MAX: 140,229,196 | AVG: 5,393,601 <br /> MIN: 5,393,601 <br /> MAX: 5,393,601 | AVG: 15,823,589 <br /> MIN: 15,823,589 <br /> MAX: 15,823,589 |
| sntrup761 (100 executions) | m4f | AVG: 11,392,072 <br /> MIN: 11,392,072 <br /> MAX: 11,392,072 | AVG: 794,049 <br /> MIN: 794,049 <br /> MAX: 794,049 | AVG: 743,378 <br /> MIN: 743,378 <br /> MAX: 743,378 |
| sntrup857 (100 executions) | clean | AVG: 177,668,015 <br /> MIN: 177,668,015 <br /> MAX: 177,668,015 | AVG: 6,739,738 <br /> MIN: 6,739,738 <br /> MAX: 6,739,738 | AVG: 19,262,010 <br /> MIN: 19,262,010 <br /> MAX: 19,262,010 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| dilithium2 (100 executions) | clean | AVG: 1,614,477 <br /> MIN: 1,613,563 <br /> MAX: 1,626,981 | AVG: 8,032,479 <br /> MIN: 2,987,832 <br /> MAX: 36,923,036 | AVG: 1,830,445 <br /> MIN: 1,829,963 <br /> MAX: 1,830,901 |
| dilithium2 (100 executions) | m4 | AVG: 1,318,459 <br /> MIN: 1,318,012 <br /> MAX: 1,318,931 | AVG: 3,959,810 <br /> MIN: 1,622,146 <br /> MAX: 17,275,661 | AVG: 1,259,327 <br /> MIN: 1,258,790 <br /> MAX: 1,259,982 |
| dilithium2 (100 executions) | stack | AVG: 1,318,532 <br /> MIN: 1,317,884 <br /> MAX: 1,319,036 | AVG: 12,972,203 <br /> MIN: 2,561,310 <br /> MAX: 73,306,579 | AVG: 1,259,289 <br /> MIN: 1,258,776 <br /> MAX: 1,259,819 |
| dilithium3 (100 executions) | clean | AVG: 2,539,785 <br /> MIN: 2,538,961 <br /> MAX: 2,540,640 | AVG: 11,759,429 <br /> MIN: 4,161,883 <br /> MAX: 64,856,628 | AVG: 2,671,904 <br /> MIN: 2,671,471 <br /> MAX: 2,672,362 |
| dilithium3 (100 executions) | m4 | AVG: 1,989,249 <br /> MIN: 1,988,511 <br /> MAX: 1,990,289 | AVG: 6,480,747 <br /> MIN: 2,392,221 <br /> MAX: 23,557,165 | AVG: 1,913,130 <br /> MIN: 1,912,282 <br /> MAX: 1,913,833 |
| dilithium3 (100 executions) | stack | AVG: 1,989,225 <br /> MIN: 1,988,168 <br /> MAX: 1,990,021 | AVG: 27,116,438 <br /> MIN: 3,952,331 <br /> MAX: 179,657,735 | AVG: 1,913,111 <br /> MIN: 1,912,366 <br /> MAX: 1,914,099 |
| dilithium4 (100 executions) | clean | AVG: 3,398,499 <br /> MIN: 3,398,034 <br /> MAX: 3,398,906 | AVG: 12,168,851 <br /> MIN: 5,509,148 <br /> MAX: 52,054,919 | AVG: 3,684,357 <br /> MIN: 3,683,668 <br /> MAX: 3,684,920 |
| dilithium4 (100 executions) | m4 | AVG: 2,837,216 <br /> MIN: 2,836,824 <br /> MAX: 2,837,662 | AVG: 6,449,214 <br /> MIN: 3,302,923 <br /> MAX: 14,659,109 | AVG: 2,719,554 <br /> MIN: 2,718,738 <br /> MAX: 2,720,437 |
| dilithium4 (100 executions) | stack | AVG: 2,837,227 <br /> MIN: 2,836,759 <br /> MAX: 2,837,676 | AVG: 22,600,922 <br /> MIN: 5,644,173 <br /> MAX: 115,212,171 | AVG: 2,719,582 <br /> MIN: 2,718,704 <br /> MAX: 2,720,570 |
| falcon-1024 (100 executions) | clean | AVG: 622,175,711 <br /> MIN: 337,571,831 <br /> MAX: 1,880,024,329 | AVG: 133,629,247 <br /> MIN: 133,291,572 <br /> MAX: 133,967,706 | AVG: 1,528,951 <br /> MIN: 1,528,400 <br /> MAX: 1,529,571 |
| falcon-1024 (100 executions) | m4-ct | AVG: 459,534,839 <br /> MIN: 273,177,640 <br /> MAX: 1,047,054,767 | AVG: 85,072,673 <br /> MIN: 84,815,948 <br /> MAX: 85,305,908 | AVG: 980,052 <br /> MIN: 969,152 <br /> MAX: 985,686 |
| falcon-1024 (100 executions) | opt-ct | AVG: 495,167,251 <br /> MIN: 273,177,640 <br /> MAX: 1,379,271,017 | AVG: 85,054,991 <br /> MIN: 84,783,337 <br /> MAX: 85,362,818 | AVG: 977,782 <br /> MIN: 967,975 <br /> MAX: 987,002 |
| falcon-1024 (100 executions) | opt-leaktime | AVG: 405,281,116 <br /> MIN: 244,875,160 <br /> MAX: 891,184,049 | AVG: 76,013,689 <br /> MIN: 75,446,015 <br /> MAX: 76,508,847 | AVG: 979,746 <br /> MIN: 967,632 <br /> MAX: 986,832 |
| falcon-512 (100 executions) | clean | AVG: 208,399,225 <br /> MIN: 130,550,614 <br /> MAX: 472,461,727 | AVG: 61,097,585 <br /> MIN: 60,852,840 <br /> MAX: 61,406,301 | AVG: 766,917 <br /> MIN: 766,489 <br /> MAX: 767,319 |
| falcon-512 (100 executions) | m4-ct | AVG: 171,386,113 <br /> MIN: 102,414,161 <br /> MAX: 578,366,405 | AVG: 38,980,990 <br /> MIN: 38,781,213 <br /> MAX: 39,236,694 | AVG: 474,764 <br /> MIN: 465,756 <br /> MAX: 481,271 |
| falcon-512 (100 executions) | opt-ct | AVG: 177,602,037 <br /> MIN: 102,400,864 <br /> MAX: 714,825,912 | AVG: 38,965,055 <br /> MIN: 38,810,150 <br /> MAX: 39,279,838 | AVG: 473,672 <br /> MIN: 465,686 <br /> MAX: 482,281 |
| falcon-512 (100 executions) | opt-leaktime | AVG: 152,926,229 <br /> MIN: 90,346,571 <br /> MAX: 337,384,529 | AVG: 35,378,639 <br /> MIN: 35,029,929 <br /> MAX: 35,717,852 | AVG: 475,420 <br /> MIN: 465,612 <br /> MAX: 482,310 |
| falcon-512-tree (100 executions) | m4-ct | AVG: 171,727,053 <br /> MIN: 117,531,546 <br /> MAX: 490,748,018 | AVG: 17,669,755 <br /> MIN: 17,432,665 <br /> MAX: 17,857,219 | AVG: 473,783 <br /> MIN: 465,581 <br /> MAX: 481,627 |
| falcon-512-tree (100 executions) | opt-ct | AVG: 182,000,803 <br /> MIN: 117,531,546 <br /> MAX: 537,014,335 | AVG: 17,671,861 <br /> MIN: 17,503,582 <br /> MAX: 17,907,492 | AVG: 474,096 <br /> MIN: 465,021 <br /> MAX: 482,523 |
| falcon-512-tree (100 executions) | opt-leaktime | AVG: 168,338,680 <br /> MIN: 101,826,596 <br /> MAX: 516,678,670 | AVG: 19,213,176 <br /> MIN: 18,918,057 <br /> MAX: 19,567,974 | AVG: 474,214 <br /> MIN: 465,252 <br /> MAX: 481,696 |
| sphincs-haraka-128f-robust (1 executions) | clean | AVG: 104,787,309 <br /> MIN: 104,787,309 <br /> MAX: 104,787,309 | AVG: 3,878,075,744 <br /> MIN: 3,878,075,744 <br /> MAX: 3,878,075,744 | AVG: 160,747,512 <br /> MIN: 160,747,512 <br /> MAX: 160,747,512 |
| sphincs-haraka-128f-simple (1 executions) | clean | AVG: 72,822,905 <br /> MIN: 72,822,905 <br /> MAX: 72,822,905 | AVG: 2,618,613,346 <br /> MIN: 2,618,613,346 <br /> MAX: 2,618,613,346 | AVG: 110,346,142 <br /> MIN: 110,346,142 <br /> MAX: 110,346,142 |
| sphincs-haraka-128s-robust (1 executions) | clean | AVG: 3,336,087,734 <br /> MIN: 3,336,087,734 <br /> MAX: 3,336,087,734 | AVG: 62,522,334,287 <br /> MIN: 62,522,334,287 <br /> MAX: 62,522,334,287 | AVG: 69,736,124 <br /> MIN: 69,736,124 <br /> MAX: 69,736,124 |
| sphincs-haraka-128s-simple (1 executions) | clean | AVG: 2,312,256,437 <br /> MIN: 2,312,256,437 <br /> MAX: 2,312,256,437 | AVG: 41,759,085,792 <br /> MIN: 41,759,085,792 <br /> MAX: 41,759,085,792 | AVG: 45,891,563 <br /> MIN: 45,891,563 <br /> MAX: 45,891,563 |
| sphincs-haraka-192f-robust (1 executions) | clean | AVG: 155,427,078 <br /> MIN: 155,427,078 <br /> MAX: 155,427,078 | AVG: 4,653,572,252 <br /> MIN: 4,653,572,252 <br /> MAX: 4,653,572,252 | AVG: 254,933,605 <br /> MIN: 254,933,605 <br /> MAX: 254,933,605 |
| sphincs-haraka-192f-simple (1 executions) | clean | AVG: 107,270,973 <br /> MIN: 107,270,973 <br /> MAX: 107,270,973 | AVG: 3,088,059,988 <br /> MIN: 3,088,059,988 <br /> MAX: 3,088,059,988 | AVG: 168,554,107 <br /> MIN: 168,554,107 <br /> MAX: 168,554,107 |
| sphincs-haraka-192s-robust (1 executions) | clean | AVG: 4,957,051,483 <br /> MIN: 4,957,051,483 <br /> MAX: 4,957,051,483 | AVG: 154,251,598,347 <br /> MIN: 154,251,598,347 <br /> MAX: 154,251,598,347 | AVG: 110,861,825 <br /> MIN: 110,861,825 <br /> MAX: 110,861,825 |
| sphincs-haraka-192s-simple (1 executions) | clean | AVG: 3,414,581,337 <br /> MIN: 3,414,581,337 <br /> MAX: 3,414,581,337 | AVG: 92,506,480,154 <br /> MIN: 92,506,480,154 <br /> MAX: 92,506,480,154 | AVG: 70,786,261 <br /> MIN: 70,786,261 <br /> MAX: 70,786,261 |
| sphincs-haraka-256f-robust (1 executions) | clean | AVG: 415,473,286 <br /> MIN: 415,473,286 <br /> MAX: 415,473,286 | AVG: 11,563,963,571 <br /> MIN: 11,563,963,571 <br /> MAX: 11,563,963,571 | AVG: 277,440,214 <br /> MIN: 277,440,214 <br /> MAX: 277,440,214 |
| sphincs-haraka-256f-simple (1 executions) | clean | AVG: 285,155,664 <br /> MIN: 285,155,664 <br /> MAX: 285,155,664 | AVG: 7,636,212,442 <br /> MIN: 7,636,212,442 <br /> MAX: 7,636,212,442 | AVG: 180,737,136 <br /> MIN: 180,737,136 <br /> MAX: 180,737,136 |
| sphincs-haraka-256s-robust (1 executions) | clean | AVG: 6,639,120,105 <br /> MIN: 6,639,120,105 <br /> MAX: 6,639,120,105 | AVG: 103,762,136,231 <br /> MIN: 103,762,136,231 <br /> MAX: 103,762,136,231 | AVG: 154,024,957 <br /> MIN: 154,024,957 <br /> MAX: 154,024,957 |
| sphincs-haraka-256s-simple (1 executions) | clean | AVG: 4,553,387,845 <br /> MIN: 4,553,387,845 <br /> MAX: 4,553,387,845 | AVG: 67,650,617,389 <br /> MIN: 67,650,617,389 <br /> MAX: 67,650,617,389 | AVG: 98,468,503 <br /> MIN: 98,468,503 <br /> MAX: 98,468,503 |
| sphincs-sha256-128f-robust (1 executions) | clean | AVG: 30,486,094 <br /> MIN: 30,486,094 <br /> MAX: 30,486,094 | AVG: 912,695,869 <br /> MIN: 912,695,869 <br /> MAX: 912,695,869 | AVG: 39,774,881 <br /> MIN: 39,774,881 <br /> MAX: 39,774,881 |
| sphincs-sha256-128f-simple (1 executions) | clean | AVG: 15,903,697 <br /> MIN: 15,903,697 <br /> MAX: 15,903,697 | AVG: 502,249,164 <br /> MIN: 502,249,164 <br /> MAX: 502,249,164 | AVG: 20,926,343 <br /> MIN: 20,926,343 <br /> MAX: 20,926,343 |
| sphincs-sha256-128s-robust (1 executions) | clean | AVG: 975,171,329 <br /> MIN: 975,171,329 <br /> MAX: 975,171,329 | AVG: 13,506,102,373 <br /> MIN: 13,506,102,373 <br /> MAX: 13,506,102,373 | AVG: 16,045,163 <br /> MIN: 16,045,163 <br /> MAX: 16,045,163 |
| sphincs-sha256-128s-simple (1 executions) | clean | AVG: 509,099,334 <br /> MIN: 509,099,334 <br /> MAX: 509,099,334 | AVG: 7,581,936,911 <br /> MIN: 7,581,936,911 <br /> MAX: 7,581,936,911 | AVG: 8,649,907 <br /> MIN: 8,649,907 <br /> MAX: 8,649,907 |
| sphincs-sha256-192f-robust (1 executions) | clean | AVG: 45,129,438 <br /> MIN: 45,129,438 <br /> MAX: 45,129,438 | AVG: 1,250,923,888 <br /> MIN: 1,250,923,888 <br /> MAX: 1,250,923,888 | AVG: 68,600,406 <br /> MIN: 68,600,406 <br /> MAX: 68,600,406 |
| sphincs-sha256-192f-simple (1 executions) | clean | AVG: 23,396,245 <br /> MIN: 23,396,245 <br /> MAX: 23,396,245 | AVG: 660,825,812 <br /> MIN: 660,825,812 <br /> MAX: 660,825,812 | AVG: 34,075,987 <br /> MIN: 34,075,987 <br /> MAX: 34,075,987 |
| sphincs-sha256-192s-robust (1 executions) | clean | AVG: 1,444,574,386 <br /> MIN: 1,444,574,386 <br /> MAX: 1,444,574,386 | AVG: 33,011,372,835 <br /> MIN: 33,011,372,835 <br /> MAX: 33,011,372,835 | AVG: 26,737,825 <br /> MIN: 26,737,825 <br /> MAX: 26,737,825 |
| sphincs-sha256-192s-simple (1 executions) | clean | AVG: 748,723,035 <br /> MIN: 748,723,035 <br /> MAX: 748,723,035 | AVG: 18,267,765,959 <br /> MIN: 18,267,765,959 <br /> MAX: 18,267,765,959 | AVG: 13,287,049 <br /> MIN: 13,287,049 <br /> MAX: 13,287,049 |
| sphincs-sha256-256f-robust (1 executions) | clean | AVG: 164,782,903 <br /> MIN: 164,782,903 <br /> MAX: 164,782,903 | AVG: 3,847,550,681 <br /> MIN: 3,847,550,681 <br /> MAX: 3,847,550,681 | AVG: 95,517,895 <br /> MIN: 95,517,895 <br /> MAX: 95,517,895 |
| sphincs-sha256-256f-simple (1 executions) | clean | AVG: 61,681,246 <br /> MIN: 61,681,246 <br /> MAX: 61,681,246 | AVG: 1,492,124,764 <br /> MIN: 1,492,124,764 <br /> MAX: 1,492,124,764 | AVG: 35,023,102 <br /> MIN: 35,023,102 <br /> MAX: 35,023,102 |
| sphincs-sha256-256s-robust (1 executions) | clean | AVG: 2,636,998,612 <br /> MIN: 2,636,998,612 <br /> MAX: 2,636,998,612 | AVG: 32,413,409,203 <br /> MIN: 32,413,409,203 <br /> MAX: 32,413,409,203 | AVG: 50,331,427 <br /> MIN: 50,331,427 <br /> MAX: 50,331,427 |
| sphincs-sha256-256s-simple (1 executions) | clean | AVG: 985,161,519 <br /> MIN: 985,161,519 <br /> MAX: 985,161,519 | AVG: 12,724,301,171 <br /> MIN: 12,724,301,171 <br /> MAX: 12,724,301,171 | AVG: 17,073,415 <br /> MIN: 17,073,415 <br /> MAX: 17,073,415 |
| sphincs-shake256-128f-robust (1 executions) | clean | AVG: 123,500,899 <br /> MIN: 123,500,899 <br /> MAX: 123,500,899 | AVG: 3,712,792,793 <br /> MIN: 3,712,792,793 <br /> MAX: 3,712,792,793 | AVG: 158,221,209 <br /> MIN: 158,221,209 <br /> MAX: 158,221,209 |
| sphincs-shake256-128f-simple (1 executions) | clean | AVG: 64,653,461 <br /> MIN: 64,653,461 <br /> MAX: 64,653,461 | AVG: 2,034,928,399 <br /> MIN: 2,034,928,399 <br /> MAX: 2,034,928,399 | AVG: 80,976,754 <br /> MIN: 80,976,754 <br /> MAX: 80,976,754 |
| sphincs-shake256-128s-robust (1 executions) | clean | AVG: 3,952,863,150 <br /> MIN: 3,952,863,150 <br /> MAX: 3,952,863,150 | AVG: 54,890,446,193 <br /> MIN: 54,890,446,193 <br /> MAX: 54,890,446,193 | AVG: 70,806,849 <br /> MIN: 70,806,849 <br /> MAX: 70,806,849 |
| sphincs-shake256-128s-simple (1 executions) | clean | AVG: 2,069,315,153 <br /> MIN: 2,069,315,153 <br /> MAX: 2,069,315,153 | AVG: 30,698,186,946 <br /> MIN: 30,698,186,946 <br /> MAX: 30,698,186,946 | AVG: 32,311,274 <br /> MIN: 32,311,274 <br /> MAX: 32,311,274 |
| sphincs-shake256-192f-robust (1 executions) | clean | AVG: 180,649,244 <br /> MIN: 180,649,244 <br /> MAX: 180,649,244 | AVG: 4,819,914,241 <br /> MIN: 4,819,914,241 <br /> MAX: 4,819,914,241 | AVG: 267,285,175 <br /> MIN: 267,285,175 <br /> MAX: 267,285,175 |
| sphincs-shake256-192f-simple (1 executions) | clean | AVG: 94,651,090 <br /> MIN: 94,651,090 <br /> MAX: 94,651,090 | AVG: 2,582,471,427 <br /> MIN: 2,582,471,427 <br /> MAX: 2,582,471,427 | AVG: 133,970,724 <br /> MIN: 133,970,724 <br /> MAX: 133,970,724 |
| sphincs-shake256-192s-robust (1 executions) | clean | AVG: 5,781,596,874 <br /> MIN: 5,781,596,874 <br /> MAX: 5,781,596,874 | AVG: 111,470,931,139 <br /> MIN: 111,470,931,139 <br /> MAX: 111,470,931,139 | AVG: 95,270,415 <br /> MIN: 95,270,415 <br /> MAX: 95,270,415 |
| sphincs-shake256-192s-simple (1 executions) | clean | AVG: 3,029,224,867 <br /> MIN: 3,029,224,867 <br /> MAX: 3,029,224,867 | AVG: 63,917,126,467 <br /> MIN: 63,917,126,467 <br /> MAX: 63,917,126,467 | AVG: 47,809,446 <br /> MIN: 47,809,446 <br /> MAX: 47,809,446 |
| sphincs-shake256-256f-robust (1 executions) | clean | AVG: 476,820,891 <br /> MIN: 476,820,891 <br /> MAX: 476,820,891 | AVG: 10,541,877,335 <br /> MIN: 10,541,877,335 <br /> MAX: 10,541,877,335 | AVG: 261,196,844 <br /> MIN: 261,196,844 <br /> MAX: 261,196,844 |
| sphincs-shake256-256f-simple (1 executions) | clean | AVG: 249,876,285 <br /> MIN: 249,876,285 <br /> MAX: 249,876,285 | AVG: 5,717,039,905 <br /> MIN: 5,717,039,905 <br /> MAX: 5,717,039,905 | AVG: 131,984,625 <br /> MIN: 131,984,625 <br /> MAX: 131,984,625 |
| sphincs-shake256-256s-robust (1 executions) | clean | AVG: 7,628,190,987 <br /> MIN: 7,628,190,987 <br /> MAX: 7,628,190,987 | AVG: 86,771,181,274 <br /> MIN: 86,771,181,274 <br /> MAX: 86,771,181,274 | AVG: 124,946,339 <br /> MIN: 124,946,339 <br /> MAX: 124,946,339 |
| sphincs-shake256-256s-simple (1 executions) | clean | AVG: 3,996,764,935 <br /> MIN: 3,996,764,935 <br /> MAX: 3,996,764,935 | AVG: 47,637,377,023 <br /> MIN: 47,637,377,023 <br /> MAX: 47,637,377,023 | AVG: 65,274,248 <br /> MIN: 65,274,248 <br /> MAX: 65,274,248 |
# Memory Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [bytes] | Encapsulation [bytes] | Decapsulation [bytes] |
| ------ | -------------- | ---------------------- | --------------------- | --------------------- |
| firesaber | clean | 19,524 | 19,628 | 21,108 |
| firesaber | m4f | 37,116 | 40,484 | 41,964 |
| frodokem640aes | m4 | 31,992 | 62,488 | 83,104 |
| frodokem640shake | m4 | 26,600 | 51,976 | 72,592 |
| frodokem640shake | opt | 36,664 | 58,320 | 78,944 |
| hqc-rmrs-128 | clean | 48,348 | 63,932 | 70,676 |
| kyber1024 | clean | 15,164 | 18,836 | 20,412 |
| kyber1024 | m4 | 3,788 | 3,476 | 3,508 |
| kyber1024-90s | clean | 15,340 | 19,020 | 20,596 |
| kyber1024-90s | m4 | 4,636 | 4,000 | 4,032 |
| kyber512 | clean | 6,292 | 8,956 | 9,732 |
| kyber512 | m4 | 2,396 | 2,484 | 2,500 |
| kyber512-90s | clean | 6,548 | 9,212 | 9,988 |
| kyber512-90s | m4 | 2,904 | 2,992 | 3,008 |
| kyber768 | clean | 10,388 | 13,556 | 14,652 |
| kyber768 | m4 | 3,276 | 2,964 | 2,988 |
| kyber768-90s | clean | 10,652 | 13,820 | 14,916 |
| kyber768-90s | m4 | 3,432 | 3,504 | 3,520 |
| lightsaber | clean | 9,332 | 9,436 | 10,180 |
| lightsaber | m4f | 14,604 | 16,252 | 16,996 |
| ntruhps2048509 | clean | 25,532 | 20,680 | 18,996 |
| ntruhps2048509 | m4f | 21,392 | 14,068 | 14,800 |
| ntruhps2048677 | clean | 34,296 | 27,756 | 25,548 |
| ntruhps2048677 | m4f | 28,504 | 9,036 | 19,728 |
| ntruhps4096821 | clean | 40,960 | 33,036 | 30,472 |
| ntruhps4096821 | m4f | 34,504 | 10,924 | 23,952 |
| ntruhrss701 | clean | 32,920 | 26,140 | 25,984 |
| ntruhrss701 | m4f | 27,560 | 7,400 | 20,552 |
| ntrulpr653 | clean | 11,864 | 12,048 | 13,416 |
| ntrulpr761 | clean | 10,784 | 12,376 | 13,864 |
| ntrulpr761 | m4f | 28,444 | 33,460 | 39,684 |
| ntrulpr857 | clean | 15,640 | 15,600 | 17,376 |
| saber | clean | 12,908 | 13,012 | 14,108 |
| saber | m4f | 23,284 | 32,620 | 33,824 |
| sikep434 | m4 | 6,272 | 6,504 | 6,840 |
| sikep434 | opt | 6,752 | 7,040 | 7,376 |
| sikep503 | m4 | 6,992 | 7,344 | 7,720 |
| sikep503 | opt | 6,664 | 7,016 | 7,392 |
| sikep610 | m4 | 10,504 | 10,904 | 11,368 |
| sikep610 | opt | 10,072 | 10,488 | 10,936 |
| sikep751 | m4 | 12,272 | 12,272 | 12,840 |
| sikep751 | opt | 11,616 | 11,728 | 12,296 |
| sntrup653 | clean | 10,664 | 8,096 | 9,656 |
| sntrup761 | clean | 12,284 | 9,256 | 11,200 |
| sntrup761 | m4f | 98,420 | 28,612 | 31,452 |
| sntrup857 | clean | 13,912 | 10,400 | 12,696 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| dilithium2 | clean | 36,396 | 61,292 | 40,644 |
| dilithium2 | m4 | 7,916 | 38,300 | 9,004 |
| dilithium2 | stack | 7,916 | 8,924 | 9,004 |
| dilithium3 | clean | 50,732 | 81,772 | 54,980 |
| dilithium3 | m4 | 8,940 | 52,756 | 10,028 |
| dilithium3 | stack | 8,940 | 9,948 | 10,028 |
| dilithium4 | clean | 67,116 | 104,388 | 71,452 |
| dilithium4 | m4 | 9,964 | 69,276 | 11,052 |
| dilithium4 | stack | 9,964 | 10,972 | 11,052 |
| falcon-1024 | clean | 35,256 | 82,484 | 8,796 |
| falcon-1024 | m4-ct | 1,432 | 2,680 | 492 |
| falcon-1024 | opt-ct | 1,504 | 2,568 | 496 |
| falcon-1024 | opt-leaktime | 1,408 | 2,672 | 492 |
| falcon-512 | clean | 18,392 | 42,460 | 4,700 |
| falcon-512 | m4-ct | 1,480 | 2,480 | 492 |
| falcon-512 | opt-ct | 1,488 | 2,479 | 492 |
| falcon-512 | opt-leaktime | 1,488 | 2,576 | 492 |
| falcon-512-tree | m4-ct | 1,440 | 2,776 | 492 |
| falcon-512-tree | opt-ct | 1,496 | 2,776 | 492 |
| falcon-512-tree | opt-leaktime | 1,400 | 2,792 | 492 |
| sphincs-haraka-128f-robust | clean | 3,612 | 3,704 | 4,068 |
| sphincs-haraka-128f-simple | clean | 3,604 | 3,696 | 4,060 |
| sphincs-haraka-128s-robust | clean | 3,824 | 3,872 | 3,408 |
| sphincs-haraka-128s-simple | clean | 3,816 | 3,784 | 3,372 |
| sphincs-haraka-192f-robust | clean | 5,128 | 5,080 | 5,396 |
| sphincs-haraka-192f-simple | clean | 5,012 | 5,072 | 5,388 |
| sphincs-haraka-192s-robust | clean | 5,312 | 5,296 | 4,840 |
| sphincs-haraka-192s-simple | clean | 5,304 | 5,288 | 4,752 |
| sphincs-haraka-256f-robust | clean | 7,040 | 7,008 | 6,660 |
| sphincs-haraka-256f-simple | clean | 7,004 | 7,000 | 6,652 |
| sphincs-haraka-256s-robust | clean | 7,320 | 7,232 | 6,596 |
| sphincs-haraka-256s-simple | clean | 7,304 | 7,224 | 6,588 |
| sphincs-sha256-128f-robust | clean | 2,264 | 2,328 | 2,720 |
| sphincs-sha256-128f-simple | clean | 2,104 | 2,168 | 2,560 |
| sphincs-sha256-128s-robust | clean | 2,488 | 2,528 | 2,032 |
| sphincs-sha256-128s-simple | clean | 2,288 | 2,368 | 1,872 |
| sphincs-sha256-192f-robust | clean | 3,680 | 3,824 | 4,056 |
| sphincs-sha256-192f-simple | clean | 3,512 | 3,544 | 3,888 |
| sphincs-sha256-192s-robust | clean | 3,984 | 3,960 | 3,392 |
| sphincs-sha256-192s-simple | clean | 3,776 | 3,792 | 3,224 |
| sphincs-sha256-256f-robust | clean | 5,680 | 5,760 | 5,328 |
| sphincs-sha256-256f-simple | clean | 5,504 | 5,584 | 5,152 |
| sphincs-sha256-256s-robust | clean | 5,992 | 5,904 | 5,264 |
| sphincs-sha256-256s-simple | clean | 5,816 | 5,728 | 5,088 |
| sphincs-shake256-128f-robust | clean | 2,180 | 2,236 | 2,628 |
| sphincs-shake256-128f-simple | clean | 2,180 | 2,344 | 2,628 |
| sphincs-shake256-128s-robust | clean | 2,364 | 2,432 | 1,940 |
| sphincs-shake256-128s-simple | clean | 2,400 | 2,432 | 1,940 |
| sphincs-shake256-192f-robust | clean | 3,596 | 3,728 | 3,964 |
| sphincs-shake256-192f-simple | clean | 3,596 | 3,620 | 3,964 |
| sphincs-shake256-192s-robust | clean | 3,896 | 3,864 | 3,300 |
| sphincs-shake256-192s-simple | clean | 3,896 | 3,864 | 3,300 |
| sphincs-shake256-256f-robust | clean | 5,632 | 5,664 | 5,236 |
| sphincs-shake256-256f-simple | clean | 5,596 | 5,664 | 5,280 |
| sphincs-shake256-256s-robust | clean | 5,904 | 5,808 | 5,172 |
| sphincs-shake256-256s-simple | clean | 5,904 | 5,808 | 5,172 |
# Hashing Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | Key Generation [%] | Encapsulation [%] | Decapsulation [%] |
| ------ | -------------- | ------------------ | ----------------- | ----------------- |
| firesaber | clean | 19.2% | 19.1% | 14.1% |
| firesaber | m4f | 70.9% | 70.1% | 60.1% |
| frodokem640aes | m4 | 74.3% | 77.8% | 77.1% |
| frodokem640shake | m4 | 85.5% | 86.5% | 86.2% |
| frodokem640shake | opt | 74.2% | 65.7% | 65.2% |
| hqc-rmrs-128 | clean | 53.6% | 41.4% | 33.2% |
| kyber1024 | clean | 54.9% | 54.3% | 43.2% |
| kyber1024 | m4 | 74.8% | 78.4% | 70.7% |
| kyber1024-90s | clean | 73.8% | 70.5% | 64.0% |
| kyber1024-90s | m4 | 66.5% | 69.0% | 62.3% |
| kyber512 | clean | 55.3% | 52.4% | 37.7% |
| kyber512 | m4 | 76.2% | 78.8% | 67.8% |
| kyber512-90s | clean | 68.7% | 62.7% | 52.6% |
| kyber512-90s | m4 | 68.6% | 70.3% | 60.8% |
| kyber768 | clean | 53.4% | 53.0% | 40.3% |
| kyber768 | m4 | 74.2% | 78.2% | 69.0% |
| kyber768-90s | clean | 71.4% | 67.4% | 59.4% |
| kyber768-90s | m4 | 66.0% | 69.0% | 61.1% |
| lightsaber | clean | 25.3% | 24.2% | 15.7% |
| lightsaber | m4f | 71.6% | 70.5% | 57.0% |
| ntruhps2048509 | clean | 0.0% | 2.5% | 4.2% |
| ntruhps2048509 | m4f | 0.0% | 4.7% | 19.2% |
| ntruhps2048677 | clean | 0.0% | 2.2% | 3.3% |
| ntruhps2048677 | m4f | 0.0% | 4.7% | 17.3% |
| ntruhps4096821 | clean | 0.0% | 1.7% | 2.9% |
| ntruhps4096821 | m4f | 0.0% | 3.8% | 16.1% |
| ntruhrss701 | clean | 0.0% | 2.6% | 3.5% |
| ntruhrss701 | m4f | 0.0% | 10.3% | 17.7% |
| ntrulpr653 | clean | 5.4% | 6.0% | 3.5% |
| ntrulpr761 | clean | 7.9% | 8.5% | 5.4% |
| ntrulpr761 | m4f | 20.9% | 35.6% | 31.8% |
| ntrulpr857 | clean | 4.2% | 4.6% | 2.7% |
| saber | clean | 22.0% | 21.7% | 15.2% |
| saber | m4f | 71.6% | 71.3% | 59.8% |
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
| dilithium2 | clean | 61.4% | 30.0% | 53.0% |
| dilithium2 | m4 | 82.2% | 58.9% | 77.3% |
| dilithium2 | stack | 82.2% | 75.9% | 77.3% |
| dilithium3 | clean | 66.0% | 31.2% | 57.1% |
| dilithium3 | m4 | 83.4% | 60.7% | 79.8% |
| dilithium3 | stack | 83.4% | 78.7% | 79.8% |
| dilithium4 | clean | 66.6% | 35.6% | 60.1% |
| dilithium4 | m4 | 85.1% | 64.1% | 81.6% |
| dilithium4 | stack | 85.1% | 79.2% | 81.6% |
| falcon-1024 | clean | 8.5% | 0.3% | 27.0% |
| falcon-1024 | m4-ct | 11.1% | 0.5% | 34.2% |
| falcon-1024 | opt-ct | 10.7% | 0.5% | 34.3% |
| falcon-1024 | opt-leaktime | 12.6% | 0.5% | 34.2% |
| falcon-512 | clean | 12.8% | 0.4% | 29.4% |
| falcon-512 | m4-ct | 15.9% | 0.5% | 36.0% |
| falcon-512 | opt-ct | 17.1% | 0.5% | 35.9% |
| falcon-512 | opt-leaktime | 18.4% | 0.6% | 36.0% |
| falcon-512-tree | m4-ct | 15.9% | 1.2% | 36.0% |
| falcon-512-tree | opt-ct | 17.0% | 1.2% | 35.9% |
| falcon-512-tree | opt-leaktime | 19.3% | 1.1% | 35.9% |
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
| sphincs-sha256-128f-robust | clean | 89.0% | 88.6% | 89.1% |
| sphincs-sha256-128f-simple | clean | 87.6% | 87.0% | 87.5% |
| sphincs-sha256-128s-robust | clean | 89.0% | 88.5% | 89.1% |
| sphincs-sha256-128s-simple | clean | 87.6% | 86.7% | 87.4% |
| sphincs-sha256-192f-robust | clean | 88.6% | 88.7% | 88.9% |
| sphincs-sha256-192f-simple | clean | 87.3% | 87.4% | 87.6% |
| sphincs-sha256-192s-robust | clean | 88.6% | 89.1% | 89.1% |
| sphincs-sha256-192s-simple | clean | 87.3% | 87.8% | 87.9% |
| sphincs-sha256-256f-robust | clean | 91.9% | 91.9% | 92.3% |
| sphincs-sha256-256f-simple | clean | 87.0% | 87.2% | 87.4% |
| sphincs-sha256-256s-robust | clean | 91.9% | 92.0% | 92.4% |
| sphincs-sha256-256s-simple | clean | 87.2% | 87.4% | 87.8% |
| sphincs-shake256-128f-robust | clean | 97.8% | 97.6% | 97.8% |
| sphincs-shake256-128f-simple | clean | 96.4% | 96.3% | 96.4% |
| sphincs-shake256-128s-robust | clean | 97.8% | 97.6% | 97.8% |
| sphincs-shake256-128s-simple | clean | 96.4% | 96.2% | 96.3% |
| sphincs-shake256-192f-robust | clean | 97.7% | 97.6% | 97.7% |
| sphincs-shake256-192f-simple | clean | 96.3% | 96.3% | 96.3% |
| sphincs-shake256-192s-robust | clean | 97.7% | 97.4% | 97.7% |
| sphincs-shake256-192s-simple | clean | 96.3% | 96.0% | 96.2% |
| sphincs-shake256-256f-robust | clean | 97.7% | 97.6% | 97.7% |
| sphincs-shake256-256f-simple | clean | 96.3% | 96.2% | 96.2% |
| sphincs-shake256-256s-robust | clean | 97.7% | 97.5% | 97.7% |
| sphincs-shake256-256s-simple | clean | 96.3% | 96.1% | 96.2% |
# Size Evaluation
## Key Encapsulation Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| firesaber | clean | 10,220 | 0 | 0 | 10,220 |
| firesaber | m4f | 10,972 | 0 | 0 | 10,972 |
| frodokem640aes | m4 | 8,568 | 0 | 0 | 8,568 |
| frodokem640shake | m4 | 8,644 | 0 | 0 | 8,644 |
| frodokem640shake | opt | 6,476 | 0 | 0 | 6,476 |
| hqc-rmrs-128 | clean | 18,460 | 0 | 0 | 18,460 |
| kyber1024 | clean | 6,084 | 0 | 0 | 6,084 |
| kyber1024 | m4 | 11,696 | 0 | 0 | 11,696 |
| kyber1024-90s | clean | 6,468 | 0 | 0 | 6,468 |
| kyber1024-90s | m4 | 11,976 | 0 | 0 | 11,976 |
| kyber512 | clean | 4,900 | 0 | 0 | 4,900 |
| kyber512 | m4 | 10,720 | 0 | 0 | 10,720 |
| kyber512-90s | clean | 5,148 | 0 | 0 | 5,148 |
| kyber512-90s | m4 | 10,932 | 0 | 0 | 10,932 |
| kyber768 | clean | 4,912 | 0 | 0 | 4,912 |
| kyber768 | m4 | 10,872 | 0 | 0 | 10,872 |
| kyber768-90s | clean | 5,172 | 0 | 0 | 5,172 |
| kyber768-90s | m4 | 10,848 | 0 | 0 | 10,848 |
| lightsaber | clean | 10,380 | 0 | 0 | 10,380 |
| lightsaber | m4f | 10,928 | 0 | 0 | 10,928 |
| ntruhps2048509 | clean | 64,644 | 0 | 0 | 64,644 |
| ntruhps2048509 | m4f | 91,656 | 0 | 0 | 91,656 |
| ntruhps2048677 | clean | 17,304 | 0 | 0 | 17,304 |
| ntruhps2048677 | m4f | 142,240 | 0 | 12,288 | 154,528 |
| ntruhps4096821 | clean | 17,064 | 0 | 0 | 17,064 |
| ntruhps4096821 | m4f | 167,356 | 0 | 13,824 | 181,180 |
| ntruhrss701 | clean | 16,724 | 0 | 0 | 16,724 |
| ntruhrss701 | m4f | 145,324 | 0 | 12,288 | 157,612 |
| ntrulpr653 | clean | 7,612 | 0 | 0 | 7,612 |
| ntrulpr761 | clean | 8,096 | 0 | 0 | 8,096 |
| ntrulpr761 | m4f | 114,281 | 0 | 0 | 114,281 |
| ntrulpr857 | clean | 8,340 | 0 | 0 | 8,340 |
| saber | clean | 10,128 | 0 | 0 | 10,128 |
| saber | m4f | 11,688 | 0 | 0 | 11,688 |
| sikep434 | m4 | 29,600 | 0 | 0 | 29,600 |
| sikep434 | opt | 28,232 | 0 | 0 | 28,232 |
| sikep503 | m4 | 31,576 | 0 | 0 | 31,576 |
| sikep503 | opt | 26,432 | 0 | 0 | 26,432 |
| sikep610 | m4 | 29,420 | 0 | 0 | 29,420 |
| sikep610 | opt | 19,420 | 0 | 0 | 19,420 |
| sikep751 | m4 | 33,012 | 0 | 0 | 33,012 |
| sikep751 | opt | 21,064 | 0 | 0 | 21,064 |
| sntrup653 | clean | 12,420 | 0 | 0 | 12,420 |
| sntrup761 | clean | 13,160 | 0 | 0 | 13,160 |
| sntrup761 | m4f | 146,845 | 40 | 6,952 | 153,837 |
| sntrup857 | clean | 13,536 | 0 | 0 | 13,536 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| dilithium2 | clean | 11,184 | 0 | 0 | 11,184 |
| dilithium2 | m4 | 20,212 | 0 | 0 | 20,212 |
| dilithium2 | stack | 20,224 | 0 | 0 | 20,224 |
| dilithium3 | clean | 11,068 | 0 | 0 | 11,068 |
| dilithium3 | m4 | 20,188 | 0 | 0 | 20,188 |
| dilithium3 | stack | 20,192 | 0 | 0 | 20,192 |
| dilithium4 | clean | 11,256 | 0 | 0 | 11,256 |
| dilithium4 | m4 | 20,340 | 0 | 0 | 20,340 |
| dilithium4 | stack | 20,320 | 0 | 0 | 20,320 |
| falcon-1024 | clean | 80,193 | 0 | 0 | 80,193 |
| falcon-1024 | m4-ct | 81,289 | 0 | 79,872 | 161,161 |
| falcon-1024 | opt-ct | 81,289 | 0 | 79,872 | 161,161 |
| falcon-1024 | opt-leaktime | 74,453 | 0 | 79,872 | 154,325 |
| falcon-512 | clean | 80,165 | 0 | 0 | 80,165 |
| falcon-512 | m4-ct | 81,289 | 0 | 39,936 | 121,225 |
| falcon-512 | opt-ct | 81,289 | 0 | 39,936 | 121,225 |
| falcon-512 | opt-leaktime | 74,453 | 0 | 39,936 | 114,389 |
| falcon-512-tree | m4-ct | 81,029 | 0 | 27,648 | 108,677 |
| falcon-512-tree | opt-ct | 81,029 | 0 | 27,648 | 108,677 |
| falcon-512-tree | opt-leaktime | 74,193 | 0 | 27,648 | 101,841 |
| sphincs-haraka-128f-robust | clean | 16,784 | 0 | 0 | 16,784 |
| sphincs-haraka-128f-simple | clean | 16,632 | 0 | 0 | 16,632 |
| sphincs-haraka-128s-robust | clean | 17,096 | 0 | 0 | 17,096 |
| sphincs-haraka-128s-simple | clean | 16,944 | 0 | 0 | 16,944 |
| sphincs-haraka-192f-robust | clean | 16,652 | 0 | 0 | 16,652 |
| sphincs-haraka-192f-simple | clean | 16,468 | 0 | 0 | 16,468 |
| sphincs-haraka-192s-robust | clean | 16,856 | 0 | 0 | 16,856 |
| sphincs-haraka-192s-simple | clean | 16,672 | 0 | 0 | 16,672 |
| sphincs-haraka-256f-robust | clean | 17,136 | 0 | 0 | 17,136 |
| sphincs-haraka-256f-simple | clean | 16,896 | 0 | 0 | 16,896 |
| sphincs-haraka-256s-robust | clean | 17,336 | 0 | 0 | 17,336 |
| sphincs-haraka-256s-simple | clean | 17,092 | 0 | 0 | 17,092 |
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
