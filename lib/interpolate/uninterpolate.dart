part of interpolate;

Function uninterpolateNumber(num a, num b) {
  b = b - a > 0 ? 1 / (b - a) : 0;
  return (x) { return (x - a) * b; };
}

Function uninterpolateClamp(num a, num b) {
  b = b - a > 0 ? 1 / (b - a) : 0;
  return (x) { return math.max(0, math.min(1, (x - a) * b)); };
}
