@JS('d3.svg')
library d3.src.svg;

import 'package:js/js.dart';

/// create a new line generator.
external Line line();

@JS()
class Line {
  /// generate a piecewise linear curve, as in a line chart.
  external line(data);

  /// get or set the x-coordinate accessor.
  external x([x]);

  /// get or set the y-coordinate accessor.
  external y([y]);

  /// get or set the interpolation mode.
  external interpolate([interpolate]);

  /// get or set the cardinal spline tension.
  external tension([tension]);

  /// control whether the line is defined at a given point.
  external defined([defined]);
}

/// create a new radial line generator.
@JS('line.radial')
external RadialLine radial();

@JS()
class RadialLine {
  /// generate a piecewise linear curve, as in a polar line chart.
  external line(data);

  /// get or set the radius accessor.
  external radius([radius]);

  /// get or set the angle accessor.
  external angle([angle]);

  /// get or set the interpolation mode.
  external interpolate([interpolate]);

  /// get or set the cardinal spline tension.
  external tension([tension]);

  /// control whether the line is defined at a given point.
  external defined([defined]);
}

/// create a new area generator.
external Area area();

@JS()
class Area {
  /// generate a piecewise linear area, as in an area chart.
  external area(data);

  /// get or set the x-coordinate accessors.
  external x([x]);

  /// get or set the x0-coordinate (baseline) accessor.
  external x0([x0]);

  /// get or set the x1-coordinate (topline) accessor.
  external x1([x1]);

  /// get or set the y-coordinate accessors.
  external y([y]);

  /// get or set the y0-coordinate (baseline) accessor.
  external y0([y0]);

  /// get or set the y1-coordinate (topline) accessor.
  external y1([y1]);

  /// get or set the interpolation mode.
  external interpolate([interpolate]);

  /// get or set the cardinal spline tension.
  external tension([tension]);

  /// control whether the area is defined at a given point.
}

/// create a new area generator.
@JS('area.radial')
external RadialArea radialArea();

class RadialArea {
  /// generate a piecewise linear area, as in a polar area chart.
  external area();

  /// get or set the radius accessors.
  external radius([radius]);

  /// get or set the inner radius (baseline) accessor.
  external innerRadius([radius]);

  /// get or set the outer radius (topline) accessor.
  external outerRadius([radius]);

  /// get or set the angle accessors.
  external angle([angle]);

  /// get or set the angle (baseline) accessor.
  external startAngle([angle]);

  /// get or set the angle (topline) accessor.
  external endAngle([angle]);

  /// control whether the area is defined at a given point.
  external defined([defined]);
}

/// create a new arc generator.
external Arc arc();

@JS()
class Arc {
  /// generate a solid arc, as in a pie or donut chart.
  external arc(datum, [index]);

  /// get or set the inner radius accessor.
  external innerRadius([radius]);

  /// get or set the outer radius accessor.
  external outerRadius([radius]);

  /// get or set the corner radius accessor.
  external cornerRadius([radius]);

  /// get or set the pad radius accessor.
  external padRadius([radius]);

  /// get or set the start angle accessor.
  external startAngle([angle]);

  /// get or set the end angle accessor.
  external endAngle([angle]);

  /// get or set the pad angle accessor.
  external padAngle([angle]);

  /// compute the arc centroid.
  external centroid([arguments]);
}

/// create a new symbol generator.
external Symbol symbol();

@JS()
class Symbol {
  /// generate categorical symbols, as in a scatterplot.
  external symbol(datum, [index]);

  /// get or set the symbol type accessor.
  external type([type]);

  /// get or set the symbol size (in square pixels) accessor.
  external size([size]);
}

/// the array of supported symbol types.
external List get symbolTypes;

/// create a new chord generator.
external Chord chord();

@JS()
class Chord {
  /// generate a quadratic Bézier connecting two arcs, as in a chord diagram.
  external chord(datum, [index]);

  /// get or set the source arc accessor.
  external source([source]);

  /// get or set the target arc accessor.
  external target([target]);

  /// get or set the arc radius accessor.
  external radius([radius]);

  /// get or set the arc start angle accessor.
  external startAngle([angle]);

  /// get or set the arc end angle accessor.
  external endAngle([angle]);
}

/// create a new diagonal generator.
external Diagonal diagonal();

@JS()
class Diagonal {
  /// generate a two-dimensional Bézier connector, as in a node-link diagram.
  external diagonal(datum, [index]);

  /// get or set the source point accessor.
  external source([source]);

  /// get or set the target point accessor.
  external target([target]);

  /// get or set an optional point transform.
  external projection([projection]);
}

@JS('diagonal.radial')
external radialDiagonal();

/// create a new axis generator.
external Axis axis();

@JS()
class Axis {
  /// creates or updates an axis for the given selection or transition.
  external axis(selection);

  /// get or set the axis scale.
  external Axis scale([scale]);

  /// get or set the axis orientation.
  external Axis orient([orientation]);

  /// control how ticks are generated for the axis.
  external Axis ticks([arguments]);

  /// specify tick values explicitly.
  external tickValues([values]);

  /// specify the size of major, minor and end ticks.
  external Axis tickSize([inner, outer]);

  /// specify the size of inner ticks.
  external innerTickSize([size]);

  /// specify the size of outer ticks.
  external outerTickSize([size]);

  /// specify padding between ticks and tick labels.
  external tickPadding([padding]);

  /// override the tick formatting for labels.
  external tickFormat([format]);
}

/// click and drag to select one- or two-dimensional regions.
external Brush brush();

@JS()
class Brush {
  /// apply a brush to the given selection or transition.
  external brush(selection);

  /// the brush’s x-scale, for horizontal brushing.
  external x([scale]);

  /// the brush’s y-scale, for vertical brushing.
  external y([scale]);

  /// the brush’s extent in zero, one or two dimensions.
  external extent([values]);
  external clamp([clamp]);

  /// reset the brush extent.
  external clear();

  /// whether or not the brush extent is empty.
  external empty();

  /// listeners for when the brush is moved.
  external on(type, [listener]);

  /// dispatch brush events after setting the extent.
  external event(selection);
}
