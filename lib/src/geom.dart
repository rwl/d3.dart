@JS('d3.geom')
library d3.src.geom;

import 'package:js/js.dart';

/// Create a Voronoi layout with default accessors.
external Voronoi voronoi();

@JS()
class Voronoi {
  /// Compute the Voronoi tessellation for the specified points.
  external voronoi(data);

  /// Get or set the x-coordinate accessor for each point.
  external x([x]);

  /// Get or set the y-coordinate accessor for each point.
  external y([y]);

  /// Get or set the clip extent for the tesselation.
  external clipExtent([extent]);

  /// Compute the Delaunay mesh as a network of links.
  external links(data);

  /// Compute the Delaunay mesh as a triangular tessellation.
  external triangles(data);
}

external Quadtree quadtree();

@JS()
class Quadtree {
  /// Constructs a quadtree for an array of points.
  external Root quadtree(points, [x1, y1, x2, y2]);
  external x([x]);
  external y([y]);
  external extent([extent]);
}

@JS()
class Root {
  /// Add a point to the quadtree.
  external add(point);

  /// Recursively visit nodes in the quadtree.
  external visit(callback);

  /// Find the closest point in the quadtree.
  external find(point);
}

/// Create a polygon from the specified array of points.
external Polygon polygon(vertices);

@JS()
class Polygon {
  /// Compute the counterclockwise area of this polygon.
  external area();

  /// Compute the area centroid of this polygon.
  external centroid();

  /// Clip the specified polygon to this polygon.
  external clip(subject);
}

/// Create a convex hull layout with default accessors.
external Hull hull();

@JS()
class Hull {
  /// Compute the convex hull for the given array of points.
  external hull(vertices);

  /// Get or set the x-coordinate accessor.
  external x([x]);

  /// Get or set the y-coordinate accessor.
  external y([y]);
}
