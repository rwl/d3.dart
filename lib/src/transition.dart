library d3.src.transition;

import 'js/transition.dart' as transition;
import 'selection.dart' show Attr, newAttr, SelectionFn, Styles, newStyles;

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

  /// Set style properties.
  Styles<String> get style => newStyles(this);

  /// Set style properties.
  Styles<SelectionFn> get styleFn => newStyles(this);

  /// Get or set attribute values.
  Attr<String> get attr => newAttr(this);

  /// Get or set attribute values.
  Attr<SelectionFn> get attrFn => newAttr(this);

  /// Subselect a descendant element for each selected element.
  Transition select(String selector) => new Transition._(js.select(selector));

  /// Remove selected elements at the end of a transition.
  Transition remove() => new Transition._(js.remove());

  /// Call a function passing in the current transition.
  void call(function(selection)) {
    js.call(function);
  }

  /// Smoothly transition between two attribute values.
  void attrTween(String name, Function tween) {
    js.attrTween(name, tween);
  }

  /// Add a listener for transition end events.
  void each(Function listener, String type) {
    js.each(listener, type: type);
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
