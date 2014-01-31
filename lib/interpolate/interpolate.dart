library interpolate;

import 'dart:math' as math;

import '../color/color.dart' as color;
import '../utils.dart' as utils;

part 'rgb.dart';
part 'hsl.dart';
part 'string.dart';
part 'number.dart';
part 'array.dart';
part 'object.dart';
part 'uninterpolate.dart';

interpolate(a, b) {
  var i = interpolators.length;
  Function f;
  while (--i >= 0) {
    var intp = interpolators[i];
    f = intp(a, b);
    if (f != null) {
      break; // FIXME
    }
  }
  return f;
}

var colorString = new RegExp(r"^(#|rgb\(|hsl\()");

List interpolators = [
  (a, b) {
    if (b is String) {
      if (color.rgb_names.containsKey(b) || b.contains(colorString)) {
        return interpolateRgb(a, b);
      }
      return interpolateString(a, b);
    } else if (b is color.Color) {
      return interpolateRgb(a, b);
    } else if (b is List) {
      return interpolateArray(a, b);
    } else if (b is num) {
      return interpolateNumber(a, b);
    }
    return interpolateObject(a, b);
  }
];
