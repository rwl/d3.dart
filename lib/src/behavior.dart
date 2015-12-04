@JS('d3.behavior')
library d3.src.behavior;

import 'package:js/js.dart';

external Drag drag();

@JS()
class Drag {
  external Drag on(type, [listener]);
  external Drag origin([origin]);
}

/// Create a zoom behavior.
external Zoom zoom();

@JS()
class Zoom {
  /// Apply the zoom behavior to the selected elements.
  external zoom(selection);

  /// The current translate offset.
  external Zoom translate([translate]);

  /// The current scale factor.
  external Zoom scale([scale]);

  /// Optional limits on the scale factor.
  external Zoom scaleExtent([extent]);

  /// An optional focal point for mousewheel zooming.
  external Zoom center([center]);

  /// The dimensions of the viewport.
  external Zoom size([size]);

  /// An optional scale whose domain is bound to the x extent of the viewport.
  external Zoom x([x]);

  /// An optional scale whose domain is bound to the y extent of the viewport.
  external Zoom y([y]);

  /// Listeners for when the scale or translate changes.
  external Zoom on(type, listener);

  /// Dispatch zoom events after setting the scale or translate.
  external Zoom event(selection);

  /// Get or set the dblclick transition duration.
  external Zoom duration([duration]);
}
