  for (i = 0;i < 256;++i) c0[i] = 0;
  for (i = 0;i < 256;++i) c1[i] = 0;
  for (i = 0;i < 256;++i) c2[i] = 0;
  for (i = 0;i < 256;++i) c3[i] = 0;

  for (i = n;i;) {
    uint32 u = x[--i];
    ++c0[255&u];
    ++c1[255&(u>>8)];
    ++c2[255&(u>>16)];
    ++c3[128^(u>>24)];
  }

  t0 = t1 = t2 = t3 = 0;
  for (i = 0;i < 256;++i) {
    t0 += c0[i]; c0[i] = t0;
    t1 += c1[i]; c1[i] = t1;
    t2 += c2[i]; c2[i] = t2;
    t3 += c3[i]; c3[i] = t3;
  }

  for (i = n;i;) { uint32 u = x[--i]; y[--c0[255&u]] = u; }
  for (i = n;i;) { uint32 u = y[--i]; x[--c1[255&(u>>8)]] = u; }
  for (i = n;i;) { uint32 u = x[--i]; y[--c2[255&(u>>16)]] = u; }
  for (i = n;i;) { uint32 u = y[--i]; x[--c3[128^(u>>24)]] = u; }
