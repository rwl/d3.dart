//@Js('d3')
library d3.selection;

import 'package:js/js.dart';

@Js('d3.select')
external Selection select(selector);

@Js()
class Selection {
  //external Selection(selector);
  external Selection selectAll(selector);
  external Selection data([values, key]);
  external Selection enter();
  external Selection append(String name);
  external Selection style(name, [value, priority]);
  external Selection text([value]);
}
