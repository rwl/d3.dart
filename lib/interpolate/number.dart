part of interpolate;

Function interpolateNumber(a, b) {
  if (a is String) {
    a = (a.length == 0) ? 0 : double.parse(a);
  }
  if (b is String) {
    b = (b.length == 0) ? 0 : double.parse(b);
  }
  b -= a;
  return (t) { return a + b * t; };
}
