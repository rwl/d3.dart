part of d3.geo;

area(object) {
  areaSum = 0;
  stream(object, area);
  return areaSum;
}

var areaSum;
var areaRingSum = new Adder();

class Area {
  sphere() { areaSum += 4 * pi; }
  Function point = () {};
  Function lineStart = () {};
  Function  lineEnd = () {};

  // Only count area for polygon rings.
  polygonStart() {
    areaRingSum.reset();
    lineStart = areaRingStart;
  }

  polygonEnd() {
    var area = 2 * areaRingSum;
    areaSum += area < 0 ? 4 * pi + area : area;
    lineStart = lineEnd = point = () {};
  }
}

final geo_area = new Area();

areaRingStart() {
  var lambda00, phi00, lambda0, cosphi0, sinphi0; // start point and previous point
  Function nextPoint;

  // For the first point, …
  geo_area.point = (lambda, phi) {
    geo_area.point = nextPoint;
    lambda0 = (lambda00 = lambda) * radians;  // TODO: double check
    cosphi0 = math.cos(phi = (phi00 = phi) * radians / 2 + pi / 4);
    sinphi0 = math.sin(phi);
  };

  // For subsequent points, …
  nextPoint = (lambda, phi) {
    lambda *= radians;
    phi = phi * radians / 2 + pi / 4; // half the angular distance from south pole

    // Spherical excess E for a spherical triangle with vertices: south pole,
    // previous point, current point.  Uses a formula derived from Cagnoli’s
    // theorem.  See Todhunter, Spherical Trig. (1871), Sec. 103, Eq. (2).
    var dlambda = lambda - lambda0,
        cosphi = math.cos(phi),
        sinphi = math.sin(phi),
        k = sinphi0 * sinphi,
        u = cosphi0 * cosphi + k * math.cos(dlambda),
        v = k * math.sin(dlambda);
    areaRingSum.add(math.atan2(v, u));

    // Advance the previous points.
    lambda0 = lambda;
    cosphi0 = cosphi;
    sinphi0 = sinphi;
  };

  // For the last point, return to the start.
  geo_area.lineEnd = () {
    nextPoint(lambda00, phi00);
  };
}
