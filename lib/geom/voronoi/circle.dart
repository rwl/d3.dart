part of d3.geom.voronoi;

class Circle {
  var x, y, arc, site, cy;

  Circle() {
    voronoiRedBlackNode(this);
    this.x =
    this.y =
    this.arc =
    this.site =
    this.cy = null;
  }
}

voronoiAttachCircle(arc) {
  var lArc = arc.P,
      rArc = arc.N;

  if (!lArc || !rArc) return;

  var lSite = lArc.site,
      cSite = arc.site,
      rSite = rArc.site;

  if (lSite == rSite) return;

  var bx = cSite.x,
      by = cSite.y,
      ax = lSite.x - bx,
      ay = lSite.y - by,
      cx = rSite.x - bx,
      cy = rSite.y - by;

  var d = 2 * (ax * cy - ay * cx);
  if (d >= -epsilon2) return;

  var ha = ax * ax + ay * ay,
      hc = cx * cx + cy * cy,
      x = (cy * ha - ay * hc) / d,
      y = (ax * hc - cx * ha) / d,
      cy = y + by;

  var circle = voronoiCirclePool.pop() || new Circle();
  circle.arc = arc;
  circle.site = cSite;
  circle.x = x + bx;
  circle.y = cy + math.sqrt(x * x + y * y); // y bottom
  circle.cy = cy;

  arc.circle = circle;

  var before = null,
      node = voronoiCircles._;

  while (node) {
    if (circle.y < node.y || (circle.y == node.y && circle.x <= node.x)) {
      if (node.L) node = node.L;
      else { before = node.P; break; }
    } else {
      if (node.R) node = node.R;
      else { before = node; break; }
    }
  }

  voronoiCircles.insert(before, circle);
  if (!before) voronoiFirstCircle = circle;
}

voronoiDetachCircle(arc) {
  var circle = arc.circle;
  if (circle) {
    if (!circle.P) voronoiFirstCircle = circle.N;
    voronoiCircles.remove(circle);
    voronoiCirclePool.add(circle);
    voronoiRedBlackNode(circle);
    arc.circle = null;
  }
}
