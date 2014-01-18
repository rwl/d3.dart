part of interpolate;

Function interpolateNumber(num a, num b) {
  b -= a;
  return (t) { return a + b * t; };
}