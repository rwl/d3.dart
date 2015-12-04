@JS('d3.behavior')
library d3.src.behavior;

import 'package:js/js.dart';

external Drag drag();

@JS()
class Drag {
  external Drag on(type, [listener]);
  external Drag origin([origin]);
}

external Zoom zoom();

@JS()
class Zoom {
  external Zoom translate([translate]);
  external Zoom scale([scale]);
  external Zoom scaleExtent([extent]);
  external Zoom center([center]);
  external Zoom size([size]);
  external Zoom x([x]);
  external Zoom y([y]);
  external Zoom on(type, listener);
  external Zoom event(selection);
}
