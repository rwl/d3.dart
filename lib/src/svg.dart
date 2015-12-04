@JS('d3.svg')
library d3.src.svg;

import 'package:js/js.dart';

/// Create a new line generator.
external Line line();

@JS()
class Line {
  /// Generate a piecewise linear curve, as in a line chart.
  external line(data);

  /// Get or set the x-coordinate accessor.
  external x([x]);

  /// Get or set the y-coordinate accessor.
  external y([y]);

  /// Get or set the interpolation mode.
  external interpolate([interpolate]);

  /// Get or set the cardinal spline tension.
  external tension([tension]);

  /// Control whether the line is defined at a given point.
  external defined([defined]);
}

/// Create a new radial line generator.
@JS('line.radial')
external RadialLine radial();

@JS()
class RadialLine {
  /// Generate a piecewise linear curve, as in a polar line chart.
  external line(data);

  /// Get or set the radius accessor.
  external radius([radius]);

  /// Get or set the angle accessor.
  external angle([angle]);

  /// Get or set the interpolation mode.
  external interpolate([interpolate]);

  /// Get or set the cardinal spline tension.
  external tension([tension]);

  /// Control whether the line is defined at a given point.
  external defined([defined]);
}

/// Create a new area generator.
external Area area();

@JS()
class Area {
  /// Generate a piecewise linear area, as in an area chart.
  external area(data);

  /// Get or set the x-coordinate accessors.
  external x([x]);

  /// Get or set the x0-coordinate (baseline) accessor.
  external x0([x0]);

  /// Get or set the x1-coordinate (topline) accessor.
  external x1([x1]);

  /// Get or set the y-coordinate accessors.
  external y([y]);

  /// Get or set the y0-coordinate (baseline) accessor.
  external y0([y0]);

  /// Get or set the y1-coordinate (topline) accessor.
  external y1([y1]);

  /// Get or set the interpolation mode.
  external interpolate([interpolate]);

  /// Get or set the cardinal spline tension.
  external tension([tension]);

  /// Control whether the area is defined at a given point.
}

/// Create a new area generator.
@JS('area.radial')
external RadialArea radialArea();

class RadialArea {
  /// Generate a piecewise linear area, as in a polar area chart.
  external area();

  /// Get or set the radius accessors.
  external radius([radius]);

  /// Get or set the inner radius (baseline) accessor.
  external innerRadius([radius]);

  /// Get or set the outer radius (topline) accessor.
  external outerRadius([radius]);

  /// Get or set the angle accessors.
  external angle([angle]);

  /// Get or set the angle (baseline) accessor.
  external startAngle([angle]);

  /// Get or set the angle (topline) accessor.
  external endAngle([angle]);

  /// Control whether the area is defined at a given point.
  external defined([defined]);
}

/// Create a new arc generator.
external Arc arc();

@JS()
class Arc {
  /// Generate a solid arc, as in a pie or donut chart.
  external arc(datum, [index]);

  /// Get or set the inner radius accessor.
  external innerRadius([radius]);

  /// Get or set the outer radius accessor.
  external outerRadius([radius]);

  /// Get or set the corner radius accessor.
  external cornerRadius([radius]);

  /// Get or set the pad radius accessor.
  external padRadius([radius]);

  /// Get or set the start angle accessor.
  external startAngle([angle]);

  /// Get or set the end angle accessor.
  external endAngle([angle]);

  /// Get or set the pad angle accessor.
  external padAngle([angle]);

  /// Compute the arc centroid.
  external centroid([arguments]);
}

/// Create a new symbol generator.
external Symbol symbol();

@JS()
class Symbol {
  /// Generate categorical symbols, as in a scatterplot.
  external symbol(datum, [index]);

  /// Get or set the symbol type accessor.
  external type([type]);

  /// Get or set the symbol size (in square pixels) accessor.
  external size([size]);
}

/// The array of supported symbol types.
external List get symbolTypes;

/// Create a new chord generator.
external Chord chord();

@JS()
class Chord {
  /// Generate a quadratic Bézier connecting two arcs, as in a chord diagram.
  external chord(datum, [index]);

  /// Get or set the source arc accessor.
  external source([source]);

  /// Get or set the target arc accessor.
  external target([target]);

  /// Get or set the arc radius accessor.
  external radius([radius]);

  /// Get or set the arc start angle accessor.
  external startAngle([angle]);

  /// Get or set the arc end angle accessor.
  external endAngle([angle]);
}

/// Create a new diagonal generator.
external Diagonal diagonal();

@JS()
class Diagonal {
  /// Generate a two-dimensional Bézier connector, as in a node-link diagram.
  external diagonal(datum, [index]);

  /// Get or set the source point accessor.
  external source([source]);

  /// Get or set the target point accessor.
  external target([target]);

  /// Get or set an optional point transform.
  external projection([projection]);
}

@JS('diagonal.radial')
external radialDiagonal();

/// Create a new axis generator.
external Axis axis();

@JS()
class Axis {
  /// Creates or updates an axis for the given selection or transition.
  external axis(selection);

  /// Get or set the axis scale.
  external Axis scale([scale]);

  /// Get or set the axis orientation.
  external Axis orient([orientation]);

  /// Control how ticks are generated for the axis.
  external Axis ticks([arguments]);

  /// Specify tick values explicitly.
  external tickValues([values]);

  /// Specify the size of major, minor and end ticks.
  external Axis tickSize([inner, outer]);

  /// Specify the size of inner ticks.
  external innerTickSize([size]);

  /// Specify the size of outer ticks.
  external outerTickSize([size]);

  /// Specify padding between ticks and tick labels.
  external tickPadding([padding]);

  /// Override the tick formatting for labels.
  external tickFormat([format]);
}

/// Click and drag to select one- or two-dimensional regions.
external Brush brush();

@JS()
class Brush {
  /// Apply a brush to the given selection or transition.
  external brush(selection);

  /// The brush’s x-scale, for horizontal brushing.
  external x([scale]);

  /// The brush’s y-scale, for vertical brushing.
  external y([scale]);

  /// The brush’s extent in zero, one or two dimensions.
  external extent([values]);
  external clamp([clamp]);

  /// Reset the brush extent.
  external clear();

  /// Whether or not the brush extent is empty.
  external empty();

  /// Listeners for when the brush is moved.
  external on(type, [listener]);

  /// Dispatch brush events after setting the extent.
  external event(selection);
}
