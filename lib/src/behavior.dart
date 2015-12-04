@JS('d3.behavior')
library d3.src.behavior;

import 'package:js/js.dart';

external Drag drag();

@JS()
class Drag {
  external Drag on(type, [listener]);
  external Drag origin([origin]);
}

/// create a zoom behavior.
external Zoom zoom();

@JS()
class Zoom {
  /// apply the zoom behavior to the selected elements.
  external zoom(selection);

  /// the current translate offset.
  external Zoom translate([translate]);

  /// the current scale factor.
  external Zoom scale([scale]);

  /// optional limits on the scale factor.
  external Zoom scaleExtent([extent]);

  /// an optional focal point for mousewheel zooming.
  external Zoom center([center]);

  /// the dimensions of the viewport.
  external Zoom size([size]);

  /// an optional scale whose domain is bound to the x extent of the viewport.
  external Zoom x([x]);

  /// an optional scale whose domain is bound to the y extent of the viewport.
  external Zoom y([y]);

  /// listeners for when the scale or translate changes.
  external Zoom on(type, listener);

  /// dispatch zoom events after setting the scale or translate.
  external Zoom event(selection);

  /// get or set the dblclick transition duration.
  external Zoom duration([duration]);
}
