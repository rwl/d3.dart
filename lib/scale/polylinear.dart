part of scale;

Function polylinear(List domain, List range, Function uninterpolate, Function interpolate) {
  var u = [],
      i = [],
      j = 0,
      k = math.min(domain.length, range.length) - 1;

  // Handle descending domains.
  bool decending = false;
  try {
    decending = domain[k] < domain[0];
  } catch (e) {
    decending = domain[k].compareTo(domain[0]) < 0;
  }
  if (decending) {
    domain = new List.from(domain.reversed);
    range = new List.from(range.reversed);
  }

  while (++j <= k) {
    u.add(uninterpolate(domain[j - 1], domain[j]));
    i.add(interpolate(range[j - 1], range[j]));
  }

  return (x) {
    var j = arrays.bisect(domain, x, lo:1, hi:k) - 1;
    return i[j](u[j](x));
  };
}