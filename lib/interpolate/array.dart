part of interpolate;

Function interpolateArray(a, b) {
  var x = [],
      c = [],
      na = a.length,
      nb = b.length,
      n0 = math.min(a.length, b.length),
      i;
  for (i = 0; i < n0; ++i) x.add(interpolate(a[i], b[i]));
  for (; i < na; ++i) c[i] = a[i];
  for (; i < nb; ++i) c[i] = b[i];
  return (t) {
    for (i = 0; i < n0; ++i) c[i] = x[i](t);
    return c;
  };
}
