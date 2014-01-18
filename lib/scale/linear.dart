part of scale;

linear() {
  return new Linear([0, 1], [0, 1], lib_interpolate.interpolate, false);
}

class Linear {

  List _domain, _range;
  Function _interpolate;
  bool _clamp;

  var output, input;

  Linear(this._domain, this._range, this._interpolate, this._clamp);

  rescale() {
    var linear = math.min(domain.length, _range.length) > 2 ? polylinear : bilinear;
    var uninterpolate = _clamp ? lib_interpolate.uninterpolateClamp : lib_interpolate.uninterpolateNumber;
    output = linear(_domain, _range, uninterpolate, _interpolate);
    input = linear(_range, _domain, uninterpolate, lib_interpolate.interpolate);
    return scale;
  }

  scale(x) {
    return output(x);
  }

  List get domain => _domain;

  set domain(List x) {
    _domain = x;//.map(num);
    return rescale();
  }

  List get range => _range;

  set range(List x) {
    _range = x;
    return rescale();
  }

  Function get interpolate => _interpolate;

  set interpolate(Function x) {
    _interpolate = x;
    return rescale();
  }

  bool get clamp => _clamp;

  set clamp(bool x) {
    _clamp = x;
    return rescale();
  }

}