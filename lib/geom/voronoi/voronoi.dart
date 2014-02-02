library d3.geom.voronoi;

part 'beach.dart';
part 'cell.dart';
part 'circle.dart';
part 'clip.dart';
part 'edge.dart';
part 'red_black.dart';

var voronoiEdges,
    voronoiCells,
    voronoiBeaches,
    voronoiBeachPool = [],
    voronoiFirstCircle,
    voronoiCircles,
    voronoiCirclePool = [];

voronoi(sites, bbox) {
  var site = sites.sort(voronoiVertexOrder).pop(),
      x0,
      y0,
      circle;

  voronoiEdges = [];
  voronoiCells = new List(sites.length);
  voronoiBeaches = new voronoiRedBlackTree;
  voronoiCircles = new voronoiRedBlackTree;

  while (true) {
    circle = voronoiFirstCircle;
    if (site && (!circle || site.y < circle.y || (site.y == circle.y && site.x < circle.x))) {
      if (site.x != x0 || site.y != y0) {
        voronoiCells[site.i] = new voronoiCell(site);
        voronoiAddBeach(site);
        x0 = site.x; y0 = site.y;
      }
      site = sites.pop();
    } else if (circle) {
      voronoiRemoveBeach(circle.arc);
    } else {
      break;
    }
  }

  if (bbox) {
    voronoiClipEdges(bbox);
    voronoiCloseCells(bbox);
  }

  var diagram = {'cells': voronoiCells, 'edges': voronoiEdges};

  voronoiBeaches =
  voronoiCircles =
  voronoiEdges =
  voronoiCells = null;

  return diagram;
}

voronoiVertexOrder(a, b) {
  return b.y - a.y || b.x - a.x;
}
