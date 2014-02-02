part of d3.geom;

class Voronoi {
  var x = (d) { return d[0]; };
  var y = (d) { return d[1]; };
  var fx = x,
      fy = y,
      clipExtent = voronoiClipExtent;

  voronoi(data) {
    var polygons = new List(data.length),
        x0 = clipExtent[0][0],
        y0 = clipExtent[0][1],
        x1 = clipExtent[1][0],
        y1 = clipExtent[1][1];

    voronoi(sites(data), clipExtent).cells.forEach((cell, i) {
      var edges = cell.edges,
          site = cell.site,
          polygon = polygons[i] = edges.length ? edges.map((e) { var s = e.start(); return [s.x, s.y]; })
              : site.x >= x0 && site.x <= x1 && site.y >= y0 && site.y <= y1 ? [[x0, y1], [x1, y1], [x1, y0], [x0, y0]]
              : [];
      polygon.point = data[i];
    });

    return polygons;
  }

  static sites(data) {
    return data.map((d, i) {
      return {
        'x': math.round(fx(d, i) / epsilon) * epsilon,
        'y': math.round(fy(d, i) / epsilon) * epsilon,
        'i': i
      };
    });
  }

  links(data) {
    return voronoi(sites(data)).edges.filter((edge) {
      return edge.l && edge.r;
    }).map((edge) {
      return {
        'source': data[edge.l.i],
        'target': data[edge.r.i]
      };
    });
  }

  triangles(data) {
    var triangles = [];

    voronoi(sites(data)).cells.forEach((cell, i) {
      var site = cell.site,
          edges = cell.edges.sort(voronoiHalfEdgeOrder),
          j = -1,
          m = edges.length,
          e0,
          s0,
          e1 = edges[m - 1].edge,
          s1 = e1.l == site ? e1.r : e1.l;

      while (++j < m) {
        e0 = e1;
        s0 = s1;
        e1 = edges[j].edge;
        s1 = e1.l == site ? e1.r : e1.l;
        if (i < s0.i && i < s1.i && voronoiTriangleArea(site, s0, s1) < 0) {
          triangles.add([data[i], data[s0.i], data[s1.i]]);
        }
      }
    });

    return triangles;
  }

  clipExtent([arg=unique]) {
    if (arg == unique) {
      return clipExtent == voronoiClipExtent ? null : clipExtent;
    }
    clipExtent = arg == null ? voronoiClipExtent : arg;
    return this;
  }
}

final voronoiClipExtent = [[-1e6, -1e6], [1e6, 1e6]];

num voronoiTriangleArea(a, b, c) {
  return (a.x - c.x) * (b.y - a.y) - (a.x - b.x) * (c.y - a.y);
}
