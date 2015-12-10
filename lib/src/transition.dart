library d3.src.transition;

import 'js/transition.dart' as transition;

/// A special type of selection where the operators apply smoothly
/// over time rather than instantaneously.
class Transition {
  final transition.Transition js;

  Transition._(this.js);

  Transition() : js = transition.transition();

  /// Specify per-element duration in milliseconds.
  void set duration(num duration) {
    js.duration(duration);
  }

  /// Specify a custom tween operator to run as part of the transition.
  void tween(String name, Function fn()) {
    js.tween(name, fn);
  }

  /// Call a function passing in the current transition.
  void call(function(selection)) {
    js.call(function);
  }
}

/// A parametric interpolation function.
class Interpolate<T> {
  final transition.Interpolate js;

  Interpolate(T a, T b) : js = transition.interpolate(a, b);

  T call(num t) => js.call(t);
}

/// For internal use.
Transition newTransition(transition.Transition t) {
  return new Transition._(t);
}
