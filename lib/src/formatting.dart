@JS('d3')
library d3.src.formatting;

import 'package:js/js.dart';

/// Format a number as a string.
external format(specifier);

/// Returns the SI prefix for the specified value and precision.
external formatPrefix(value, [precision]);

/// Rounds a value to some digits after the decimal point.
external round(x, [n]);

/// Quote a string for use in a regular expression.
external requote(string);
