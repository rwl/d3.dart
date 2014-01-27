part of interpolate;

Function uninterpolateNumber(a, b) {
  a = utils.toDouble(a);
  b = utils.toDouble(b);
  b = b - a > 0 ? 1 / (b - a) : 0;
  return (x) { return (utils.toDouble(x) - a) * b; };
}

Function uninterpolateClamp(a, b) {
  a = utils.toDouble(a);
  b = utils.toDouble(b);
  b = b - a > 0 ? 1 / (b - a) : 0;
  return (x) { return math.max(0, math.min(1, (utils.toDouble(x) - a) * b)); };
}
