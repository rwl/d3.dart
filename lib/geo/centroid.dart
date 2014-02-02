part of d3.geo;

centroid(object) {
  centroidW0 = centroidW1 =
  centroidX0 = centroidY0 = centroidZ0 =
  centroidX1 = centroidY1 = centroidZ1 =
  centroidX2 = centroidY2 = centroidZ2 = 0;
  stream(object, centroid);

  var x = centroidX2,
      y = centroidY2,
      z = centroidZ2,
      m = x * x + y * y + z * z;

  // If the area-weighted centroid is undefined, fall back to length-weighted centroid.
  if (m < epsilon2) {
    x = centroidX1; y = centroidY1; z = centroidZ1;
    // If the feature has zero length, fall back to arithmetic mean of point vectors.
    if (centroidW1 < epsilon) {
      x = centroidX0; y = centroidY0; z = centroidZ0;
    }
    m = x * x + y * y + z * z;
    // If the feature still has an undefined centroid, then return.
    if (m < epsilon2) return [double.NAN, double.NAN];
  }

  return [math.atan2(y, x) * degrees, asin(z / math.sqrt(m)) * degrees];
}

var centroidW0,
    centroidW1,
    centroidX0,
    centroidY0,
    centroidZ0,
    centroidX1,
    centroidY1,
    centroidZ1,
    centroidX2,
    centroidY2,
    centroidZ2;

class Centroid {
  Function sphere = () {};
  Function point = centroidPoint;
  Function lineStart = centroidLineStart;
  Function lineEnd = centroidLineEnd;
  polygonStart() {
    this.lineStart = centroidRingStart;
  }
  polygonEnd() {
    this.lineStart = centroidLineStart;
  }
}

final geo_centroid = new Centroid();

// Arithmetic mean of Cartesian vectors.
centroidPoint(lambda, phi) {
  lambda *= radians;
  var cosphi = math.cos(phi *= radians);
  centroidPointXYZ(cosphi * math.cos(lambda), cosphi * math.sin(lambda), math.sin(phi));
}

centroidPointXYZ(x, y, z) {
  ++centroidW0;
  centroidX0 += (x - centroidX0) / centroidW0;
  centroidY0 += (y - centroidY0) / centroidW0;
  centroidZ0 += (z - centroidZ0) / centroidW0;
}

centroidLineStart() {
  var x0, y0, z0; // previous point

  nextPoint(lambda, phi) {
    lambda *= radians;
    var cosphi = math.cos(phi *= radians),
        x = cosphi * math.cos(lambda),
        y = cosphi * math.sin(lambda),
        z = math.sin(phi),
        w = math.atan2(
          math.sqrt((w = y0 * z - z0 * y) * w + (w = z0 * x - x0 * z) * w + (w = x0 * y - y0 * x) * w),
          x0 * x + y0 * y + z0 * z);
    centroidW1 += w;
    centroidX1 += w * (x0 + (x0 = x));
    centroidY1 += w * (y0 + (y0 = y));
    centroidZ1 += w * (z0 + (z0 = z));
    centroidPointXYZ(x0, y0, z0);
  }

  geo_centroid.point = (lambda, phi) {
    lambda *= radians;
    var cosphi = math.cos(phi *= radians);
    x0 = cosphi * math.cos(lambda);
    y0 = cosphi * math.sin(lambda);
    z0 = math.sin(phi);
    geo_centroid.point = nextPoint;
    centroidPointXYZ(x0, y0, z0);
  };
}

centroidLineEnd() {
  geo_centroid.point = centroidPoint;
}

// See J. E. Brock, The Inertia Tensor for a Spherical Triangle,
// J. Applied Mechanics 42, 239 (1975).
centroidRingStart() {
  var lambda00, phi00, // first point
      x0, y0, z0; // previous point

  nextPoint(lambda, phi) {
    lambda *= radians;
    var cosphi = math.cos(phi *= radians),
        x = cosphi * math.cos(lambda),
        y = cosphi * math.sin(lambda),
        z = math.sin(phi),
        cx = y0 * z - z0 * y,
        cy = z0 * x - x0 * z,
        cz = x0 * y - y0 * x,
        m = math.sqrt(cx * cx + cy * cy + cz * cz),
        u = x0 * x + y0 * y + z0 * z,
        v = m && -acos(u) / m, // area weight
        w = math.atan2(m, u); // line weight
    centroidX2 += v * cx;
    centroidY2 += v * cy;
    centroidZ2 += v * cz;
    centroidW1 += w;
    centroidX1 += w * (x0 + (x0 = x));
    centroidY1 += w * (y0 + (y0 = y));
    centroidZ1 += w * (z0 + (z0 = z));
    centroidPointXYZ(x0, y0, z0);
  }

  geo_centroid.point = (lambda, phi) {
    lambda00 = lambda; phi00 = phi;
    geo_centroid.point = nextPoint;
    lambda *= radians;
    var cosphi = math.cos(phi *= radians);
    x0 = cosphi * math.cos(lambda);
    y0 = cosphi * math.sin(lambda);
    z0 = math.sin(phi);
    centroidPointXYZ(x0, y0, z0);
  };

  geo_centroid.lineEnd = () {
    nextPoint(lambda00, phi00);
    geo_centroid.lineEnd = centroidLineEnd;
    geo_centroid.point = centroidPoint;
  };
}
