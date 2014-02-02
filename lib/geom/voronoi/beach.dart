part of d3.geom.voronoi;

class Beach {
  var edge, site, circle;
  Beach() {
    voronoiRedBlackNode(this);
    this.edge =
        this.site =
            this.circle = null;
  }
}

voronoiCreateBeach(site) {
  var beach = voronoiBeachPool.pop() || new Beach();
  beach.site = site;
  return beach;
}

voronoiDetachBeach(beach) {
  voronoiDetachCircle(beach);
  voronoiBeaches.remove(beach);
  voronoiBeachPool.push(beach);
  voronoiRedBlackNode(beach);
}

voronoiRemoveBeach(beach) {
  var circle = beach.circle,
      x = circle.x,
      y = circle.cy,
      vertex = {x: x, y: y},
      previous = beach.P,
      next = beach.N,
      disappearing = [beach];

  voronoiDetachBeach(beach);

  var lArc = previous;
  while (lArc.circle
      && (x - lArc.circle.x).abs() < epsilon
      && (y - lArc.circle.cy).abs() < epsilon) {
    previous = lArc.P;
    disappearing.unshift(lArc);
    voronoiDetachBeach(lArc);
    lArc = previous;
  }

  disappearing.unshift(lArc);
  voronoiDetachCircle(lArc);

  var rArc = next;
  while (rArc.circle
      && (x - rArc.circle.x).abs() < epsilon
      && (y - rArc.circle.cy).abs() < epsilon) {
    next = rArc.N;
    disappearing.push(rArc);
    voronoiDetachBeach(rArc);
    rArc = next;
  }

  disappearing.add(rArc);
  voronoiDetachCircle(rArc);

  var nArcs = disappearing.length,
      iArc;
  for (iArc = 1; iArc < nArcs; ++iArc) {
    rArc = disappearing[iArc];
    lArc = disappearing[iArc - 1];
    voronoiSetEdgeEnd(rArc.edge, lArc.site, rArc.site, vertex);
  }

  lArc = disappearing[0];
  rArc = disappearing[nArcs - 1];
  rArc.edge = voronoiCreateEdge(lArc.site, rArc.site, null, vertex);

  voronoiAttachCircle(lArc);
  voronoiAttachCircle(rArc);
}

voronoiAddBeach(site) {
  var x = site.x,
      directrix = site.y,
      lArc,
      rArc,
      dxl,
      dxr,
      node = voronoiBeaches._;

  while (node) {
    dxl = voronoiLeftBreakPoint(node, directrix) - x;
    if (dxl > epsilon) node = node.L; else {
      dxr = x - voronoiRightBreakPoint(node, directrix);
      if (dxr > epsilon) {
        if (!node.R) {
          lArc = node;
          break;
        }
        node = node.R;
      } else {
        if (dxl > -epsilon) {
          lArc = node.P;
          rArc = node;
        } else if (dxr > -epsilon) {
          lArc = node;
          rArc = node.N;
        } else {
          lArc = rArc = node;
        }
        break;
      }
    }
  }

  var newArc = voronoiCreateBeach(site);
  voronoiBeaches.insert(lArc, newArc);

  if (!lArc && !rArc) return;

  if (lArc == rArc) {
    voronoiDetachCircle(lArc);
    rArc = voronoiCreateBeach(lArc.site);
    voronoiBeaches.insert(newArc, rArc);
    newArc.edge = rArc.edge = voronoiCreateEdge(lArc.site, newArc.site);
    voronoiAttachCircle(lArc);
    voronoiAttachCircle(rArc);
    return;
  }

  if (!rArc) { // && lArc
    newArc.edge = voronoiCreateEdge(lArc.site, newArc.site);
    return;
  }

  // else lArc !== rArc
  voronoiDetachCircle(lArc);
  voronoiDetachCircle(rArc);

  var lSite = lArc.site,
      ax = lSite.x,
      ay = lSite.y,
      bx = site.x - ax,
      by = site.y - ay,
      rSite = rArc.site,
      cx = rSite.x - ax,
      cy = rSite.y - ay,
      d = 2 * (bx * cy - by * cx),
      hb = bx * bx + by * by,
      hc = cx * cx + cy * cy,
      vertex = {x: (cy * hb - by * hc) / d + ax, y: (bx * hc - cx * hb) / d + ay};

  voronoiSetEdgeEnd(rArc.edge, lSite, rSite, vertex);
  newArc.edge = voronoiCreateEdge(lSite, site, null, vertex);
  rArc.edge = voronoiCreateEdge(site, rSite, null, vertex);
  voronoiAttachCircle(lArc);
  voronoiAttachCircle(rArc);
}

voronoiLeftBreakPoint(arc, directrix) {
  var site = arc.site,
      rfocx = site.x,
      rfocy = site.y,
      pby2 = rfocy - directrix;

  if (!pby2) return rfocx;

  var lArc = arc.P;
  if (!lArc) return double.NEGATIVE_INFINITY;

  site = lArc.site;
  var lfocx = site.x,
      lfocy = site.y,
      plby2 = lfocy - directrix;

  if (!plby2) return lfocx;

  var hl = lfocx - rfocx,
      aby2 = 1 / pby2 - 1 / plby2,
      b = hl / plby2;

  if (aby2) return (-b + math.sqrt(b * b - 2 * aby2 * (hl * hl / (-2 * plby2) - lfocy + plby2 / 2 + rfocy - pby2 / 2))) / aby2 + rfocx;

  return (rfocx + lfocx) / 2;
}

voronoiRightBreakPoint(arc, directrix) {
  var rArc = arc.N;
  if (rArc) return voronoiLeftBreakPoint(rArc, directrix);
  var site = arc.site;
  return site.y == directrix ? site.x : double.INFINITY;
}
