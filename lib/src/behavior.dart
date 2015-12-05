library d3.src.behavior;

import 'dart:js';

JsObject _behavior = context['d3']['behavior'];

Drag drag() {
  return _behavior.callMethod('drag', []);
}

class Drag {
  final JsObject _proxy;

  Drag._(this._proxy);

  Drag on(type, [listener]) {
    return _proxy.callMethod('on', []);
  }

  Drag origin([origin]) {
    return _proxy.callMethod('origin', []);
  }
}

/// Create a zoom behavior.
Zoom zoom() {
  return _behavior.callMethod('zoom', []);
}

class Zoom {
  final JsObject _proxy;

  Zoom._(this._proxy);

  call(selection) => zoom(selection);

  /// Apply the zoom behavior to the selected elements.
  zoom(selection) {
    return _proxy.callMethod('zoom', []);
  }

  /// The current translate offset.
  Zoom translate([translate]) {
    return _proxy.callMethod('translate', []);
  }

  /// The current scale factor.
  Zoom scale([scale]) {
    return _proxy.callMethod('scale', []);
  }

  /// Optional limits on the scale factor.
  Zoom scaleExtent([extent]) {
    return _proxy.callMethod('scaleExtent', []);
  }

  /// An optional focal point for mousewheel zooming.
  Zoom center([center]) {
    return _proxy.callMethod('center', []);
  }

  /// The dimensions of the viewport.
  Zoom size([size]) {
    return _proxy.callMethod('size', []);
  }

  /// An optional scale whose domain is bound to the x extent of the viewport.
  Zoom x([x]) {
    return _proxy.callMethod('x', []);
  }

  /// An optional scale whose domain is bound to the y extent of the viewport.
  Zoom y([y]) {
    return _proxy.callMethod('y', []);
  }

  /// Listeners for when the scale or translate changes.
  Zoom on(type, listener) {
    return _proxy.callMethod('on', []);
  }

  /// Dispatch zoom events after setting the scale or translate.
  Zoom event(selection) {
    return _proxy.callMethod('event', []);
  }

  /// Get or set the dblclick transition duration.
  Zoom duration([duration]) {
    return _proxy.callMethod('duration', []);
  }
}
