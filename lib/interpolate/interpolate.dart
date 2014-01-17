library interpolate;

import 'dart:math' as math;

import '../color/color.dart' as color;

part 'rgb.dart';
part 'string.dart';
part 'number.dart';
part 'array.dart';
part 'object.dart';

interpolate(a, b) {
  var i = interpolators.length;
  Function f;
  while (--i >= 0 && !(f = interpolators[i](a, b)));
  return f;
}

List interpolators = [
  (a, b) {
    if (b is String) {
      if (color.rgb_names.containsKey(b)) {// || "^(#|rgb\(|hsl\()".test(b)) {
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
