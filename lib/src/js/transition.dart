library d3.src.js.transition;

import 'dart:html';
import 'dart:js';

import 'd3.dart';
import 'selection.dart' as sel;
import 'color.dart' as color;
import 'math.dart' as math;

JsObject _d3 = context['d3'];

/// Start an animated transition.
Transition transition([sel.Selection selection, String name = '']) {
  return new Transition(selection, name);
}

class Transition {
  final JsObject _proxy;

  Transition._(this._proxy);

  factory Transition([sel.Selection selection, String name = '']) {
    var args = [];
    if (selection != null) {
      args.add(sel.getProxy(selection));
    }
    args.add(name);
    return new Transition._(_d3.callMethod('transition', args));
  }

  /// Specify per-element delay in milliseconds.
  delay([delay = undefined]) {
    var args = [];
    if (delay is Function) {
      args.add(func4VarArgs(delay));
    } else if (delay != undefined) {
      args.add(delay);
    }
    var retval = _proxy.callMethod('delay', args);
    if (delay == undefined) {
      return retval;
    } else {
      return new Transition._(retval);
    }
  }

  /// Specify per-element duration in milliseconds.
  duration([duration = undefined]) {
    var args = [];
    if (duration is Function) {
      args.add(func4VarArgs(duration));
    } else if (duration != undefined) {
      args.add(duration);
    }
    var retval = _proxy.callMethod('duration', args);
    if (duration == undefined) {
      return retval;
    } else {
      return new Transition._(retval);
    }
  }

  /// Specify transition easing function.
  ease([value = undefined, arguments = undefined]) {
    var args = [];
    if (value != undefined) {
      args.add(value);
    }
    if (arguments != undefined) {
      args.add(arguments);
    }
    var retval = _proxy.callMethod('ease', args);
    if (value == undefined) {
      return retval;
    } else {
      return new Transition._(retval);
    }
  }

  /// Smoothly transition to the new attribute value.
  Transition attr(String name, value) {
    var args = [name];
    if (value is Function) {
      args.add(func4VarArgs(value));
    } else {
      args.add(value);
    }
    return new Transition._(_proxy.callMethod('attr', args));
  }

  /// Smoothly transition between two attribute values.
  Transition attrTween(String name, tween) {
    var args = [name];
    if (tween is Function) {
      args.add(func4VarArgs(tween));
    } else {
      args.add(tween);
    }
    return new Transition._(_proxy.callMethod('attrTween', args));
  }

  /// Smoothly transition to the new style property value.
  Transition style(String name, value, [priority = undefined]) {
    var args = [name];
    if (value is Function) {
      args.add(func4VarArgs(value));
    } else {
      args.add(value);
    }
    if (priority != undefined) {
      args.add(priority);
    }
    return new Transition._(_proxy.callMethod('style', args));
  }

  /// Smoothly transition between two style property values.
  Transition styleTween(name, tween, [String priority = undefinedString]) {
    var args = [name];
    if (tween is Function) {
      args.add(func4VarArgs(tween));
    } else {
      args.add(tween);
    }
    if (priority != undefinedString) {
      args.add(priority);
    }
    return new Transition._(_proxy.callMethod('styleTween', args));
  }

  /// Set the text content when the transition starts.
  Transition text(value) {
    var args = [];
    if (value is Function) {
      args.add(func4VarArgs(value));
    } else {
      args.add(value);
    }
    return new Transition._(_proxy.callMethod('text', args));
  }

  /// Specify a custom tween operator to run as part of the transition.
  Transition tween(String name, Function fn) {
    var args = [name, func3VarArgs(fn)];
    return new Transition._(_proxy.callMethod('tween', args));
  }

  /// Remove selected elements at the end of a transition.
  Transition remove() => new Transition._(_proxy.callMethod('remove'));

  /// Start a transition on a descendant element for each selected element.
  Transition select(String selector) {
    var args = [];
    if (selector is Function) {
      args.add(func4VarArgs(selector));
    } else {
      args.add(selector);
    }
    return new Transition._(_proxy.callMethod('select', args));
  }

  /// Start a transition on multiple descendants for each selected element.
  Transition selectAll(String selector) {
    var args = [];
    if (selector is Function) {
      args.add(func4VarArgs(selector));
    } else {
      args.add(selector);
    }
    return new Transition._(_proxy.callMethod('selectAll', args));
  }

  /// Filter a transition based on data.
  Transition filter(selector) {
    var args = [];
    if (selector is Function) {
      args.add(func4VarArgs(selector));
    } else {
      args.add(selector);
    }
    return new Transition._(_proxy.callMethod('filter', args));
  }

  /// When this transition ends, start another one on the same elements.
  Transition transition() => new Transition._(_proxy.callMethod('transition'));

  /// Add a listener for transition end events.
  Transition each(Function listener, {String type: undefinedString}) {
    var args = [];
    if (type != undefinedString) {
      args.add(type);
    }
    args.add(func4VarArgs(listener));
    return new Transition._(_proxy.callMethod('each', args));
  }

  /// Call a function passing in the current transition.
  Transition call(Function function,
      [arg1 = undefined,
      arg2 = undefined,
      arg3 = undefined,
      arg4 = undefined,
      arg5 = undefined,
      arg6 = undefined,
      arg7 = undefined]) {
    var args = [function];
    if (arg1 != undefined) {
      args.add(arg1);
    }
    if (arg2 != undefined) {
      args.add(arg2);
    }
    if (arg3 != undefined) {
      args.add(arg3);
    }
    if (arg4 != undefined) {
      args.add(arg4);
    }
    if (arg5 != undefined) {
      args.add(arg5);
    }
    if (arg6 != undefined) {
      args.add(arg6);
    }
    if (arg7 != undefined) {
      args.add(arg7);
    }
    return new Transition._(_proxy.callMethod('call', args));
  }

  /// Returns true if the transition is empty.
  bool empty() => _proxy.callMethod('empty');

  /// Returns the first node in the transition.
  Node node() => _proxy.callMethod('node');

  /// Returns the number of elements in the selection.
  int size() => _proxy.callMethod('size');
}

/// Customize transition timing.
Ease ease(String type, [List arguments]) {
  var args = [type]..addAll(arguments);
  return new Ease._(_d3.callMethod('ease', args));
}

/// A parametric easing function.
class Ease {
  final JsObject _proxy;

  Ease._(this._proxy);

  factory Ease(String type, [List arguments]) => ease(type, arguments);

  /// A parametric easing function.
  num call(num t) => _proxy.callMethod('call', [_proxy, t]);
}

/// Start a custom animation timer.
timer(bool fn(t), [num delay = undefinedNum, time = undefined]) {
  var args = [fn];
  if (delay != undefinedNum) {
    args.add(delay);
  }
  if (time != null) {
    args.add(time);
  }
  _d3.callMethod('timer', args);
}

/// Immediately execute any zero-delay timers.
flushTimer() => _d3['timer'].callMethod('flush');

/// Interpolate two values.
Interpolate interpolate(a, b) {
  return new Interpolate._(_d3.callMethod('interpolate', [a, b]));
}

/// A parametric interpolation function.
class Interpolate {
  final JsObject _proxy;

  Interpolate._(this._proxy);

  factory Interpolate(a, b) => interpolate(a, b);

  /// Interpolate two numbers.
  factory Interpolate.number(num a, num b) => interpolateNumber(a, b);

  /// Interpolate two integers.
  factory Interpolate.round(int a, int b) => interpolateRound(a, b);

  /// Interpolate two strings.
  factory Interpolate.string(String a, String b) => interpolateString(a, b);

  /// Interpolate two RGB colors.
  factory Interpolate.rgb(color.Rgb a, color.Rgb b) => interpolateRgb(a, b);

  /// Interpolate two HSL colors.
  factory Interpolate.hsl(color.Hsl a, color.Hsl b) => interpolateHsl(a, b);

  /// Interpolate two L*a*b* colors.
  factory Interpolate.lab(color.Lab a, color.Lab b) => interpolateLab(a, b);

  /// Interpolate two HCL colors.
  factory Interpolate.hcl(color.Hcl a, color.Hcl b) => interpolateHcl(a, b);

  /// Interpolate two arrays of values.
  factory Interpolate.array(List a, List b) => interpolateArray(a, b);

  /// Interpolate two arbitrary objects.
  factory Interpolate.object(a, b) => interpolateObject(a, b);

  /// Interpolate two 2D matrix transforms.
  factory Interpolate.transform(math.Transform a, math.Transform b) =>
      interpolateTransform(a, b);

  /// Zoom and pan between two points smoothly.
  factory Interpolate.zoom(a, b) => interpolateZoom(a, b);

  /// A parametric interpolation function.
  call(num t) => _proxy.callMethod('call', [_proxy, t]);
}

/// Interpolate two numbers.
Interpolate interpolateNumber(num a, num b) {
  return new Interpolate._(_d3.callMethod('interpolateNumber', [a, b]));
}

/// Interpolate two integers.
Interpolate interpolateRound(int a, int b) {
  return new Interpolate._(_d3.callMethod('interpolateRound', [a, b]));
}

/// Interpolate two strings.
Interpolate interpolateString(String a, String b) {
  return new Interpolate._(_d3.callMethod('interpolateString', [a, b]));
}

/// Interpolate two RGB colors.
Interpolate interpolateRgb(color.Rgb a, color.Rgb b) {
  return new Interpolate._(
      _d3.callMethod('interpolateRgb', [color.getProxy(a), color.getProxy(b)]));
}

/// Interpolate two HSL colors.
Interpolate interpolateHsl(color.Hsl a, color.Hsl b) {
  return new Interpolate._(
      _d3.callMethod('interpolateHsl', [color.getProxy(a), color.getProxy(b)]));
}

/// Interpolate two L*a*b* colors.
Interpolate interpolateLab(color.Lab a, color.Lab b) {
  return new Interpolate._(
      _d3.callMethod('interpolateLab', [color.getProxy(a), color.getProxy(b)]));
}

/// Interpolate two HCL colors.
Interpolate interpolateHcl(color.Hcl a, color.Hcl b) {
  return new Interpolate._(
      _d3.callMethod('interpolateHcl', [color.getProxy(a), color.getProxy(b)]));
}

/// Interpolate two arrays of values.
Interpolate interpolateArray(List a, List b) {
  return new Interpolate._(_d3.callMethod(
      'interpolateArray', [color.getProxy(a), color.getProxy(b)]));
}

/// Interpolate two arbitrary objects.
Interpolate interpolateObject(a, b) {
  return new Interpolate._(_d3.callMethod('interpolateObject', [a, b]));
}

/// Interpolate two 2D matrix transforms.
Interpolate interpolateTransform(math.Transform a, math.Transform b) {
  return new Interpolate._(_d3.callMethod(
      'interpolateTransform', [math.getProxy(a), math.getProxy(b)]));
}

/// Zoom and pan between two points smoothly.
Interpolate interpolateZoom(a, b) {
  return new Interpolate._(_d3.callMethod('interpolateZoom', [a, b]));
}

/// Register a custom interpolator.
List<Interpolate> get interpolators {
  return _d3['interpolators'].map((i) => new Interpolate._(i)).toList();
}

/// For internal use.
Transition newTransition(JsObject proxy) => new Transition._(proxy);

/// For internal use.
JsObject getProxy(arg) => arg._proxy;
