library interpolate;

import '../color/color.dart' as color;

part 'rgb.dart';

interpolate(a, b) {
  var i = interpolators.length;
  Function f;
  while (--i >= 0 && !(f = interpolators[i](a, b)));
  return f;
}

List interpolators = [
  (a, b) {
    var t = typeof b;
    return (t == "string" ? (rgb_names.containsKey(b) || "^(#|rgb\(|hsl\()".test(b) ? d3_interpolateRgb : d3_interpolateString)
        : b instanceof d3_Color ? d3_interpolateRgb
        : t === "object" ? (Array.isArray(b) ? d3_interpolateArray : d3_interpolateObject)
        : d3_interpolateNumber)(a, b);
  }
];
