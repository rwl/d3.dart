library d3.src.formatting;

import 'dart:js';

JsObject _d3 = context['d3'];

/// Format a number as a string.
format(specifier) {
  return _d3.callMethod('format', []);
}

/// Returns the SI prefix for the specified value and precision.
formatPrefix(value, [precision]) {
  return _d3.callMethod('formatPrefix', []);
}

/// Rounds a value to some digits after the decimal point.
round(x, [n]) {
  return _d3.callMethod('round', []);
}

/// Quote a string for use in a regular expression.
requote(string) {
  return _d3.callMethod('requote', []);
}
