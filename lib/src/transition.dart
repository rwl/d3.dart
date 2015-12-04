@JS('d3')
library d3.src.transition;

import 'dart:html';
import 'package:js/js.dart';

/// start an animated transition.
external Transition transition([selection, name]);

@JS()
class Transition {
  /// specify per-element delay in milliseconds.
  external Transition delay([delay]);

  /// specify per-element duration in milliseconds.
  external Transition duration([duration]);

  /// specify transition easing function.
  external Transition ease([value, arguments]);

  /// smoothly transition to the new attribute value.
  external Transition attr(name, value);

  /// smoothly transition between two attribute values.
  external Transition attrTween(name, tween);

  /// smoothly transition to the new style property value.
  external Transition style(name, value, [priority]);

  /// smoothly transition between two style property values.
  external Transition styleTween(name, tween, [priority]);

  /// set the text content when the transition starts.
  external Transition text(value);

  /// specify a custom tween operator to run as part of the transition.
  external Transition tween(name, factory);

  /// remove selected elements at the end of a transition.
  external Transition remove();

  /// start a transition on a descendant element for each selected element.
  external Transition select(selector);

  /// start a transition on multiple descendants for each selected element.
  external Transition selectAll(selector);

  /// filter a transition based on data.
  external Transition filter(selector);

  /// when this transition ends, start another one on the same elements.
  external Transition transition();

  /// add a listener for transition end events.
  external Transition each([type, listener]);

  /// call a function passing in the current transition.
  external Transition call(function, [arguments]);

  /// returns true if the transition is empty.
  external bool empty();

  /// returns the first node in the transition.
  external Node node();

  /// returns the number of elements in the selection.
  external int size();
}

/// customize transition timing.
external Ease ease(type, [arguments]);

@JS()
class Ease {
  /// a parametric easing function.
  external num ease(t);
}

/// start a custom animation timer.
external timer(function, [delay, time]);

/// immediately execute any zero-delay timers.
@JS('timer.flush')
external flushTimer();

/// interpolate two values.
external Interpolate interpolate(a, b);

@JS()
class Interpolate {
  /// a parametric interpolation function.
  external interpolate(t);
}

/// interpolate two numbers.
external interpolateNumber(a, b);

/// interpolate two integers.
external interpolateRound(a, b);

/// interpolate two strings.
external interpolateString(a, b);

/// interpolate two RGB colors.
external interpolateRgb(a, b);

/// interpolate two HSL colors.
external interpolateHsl(a, b);

/// interpolate two L*a*b* colors.
external interpolateLab(a, b);

/// interpolate two HCL colors.
external interpolateHcl(a, b);

/// interpolate two arrays of values.
external interpolateArray(a, b);

/// interpolate two arbitrary objects.
external interpolateObject(a, b);

/// interpolate two 2D matrix transforms.
external interpolateTransform(a, b);

/// zoom and pan between two points smoothly.
external interpolateZoom(a, b);

@JS('geo.interpolate')
external geo_interpolate(a, b);

/// register a custom interpolator.
external List get interpolators;
