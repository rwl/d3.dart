part of scale;

class Linear {
  List _domain, _range;
  Function _interpolate;
  bool _clamp;

  var output, input;

  Linear() {
    this._domain = [0, 1];
    this._range = [0, 1];
    this._interpolate = libInterpolate.interpolate;
    this._clamp = false;
    rescale();
  }

  rescale() {
    var linear = math.min(_domain.length, _range.length) > 2 ? polylinear : bilinear;
    var uninterpolate = _clamp ? libInterpolate.uninterpolateClamp : libInterpolate.uninterpolateNumber;
    output = linear(_domain, _range, uninterpolate, _interpolate);
    input = linear(_range, _domain, uninterpolate, libInterpolate.interpolate);
    return scale;
  }

  scale(x) {
    return output(x);
  }

  // Note: requires range is coercible to number!
  invert(y) {
    return input(y);
  }

  List get domain => _domain;

  void set domain(List x) {
    _domain = x.map(utils.toDouble).toList();
    rescale();
  }

  List get range => _range;

  void set range(List x) {
    _range = x;
    rescale();
  }

  Function get interpolate => _interpolate;

  void set interpolate(Function x) {
    _interpolate = x;
    rescale();
  }

  bool get clamp => _clamp;

  void set clamp(bool x) {
    _clamp = x;
    rescale();
  }

  ticks(int m) {
    return linearTicks(domain, m);
  }

  tickFormat(m, [format=null]) {
    return linearTickFormat(domain, m, format);
  }

  Linear copy() {
    return new Linear()
      ..domain = this.domain
      ..range = this.range
      ..interpolate = this.interpolate
      ..clamp = this.clamp;
  }

  call(x) {
    rescale();
    return scale(x);
  }
}

linearTickRange(domain, m) {
  if (m == null) m = 10;

  var extent = scaleExtent(domain),
      span = extent[1] - extent[0],
      step = math.pow(10, (math.log(span / m) / math.LN10).floor()),
      err = m / span * step;

  // Filter ticks to get closer to the desired count.
  if (err <= .15) step *= 10;
  else if (err <= .35) step *= 5;
  else if (err <= .75) step *= 2;

  // Round start and stop values to step interval.
  extent[0] = (extent[0] / step).ceil() * step;
  extent[1] = (extent[1] / step).floor() * step + step * .5; // inclusive
  extent.add(step);
  return extent;
}

linearTicks(domain, m) {
  var range = linearTickRange(domain, m);
  return arrays.range(range[0], range[1], range[2]);
}

linearTickFormat(domain, m, fmt) {
  var range = linearTickRange(domain, m);
//  return format.format(fmt != null
//      ? fmt.replace(format_re, (a, b, c, d, e, f, g, h, i, j) { return [b, c, d, e, f, g, h, i || "." + linearFormatPrecision(j, range), j].join(""); })
//      : ",." + linearPrecision(range[2]) + "f");
  return (d) { return format.format(d); };
}

var linearFormatSignificant = {'s': 1, 'g': 1, 'p': 1, 'r': 1, 'e': 1};

// Returns the number of significant digits after the decimal point.
linearPrecision(value) {
  return -(math.log(value) / math.LN10 + .01).floor();
}

// For some format types, the precision specifies the number of significant
// digits; for others, it specifies the number of digits after the decimal
// point. For significant format types, the desired precision equals one plus
// the difference between the decimal precision of the range’s maximum absolute
// value and the tick step’s decimal precision. For format "e", the digit before
// the decimal point counts as one.
linearFormatPrecision(type, range) {
  var p = linearPrecision(range[2]);
  return linearFormatSignificant.containsKey(type)
      ? (p - linearPrecision(math.max(range[0].abs(), range[1].abs()))).abs() + (type != "e" ? 1 : 0)
      : p - (type == "%" ? 1 : 0) * 2;
}
