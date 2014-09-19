part of d3.svg;

typedef String interpolator(List<List<num>> points, num tension);

typedef bool definer(Line line, List<num> point, int i);

typedef List<List<num>> projector(List<List<num>> points);

class Line {
  num x = null;
  num y = null;
  definer defined = (t, d, i) { return true; };
  interpolator interpolate = lineLinear;
  String interpolateKey = "linear";
  num tension = .7;

  projector projection;

  Line([this.projection = null]) {
    if (projection == null) {
      projection = (d) => d;
    }
  }

  line(data) {
    List segments = [], points = [];
    int i = -1, n = data.length;
    var d;

    segment() {
      segments.addAll(["M", interpolate(projection(points), tension)]);
    }

    while (++i < n) {
      if (defined(this, d = data[i], i)) {
        points.add([x == null ? data[i][0] : x, y == null ? data[i][1] : y]);
      } else if (points.length > 0) {
        segment();
        points = [];
      }
    }

    if (points.length > 0) segment();

    return segments.length > 0 ? segments.join("") : null;
  }

  String get interpolation => interpolateKey;

  void set interpolation(final String key) {
    if (lineInterpolators.containsKey(key)) {
      interpolate = lineInterpolators[key];
      interpolateKey = key;
    } else {
      interpolate = lineLinear;
      interpolateKey = "linear";
    }
  }
}

// The various interpolators supported by the `line` class.
final Map<String, interpolator> lineInterpolators = {
  "linear": lineLinear,
  "linear-closed": lineLinearClosed,
  "step": lineStep,
  "step-before": lineStepBefore,
  "step-after": lineStepAfter,
  "basis": lineBasis,
  "basis-open": lineBasisOpen,
  "basis-closed": lineBasisClosed,
  "bundle": lineBundle,
//  "cardinal": lineCardinal,
//  "cardinal-open": lineCardinalOpen,
//  "cardinal-closed": lineCardinalClosed,
//  "monotone": lineMonotone
};


// Linear interpolation; generates "L" commands.
String lineLinear(List<List<num>> points, num tension) {
  return points.map((point) {
    return "${fmt(point[0])},${fmt(point[1])}";
  }).join("L");
}

String lineLinearClosed(List<List<num>> points, num tension) {
  return lineLinear(points, tension) + "Z";
}

// Step interpolation; generates "H" and "V" commands.
String lineStep(List<List<num>> points, num tension) {
  var i = 0,
      n = points.length,
      p = points[0],
      path = [p[0], ",", p[1]];
  while (++i < n) {
    path.addAll(["H", (p[0] + (p = points[i])[0]) / 2, "V", p[1]]);
  }
  if (n > 1) {
    path.addAll(["H", p[0]]);
  }
  return path.join("");
}

// Step interpolation; generates "H" and "V" commands.
String lineStepBefore(List<List<num>> points, num tension) {
  var i = 0,
      n = points.length,
      p = points[0],
      path = [p[0], ",", p[1]];
  while (++i < n) {
    path.addAll(["V", (p = points[i])[1], "H", p[0]]);
  }
  return path.join("");
}

// Step interpolation; generates "H" and "V" commands.
String lineStepAfter(List<List<num>> points, num tension) {
  var i = 0,
      n = points.length,
      p = points[0],
      path = [p[0], ",", p[1]];
  while (++i < n) {
    path.addAll(["H", (p = points[i])[0], "V", p[1]]);
  }
  return path.join("");
}
/*
// Open cardinal spline interpolation; generates "C" commands.
String lineCardinalOpen(List<List<num>> points, num tension) {
  return points.length < 4
      ? lineLinear(points, tension)
      : points[1] + lineHermite(points.slice(1, points.length - 1),
        lineCardinalTangents(points, tension));
}

// Closed cardinal spline interpolation; generates "C" commands.
String lineCardinalClosed(List<List<num>> points, num tension) {
  if (points.length < 3) {
    return lineLinear(points, tension);
  } else {
    points.add(points[0]);
    return points[0] + lineHermite(points,
        lineCardinalTangents([points[points.length - 2]]
        .concat(points, [points[1]]), tension));
  }
}

// Cardinal spline interpolation; generates "C" commands.
String lineCardinal(List<List<num>> points, num tension) {
  return points.length < 3
      ? lineLinear(points, tension)
      : points[0] + lineHermite(points,
        lineCardinalTangents(points, tension));
}
*/

// Hermite spline construction; generates "C" commands.
String lineHermite(List<List<num>> points, List tangents) {
  if (tangents.length < 1
      || (points.length != tangents.length
      && points.length != tangents.length + 2)) {
    return lineLinear(points, -1);
  }

  bool quad = points.length != tangents.length;
  var path = "",
      p0 = points[0],
      p = points[1],
      t0 = tangents[0],
      t = t0,
      pi = 1;

  if (quad) {
    path += "Q" + (p[0] - t0[0] * 2 / 3) + "," + (p[1] - t0[1] * 2 / 3)
        + "," + p[0] + "," + p[1];
    p0 = points[1];
    pi = 2;
  }

  if (tangents.length > 1) {
    t = tangents[1];
    p = points[pi];
    pi++;
    path += "C" + (p0[0] + t0[0]) + "," + (p0[1] + t0[1])
        + "," + (p[0] - t[0]) + "," + (p[1] - t[1])
        + "," + p[0] + "," + p[1];
    for (var i = 2; i < tangents.length; i++, pi++) {
      p = points[pi];
      t = tangents[i];
      path += "S" + (p[0] - t[0]) + "," + (p[1] - t[1])
          + "," + p[0] + "," + p[1];
    }
  }

  if (quad) {
    var lp = points[pi];
    path += "Q" + (p[0] + t[0] * 2 / 3) + "," + (p[1] + t[1] * 2 / 3)
        + "," + lp[0] + "," + lp[1];
  }

  return path;
}

// Generates tangents for a cardinal spline.
String lineCardinalTangents(List<List<num>> points, num tension) {
  var tangents = [],
      a = (1 - tension) / 2,
      p0,
      p1 = points[0],
      p2 = points[1],
      i = 1,
      n = points.length;
  while (++i < n) {
    p0 = p1;
    p1 = p2;
    p2 = points[i];
    tangents.add([a * (p2[0] - p0[0]), a * (p2[1] - p0[1])]);
  }
  return tangents;
}

// B-spline interpolation; generates "C" commands.
String lineBasis(List<List<num>> points, num tension) {
  if (points.length < 3) return lineLinear(points, tension);
  var i = 1,
      n = points.length,
      pi = points[0],
      x0 = pi[0],
      y0 = pi[1],
      px = [x0, x0, x0, (pi = points[1])[0]],
      py = [y0, y0, y0, pi[1]],
      path = [x0, ",", y0, "L", lineDot4(lineBasisBezier3, px), ",", lineDot4(lineBasisBezier3, py)];
  points.add(points[n - 1]);
  while (++i <= n) {
    pi = points[i];
    px.removeAt(0); px.add(pi[0]);
    py.removeAt(0); py.add(pi[1]);
    lineBasisBezier(path, px, py);
  }
  points.removeLast();
  path.addAll(["L", pi]);
  return path.join("");
}

// Open B-spline interpolation; generates "C" commands.
String lineBasisOpen(List<List<num>> points, num tension) {
  if (points.length < 4) return lineLinear(points, tension);
  var path = [],
      i = -1,
      n = points.length,
      pi,
      px = [0],
      py = [0];
  while (++i < 3) {
    pi = points[i];
    px.add(pi[0]);
    py.add(pi[1]);
  }
  path.add("${lineDot4(lineBasisBezier3, px)},${lineDot4(lineBasisBezier3, py)}");
  --i; while (++i < n) {
    pi = points[i];
    px.removeAt(0); px.add(pi[0]);
    py.removeAt(0); py.add(pi[1]);
    lineBasisBezier(path, px, py);
  }
  return path.join("");
}

// Closed B-spline interpolation; generates "C" commands.
String lineBasisClosed(List<List<num>> points, num tension) {
  var path,
      i = -1,
      n = points.length,
      m = n + 4,
      pi,
      px = [],
      py = [];
  while (++i < 4) {
    pi = points[i % n];
    px.add(pi[0]);
    py.add(pi[1]);
  }
  path = [
    lineDot4(lineBasisBezier3, px), ",",
    lineDot4(lineBasisBezier3, py)
  ];
  --i; while (++i < m) {
    pi = points[i % n];
    px.removeAt(0); px.add(pi[0]);
    py.removeAt(0); py.add(pi[1]);
    lineBasisBezier(path, px, py);
  }
  return path.join("");
}

String lineBundle(List<List<num>> points, num tension) {
  var n = points.length - 1;
  if (n != 0) {
    var x0 = points[0][0],
        y0 = points[0][1],
        dx = points[n][0] - x0,
        dy = points[n][1] - y0,
        i = -1,
        p,
        t;
    while (++i <= n) {
      p = points[i];
      t = i / n;
      p[0] = tension * p[0] + (1 - tension) * (x0 + t * dx);
      p[1] = tension * p[1] + (1 - tension) * (y0 + t * dy);
    }
  }
  return lineBasis(points, tension);
}

// Returns the dot product of the given four-element vectors.
lineDot4(List<num> a, List<num> b) {
  return a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3];
}

// Matrix to transform basis (b-spline) control points to bezier
// control points. Derived from FvD 11.2.8.
final List<double> lineBasisBezier1 = [0, 2/3, 1/3, 0];
final List<double> lineBasisBezier2 = [0, 1/3, 2/3, 0];
final List<double> lineBasisBezier3 = [0, 1/6, 2/3, 1/6];

// Pushes a "C" Bézier curve onto the specified path array, given the
// two specified four-element arrays which define the control points.
lineBasisBezier(List path, x, y) {
  path.addAll([
      "C", lineDot4(lineBasisBezier1, x),
      ",", lineDot4(lineBasisBezier1, y),
      ",", lineDot4(lineBasisBezier2, x),
      ",", lineDot4(lineBasisBezier2, y),
      ",", lineDot4(lineBasisBezier3, x),
      ",", lineDot4(lineBasisBezier3, y)]);
}

// Computes the slope from points p0 to p1.
num lineSlope(List<num> p0, List<num> p1) {
  return (p1[1] - p0[1]) / (p1[0] - p0[0]);
}

// Compute three-point differences for the given points.
// http://en.wikipedia.org/wiki/Cubic_Hermite_spline#Finite_difference
lineFiniteDifferences(List<List<num>> points, num tension) {
  var i = 0,
      j = points.length - 1,
      m = [],
      p0 = points[0],
      p1 = points[1],
      d = m[0] = lineSlope(p0, p1);
  while (++i < j) {
    m[i] = (d + (d = lineSlope(p0 = p1, p1 = points[i + 1]))) / 2;
  }
  m[i] = d;
  return m;
}
/*
// Interpolates the given points using Fritsch-Carlson Monotone cubic Hermite
// interpolation. Returns an array of tangent vectors. For details, see
// http://en.wikipedia.org/wiki/Monotone_cubic_interpolation
List lineMonotoneTangents(List<List<num>> points) {
  var tangents = [],
      d,
      a,
      b,
      s,
      m = lineFiniteDifferences(points, -1),
      i = -1,
      j = points.length - 1;

  // The first two steps are done by computing finite-differences:
  // 1. Compute the slopes of the secant lines between successive points.
  // 2. Initialize the tangents at every point as the average of the secants.

  // Then, for each segment…
  while (++i < j) {
    d = lineSlope(points[i], points[i + 1]);

    // 3. If two successive yk = y{k + 1} are equal (i.e., d is zero), then set
    // mk = m{k + 1} = 0 as the spline connecting these points must be flat to
    // preserve monotonicity. Ignore step 4 and 5 for those k.

    if (d.abs() < epsilon) {
      m[i] = m[i + 1] = 0;
    } else {
      // 4. Let ak = mk / dk and bk = m{k + 1} / dk.
      a = m[i] / d;
      b = m[i + 1] / d;

      // 5. Prevent overshoot and ensure monotonicity by restricting the
      // magnitude of vector <ak, bk> to a circle of radius 3.
      s = a * a + b * b;
      if (s > 9) {
        s = d * 3 / math.sqrt(s);
        m[i] = s * a;
        m[i + 1] = s * b;
      }
    }
  }

  // Compute the normalized tangent vector from the slopes. Note that if x is
  // not monotonic, it's possible that the slope will be infinite, so we protect
  // against NaN by setting the coordinate to zero.
  i = -1; while (++i <= j) {
    s = (points[math.min(j, i + 1)][0] - points[math.max(0, i - 1)][0]) / (6 * (1 + m[i] * m[i]));
    tangents.add([s || 0, m[i] * s || 0]);
  }

  return tangents;
}

String lineMonotone(List<List<num>> points, num tension) {
  return points.length < 3
      ? lineLinear(points, tension)
      : points[0] + lineHermite(points, lineMonotoneTangents(points));
}
*/