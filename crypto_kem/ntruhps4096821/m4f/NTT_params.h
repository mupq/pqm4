#ifndef NTT_PARAMS_H
#define NTT_PARAMS_H

#define ARRAY_N 1728

#ifndef NTRU_Q
#define NTRU_Q 4096
#endif

#ifndef NTRU_N
#define NTRU_N 821
#endif

#define NTT_N 64
#define LOGNTT_N 6

#define Q1 3365569
#define Q1pr 29

// omegaQ1 = Q1pr^((Q1 - 1) / NTT_N) mod Q1
#define omegaQ1 1008125
// invomegaQ1 = omegaQ1^{-1} mod Q1
#define invomegaQ1 (-1632596)
// RmodQ1 = 2^32 mod^{+-} Q1
#define RmodQ1 501252
// Q1prime = -Q1^{-1} mod^{+-} 2^32
#define Q1prime 1205062335
// invNQ1 = NTT_N^{-1} mod^{+-} 2^32
#define invNQ1 (-52587)

// inv3Q1 = 3^{-1} mod^{+-} 2^32
#define inv3Q1 (-1121856)
// inv9Q1 = 9^{-1} mod^{+-} 2^32
#define inv9Q1 (-373952)
// invNinv9Q1 = (9 * 64)^{-1} mod^{+-} 2^32
#define invNinv9Q1 (-5843)
// invNin9R2modQ1 = invNinv9Q1 * 2^32 mod^{+-} 2^32
#define invNinv9R2modQ1 1204317

#define omega9Q1 (-1252544)
#define omega92Q1 (-248552)
#define omega93Q1 452650
#define omega94Q1 (-287860)
#define omega95Q1 543301
#define omega96Q1 (-452651)
#define omega97Q1 1540404
#define omega98Q1 (-294749)

#define invomega9Q1 (-294749)
#define invomega92Q1 1540404
#define invomega93Q1 (-452651)
#define invomega94Q1 543301
#define invomega96Q1 452650




#define omega9RmodQ1 (-19276)
#define omega92RmodQ1 (-553862)
#define omega93RmodQ1 (-1481904)
#define omega94RmodQ1 1639017
#define omega95RmodQ1 (-1033921)
#define omega96RmodQ1 980652
#define omega97RmodQ1 (-1619741)
#define omega98RmodQ1 1587783

#define invomega9RmodQ1 1587783
#define invomega92RmodQ1 (-1619741)
#define invomega93RmodQ1 980652
#define invomega94RmodQ1 (-1033921)
#define invomega96RmodQ1 (-1481904)

// omega4Q1 = omegaQ1^16 mod Q1
#define omega4Q1 (-735217)
// omega4RmodQ1 = omega4Q1 * 2^32 mod Q1
#define omega4RmodQ1 813816

#define omega4omega9Q1 1286699
#define omega4omega92Q1 (-644209)
#define omega4omega94Q1 (-875376)

#define omega4omega9RmodQ1 (-368167)
#define omega4omega92RmodQ1 (-1531963)
#define omega4omega94RmodQ1 (-1277946)

// omega4Q1 = omegaQ1^48 mod Q1
#define invomega4Q1 735217
#define invomega4RmodQ1 (-813816)

#define invomega4invomega9Q1 1146808
#define invomega4invomega92Q1 411323
#define invomega4invomega94Q1 1574552

#define invomega4invomega9RmodQ1 618416
#define invomega4invomega92RmodQ1 (-1646113)
#define invomega4invomega94RmodQ1 1215190


#define baseomegaQ1 (-464603)



#endif

