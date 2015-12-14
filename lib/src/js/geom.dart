library d3.src.js.geom;

import 'dart:js';
import 'd3.dart';

JsObject _geom = context['d3']['geom'];

/// Create a Voronoi layout with default accessors.
Voronoi voronoi() => new Voronoi._(_geom.callMethod('voronoi'));

class Voronoi {
  final JsObject _proxy;

  Voronoi._(this._proxy);

  factory Voronoi() => voronoi();

  /// Compute the Voronoi tessellation for the specified points.
  List call(List data) =>
      _proxy.callMethod('call', [_proxy, new JsObject.jsify(data)]);

  /// Get or set the x-coordinate accessor for each point.
  x([Function x = undefinedFn]) {
    var args = [];
    if (x != undefinedFn) {
      args.add(x);
    }
    var retval = _proxy.callMethod('x', args);
    if (x == undefinedFn) {
      return retval;
    } else {
      return new Voronoi._(retval);
    }
  }

  /// Get or set the y-coordinate accessor for each point.
  y([Function y = undefinedFn]) {
    var args = [];
    if (y != undefinedFn) {
      args.add(y);
    }
    var retval = _proxy.callMethod('y', args);
    if (y == undefinedFn) {
      return retval;
    } else {
      return new Voronoi._(retval);
    }
  }

  /// Get or set the clip extent for the tesselation.
  clipExtent([List extent = undefinedList]) {
    var args = [];
    if (extent != undefinedList) {
      args.add(new JsObject.jsify(extent));
    }
    var retval = _proxy.callMethod('clipExtent', args);
    if (extent == undefinedList) {
      return retval;
    } else {
      return new Voronoi._(retval);
    }
  }

  /// Compute the Delaunay mesh as a network of links.
  List links(List data) =>
      _proxy.callMethod('links', [new JsObject.jsify(data)]);

  /// Compute the Delaunay mesh as a triangular tessellation.
  List triangles(List data) =>
      _proxy.callMethod('triangles', [new JsObject.jsify(data)]);
}

Quadtree quadtree() {
  return new Quadtree._(_geom.callMethod('quadtree'));
}

class Quadtree {
  final JsObject _proxy;

  Quadtree._(this._proxy);

  factory Quadtree() => quadtree();

  /// Constructs a quadtree for an array of points.
  Root call(List points,
      [num x2_x1 = undefinedNum,
      num y2_y1 = undefinedNum,
      num x2 = undefinedNum,
      num y2 = undefinedNum]) {
    var args = [_proxy, new JsObject.jsify(points)];
    if (x2_x1 != undefinedNum) {
      args.add(x2_x1);
    }
    if (y2_y1 != undefinedNum) {
      args.add(y2_y1);
    }
    if (x2 != undefinedNum) {
      args.add(x2);
    }
    if (y2 != undefinedNum) {
      args.add(y2);
    }
    return new Root._(_proxy.callMethod('call', args));
  }

  x([Function x = undefinedFn]) {
    var args = [];
    if (x != undefinedFn) {
      args.add(x);
    }
    var retval = _proxy.callMethod('x', args);
    if (x == undefinedFn) {
      return retval;
    } else {
      return new Quadtree._(retval);
    }
  }

  y([Function y = undefinedFn]) {
    var args = [];
    if (y != undefinedFn) {
      args.add(y);
    }
    var retval = _proxy.callMethod('y', args);
    if (y == undefinedFn) {
      return retval;
    } else {
      return new Quadtree._(retval);
    }
  }

  extent([List extent = undefinedList]) {
    var args = [];
    if (extent != undefinedList) {
      args.add(new JsObject.jsify(extent));
    }
    var retval = _proxy.callMethod('extent', args);
    if (extent == undefinedList) {
      return retval;
    } else {
      return new Quadtree._(retval);
    }
  }
}

class Root {
  final JsObject _proxy;

  Root._(this._proxy);

  /// Add a point to the quadtree.
  add(List point) =>
      new Root._(_proxy.callMethod('add', [new JsObject.jsify(point)]));

  /// Recursively visit nodes in the quadtree.
  visit(callback(node, x1, y1, x2, y2)) {
    return new Root._(_proxy.callMethod('visit', [callback]));
  }

  /// Find the closest point in the quadtree.
  List find(List point) =>
      _proxy.callMethod('find', [new JsObject.jsify(point)]);
}

/// Create a polygon from the specified array of points.
Polygon polygon(List vertices) {
  return new Polygon._(
      _geom.callMethod('polygon', [new JsObject.jsify(vertices)]));
}

class Polygon {
  final JsObject _proxy;

  Polygon._(this._proxy);

  factory Polygon(List vertices) => polygon(vertices);

  /// Compute the counterclockwise area of this polygon.
  num area() => _proxy.callMethod('area');

  /// Compute the area centroid of this polygon.
  List centroid() => _proxy.callMethod('centroid');

  /// Clip the specified polygon to this polygon.
  clip(Polygon subject) {
    return new Polygon._(_proxy.callMethod('clip', [subject]));
  }
}

/// Create a convex hull layout with default accessors.
Hull hull() => new Hull._(_geom.callMethod('hull'));

class Hull {
  final JsObject _proxy;

  Hull._(this._proxy);

  factory Hull() => hull();

  /// Compute the convex hull for the given array of points.
  call(List vertices) =>
      _proxy.callMethod('call', [_proxy, new JsObject.jsify(vertices)]);

  /// Get or set the x-coordinate accessor.
  x([Function x = undefinedFn]) {
    var args = [];
    if (x != undefinedFn) {
      args.add(x);
    }
    var retval = _proxy.callMethod('x', args);
    if (x == undefinedFn) {
      return retval;
    } else {
      return new Hull._(retval);
    }
  }

  /// Get or set the y-coordinate accessor.
  y([Function y = undefinedFn]) {
    var args = [];
    if (y != undefinedFn) {
      args.add(y);
    }
    var retval = _proxy.callMethod('y', args);
    if (y == undefinedFn) {
      return retval;
    } else {
      return new Hull._(retval);
    }
  }
}
