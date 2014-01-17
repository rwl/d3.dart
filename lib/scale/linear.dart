part of scale;

linear() {
  return new Linear([0, 1], [0, 1], d3_interpolate, false);
}

class Linear {
  
  List _domain, _range;
  Function _interpolate;
  bool _clamp;
  
  var output, input;
  
  Linear(this._domain, this._range, this._interpolate, this._clamp);

  rescale() {
    var linear = math.min(domain.length, range.length) > 2 ? d3_scale_polylinear : d3_scale_bilinear,
        uninterpolate = clamp ? d3_uninterpolateClamp : d3_uninterpolateNumber;
    output = linear(domain, range, uninterpolate, interpolate);
    input = linear(range, domain, uninterpolate, d3_interpolate);
    return scale;
  }
  
  List get domain => _domain;
  
  void set domain(List x) {
    _domain = x.map(Number);
    return rescale();
  }
  
}