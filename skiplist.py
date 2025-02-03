skip_list = [
    {'scheme': 'aimer192s', 'implementation': 'ref', 'estmemory': 2036736},
    {'scheme': 'aimer192f', 'implementation': 'ref', 'estmemory': 287744},
    {'scheme': 'aimer128s', 'implementation': 'ref', 'estmemory': 924672},
    {'scheme': 'aimer256f', 'implementation': 'ref', 'estmemory': 600064},
    {'scheme': 'aimer256s', 'implementation': 'ref', 'estmemory': 4148224},
    {'scheme': 'aimer128f', 'implementation': 'ref', 'estmemory': 131072},
    {'scheme': 'aimer192s', 'implementation': 'm4stack', 'estmemory': 70656},
    {'scheme': 'aimer192s', 'implementation': 'm4speed', 'estmemory': 360448},
    {'scheme': 'aimer192f', 'implementation': 'm4stack', 'estmemory': 46080},
    {'scheme': 'aimer192f', 'implementation': 'm4speed', 'estmemory': 287744},
    {'scheme': 'aimer128s', 'implementation': 'm4stack', 'estmemory': 39936},
    {'scheme': 'aimer128s', 'implementation': 'm4speed', 'estmemory': 172032},
    {'scheme': 'aimer256f', 'implementation': 'm4stack', 'estmemory': 105472},
    {'scheme': 'aimer256f', 'implementation': 'm4speed', 'estmemory': 600064},
    {'scheme': 'aimer256s', 'implementation': 'm4stack', 'estmemory': 135168},
    {'scheme': 'aimer256s', 'implementation': 'm4speed', 'estmemory': 633856},
    {'scheme': 'aimer128f', 'implementation': 'm4stack', 'estmemory': 22528},
    {'scheme': 'aimer128f', 'implementation': 'm4speed', 'estmemory': 131072},
    {'scheme': 'aimer192s', 'implementation': 'mem_opt', 'estmemory': 70656},
    {'scheme': 'aimer192f', 'implementation': 'mem_opt', 'estmemory': 46080},
    {'scheme': 'aimer128s', 'implementation': 'mem_opt', 'estmemory': 39936},
    {'scheme': 'aimer256f', 'implementation': 'mem_opt', 'estmemory': 105472},
    {'scheme': 'aimer256s', 'implementation': 'mem_opt', 'estmemory': 135168},
    {'scheme': 'aimer128f', 'implementation': 'mem_opt', 'estmemory': 22528},
    {'scheme': 'ascon-sign-128f-robust', 'implementation': 'ref', 'estmemory': 21504},
    {'scheme': 'ascon-sign-128f-simple', 'implementation': 'ref', 'estmemory': 21504},
    {'scheme': 'ascon-sign-128s-robust', 'implementation': 'ref', 'estmemory': 12288},
    {'scheme': 'ascon-sign-128s-simple', 'implementation': 'ref', 'estmemory': 12288},
    {'scheme': 'ascon-sign-192f-robust', 'implementation': 'ref', 'estmemory': 43008},
    {'scheme': 'ascon-sign-192f-simple', 'implementation': 'ref', 'estmemory': 41984},
    {'scheme': 'ascon-sign-192s-robust', 'implementation': 'ref', 'estmemory': 23552},
    {'scheme': 'ascon-sign-192s-simple', 'implementation': 'ref', 'estmemory': 22528},
    {'scheme': 'bikel1', 'implementation': 'm4f', 'estmemory': 103424},
    {'scheme': 'bikel1', 'implementation': 'opt', 'estmemory': 90112},
    {'scheme': 'bikel3', 'implementation': 'm4f', 'estmemory': 194560},
    {'scheme': 'bikel3', 'implementation': 'opt', 'estmemory': 175104},
    {'scheme': 'cross-sha2-r-sdp-1-fast', 'implementation': 'ref', 'estmemory': 234496},
    {'scheme': 'cross-sha2-r-sdp-1-small', 'implementation': 'ref', 'estmemory': 721920},
    {'scheme': 'cross-sha2-r-sdp-3-fast', 'implementation': 'ref', 'estmemory': 365568},
    {'scheme': 'cross-sha2-r-sdp-3-small', 'implementation': 'ref', 'estmemory': 1295360},
    {'scheme': 'cross-sha2-r-sdp-5-fast', 'implementation': 'ref', 'estmemory': 914432},
    {'scheme': 'cross-sha2-r-sdp-5-small', 'implementation': 'ref', 'estmemory': 1748992},
    {'scheme': 'cross-sha2-r-sdpg-1-fast', 'implementation': 'ref', 'estmemory': 143360},
    {'scheme': 'cross-sha2-r-sdpg-1-small', 'implementation': 'ref', 'estmemory': 477184},
    {'scheme': 'cross-sha2-r-sdpg-3-fast', 'implementation': 'ref', 'estmemory': 230400},
    {'scheme': 'cross-sha2-r-sdpg-3-small', 'implementation': 'ref', 'estmemory': 776192},
    {'scheme': 'cross-sha2-r-sdpg-5-fast', 'implementation': 'ref', 'estmemory': 440320},
    {'scheme': 'cross-sha2-r-sdpg-5-small', 'implementation': 'ref', 'estmemory': 1063936},
    {'scheme': 'cross-sha3-r-sdp-1-fast', 'implementation': 'ref', 'estmemory': 234496},
    {'scheme': 'cross-sha3-r-sdp-1-small', 'implementation': 'ref', 'estmemory': 721920},
    {'scheme': 'cross-sha3-r-sdp-3-fast', 'implementation': 'ref', 'estmemory': 365568},
    {'scheme': 'cross-sha3-r-sdp-3-small', 'implementation': 'ref', 'estmemory': 1295360},
    {'scheme': 'cross-sha3-r-sdp-5-fast', 'implementation': 'ref', 'estmemory': 914432},
    {'scheme': 'cross-sha3-r-sdp-5-small', 'implementation': 'ref', 'estmemory': 1748992},
    {'scheme': 'cross-sha3-r-sdpg-1-fast', 'implementation': 'ref', 'estmemory': 143360},
    {'scheme': 'cross-sha3-r-sdpg-1-small', 'implementation': 'ref', 'estmemory': 477184},
    {'scheme': 'cross-sha3-r-sdpg-3-fast', 'implementation': 'ref', 'estmemory': 230400},
    {'scheme': 'cross-sha3-r-sdpg-3-small', 'implementation': 'ref', 'estmemory': 776192},
    {'scheme': 'cross-sha3-r-sdpg-5-fast', 'implementation': 'ref', 'estmemory': 440320},
    {'scheme': 'cross-sha3-r-sdpg-5-small', 'implementation': 'ref', 'estmemory': 1063936},
    {'scheme': 'falcon-1024', 'implementation': 'clean', 'estmemory': 91136},
    {'scheme': 'falcon-1024', 'implementation': 'm4-ct', 'estmemory': 89088},
    {'scheme': 'falcon-1024', 'implementation': 'opt-ct', 'estmemory': 89088},
    {'scheme': 'falcon-1024', 'implementation': 'opt-leaktime', 'estmemory': 90112},
    {'scheme': 'falcon-1024-tree', 'implementation': 'opt-ct', 'estmemory': 185344},
    {'scheme': 'falcon-1024-tree', 'implementation': 'opt-leaktime', 'estmemory': 186368},
    {'scheme': 'falcon-512', 'implementation': 'clean', 'estmemory': 48128},
    {'scheme': 'falcon-512', 'implementation': 'm4-ct', 'estmemory': 46080},
    {'scheme': 'falcon-512', 'implementation': 'opt-ct', 'estmemory': 46080},
    {'scheme': 'falcon-512', 'implementation': 'opt-leaktime', 'estmemory': 47104},
    {'scheme': 'falcon-512-tree', 'implementation': 'm4-ct', 'estmemory': 90112},
    {'scheme': 'falcon-512-tree', 'implementation': 'opt-ct', 'estmemory': 90112},
    {'scheme': 'falcon-512-tree', 'implementation': 'opt-leaktime', 'estmemory': 91136},
    {'scheme': 'haetae2', 'implementation': 'm4f', 'estmemory': 60416},
    {'scheme': 'haetae2', 'implementation': 'ref', 'estmemory': 59392},
    {'scheme': 'haetae3', 'implementation': 'm4f', 'estmemory': 90112},
    {'scheme': 'haetae3', 'implementation': 'ref', 'estmemory': 87040},
    {'scheme': 'haetae5', 'implementation': 'm4f', 'estmemory': 112640},
    {'scheme': 'haetae5', 'implementation': 'ref', 'estmemory': 109568},
    {'scheme': 'hawk1024', 'implementation': 'ref', 'estmemory': 32768},
    {'scheme': 'hawk256', 'implementation': 'ref', 'estmemory': 10240},
    {'scheme': 'hawk512', 'implementation': 'ref', 'estmemory': 17408},
    {'scheme': 'hqc-128', 'implementation': 'clean', 'estmemory': 66560},
    {'scheme': 'hqc-192', 'implementation': 'clean', 'estmemory': 130048},
    {'scheme': 'hqc-256', 'implementation': 'clean', 'estmemory': 205824},
    {'scheme': 'ml-kem-1024', 'implementation': 'clean', 'estmemory': 27648},
    {'scheme': 'ml-kem-1024', 'implementation': 'm4fspeed', 'estmemory': 16384},
    {'scheme': 'ml-kem-1024', 'implementation': 'm4fstack', 'estmemory': 12288},
    {'scheme': 'ml-kem-512', 'implementation': 'clean', 'estmemory': 14336},
    {'scheme': 'ml-kem-512', 'implementation': 'm4fspeed', 'estmemory': 10240},
    {'scheme': 'ml-kem-512', 'implementation': 'm4fstack', 'estmemory': 7168},
    {'scheme': 'ml-kem-768', 'implementation': 'clean', 'estmemory': 20480},
    {'scheme': 'ml-kem-768', 'implementation': 'm4fspeed', 'estmemory': 13312},
    {'scheme': 'ml-kem-768', 'implementation': 'm4fstack', 'estmemory': 10240},
    {'scheme': 'mayo1', 'implementation': 'm4f', 'estmemory': 446464},
    {'scheme': 'mayo1', 'implementation': 'ref', 'estmemory': 404480},
    {'scheme': 'mayo2', 'implementation': 'm4f', 'estmemory': 287744},
    {'scheme': 'mayo2', 'implementation': 'ref', 'estmemory': 279552},
    {'scheme': 'mayo3', 'implementation': 'm4f', 'estmemory': 477184},
    {'scheme': 'mayo3', 'implementation': 'ref', 'estmemory': 1144832},
    {'scheme': 'mceliece348864', 'implementation': 'clean', 'estmemory': 693248},
    {'scheme': 'mceliece348864f', 'implementation': 'clean', 'estmemory': 693248},
    {'scheme': 'mceliece460896', 'implementation': 'clean', 'estmemory': 1425408},
    {'scheme': 'mceliece460896f', 'implementation': 'clean', 'estmemory': 1426432},
    {'scheme': 'mceliece6688128', 'implementation': 'clean', 'estmemory': 2627584},
    {'scheme': 'mceliece6688128f', 'implementation': 'clean', 'estmemory': 2628608},
    {'scheme': 'mceliece6960119', 'implementation': 'clean', 'estmemory': 2585600},
    {'scheme': 'mceliece6960119f', 'implementation': 'clean', 'estmemory': 2586624},
    {'scheme': 'mceliece8192128', 'implementation': 'clean', 'estmemory': 3259392},
    {'scheme': 'mceliece8192128f', 'implementation': 'clean', 'estmemory': 3260416},
    {'scheme': 'mirith_IIIa_fast', 'implementation': 'ref', 'estmemory': 287744},
    {'scheme': 'mirith_IIIa_short', 'implementation': 'ref', 'estmemory': 2197504},
    {'scheme': 'mirith_IIIb_fast', 'implementation': 'ref', 'estmemory': 320512},
    {'scheme': 'mirith_IIIb_short', 'implementation': 'ref', 'estmemory': 2386944},
    {'scheme': 'mirith_Ia_fast', 'implementation': 'ref', 'estmemory': 134144},
    {'scheme': 'mirith_Ia_short', 'implementation': 'ref', 'estmemory': 1019904},
    {'scheme': 'mirith_Ib_fast', 'implementation': 'ref', 'estmemory': 163840},
    {'scheme': 'mirith_Ib_short', 'implementation': 'ref', 'estmemory': 1195008},
    {'scheme': 'mirith_Va_fast', 'implementation': 'ref', 'estmemory': 519168},
    {'scheme': 'mirith_Va_short', 'implementation': 'ref', 'estmemory': 3816448},
    {'scheme': 'mirith_Vb_fast', 'implementation': 'ref', 'estmemory': 572416},
    {'scheme': 'mirith_Vb_short', 'implementation': 'ref', 'estmemory': 4117504},
    {'scheme': 'mirith_hypercube_IIIa_fast', 'implementation': 'ref', 'estmemory': 188416},
    {'scheme': 'mirith_hypercube_IIIa_short', 'implementation': 'ref', 'estmemory': 502784},
    {'scheme': 'mirith_hypercube_IIIa_shorter', 'implementation': 'ref', 'estmemory': 3894272},
    {'scheme': 'mirith_hypercube_IIIb_fast', 'implementation': 'ref', 'estmemory': 211968},
    {'scheme': 'mirith_hypercube_IIIb_short', 'implementation': 'ref', 'estmemory': 526336},
    {'scheme': 'mirith_hypercube_IIIb_shorter', 'implementation': 'ref', 'estmemory': 3916800},
    {'scheme': 'mirith_hypercube_Ia_fast', 'implementation': 'opt', 'estmemory': 88064},
    {'scheme': 'mirith_hypercube_Ia_fast', 'implementation': 'ref', 'estmemory': 89088},
    {'scheme': 'mirith_hypercube_Ia_short', 'implementation': 'ref', 'estmemory': 227328},
    {'scheme': 'mirith_hypercube_Ia_shorter', 'implementation': 'ref', 'estmemory': 1779712},
    {'scheme': 'mirith_hypercube_Ib_fast', 'implementation': 'opt', 'estmemory': 109568},
    {'scheme': 'mirith_hypercube_Ib_fast', 'implementation': 'ref', 'estmemory': 109568},
    {'scheme': 'mirith_hypercube_Ib_short', 'implementation': 'ref', 'estmemory': 247808},
    {'scheme': 'mirith_hypercube_Ib_shorter', 'implementation': 'ref', 'estmemory': 1800192},
    {'scheme': 'mirith_hypercube_Va_fast', 'implementation': 'ref', 'estmemory': 344064},
    {'scheme': 'mirith_hypercube_Va_short', 'implementation': 'ref', 'estmemory': 878592},
    {'scheme': 'mirith_hypercube_Va_shorter', 'implementation': 'ref', 'estmemory': 4217856},
    {'scheme': 'mirith_hypercube_Vb_fast', 'implementation': 'ref', 'estmemory': 382976},
    {'scheme': 'mirith_hypercube_Vb_short', 'implementation': 'ref', 'estmemory': 916480},
    {'scheme': 'mirith_hypercube_Vb_shorter', 'implementation': 'ref', 'estmemory': 4218880},
    {'scheme': 'mqom_cat1_gf251_fast', 'implementation': 'ref', 'estmemory': 411648},
    {'scheme': 'mqom_cat1_gf251_short', 'implementation': 'ref', 'estmemory': 675840},
    {'scheme': 'mqom_cat1_gf31_fast', 'implementation': 'ref', 'estmemory': 624640},
    {'scheme': 'mqom_cat1_gf31_short', 'implementation': 'ref', 'estmemory': 878592},
    {'scheme': 'mqom_cat3_gf251_fast', 'implementation': 'ref', 'estmemory': 1307648},
    {'scheme': 'mqom_cat3_gf251_short', 'implementation': 'ref', 'estmemory': 1903616},
    {'scheme': 'mqom_cat3_gf31_fast', 'implementation': 'ref', 'estmemory': 2171904},
    {'scheme': 'mqom_cat3_gf31_short', 'implementation': 'ref', 'estmemory': 2688000},
    {'scheme': 'mqom_cat5_gf251_fast', 'implementation': 'ref', 'estmemory': 3260416},
    {'scheme': 'mqom_cat5_gf251_short', 'implementation': 'ref', 'estmemory': 4146176},
    {'scheme': 'ov-Ip', 'implementation': 'm4f', 'estmemory': 534528},
    {'scheme': 'ov-Ip', 'implementation': 'ref', 'estmemory': 534528},
    {'scheme': 'ov-Ip-pkc', 'implementation': 'm4fspeed', 'estmemory': 565248},
    {'scheme': 'ov-Ip-pkc', 'implementation': 'm4fstack', 'estmemory': 425984},
    {'scheme': 'ov-Ip-pkc', 'implementation': 'ref', 'estmemory': 568320},
    {'scheme': 'ov-Ip-pkc-skc', 'implementation': 'm4fspeed', 'estmemory': 425984},
    {'scheme': 'ov-Ip-pkc-skc', 'implementation': 'm4fstack', 'estmemory': 425984},
    {'scheme': 'ov-Ip-pkc-skc', 'implementation': 'ref', 'estmemory': 330752},
    {'scheme': 'perk-128-fast-3', 'implementation': 'm4', 'estmemory': 33792},
    {'scheme': 'perk-128-fast-3', 'implementation': 'ref', 'estmemory': 323584},
    {'scheme': 'perk-128-fast-5', 'implementation': 'm4', 'estmemory': 34816},
    {'scheme': 'perk-128-fast-5', 'implementation': 'ref', 'estmemory': 315392},
    {'scheme': 'perk-128-short-3', 'implementation': 'm4', 'estmemory': 37888},
    {'scheme': 'perk-128-short-3', 'implementation': 'ref', 'estmemory': 1570816},
    {'scheme': 'perk-128-short-5', 'implementation': 'm4', 'estmemory': 37888},
    {'scheme': 'perk-128-short-5', 'implementation': 'ref', 'estmemory': 1472512},
    {'scheme': 'perk-192-fast-3', 'implementation': 'm4', 'estmemory': 68608},
    {'scheme': 'perk-192-fast-3', 'implementation': 'ref', 'estmemory': 707584},
    {'scheme': 'perk-192-fast-5', 'implementation': 'm4', 'estmemory': 68608},
    {'scheme': 'perk-192-fast-5', 'implementation': 'ref', 'estmemory': 681984},
    {'scheme': 'perk-192-short-3', 'implementation': 'm4', 'estmemory': 69632},
    {'scheme': 'perk-192-short-3', 'implementation': 'ref', 'estmemory': 3487744},
    {'scheme': 'perk-192-short-5', 'implementation': 'm4', 'estmemory': 69632},
    {'scheme': 'perk-192-short-5', 'implementation': 'ref', 'estmemory': 3240960},
    {'scheme': 'perk-256-fast-3', 'implementation': 'm4', 'estmemory': 115712},
    {'scheme': 'perk-256-fast-3', 'implementation': 'ref', 'estmemory': 1226752},
    {'scheme': 'perk-256-fast-5', 'implementation': 'm4', 'estmemory': 114688},
    {'scheme': 'perk-256-fast-5', 'implementation': 'ref', 'estmemory': 1175552},
    {'scheme': 'perk-256-short-3', 'implementation': 'm4', 'estmemory': 111616},
    {'scheme': 'perk-256-short-3', 'implementation': 'ref', 'estmemory': 4222976},
    {'scheme': 'perk-256-short-5', 'implementation': 'm4', 'estmemory': 109568},
    {'scheme': 'perk-256-short-5', 'implementation': 'ref', 'estmemory': 4221952},
    {'scheme': 'snova-24-5-16-4-esk', 'implementation': 'ref', 'estmemory': 205824},
    {'scheme': 'snova-24-5-16-4-ssk', 'implementation': 'ref', 'estmemory': 172032},
    {'scheme': 'snova-25-8-16-3-esk', 'implementation': 'ref', 'estmemory': 232448},
    {'scheme': 'snova-25-8-16-3-ssk', 'implementation': 'ref', 'estmemory': 194560},
    {'scheme': 'snova-28-17-16-2-esk', 'implementation': 'ref', 'estmemory': 380928},
    {'scheme': 'snova-28-17-16-2-ssk', 'implementation': 'ref', 'estmemory': 320512},
    {'scheme': 'snova-37-8-16-4-esk', 'implementation': 'ref', 'estmemory': 775168},
    {'scheme': 'snova-37-8-16-4-ssk', 'implementation': 'ref', 'estmemory': 646144},
    {'scheme': 'snova-43-25-16-2-esk', 'implementation': 'ref', 'estmemory': 1274880},
    {'scheme': 'snova-43-25-16-2-ssk', 'implementation': 'ref', 'estmemory': 1072128},
    {'scheme': 'snova-49-11-16-3-esk', 'implementation': 'ref', 'estmemory': 1055744},
    {'scheme': 'snova-49-11-16-3-ssk', 'implementation': 'ref', 'estmemory': 880640},
    {'scheme': 'snova-60-10-16-4-esk', 'implementation': 'ref', 'estmemory': 2342912},
    {'scheme': 'snova-60-10-16-4-ssk', 'implementation': 'ref', 'estmemory': 1953792},
    {'scheme': 'snova-61-33-16-2-esk', 'implementation': 'ref', 'estmemory': 3232768},
    {'scheme': 'snova-61-33-16-2-ssk', 'implementation': 'ref', 'estmemory': 2717696},
    {'scheme': 'snova-66-15-16-3-esk', 'implementation': 'ref', 'estmemory': 2617344},
    {'scheme': 'snova-66-15-16-3-ssk', 'implementation': 'ref', 'estmemory': 2185216},
    {'scheme': 'sphincs-sha2-128f-simple', 'implementation': 'clean', 'estmemory': 21504},
    {'scheme': 'sphincs-sha2-128s-simple', 'implementation': 'clean', 'estmemory': 12288},
    {'scheme': 'sphincs-sha2-192f-simple', 'implementation': 'clean', 'estmemory': 43008},
    {'scheme': 'sphincs-sha2-192s-simple', 'implementation': 'clean', 'estmemory': 23552},
    {'scheme': 'sphincs-sha2-256f-simple', 'implementation': 'clean', 'estmemory': 59392},
    {'scheme': 'sphincs-sha2-256s-simple', 'implementation': 'clean', 'estmemory': 39936},
    {'scheme': 'sphincs-shake-128f-simple', 'implementation': 'clean', 'estmemory': 21504},
    {'scheme': 'sphincs-shake-128s-simple', 'implementation': 'clean', 'estmemory': 12288},
    {'scheme': 'sphincs-shake-192f-simple', 'implementation': 'clean', 'estmemory': 41984},
    {'scheme': 'sphincs-shake-192s-simple', 'implementation': 'clean', 'estmemory': 22528},
    {'scheme': 'sphincs-shake-256f-simple', 'implementation': 'clean', 'estmemory': 59392},
    {'scheme': 'sphincs-shake-256s-simple', 'implementation': 'clean', 'estmemory': 38912},
    {'scheme': 'falcon-padded-1024', 'implementation': 'clean', 'estmemory': 91136},
    {'scheme': 'falcon-padded-512', 'implementation': 'clean', 'estmemory': 48128},
    {'scheme': 'ml-dsa-87', 'implementation': 'm4fstack', 'estmemory': 21504},
    {'scheme': 'ml-dsa-87', 'implementation': 'm4f', 'estmemory': 129024},
    {'scheme': 'ml-dsa-65', 'implementation': 'm4fstack', 'estmemory': 17408},
    {'scheme': 'ml-dsa-65', 'implementation': 'm4f', 'estmemory': 79872},
    {'scheme': 'ml-dsa-44', 'implementation': 'm4fstack', 'estmemory': 12288},
    {'scheme': 'ml-dsa-44', 'implementation': 'm4f', 'estmemory': 57344},
    {'scheme': 'ml-dsa-87', 'implementation': 'clean', 'estmemory': 136192},
    {'scheme': 'ml-dsa-65', 'implementation': 'clean', 'estmemory': 90112},
    {'scheme': 'ml-dsa-44', 'implementation': 'clean', 'estmemory': 59392},
    {'scheme': 'fndsa_provisional-1024', 'implementation': 'ref', 'estmemory': 89088},
    {'scheme': 'fndsa_provisional-512', 'implementation': 'ref', 'estmemory': 46080},
    {'scheme': 'fndsa_provisional-1024', 'implementation': 'm4f', 'estmemory': 89088},
    {'scheme': 'fndsa_provisional-512', 'implementation': 'm4f', 'estmemory': 46080},
]
