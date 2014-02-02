part of d3.geom;

class Polygon {
  List<List<int>> coordinates;

  Polygon(this.coordinates);

  get length => coordinates.length;

  operator [](i) {
    return coordinates[i];
  }

  num area() {
    var i = -1,
        n = this.length,
        a,
        b = this[n - 1],
        area = 0;

    while (++i < n) {
      a = b;
      b = this[i];
      area += a[1] * b[0] - a[0] * b[1];
    }

    return area * .5;
  }

  List<num> centroid([num k=null]) {
    var i = -1,
        n = this.length,
        x = 0,
        y = 0,
        a,
        b = this[n - 1],
        c;

    if (k != null) {
      k = -1 / (6 * this.area());
    }

    while (++i < n) {
      a = b;
      b = this[i];
      c = a[0] * b[1] - b[0] * a[1];
      x += (a[0] + b[0]) * c;
      y += (a[1] + b[1]) * c;
    }

    return [x * k, y * k];
  }


  // The Sutherland-Hodgman clipping algorithm.
  // Note: requires the clip polygon to be counterclockwise and convex.
  clip(subject) {
    var input,
        closed = polygonClosed(subject),
        i = -1,
        n = this.length - polygonClosed(this.coordinates),
        j,
        m,
        a = this[n - 1],
        b,
        c,
        d;

    while (++i < n) {
      input = subject.slice();
      subject.length = 0;
      b = this[i];
      c = input[(m = input.length - closed) - 1];
      j = -1;
      while (++j < m) {
        d = input[j];
        if (polygonInside(d, a, b)) {
          if (!polygonInside(c, a, b)) {
            subject.push(polygonIntersect(c, d, a, b));
          }
          subject.push(d);
        } else if (polygonInside(c, a, b)) {
          subject.push(polygonIntersect(c, d, a, b));
        }
        c = d;
      }
      if (closed) subject.push(subject[0]);
      a = b;
    }

    return subject;
  }
}

bool polygonInside(List<int> p, List<int> a, List<int> b) {
  return (b[0] - a[0]) * (p[1] - a[1]) < (b[1] - a[1]) * (p[0] - a[0]);
}

// Intersect two infinite lines cd and ab.
List<int> polygonIntersect(List<int> c, List<int> d, List<int> a, List<int> b) {
  var x1 = c[0], x3 = a[0], x21 = d[0] - x1, x43 = b[0] - x3,
      y1 = c[1], y3 = a[1], y21 = d[1] - y1, y43 = b[1] - y3,
      ua = (x43 * (y1 - y3) - y43 * (x1 - x3)) / (y43 * x21 - x43 * y21);
  return [x1 + ua * x21, y1 + ua * y21];
}

// Returns true if the polygon is closed.
bool polygonClosed(List<List<num>> coordinates) {
  var a = coordinates[0],
      b = coordinates[coordinates.length - 1];
  return !(a[0] - b[0] || a[1] - b[1]);
}
