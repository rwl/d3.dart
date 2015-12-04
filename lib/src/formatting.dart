@JS('d3')
library d3.src.formatting;

import 'package:js/js.dart';

/// format a number as a string.
external format(specifier);

/// returns the SI prefix for the specified value and precision.
external formatPrefix(value, [precision]);

/// rounds a value to some digits after the decimal point.
external round(x, [n]);

/// quote a string for use in a regular expression.
external requote(string);
