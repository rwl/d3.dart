library d3.src.transition;

import 'dart:html';
import 'dart:js';

JsObject _d3 = context['d3'];

/// Start an animated transition.
Transition transition([selection, name]) {
  return _d3.callMethod('transition', []);
}

class Transition {
  final JsObject _proxy;

  Transition._(this._proxy);

  /// Specify per-element delay in milliseconds.
  Transition delay([delay]) {
    return _proxy.callMethod('delay', []);
  }

  /// Specify per-element duration in milliseconds.
  Transition duration([duration]) {
    return _proxy.callMethod('duration', []);
  }

  /// Specify transition easing function.
  Transition ease([value, arguments]) {
    return _proxy.callMethod('ease', []);
  }

  /// Smoothly transition to the new attribute value.
  Transition attr(name, value) {
    return _proxy.callMethod('attr', []);
  }

  /// Smoothly transition between two attribute values.
  Transition attrTween(name, tween) {
    return _proxy.callMethod('attrTween', []);
  }

  /// Smoothly transition to the new style property value.
  Transition style(name, value, [priority]) {
    return _proxy.callMethod('style', []);
  }

  /// Smoothly transition between two style property values.
  Transition styleTween(name, tween, [priority]) {
    return _proxy.callMethod('styleTween', []);
  }

  /// Set the text content when the transition starts.
  Transition text(value) {
    return _proxy.callMethod('text', []);
  }

  /// Specify a custom tween operator to run as part of the transition.
  Transition tween(name, factory) {
    return _proxy.callMethod('tween', []);
  }

  /// Remove selected elements at the end of a transition.
  Transition remove() {
    return _proxy.callMethod('remove', []);
  }

  /// Start a transition on a descendant element for each selected element.
  Transition select(selector) {
    return _proxy.callMethod('select', []);
  }

  /// Start a transition on multiple descendants for each selected element.
  Transition selectAll(selector) {
    return _proxy.callMethod('selectAll', []);
  }

  /// Filter a transition based on data.
  Transition filter(selector) {
    return _proxy.callMethod('filter', []);
  }

  /// When this transition ends, start another one on the same elements.
  Transition transition() {
    return _proxy.callMethod('transition', []);
  }

  /// Add a listener for transition end events.
  Transition each([type, listener]) {
    return _proxy.callMethod('each', []);
  }

  /// Call a function passing in the current transition.
  Transition call(function, [arguments]) {
    return _proxy.callMethod('call', []);
  }

  /// Returns true if the transition is empty.
  bool empty() {
    return _proxy.callMethod('empty', []);
  }

  /// Returns the first node in the transition.
  Node node() {
    return _proxy.callMethod('node', []);
  }

  /// Returns the number of elements in the selection.
  int size() {
    return _proxy.callMethod('size', []);
  }
}

/// Customize transition timing.
Ease ease(type, [arguments]) {
  return _d3.callMethod('ease', []);
}

class Ease {
  final JsObject _proxy;

  Ease._(this._proxy);

  /// A parametric easing function.
  num ease(t) {
    return _proxy.callMethod('ease', []);
  }
}

/// Start a custom animation timer.
timer(function, [delay, time]) {
  return _d3.callMethod('timer', []);
}

/// Immediately execute any zero-delay timers.
flushTimer() {
  return _d3['timer'].callMethod('flush', []);
}

/// Interpolate two values.
Interpolate interpolate(a, b) {
  return _d3.callMethod('interpolate', []);
}

class Interpolate {
  final JsObject _proxy;

  Interpolate._(this._proxy);

  /// A parametric interpolation function.
  interpolate(t) {
    return _proxy.callMethod('interpolate', []);
  }
}

/// Interpolate two numbers.
interpolateNumber(a, b) {
  return _d3.callMethod('interpolateNumber', []);
}

/// Interpolate two integers.
interpolateRound(a, b) {
  return _d3.callMethod('interpolateRound', []);
}

/// Interpolate two strings.
interpolateString(a, b) {
  return _d3.callMethod('interpolateString', []);
}

/// Interpolate two RGB colors.
interpolateRgb(a, b) {
  return _d3.callMethod('interpolateRgb', []);
}

/// Interpolate two HSL colors.
interpolateHsl(a, b) {
  return _d3.callMethod('interpolateHsl', []);
}

/// Interpolate two L*a*b* colors.
interpolateLab(a, b) {
  return _d3.callMethod('interpolateLab', []);
}

/// Interpolate two HCL colors.
interpolateHcl(a, b) {
  return _d3.callMethod('interpolateHcl', []);
}

/// Interpolate two arrays of values.
interpolateArray(a, b) {
  return _d3.callMethod('interpolateArray', []);
}

/// Interpolate two arbitrary objects.
interpolateObject(a, b) {
  return _d3.callMethod('interpolateObject', []);
}

/// Interpolate two 2D matrix transforms.
interpolateTransform(a, b) {
  return _d3.callMethod('interpolateTransform', []);
}

/// Zoom and pan between two points smoothly.
interpolateZoom(a, b) {
  return _d3.callMethod('interpolateZoom', []);
}

geo_interpolate(a, b) {
  return _d3['geo'].callMethod('interpolate', []);
}

/// Register a custom interpolator.
List get interpolators {
  return _d3['interpolators'];
}
