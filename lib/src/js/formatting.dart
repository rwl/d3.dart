library d3.src.js.formatting;

import 'dart:js';
import 'd3.dart';

JsObject _d3 = context['d3'];

/// Format a number as a string.
Function format(String specifier) {
  return _d3.callMethod('format', [specifier]);
}

/// Returns the SI prefix for the specified value and precision.
formatPrefix(value, [/*num*/ precision = undefined]) {
  var args = [value];
  if (precision != undefined) {
    args.add(precision);
  }
  return _d3.callMethod('formatPrefix', args);
}

/// Rounds a value to some digits after the decimal point.
round(x, [int n = 0]) => _d3.callMethod('round', [x, n]);

/// Quote a string for use in a regular expression.
String requote(String string) => _d3.callMethod('requote', [string]);
