library d3.src.svg;

import 'dart:js';

JsObject _svg = context['d3']['svg'];

/// Create a new line generator.
Line line() {
  return _svg.callMethod('line', []);
}

class Line {
  final JsObject _proxy;

  Line._(this._proxy);

  call(data) => line(data);

  /// Generate a piecewise linear curve, as in a line chart.
  line(data) {
    return _proxy.callMethod('line', []);
  }

  /// Get or set the x-coordinate accessor.
  x([x]) {
    return _proxy.callMethod('x', []);
  }

  /// Get or set the y-coordinate accessor.
  y([y]) {
    return _proxy.callMethod('y', []);
  }

  /// Get or set the interpolation mode.
  interpolate([interpolate]) {
    return _proxy.callMethod('interpolate', []);
  }

  /// Get or set the cardinal spline tension.
  tension([tension]) {
    return _proxy.callMethod('tension', []);
  }

  /// Control whether the line is defined at a given point.
  defined([defined]) {
    return _proxy.callMethod('defined', []);
  }
}

/// Create a new radial line generator.
RadialLine radial() {
  return _svg['line'].callMethod('radial', []);
}

class RadialLine {
  final JsObject _proxy;

  RadialLine._(this._proxy);

  call(data) => line(data);

  /// Generate a piecewise linear curve, as in a polar line chart.
  line(data) {
    return _proxy.callMethod('line', []);
  }

  /// Get or set the radius accessor.
  radius([radius]) {
    return _proxy.callMethod('radius', []);
  }

  /// Get or set the angle accessor.
  angle([angle]) {
    return _proxy.callMethod('angle', []);
  }

  /// Get or set the interpolation mode.
  interpolate([interpolate]) {
    return _proxy.callMethod('interpolate', []);
  }

  /// Get or set the cardinal spline tension.
  tension([tension]) {
    return _proxy.callMethod('tension', []);
  }

  /// Control whether the line is defined at a given point.
  defined([defined]) {
    return _proxy.callMethod('defined', []);
  }
}

/// Create a new area generator.
Area area() {
  return _svg.callMethod('area', []);
}

class Area {
  final JsObject _proxy;

  Area._(this._proxy);

  call(data) => area(data);

  /// Generate a piecewise linear area, as in an area chart.
  area(data) {
    return _proxy.callMethod('area', []);
  }

  /// Get or set the x-coordinate accessors.
  x([x]) {
    return _proxy.callMethod('x', []);
  }

  /// Get or set the x0-coordinate (baseline) accessor.
  x0([x0]) {
    return _proxy.callMethod('x0', []);
  }

  /// Get or set the x1-coordinate (topline) accessor.
  x1([x1]) {
    return _proxy.callMethod('x1', []);
  }

  /// Get or set the y-coordinate accessors.
  y([y]) {
    return _proxy.callMethod('y', []);
  }

  /// Get or set the y0-coordinate (baseline) accessor.
  y0([y0]) {
    return _proxy.callMethod('y0', []);
  }

  /// Get or set the y1-coordinate (topline) accessor.
  y1([y1]) {
    return _proxy.callMethod('y1', []);
  }

  /// Get or set the interpolation mode.
  interpolate([interpolate]) {
    return _proxy.callMethod('interpolate', []);
  }

  /// Get or set the cardinal spline tension.
  tension([tension]) {
    return _proxy.callMethod('tension', []);
  }

  /// Control whether the area is defined at a given point.
}

/// Create a new area generator.
RadialArea radialArea() {
  return _svg['area'].callMethod('radial', []);
}

class RadialArea {
  final JsObject _proxy;

  RadialArea._(this._proxy);

  call() => area();

  /// Generate a piecewise linear area, as in a polar area chart.
  area() {
    return _proxy.callMethod('area', []);
  }

  /// Get or set the radius accessors.
  radius([radius]) {
    return _proxy.callMethod('radius', []);
  }

  /// Get or set the inner radius (baseline) accessor.
  innerRadius([radius]) {
    return _proxy.callMethod('innerRadius', []);
  }

  /// Get or set the outer radius (topline) accessor.
  outerRadius([radius]) {
    return _proxy.callMethod('outerRadius', []);
  }

  /// Get or set the angle accessors.
  angle([angle]) {
    return _proxy.callMethod('angle', []);
  }

  /// Get or set the angle (baseline) accessor.
  startAngle([angle]) {
    return _proxy.callMethod('startAngle', []);
  }

  /// Get or set the angle (topline) accessor.
  endAngle([angle]) {
    return _proxy.callMethod('endAngle', []);
  }

  /// Control whether the area is defined at a given point.
  defined([defined]) {
    return _proxy.callMethod('defined', []);
  }
}

/// Create a new arc generator.
Arc arc() {
  return _svg.callMethod('arc', []);
}

class Arc {
  final JsObject _proxy;

  Arc._(this._proxy);

  call(datum, [index]) => arc(datum, [index]);

  /// Generate a solid arc, as in a pie or donut chart.
  arc(datum, [index]) {
    return _proxy.callMethod('arc', []);
  }

  /// Get or set the inner radius accessor.
  innerRadius([radius]) {
    return _proxy.callMethod('innerRadius', []);
  }

  /// Get or set the outer radius accessor.
  outerRadius([radius]) {
    return _proxy.callMethod('outerRadius', []);
  }

  /// Get or set the corner radius accessor.
  cornerRadius([radius]) {
    return _proxy.callMethod('cornerRadius', []);
  }

  /// Get or set the pad radius accessor.
  padRadius([radius]) {
    return _proxy.callMethod('padRadius', []);
  }

  /// Get or set the start angle accessor.
  startAngle([angle]) {
    return _proxy.callMethod('startAngle', []);
  }

  /// Get or set the end angle accessor.
  endAngle([angle]) {
    return _proxy.callMethod('endAngle', []);
  }

  /// Get or set the pad angle accessor.
  padAngle([angle]) {
    return _proxy.callMethod('padAngle', []);
  }

  /// Compute the arc centroid.
  centroid([arguments]) {
    return _proxy.callMethod('centroid', []);
  }
}

/// Create a new symbol generator.
Symbol symbol() {
  return _svg.callMethod('symbol', []);
}

class Symbol {
  final JsObject _proxy;

  Symbol._(this._proxy);

  call(datum, [index]) => symbol(datum, [index]);

  /// Generate categorical symbols, as in a scatterplot.
  symbol(datum, [index]) {
    return _proxy.callMethod('symbol', []);
  }

  /// Get or set the symbol type accessor.
  type([type]) {
    return _proxy.callMethod('type', []);
  }

  /// Get or set the symbol size (in square pixels) accessor.
  size([size]) {
    return _proxy.callMethod('size', []);
  }
}

/// The array of supported symbol types.
List get symbolTypes {
  return _svg['symbolTypes'];
}

/// Create a new chord generator.
Chord chord() {
  return _svg.callMethod('chord', []);
}

class Chord {
  final JsObject _proxy;

  Chord._(this._proxy);

  call(datum, [index]) => chord(datum, [index]);

  /// Generate a quadratic Bézier connecting two arcs, as in a chord diagram.
  chord(datum, [index]) {
    return _proxy.callMethod('chord', []);
  }

  /// Get or set the source arc accessor.
  source([source]) {
    return _proxy.callMethod('source', []);
  }

  /// Get or set the target arc accessor.
  target([target]) {
    return _proxy.callMethod('target', []);
  }

  /// Get or set the arc radius accessor.
  radius([radius]) {
    return _proxy.callMethod('radius', []);
  }

  /// Get or set the arc start angle accessor.
  startAngle([angle]) {
    return _proxy.callMethod('startAngle', []);
  }

  /// Get or set the arc end angle accessor.
  endAngle([angle]) {
    return _proxy.callMethod('endAngle', []);
  }
}

/// Create a new diagonal generator.
Diagonal diagonal() {
  return _svg.callMethod('diagonal', []);
}

class Diagonal {
  final JsObject _proxy;

  Diagonal._(this._proxy);

  call(datum, [index]) => diagonal(datum, [index]);

  /// Generate a two-dimensional Bézier connector, as in a node-link diagram.
  diagonal(datum, [index]) {
    return _proxy.callMethod('diagonal', []);
  }

  /// Get or set the source point accessor.
  source([source]) {
    return _proxy.callMethod('source', []);
  }

  /// Get or set the target point accessor.
  target([target]) {
    return _proxy.callMethod('target', []);
  }

  /// Get or set an optional point transform.
  projection([projection]) {
    return _proxy.callMethod('projection', []);
  }
}

radialDiagonal() {
  return _svg['diagonal'].callMethod('radial', []);
}

/// Create a new axis generator.
Axis axis() {
  return _svg.callMethod('axis', []);
}

class Axis {
  final JsObject _proxy;

  Axis._(this._proxy);

  call(selection) => axis(selection);

  /// Creates or updates an axis for the given selection or transition.
  axis(selection) {
    return _proxy.callMethod('axis', []);
  }

  /// Get or set the axis scale.
  Axis scale([scale]) {
    return _proxy.callMethod('scale', []);
  }

  /// Get or set the axis orientation.
  Axis orient([orientation]) {
    return _proxy.callMethod('orient', []);
  }

  /// Control how ticks are generated for the axis.
  Axis ticks([arguments]) {
    return _proxy.callMethod('ticks', []);
  }

  /// Specify tick values explicitly.
  tickValues([values]) {
    return _proxy.callMethod('tickValues', []);
  }

  /// Specify the size of major, minor and end ticks.
  Axis tickSize([inner, outer]) {
    return _proxy.callMethod('tickSize', []);
  }

  /// Specify the size of inner ticks.
  innerTickSize([size]) {
    return _proxy.callMethod('innerTickSize', []);
  }

  /// Specify the size of outer ticks.
  outerTickSize([size]) {
    return _proxy.callMethod('outerTickSize', []);
  }

  /// Specify padding between ticks and tick labels.
  tickPadding([padding]) {
    return _proxy.callMethod('tickPadding', []);
  }

  /// Override the tick formatting for labels.
  tickFormat([format]) {
    return _proxy.callMethod('tickFormat', []);
  }
}

/// Click and drag to select one- or two-dimensional regions.
Brush brush() {
  return _svg.callMethod('brush', []);
}

class Brush {
  final JsObject _proxy;

  Brush._(this._proxy);

  call(selection) => brush(selection);

  /// Apply a brush to the given selection or transition.
  brush(selection) {
    return _proxy.callMethod('brush', []);
  }

  /// The brush's x-scale, for horizontal brushing.
  x([scale]) {
    return _proxy.callMethod('x', []);
  }

  /// The brush's y-scale, for vertical brushing.
  y([scale]) {
    return _proxy.callMethod('y', []);
  }

  /// The brush's extent in zero, one or two dimensions.
  extent([values]) {
    return _proxy.callMethod('extent', []);
  }

  clamp([clamp]) {
    return _proxy.callMethod('clamp', []);
  }

  /// Reset the brush extent.
  clear() {
    return _proxy.callMethod('clear', []);
  }

  /// Whether or not the brush extent is empty.
  empty() {
    return _proxy.callMethod('empty', []);
  }

  /// Listeners for when the brush is moved.
  on(type, [listener]) {
    return _proxy.callMethod('on', []);
  }

  /// Dispatch brush events after setting the extent.
  event(selection) {
    return _proxy.callMethod('event', []);
  }
}
