@JS('d3.geom')
library d3.src.geom;

import 'package:js/js.dart';

external Voronoi voronoi();

@JS()
class Voronoi {
  external voronoi(data);
  external x([x]);
  external y([y]);
  external clipExtent([extent]);
  external links(data);
  external triangles(data);
}

external Quadtree quadtree();

@JS()
class Quadtree {
  external Root quadtree(points, [x1, y1, x2, y2]);
  external x([x]);
  external y([y]);
  external extent([extent]);
}

@JS()
class Root {
  external add(point);
  external visit(callback);
  external find(point);
}

external Polygon polygon(vertices);

@JS()
class Polygon {
  external area();
  external centroid();
  external clip(subject);
}

external Hull hull();

@JS()
class Hull {
  external hull(vertices);
  external x([x]);
  external y([y]);
}
