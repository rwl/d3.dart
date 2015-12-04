@JS('d3')
library d3.src.transition;

import 'dart:html';
import 'package:js/js.dart';

/// Start an animated transition.
external Transition transition([selection, name]);

@JS()
class Transition {
  /// Specify per-element delay in milliseconds.
  external Transition delay([delay]);

  /// Specify per-element duration in milliseconds.
  external Transition duration([duration]);

  /// Specify transition easing function.
  external Transition ease([value, arguments]);

  /// Smoothly transition to the new attribute value.
  external Transition attr(name, value);

  /// Smoothly transition between two attribute values.
  external Transition attrTween(name, tween);

  /// Smoothly transition to the new style property value.
  external Transition style(name, value, [priority]);

  /// Smoothly transition between two style property values.
  external Transition styleTween(name, tween, [priority]);

  /// Set the text content when the transition starts.
  external Transition text(value);

  /// Specify a custom tween operator to run as part of the transition.
  external Transition tween(name, factory);

  /// Remove selected elements at the end of a transition.
  external Transition remove();

  /// Start a transition on a descendant element for each selected element.
  external Transition select(selector);

  /// Start a transition on multiple descendants for each selected element.
  external Transition selectAll(selector);

  /// Filter a transition based on data.
  external Transition filter(selector);

  /// When this transition ends, start another one on the same elements.
  external Transition transition();

  /// Add a listener for transition end events.
  external Transition each([type, listener]);

  /// Call a function passing in the current transition.
  external Transition call(function, [arguments]);

  /// Returns true if the transition is empty.
  external bool empty();

  /// Returns the first node in the transition.
  external Node node();

  /// Returns the number of elements in the selection.
  external int size();
}

/// Customize transition timing.
external Ease ease(type, [arguments]);

@JS()
class Ease {
  /// A parametric easing function.
  external num ease(t);
}

/// Start a custom animation timer.
external timer(function, [delay, time]);

/// Immediately execute any zero-delay timers.
@JS('timer.flush')
external flushTimer();

/// Interpolate two values.
external Interpolate interpolate(a, b);

@JS()
class Interpolate {
  /// A parametric interpolation function.
  external interpolate(t);
}

/// Interpolate two numbers.
external interpolateNumber(a, b);

/// Interpolate two integers.
external interpolateRound(a, b);

/// Interpolate two strings.
external interpolateString(a, b);

/// Interpolate two RGB colors.
external interpolateRgb(a, b);

/// Interpolate two HSL colors.
external interpolateHsl(a, b);

/// Interpolate two L*a*b* colors.
external interpolateLab(a, b);

/// Interpolate two HCL colors.
external interpolateHcl(a, b);

/// Interpolate two arrays of values.
external interpolateArray(a, b);

/// Interpolate two arbitrary objects.
external interpolateObject(a, b);

/// Interpolate two 2D matrix transforms.
external interpolateTransform(a, b);

/// Zoom and pan between two points smoothly.
external interpolateZoom(a, b);

@JS('geo.interpolate')
external geo_interpolate(a, b);

/// Register a custom interpolator.
external List get interpolators;
