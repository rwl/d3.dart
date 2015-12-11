library d3.src.svg;

import 'dart:html' show Element;
import 'dart:async';
import 'js/svg.dart' as svg;
import 'scale.dart';
import 'selection.dart';
import 'transition.dart';

class Axis {
  final svg.Axis js;
  Axis() : js = svg.axis();

  /// Creates or updates an axis for the given selection or transition.
  void call(selection) {
    if (selection is Selection) {
      js.call(selection.js);
    } else if (selection is Transition) {
      js.call(selection.js);
    } else {
      js.call(selection);
    }
  }

  /// Get or set the axis scale.
  void set scale(Scale scale) {
    js.scale(scale.js);
  }

  /// Get or set the axis orientation.
  void set orient(String orientation) {
    js.orient(orientation);
  }

  /// Control how ticks are generated for the axis.
  void ticks(num count, [String format]) {
    if (format == null) {
      js.ticks(count);
    } else {
      js.ticks(count, format);
    }
  }

  /// Specify the size of inner ticks.
  void set tickSize(num size) {
    js.tickSize(size);
  }
}

/// Create a new diagonal generator.
class Diagonal {
  final svg.Diagonal js;

  Diagonal() : js = svg.diagonal();

  /// Generate a two-dimensional Bézier connector, as in a node-link diagram.
  String call(dynamic datum, [int index]) {
    if (index != null) {
      return js.call(datum, index);
    } else {
      return js.call(datum);
    }
  }

  /// Get or set an optional point transform.
  void set projectionFn(SelectionFn projection) {
    js.projection(projection);
  }
}

/// Click and drag to select one- or two-dimensional regions.
class Brush {
  final svg.Brush js;

  Brush() : js = svg.brush();

  /// Apply a brush to the given selection or transition.
  void call(selection) {
    if (selection is Selection) {
      js.call(selection.js);
    } else if (selection is Transition) {
      js.call(selection.js);
    } else {
      js.call(selection);
    }
  }

  /// The brush's x-scale, for horizontal brushing.
  void set x(Scale scale) {
    js.x(scale.js);
  }

  /// The brush's y-scale, for vertical brushing.
  void set y(Scale scale) {
    js.y(scale.js);
  }

  /// Listen for when the brush is moved.
  Stream<Selected> get onBrushStart {
    var ctrl = new StreamController<Selected>(onCancel: () {
      js.on('brushstart', null);
    }, sync: true);
    js.on('brushstart', (Element elem, data, int i) {
      ctrl.add(new Selected(elem, data, i));
    });
    return ctrl.stream;
  }

  /// Listen for when the brush is moved.
  Stream<Selected> get onBrush {
    var ctrl = new StreamController<Selected>(onCancel: () {
      js.on('brush', null);
    }, sync: true);
    js.on('brush', (Element elem, data, int i) {
      ctrl.add(new Selected(elem, data, i));
    });
    return ctrl.stream;
  }

  /// Listen for when the brush is moved.
  Stream<Selected> get onBrushEnd {
    var ctrl = new StreamController<Selected>(onCancel: () {
      js.on('brushend', null);
    }, sync: true);
    js.on('brushend', (Element elem, data, int i) {
      ctrl.add(new Selected(elem, data, i));
    });
    return ctrl.stream;
  }
}
