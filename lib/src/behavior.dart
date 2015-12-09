library d3.src.behavior;

import 'dart:html';
import 'dart:async';

import 'js/behavior.dart' as behavior;
import 'scale.dart';
import 'selection.dart';

class Zoom {
  final behavior.Zoom js;

  final StreamController<Selected> _zoomCtrl = new StreamController.broadcast();

  Zoom() : js = behavior.zoom() {
    js.on('zoom', (Element elem, d, int i) {
      _zoomCtrl.add(new Selected(elem, d, i));
    });
  }

  /// Apply the zoom behavior to the selected elements.
  void call(AbstractSelection selection) {
    js.call(selection.js);
  }

  /// An optional scale whose domain is bound to the x extent of the viewport.
  void set x(Scale scale) {
    js.x(scale.js);
  }

  /// An optional scale whose domain is bound to the y extent of the viewport.
  void set y(Scale scale) {
    js.y(scale.js);
  }

  /// Optional limits on the scale factor.
  void set scaleExtent(List<num> extent) {
    js.scaleExtent(extent);
  }

  /// The dimensions of the viewport.
  void set size(List<num> size) {
    js.size(size);
  }

  /// Set the current scale factor.
  void set scale(num scale) {
    js.scale(scale);
  }

  /// The current scale factor.
  num get scale => js.scale();

  /// Set the translate offset.
  void set translate(List translate) {
    js.translate(translate);
  }

  /// The current translate offset.
  List<num> get translate => js.translate();

  /// An optional focal point for mousewheel zooming.
  void set center(List center) {
    js.center(center);
  }

  List get center => js.center();

  /// Dispatch zoom events after setting the scale or translate.
  void event(AbstractSelection selection) {
    js.event(selection.js);
  }

  Stream<Selected> get onZoom => _zoomCtrl.stream;
}
