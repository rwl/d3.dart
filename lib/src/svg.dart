library d3.src.svg;

import 'dart:js';
import 'd3.dart';

import 'selection.dart' as sel;
import 'transition.dart' as trans;
import 'scale.dart' as sc;

JsObject _svg = context['d3']['svg'];

/// Create a new line generator.
Line line() => new Line._(_svg.callMethod('line'));

class Line {
  final JsObject _proxy;

  Line._(this._proxy);

  /// Generate a piecewise linear curve, as in a line chart.
  String call(List data) => _proxy.callMethod('call', [_proxy, data]);

  /// Get or set the x-coordinate accessor.
  x([x = undefined]) {
    var args = [];
    if (x is Function) {
      args.add(func4VarArgs(x));
    } else if (x != undefined) {
      args.add(x);
    }
    var retval = _proxy.callMethod('x', args);
    if (x == undefined) {
      return retval;
    } else {
      return new Line._(retval);
    }
  }

  /// Get or set the y-coordinate accessor.
  y([y = undefined]) {
    var args = [];
    if (y is Function) {
      args.add(func4VarArgs(y));
    } else if (y != undefined) {
      args.add(y);
    }
    var retval = _proxy.callMethod('y', args);
    if (y == undefined) {
      return retval;
    } else {
      return new Line._(retval);
    }
  }

  /// Get or set the interpolation mode.
  interpolate([interpolate = undefined]) {
    var args = [];
    if (interpolate != undefined) {
      args.add(interpolate);
    }
    var retval = _proxy.callMethod('interpolate', args);
    if (interpolate == undefined) {
      return retval;
    } else {
      return new Line._(retval);
    }
  }

  /// Get or set the cardinal spline tension.
  tension([num tension = undefinedNum]) {
    var args = [];
    if (tension != undefinedNum) {
      args.add(tension);
    }
    var retval = _proxy.callMethod('tension', args);
    if (tension == undefinedNum) {
      return retval;
    } else {
      return new Line._(retval);
    }
  }

  /// Control whether the line is defined at a given point.
  defined([Function defined = undefinedFn]) {
    var args = [];
    if (defined != undefinedFn) {
      args.add(defined);
    }
    var retval = _proxy.callMethod('defined', args);
    if (defined == undefinedFn) {
      return retval;
    } else {
      return new Line._(retval);
    }
  }
}

/// Create a new radial line generator.
RadialLine radial() => new RadialLine._(_svg['line'].callMethod('radial'));

class RadialLine {
  final JsObject _proxy;

  RadialLine._(this._proxy);

  /// Generate a piecewise linear curve, as in a polar line chart.
  String call(List data) => _proxy.callMethod('call', [_proxy, data]);

  /// Get or set the radius accessor.
  radius([radius = undefined]) {
    var args = [];
    if (radius != undefined) {
      args.add(radius);
    }
    var retval = _proxy.callMethod('radius', args);
    if (radius == undefined) {
      return retval;
    } else {
      return new RadialLine._(retval);
    }
  }

  /// Get or set the angle accessor.
  angle([angle = undefined]) {
    var args = [];
    if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('angle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new RadialLine._(retval);
    }
  }

  /// Get or set the interpolation mode.
  interpolate([interpolate = undefined]) {
    var args = [];
    if (interpolate != undefined) {
      args.add(interpolate);
    }
    var retval = _proxy.callMethod('interpolate', args);
    if (interpolate == undefined) {
      return retval;
    } else {
      return new RadialLine._(retval);
    }
  }

  /// Get or set the cardinal spline tension.
  tension([num tension = undefinedNum]) {
    var args = [];
    if (tension != undefinedNum) {
      args.add(tension);
    }
    var retval = _proxy.callMethod('tension', args);
    if (tension == undefinedNum) {
      return retval;
    } else {
      return new RadialLine._(retval);
    }
  }

  /// Control whether the line is defined at a given point.
  defined([defined = undefined]) {
    var args = [];
    if (defined != undefined) {
      args.add(defined);
    }
    var retval = _proxy.callMethod('defined', args);
    if (defined == undefined) {
      return retval;
    } else {
      return new RadialLine._(retval);
    }
  }
}

/// Create a new area generator.
Area area() => new Area._(_svg.callMethod('area'));

class Area {
  final JsObject _proxy;

  Area._(this._proxy);

  /// Generate a piecewise linear area, as in an area chart.
  String call(List data) => _proxy.callMethod('area', [_proxy, data]);

  /// Get or set the x-coordinate accessors.
  x([x = undefined]) {
    var args = [];
    if (x is Function) {
      args.add(func4VarArgs(x));
    } else if (x != undefined) {
      args.add(x);
    }
    var retval = _proxy.callMethod('x', args);
    if (x == undefined) {
      return retval;
    } else {
      return new Area._(retval);
    }
  }

  /// Get or set the x0-coordinate (baseline) accessor.
  x0([x0 = undefined]) {
    var args = [];
    if (x0 != undefined) {
      args.add(x0);
    }
    var retval = _proxy.callMethod('x0', args);
    if (x0 == undefined) {
      return retval;
    } else {
      return new Area._(retval);
    }
  }

  /// Get or set the x1-coordinate (topline) accessor.
  x1([x1 = undefined]) {
    var args = [];
    if (x1 != undefined) {
      args.add(x1);
    }
    var retval = _proxy.callMethod('x1', args);
    if (x1 == undefined) {
      return retval;
    } else {
      return new Area._(retval);
    }
  }

  /// Get or set the y-coordinate accessors.
  y([y = undefined]) {
    var args = [];
    if (y is Function) {
      args.add(func4VarArgs(y));
    } else if (y != undefined) {
      args.add(y);
    }
    var retval = _proxy.callMethod('y', args);
    if (y == undefined) {
      return retval;
    } else {
      return new Area._(retval);
    }
  }

  /// Get or set the y0-coordinate (baseline) accessor.
  y0([y0 = undefined]) {
    var args = [];
    if (y0 != undefined) {
      args.add(y0);
    }
    var retval = _proxy.callMethod('y0', args);
    if (y0 == undefined) {
      return retval;
    } else {
      return new Area._(retval);
    }
  }

  /// Get or set the y1-coordinate (topline) accessor.
  y1([y1 = undefined]) {
    var args = [];
    if (y1 != undefined) {
      args.add(y1);
    }
    var retval = _proxy.callMethod('y1', args);
    if (y1 == undefined) {
      return retval;
    } else {
      return new Area._(retval);
    }
  }

  /// Get or set the interpolation mode.
  interpolate([interpolate = undefined]) {
    var args = [];
    if (interpolate != undefined) {
      args.add(interpolate);
    }
    var retval = _proxy.callMethod('interpolate', args);
    if (interpolate == undefined) {
      return retval;
    } else {
      return new Area._(retval);
    }
  }

  /// Get or set the cardinal spline tension.
  tension([tension = undefined]) {
    var args = [];
    if (tension != undefined) {
      args.add(tension);
    }
    var retval = _proxy.callMethod('tension', args);
    if (tension == undefined) {
      return retval;
    } else {
      return new Area._(retval);
    }
  }

  /// Control whether the area is defined at a given point.
}

/// Create a new area generator.
RadialArea radialArea() => new RadialArea._(_svg['area'].callMethod('radial'));

class RadialArea {
  final JsObject _proxy;

  RadialArea._(this._proxy);

  /// Generate a piecewise linear area, as in a polar area chart.
  String call(data) => _proxy.callMethod('call', [_proxy, data]);

  /// Get or set the radius accessors.
  radius([radius = undefined]) {
    var args = [];
    if (radius != undefined) {
      args.add(radius);
    }
    var retval = _proxy.callMethod('radius', args);
    if (radius == undefined) {
      return retval;
    } else {
      return new RadialArea._(retval);
    }
  }

  /// Get or set the inner radius (baseline) accessor.
  innerRadius([radius = undefined]) {
    var args = [];
    if (radius != undefined) {
      args.add(radius);
    }
    var retval = _proxy.callMethod('innerRadius', args);
    if (radius == undefined) {
      return retval;
    } else {
      return new RadialArea._(retval);
    }
  }

  /// Get or set the outer radius (topline) accessor.
  outerRadius([radius = undefined]) {
    var args = [];
    if (radius != undefined) {
      args.add(radius);
    }
    var retval = _proxy.callMethod('outerRadius', args);
    if (radius == undefined) {
      return retval;
    } else {
      return new RadialArea._(retval);
    }
  }

  /// Get or set the angle accessors.
  angle([angle = undefined]) {
    var args = [];
    if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('angle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new RadialArea._(retval);
    }
  }

  /// Get or set the angle (baseline) accessor.
  startAngle([angle = undefined]) {
    var args = [];
    if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('startAngle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new RadialArea._(retval);
    }
  }

  /// Get or set the angle (topline) accessor.
  endAngle([angle = undefined]) {
    var args = [];
    if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('endAngle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new RadialArea._(retval);
    }
  }

  /// Control whether the area is defined at a given point.
  defined([Function defined = undefined]) {
    var args = [];
    if (defined != undefined) {
      args.add(defined);
    }
    var retval = _proxy.callMethod('defined', args);
    if (defined == undefined) {
      return retval;
    } else {
      return new RadialArea._(retval);
    }
  }
}

/// Create a new arc generator.
Arc arc() => new Arc._(_svg.callMethod('arc'));

class Arc {
  final JsObject _proxy;

  Arc._(this._proxy);

  /// Generate a solid arc, as in a pie or donut chart.
  String call(datum, [index = undefined]) {
    var args = [_proxy, datum];
    if (index != undefined) {
      args.add(index);
    }
    return _proxy.callMethod('call', args);
  }

  /// Get or set the inner radius accessor.
  innerRadius([radius = undefined]) {
    var args = [];
    if (radius is Function) {
      args.add(func4VarArgs(radius));
    } else if (radius != undefined) {
      args.add(radius);
    }
    var retval = _proxy.callMethod('innerRadius', args);
    if (radius == undefined) {
      return retval;
    } else {
      return new Arc._(retval);
    }
  }

  /// Get or set the outer radius accessor.
  outerRadius([radius = undefined]) {
    var args = [];
    if (radius is Function) {
      args.add(func4VarArgs(radius));
    } else if (radius != undefined) {
      args.add(radius);
    }
    var retval = _proxy.callMethod('outerRadius', args);
    if (radius == undefined) {
      return retval;
    } else {
      return new Arc._(retval);
    }
  }

  /// Get or set the corner radius accessor.
  cornerRadius([radius = undefined]) {
    var args = [];
    if (radius is Function) {
      args.add(func4VarArgs(radius));
    } else if (radius != undefined) {
      args.add(radius);
    }
    var retval = _proxy.callMethod('cornerRadius', args);
    if (radius == undefined) {
      return retval;
    } else {
      return new Arc._(retval);
    }
  }

  /// Get or set the pad radius accessor.
  padRadius([radius = undefined]) {
    var args = [];
    if (radius is Function) {
      args.add(func4VarArgs(radius));
    } else if (radius != undefined) {
      args.add(radius);
    }
    var retval = _proxy.callMethod('padRadius', args);
    if (radius == undefined) {
      return retval;
    } else {
      return new Arc._(retval);
    }
  }

  /// Get or set the start angle accessor.
  startAngle([angle = undefined]) {
    var args = [];
    if (angle is Function) {
      args.add(func4VarArgs(angle));
    } else if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('startAngle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new Arc._(retval);
    }
  }

  /// Get or set the end angle accessor.
  endAngle([angle = undefined]) {
    var args = [];
    if (angle is Function) {
      args.add(func4VarArgs(angle));
    } else if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('endAngle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new Arc._(retval);
    }
  }

  /// Get or set the pad angle accessor.
  padAngle([angle = undefined]) {
    var args = [];
    if (angle is Function) {
      args.add(func4VarArgs(angle));
    } else if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('padAngle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new Arc._(retval);
    }
  }

  /// Compute the arc centroid.
  String centroid([List arguments]) => _proxy.callMethod('centroid', arguments);
}

/// Create a new symbol generator.
Symbol symbol() => new Symbol._(_svg.callMethod('symbol'));

class Symbol {
  final JsObject _proxy;

  Symbol._(this._proxy);

  /// Generate categorical symbols, as in a scatterplot.
  call(datum, [index = undefined]) {
    var args = [_proxy, datum];
    if (index != undefined) {
      args.add(index);
    }
    return _proxy.callMethod('call', args);
  }

  /// Get or set the symbol type accessor.
  type([type = undefined]) {
    var args = [];
    if (type != undefined) {
      args.add(type);
    }
    var retval = _proxy.callMethod('type', args);
    if (type == undefined) {
      return retval;
    } else {
      return new Symbol._(retval);
    }
  }

  /// Get or set the symbol size (in square pixels) accessor.
  size([size = undefined]) {
    var args = [];
    if (size != undefined) {
      args.add(size);
    }
    var retval = _proxy.callMethod('size', args);
    if (size == undefined) {
      return retval;
    } else {
      return new Symbol._(retval);
    }
  }
}

/// The array of supported symbol types.
List get symbolTypes => _svg['symbolTypes'];

/// Create a new chord generator.
Chord chord() => new Chord._(_svg.callMethod('chord'));

class Chord {
  final JsObject _proxy;

  Chord._(this._proxy);

  /// Generate a quadratic Bézier connecting two arcs, as in a chord diagram.
  String call(datum, [index = undefined]) {
    var args = [_proxy, datum];
    if (index != undefined) {
      args.add(index);
    }
    return _proxy.callMethod('call', args);
  }

  /// Get or set the source arc accessor.
  source([source = undefined]) {
    var args = [];
    if (source is Function) {
      args.add(func4VarArgs(source));
    } else if (source != undefined) {
      args.add(source);
    }
    var retval = _proxy.callMethod('source', args);
    if (source == undefined) {
      return retval;
    } else {
      return new Chord._(retval);
    }
  }

  /// Get or set the target arc accessor.
  target([target = undefined]) {
    var args = [];
    if (target is Function) {
      args.add(func4VarArgs(target));
    } else if (target != undefined) {
      args.add(target);
    }
    var retval = _proxy.callMethod('target', args);
    if (target == undefined) {
      return retval;
    } else {
      return new Chord._(retval);
    }
  }

  /// Get or set the arc radius accessor.
  radius([radius = undefined]) {
    var args = [];
    if (radius is Function) {
      args.add(func4VarArgs(radius));
    } else if (radius != undefined) {
      args.add(radius);
    }
    var retval = _proxy.callMethod('radius', args);
    if (radius == undefined) {
      return retval;
    } else {
      return new Chord._(retval);
    }
  }

  /// Get or set the arc start angle accessor.
  startAngle([angle = undefined]) {
    var args = [];
    if (angle is Function) {
      args.add(func4VarArgs(angle));
    } else if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('startAngle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new Chord._(retval);
    }
  }

  /// Get or set the arc end angle accessor.
  endAngle([angle = undefined]) {
    var args = [];
    if (angle is Function) {
      args.add(func4VarArgs(angle));
    } else if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('endAngle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new Chord._(retval);
    }
  }
}

/// Create a new diagonal generator.
Diagonal diagonal() => new Diagonal._(_svg.callMethod('diagonal'));

class Diagonal {
  final JsObject _proxy;

  Diagonal._(this._proxy);

  /// Generate a two-dimensional Bézier connector, as in a node-link diagram.
  call(datum, [index = undefined]) {
    var args = [_proxy, datum];
    if (index != undefined) {
      args.add(index);
    }
    return _proxy.callMethod('call', args);
  }

  /// Get or set the source point accessor.
  source([source = undefined]) {
    var args = [];
    if (source is Function) {
      args.add(func4VarArgs(source));
    } else if (source != undefined) {
      args.add(source);
    }
    var retval = _proxy.callMethod('source', args);
    if (source == undefined) {
      return retval;
    } else {
      return new Diagonal._(retval);
    }
  }

  /// Get or set the target point accessor.
  target([target = undefined]) {
    var args = [];
    if (target is Function) {
      args.add(func4VarArgs(target));
    } else if (target != undefined) {
      args.add(target);
    }
    var retval = _proxy.callMethod('target', args);
    if (target == undefined) {
      return retval;
    } else {
      return new Diagonal._(retval);
    }
  }

  /// Get or set an optional point transform.
  projection([projection = undefined]) {
    var args = [];
    if (projection is Function) {
      args.add(func4VarArgs(projection));
    } else if (projection != undefined) {
      args.add(projection);
    }
    var retval = _proxy.callMethod('projection', args);
    if (projection == undefined) {
      return retval;
    } else {
      return new Diagonal._(retval);
    }
  }
}

radialDiagonal() => _svg['diagonal'].callMethod('radial');

/// Create a new axis generator.
Axis axis() => new Axis._(_svg.callMethod('axis'));

class Axis {
  final JsObject _proxy;

  Axis._(this._proxy);

  /// Creates or updates an axis for the given selection or transition.
  call(selection) {
    var args = [_proxy];
    if (selection is sel.Selection) {
      args.add(sel.getProxy(selection));
    } else if (selection is trans.Transition) {
      args.add(trans.getProxy(selection));
    } else if (selection is JsArray) {
      args.add(selection);
    } else {
      throw new ArgumentError.value(selection);
    }
    return _proxy.callMethod('call', args);
  }

  /// Get or set the axis scale.
  scale([scale = undefined]) {
    var args = [];
    if (scale != undefined) {
      args.add(sc.getProxy(scale));
    }
    var retval = _proxy.callMethod('scale', args);
    if (scale == undefined) {
      return retval; // TODO: wrap in Scale
    } else {
      return new Axis._(retval);
    }
  }

  /// Get or set the axis orientation.
  orient([String orientation = undefinedString]) {
    var args = [];
    if (orientation != undefinedString) {
      args.add(orientation);
    }
    var retval = _proxy.callMethod('orient', args);
    if (orientation == undefinedString) {
      return retval;
    } else {
      return new Axis._(retval);
    }
  }

  /// Control how ticks are generated for the axis.
  ticks([arg1 = undefined, arg2 = undefined, arg3 = undefined]) {
    var args = [];

    if (arg1 != undefined) {
      args.add(arg1);
    } else if (arg2 != undefined) {
      args.add(arg2);
    } else if (arg3 != undefined) {
      args.add(arg3);
    }

    var retval = _proxy.callMethod('ticks', args);
    if (arg1 == undefined) {
      return retval;
    } else {
      return new Axis._(retval);
    }
  }

  /// Specify tick values explicitly.
  tickValues([List values = undefinedList]) {
    var args = [];
    if (values != undefinedList) {
      args.add(values);
    }
    var retval = _proxy.callMethod('tickValues', args);
    if (values == undefinedList) {
      return retval;
    } else {
      return new Axis._(retval);
    }
  }

  /// Specify the size of major, minor and end ticks.
  tickSize([num inner = undefinedNum, num outer = undefinedNum]) {
    var args = [];
    if (inner != undefinedNum) {
      args.add(inner);
    }
    if (outer != undefinedNum) {
      args.add(outer);
    }
    var retval = _proxy.callMethod('tickSize', args);
    if (inner == undefinedNum) {
      return retval;
    } else {
      return new Axis._(retval);
    }
  }

  /// Specify the size of inner ticks.
  innerTickSize([num size = undefinedNum]) {
    var args = [];
    if (size != undefinedNum) {
      args.add(size);
    }
    var retval = _proxy.callMethod('innerTickSize', args);
    if (size == undefinedNum) {
      return retval;
    } else {
      return new Axis._(retval);
    }
  }

  /// Specify the size of outer ticks.
  outerTickSize([num size = undefinedNum]) {
    var args = [];
    if (size != undefinedNum) {
      args.add(size);
    }
    var retval = _proxy.callMethod('outerTickSize', args);
    if (size == undefinedNum) {
      return retval;
    } else {
      return new Axis._(retval);
    }
  }

  /// Specify padding between ticks and tick labels.
  tickPadding([num padding = undefinedNum]) {
    var args = [];
    if (padding != undefinedNum) {
      args.add(padding);
    }
    var retval = _proxy.callMethod('tickPadding', args);
    if (padding == undefinedNum) {
      return retval;
    } else {
      return new Axis._(retval);
    }
  }

  /// Override the tick formatting for labels.
  tickFormat([format = undefined]) {
    var args = [];
    if (format is Function) {
      args.add(func4VarArgs(format));
    } else if (format != undefined) {
      args.add(format);
    }
    var retval = _proxy.callMethod('tickFormat', args);
    if (format == undefined) {
      return retval;
    } else {
      return new Axis._(retval);
    }
  }
}

/// Click and drag to select one- or two-dimensional regions.
Brush brush() => new Brush._(_svg.callMethod('brush'));

class Brush {
  final JsObject _proxy;

  Brush._(this._proxy);

  /// Apply a brush to the given selection or transition.
  call(selection) {
    var args = [_proxy];
    if (selection is sel.Selection) {
      args.add(sel.getProxy(selection));
    } else if (selection is trans.Transition) {
      args.add(trans.getProxy(selection));
    } else if (selection is JsArray) {
      args.add(selection);
    } else {
      throw new ArgumentError.value(selection);
    }
    return _proxy.callMethod('call', args);
  }

  /// The brush's x-scale, for horizontal brushing.
  x([scale = undefined]) {
    var args = [];
    if (scale != undefined) {
      args.add(sc.getProxy(scale));
    }
    var retval = _proxy.callMethod('x', args);
    if (scale == undefined) {
      return retval; // TODO: wrap in Scale
    } else {
      return new Brush._(retval);
    }
  }

  /// The brush's y-scale, for vertical brushing.
  y([scale = undefined]) {
    var args = [];
    if (scale != undefined) {
      args.add(sc.getProxy(scale));
    }
    var retval = _proxy.callMethod('y', args);
    if (scale == undefined) {
      return retval; // TODO: wrap in Scale
    } else {
      return new Brush._(retval);
    }
  }

  /// The brush's extent in zero, one or two dimensions.
  extent([values = undefined]) {
    var args = [];
    if (values != undefined) {
      args.add(values);
    }
    var retval = _proxy.callMethod('extent', args);
    if (values == undefined) {
      return retval;
    } else {
      return new Brush._(retval);
    }
  }

  clamp([clamp = undefined]) {
    var args = [];
    if (clamp != undefined) {
      args.add(clamp);
    }
    var retval = _proxy.callMethod('clamp', args);
    if (clamp == undefined) {
      return retval;
    } else {
      return new Brush._(retval);
    }
  }

  /// Reset the brush extent.
  clear() => new Brush._(_proxy.callMethod('clear'));

  /// Whether or not the brush extent is empty.
  bool empty() => _proxy.callMethod('empty');

  /// Listeners for when the brush is moved.
  on(String type, [Function listener = undefinedFn]) {
    var args = [type];
    if (listener != undefinedFn) {
      args.add(listener);
    }
    return new Brush._(_proxy.callMethod('on', args));
  }

  /// Dispatch brush events after setting the extent.
  event(selection) {
    var args = [];
    if (selection is sel.Selection) {
      args.add(sel.getProxy(selection));
    } else if (selection is trans.Transition) {
      args.add(trans.getProxy(selection));
    } else if (selection is JsArray) {
      args.add(selection);
    } else {
      throw new ArgumentError.value(selection);
    }
    return new Brush._(_proxy.callMethod('event', args));
  }
}
