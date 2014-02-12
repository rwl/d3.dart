part of scale;

//ordinal() {
//  return new Ordinal([], new Ranger("range", [[]]));
//}

class Ordinal {
  List _domain;
  Ranger ranger;

  Map _index;
  List _range;
  int _rangeBand;

  Ordinal([domain = null, ranger = null]) {
    this.ranger = ranger == null ? new Ranger(RangeType.RANGE, []) : ranger;
    this.domain = domain == null ? [] : domain;
  }

  call(x) {
    if (_index.containsKey(x)) {
      return _range[(_index[x] - 1) % range.length];
    } else if (ranger.t == RangeType.RANGE) {
      _domain.add(x);
      _index[x] = x;
      return _range[(_index[x] - 1) % range.length];
    }
//    return _range[((_index[x] || ranger.t == "range" && _index[x] = _domain.add(x)) - 1) % range.length];
  }

  steps(start, step) {
    return arrays.range(domain.length).map((i) {
      return start + step * i;
    });
  }

  List get domain => _domain;

  void set domain(x) {
    _domain = [];
    _index = new Map();
    int i = -1, n = x.length;
    var xi;
    while (++i < n) {
      if (!_index.containsKey(xi = x[i])) {
        _domain.add(xi);
        _index[xi] = xi;
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
//    return scale;
  }

  rangeBands(List x, [padding=0, outerPadding=null]) {
    if (outerPadding == null) {
      outerPadding = padding;
    }
    final reverse = x[1] < x[0];
    final start = x[reverse - 0];
    final stop = x[1 - reverse];
    final step = (stop - start) / (_domain.length - padding + 2 * outerPadding);
    _range = steps(start + step * outerPadding, step);
    if (reverse) {
      _range = _range.reversed;
    }
    _rangeBand = step * (1 - padding);
    ranger = new Ranger(RangeType.RANGE_BANDS, x, padding, outerPadding);
//    return scale;
  }

  rangeRoundBands(x, [padding=0, outerPadding=null]) {
    if (outerPadding == null) {
      outerPadding = padding;
    }
    final reverse = x[1] < x[0];
    final start = x[reverse - 0];
    final stop = x[1 - reverse];
    final step = ((stop - start) / (_domain.length - padding + 2 * outerPadding)).floor();
    final error = stop - start - (_domain.length - padding) * step;
    range = steps(start + (error / 2).round(), step);
    if (reverse) {
      _range = _range.reversed;
    }
    _rangeBand = (step * (1 - padding)).round();
    ranger = new Ranger(RangeType.RANGE_ROUND_BANDS, x, padding, outerPadding);
//    return scale;
  }

  int get rangeBand => _rangeBand;

  List get rangeExtent => scaleExtent(ranger.x[0]);

  copy() => new Ordinal(_domain, ranger);

}

class Ranger {
  RangeType t;
  List x;
  int padding;
  int outerPadding;

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