/// D3 is a library for manipulating documents based on data. D3 helps you
/// bring data to life using HTML, SVG and CSS.
///
/// A strongly typed interface to the `d3.js.*` libraries for idiomatic Dart.
library d3;

export 'src/selection.dart';
export 'src/scale.dart';
export 'src/svg.dart';
export 'src/xhr.dart';

class Margin {
  final num top, right, bottom, left;
  Margin({this.top: 0, this.right: 0, this.bottom: 0, this.left: 0});
}
