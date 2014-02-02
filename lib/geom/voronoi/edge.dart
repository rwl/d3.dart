part of d3.geom.voronoi;

class Edge {
  var l, r, a, b;
  Edge(lSite, rSite) {
    this.l = lSite;
    this.r = rSite;
    this.a = this.b = null; // for border edges
  }
}

voronoiCreateEdge(lSite, rSite, va, vb) {
  var edge = new Edge(lSite, rSite);
  voronoiEdges.add(edge);
  if (va) voronoiSetEdgeEnd(edge, lSite, rSite, va);
  if (vb) voronoiSetEdgeEnd(edge, rSite, lSite, vb);
  voronoiCells[lSite.i].edges.add(new HalfEdge(edge, lSite, rSite));
  voronoiCells[rSite.i].edges.add(new HalfEdge(edge, rSite, lSite));
  return edge;
}

voronoiCreateBorderEdge(lSite, va, vb) {
  var edge = new Edge(lSite, null);
  edge.a = va;
  edge.b = vb;
  voronoiEdges.add(edge);
  return edge;
}

voronoiSetEdgeEnd(edge, lSite, rSite, vertex) {
  if (!edge.a && !edge.b) {
    edge.a = vertex;
    edge.l = lSite;
    edge.r = rSite;
  } else if (edge.l == rSite) {
    edge.b = vertex;
  } else {
    edge.a = vertex;
  }
}

class HalfEdge {
  var edge, site, angle;
  HalfEdge(edge, lSite, rSite) {
    var va = edge.a,
        vb = edge.b;
    this.edge = edge;
    this.site = lSite;
    this.angle = rSite ? math.atan2(rSite.y - lSite.y, rSite.x - lSite.x)
        : edge.l == lSite ? math.atan2(vb.x - va.x, va.y - vb.y)
        : math.atan2(va.x - vb.x, vb.y - va.y);
  }

  start() {
    return this.edge.l == this.site ? this.edge.a : this.edge.b;
  }

  end() {
    return this.edge.l == this.site ? this.edge.b : this.edge.a;
  }
}
