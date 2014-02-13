part of scale;

class Ordinal {
  List _domain;
  Ranger ranger;

  Map<String, int> _index;
  List _range;
  num _rangeBand;

  Ordinal([domain = null, ranger = null]) {
    this.ranger = ranger == null ? new Ranger(RangeType.RANGE, []) : ranger;
    this.domain = domain == null ? [] : domain;
  }

  /**
   * Given a value x in the input domain, returns the corresponding value in
   * the output range.
   */
  call(final Object x) {
    final String xs = x.toString();
    if (_index.containsKey(xs)) {
      return _range[(_index[xs] - 1) % _range.length];
    } else if (ranger.t == RangeType.RANGE) {
      _domain.add(x);
      _index[xs] = _domain.length;
      if (_range.length > 0) {
        return _range[(_index[xs] - 1) % _range.length];
      }
    }
    return null;
  }

  List steps(num start, num step) {
    return arrays.range(domain.length).map((i) {
      return start + step * i;
    }).toList();
  }

  List get domain => _domain;

  void set domain(List<Object> x) {
    _domain = [];
    _index = new Map<String, int>();
    int i = -1;
    final n = x.length;
    while (++i < n) {
      var xi = x[i];
      if (!_index.containsKey(xi.toString())) {
        _domain.add(xi);
        _index[xi.toString()] = _domain.length;
      }
    }

    switch (ranger.t) {
    case RangeType.RANGE:
      range = ranger.x;
      break;
    case RangeType.RANGE_POINTS:
      return rangePoints(ranger.x, ranger.padding);
      break;
    case RangeType.RANGE_BANDS:
      return rangeBands(ranger.x, ranger.padding, ranger.outerPadding);
      break;
    case RangeType.RANGE_ROUND_BANDS:
      return rangeRoundBands(ranger.x, ranger.padding, ranger.outerPadding);
      break;
    }
  }

  List get range => _range;

  void set range(List x) {
    _range = x;
    _rangeBand = 0;
    ranger = new Ranger(RangeType.RANGE, x);
  }

  rangePoints(List x, [int padding=0]) {
    final start = x[0];
    final stop = x[1];
    final step = (stop - start) / (math.max(1, _domain.length - 1) + padding);
    _range = steps(_domain.length < 2 ? (start + stop) / 2 : start + step * padding / 2, step);
    _rangeBand = 0;
    ranger = new Ranger(RangeType.RANGE_POINTS, x, padding);
  }

  rangeBands(List<num> x, [padding=0, outerPadding=null]) {
    if (outerPadding == null) {
      outerPadding = padding;
    }
    final int reverse = x[1] < x[0] ? 1 : 0;
    final start = x[reverse - 0];
    final stop = x[1 - reverse];
    final step = (stop - start) / (_domain.length - padding + 2 * outerPadding);
    _range = steps(start + step * outerPadding, step);
    if (reverse != 0) {
      _range = _range.reversed.toList();
    }
    _rangeBand = step * (1 - padding);
    ranger = new Ranger(RangeType.RANGE_BANDS, x, padding, outerPadding);
  }

  rangeRoundBands(List<num> x, [padding=0, outerPadding=null]) {
    if (outerPadding == null) {
      outerPadding = padding;
    }
    final int reverse = x[1] < x[0] ? 1 : 0;
    final start = x[reverse - 0];
    final stop = x[1 - reverse];
    num step = (stop - start) / (_domain.length - padding + 2 * outerPadding);
    if (!step.isNaN && !step.isInfinite) {
      step = step.floor();
    }
    final error = stop - start - (_domain.length - padding) * step;
    num st = start + (error / 2);
    if (!st.isNaN && !st.isInfinite) {
      st = st.round();
    }
    range = steps(st, step);
    if (reverse != 0) {
      _range = _range.reversed.toList();
    }
    num rb = step * (1 - padding);
    if (!rb.isNaN && !rb.isInfinite) {
      rb = rb.round();
    }
    _rangeBand = rb;
    ranger = new Ranger(RangeType.RANGE_ROUND_BANDS, x, padding, outerPadding);
  }

  num get rangeBand => _rangeBand;

  List get rangeExtent => scaleExtent(ranger.x);

  copy() => new Ordinal(_domain, ranger);

}

class Ranger {
  RangeType t;
  List x;
  num padding;
  num outerPadding;

  Ranger(this.t, this.x, [this.padding, this.outerPadding]);
}

class RangeType {
  final _value;
  const RangeType._internal(this._value);
  toString() => 'Enum.$_value';

  static const RANGE = const RangeType._internal('range');
  static const RANGE_POINTS = const RangeType._internal('rangePoints');
  static const RANGE_BANDS = const RangeType._internal('rangeBands');
  static const RANGE_ROUND_BANDS = const RangeType._internal('rangeRoundBands');
}
