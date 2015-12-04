@JS('d3.geom')
library d3.src.geom;

import 'package:js/js.dart';

/// create a Voronoi layout with default accessors.
external Voronoi voronoi();

@JS()
class Voronoi {
  /// compute the Voronoi tessellation for the specified points.
  external voronoi(data);

  /// get or set the x-coordinate accessor for each point.
  external x([x]);

  /// get or set the y-coordinate accessor for each point.
  external y([y]);

  /// get or set the clip extent for the tesselation.
  external clipExtent([extent]);

  /// compute the Delaunay mesh as a network of links.
  external links(data);

  /// compute the Delaunay mesh as a triangular tessellation.
  external triangles(data);
}

external Quadtree quadtree();

@JS()
class Quadtree {
  /// constructs a quadtree for an array of points.
  external Root quadtree(points, [x1, y1, x2, y2]);
  external x([x]);
  external y([y]);
  external extent([extent]);
}

@JS()
class Root {
  /// add a point to the quadtree.
  external add(point);

  /// recursively visit nodes in the quadtree.
  external visit(callback);

  /// find the closest point in the quadtree.
  external find(point);
}

/// create a polygon from the specified array of points.
external Polygon polygon(vertices);

@JS()
class Polygon {
  /// compute the counterclockwise area of this polygon.
  external area();

  /// compute the area centroid of this polygon.
  external centroid();

  /// clip the specified polygon to this polygon.
  external clip(subject);
}

/// create a convex hull layout with default accessors.
external Hull hull();

@JS()
class Hull {
  /// compute the convex hull for the given array of points.
  external hull(vertices);

  /// get or set the x-coordinate accessor.
  external x([x]);

  /// get or set the y-coordinate accessor.
  external y([y]);
}
