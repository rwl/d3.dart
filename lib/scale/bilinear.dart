part of scale;

Function bilinear(List domain, List range, Function uninterpolate, Function interpolate) {
  Function u = uninterpolate(domain[0], domain[1]);
  Function i = interpolate(range[0], range[1]);
  return (x) {
    return i(u(x));
  };
}
