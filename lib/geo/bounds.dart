part of d3.geo;

class Bound {
  var lambda0, phi0, lambda1, phi1, // bounds
  lambda_, // previous lambda-coordinate
  lambda__, phi__, // first point
  p0, // previous 3D point
  dlambdaSum,
  ranges,
  range;

  Function point;
  Function lineStart;
  Function lineEnd;

  Bound() {
    point = _point;
    lineStart = _lineStart;
    lineEnd = _lineEnd;
  }

  polygonStart() {
    this.point = _ringPoint;
    this.lineStart = _ringStart;
    this.lineEnd = _ringEnd;
    dlambdaSum = 0;
    geo_area.polygonStart();
  }

  polygonEnd() {
    geo_area.polygonEnd();
    this.point = _point;
    this.lineStart = _lineStart;
    this.lineEnd = _lineEnd;
    if (areaRingSum < 0) {
      lambda0 = -(lambda1 = 180); phi0 = -(phi1 = 90);
    } else if (dlambdaSum > epsilon) {
      phi1 = 90;
    } else if (dlambdaSum < -epsilon) {
      phi0 = -90;
    }
    range[0] = lambda0; range[1] = lambda1;
  }

  _point(lambda, phi) {
    ranges.add(range = [lambda0 = lambda, lambda1 = lambda]);
    if (phi < phi0) phi0 = phi;
    if (phi > phi1) phi1 = phi;
  }

  _linePoint(lambda, phi) {
    var p = cartesian([lambda * radians, phi * radians]);
    if (p0) {
      var normal = cartesianCross(p0, p),
          equatorial = [normal[1], -normal[0], 0],
          inflection = cartesianCross(equatorial, normal);
      cartesianNormalize(inflection);
      inflection = spherical(inflection);
      var dlambda = lambda - lambda_,
          s = dlambda > 0 ? 1 : -1,
          lambdai = inflection[0] * degrees * s,
          antimeridian = dlambda.abs() > 180;
      if (antimeridian ^ (s * lambda_ < lambdai && lambdai < s * lambda)) {
        var phii = inflection[1] * degrees;
        if (phii > phi1) phi1 = phii;
      } else if (lambdai = (lambdai + 360) % 360 - 180, antimeridian ^ (s * lambda_ < lambdai && lambdai < s * lambda)) {
        var phii = -inflection[1] * degrees;
        if (phii < phi0) {
          phi0 = phii;
        }
      } else {
        if (phi < phi0) phi0 = phi;
        if (phi > phi1) phi1 = phi;
      }
      if (antimeridian) {
        if (lambda < lambda_) {
          if (angle(lambda0, lambda) > angle(lambda0, lambda1)) lambda1 = lambda;
        } else {
          if (angle(lambda, lambda1) > angle(lambda0, lambda1)) lambda0 = lambda;
        }
      } else {
        if (lambda1 >= lambda0) {
          if (lambda < lambda0) lambda0 = lambda;
          if (lambda > lambda1) lambda1 = lambda;
        } else {
          if (lambda > lambda_) {
            if (angle(lambda0, lambda) > angle(lambda0, lambda1)) lambda1 = lambda;
          } else {
            if (angle(lambda, lambda1) > angle(lambda0, lambda1)) lambda0 = lambda;
          }
        }
      }
    } else {
      point(lambda, phi);
    }
    p0 = p; lambda_ = lambda;
  }

  _lineStart() { this.point = _linePoint; }

  _lineEnd() {
    range[0] = lambda0; range[1] = lambda1;
    this.point = _point;
    p0 = null;
  }

  _ringPoint(lambda, phi) {
    if (p0) {
      var dlambda = lambda - lambda_;
      dlambdaSum += dlambda.abs() > 180 ? dlambda + (dlambda > 0 ? 360 : -360) : dlambda;
    } else {
      lambda__ = lambda; phi__ = phi;
    }
    geo_area.point(lambda, phi);
    _linePoint(lambda, phi);
  }

  _ringStart() {
    geo_area.lineStart();
  }

  _ringEnd() {
    _ringPoint(lambda__, phi__);
    geo_area.lineEnd();
    if (dlambdaSum.abs() > epsilon) lambda0 = -(lambda1 = 180);
    range[0] = lambda0; range[1] = lambda1;
    p0 = null;
  }
}


bounds(feature) {
  final Bound b = new Bound();

  b.phi1 = b.lambda1 = double.NEGATIVE_INFINITY;
  b.lambda0 = b.phi0 = double.INFINITY;
  b.ranges = [];

  stream(feature, b);

  var n = b.ranges.length;
  if (n) {
    // First, sort ranges by their minimum longitudes.
    b.ranges.sort(compareRanges);

    // Then, merge any ranges that overlap.
    for (var i = 1, a = b.ranges[0], b, merged = [a]; i < n; ++i) {
      b = b.ranges[i];
      if (withinRange(b[0], a) || withinRange(b[1], a)) {
        if (angle(a[0], b[1]) > angle(a[0], a[1])) a[1] = b[1];
        if (angle(b[0], a[1]) > angle(a[0], a[1])) a[0] = b[0];
      } else {
        merged.add(a = b);
      }
    }

    // Finally, find the largest gap between the merged ranges.
    // The final bounding box will be the inverse of this gap.
    var best = double.NEGATIVE_INFINITY, dlambda;
    for (var n = merged.length - 1, i = 0, a = merged[n], b; i <= n; a = b, ++i) {
      b = merged[i];
      if ((dlambda = angle(a[1], b[0])) > best) {
        best = dlambda; b.lambda0 = b[0]; b.lambda1 = a[1];
      }
    }
  }
  b.ranges = b.range = null;

  return b.lambda0 == double.INFINITY || b.phi0 == double.INFINITY
      ? [[double.NAN, double.NAN], [double.NAN, double.NAN]]
  : [[b.lambda0, b.phi0], [b.lambda1, b.phi1]];
}

// Finds the left-right distance between two longitudes.
// This is almost the same as (lambda1 - lambda0 + 360°) % 360°, except that we want
// the distance between ±180° to be 360°.
angle(lambda0, lambda1) { return (lambda1 -= lambda0) < 0 ? lambda1 + 360 : lambda1; }

compareRanges(a, b) { return a[0] - b[0]; }

withinRange(x, range) {
  return range[0] <= range[1] ? range[0] <= x && x <= range[1] : x < range[0] || range[1] < x;
}
