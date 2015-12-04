@JS('d3')
library d3.src.selection;

import 'package:js/js.dart';

external Selection select(selector);

@JS()
class Selection {
  //external Selection(selector);
  external Selection select(selector);
  external Selection selectAll(selector);
  external Selection data([values, key]);
  external Selection enter();
  external Selection append(String name);
  external Selection style(name, [value, priority]);
  external Selection text([value]);
  external Selection attr(name, [value]);
  external Selection call(function, [arguments]);
  external Selection on(type, [listener, capture]);
}
