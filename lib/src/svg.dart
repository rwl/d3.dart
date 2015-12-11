library d3.src.svg;

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
