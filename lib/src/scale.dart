library d3.src.scale;

import 'js/scale.dart' as scale;

/// A linear quantitative scale.
class LinearScale<T> {
  final scale.LinearScale js;
  LinearScale() : js = scale.linear();

  /// Set the scale's input domain.
  void set domain(List<num> numbers) {
    js.domain(numbers);
  }

  /// Get or set the scale's output range.
  void set range(List<T> values) {
    js.range(values);
  }
}
