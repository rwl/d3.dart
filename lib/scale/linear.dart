part of scale;

linear() {
  return new Linear([0, 1], [0, 1], lib_interpolate.interpolate, false);
}

class Linear {

  List _domain, _range;
  Function _interpolate;
  bool _clamp;

  var output, input;

  Linear(this._domain, this._range, this._interpolate, this._clamp) {
    rescale();
  }

  rescale() {
    var linear = math.min(_domain.length, _range.length) > 2 ? polylinear : bilinear;
    var uninterpolate = _clamp ? lib_interpolate.uninterpolateClamp : lib_interpolate.uninterpolateNumber;
    output = linear(_domain, _range, uninterpolate, _interpolate);
    input = linear(_range, _domain, uninterpolate, lib_interpolate.interpolate);
    return scale;
  }

  scale(x) {
    return output(x);
  }

  // Note: requires range is coercible to number!
  invert(y) {
    return input(y);
  }

  domain([List x = null]) {
    if (x == null) return _domain;
    _domain = x;//.map(num);
    rescale();
    return this;
  }

  range([List x = null]) {
    if (x == null) return _range;
    _range = x;
    rescale();
    return this;
  }

  interpolate([Function x = null]) {
    if (x == null) return _interpolate;
    _interpolate = x;
    rescale();
    return this;
  }

  clamp([bool x = null]) {
    if (x == null) return _clamp;
    _clamp = x;
    rescale();
    return this;
  }

  call(x) {
    rescale();
    return scale(x);
  }

}