library d3.src.behavior;

import 'dart:html' show Element;
import 'dart:async';

import 'js/behavior.dart' as behavior;
import 'scale.dart';
import 'selection.dart';
import 'transition.dart';

class Drag {
  final behavior.Drag js;

  Drag() : js = behavior.drag();

  /// Apply the drag behavior to the selected elements.
  void call(selection) {
    if (selection is Selection) {
      js.call(selection.js);
    } else if (selection is Transition) {
      js.call(selection.js);
    } else {
      js.call(selection);
    }
  }

  Stream<Selected> get onDragStart {
    var ctrl = new StreamController<Selected>(onCancel: () {
      js.on('dragstart', null);
    }, sync: true);
    js.on('dragstart', (Element elem, data, int i) {
      ctrl.add(new Selected(elem, data, i));
    });
    return ctrl.stream;
  }

  Stream<Selected> get onDrag {
    var ctrl = new StreamController<Selected>(onCancel: () {
      js.on('drag', null);
    }, sync: true);
    js.on('drag', (Element elem, data, int i) {
      ctrl.add(new Selected(elem, data, i));
    });
    return ctrl.stream;
  }

  Stream<Selected> get onDragEnd {
    var ctrl = new StreamController<Selected>(onCancel: () {
      js.on('dragend', null);
    }, sync: true);
    js.on('dragstart', (Element elem, data, int i) {
      ctrl.add(new Selected(elem, data, i));
    });
    return ctrl.stream;
  }
}

class Zoom {
  final behavior.Zoom js;

  Zoom() : js = behavior.zoom();

  /// Apply the zoom behavior to the selected elements.
  void call(selection) {
    if (selection is Selection) {
      js.call(selection.js);
    } else if (selection is Transition) {
      js.call(selection.js);
    } else {
      js.call(selection);
    }
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
  void event(selection) {
    if (selection is Selection) {
      js.event(selection.js);
    } else if (selection is Transition) {
      js.event(selection.js);
    } else {
      js.event(selection);
    }
  }

  Stream<Selected> get onZoomStart {
    var ctrl = new StreamController<Selected>(onCancel: () {
      js.on('zoomstart', null);
    }, sync: true);
    js.on('zoomstart', (Element elem, data, int i) {
      ctrl.add(new Selected(elem, data, i));
    });
    return ctrl.stream;
  }

  Stream<Selected> get onZoom {
    var ctrl = new StreamController<Selected>(onCancel: () {
      js.on('zoom', null);
    }, sync: true);
    js.on('zoom', (Element elem, data, int i) {
      ctrl.add(new Selected(elem, data, i));
    });
    return ctrl.stream;
  }

  Stream<Selected> get onZoomEnd {
    var ctrl = new StreamController<Selected>(onCancel: () {
      js.on('zoomend', null);
    }, sync: true);
    js.on('zoomend', (Element elem, data, int i) {
      ctrl.add(new Selected(elem, data, i));
    });
    return ctrl.stream;
  }
}
