part of d3.geom.voronoi;

voronoiClipEdges(extent) {
  var edges = voronoiEdges,
      clip = clipLine(extent[0][0], extent[0][1], extent[1][0], extent[1][1]),
      i = edges.length,
      e;
  while (i--) {
    e = edges[i];
    if (!voronoiConnectEdge(e, extent)
        || !clip(e)
        || ((e.a.x - e.b.x).abs() < epsilon && (e.a.y - e.b.y).abs() < epsilon)) {
      e.a = e.b = null;
      edges.splice(i, 1);
    }
  }
}

voronoiConnectEdge(edge, extent) {
  var vb = edge.b;
  if (vb) return true;

  var va = edge.a,
      x0 = extent[0][0],
      x1 = extent[1][0],
      y0 = extent[0][1],
      y1 = extent[1][1],
      lSite = edge.l,
      rSite = edge.r,
      lx = lSite.x,
      ly = lSite.y,
      rx = rSite.x,
      ry = rSite.y,
      fx = (lx + rx) / 2,
      fy = (ly + ry) / 2,
      fm,
      fb;

  if (ry == ly) {
    if (fx < x0 || fx >= x1) return null;
    if (lx > rx) {
      if (!va) va = {'x': fx, 'y': y0};
      else if (va.y >= y1) return null;
      vb = {'x': fx, 'y': y1};
    } else {
      if (!va) va = {'x': fx, 'y': y1};
      else if (va.y < y0) return null;
      vb = {'x': fx, 'y': y0};
    }
  } else {
    fm = (lx - rx) / (ry - ly);
    fb = fy - fm * fx;
    if (fm < -1 || fm > 1) {
      if (lx > rx) {
        if (!va) va = {'x': (y0 - fb) / fm, 'y': y0};
        else if (va.y >= y1) return null;
        vb = {'x': (y1 - fb) / fm, 'y': y1};
      } else {
        if (!va) va = {'x': (y1 - fb) / fm, 'y': y1};
        else if (va.y < y0) return null;
        vb = {'x': (y0 - fb) / fm, 'y': y0};
      }
    } else {
      if (ly < ry) {
        if (!va) va = {'x': x0, 'y': fm * x0 + fb};
        else if (va.x >= x1) return null;
        vb = {'x': x1, 'y': fm * x1 + fb};
      } else {
        if (!va) va = {'x': x1, 'y': fm * x1 + fb};
        else if (va.x < x0) return null;
        vb = {'x': x0, 'y': fm * x0 + fb};
      }
    }
  }

  edge.a = va;
  edge.b = vb;
  return true;
}
