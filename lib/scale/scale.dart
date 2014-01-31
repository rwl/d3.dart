library scale;

import 'dart:math' as math;

import '../color/color.dart' as color;
import '../interpolate/interpolate.dart' as libInterpolate;
import '../arrays/arrays.dart' as arrays;
import '../locale/locale.dart';
import '../format/format.dart';
import '../utils.dart' as utils;

part 'category.dart';
part 'ordinal.dart';
part 'linear.dart';
part 'polylinear.dart';
part 'bilinear.dart';

scaleExtent(domain) {
  var start = domain[0], stop = domain[domain.length - 1];
  return start < stop ? [start, stop] : [stop, start];
}

scaleRange(scale) {
  return scale.rangeExtent ? scale.rangeExtent() : scaleExtent(scale.range());
}
