@JS('d3.svg')
library d3.src.svg;

import 'package:js/js.dart';

external Axis axis();

@JS()
class Axis {
  external Axis scale([scale]);
  external Axis orient([orientation]);
  external Axis ticks([arguments]);
  external Axis tickSize([inner, outer]);
}
