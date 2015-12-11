library d3.src.scale;

import 'js/scale.dart' as scale;

/// Converts between data and visual encodings.
abstract class Scale {
  dynamic get js;
}

/// A linear quantitative scale.
class LinearScale<T> implements Scale {
  final scale.LinearScale js;

  LinearScale() : js = scale.linear();

  /// Get the range value corresponding to a given domain value.
  T call(num x) => js.call(x);

  /// Set the scale's input domain.
  void set domain(Iterable<num> numbers) {
    js.domain(numbers.toList());
  }

  /// Get or set the scale's input domain.
  List<num> get domain => js.domain();

  /// Get or set the scale's output range.
  void set range(Iterable<T> values) {
    js.range(values.toList());
  }
}

/// Construct a linear identity scale.
class IdentityScale<T> implements Scale {
  final scale.IdentityScale js;

  IdentityScale() : js = scale.identity();

  /// The identity function.
  T call(num x) => js.call(x);

  /// Get or set the scale's domain and range.
  void set domain(List<num> numbers) {
    js.domain(numbers);
  }
}

/// For discrete input domains, such as names or categories.
class OrdinalScale<T, U> implements Scale {
  final scale.Ordinal js;

  OrdinalScale._(this.js);

  OrdinalScale() : js = scale.ordinal();

  factory OrdinalScale.category10() => new OrdinalScale._(scale.category10());

  factory OrdinalScale.category20() => new OrdinalScale._(scale.category20());

  factory OrdinalScale.category20b() => new OrdinalScale._(scale.category20b());

  factory OrdinalScale.category20c() => new OrdinalScale._(scale.category20c());

  /// Get the range value corresponding to a given domain value.
  U call(T x) => js.call(x);

  /// Set the scale's input domain.
  void set domain(Iterable<T> values) {
    js.domain(values.toList());
  }

  /// Divide a continuous output range for discrete bands.
  void rangeRoundBands(Iterable<num> interval,
      [num padding, num outerPadding]) {
    if (padding == null) {
      js.rangeRoundBands(interval.toList());
    } else if (outerPadding == null) {
      js.rangeRoundBands(interval.toList(), padding);
    } else {
      js.rangeRoundBands(interval.toList(), padding, outerPadding);
    }
  }

  /// Get the discrete range band width.
  num get rangeBand => js.rangeBand();
}
