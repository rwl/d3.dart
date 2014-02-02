part of d3.geom.voronoi;

class Cell {
  var site, edges;

  Cell(site) {
    this.site = site;
    this.edges = [];
  }

  prepare() {
    var halfEdges = this.edges,
        iHalfEdge = halfEdges.length,
        edge;

    while (iHalfEdge--) {
      edge = halfEdges[iHalfEdge].edge;
      if (!edge.b || !edge.a) halfEdges.splice(iHalfEdge, 1);
    }

    halfEdges.sort(voronoiHalfEdgeOrder);
    return halfEdges.length;
  }
}

voronoiCloseCells(extent) {
  var x0 = extent[0][0],
      x1 = extent[1][0],
      y0 = extent[0][1],
      y1 = extent[1][1],
      x2,
      y2,
      x3,
      y3,
      cells = voronoiCells,
      iCell = cells.length,
      cell,
      iHalfEdge,
      halfEdges,
      nHalfEdges,
      start,
      end;

  while (iCell--) {
    cell = cells[iCell];
    if (!cell || !cell.prepare()) continue;
    halfEdges = cell.edges;
    nHalfEdges = halfEdges.length;
    iHalfEdge = 0;
    while (iHalfEdge < nHalfEdges) {
      end = halfEdges[iHalfEdge].end(); x3 = end.x; y3 = end.y;
      start = halfEdges[++iHalfEdge % nHalfEdges].start(); x2 = start.x; y2 = start.y;
      if ((x3 - x2).abs() > epsilon || (y3 - y2).abs() > epsilon) {
        halfEdges.splice(iHalfEdge, 0, new voronoiHalfEdge(voronoiCreateBorderEdge(cell.site, end,
            (x3 - x0).abs() < epsilon && y1 - y3 > epsilon ? {'x': x0, 'y': (x2 - x0).abs() < epsilon ? y2 : y1}
            : (y3 - y1).abs() < epsilon && x1 - x3 > epsilon ? {'x': (y2 - y1).abs() < epsilon ? x2 : x1, y: y1}
            : (x3 - x1).abs() < epsilon && y3 - y0 > epsilon ? {'x': x1, 'y': (x2 - x1).abs() < epsilon ? y2 : y0}
            : (y3 - y0).abs() < epsilon && x3 - x0 > epsilon ? {'x': (y2 - y0).abs() < epsilon ? x2 : x0, y: y0}
            : null), cell.site, null));
        ++nHalfEdges;
      }
    }
  }
}

voronoiHalfEdgeOrder(a, b) {
  return b.angle - a.angle;
}
