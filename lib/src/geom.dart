library d3.src.geom;

import 'dart:js';

JsObject _d3 = context['d3'];
JsObject _geom = context['d3']['geom'];

/// Create a Voronoi layout with default accessors.
Voronoi voronoi() {
  return _geom.callMethod('voronoi', []);
}

class Voronoi {
  final JsObject _proxy;

  Voronoi._(this._proxy);

  call(data) => voronoi(data);

  /// Compute the Voronoi tessellation for the specified points.
  voronoi(data) {
    return _proxy.callMethod('voronoi', []);
  }

  /// Get or set the x-coordinate accessor for each point.
  x([x]) {
    return _proxy.callMethod('x', []);
  }

  /// Get or set the y-coordinate accessor for each point.
  y([y]) {
    return _proxy.callMethod('y', []);
  }

  /// Get or set the clip extent for the tesselation.
  clipExtent([extent]) {
    return _proxy.callMethod('clipExtent', []);
  }

  /// Compute the Delaunay mesh as a network of links.
  links(data) {
    return _proxy.callMethod('links', []);
  }

  /// Compute the Delaunay mesh as a triangular tessellation.
  triangles(data) {
    return _proxy.callMethod('triangles', []);
  }
}

Quadtree quadtree() {
  return _geom.callMethod('quadtree', []);
}

class Quadtree {
  final JsObject _proxy;

  Quadtree._(this._proxy);

  call(points, [x1, y1, x2, y2]) => quadtree(points, [x1, y1, x2, y2]);

  /// Constructs a quadtree for an array of points.
  Root quadtree(points, [x1, y1, x2, y2]) {
    return _proxy.callMethod('quadtree', []);
  }

  x([x]) {
    return _proxy.callMethod('x', []);
  }

  y([y]) {
    return _proxy.callMethod('y', []);
  }

  extent([extent]) {
    return _proxy.callMethod('extent', []);
  }
}

class Root {
  final JsObject _proxy;

  Root._(this._proxy);

  /// Add a point to the quadtree.
  add(point) {
    return _proxy.callMethod('add', []);
  }

  /// Recursively visit nodes in the quadtree.
  visit(callback) {
    return _proxy.callMethod('visit', []);
  }

  /// Find the closest point in the quadtree.
  find(point) {
    return _proxy.callMethod('find', []);
  }
}

/// Create a polygon from the specified array of points.
Polygon polygon(vertices) {
  return _geom.callMethod('polygon', []);
}

class Polygon {
  final JsObject _proxy;

  Polygon._(this._proxy);

  /// Compute the counterclockwise area of this polygon.
  area() {
    return _proxy.callMethod('area', []);
  }

  /// Compute the area centroid of this polygon.
  centroid() {
    return _proxy.callMethod('centroid', []);
  }

  /// Clip the specified polygon to this polygon.
  clip(subject) {
    return _proxy.callMethod('clip', []);
  }
}

/// Create a convex hull layout with default accessors.
Hull hull() {
  return _geom.callMethod('hull', []);
}

class Hull {
  final JsObject _proxy;

  Hull._(this._proxy);

  /// Compute the convex hull for the given array of points.
  hull(vertices) {
    return _proxy.callMethod('hull', []);
  }

  /// Get or set the x-coordinate accessor.
  x([x]) {
    return _proxy.callMethod('x', []);
  }

  /// Get or set the y-coordinate accessor.
  y([y]) {
    return _proxy.callMethod('y', []);
  }
}
