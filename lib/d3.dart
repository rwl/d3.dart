/// D3 is a library for manipulating documents based on data. D3 helps you
/// bring data to life using HTML, SVG and CSS.
library d3;

export 'src/array.dart' hide quantile;
export 'src/behavior.dart';
export 'src/color.dart' hide getProxy;
export 'src/formatting.dart';
export 'src/geo.dart' hide transform, area, interpolate;
export 'src/geom.dart';
export 'src/internal.dart';
export 'src/layout.dart' hide Chord, chord;
export 'src/locale.dart';
export 'src/math.dart' hide getProxy;
export 'src/namespace.dart';
export 'src/scale.dart' hide getProxy;
export 'src/selection.dart' hide getProxy;
export 'src/svg.dart';
export 'src/time.dart' hide format;
export 'src/transition.dart' hide newTransition, getProxy;
export 'src/xhr.dart';

class Margin {
  final num top, right, bottom, left;
  Margin({this.top: 0, this.right: 0, this.bottom: 0, this.left: 0});
}
