# Speed Evaluation
## Key Encapsulation Schemes
| scheme | implementation | key generation [cycles] | encapsulation [cycles] | decapsulation [cycles] |
| ------ | -------------- | ----------------------- | ---------------------- | ---------------------- |
| babybear (100 executions) | clean | AVG: 4,040,567 <br /> MIN: 4,040,567 <br /> MAX: 4,040,567 | AVG: 5,890,050 <br /> MIN: 5,890,050 <br /> MAX: 5,890,050 | AVG: 12,012,511 <br /> MIN: 12,012,511 <br /> MAX: 12,012,511 |
| babybear (100 executions) | opt | AVG: 678,841 <br /> MIN: 678,841 <br /> MAX: 678,841 | AVG: 858,588 <br /> MIN: 858,588 <br /> MAX: 858,588 | AVG: 1,331,463 <br /> MIN: 1,331,463 <br /> MAX: 1,331,463 |
| babybear-ephem (100 executions) | clean | AVG: 4,040,567 <br /> MIN: 4,040,567 <br /> MAX: 4,040,567 | AVG: 5,916,913 <br /> MIN: 5,916,913 <br /> MAX: 5,916,913 | AVG: 1,992,862 <br /> MIN: 1,992,862 <br /> MAX: 1,992,862 |
| babybear-ephem (100 executions) | opt | AVG: 678,840 <br /> MIN: 678,840 <br /> MAX: 678,840 | AVG: 885,163 <br /> MIN: 885,163 <br /> MAX: 885,163 | AVG: 290,198 <br /> MIN: 290,198 <br /> MAX: 290,198 |
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
| lac-128-v3a (100 executions) | opt | AVG: 850,580 <br /> MIN: 845,974 <br /> MAX: 854,167 | AVG: 1,429,623 <br /> MIN: 1,424,453 <br /> MAX: 1,436,738 | AVG: 1,959,971 <br /> MIN: 1,954,123 <br /> MAX: 1,966,296 |
| lac-128-v3a (100 executions) | ref | AVG: 1,405,100 <br /> MIN: 1,404,853 <br /> MAX: 1,408,213 | AVG: 2,399,325 <br /> MIN: 2,399,079 <br /> MAX: 2,402,439 | AVG: 3,345,990 <br /> MIN: 3,345,675 <br /> MAX: 3,349,082 |
| lac-128-v3b (100 executions) | opt | AVG: 838,222 <br /> MIN: 834,260 <br /> MAX: 840,916 | AVG: 1,414,379 <br /> MIN: 1,408,040 <br /> MAX: 1,420,136 | AVG: 1,938,640 <br /> MIN: 1,932,946 <br /> MAX: 1,945,054 |
| lac-128-v3b (100 executions) | ref | AVG: 1,262,836 <br /> MIN: 1,262,836 <br /> MAX: 1,262,836 | AVG: 2,156,580 <br /> MIN: 2,156,580 <br /> MAX: 2,156,580 | AVG: 2,999,306 <br /> MIN: 2,999,236 <br /> MAX: 2,999,368 |
| lac-192-v3a (100 executions) | opt | AVG: 1,506,725 <br /> MIN: 1,498,109 <br /> MAX: 1,517,899 | AVG: 2,427,256 <br /> MIN: 2,413,903 <br /> MAX: 2,442,483 | AVG: 3,329,635 <br /> MIN: 3,315,962 <br /> MAX: 3,342,119 |
| lac-192-v3a (100 executions) | ref | AVG: 2,355,311 <br /> MIN: 2,355,140 <br /> MAX: 2,358,606 | AVG: 3,816,155 <br /> MIN: 3,815,984 <br /> MAX: 3,819,450 | AVG: 5,261,134 <br /> MIN: 5,260,867 <br /> MAX: 5,264,447 |
| lac-192-v3b (100 executions) | opt | AVG: 1,483,518 <br /> MIN: 1,475,270 <br /> MAX: 1,495,238 | AVG: 2,396,247 <br /> MIN: 2,383,051 <br /> MAX: 2,410,771 | AVG: 3,290,104 <br /> MIN: 3,274,439 <br /> MAX: 3,306,195 |
| lac-192-v3b (100 executions) | ref | AVG: 2,593,395 <br /> MIN: 2,593,395 <br /> MAX: 2,593,395 | AVG: 4,216,804 <br /> MIN: 4,216,804 <br /> MAX: 4,216,804 | AVG: 5,820,552 <br /> MIN: 5,820,471 <br /> MAX: 5,820,639 |
| lac-256-v3a (100 executions) | opt | AVG: 2,019,305 <br /> MIN: 2,009,946 <br /> MAX: 2,029,532 | AVG: 3,632,140 <br /> MIN: 3,612,893 <br /> MAX: 3,654,861 | AVG: 5,326,284 <br /> MIN: 5,306,105 <br /> MAX: 5,347,008 |
| lac-256-v3a (100 executions) | ref | AVG: 3,490,042 <br /> MIN: 3,489,931 <br /> MAX: 3,490,131 | AVG: 6,365,490 <br /> MIN: 6,365,379 <br /> MAX: 6,365,579 | AVG: 9,323,913 <br /> MIN: 9,323,648 <br /> MAX: 9,324,105 |
| lac-256-v3b (100 executions) | opt | AVG: 1,995,898 <br /> MIN: 1,987,640 <br /> MAX: 2,005,560 | AVG: 3,602,176 <br /> MIN: 3,585,802 <br /> MAX: 3,616,266 | AVG: 5,284,720 <br /> MIN: 5,269,246 <br /> MAX: 5,303,034 |
| lac-256-v3b (100 executions) | ref | AVG: 3,466,405 <br /> MIN: 3,466,405 <br /> MAX: 3,466,405 | AVG: 6,335,071 <br /> MIN: 6,335,071 <br /> MAX: 6,335,071 | AVG: 9,281,674 <br /> MIN: 9,281,575 <br /> MAX: 9,281,764 |
| lac-light-v3a (100 executions) | opt | AVG: 446,806 <br /> MIN: 443,375 <br /> MAX: 451,200 | AVG: 672,562 <br /> MIN: 667,154 <br /> MAX: 681,065 | AVG: 862,517 <br /> MIN: 857,788 <br /> MAX: 870,249 |
| lac-light-v3a (100 executions) | ref | AVG: 722,879 <br /> MIN: 722,623 <br /> MAX: 726,005 | AVG: 1,093,993 <br /> MIN: 1,093,737 <br /> MAX: 1,097,119 | AVG: 1,430,436 <br /> MIN: 1,430,101 <br /> MAX: 1,433,606 |
| lac-light-v3b (100 executions) | opt | AVG: 434,424 <br /> MIN: 431,816 <br /> MAX: 436,936 | AVG: 657,519 <br /> MIN: 652,188 <br /> MAX: 663,164 | AVG: 843,914 <br /> MIN: 839,144 <br /> MAX: 850,368 |
| lac-light-v3b (100 executions) | ref | AVG: 645,992 <br /> MIN: 645,992 <br /> MAX: 645,992 | AVG: 980,704 <br /> MIN: 980,704 <br /> MAX: 980,704 | AVG: 1,278,903 <br /> MIN: 1,278,850 <br /> MAX: 1,278,962 |
| lightsaber (100 executions) | clean | AVG: 1,033,020 <br /> MIN: 1,033,020 <br /> MAX: 1,033,020 | AVG: 1,509,916 <br /> MIN: 1,509,916 <br /> MAX: 1,509,916 | AVG: 1,820,857 <br /> MIN: 1,820,857 <br /> MAX: 1,820,857 |
| lightsaber (100 executions) | m4 | AVG: 458,660 <br /> MIN: 458,660 <br /> MAX: 458,660 | AVG: 649,332 <br /> MIN: 649,332 <br /> MAX: 649,332 | AVG: 673,339 <br /> MIN: 673,339 <br /> MAX: 673,339 |
| mamabear (100 executions) | clean | AVG: 8,872,478 <br /> MIN: 8,872,478 <br /> MAX: 8,872,478 | AVG: 11,613,444 <br /> MIN: 11,613,444 <br /> MAX: 11,613,444 | AVG: 23,541,053 <br /> MIN: 23,541,053 <br /> MAX: 23,541,053 |
| mamabear (100 executions) | opt | AVG: 1,329,473 <br /> MIN: 1,329,473 <br /> MAX: 1,329,473 | AVG: 1,566,826 <br /> MIN: 1,566,826 <br /> MAX: 1,566,826 | AVG: 2,238,894 <br /> MIN: 2,238,894 <br /> MAX: 2,238,894 |
| mamabear-ephem (100 executions) | clean | AVG: 8,885,649 <br /> MIN: 8,885,649 <br /> MAX: 8,885,649 | AVG: 11,656,053 <br /> MIN: 11,656,053 <br /> MAX: 11,656,053 | AVG: 2,934,701 <br /> MIN: 2,934,701 <br /> MAX: 2,934,701 |
| mamabear-ephem (100 executions) | opt | AVG: 1,341,937 <br /> MIN: 1,341,937 <br /> MAX: 1,341,937 | AVG: 1,608,220 <br /> MIN: 1,608,220 <br /> MAX: 1,608,220 | AVG: 399,162 <br /> MIN: 399,162 <br /> MAX: 399,162 |
| newhope1024cca (100 executions) | clean | AVG: 1,448,539 <br /> MIN: 1,448,096 <br /> MAX: 1,448,831 | AVG: 2,242,470 <br /> MIN: 2,242,027 <br /> MAX: 2,242,762 | AVG: 2,380,184 <br /> MIN: 2,379,741 <br /> MAX: 2,380,476 |
| newhope1024cca (100 executions) | m4 | AVG: 1,157,930 <br /> MIN: 1,157,590 <br /> MAX: 1,158,253 | AVG: 1,689,189 <br /> MIN: 1,688,849 <br /> MAX: 1,689,512 | AVG: 1,613,694 <br /> MIN: 1,613,354 <br /> MAX: 1,614,017 |
| newhope1024cpa (100 executions) | clean | AVG: 1,263,006 <br /> MIN: 1,262,724 <br /> MAX: 1,263,324 | AVG: 1,835,444 <br /> MIN: 1,835,162 <br /> MAX: 1,835,762 | AVG: 327,590 <br /> MIN: 327,590 <br /> MAX: 327,590 |
| newhope1024cpa (100 executions) | m4 | AVG: 978,169 <br /> MIN: 977,781 <br /> MAX: 978,546 | AVG: 1,282,175 <br /> MIN: 1,281,787 <br /> MAX: 1,282,552 | AVG: 129,651 <br /> MIN: 129,651 <br /> MAX: 129,651 |
| newhope512cca (100 executions) | clean | AVG: 713,172 <br /> MIN: 712,905 <br /> MAX: 713,415 | AVG: 1,121,555 <br /> MIN: 1,121,288 <br /> MAX: 1,121,798 | AVG: 1,175,581 <br /> MIN: 1,175,314 <br /> MAX: 1,175,824 |
| newhope512cca (100 executions) | m4 | AVG: 579,153 <br /> MIN: 578,910 <br /> MAX: 579,403 | AVG: 866,063 <br /> MIN: 865,820 <br /> MAX: 866,313 | AVG: 820,110 <br /> MIN: 819,867 <br /> MAX: 820,360 |
| newhope512cpa (100 executions) | clean | AVG: 621,596 <br /> MIN: 621,404 <br /> MAX: 621,809 | AVG: 903,459 <br /> MIN: 903,267 <br /> MAX: 903,672 | AVG: 162,819 <br /> MIN: 162,819 <br /> MAX: 162,819 |
| newhope512cpa (100 executions) | m4 | AVG: 488,236 <br /> MIN: 487,963 <br /> MAX: 488,524 | AVG: 647,974 <br /> MIN: 647,701 <br /> MAX: 648,262 | AVG: 71,434 <br /> MIN: 71,434 <br /> MAX: 71,434 |
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
| papabear (100 executions) | clean | AVG: 15,605,680 <br /> MIN: 15,605,680 <br /> MAX: 15,605,680 | AVG: 19,240,990 <br /> MIN: 19,240,990 <br /> MAX: 19,240,990 | AVG: 38,867,571 <br /> MIN: 38,867,571 <br /> MAX: 38,867,571 |
| papabear (100 executions) | opt | AVG: 2,213,821 <br /> MIN: 2,213,821 <br /> MAX: 2,213,821 | AVG: 2,511,356 <br /> MIN: 2,511,356 <br /> MAX: 2,511,356 | AVG: 3,389,776 <br /> MIN: 3,389,776 <br /> MAX: 3,389,776 |
| papabear-ephem (100 executions) | clean | AVG: 15,623,227 <br /> MIN: 15,623,227 <br /> MAX: 15,623,227 | AVG: 19,287,653 <br /> MIN: 19,287,653 <br /> MAX: 19,287,653 | AVG: 3,876,525 <br /> MIN: 3,876,525 <br /> MAX: 3,876,525 |
| papabear-ephem (100 executions) | opt | AVG: 2,230,426 <br /> MIN: 2,230,426 <br /> MAX: 2,230,426 | AVG: 2,557,020 <br /> MIN: 2,557,020 <br /> MAX: 2,557,020 | AVG: 504,229 <br /> MIN: 504,229 <br /> MAX: 504,229 |
| r5n1-1cca-0d (100 executions) | m4 | AVG: 3,610,734 <br /> MIN: 3,596,681 <br /> MAX: 3,621,566 | AVG: 3,467,086 <br /> MIN: 3,444,498 <br /> MAX: 3,491,459 | AVG: 4,124,218 <br /> MIN: 4,102,674 <br /> MAX: 4,148,122 |
| r5n1-1cca-0d (100 executions) | opt | AVG: 3,704,136 <br /> MIN: 3,692,050 <br /> MAX: 3,715,554 | AVG: 4,184,076 <br /> MIN: 4,172,811 <br /> MAX: 4,195,730 | AVG: 4,840,633 <br /> MIN: 4,828,775 <br /> MAX: 4,853,416 |
| r5n1-1cpa-0d (100 executions) | m4 | AVG: 5,660,387 <br /> MIN: 5,648,234 <br /> MAX: 5,676,305 | AVG: 4,127,150 <br /> MIN: 4,096,217 <br /> MAX: 4,151,670 | AVG: 1,344,843 <br /> MIN: 1,333,836 <br /> MAX: 1,356,864 |
| r5n1-1cpa-0d (100 executions) | opt | AVG: 5,967,508 <br /> MIN: 5,954,894 <br /> MAX: 5,981,700 | AVG: 5,383,923 <br /> MIN: 5,367,872 <br /> MAX: 5,401,126 | AVG: 1,346,148 <br /> MIN: 1,334,508 <br /> MAX: 1,361,644 |
| r5n1-3cca-0d (100 executions) | m4 | AVG: 16,029,530 <br /> MIN: 15,986,213 <br /> MAX: 16,067,261 | AVG: 11,735,787 <br /> MIN: 11,682,473 <br /> MAX: 11,800,364 | AVG: 14,033,196 <br /> MIN: 13,952,456 <br /> MAX: 14,126,188 |
| r5n1-3cca-0d (100 executions) | opt | AVG: 16,533,418 <br /> MIN: 16,493,302 <br /> MAX: 16,569,913 | AVG: 15,635,670 <br /> MIN: 15,562,949 <br /> MAX: 15,675,003 | AVG: 17,936,184 <br /> MIN: 17,829,327 <br /> MAX: 17,986,768 |
| r5n1-3cpa-0d (100 executions) | m4 | AVG: 9,026,002 <br /> MIN: 8,972,014 <br /> MAX: 9,063,818 | AVG: 6,737,512 <br /> MIN: 6,689,051 <br /> MAX: 6,806,324 | AVG: 1,998,544 <br /> MIN: 1,948,974 <br /> MAX: 2,024,666 |
| r5n1-3cpa-0d (100 executions) | opt | AVG: 9,548,719 <br /> MIN: 9,508,562 <br /> MAX: 9,580,607 | AVG: 8,677,851 <br /> MIN: 8,627,960 <br /> MAX: 8,714,666 | AVG: 2,002,491 <br /> MIN: 1,966,652 <br /> MAX: 2,025,342 |
| r5n1-5cca-0d (100 executions) | m4 | AVG: 21,911,043 <br /> MIN: 21,873,755 <br /> MAX: 21,958,067 | AVG: 16,224,697 <br /> MIN: 16,145,455 <br /> MAX: 16,277,965 | AVG: 18,542,178 <br /> MIN: 18,468,920 <br /> MAX: 18,608,017 |
| r5n1-5cca-0d (100 executions) | opt | AVG: 23,408,728 <br /> MIN: 23,379,373 <br /> MAX: 23,448,732 | AVG: 21,375,231 <br /> MIN: 21,343,403 <br /> MAX: 21,418,450 | AVG: 23,694,383 <br /> MIN: 23,651,288 <br /> MAX: 23,757,369 |
| r5n1-5cpa-0d (100 executions) | m4 | AVG: 32,794,508 <br /> MIN: 32,725,688 <br /> MAX: 32,856,666 | AVG: 20,580,889 <br /> MIN: 20,453,670 <br /> MAX: 20,678,023 | AVG: 5,013,307 <br /> MIN: 4,955,810 <br /> MAX: 5,083,493 |
| r5n1-5cpa-0d (100 executions) | opt | AVG: 34,990,726 <br /> MIN: 34,897,569 <br /> MAX: 35,074,159 | AVG: 29,061,778 <br /> MIN: 28,977,972 <br /> MAX: 29,142,957 | AVG: 5,011,236 <br /> MIN: 4,926,691 <br /> MAX: 5,088,097 |
| r5nd-1cca-0d (100 executions) | m4 | AVG: 418,625 <br /> MIN: 412,840 <br /> MAX: 423,232 | AVG: 637,512 <br /> MIN: 632,903 <br /> MAX: 643,569 | AVG: 806,882 <br /> MIN: 801,590 <br /> MAX: 815,329 |
| r5nd-1cca-0d (100 executions) | opt | AVG: 552,657 <br /> MIN: 549,115 <br /> MAX: 555,175 | AVG: 835,364 <br /> MIN: 832,088 <br /> MAX: 838,328 | AVG: 1,066,987 <br /> MIN: 1,061,829 <br /> MAX: 1,071,364 |
| r5nd-1cca-5d (100 executions) | m4 | AVG: 316,787 <br /> MIN: 312,436 <br /> MAX: 330,542 | AVG: 503,649 <br /> MIN: 500,483 <br /> MAX: 517,442 | AVG: 658,295 <br /> MIN: 653,224 <br /> MAX: 672,819 |
| r5nd-1cca-5d (100 executions) | opt | AVG: 404,338 <br /> MIN: 401,765 <br /> MAX: 418,982 | AVG: 665,049 <br /> MIN: 662,669 <br /> MAX: 666,955 | AVG: 893,486 <br /> MIN: 889,752 <br /> MAX: 906,906 |
| r5nd-1cpa-0d (100 executions) | m4 | AVG: 303,129 <br /> MIN: 298,352 <br /> MAX: 306,118 | AVG: 404,825 <br /> MIN: 400,430 <br /> MAX: 410,405 | AVG: 147,943 <br /> MIN: 146,720 <br /> MAX: 149,441 |
| r5nd-1cpa-0d (100 executions) | opt | AVG: 384,972 <br /> MIN: 381,754 <br /> MAX: 386,430 | AVG: 503,940 <br /> MIN: 501,451 <br /> MAX: 506,392 | AVG: 165,017 <br /> MIN: 163,594 <br /> MAX: 166,606 |
| r5nd-1cpa-5d (100 executions) | m4 | AVG: 340,727 <br /> MIN: 337,012 <br /> MAX: 345,124 | AVG: 502,398 <br /> MIN: 499,641 <br /> MAX: 506,028 | AVG: 235,395 <br /> MIN: 232,642 <br /> MAX: 238,230 |
| r5nd-1cpa-5d (100 executions) | opt | AVG: 439,294 <br /> MIN: 436,635 <br /> MAX: 441,939 | AVG: 688,694 <br /> MIN: 685,880 <br /> MAX: 691,964 | AVG: 323,610 <br /> MIN: 321,002 <br /> MAX: 327,575 |
| r5nd-3cca-0d (100 executions) | m4 | AVG: 676,352 <br /> MIN: 668,788 <br /> MAX: 681,968 | AVG: 1,038,035 <br /> MIN: 1,026,906 <br /> MAX: 1,047,366 | AVG: 1,285,081 <br /> MIN: 1,272,469 <br /> MAX: 1,295,750 |
| r5nd-3cca-0d (100 executions) | opt | AVG: 902,168 <br /> MIN: 898,430 <br /> MAX: 905,575 | AVG: 1,373,298 <br /> MIN: 1,368,391 <br /> MAX: 1,377,150 | AVG: 1,728,581 <br /> MIN: 1,723,376 <br /> MAX: 1,734,074 |
| r5nd-3cca-5d (100 executions) | m4 | AVG: 672,941 <br /> MIN: 667,590 <br /> MAX: 678,905 | AVG: 1,026,684 <br /> MIN: 1,019,148 <br /> MAX: 1,032,129 | AVG: 1,323,063 <br /> MIN: 1,312,905 <br /> MAX: 1,331,087 |
| r5nd-3cca-5d (100 executions) | opt | AVG: 901,463 <br /> MIN: 897,972 <br /> MAX: 905,181 | AVG: 1,430,198 <br /> MIN: 1,426,063 <br /> MAX: 1,435,010 | AVG: 1,901,023 <br /> MIN: 1,896,007 <br /> MAX: 1,906,157 |
| r5nd-3cpa-0d (100 executions) | m4 | AVG: 1,008,831 <br /> MIN: 998,315 <br /> MAX: 1,025,526 | AVG: 1,350,370 <br /> MIN: 1,338,741 <br /> MAX: 1,369,727 | AVG: 530,535 <br /> MIN: 522,015 <br /> MAX: 545,652 |
| r5nd-3cpa-0d (100 executions) | opt | AVG: 1,384,549 <br /> MIN: 1,377,532 <br /> MAX: 1,400,789 | AVG: 1,922,108 <br /> MIN: 1,913,535 <br /> MAX: 1,938,116 | AVG: 727,245 <br /> MIN: 717,172 <br /> MAX: 745,636 |
| r5nd-3cpa-5d (100 executions) | m4 | AVG: 671,284 <br /> MIN: 657,324 <br /> MAX: 677,878 | AVG: 933,385 <br /> MIN: 928,300 <br /> MAX: 938,975 | AVG: 376,338 <br /> MIN: 360,548 <br /> MAX: 381,958 |
| r5nd-3cpa-5d (100 executions) | opt | AVG: 900,201 <br /> MIN: 885,054 <br /> MAX: 903,351 | AVG: 1,336,870 <br /> MIN: 1,333,497 <br /> MAX: 1,340,664 | AVG: 551,221 <br /> MIN: 536,444 <br /> MAX: 554,702 |
| r5nd-5cca-0d (100 executions) | m4 | AVG: 915,413 <br /> MIN: 906,753 <br /> MAX: 929,172 | AVG: 1,408,313 <br /> MIN: 1,396,458 <br /> MAX: 1,421,635 | AVG: 1,713,849 <br /> MIN: 1,702,795 <br /> MAX: 1,728,695 |
| r5nd-5cca-0d (100 executions) | opt | AVG: 1,240,709 <br /> MIN: 1,238,611 <br /> MAX: 1,244,074 | AVG: 1,884,863 <br /> MIN: 1,879,714 <br /> MAX: 1,890,005 | AVG: 2,341,900 <br /> MIN: 2,332,883 <br /> MAX: 2,349,951 |
| r5nd-5cca-5d (100 executions) | m4 | AVG: 1,159,024 <br /> MIN: 1,140,084 <br /> MAX: 1,168,522 | AVG: 1,712,038 <br /> MIN: 1,693,169 <br /> MAX: 1,719,099 | AVG: 2,231,392 <br /> MIN: 2,213,978 <br /> MAX: 2,240,361 |
| r5nd-5cca-5d (100 executions) | opt | AVG: 1,623,426 <br /> MIN: 1,607,917 <br /> MAX: 1,630,048 | AVG: 2,510,395 <br /> MIN: 2,493,605 <br /> MAX: 2,517,919 | AVG: 3,363,545 <br /> MIN: 3,347,445 <br /> MAX: 3,373,807 |
| r5nd-5cpa-0d (100 executions) | m4 | AVG: 1,347,812 <br /> MIN: 1,327,900 <br /> MAX: 1,361,634 | AVG: 1,823,524 <br /> MIN: 1,800,045 <br /> MAX: 1,842,564 | AVG: 675,568 <br /> MIN: 657,972 <br /> MAX: 685,178 |
| r5nd-5cpa-0d (100 executions) | opt | AVG: 1,896,260 <br /> MIN: 1,880,238 <br /> MAX: 1,919,674 | AVG: 2,661,738 <br /> MIN: 2,644,863 <br /> MAX: 2,673,929 | AVG: 968,660 <br /> MIN: 951,379 <br /> MAX: 992,668 |
| r5nd-5cpa-5d (100 executions) | m4 | AVG: 1,220,605 <br /> MIN: 1,205,540 <br /> MAX: 1,236,517 | AVG: 1,677,233 <br /> MIN: 1,663,365 <br /> MAX: 1,689,424 | AVG: 656,537 <br /> MIN: 642,110 <br /> MAX: 669,527 |
| r5nd-5cpa-5d (100 executions) | opt | AVG: 1,702,735 <br /> MIN: 1,688,816 <br /> MAX: 1,713,208 | AVG: 2,515,714 <br /> MIN: 2,499,641 <br /> MAX: 2,526,380 | AVG: 1,013,423 <br /> MIN: 997,997 <br /> MAX: 1,024,678 |
| rollo-I-128 (100 executions) | ref | AVG: 33,861,072 <br /> MIN: 33,690,382 <br /> MAX: 34,007,816 | AVG: 3,113,500 <br /> MIN: 3,105,408 <br /> MAX: 3,121,156 | AVG: 14,694,648 <br /> MIN: 14,008,517 <br /> MAX: 15,435,245 |
| rollo-I-192 (100 executions) | ref | AVG: 45,943,058 <br /> MIN: 45,756,043 <br /> MAX: 46,200,855 | AVG: 3,672,034 <br /> MIN: 3,665,932 <br /> MAX: 3,678,573 | AVG: 18,974,153 <br /> MIN: 18,805,659 <br /> MAX: 20,084,667 |
| rollo-I-256 (100 executions) | ref | AVG: 69,323,491 <br /> MIN: 68,937,122 <br /> MAX: 69,611,454 | AVG: 4,725,068 <br /> MIN: 4,719,234 <br /> MAX: 4,731,521 | AVG: 32,339,031 <br /> MIN: 32,198,423 <br /> MAX: 32,538,312 |
| rollo-II-128 (100 executions) | ref | AVG: 155,305,161 <br /> MIN: 155,013,877 <br /> MAX: 155,532,642 | AVG: 10,621,613 <br /> MIN: 10,615,018 <br /> MAX: 10,628,043 | AVG: 30,798,365 <br /> MIN: 30,698,203 <br /> MAX: 31,715,736 |
| rollo-II-192 (100 executions) | ref | AVG: 183,343,584 <br /> MIN: 182,578,200 <br /> MAX: 183,811,328 | AVG: 12,112,733 <br /> MIN: 12,107,861 <br /> MAX: 12,118,513 | AVG: 36,385,113 <br /> MIN: 36,272,752 <br /> MAX: 36,517,787 |
| rollo-II-256 (100 executions) | ref | AVG: 215,860,701 <br /> MIN: 215,517,994 <br /> MAX: 216,304,902 | AVG: 13,587,317 <br /> MIN: 13,581,140 <br /> MAX: 13,594,998 | AVG: 45,235,641 <br /> MIN: 45,101,076 <br /> MAX: 45,356,459 |
| rqc128 (100 executions) | ref | AVG: 8,105,798 <br /> MIN: 8,087,806 <br /> MAX: 8,124,616 | AVG: 15,117,875 <br /> MIN: 15,098,845 <br /> MAX: 15,136,544 | AVG: 105,939,613 <br /> MIN: 105,675,892 <br /> MAX: 106,183,245 |
| rqc192 (100 executions) | ref | AVG: 23,711,306 <br /> MIN: 22,133,193 <br /> MAX: 36,240,705 | AVG: 39,412,619 <br /> MIN: 37,859,202 <br /> MAX: 51,719,937 | AVG: 254,622,745 <br /> MIN: 251,119,052 <br /> MAX: 279,316,313 |
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
| dilithium2 (100 executions) | m4 | AVG: 1,312,469 <br /> MIN: 1,310,871 <br /> MAX: 1,324,474 | AVG: 4,710,932 <br /> MIN: 1,798,114 <br /> MAX: 17,637,113 | AVG: 1,366,913 <br /> MIN: 1,366,566 <br /> MAX: 1,367,306 |
| dilithium3 (100 executions) | clean | AVG: 2,539,785 <br /> MIN: 2,538,961 <br /> MAX: 2,540,640 | AVG: 11,759,429 <br /> MIN: 4,161,883 <br /> MAX: 64,856,628 | AVG: 2,671,904 <br /> MIN: 2,671,471 <br /> MAX: 2,672,362 |
| dilithium3 (100 executions) | m4 | AVG: 2,141,712 <br /> MIN: 2,140,840 <br /> MAX: 2,142,715 | AVG: 6,297,235 <br /> MIN: 2,644,653 <br /> MAX: 21,917,527 | AVG: 2,081,665 <br /> MIN: 2,081,327 <br /> MAX: 2,082,049 |
| dilithium4 (100 executions) | clean | AVG: 3,398,499 <br /> MIN: 3,398,034 <br /> MAX: 3,398,906 | AVG: 12,168,851 <br /> MIN: 5,509,148 <br /> MAX: 52,054,919 | AVG: 3,684,357 <br /> MIN: 3,683,668 <br /> MAX: 3,684,920 |
| dilithium4 (100 executions) | m4 | AVG: 2,901,151 <br /> MIN: 2,900,788 <br /> MAX: 2,901,607 | AVG: 6,709,457 <br /> MIN: 3,659,459 <br /> MAX: 24,466,499 | AVG: 2,963,186 <br /> MIN: 2,962,640 <br /> MAX: 2,963,641 |
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
| luov-47-42-182-chacha (100 executions) | ref | AVG: 21,000,012 <br /> MIN: 20,862,841 <br /> MAX: 21,114,732 | AVG: 57,884,512 <br /> MIN: 57,838,973 <br /> MAX: 57,939,274 | AVG: 32,884,586 <br /> MIN: 32,872,366 <br /> MAX: 32,898,789 |
| luov-47-42-182-keccak (100 executions) | ref | AVG: 29,638,929 <br /> MIN: 29,503,412 <br /> MAX: 29,794,335 | AVG: 66,356,015 <br /> MIN: 66,318,361 <br /> MAX: 66,400,831 | AVG: 43,068,640 <br /> MIN: 43,056,451 <br /> MAX: 43,084,443 |
| luov-61-60-261-chacha (100 executions) | ref | AVG: 61,819,106 <br /> MIN: 61,561,060 <br /> MAX: 62,087,952 | AVG: 250,029,339 <br /> MIN: 249,938,705 <br /> MAX: 250,092,063 | AVG: 107,905,857 <br /> MIN: 107,879,984 <br /> MAX: 107,927,089 |
| luov-61-60-261-keccak (100 executions) | ref | AVG: 92,133,826 <br /> MIN: 91,830,833 <br /> MAX: 92,425,404 | AVG: 279,672,854 <br /> MIN: 279,609,342 <br /> MAX: 279,728,867 | AVG: 138,353,754 <br /> MIN: 138,331,818 <br /> MAX: 138,373,656 |
| luov-7-57-197-chacha (100 executions) | ref | AVG: 35,318,079 <br /> MIN: 35,078,613 <br /> MAX: 35,553,406 | AVG: 65,405,967 <br /> MIN: 65,337,206 <br /> MAX: 65,476,034 | AVG: 40,331,209 <br /> MIN: 40,309,316 <br /> MAX: 40,344,859 |
| luov-7-57-197-keccak (100 executions) | ref | AVG: 50,001,029 <br /> MIN: 49,808,905 <br /> MAX: 50,194,528 | AVG: 79,666,086 <br /> MIN: 79,581,864 <br /> MAX: 79,744,285 | AVG: 55,008,767 <br /> MIN: 54,971,175 <br /> MAX: 55,020,892 |
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
| babybear | clean | 6,132 | 5,988 | 10,116 |
| babybear | opt | 3,076 | 2,964 | 5,092 |
| babybear-ephem | clean | 6,132 | 5,980 | 4,864 |
| babybear-ephem | opt | 3,076 | 2,980 | 2,420 |
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
| lac-128-v3a | opt | 7,436 | 8,964 | 10,396 |
| lac-128-v3a | ref | 6,396 | 7,924 | 9,448 |
| lac-128-v3b | opt | 7,436 | 8,964 | 10,396 |
| lac-128-v3b | ref | 6,396 | 7,924 | 9,356 |
| lac-192-v3a | opt | 14,604 | 17,476 | 20,304 |
| lac-192-v3a | ref | 12,540 | 15,412 | 18,148 |
| lac-192-v3b | opt | 14,604 | 17,476 | 20,304 |
| lac-192-v3b | ref | 12,540 | 15,412 | 18,240 |
| lac-256-v3a | opt | 14,604 | 17,700 | 20,660 |
| lac-256-v3a | ref | 12,632 | 15,636 | 18,688 |
| lac-256-v3b | opt | 14,604 | 17,700 | 20,660 |
| lac-256-v3b | ref | 12,632 | 15,636 | 18,688 |
| lac-light-v3a | opt | 7,436 | 8,852 | 10,172 |
| lac-light-v3a | ref | 6,396 | 7,812 | 9,132 |
| lac-light-v3b | opt | 7,436 | 8,852 | 10,172 |
| lac-light-v3b | ref | 6,396 | 7,812 | 9,132 |
| lightsaber | clean | 10,540 | 12,276 | 13,020 |
| lightsaber | m4 | 9,652 | 11,388 | 12,132 |
| mamabear | clean | 6,772 | 6,712 | 11,640 |
| mamabear | opt | 3,572 | 3,436 | 6,052 |
| mamabear-ephem | clean | 6,776 | 6,604 | 4,772 |
| mamabear-ephem | opt | 3,572 | 3,460 | 2,908 |
| newhope1024cca | clean | 11,028 | 17,292 | 19,508 |
| newhope1024cca | m4 | 2,852 | 5,036 | 5,036 |
| newhope1024cpa | clean | 11,020 | 17,196 | 8,284 |
| newhope1024cpa | m4 | 2,844 | 4,940 | 2,176 |
| newhope512cca | clean | 5,900 | 9,100 | 10,228 |
| newhope512cca | m4 | 1,828 | 2,988 | 2,988 |
| newhope512cpa | clean | 5,892 | 9,004 | 4,184 |
| newhope512cpa | m4 | 1,820 | 2,892 | 1,152 |
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
| papabear | clean | 7,404 | 7,344 | 13,056 |
| papabear | opt | 4,052 | 3,916 | 7,012 |
| papabear-ephem | clean | 7,408 | 7,328 | 4,772 |
| papabear-ephem | opt | 4,052 | 3,940 | 3,380 |
| r5n1-1cca-0d | m4 | 19,492 | 25,508 | 31,292 |
| r5n1-1cca-0d | opt | 19,492 | 25,508 | 31,292 |
| r5n1-1cpa-0d | m4 | 18,916 | 24,340 | 17,844 |
| r5n1-1cpa-0d | opt | 18,916 | 24,340 | 17,844 |
| r5n1-3cca-0d | m4 | 29,852 | 39,844 | 49,572 |
| r5n1-3cca-0d | opt | 29,852 | 39,844 | 49,572 |
| r5n1-3cpa-0d | m4 | 26,596 | 35,768 | 28,068 |
| r5n1-3cpa-0d | opt | 26,596 | 35,732 | 28,068 |
| r5n1-5cca-0d | m4 | 37,284 | 52,416 | 67,028 |
| r5n1-5cca-0d | opt | 37,284 | 52,308 | 53,247 |
| r5n1-5cpa-0d | m4 | 40,580 | 55,156 | 46,260 |
| r5n1-5cpa-0d | opt | 40,580 | 55,156 | 46,260 |
| r5nd-1cca-0d | m4 | 4,492 | 5,596 | 6,332 |
| r5nd-1cca-0d | opt | 4,492 | 5,596 | 6,332 |
| r5nd-1cca-5d | m4 | 3,924 | 4,996 | 5,612 |
| r5nd-1cca-5d | opt | 3,924 | 4,996 | 5,612 |
| r5nd-1cpa-0d | m4 | 4,492 | 5,404 | 2,132 |
| r5nd-1cpa-0d | opt | 4,492 | 5,404 | 2,132 |
| r5nd-1cpa-5d | m4 | 3,836 | 4,836 | 2,500 |
| r5nd-1cpa-5d | opt | 3,836 | 4,836 | 2,508 |
| r5nd-3cca-0d | m4 | 6,140 | 7,764 | 8,884 |
| r5nd-3cca-0d | opt | 6,140 | 7,764 | 8,884 |
| r5nd-3cca-5d | m4 | 5,628 | 7,148 | 8,100 |
| r5nd-3cca-5d | opt | 5,628 | 7,148 | 8,100 |
| r5nd-3cpa-0d | m4 | 6,044 | 7,532 | 4,644 |
| r5nd-3cpa-0d | opt | 6,044 | 7,532 | 4,660 |
| r5nd-3cpa-5d | m4 | 5,588 | 7,020 | 3,516 |
| r5nd-3cpa-5d | opt | 5,588 | 7,020 | 3,524 |
| r5nd-5cca-0d | m4 | 8,076 | 10,276 | 11,804 |
| r5nd-5cca-0d | opt | 8,076 | 10,276 | 11,804 |
| r5nd-5cca-5d | m4 | 7,068 | 9,068 | 10,372 |
| r5nd-5cca-5d | opt | 7,068 | 9,068 | 10,372 |
| r5nd-5cpa-0d | m4 | 7,532 | 9,476 | 5,900 |
| r5nd-5cpa-0d | opt | 7,532 | 9,476 | 5,916 |
| r5nd-5cpa-5d | m4 | 7,028 | 8,764 | 4,524 |
| r5nd-5cpa-5d | opt | 7,036 | 8,772 | 4,532 |
| rollo-I-128 | ref | 1,552 | 1,468 | 1,536 |
| rollo-I-192 | ref | 1,528 | 1,492 | 1,584 |
| rollo-I-256 | ref | 1,592 | 1,540 | 1,680 |
| rollo-II-128 | ref | 1,712 | 4,136 | 4,488 |
| rollo-II-192 | ref | 1,720 | 4,632 | 4,896 |
| rollo-II-256 | ref | 1,816 | 4,848 | 5,208 |
| rqc128 | ref | 3,232 | 10,104 | 11,940 |
| rqc192 | ref | 4,256 | 24,704 | 27,556 |
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
| dilithium2 | m4 | 36,396 | 61,284 | 40,644 |
| dilithium3 | clean | 50,732 | 81,772 | 54,980 |
| dilithium3 | m4 | 50,732 | 81,764 | 54,980 |
| dilithium4 | clean | 67,116 | 104,388 | 71,452 |
| dilithium4 | m4 | 67,116 | 104,380 | 71,452 |
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
| luov-47-42-182-chacha | ref | 2,488 | 4,472 | 2,944 |
| luov-47-42-182-keccak | ref | 2,884 | 4,548 | 3,340 |
| luov-61-60-261-chacha | ref | 3,360 | 6,096 | 4,104 |
| luov-61-60-261-keccak | ref | 3,788 | 6,208 | 4,568 |
| luov-7-57-197-chacha | ref | 2,736 | 2,704 | 1,256 |
| luov-7-57-197-keccak | ref | 3,276 | 2,812 | 2,092 |
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
| babybear | clean | 9.6% | 7.3% | 8.6% |
| babybear | opt | 56.8% | 49.5% | 45.4% |
| babybear-ephem | clean | 9.6% | 7.7% | 6.5% |
| babybear-ephem | opt | 56.8% | 50.9% | 44.4% |
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
| lac-128-v3a | opt | 20.3% | 17.3% | 12.6% |
| lac-128-v3a | ref | 12.3% | 10.3% | 7.4% |
| lac-128-v3b | opt | 20.2% | 17.2% | 12.6% |
| lac-128-v3b | ref | 13.4% | 11.3% | 8.1% |
| lac-192-v3a | opt | 12.0% | 10.1% | 7.4% |
| lac-192-v3a | ref | 7.7% | 6.4% | 4.7% |
| lac-192-v3b | opt | 11.9% | 10.1% | 7.4% |
| lac-192-v3b | ref | 6.8% | 5.8% | 4.2% |
| lac-256-v3a | opt | 12.5% | 9.7% | 6.6% |
| lac-256-v3a | ref | 7.2% | 5.6% | 3.8% |
| lac-256-v3b | opt | 12.5% | 9.7% | 6.6% |
| lac-256-v3b | ref | 7.2% | 5.5% | 3.8% |
| lac-light-v3a | opt | 21.4% | 19.4% | 15.1% |
| lac-light-v3a | ref | 13.2% | 11.9% | 9.1% |
| lac-light-v3b | opt | 21.2% | 19.3% | 15.1% |
| lac-light-v3b | ref | 14.3% | 13.0% | 9.9% |
| lightsaber | clean | 25.1% | 24.0% | 15.6% |
| lightsaber | m4 | 56.5% | 55.8% | 42.2% |
| mamabear | clean | 8.2% | 6.6% | 7.6% |
| mamabear | opt | 54.3% | 48.5% | 45.4% |
| mamabear-ephem | clean | 8.2% | 6.8% | 5.7% |
| mamabear-ephem | opt | 53.8% | 48.9% | 41.9% |
| newhope1024cca | clean | 59.5% | 59.2% | 47.8% |
| newhope1024cca | m4 | 74.3% | 78.5% | 70.3% |
| newhope1024cpa | clean | 53.8% | 50.2% | 4.2% |
| newhope1024cpa | m4 | 69.9% | 71.7% | 10.7% |
| newhope512cca | clean | 61.5% | 61.7% | 50.1% |
| newhope512cca | m4 | 75.6% | 79.8% | 71.7% |
| newhope512cpa | clean | 56.2% | 52.5% | 8.5% |
| newhope512cpa | m4 | 71.4% | 73.0% | 19.4% |
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
| papabear | clean | 7.5% | 6.3% | 7.0% |
| papabear | opt | 52.4% | 47.8% | 45.2% |
| papabear-ephem | clean | 7.5% | 6.4% | 5.3% |
| papabear-ephem | opt | 52.1% | 48.0% | 40.7% |
| r5n1-1cca-0d | m4 | 27.0% | 52.9% | 54.2% |
| r5n1-1cca-0d | opt | 26.4% | 44.2% | 46.6% |
| r5n1-1cpa-0d | m4 | 22.3% | 39.0% | 75.4% |
| r5n1-1cpa-0d | opt | 21.2% | 30.4% | 75.4% |
| r5n1-3cca-0d | m4 | 15.7% | 35.8% | 41.0% |
| r5n1-3cca-0d | opt | 15.2% | 27.2% | 32.6% |
| r5n1-3cpa-0d | m4 | 18.2% | 35.8% | 78.5% |
| r5n1-3cpa-0d | opt | 17.2% | 28.1% | 78.5% |
| r5n1-5cca-0d | m4 | 12.1% | 32.3% | 36.3% |
| r5n1-5cca-0d | opt | 11.3% | 24.8% | 28.8% |
| r5n1-5cpa-0d | m4 | 11.9% | 24.8% | 73.9% |
| r5n1-5cpa-0d | opt | 11.2% | 17.8% | 73.9% |
| r5nd-1cca-0d | m4 | 36.9% | 44.5% | 42.9% |
| r5nd-1cca-0d | opt | 28.3% | 34.2% | 32.9% |
| r5nd-1cca-5d | m4 | 42.5% | 45.0% | 41.3% |
| r5nd-1cca-5d | opt | 33.5% | 34.3% | 30.7% |
| r5nd-1cpa-0d | m4 | 46.5% | 50.8% | 68.1% |
| r5nd-1cpa-0d | opt | 36.9% | 41.1% | 61.5% |
| r5nd-1cpa-5d | m4 | 40.5% | 38.1% | 47.4% |
| r5nd-1cpa-5d | opt | 31.9% | 28.1% | 35.3% |
| r5nd-3cca-0d | m4 | 35.9% | 44.1% | 41.7% |
| r5nd-3cca-0d | opt | 27.2% | 33.5% | 31.3% |
| r5nd-3cca-5d | m4 | 36.8% | 41.4% | 39.4% |
| r5nd-3cca-5d | opt | 27.8% | 30.0% | 27.8% |
| r5nd-3cpa-0d | m4 | 31.4% | 31.0% | 48.6% |
| r5nd-3cpa-0d | opt | 23.2% | 22.1% | 36.4% |
| r5nd-3cpa-5d | m4 | 36.9% | 36.1% | 48.4% |
| r5nd-3cpa-5d | opt | 27.8% | 25.5% | 33.9% |
| r5nd-5cca-0d | m4 | 33.4% | 42.3% | 39.4% |
| r5nd-5cca-0d | opt | 24.8% | 31.8% | 29.1% |
| r5nd-5cca-5d | m4 | 29.1% | 33.0% | 32.4% |
| r5nd-5cca-5d | opt | 21.0% | 22.7% | 21.9% |
| r5nd-5cpa-0d | m4 | 27.4% | 27.2% | 44.0% |
| r5nd-5cpa-0d | opt | 19.7% | 18.8% | 31.4% |
| r5nd-5cpa-5d | m4 | 28.8% | 27.9% | 42.9% |
| r5nd-5cpa-5d | opt | 20.9% | 18.8% | 28.6% |
| rollo-I-128 | ref | 0.1% | 0.3% | 0.2% |
| rollo-I-192 | ref | 0.1% | 0.3% | 0.2% |
| rollo-I-256 | ref | 0.0% | 0.2% | 0.1% |
| rollo-II-128 | ref | 0.0% | 2.1% | 0.9% |
| rollo-II-192 | ref | 0.0% | 2.1% | 0.8% |
| rollo-II-256 | ref | 0.0% | 2.0% | 0.7% |
| rqc128 | ref | 4.1% | 4.2% | 0.9% |
| rqc192 | ref | 2.6% | 2.7% | 0.6% |
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
| dilithium2 | m4 | 75.6% | 53.5% | 71.0% |
| dilithium3 | clean | 66.0% | 31.2% | 57.1% |
| dilithium3 | m4 | 78.3% | 55.5% | 73.3% |
| dilithium4 | clean | 66.6% | 35.6% | 60.1% |
| dilithium4 | m4 | 78.0% | 58.0% | 74.7% |
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
| luov-47-42-182-chacha | ref | 0.6% | 0.3% | 0.1% |
| luov-47-42-182-keccak | ref | 38.5% | 17.3% | 26.3% |
| luov-61-60-261-chacha | ref | 0.4% | 0.1% | 0.0% |
| luov-61-60-261-keccak | ref | 40.7% | 13.5% | 27.0% |
| luov-7-57-197-chacha | ref | 0.4% | 0.2% | 0.0% |
| luov-7-57-197-keccak | ref | 38.3% | 24.1% | 34.6% |
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
| babybear | clean | 5,002 | 0 | 0 | 5,002 |
| babybear | opt | 5,517 | 0 | 0 | 5,517 |
| babybear-ephem | clean | 4,810 | 0 | 0 | 4,810 |
| babybear-ephem | opt | 4,859 | 0 | 0 | 4,859 |
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
| lac-128-v3a | opt | 5,576 | 1,188 | 0 | 6,764 |
| lac-128-v3a | ref | 5,468 | 1,188 | 0 | 6,656 |
| lac-128-v3b | opt | 4,964 | 1,188 | 0 | 6,152 |
| lac-128-v3b | ref | 4,912 | 1,188 | 0 | 6,100 |
| lac-192-v3a | opt | 5,396 | 2,276 | 0 | 7,672 |
| lac-192-v3a | ref | 5,276 | 2,276 | 0 | 7,552 |
| lac-192-v3b | opt | 5,156 | 2,276 | 0 | 7,432 |
| lac-192-v3b | ref | 5,092 | 2,276 | 0 | 7,368 |
| lac-256-v3a | opt | 4,908 | 2,480 | 0 | 7,388 |
| lac-256-v3a | ref | 4,788 | 2,480 | 0 | 7,268 |
| lac-256-v3b | opt | 4,664 | 2,480 | 0 | 7,144 |
| lac-256-v3b | ref | 4,600 | 2,480 | 0 | 7,080 |
| lac-light-v3a | opt | 4,872 | 1,116 | 0 | 5,988 |
| lac-light-v3a | ref | 4,764 | 1,116 | 0 | 5,880 |
| lac-light-v3b | opt | 4,260 | 1,116 | 0 | 5,376 |
| lac-light-v3b | ref | 4,208 | 1,116 | 0 | 5,324 |
| lightsaber | clean | 11,952 | 0 | 0 | 11,952 |
| lightsaber | m4 | 44,576 | 0 | 0 | 44,576 |
| mamabear | clean | 5,534 | 0 | 0 | 5,534 |
| mamabear | opt | 5,421 | 0 | 0 | 5,421 |
| mamabear-ephem | clean | 4,806 | 0 | 0 | 4,806 |
| mamabear-ephem | opt | 4,771 | 0 | 0 | 4,771 |
| newhope1024cca | clean | 10,708 | 0 | 0 | 10,708 |
| newhope1024cca | m4 | 12,088 | 4,096 | 0 | 16,184 |
| newhope1024cpa | clean | 10,380 | 0 | 0 | 10,380 |
| newhope1024cpa | m4 | 11,156 | 4,096 | 0 | 15,252 |
| newhope512cca | clean | 6,964 | 0 | 0 | 6,964 |
| newhope512cca | m4 | 11,068 | 2,048 | 0 | 13,116 |
| newhope512cpa | clean | 6,636 | 0 | 0 | 6,636 |
| newhope512cpa | m4 | 10,140 | 2,048 | 0 | 12,188 |
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
| papabear | clean | 5,610 | 0 | 0 | 5,610 |
| papabear | opt | 5,373 | 0 | 0 | 5,373 |
| papabear-ephem | clean | 4,806 | 0 | 0 | 4,806 |
| papabear-ephem | opt | 4,723 | 0 | 0 | 4,723 |
| r5n1-1cca-0d | m4 | 3,213 | 0 | 0 | 3,213 |
| r5n1-1cca-0d | opt | 3,091 | 0 | 0 | 3,091 |
| r5n1-1cpa-0d | m4 | 3,057 | 0 | 0 | 3,057 |
| r5n1-1cpa-0d | opt | 2,975 | 0 | 0 | 2,975 |
| r5n1-3cca-0d | m4 | 3,581 | 0 | 0 | 3,581 |
| r5n1-3cca-0d | opt | 3,443 | 0 | 0 | 3,443 |
| r5n1-3cpa-0d | m4 | 3,129 | 0 | 0 | 3,129 |
| r5n1-3cpa-0d | opt | 3,019 | 0 | 0 | 3,019 |
| r5n1-5cca-0d | m4 | 3,501 | 0 | 0 | 3,501 |
| r5n1-5cca-0d | opt | 3,415 | 0 | 0 | 3,415 |
| r5n1-5cpa-0d | m4 | 3,185 | 0 | 0 | 3,185 |
| r5n1-5cpa-0d | opt | 3,103 | 0 | 0 | 3,103 |
| r5nd-1cca-0d | m4 | 2,639 | 0 | 0 | 2,639 |
| r5nd-1cca-0d | opt | 2,621 | 0 | 0 | 2,621 |
| r5nd-1cca-5d | m4 | 5,207 | 0 | 0 | 5,207 |
| r5nd-1cca-5d | opt | 5,133 | 0 | 0 | 5,133 |
| r5nd-1cpa-0d | m4 | 2,219 | 0 | 0 | 2,219 |
| r5nd-1cpa-0d | opt | 2,153 | 0 | 0 | 2,153 |
| r5nd-1cpa-5d | m4 | 4,863 | 0 | 0 | 4,863 |
| r5nd-1cpa-5d | opt | 4,853 | 0 | 0 | 4,853 |
| r5nd-3cca-0d | m4 | 2,795 | 0 | 0 | 2,795 |
| r5nd-3cca-0d | opt | 2,721 | 0 | 0 | 2,721 |
| r5nd-3cca-5d | m4 | 6,623 | 0 | 0 | 6,623 |
| r5nd-3cca-5d | opt | 6,553 | 0 | 0 | 6,553 |
| r5nd-3cpa-0d | m4 | 2,311 | 0 | 0 | 2,311 |
| r5nd-3cpa-0d | opt | 2,301 | 0 | 0 | 2,301 |
| r5nd-3cpa-5d | m4 | 6,115 | 0 | 0 | 6,115 |
| r5nd-3cpa-5d | opt | 6,045 | 0 | 0 | 6,045 |
| r5nd-5cca-0d | m4 | 2,839 | 0 | 0 | 2,839 |
| r5nd-5cca-0d | opt | 2,821 | 0 | 0 | 2,821 |
| r5nd-5cca-5d | m4 | 4,503 | 0 | 0 | 4,503 |
| r5nd-5cca-5d | opt | 4,481 | 0 | 0 | 4,481 |
| r5nd-5cpa-0d | m4 | 2,359 | 0 | 0 | 2,359 |
| r5nd-5cpa-0d | opt | 2,341 | 0 | 0 | 2,341 |
| r5nd-5cpa-5d | m4 | 3,859 | 0 | 0 | 3,859 |
| r5nd-5cpa-5d | opt | 3,797 | 0 | 0 | 3,797 |
| rollo-I-128 | ref | 16,044 | 0 | 2,072 | 18,116 |
| rollo-I-192 | ref | 15,972 | 0 | 2,072 | 18,044 |
| rollo-I-256 | ref | 15,868 | 0 | 2,072 | 17,940 |
| rollo-II-128 | ref | 17,104 | 0 | 2,072 | 19,176 |
| rollo-II-192 | ref | 16,932 | 0 | 2,072 | 19,004 |
| rollo-II-256 | ref | 16,932 | 0 | 2,072 | 19,004 |
| rqc128 | ref | 21,588 | 0 | 2,072 | 23,660 |
| rqc192 | ref | 23,756 | 0 | 2,072 | 25,828 |
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
| dilithium2 | m4 | 18,088 | 0 | 0 | 18,088 |
| dilithium3 | clean | 11,068 | 0 | 0 | 11,068 |
| dilithium3 | m4 | 17,964 | 0 | 0 | 17,964 |
| dilithium4 | clean | 11,256 | 0 | 0 | 11,256 |
| dilithium4 | m4 | 18,144 | 0 | 0 | 18,144 |
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
| luov-47-42-182-chacha | ref | 10,060 | 0 | 0 | 10,060 |
| luov-47-42-182-keccak | ref | 10,080 | 0 | 0 | 10,080 |
| luov-61-60-261-chacha | ref | 10,160 | 0 | 0 | 10,160 |
| luov-61-60-261-keccak | ref | 10,180 | 0 | 0 | 10,180 |
| luov-7-57-197-chacha | ref | 9,948 | 0 | 0 | 9,948 |
| luov-7-57-197-keccak | ref | 9,920 | 0 | 0 | 9,920 |
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
