library d3;

export 'src/array.dart' hide quantile;
export 'src/behavior.dart';
export 'src/color.dart';
export 'src/formatting.dart';
export 'src/geo.dart' hide transform, area, interpolate;
export 'src/geom.dart';
export 'src/internal.dart';
export 'src/layout.dart' hide Chord, chord;
export 'src/locale.dart';
export 'src/math.dart';
export 'src/namespace.dart';
export 'src/scale.dart';
export 'src/selection.dart';
export 'src/svg.dart';
export 'src/time.dart' hide format;
export 'src/transition.dart';
export 'src/xhr.dart';

class Margin {
  final num top, right, bottom, left;
  Margin({this.top: 0, this.right: 0, this.bottom: 0, this.left: 0});
}
