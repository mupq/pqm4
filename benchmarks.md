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
| ml-kem-1024 (10 executions) | clean | AVG: 1,536,343 <br /> MIN: 1,535,750 <br /> MAX: 1,536,698 | AVG: 1,708,071 <br /> MIN: 1,707,476 <br /> MAX: 1,708,427 | AVG: 2,020,327 <br /> MIN: 2,019,721 <br /> MAX: 2,020,672 |
| ml-kem-1024 (10 executions) | m4fspeed | AVG: 1,018,976 <br /> MIN: 1,014,877 <br /> MAX: 1,026,934 | AVG: 1,031,565 <br /> MIN: 1,027,454 <br /> MAX: 1,039,544 | AVG: 1,094,008 <br /> MIN: 1,089,897 <br /> MAX: 1,101,987 |
| ml-kem-1024 (10 executions) | m4fstack | AVG: 1,020,202 <br /> MIN: 1,017,478 <br /> MAX: 1,029,553 | AVG: 1,037,953 <br /> MIN: 1,035,260 <br /> MAX: 1,047,298 | AVG: 1,100,982 <br /> MIN: 1,098,251 <br /> MAX: 1,110,327 |
| ml-kem-512 (10 executions) | clean | AVG: 595,793 <br /> MIN: 595,576 <br /> MAX: 595,971 | AVG: 700,605 <br /> MIN: 700,383 <br /> MAX: 700,779 | AVG: 888,653 <br /> MIN: 888,436 <br /> MAX: 888,831 |
| ml-kem-512 (10 executions) | m4fspeed | AVG: 392,423 <br /> MIN: 392,211 <br /> MAX: 392,614 | AVG: 390,881 <br /> MIN: 390,671 <br /> MAX: 391,073 | AVG: 428,167 <br /> MIN: 427,955 <br /> MAX: 428,357 |
| ml-kem-512 (10 executions) | m4fstack | AVG: 392,224 <br /> MIN: 391,772 <br /> MAX: 392,541 | AVG: 392,864 <br /> MIN: 392,407 <br /> MAX: 393,181 | AVG: 430,202 <br /> MIN: 429,745 <br /> MAX: 430,519 |
| ml-kem-768 (10 executions) | clean | AVG: 988,722 <br /> MIN: 985,880 <br /> MAX: 998,135 | AVG: 1,138,225 <br /> MIN: 1,135,419 <br /> MAX: 1,147,634 | AVG: 1,387,984 <br /> MIN: 1,385,144 <br /> MAX: 1,397,397 |
| ml-kem-768 (10 executions) | m4fspeed | AVG: 642,096 <br /> MIN: 639,116 <br /> MAX: 651,103 | AVG: 658,754 <br /> MIN: 655,785 <br /> MAX: 667,769 | AVG: 707,827 <br /> MIN: 704,858 <br /> MAX: 716,842 |
| ml-kem-768 (10 executions) | m4fstack | AVG: 644,195 <br /> MIN: 640,433 <br /> MAX: 652,374 | AVG: 664,654 <br /> MIN: 660,893 <br /> MAX: 672,834 | AVG: 714,194 <br /> MIN: 710,433 <br /> MAX: 722,374 |
## Signature Schemes
| scheme | implementation | key generation [cycles] | sign [cycles] | verify [cycles] |
| ------ | -------------- | ----------------------- | ------------- | --------------- |
| aimer128f (10 executions) | m4speed | AVG: 490,087 <br /> MIN: 490,087 <br /> MAX: 490,088 | AVG: 28,590,420 <br /> MIN: 28,590,395 <br /> MAX: 28,590,439 | AVG: 26,750,578 <br /> MIN: 26,749,771 <br /> MAX: 26,751,014 |
| aimer128f (10 executions) | m4stack | AVG: 490,082 <br /> MIN: 490,082 <br /> MAX: 490,083 | AVG: 46,470,710 <br /> MIN: 46,470,162 <br /> MAX: 46,471,507 | AVG: 26,743,713 <br /> MIN: 26,743,128 <br /> MAX: 26,744,143 |
| aimer128f (10 executions) | mem_opt | AVG: 564,325 <br /> MIN: 564,324 <br /> MAX: 564,326 | AVG: 46,875,341 <br /> MIN: 46,874,593 <br /> MAX: 46,876,276 | AVG: 26,989,249 <br /> MIN: 26,988,505 <br /> MAX: 26,989,828 |
| aimer128f (10 executions) | ref | AVG: 564,323 <br /> MIN: 564,323 <br /> MAX: 564,324 | AVG: 28,991,142 <br /> MIN: 28,991,115 <br /> MAX: 28,991,171 | AVG: 26,994,617 <br /> MIN: 26,994,234 <br /> MAX: 26,994,927 |
| aimer128s (10 executions) | m4speed | AVG: 490,085 <br /> MIN: 490,085 <br /> MAX: 490,086 | AVG: 277,353,540 <br /> MIN: 277,345,110 <br /> MAX: 277,354,485 | AVG: 225,136,633 <br /> MIN: 225,136,625 <br /> MAX: 225,136,640 |
| aimer128s (10 executions) | m4stack | AVG: 490,088 <br /> MIN: 490,088 <br /> MAX: 490,088 | AVG: 372,458,535 <br /> MIN: 372,458,327 <br /> MAX: 372,459,135 | AVG: 225,134,323 <br /> MIN: 225,134,115 <br /> MAX: 225,134,367 |
| aimer128s (10 executions) | mem_opt | AVG: 564,323 <br /> MIN: 564,323 <br /> MAX: 564,325 | AVG: 374,834,586 <br /> MIN: 374,834,473 <br /> MAX: 374,834,973 | AVG: 227,230,761 <br /> MIN: 227,230,441 <br /> MAX: 227,230,833 |
| aimer192f (10 executions) | m4speed | AVG: 1,192,752 <br /> MIN: 1,192,752 <br /> MAX: 1,192,753 | AVG: 80,106,923 <br /> MIN: 80,106,896 <br /> MAX: 80,106,945 | AVG: 75,084,294 <br /> MIN: 75,083,653 <br /> MAX: 75,085,373 |
| aimer192f (10 executions) | m4stack | AVG: 1,192,753 <br /> MIN: 1,192,753 <br /> MAX: 1,192,754 | AVG: 116,329,912 <br /> MIN: 116,328,844 <br /> MAX: 116,330,708 | AVG: 75,138,063 <br /> MIN: 75,137,469 <br /> MAX: 75,138,892 |
| aimer192f (10 executions) | mem_opt | AVG: 1,397,043 <br /> MIN: 1,397,043 <br /> MAX: 1,397,043 | AVG: 117,993,511 <br /> MIN: 117,991,579 <br /> MAX: 117,995,094 | AVG: 76,372,135 <br /> MIN: 76,370,763 <br /> MAX: 76,373,839 |
| aimer192f (10 executions) | ref | AVG: 1,397,040 <br /> MIN: 1,397,040 <br /> MAX: 1,397,041 | AVG: 81,884,026 <br /> MIN: 81,883,991 <br /> MAX: 81,884,035 | AVG: 76,458,825 <br /> MIN: 76,456,517 <br /> MAX: 76,460,984 |
| aimer192s (10 executions) | m4speed | AVG: 1,192,756 <br /> MIN: 1,192,756 <br /> MAX: 1,192,758 | AVG: 763,112,898 <br /> MIN: 763,110,056 <br /> MAX: 763,113,314 | AVG: 617,799,254 <br /> MIN: 617,799,226 <br /> MAX: 617,799,272 |
| aimer192s (10 executions) | m4stack | AVG: 1,192,756 <br /> MIN: 1,192,756 <br /> MAX: 1,192,756 | AVG: 904,630,579 <br /> MIN: 904,630,192 <br /> MAX: 904,631,379 | AVG: 617,834,636 <br /> MIN: 617,834,607 <br /> MAX: 617,834,652 |
| aimer192s (10 executions) | mem_opt | AVG: 1,397,047 <br /> MIN: 1,397,039 <br /> MAX: 1,397,079 | AVG: 916,637,185 <br /> MIN: 916,637,133 <br /> MAX: 916,637,425 | AVG: 629,249,382 <br /> MIN: 629,249,345 <br /> MAX: 629,249,415 |
| aimer256f (10 executions) | m4speed | AVG: 2,899,948 <br /> MIN: 2,899,948 <br /> MAX: 2,899,949 | AVG: 160,891,483 <br /> MIN: 160,891,455 <br /> MAX: 160,891,501 | AVG: 166,071,755 <br /> MIN: 166,068,640 <br /> MAX: 166,073,951 |
| aimer256f (10 executions) | m4stack | AVG: 2,899,950 <br /> MIN: 2,899,947 <br /> MAX: 2,899,985 | AVG: 228,360,437 <br /> MIN: 228,359,438 <br /> MAX: 228,362,262 | AVG: 166,042,220 <br /> MIN: 166,040,702 <br /> MAX: 166,043,056 |
| aimer256f (10 executions) | mem_opt | AVG: 3,344,254 <br /> MIN: 3,344,250 <br /> MAX: 3,344,255 | AVG: 233,973,308 <br /> MIN: 233,969,892 <br /> MAX: 233,976,707 | AVG: 170,620,601 <br /> MIN: 170,617,448 <br /> MAX: 170,623,743 |
| aimer256f (10 executions) | ref | AVG: 3,344,258 <br /> MIN: 3,344,255 <br /> MAX: 3,344,292 | AVG: 164,484,408 <br /> MIN: 164,483,962 <br /> MAX: 164,484,481 | AVG: 170,648,722 <br /> MIN: 170,647,189 <br /> MAX: 170,651,027 |
| aimer256s (10 executions) | m4speed | AVG: 2,899,956 <br /> MIN: 2,899,949 <br /> MAX: 2,899,989 | AVG: 1,391,295,720 <br /> MIN: 1,391,289,067 <br /> MAX: 1,391,297,144 | AVG: 1,321,985,344 <br /> MIN: 1,321,984,834 <br /> MAX: 1,321,985,426 |
| aimer256s (10 executions) | m4stack | AVG: 2,899,950 <br /> MIN: 2,899,950 <br /> MAX: 2,899,950 | AVG: 1,712,314,043 <br /> MIN: 1,712,314,001 <br /> MAX: 1,712,314,175 | AVG: 1,322,034,101 <br /> MIN: 1,322,034,066 <br /> MAX: 1,322,034,132 |
| aimer256s (10 executions) | mem_opt | AVG: 3,344,262 <br /> MIN: 3,344,252 <br /> MAX: 3,344,293 | AVG: 1,752,719,642 <br /> MIN: 1,752,719,422 <br /> MAX: 1,752,720,844 | AVG: 1,361,337,862 <br /> MIN: 1,361,336,718 <br /> MAX: 1,361,338,013 |
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
| fndsa_provisional-1024 (10 executions) | m4f | AVG: 308,608,613 <br /> MIN: 195,536,229 <br /> MAX: 763,483,542 | AVG: 48,321,135 <br /> MIN: 48,158,227 <br /> MAX: 48,398,718 | AVG: 793,856 <br /> MIN: 782,604 <br /> MAX: 799,182 |
| fndsa_provisional-1024 (10 executions) | ref | AVG: 274,928,016 <br /> MIN: 217,869,128 <br /> MAX: 448,029,028 | AVG: 107,512,779 <br /> MIN: 107,106,716 <br /> MAX: 107,788,566 | AVG: 1,461,795 <br /> MIN: 1,444,739 <br /> MAX: 1,469,817 |
| fndsa_provisional-512 (10 executions) | m4f | AVG: 67,693,338 <br /> MIN: 57,825,106 <br /> MAX: 81,542,705 | AVG: 22,469,685 <br /> MIN: 22,280,159 <br /> MAX: 22,594,542 | AVG: 396,949 <br /> MIN: 390,368 <br /> MAX: 406,553 |
| fndsa_provisional-512 (10 executions) | ref | AVG: 85,699,591 <br /> MIN: 64,822,516 <br /> MAX: 132,207,505 | AVG: 49,522,949 <br /> MIN: 49,325,465 <br /> MAX: 49,631,598 | AVG: 731,387 <br /> MIN: 714,301 <br /> MAX: 738,870 |
| haetae2 (100 executions) | m4f | AVG: 6,743,278 <br /> MIN: 1,555,292 <br /> MAX: 25,393,506 | AVG: 21,993,963 <br /> MIN: 4,721,290 <br /> MAX: 86,765,689 | AVG: 918,459 <br /> MIN: 918,244 <br /> MAX: 918,668 |
| haetae2 (100 executions) | ref | AVG: 9,363,639 <br /> MIN: 1,716,264 <br /> MAX: 41,895,014 | AVG: 31,631,089 <br /> MIN: 6,247,382 <br /> MAX: 216,853,925 | AVG: 1,104,080 <br /> MIN: 1,103,874 <br /> MAX: 1,104,329 |
| haetae3 (100 executions) | m4f | AVG: 12,925,388 <br /> MIN: 2,752,846 <br /> MAX: 52,240,529 | AVG: 30,891,994 <br /> MIN: 7,467,529 <br /> MAX: 160,522,018 | AVG: 1,760,745 <br /> MIN: 1,760,408 <br /> MAX: 1,761,081 |
| haetae3 (100 executions) | ref | AVG: 20,247,658 <br /> MIN: 3,023,325 <br /> MAX: 101,863,701 | AVG: 41,078,691 <br /> MIN: 9,771,906 <br /> MAX: 168,213,225 | AVG: 1,998,105 <br /> MIN: 1,997,691 <br /> MAX: 1,998,406 |
| haetae5 (100 executions) | m4f | AVG: 19,064,310 <br /> MIN: 3,530,778 <br /> MAX: 94,189,003 | AVG: 44,679,058 <br /> MIN: 9,277,906 <br /> MAX: 182,948,586 | AVG: 2,323,830 <br /> MIN: 2,323,454 <br /> MAX: 2,324,229 |
| haetae5 (100 executions) | ref | AVG: 18,169,623 <br /> MIN: 3,864,921 <br /> MAX: 64,304,046 | AVG: 63,180,459 <br /> MIN: 12,011,324 <br /> MAX: 264,538,555 | AVG: 2,461,679 <br /> MIN: 2,461,294 <br /> MAX: 2,462,068 |
| hawk1024 (100 executions) | ref | AVG: 246,017,495 <br /> MIN: 183,762,252 <br /> MAX: 662,190,563 | AVG: 4,309,675 <br /> MIN: 4,309,595 <br /> MAX: 4,309,759 | AVG: 2,782,441 <br /> MIN: 2,780,257 <br /> MAX: 2,784,348 |
| hawk256 (100 executions) | ref | AVG: 15,758,436 <br /> MIN: 11,600,791 <br /> MAX: 35,345,186 | AVG: 1,042,002 <br /> MIN: 954,957 <br /> MAX: 2,294,025 | AVG: 627,815 <br /> MIN: 627,480 <br /> MAX: 628,077 |
| hawk512 (100 executions) | ref | AVG: 53,733,289 <br /> MIN: 45,271,209 <br /> MAX: 174,603,165 | AVG: 1,972,051 <br /> MIN: 1,971,984 <br /> MAX: 1,972,127 | AVG: 1,293,829 <br /> MIN: 1,292,946 <br /> MAX: 1,294,494 |
| mayo1 (10 executions) | m4f | AVG: 9,572,502 <br /> MIN: 9,572,487 <br /> MAX: 9,572,527 | AVG: 16,860,361 <br /> MIN: 16,860,360 <br /> MAX: 16,860,362 | AVG: 11,031,631 <br /> MIN: 11,031,601 <br /> MAX: 11,031,641 |
| mayo1 (10 executions) | ref | AVG: 14,912,311 <br /> MIN: 14,912,275 <br /> MAX: 14,912,318 | AVG: 34,939,149 <br /> MIN: 34,939,148 <br /> MAX: 34,939,151 | AVG: 13,972,096 <br /> MIN: 13,972,062 <br /> MAX: 13,972,103 |
| mayo2 (10 executions) | m4f | AVG: 9,575,000 <br /> MIN: 9,574,978 <br /> MAX: 9,575,017 | AVG: 11,006,533 <br /> MIN: 11,006,511 <br /> MAX: 11,006,551 | AVG: 6,028,386 <br /> MIN: 6,028,371 <br /> MAX: 6,028,413 |
| mayo2 (10 executions) | ref | AVG: 17,182,073 <br /> MIN: 17,182,072 <br /> MAX: 17,182,075 | AVG: 23,433,633 <br /> MIN: 23,433,613 <br /> MAX: 23,433,656 | AVG: 6,809,416 <br /> MIN: 6,809,403 <br /> MAX: 6,809,447 |
| mayo3 (10 executions) | m4f | AVG: 27,170,159 <br /> MIN: 27,170,149 <br /> MAX: 27,170,188 | AVG: 45,517,756 <br /> MIN: 45,517,727 <br /> MAX: 45,517,768 | AVG: 28,446,810 <br /> MIN: 28,446,809 <br /> MAX: 28,446,813 |
| mayo3 (10 executions) | ref | AVG: 42,601,482 <br /> MIN: 42,601,466 <br /> MAX: 42,601,509 | AVG: 95,034,259 <br /> MIN: 95,034,238 <br /> MAX: 95,034,278 | AVG: 34,019,916 <br /> MIN: 34,019,866 <br /> MAX: 34,019,966 |
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
| ml-dsa-44 (1000 executions) | clean | AVG: 1,874,405 <br /> MIN: 1,827,873 <br /> MAX: 1,914,904 | AVG: 7,925,955 <br /> MIN: 3,322,507 <br /> MAX: 33,055,004 | AVG: 2,063,096 <br /> MIN: 2,062,599 <br /> MAX: 2,063,590 |
| ml-dsa-44 (1000 executions) | m4f | AVG: 1,426,025 <br /> MIN: 1,379,650 <br /> MAX: 1,466,529 | AVG: 3,943,121 <br /> MIN: 1,812,557 <br /> MAX: 17,009,165 | AVG: 1,421,623 <br /> MIN: 1,420,738 <br /> MAX: 1,422,362 |
| ml-dsa-44 (1000 executions) | m4fstack | AVG: 1,799,062 <br /> MIN: 1,685,053 <br /> MAX: 1,902,006 | AVG: 12,134,284 <br /> MIN: 3,901,973 <br /> MAX: 65,357,843 | AVG: 3,242,333 <br /> MIN: 3,199,001 <br /> MAX: 3,279,836 |
| ml-dsa-65 (1000 executions) | clean | AVG: 3,205,533 <br /> MIN: 3,204,116 <br /> MAX: 3,206,864 | AVG: 12,359,056 <br /> MIN: 5,098,254 <br /> MAX: 70,122,163 | AVG: 3,377,305 <br /> MIN: 3,376,896 <br /> MAX: 3,377,714 |
| ml-dsa-65 (1000 executions) | m4f | AVG: 2,516,006 <br /> MIN: 2,514,337 <br /> MAX: 2,517,453 | AVG: 6,193,171 <br /> MIN: 2,918,295 <br /> MAX: 26,008,621 | AVG: 2,415,944 <br /> MIN: 2,415,109 <br /> MAX: 2,416,730 |
| ml-dsa-65 (1000 executions) | m4fstack | AVG: 3,412,622 <br /> MIN: 3,406,495 <br /> MAX: 3,418,945 | AVG: 24,421,526 <br /> MIN: 6,735,243 <br /> MAX: 164,688,347 | AVG: 5,732,397 <br /> MIN: 5,688,990 <br /> MAX: 5,783,258 |
| ml-dsa-87 (1000 executions) | clean | AVG: 5,341,863 <br /> MIN: 5,276,084 <br /> MAX: 5,406,569 | AVG: 15,579,513 <br /> MIN: 7,954,385 <br /> MAX: 82,615,659 | AVG: 5,610,203 <br /> MIN: 5,609,675 <br /> MAX: 5,610,695 |
| ml-dsa-87 (1000 executions) | m4f | AVG: 4,275,859 <br /> MIN: 4,188,469 <br /> MAX: 4,340,256 | AVG: 7,947,380 <br /> MIN: 4,880,711 <br /> MAX: 29,357,607 | AVG: 4,193,104 <br /> MIN: 4,191,862 <br /> MAX: 4,194,249 |
| ml-dsa-87 (1000 executions) | m4fstack | AVG: 5,820,537 <br /> MIN: 5,484,663 <br /> MAX: 6,113,363 | AVG: 33,357,899 <br /> MIN: 11,168,408 <br /> MAX: 170,850,278 | AVG: 9,911,514 <br /> MIN: 9,852,116 <br /> MAX: 9,969,829 |
| mqom_cat1_gf251_fast (10 executions) | ref | AVG: 7,780,082 <br /> MIN: 7,761,398 <br /> MAX: 7,795,766 | AVG: 149,063,790 <br /> MIN: 149,045,955 <br /> MAX: 149,079,787 | AVG: 136,742,778 <br /> MIN: 136,613,266 <br /> MAX: 136,821,602 |
| mqom_cat1_gf31_fast (10 executions) | ref | AVG: 8,472,628 <br /> MIN: 8,471,619 <br /> MAX: 8,473,585 | AVG: 243,796,920 <br /> MIN: 243,782,136 <br /> MAX: 243,811,088 | AVG: 244,346,110 <br /> MIN: 244,239,828 <br /> MAX: 244,424,317 |
| ov-Ip (10 executions) | m4f | AVG: 139,271,467 <br /> MIN: 139,271,458 <br /> MAX: 139,271,493 | AVG: 2,505,317 <br /> MIN: 2,505,311 <br /> MAX: 2,505,345 | AVG: 996,456 <br /> MIN: 986,007 <br /> MAX: 997,662 |
| ov-Ip (10 executions) | ref | AVG: 351,626,040 <br /> MIN: 351,626,005 <br /> MAX: 351,626,063 | AVG: 6,488,435 <br /> MIN: 6,488,421 <br /> MAX: 6,488,456 | AVG: 1,413,310 <br /> MIN: 1,413,307 <br /> MAX: 1,413,342 |
| ov-Ip-pkc (10 executions) | m4fspeed | AVG: 175,478,881 <br /> MIN: 175,478,862 <br /> MAX: 175,478,911 | AVG: 2,527,865 <br /> MIN: 2,527,858 <br /> MAX: 2,527,896 | AVG: 11,215,424 <br /> MIN: 11,205,795 <br /> MAX: 11,218,217 |
| ov-Ip-pkc (10 executions) | m4fstack | AVG: 175,478,881 <br /> MIN: 175,478,860 <br /> MAX: 175,478,903 | AVG: 2,773,500 <br /> MIN: 2,527,858 <br /> MAX: 4,984,285 | AVG: 12,061,774 <br /> MIN: 12,042,070 <br /> MAX: 12,064,226 |
| ov-Ip-pkc (10 executions) | ref | AVG: 375,763,094 <br /> MIN: 375,763,057 <br /> MAX: 375,763,124 | AVG: 6,928,079 <br /> MIN: 6,928,071 <br /> MAX: 6,928,111 | AVG: 11,584,175 <br /> MIN: 11,584,145 <br /> MAX: 11,584,182 |
| ov-Ip-pkc-skc (10 executions) | m4fspeed | AVG: 175,478,965 <br /> MIN: 175,478,948 <br /> MAX: 175,478,990 | AVG: 89,263,175 <br /> MIN: 89,263,170 <br /> MAX: 89,263,214 | AVG: 12,003,597 <br /> MIN: 11,986,733 <br /> MAX: 12,006,562 |
| ov-Ip-pkc-skc (10 executions) | m4fstack | AVG: 175,478,966 <br /> MIN: 175,478,947 <br /> MAX: 175,478,991 | AVG: 89,263,173 <br /> MIN: 89,263,168 <br /> MAX: 89,263,204 | AVG: 12,058,243 <br /> MIN: 12,038,372 <br /> MAX: 12,064,225 |
| ov-Ip-pkc-skc (10 executions) | ref | AVG: 375,763,142 <br /> MIN: 375,763,127 <br /> MAX: 375,763,170 | AVG: 242,044,572 <br /> MIN: 242,044,549 <br /> MAX: 242,044,595 | AVG: 12,436,704 <br /> MIN: 12,436,679 <br /> MAX: 12,436,717 |
| perk-128-fast-3 (10 executions) | m4 | AVG: 644,470 <br /> MIN: 636,635 <br /> MAX: 647,939 | AVG: 246,017,426 <br /> MIN: 243,005,413 <br /> MAX: 253,780,360 | AVG: 81,024,701 <br /> MIN: 80,816,007 <br /> MAX: 81,395,570 |
| perk-128-fast-3 (10 executions) | ref | AVG: 708,498 <br /> MIN: 693,335 <br /> MAX: 746,765 | AVG: 217,731,020 <br /> MIN: 217,373,834 <br /> MAX: 218,266,235 | AVG: 96,392,553 <br /> MIN: 96,066,645 <br /> MAX: 96,887,038 |
| perk-128-fast-5 (10 executions) | m4 | AVG: 817,180 <br /> MIN: 816,960 <br /> MAX: 817,404 | AVG: 237,884,869 <br /> MIN: 230,003,551 <br /> MAX: 244,535,683 | AVG: 78,109,386 <br /> MIN: 77,698,543 <br /> MAX: 78,417,783 |
| perk-128-fast-5 (10 executions) | ref | AVG: 909,135 <br /> MIN: 909,079 <br /> MAX: 909,199 | AVG: 215,652,606 <br /> MIN: 215,184,285 <br /> MAX: 216,332,885 | AVG: 94,148,220 <br /> MIN: 93,538,371 <br /> MAX: 95,135,325 |
| perk-128-short-3 (10 executions) | m4 | AVG: 642,276 <br /> MIN: 636,688 <br /> MAX: 647,881 | AVG: 1,346,726,173 <br /> MIN: 1,331,302,188 <br /> MAX: 1,370,409,684 | AVG: 460,140,305 <br /> MIN: 459,600,932 <br /> MAX: 460,823,613 |
| perk-128-short-5 (10 executions) | m4 | AVG: 817,086 <br /> MIN: 816,914 <br /> MAX: 817,352 | AVG: 1,249,408,455 <br /> MIN: 1,222,079,503 <br /> MAX: 1,287,162,277 | AVG: 428,017,047 <br /> MIN: 427,222,001 <br /> MAX: 428,959,908 |
| perk-192-fast-3 (10 executions) | m4 | AVG: 1,490,893 <br /> MIN: 1,490,614 <br /> MAX: 1,491,170 | AVG: 578,039,864 <br /> MIN: 570,936,301 <br /> MAX: 583,232,703 | AVG: 194,443,607 <br /> MIN: 194,020,947 <br /> MAX: 194,812,016 |
| perk-192-fast-5 (10 executions) | m4 | AVG: 1,803,700 <br /> MIN: 1,803,353 <br /> MAX: 1,804,063 | AVG: 560,779,599 <br /> MIN: 551,003,314 <br /> MAX: 567,090,598 | AVG: 186,978,273 <br /> MIN: 185,781,347 <br /> MAX: 187,997,766 |
| perk-192-short-3 (10 executions) | m4 | AVG: 1,490,931 <br /> MIN: 1,490,700 <br /> MAX: 1,491,237 | AVG: 3,287,248,058 <br /> MIN: 3,215,163,085 <br /> MAX: 3,367,875,518 | AVG: 1,177,626,072 <br /> MIN: 1,173,662,370 <br /> MAX: 1,180,161,689 |
| perk-192-short-5 (10 executions) | m4 | AVG: 1,803,810 <br /> MIN: 1,803,582 <br /> MAX: 1,804,114 | AVG: 3,055,640,781 <br /> MIN: 3,012,300,361 <br /> MAX: 3,097,923,832 | AVG: 1,098,102,537 <br /> MIN: 1,091,885,810 <br /> MAX: 1,100,922,095 |
| perk-256-fast-3 (10 executions) | m4 | AVG: 2,579,417 <br /> MIN: 2,579,240 <br /> MAX: 2,579,552 | AVG: 1,180,042,672 <br /> MIN: 1,167,250,030 <br /> MAX: 1,195,968,610 | AVG: 418,170,893 <br /> MIN: 415,658,694 <br /> MAX: 420,627,465 |
| perk-256-fast-5 (10 executions) | m4 | AVG: 3,067,494 <br /> MIN: 3,051,317 <br /> MAX: 3,122,708 | AVG: 1,132,865,549 <br /> MIN: 1,118,062,283 <br /> MAX: 1,145,937,660 | AVG: 398,350,119 <br /> MIN: 396,811,115 <br /> MAX: 400,676,954 |
| perk-256-short-3 (10 executions) | m4 | AVG: 2,585,286 <br /> MIN: 2,579,142 <br /> MAX: 2,638,281 | AVG: 6,776,856,645 <br /> MIN: 6,661,520,383 <br /> MAX: 6,897,544,501 | AVG: 2,642,609,592 <br /> MIN: 2,640,236,102 <br /> MAX: 2,645,143,628 |
| perk-256-short-5 (10 executions) | m4 | AVG: 3,079,789 <br /> MIN: 3,052,513 <br /> MAX: 3,184,058 | AVG: 6,207,736,113 <br /> MIN: 6,128,500,846 <br /> MAX: 6,330,487,968 | AVG: 2,452,601,903 <br /> MIN: 2,442,259,899 <br /> MAX: 2,460,272,362 |
| snova-24-5-16-4-esk (10 executions) | ref | AVG: 24,840,838 <br /> MIN: 24,840,391 <br /> MAX: 24,841,191 | AVG: 139,251,354 <br /> MIN: 139,235,721 <br /> MAX: 139,274,512 | AVG: 88,454,046 <br /> MIN: 88,453,528 <br /> MAX: 88,454,429 |
| snova-24-5-16-4-ssk (10 executions) | ref | AVG: 24,772,323 <br /> MIN: 24,771,821 <br /> MAX: 24,772,994 | AVG: 174,094,748 <br /> MIN: 160,180,156 <br /> MAX: 299,202,162 | AVG: 88,453,756 <br /> MIN: 88,453,293 <br /> MAX: 88,454,408 |
| snova-25-8-16-3-esk (10 executions) | ref | AVG: 35,280,792 <br /> MIN: 35,280,693 <br /> MAX: 35,280,867 | AVG: 71,674,196 <br /> MIN: 65,171,606 <br /> MAX: 130,098,735 | AVG: 42,542,485 <br /> MIN: 42,542,403 <br /> MAX: 42,542,553 |
| snova-25-8-16-3-ssk (10 executions) | ref | AVG: 35,195,324 <br /> MIN: 35,195,216 <br /> MAX: 35,195,579 | AVG: 112,654,217 <br /> MIN: 93,165,980 <br /> MAX: 158,103,540 | AVG: 42,542,507 <br /> MIN: 42,542,396 <br /> MAX: 42,542,732 |
| snova-28-17-16-2-esk (10 executions) | ref | AVG: 51,177,590 <br /> MIN: 51,177,548 <br /> MAX: 51,177,647 | AVG: 23,387,139 <br /> MIN: 21,270,788 <br /> MAX: 42,311,786 | AVG: 19,180,389 <br /> MIN: 19,180,360 <br /> MAX: 19,180,440 |
| snova-28-17-16-2-ssk (10 executions) | ref | AVG: 51,065,038 <br /> MIN: 51,064,999 <br /> MAX: 51,065,086 | AVG: 52,865,514 <br /> MIN: 50,757,388 <br /> MAX: 71,788,606 | AVG: 19,180,379 <br /> MIN: 19,180,357 <br /> MAX: 19,180,425 |
| snova-37-8-16-4-ssk (10 executions) | ref | AVG: 122,023,801 <br /> MIN: 122,023,399 <br /> MAX: 122,024,216 | AVG: 533,063,912 <br /> MIN: 533,033,960 <br /> MAX: 533,090,127 | AVG: 335,806,349 <br /> MIN: 335,805,890 <br /> MAX: 335,806,820 |
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
| ml-kem-1024 | clean | 15,128 | 18,776 | 20,352 |
| ml-kem-1024 | m4fspeed | 6,436 | 7,500 | 7,484 |
| ml-kem-1024 | m4fstack | 3,332 | 3,372 | 3,356 |
| ml-kem-512 | clean | 6,152 | 8,784 | 9,560 |
| ml-kem-512 | m4fspeed | 4,372 | 5,436 | 5,412 |
| ml-kem-512 | m4fstack | 2,300 | 2,348 | 2,332 |
| ml-kem-768 | clean | 10,248 | 13,384 | 14,480 |
| ml-kem-768 | m4fspeed | 5,396 | 6,468 | 6,452 |
| ml-kem-768 | m4fstack | 2,820 | 2,860 | 2,844 |
## Signature Schemes
| Scheme | Implementation | Key Generation [bytes] | Sign [bytes] | Verify [bytes] |
| ------ | -------------- | ---------------------- | ------------ | -------------- |
| aimer128f | m4speed | 8,720 | 123,376 | 15,448 |
| aimer128f | m4stack | 8,720 | 13,864 | 15,440 |
| aimer128f | mem_opt | 8,728 | 13,864 | 15,440 |
| aimer128f | ref | 8,728 | 123,376 | 15,448 |
| aimer128s | m4speed | 8,720 | 166,204 | 34,624 |
| aimer128s | m4stack | 8,720 | 27,324 | 34,624 |
| aimer128s | mem_opt | 8,728 | 27,324 | 34,624 |
| aimer192f | m4speed | 19,184 | 273,104 | 31,608 |
| aimer192f | m4stack | 19,184 | 29,976 | 31,608 |
| aimer192f | mem_opt | 19,192 | 29,976 | 31,608 |
| aimer192f | ref | 19,192 | 273,104 | 31,608 |
| aimer192s | m4speed | 19,184 | 349,788 | 60,384 |
| aimer192s | m4stack | 19,184 | 43,220 | 60,384 |
| aimer192s | mem_opt | 19,192 | 43,220 | 60,384 |
| aimer256f | m4speed | 50,032 | 573,176 | 78,608 |
| aimer256f | m4stack | 50,032 | 77,056 | 78,568 |
| aimer256f | mem_opt | 50,040 | 77,164 | 78,568 |
| aimer256f | ref | 50,040 | 573,284 | 78,716 |
| aimer256s | m4speed | 50,032 | 615,856 | 116,936 |
| aimer256s | m4stack | 50,032 | 76,032 | 116,936 |
| aimer256s | mem_opt | 50,040 | 76,140 | 117,044 |
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
| fndsa_provisional-1024 | m4f | 27,772 | 81,992 | 5,024 |
| fndsa_provisional-1024 | ref | 27,676 | 82,276 | 5,308 |
| fndsa_provisional-512 | m4f | 14,348 | 41,952 | 2,976 |
| fndsa_provisional-512 | ref | 14,380 | 42,124 | 3,260 |
| haetae2 | m4f | 19,756 | 55,568 | 23,296 |
| haetae2 | ref | 26,092 | 54,444 | 29,696 |
| haetae3 | m4f | 29,596 | 83,420 | 31,784 |
| haetae3 | ref | 43,492 | 80,428 | 48,424 |
| haetae5 | m4f | 34,084 | 103,964 | 37,300 |
| haetae5 | ref | 54,868 | 100,228 | 62,024 |
| hawk1024 | ref | 27,972 | 7,980 | 11,468 |
| hawk256 | ref | 7,900 | 3,320 | 3,712 |
| hawk512 | ref | 14,580 | 4,856 | 6,272 |
| mayo1 | m4f | 179,276 | 251,204 | 253,484 |
| mayo1 | ref | 154,220 | 197,268 | 214,756 |
| mayo2 | m4f | 169,548 | 168,700 | 159,500 |
| mayo2 | ref | 118,204 | 122,252 | 152,732 |
| mayo3 | m4f | 499,508 | 592,012 | 583,212 |
| mayo3 | ref | 401,500 | 487,596 | 515,860 |
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
| ml-dsa-44 | clean | 38,304 | 51,976 | 36,308 |
| ml-dsa-44 | m4f | 38,296 | 44,816 | 8,912 |
| ml-dsa-44 | m4fstack | 4,408 | 5,080 | 2,712 |
| ml-dsa-65 | clean | 60,832 | 79,624 | 57,736 |
| ml-dsa-65 | m4f | 60,824 | 68,872 | 9,888 |
| ml-dsa-65 | m4fstack | 4,408 | 6,616 | 2,712 |
| ml-dsa-87 | clean | 97,696 | 122,740 | 92,948 |
| ml-dsa-87 | m4f | 97,688 | 107,892 | 12,060 |
| ml-dsa-87 | m4fstack | 4,408 | 8,144 | 2,720 |
| mqom_cat1_gf251_fast | ref | 184,356 | 399,396 | 252,684 |
| mqom_cat1_gf31_fast | ref | 262,888 | 612,816 | 421,596 |
| ov-Ip | m4f | 18,676 | 5,192 | 2,520 |
| ov-Ip | ref | 18,732 | 12,712 | 5,492 |
| ov-Ip-pkc | m4fspeed | 145,236 | 5,192 | 280,952 |
| ov-Ip-pkc | m4fstack | 145,236 | 5,192 | 6,556 |
| ov-Ip-pkc | ref | 18,732 | 12,712 | 283,860 |
| ov-Ip-pkc-skc | m4fspeed | 383,148 | 243,104 | 281,036 |
| ov-Ip-pkc-skc | m4fstack | 383,148 | 243,104 | 6,556 |
| ov-Ip-pkc-skc | ref | 256,644 | 256,596 | 283,860 |
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
| ml-kem-1024 | clean | 50.0% | 45.7% | 38.6% |
| ml-kem-1024 | m4fspeed | 75.3% | 75.5% | 71.2% |
| ml-kem-1024 | m4fstack | 75.1% | 74.9% | 70.7% |
| ml-kem-512 | clean | 49.8% | 41.1% | 32.5% |
| ml-kem-512 | m4fspeed | 75.5% | 73.5% | 67.1% |
| ml-kem-512 | m4fstack | 75.6% | 73.2% | 66.9% |
| ml-kem-768 | clean | 48.5% | 43.2% | 35.4% |
| ml-kem-768 | m4fspeed | 74.5% | 74.4% | 69.2% |
| ml-kem-768 | m4fstack | 74.4% | 73.9% | 68.7% |
## Signature Schemes
| Scheme | Implementation | Key Generation [%] | Sign [%] | Verify [%] |
| ------ | -------------- | ------------------ | -------- | ---------- |
| aimer128f | m4speed | 57.9% | 49.5% | 50.1% |
| aimer128f | m4stack | 57.9% | 66.6% | 50.1% |
| aimer128f | mem_opt | 50.6% | 66.1% | 49.6% |
| aimer128f | ref | 50.6% | 48.8% | 49.6% |
| aimer128s | m4speed | 57.9% | 43.2% | 50.7% |
| aimer128s | m4stack | 57.9% | 68.3% | 50.7% |
| aimer128s | mem_opt | 50.6% | 67.9% | 50.2% |
| aimer192f | m4speed | 62.3% | 40.7% | 41.2% |
| aimer192f | m4stack | 62.3% | 57.2% | 41.2% |
| aimer192f | mem_opt | 53.5% | 56.4% | 40.5% |
| aimer192f | ref | 53.5% | 39.8% | 40.5% |
| aimer192s | m4speed | 62.3% | 43.4% | 41.7% |
| aimer192s | m4stack | 62.3% | 58.9% | 41.7% |
| aimer192s | mem_opt | 53.5% | 58.1% | 40.9% |
| aimer256f | m4speed | 67.7% | 28.6% | 27.8% |
| aimer256f | m4stack | 67.7% | 41.5% | 27.8% |
| aimer256f | mem_opt | 58.9% | 40.6% | 27.0% |
| aimer256f | ref | 58.9% | 28.0% | 27.0% |
| aimer256s | m4speed | 67.7% | 32.2% | 28.0% |
| aimer256s | m4stack | 67.7% | 43.3% | 28.0% |
| aimer256s | mem_opt | 58.9% | 42.4% | 27.2% |
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
| fndsa_provisional-1024 | m4f | 7.0% | 10.2% | 61.6% |
| fndsa_provisional-1024 | ref | 8.0% | 6.2% | 45.3% |
| fndsa_provisional-512 | m4f | 4.2% | 11.2% | 64.0% |
| fndsa_provisional-512 | ref | 8.1% | 6.9% | 47.6% |
| haetae2 | m4f | 12.4% | 56.7% | 54.1% |
| haetae2 | ref | 10.6% | 42.4% | 45.1% |
| haetae3 | m4f | 14.6% | 56.6% | 57.1% |
| haetae3 | ref | 14.4% | 42.4% | 50.3% |
| haetae5 | m4f | 15.7% | 56.6% | 57.5% |
| haetae5 | ref | 15.7% | 42.8% | 54.3% |
| hawk1024 | ref | 1.7% | 49.3% | 8.3% |
| hawk256 | ref | 32.8% | 54.6% | 10.7% |
| hawk512 | ref | 2.6% | 48.7% | 8.6% |
| mayo1 | m4f | 67.5% | 38.8% | 58.5% |
| mayo1 | ref | 43.3% | 18.7% | 46.2% |
| mayo2 | m4f | 47.7% | 42.0% | 75.2% |
| mayo2 | ref | 26.6% | 19.7% | 66.6% |
| mayo3 | m4f | 61.9% | 37.1% | 59.0% |
| mayo3 | ref | 39.5% | 16.5% | 45.9% |
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
| ml-dsa-44 | clean | 61.0% | 31.0% | 52.9% |
| ml-dsa-44 | m4f | 79.9% | 60.6% | 76.6% |
| ml-dsa-44 | m4fstack | 74.9% | 54.8% | 40.8% |
| ml-dsa-65 | clean | 64.7% | 31.2% | 56.8% |
| ml-dsa-65 | m4f | 82.3% | 60.6% | 79.2% |
| ml-dsa-65 | m4fstack | 77.1% | 54.2% | 41.0% |
| ml-dsa-87 | clean | 67.0% | 35.9% | 61.1% |
| ml-dsa-87 | m4f | 83.5% | 65.3% | 81.6% |
| ml-dsa-87 | m4fstack | 76.1% | 54.0% | 42.6% |
| mqom_cat1_gf251_fast | ref | 73.5% | 33.0% | 33.1% |
| mqom_cat1_gf31_fast | ref | 64.6% | 19.8% | 19.2% |
| ov-Ip | m4f | 7.5% | 0.9% | 1.1% |
| ov-Ip | ref | 3.0% | 0.3% | 0.8% |
| ov-Ip-pkc | m4fspeed | 6.4% | 0.9% | 81.4% |
| ov-Ip-pkc | m4fstack | 6.4% | 0.9% | 81.3% |
| ov-Ip-pkc | ref | 3.0% | 0.3% | 79.1% |
| ov-Ip-pkc-skc | m4fspeed | 6.4% | 12.5% | 81.7% |
| ov-Ip-pkc-skc | m4fstack | 6.4% | 12.5% | 81.3% |
| ov-Ip-pkc-skc | ref | 3.0% | 4.7% | 79.1% |
| perk-128-fast-3 | m4 | 63.7% | 48.5% | 71.6% |
| perk-128-fast-3 | ref | 58.7% | 28.4% | 61.6% |
| perk-128-fast-5 | m4 | 56.1% | 47.1% | 70.5% |
| perk-128-fast-5 | ref | 50.5% | 27.2% | 60.2% |
| perk-128-short-3 | m4 | 63.9% | 47.7% | 69.8% |
| perk-128-short-5 | m4 | 56.2% | 46.3% | 68.6% |
| perk-192-fast-3 | m4 | 69.6% | 48.8% | 72.2% |
| perk-192-fast-5 | m4 | 62.9% | 48.0% | 71.3% |
| perk-192-short-3 | m4 | 69.5% | 46.9% | 66.1% |
| perk-192-short-5 | m4 | 62.9% | 45.9% | 64.8% |
| perk-256-fast-3 | m4 | 71.3% | 52.0% | 74.9% |
| perk-256-fast-5 | m4 | 64.2% | 51.1% | 74.0% |
| perk-256-short-3 | m4 | 71.4% | 48.8% | 65.4% |
| perk-256-short-5 | m4 | 64.0% | 47.9% | 64.1% |
| snova-24-5-16-4-esk | ref | 12.2% | 0.0% | 3.4% |
| snova-24-5-16-4-ssk | ref | 12.2% | 1.9% | 3.4% |
| snova-25-8-16-3-esk | ref | 9.6% | 0.1% | 8.0% |
| snova-25-8-16-3-ssk | ref | 9.7% | 3.5% | 8.0% |
| snova-28-17-16-2-esk | ref | 10.6% | 0.2% | 28.1% |
| snova-28-17-16-2-ssk | ref | 10.6% | 10.7% | 28.1% |
| snova-37-8-16-4-ssk | ref | 8.8% | 2.0% | 3.4% |
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
| ml-kem-1024 | clean | 6,160 | 0 | 0 | 6,160 |
| ml-kem-1024 | m4fspeed | 16,916 | 0 | 0 | 16,916 |
| ml-kem-1024 | m4fstack | 14,016 | 0 | 0 | 14,016 |
| ml-kem-512 | clean | 5,116 | 0 | 0 | 5,116 |
| ml-kem-512 | m4fspeed | 15,848 | 0 | 0 | 15,848 |
| ml-kem-512 | m4fstack | 13,328 | 0 | 0 | 13,328 |
| ml-kem-768 | clean | 5,120 | 0 | 0 | 5,120 |
| ml-kem-768 | m4fspeed | 16,016 | 0 | 0 | 16,016 |
| ml-kem-768 | m4fstack | 13,320 | 0 | 0 | 13,320 |
## Signature Schemes
| Scheme | Implementation | .text [bytes] | .data [bytes] | .bss [bytes] | Total [bytes] |
| ------ | -------------- | ------------- | ------------- | ------------ | ------------- |
| aimer128f | m4speed | 15,992 | 0 | 0 | 15,992 |
| aimer128f | m4stack | 16,392 | 0 | 0 | 16,392 |
| aimer128f | mem_opt | 17,476 | 0 | 0 | 17,476 |
| aimer128f | ref | 17,076 | 0 | 0 | 17,076 |
| aimer128s | m4speed | 16,764 | 0 | 0 | 16,764 |
| aimer128s | m4stack | 16,368 | 0 | 0 | 16,368 |
| aimer128s | mem_opt | 17,452 | 0 | 0 | 17,452 |
| aimer192f | m4speed | 23,528 | 0 | 0 | 23,528 |
| aimer192f | m4stack | 23,956 | 0 | 0 | 23,956 |
| aimer192f | mem_opt | 25,384 | 0 | 0 | 25,384 |
| aimer192f | ref | 24,956 | 0 | 0 | 24,956 |
| aimer192s | m4speed | 24,256 | 0 | 0 | 24,256 |
| aimer192s | m4stack | 23,860 | 0 | 0 | 23,860 |
| aimer192s | mem_opt | 25,288 | 0 | 0 | 25,288 |
| aimer256f | m4speed | 25,596 | 0 | 0 | 25,596 |
| aimer256f | m4stack | 26,096 | 0 | 0 | 26,096 |
| aimer256f | mem_opt | 27,804 | 0 | 0 | 27,804 |
| aimer256f | ref | 27,304 | 0 | 0 | 27,304 |
| aimer256s | m4speed | 26,372 | 0 | 0 | 26,372 |
| aimer256s | m4stack | 25,928 | 0 | 0 | 25,928 |
| aimer256s | mem_opt | 27,636 | 0 | 0 | 27,636 |
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
| fndsa_provisional-1024 | m4f | 103,801 | 0 | 0 | 103,801 |
| fndsa_provisional-1024 | ref | 103,089 | 0 | 0 | 103,089 |
| fndsa_provisional-512 | m4f | 103,789 | 0 | 0 | 103,789 |
| fndsa_provisional-512 | ref | 103,077 | 0 | 0 | 103,077 |
| haetae2 | m4f | 35,708 | 0 | 0 | 35,708 |
| haetae2 | ref | 25,568 | 0 | 0 | 25,568 |
| haetae3 | m4f | 35,936 | 0 | 0 | 35,936 |
| haetae3 | ref | 25,980 | 0 | 0 | 25,980 |
| haetae5 | m4f | 35,692 | 0 | 0 | 35,692 |
| haetae5 | ref | 25,688 | 0 | 0 | 25,688 |
| hawk1024 | ref | 102,031 | 0 | 0 | 102,031 |
| hawk256 | ref | 102,015 | 0 | 0 | 102,015 |
| hawk512 | ref | 102,027 | 0 | 0 | 102,027 |
| mayo1 | m4f | 67,236 | 8 | 1 | 67,245 |
| mayo1 | ref | 29,988 | 8 | 16 | 30,012 |
| mayo2 | m4f | 68,356 | 8 | 1 | 68,365 |
| mayo2 | ref | 27,852 | 8 | 16 | 27,876 |
| mayo3 | m4f | 97,168 | 8 | 1 | 97,177 |
| mayo3 | ref | 36,660 | 8 | 16 | 36,684 |
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
| ml-dsa-44 | clean | 8,212 | 0 | 0 | 8,212 |
| ml-dsa-44 | m4f | 19,592 | 0 | 0 | 19,592 |
| ml-dsa-44 | m4fstack | 24,844 | 0 | 0 | 24,844 |
| ml-dsa-65 | clean | 7,724 | 0 | 0 | 7,724 |
| ml-dsa-65 | m4f | 19,328 | 0 | 0 | 19,328 |
| ml-dsa-65 | m4fstack | 24,120 | 0 | 0 | 24,120 |
| ml-dsa-87 | clean | 8,036 | 0 | 0 | 8,036 |
| ml-dsa-87 | m4f | 19,500 | 0 | 0 | 19,500 |
| ml-dsa-87 | m4fstack | 24,516 | 0 | 0 | 24,516 |
| mqom_cat1_gf251_fast | ref | 16,865 | 0 | 0 | 16,865 |
| mqom_cat1_gf31_fast | ref | 23,718 | 0 | 0 | 23,718 |
| ov-Ip | m4f | 116,070 | 0 | 0 | 116,070 |
| ov-Ip | ref | 22,374 | 0 | 0 | 22,374 |
| ov-Ip-pkc | m4fspeed | 116,310 | 0 | 0 | 116,310 |
| ov-Ip-pkc | m4fstack | 88,530 | 0 | 0 | 88,530 |
| ov-Ip-pkc | ref | 22,630 | 0 | 0 | 22,630 |
| ov-Ip-pkc-skc | m4fspeed | 116,350 | 0 | 0 | 116,350 |
| ov-Ip-pkc-skc | m4fstack | 88,570 | 0 | 0 | 88,570 |
| ov-Ip-pkc-skc | ref | 22,670 | 0 | 0 | 22,670 |
| perk-128-fast-3 | m4 | 11,717 | 4 | 0 | 11,721 |
| perk-128-fast-3 | ref | 11,053 | 4 | 0 | 11,057 |
| perk-128-fast-5 | m4 | 11,709 | 4 | 0 | 11,713 |
| perk-128-fast-5 | ref | 11,129 | 4 | 0 | 11,133 |
| perk-128-short-3 | m4 | 24,605 | 4 | 0 | 24,609 |
| perk-128-short-5 | m4 | 24,673 | 4 | 0 | 24,677 |
| perk-192-fast-3 | m4 | 12,077 | 4 | 0 | 12,081 |
| perk-192-fast-5 | m4 | 12,017 | 4 | 0 | 12,021 |
| perk-192-short-3 | m4 | 24,009 | 4 | 0 | 24,013 |
| perk-192-short-5 | m4 | 24,649 | 4 | 0 | 24,653 |
| perk-256-fast-3 | m4 | 12,129 | 4 | 0 | 12,133 |
| perk-256-fast-5 | m4 | 12,041 | 4 | 0 | 12,045 |
| perk-256-short-3 | m4 | 31,697 | 4 | 0 | 31,701 |
| perk-256-short-5 | m4 | 32,693 | 4 | 0 | 32,697 |
| snova-24-5-16-4-esk | ref | 52,132 | 0 | 336 | 52,468 |
| snova-24-5-16-4-ssk | ref | 52,132 | 0 | 336 | 52,468 |
| snova-25-8-16-3-esk | ref | 28,240 | 0 | 299 | 28,539 |
| snova-25-8-16-3-ssk | ref | 28,240 | 0 | 299 | 28,539 |
| snova-28-17-16-2-esk | ref | 16,436 | 0 | 280 | 16,716 |
| snova-28-17-16-2-ssk | ref | 16,436 | 0 | 280 | 16,716 |
| snova-37-8-16-4-ssk | ref | 52,440 | 0 | 336 | 52,776 |
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
