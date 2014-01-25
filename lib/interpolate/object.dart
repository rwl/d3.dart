part of interpolate;

Function interpolateObject(Map a, Map b) {
  Map i = {}, c = {};
  var k;
  a.forEach((k, v) {
    if (b.containsKey(k)) {
      i[k] = interpolate(v, b[k]);
    } else {
      c[k] = v;
    }
  });
  b.forEach((k, v) {
    if (!a.containsKey(k)) {
      c[k] = v;
    }
  });
  return (t) {
    i.forEach((k, v) {
      c[k] = v(t);
    });
    return c;
  };
}
