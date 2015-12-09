library d3.src.svg;

import 'js/svg.dart' as svg;
import 'scale.dart';
import 'selection.dart';

class Axis {
  final svg.Axis js;
  Axis() : js = svg.axis();

  /// Creates or updates an axis for the given selection or transition.
  void call(AbstractSelection selection) {
    js.call(selection.js);
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
}
