# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| firesaber (100 executions) | clean | AVG: 3,742,077 <br /> MIN: 3,742,077 <br /> MAX: 3,742,077 | AVG: 4,652,854 <br /> MIN: 4,652,854 <br /> MAX: 4,652,854 | AVG: 5,099,065 <br /> MIN: 5,099,065 <br /> MAX: 5,099,065 |
| firesaber (100 executions) | m4 | AVG: 1,445,891 <br /> MIN: 1,445,891 <br /> MAX: 1,445,891 | AVG: 1,782,978 <br /> MIN: 1,782,978 <br /> MAX: 1,782,978 | AVG: 1,843,481 <br /> MIN: 1,843,481 <br /> MAX: 1,843,481 |
| frodokem640aes (100 executions) | m4 | AVG: 48,348,105 <br /> MIN: 48,348,105 <br /> MAX: 48,348,105 | AVG: 47,130,922 <br /> MIN: 47,130,922 <br /> MAX: 47,130,922 | AVG: 46,594,383 <br /> MIN: 46,594,383 <br /> MAX: 46,594,383 |
| frodokem640shake (100 executions) | m4 | AVG: 79,325,705 <br /> MIN: 79,325,705 <br /> MAX: 79,325,705 | AVG: 79,699,757 <br /> MIN: 79,699,757 <br /> MAX: 79,699,757 | AVG: 79,145,449 <br /> MIN: 79,145,449 <br /> MAX: 79,145,449 |
| frodokem640shake (100 executions) | opt | AVG: 91,896,318 <br /> MIN: 91,896,318 <br /> MAX: 91,896,318 | AVG: 104,912,447 <br /> MIN: 104,912,447 <br /> MAX: 104,912,447 | AVG: 104,638,561 <br /> MIN: 104,638,561 <br /> MAX: 104,638,561 |
| kyber1024 (100 executions) | clean | AVG: 1,901,335 <br /> MIN: 1,900,859 <br /> MAX: 1,901,899 | AVG: 2,260,972 <br /> MIN: 2,260,496 <br /> MAX: 2,261,536 | AVG: 2,416,774 <br /> MIN: 2,416,298 <br /> MAX: 2,417,338 |
| kyber1024 (100 executions) | m4 | AVG: 1,430,558 <br /> MIN: 1,430,058 <br /> MAX: 1,431,255 | AVG: 1,626,057 <br /> MIN: 1,625,562 <br /> MAX: 1,626,720 | AVG: 1,545,585 <br /> MIN: 1,545,090 <br /> MAX: 1,546,248 |
| kyber1024-90s (100 executions) | clean | AVG: 1,472,425 <br /> MIN: 1,472,014 <br /> MAX: 1,472,782 | AVG: 1,720,606 <br /> MIN: 1,720,195 <br /> MAX: 1,720,963 | AVG: 1,973,517 <br /> MIN: 1,973,106 <br /> MAX: 1,973,874 |
| kyber1024-90s (100 executions) | m4 | AVG: 1,009,844 <br /> MIN: 1,009,330 <br /> MAX: 1,010,446 | AVG: 1,099,057 <br /> MIN: 1,098,514 <br /> MAX: 1,099,708 | AVG: 1,115,677 <br /> MIN: 1,115,134 <br /> MAX: 1,116,328 |
| kyber512 (100 executions) | clean | AVG: 655,816 <br /> MIN: 655,614 <br /> MAX: 656,094 | AVG: 889,484 <br /> MIN: 889,282 <br /> MAX: 889,762 | AVG: 991,971 <br /> MIN: 991,769 <br /> MAX: 992,249 |
| kyber512 (100 executions) | m4 | AVG: 471,032 <br /> MIN: 470,798 <br /> MAX: 471,247 | AVG: 597,343 <br /> MIN: 597,109 <br /> MAX: 597,558 | AVG: 555,975 <br /> MIN: 555,741 <br /> MAX: 556,190 |
| kyber512-90s (100 executions) | clean | AVG: 512,648 <br /> MIN: 512,397 <br /> MAX: 512,941 | AVG: 676,469 <br /> MIN: 676,218 <br /> MAX: 676,762 | AVG: 831,859 <br /> MIN: 831,608 <br /> MAX: 832,152 |
| kyber512-90s (100 executions) | m4 | AVG: 330,674 <br /> MIN: 330,429 <br /> MAX: 330,849 | AVG: 387,138 <br /> MIN: 386,893 <br /> MAX: 387,313 | AVG: 398,673 <br /> MIN: 398,428 <br /> MAX: 398,848 |
| kyber768 (100 executions) | clean | AVG: 1,204,978 <br /> MIN: 1,204,533 <br /> MAX: 1,205,366 | AVG: 1,495,803 <br /> MIN: 1,495,358 <br /> MAX: 1,496,191 | AVG: 1,622,337 <br /> MIN: 1,621,892 <br /> MAX: 1,622,725 |
| kyber768 (100 executions) | m4 | AVG: 887,618 <br /> MIN: 887,173 <br /> MAX: 887,953 | AVG: 1,047,720 <br /> MIN: 1,047,308 <br /> MAX: 1,048,019 | AVG: 985,976 <br /> MIN: 985,564 <br /> MAX: 986,275 |
| kyber768-90s (100 executions) | clean | AVG: 936,990 <br /> MIN: 936,598 <br /> MAX: 937,329 | AVG: 1,135,877 <br /> MIN: 1,135,485 <br /> MAX: 1,136,216 | AVG: 1,337,409 <br /> MIN: 1,337,017 <br /> MAX: 1,337,748 |
| kyber768-90s (100 executions) | m4 | AVG: 624,485 <br /> MIN: 624,067 <br /> MAX: 625,074 | AVG: 695,432 <br /> MIN: 695,004 <br /> MAX: 696,031 | AVG: 708,683 <br /> MIN: 708,255 <br /> MAX: 709,282 |
| lightsaber (100 executions) | clean | AVG: 1,033,020 <br /> MIN: 1,033,020 <br /> MAX: 1,033,020 | AVG: 1,509,916 <br /> MIN: 1,509,916 <br /> MAX: 1,509,916 | AVG: 1,820,857 <br /> MIN: 1,820,857 <br /> MAX: 1,820,857 |
| lightsaber (100 executions) | m4 | AVG: 458,660 <br /> MIN: 458,660 <br /> MAX: 458,660 | AVG: 649,332 <br /> MIN: 649,332 <br /> MAX: 649,332 | AVG: 673,339 <br /> MIN: 673,339 <br /> MAX: 673,339 |
| ntruhps2048509 (100 executions) | clean | AVG: 111,492,425 <br /> MIN: 111,492,425 <br /> MAX: 111,492,425 | AVG: 3,066,947 <br /> MIN: 3,066,947 <br /> MAX: 3,066,947 | AVG: 7,884,197 <br /> MIN: 7,884,197 <br /> MAX: 7,884,197 |
| ntruhps2048509 (100 executions) | m4 | AVG: 79,686,034 <br /> MIN: 79,686,034 <br /> MAX: 79,686,034 | AVG: 577,135 <br /> MIN: 577,135 <br /> MAX: 577,135 | AVG: 545,283 <br /> MIN: 545,283 <br /> MAX: 545,283 |
| ntruhps2048677 (100 executions) | clean | AVG: 200,216,118 <br /> MIN: 200,216,118 <br /> MAX: 200,216,118 | AVG: 5,265,948 <br /> MIN: 5,265,948 <br /> MAX: 5,265,948 | AVG: 13,846,001 <br /> MIN: 13,846,001 <br /> MAX: 13,846,001 |
| ntruhps2048677 (100 executions) | m4 | AVG: 143,820,865 <br /> MIN: 143,820,865 <br /> MAX: 143,820,865 | AVG: 854,493 <br /> MIN: 854,493 <br /> MAX: 854,493 | AVG: 841,809 <br /> MIN: 841,809 <br /> MAX: 841,809 |
| ntruhps4096821 (100 executions) | clean | AVG: 297,661,023 <br /> MIN: 297,661,023 <br /> MAX: 297,661,023 | AVG: 7,590,614 <br /> MIN: 7,590,614 <br /> MAX: 7,590,614 | AVG: 20,275,565 <br /> MIN: 20,275,565 <br /> MAX: 20,275,565 |
| ntruhps4096821 (100 executions) | m4 | AVG: 208,965,432 <br /> MIN: 208,965,432 <br /> MAX: 208,965,432 | AVG: 1,077,000 <br /> MIN: 1,077,000 <br /> MAX: 1,077,000 | AVG: 1,073,275 <br /> MIN: 1,073,275 <br /> MAX: 1,073,275 |
| ntruhrss701 (100 executions) | clean | AVG: 214,355,083 <br /> MIN: 214,355,083 <br /> MAX: 214,355,083 | AVG: 5,149,624 <br /> MIN: 5,149,624 <br /> MAX: 5,149,624 | AVG: 14,880,399 <br /> MIN: 14,880,399 <br /> MAX: 14,880,399 |
| ntruhrss701 (100 executions) | m4 | AVG: 153,182,039 <br /> MIN: 153,182,039 <br /> MAX: 153,182,039 | AVG: 404,905 <br /> MIN: 404,905 <br /> MAX: 404,905 | AVG: 894,739 <br /> MIN: 894,739 <br /> MAX: 894,739 |
| ntrulpr653 (100 executions) | ref | AVG: 52,643,753 <br /> MIN: 52,643,753 <br /> MAX: 52,643,753 | AVG: 104,706,486 <br /> MIN: 104,706,486 <br /> MAX: 104,706,486 | AVG: 156,559,108 <br /> MIN: 156,559,108 <br /> MAX: 156,559,108 |
| ntrulpr761 (100 executions) | m4f | AVG: 830,885 <br /> MIN: 830,885 <br /> MAX: 830,885 | AVG: 1,317,654 <br /> MIN: 1,317,654 <br /> MAX: 1,317,654 | AVG: 1,499,988 <br /> MIN: 1,499,988 <br /> MAX: 1,499,988 |
| ntrulpr761 (100 executions) | ref | AVG: 71,314,438 <br /> MIN: 71,314,438 <br /> MAX: 71,314,438 | AVG: 141,912,418 <br /> MIN: 141,912,418 <br /> MAX: 141,912,418 | AVG: 212,280,542 <br /> MIN: 212,280,542 <br /> MAX: 212,280,542 |
| ntrulpr857 (100 executions) | ref | AVG: 90,283,987 <br /> MIN: 90,283,987 <br /> MAX: 90,283,987 | AVG: 179,731,561 <br /> MIN: 179,731,561 <br /> MAX: 179,731,561 | AVG: 268,923,453 <br /> MIN: 268,923,453 <br /> MAX: 268,923,453 |
| saber (100 executions) | clean | AVG: 2,179,303 <br /> MIN: 2,179,303 <br /> MAX: 2,179,303 | AVG: 2,885,871 <br /> MIN: 2,885,871 <br /> MAX: 2,885,871 | AVG: 3,351,158 <br /> MIN: 3,351,158 <br /> MAX: 3,351,158 |
| saber (100 executions) | m4 | AVG: 893,994 <br /> MIN: 893,994 <br /> MAX: 893,994 | AVG: 1,162,082 <br /> MIN: 1,162,082 <br /> MAX: 1,162,082 | AVG: 1,198,307 <br /> MIN: 1,198,307 <br /> MAX: 1,198,307 |
| sikep434 (100 executions) | m4 | AVG: 48,264,129 <br /> MIN: 48,264,129 <br /> MAX: 48,264,129 | AVG: 78,911,465 <br /> MIN: 78,911,465 <br /> MAX: 78,911,465 | AVG: 84,276,911 <br /> MIN: 84,276,911 <br /> MAX: 84,276,911 |
| sikep434 (100 executions) | opt | AVG: 643,140,813 <br /> MIN: 643,140,813 <br /> MAX: 643,140,813 | AVG: 1,053,374,539 <br /> MIN: 1,053,374,539 <br /> MAX: 1,053,374,539 | AVG: 1,123,506,035 <br /> MIN: 1,123,506,035 <br /> MAX: 1,123,506,035 |
| sikep503 (100 executions) | m4 | AVG: 67,365,363 <br /> MIN: 67,365,363 <br /> MAX: 67,365,363 | AVG: 110,846,067 <br /> MIN: 110,846,067 <br /> MAX: 110,846,067 | AVG: 117,993,160 <br /> MIN: 117,993,160 <br /> MAX: 117,993,160 |
| sikep503 (100 executions) | opt | AVG: 972,733,846 <br /> MIN: 972,733,846 <br /> MAX: 972,733,846 | AVG: 1,602,886,599 <br /> MIN: 1,602,886,599 <br /> MAX: 1,602,886,599 | AVG: 1,704,605,781 <br /> MIN: 1,704,605,781 <br /> MAX: 1,704,605,781 |
| sikep610 (100 executions) | m4 | AVG: 119,480,622 <br /> MIN: 119,480,622 <br /> MAX: 119,480,622 | AVG: 219,632,058 <br /> MIN: 219,632,058 <br /> MAX: 219,632,058 | AVG: 221,029,700 <br /> MIN: 221,029,700 <br /> MAX: 221,029,700 |
| sikep610 (100 executions) | opt | AVG: 1,815,959,387 <br /> MIN: 1,815,959,387 <br /> MAX: 1,815,959,387 | AVG: 3,341,196,195 <br /> MIN: 3,341,196,195 <br /> MAX: 3,341,196,195 | AVG: 3,360,955,305 <br /> MIN: 3,360,955,305 <br /> MAX: 3,360,955,305 |
| sikep751 (100 executions) | m4 | AVG: 204,646,661 <br /> MIN: 204,646,661 <br /> MAX: 204,646,661 | AVG: 331,934,480 <br /> MIN: 331,934,480 <br /> MAX: 331,934,480 | AVG: 356,425,812 <br /> MIN: 356,425,812 <br /> MAX: 356,425,812 |
| sikep751 (100 executions) | opt | AVG: 3,288,678,781 <br /> MIN: 3,288,678,781 <br /> MAX: 3,288,678,781 | AVG: 5,333,567,877 <br /> MIN: 5,333,567,877 <br /> MAX: 5,333,567,877 | AVG: 5,728,790,883 <br /> MIN: 5,728,790,883 <br /> MAX: 5,728,790,883 |
| sntrup653 (100 executions) | ref | AVG: 548,355,501 <br /> MIN: 538,684,068 <br /> MAX: 780,469,915 | AVG: 52,679,631 <br /> MIN: 52,679,618 <br /> MAX: 52,679,632 | AVG: 159,534,443 <br /> MIN: 159,534,442 <br /> MAX: 159,534,473 |
| sntrup761 (100 executions) | m4f | AVG: 11,392,072 <br /> MIN: 11,392,072 <br /> MAX: 11,392,072 | AVG: 794,049 <br /> MIN: 794,049 <br /> MAX: 794,049 | AVG: 743,378 <br /> MIN: 743,378 <br /> MAX: 743,378 |
| sntrup761 (100 executions) | ref | AVG: 728,600,979 <br /> MIN: 728,600,979 <br /> MAX: 728,600,979 | AVG: 71,354,215 <br /> MIN: 71,354,215 <br /> MAX: 71,354,215 | AVG: 216,152,106 <br /> MIN: 216,152,106 <br /> MAX: 216,152,106 |
| sntrup857 (100 executions) | ref | AVG: 920,319,337 <br /> MIN: 920,319,337 <br /> MAX: 920,319,337 | AVG: 90,319,892 <br /> MIN: 90,319,892 <br /> MAX: 90,319,892 | AVG: 274,303,217 <br /> MIN: 274,303,217 <br /> MAX: 274,303,217 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| dilithium2 (100 executions) | clean | AVG: 1,614,477 <br /> MIN: 1,613,563 <br /> MAX: 1,626,981 | AVG: 8,032,479 <br /> MIN: 2,987,832 <br /> MAX: 36,923,036 | AVG: 1,830,445 <br /> MIN: 1,829,963 <br /> MAX: 1,830,901 |
| dilithium2 (100 executions) | m4 | AVG: 1,407,272 <br /> MIN: 1,406,859 <br /> MAX: 1,407,763 | AVG: 4,331,922 <br /> MIN: 1,805,767 <br /> MAX: 17,876,042 | AVG: 1,374,748 <br /> MIN: 1,374,336 <br /> MAX: 1,375,098 |
| dilithium3 (100 executions) | clean | AVG: 2,539,785 <br /> MIN: 2,538,961 <br /> MAX: 2,540,640 | AVG: 11,759,429 <br /> MIN: 4,161,883 <br /> MAX: 64,856,628 | AVG: 2,671,904 <br /> MIN: 2,671,471 <br /> MAX: 2,672,362 |
| dilithium3 (100 executions) | m4 | AVG: 2,156,465 <br /> MIN: 2,155,790 <br /> MAX: 2,157,193 | AVG: 7,314,596 <br /> MIN: 2,656,760 <br /> MAX: 27,632,645 | AVG: 2,090,983 <br /> MIN: 2,090,722 <br /> MAX: 2,091,343 |
| dilithium4 (100 executions) | clean | AVG: 3,398,499 <br /> MIN: 3,398,034 <br /> MAX: 3,398,906 | AVG: 12,168,851 <br /> MIN: 5,509,148 <br /> MAX: 52,054,919 | AVG: 3,684,357 <br /> MIN: 3,683,668 <br /> MAX: 3,684,920 |
| dilithium4 (100 executions) | m4 | AVG: 3,046,239 <br /> MIN: 3,045,914 <br /> MAX: 3,046,773 | AVG: 6,846,027 <br /> MIN: 3,657,053 <br /> MAX: 20,885,859 | AVG: 2,962,577 <br /> MIN: 2,962,265 <br /> MAX: 2,962,975 |
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
| firesaber | clean | 22,700 | 25,556 | 27,036 |
| firesaber | m4 | 20,124 | 22,972 | 24,452 |
| frodokem640aes | m4 | 31,992 | 62,488 | 83,104 |
| frodokem640shake | m4 | 26,600 | 51,976 | 72,592 |
| frodokem640shake | opt | 36,664 | 58,320 | 78,944 |
| kyber1024 | clean | 15,164 | 18,844 | 20,420 |
| kyber1024 | m4 | 3,788 | 3,484 | 3,516 |
| kyber1024-90s | clean | 15,736 | 19,416 | 20,332 |
| kyber1024-90s | m4 | 5,032 | 4,000 | 4,032 |
| kyber512 | clean | 6,452 | 9,116 | 9,860 |
| kyber512 | m4 | 2,388 | 2,476 | 2,492 |
| kyber512-90s | clean | 6,976 | 9,640 | 10,384 |
| kyber512-90s | m4 | 2,904 | 2,992 | 3,008 |
| kyber768 | clean | 10,556 | 13,724 | 14,820 |
| kyber768 | m4 | 3,276 | 2,972 | 2,996 |
| kyber768-90s | clean | 11,080 | 14,248 | 15,344 |
| kyber768-90s | m4 | 3,976 | 3,488 | 3,512 |
| lightsaber | clean | 10,540 | 12,276 | 13,020 |
| lightsaber | m4 | 9,652 | 11,388 | 12,132 |
| ntruhps2048509 | clean | 11,848 | 6,864 | 5,144 |
| ntruhps2048509 | m4 | 21,392 | 15,424 | 14,800 |
| ntruhps2048677 | clean | 15,680 | 9,036 | 6,792 |
| ntruhps2048677 | m4 | 28,504 | 20,576 | 19,728 |
| ntruhps4096821 | clean | 18,968 | 10,924 | 8,408 |
| ntruhps4096821 | m4 | 34,504 | 24,904 | 23,952 |
| ntruhrss701 | clean | 14,304 | 7,400 | 8,592 |
| ntruhrss701 | m4 | 27,560 | 19,352 | 20,552 |
| ntrulpr653 | ref | 12,204 | 18,468 | 23,012 |
| ntrulpr761 | m4f | 28,444 | 33,460 | 39,684 |
| ntrulpr761 | ref | 14,012 | 21,100 | 26,396 |
| ntrulpr857 | ref | 15,668 | 23,532 | 29,500 |
| saber | clean | 15,792 | 17,964 | 19,060 |
| saber | m4 | 13,252 | 15,516 | 16,612 |
| sikep434 | m4 | 6,272 | 6,504 | 6,840 |
| sikep434 | opt | 6,752 | 7,040 | 7,376 |
| sikep503 | m4 | 6,992 | 7,344 | 7,720 |
| sikep503 | opt | 6,664 | 7,016 | 7,392 |
| sikep610 | m4 | 10,504 | 10,904 | 11,368 |
| sikep610 | opt | 10,072 | 10,488 | 10,936 |
| sikep751 | m4 | 12,272 | 12,272 | 12,840 |
| sikep751 | opt | 11,616 | 11,728 | 12,296 |
| sntrup653 | ref | 13,972 | 13,964 | 16,660 |
| sntrup761 | m4f | 98,420 | 28,612 | 31,452 |
| sntrup761 | ref | 16,244 | 15,988 | 19,116 |
| sntrup857 | ref | 18,260 | 17,868 | 21,404 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| dilithium2 | clean | 36,396 | 61,292 | 40,644 |
| dilithium2 | m4 | 32,324 | 54,156 | 31,460 |
| dilithium3 | clean | 50,732 | 81,772 | 54,980 |
| dilithium3 | m4 | 45,636 | 72,596 | 43,748 |
| dilithium4 | clean | 67,116 | 104,388 | 71,452 |
| dilithium4 | m4 | 60,996 | 93,076 | 58,084 |
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
| firesaber | clean | 19.1% | 18.9% | 14.5% |
| firesaber | m4 | 49.4% | 49.4% | 40.1% |
| frodokem640aes | m4 | 74.3% | 77.8% | 77.1% |
| frodokem640shake | m4 | 85.5% | 86.5% | 86.2% |
| frodokem640shake | opt | 74.2% | 65.7% | 65.2% |
| kyber1024 | clean | 58.4% | 57.7% | 47.1% |
| kyber1024 | m4 | 77.5% | 80.1% | 73.5% |
| kyber1024-90s | clean | 44.8% | 43.2% | 34.4% |
| kyber1024-90s | m4 | 64.1% | 66.2% | 59.5% |
| kyber512 | clean | 54.0% | 53.1% | 38.5% |
| kyber512 | m4 | 75.0% | 78.9% | 68.6% |
| kyber512-90s | clean | 40.2% | 37.7% | 26.3% |
| kyber512-90s | m4 | 61.2% | 64.6% | 53.8% |
| kyber768 | clean | 56.5% | 55.9% | 43.7% |
| kyber768 | m4 | 76.5% | 79.7% | 71.7% |
| kyber768-90s | clean | 42.7% | 40.9% | 31.1% |
| kyber768-90s | m4 | 62.9% | 65.6% | 57.3% |
| lightsaber | clean | 25.1% | 24.0% | 15.6% |
| lightsaber | m4 | 56.5% | 55.8% | 42.2% |
| ntruhps2048509 | clean | 0.0% | 0.9% | 1.3% |
| ntruhps2048509 | m4 | 0.0% | 4.6% | 18.9% |
| ntruhps2048677 | clean | 0.0% | 0.7% | 1.0% |
| ntruhps2048677 | m4 | 0.0% | 4.6% | 16.7% |
| ntruhps4096821 | clean | 0.0% | 0.5% | 0.8% |
| ntruhps4096821 | m4 | 0.0% | 3.6% | 15.5% |
| ntruhrss701 | clean | 0.0% | 0.8% | 1.0% |
| ntruhrss701 | m4 | 0.0% | 9.6% | 17.2% |
| ntrulpr653 | ref | 0.4% | 0.4% | 0.3% |
| ntrulpr761 | m4f | 20.8% | 26.2% | 23.0% |
| ntrulpr761 | ref | 0.4% | 0.4% | 0.2% |
| ntrulpr857 | ref | 0.3% | 0.3% | 0.2% |
| saber | clean | 21.8% | 21.3% | 14.9% |
| saber | m4 | 53.0% | 52.8% | 41.7% |
| sikep434 | m4 | 0.0% | 0.1% | 0.1% |
| sikep434 | opt | 0.0% | 0.0% | 0.0% |
| sikep503 | m4 | 0.0% | 0.1% | 0.1% |
| sikep503 | opt | 0.0% | 0.0% | 0.0% |
| sikep610 | m4 | 0.0% | 0.1% | 0.1% |
| sikep610 | opt | 0.0% | 0.0% | 0.0% |
| sikep751 | m4 | 0.0% | 0.0% | 0.0% |
| sikep751 | opt | 0.0% | 0.0% | 0.0% |
| sntrup653 | ref | 0.0% | 0.4% | 0.1% |
| sntrup761 | m4f | 0.0% | 0.0% | 0.0% |
| sntrup761 | ref | 0.0% | 0.3% | 0.1% |
| sntrup857 | ref | 0.0% | 0.3% | 0.0% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| dilithium2 | clean | 61.4% | 30.0% | 53.0% |
| dilithium2 | m4 | 77.1% | 53.3% | 70.8% |
| dilithium3 | clean | 66.0% | 31.2% | 57.1% |
| dilithium3 | m4 | 78.1% | 52.8% | 73.3% |
| dilithium4 | clean | 66.6% | 35.6% | 60.1% |
| dilithium4 | m4 | 79.2% | 57.6% | 75.0% |
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
| firesaber | clean | 11,832 | 0 | 0 | 11,832 |
| firesaber | m4 | 44,424 | 0 | 0 | 44,424 |
| frodokem640aes | m4 | 8,568 | 0 | 0 | 8,568 |
| frodokem640shake | m4 | 8,644 | 0 | 0 | 8,644 |
| frodokem640shake | opt | 6,476 | 0 | 0 | 6,476 |
| kyber1024 | clean | 5,752 | 0 | 0 | 5,752 |
| kyber1024 | m4 | 11,580 | 0 | 0 | 11,580 |
| kyber1024-90s | clean | 5,896 | 0 | 0 | 5,896 |
| kyber1024-90s | m4 | 11,744 | 0 | 0 | 11,744 |
| kyber512 | clean | 5,060 | 0 | 0 | 5,060 |
| kyber512 | m4 | 10,472 | 0 | 0 | 10,472 |
| kyber512-90s | clean | 5,216 | 0 | 0 | 5,216 |
| kyber512-90s | m4 | 10,628 | 0 | 0 | 10,628 |
| kyber768 | clean | 5,176 | 0 | 0 | 5,176 |
| kyber768 | m4 | 10,760 | 0 | 0 | 10,760 |
| kyber768-90s | clean | 5,332 | 0 | 0 | 5,332 |
| kyber768-90s | m4 | 10,924 | 0 | 0 | 10,924 |
| lightsaber | clean | 11,952 | 0 | 0 | 11,952 |
| lightsaber | m4 | 44,576 | 0 | 0 | 44,576 |
| ntruhps2048509 | clean | 5,896 | 0 | 0 | 5,896 |
| ntruhps2048509 | m4 | 89,020 | 0 | 0 | 89,020 |
| ntruhps2048677 | clean | 5,908 | 0 | 0 | 5,908 |
| ntruhps2048677 | m4 | 129,440 | 0 | 0 | 129,440 |
| ntruhps4096821 | clean | 5,596 | 0 | 0 | 5,596 |
| ntruhps4096821 | m4 | 154,388 | 0 | 0 | 154,388 |
| ntruhrss701 | clean | 5,804 | 0 | 0 | 5,804 |
| ntruhrss701 | m4 | 132,160 | 0 | 0 | 132,160 |
| ntrulpr653 | ref | 4,452 | 0 | 0 | 4,452 |
| ntrulpr761 | m4f | 114,293 | 0 | 0 | 114,293 |
| ntrulpr761 | ref | 4,456 | 0 | 0 | 4,456 |
| ntrulpr857 | ref | 4,564 | 0 | 0 | 4,564 |
| saber | clean | 11,868 | 0 | 0 | 11,868 |
| saber | m4 | 44,444 | 0 | 0 | 44,444 |
| sikep434 | m4 | 29,600 | 0 | 0 | 29,600 |
| sikep434 | opt | 28,232 | 0 | 0 | 28,232 |
| sikep503 | m4 | 31,576 | 0 | 0 | 31,576 |
| sikep503 | opt | 26,432 | 0 | 0 | 26,432 |
| sikep610 | m4 | 29,420 | 0 | 0 | 29,420 |
| sikep610 | opt | 19,420 | 0 | 0 | 19,420 |
| sikep751 | m4 | 33,012 | 0 | 0 | 33,012 |
| sikep751 | opt | 21,064 | 0 | 0 | 21,064 |
| sntrup653 | ref | 5,980 | 0 | 0 | 5,980 |
| sntrup761 | m4f | 146,845 | 40 | 6,952 | 153,837 |
| sntrup761 | ref | 6,176 | 0 | 0 | 6,176 |
| sntrup857 | ref | 6,180 | 0 | 0 | 6,180 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| dilithium2 | clean | 11,184 | 0 | 0 | 11,184 |
| dilithium2 | m4 | 17,736 | 0 | 0 | 17,736 |
| dilithium3 | clean | 11,068 | 0 | 0 | 11,068 |
| dilithium3 | m4 | 17,676 | 0 | 0 | 17,676 |
| dilithium4 | clean | 11,256 | 0 | 0 | 11,256 |
| dilithium4 | m4 | 17,824 | 0 | 0 | 17,824 |
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
