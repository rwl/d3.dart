part of d3.geo;

class Circle {
  var origin = [0, 0],
      angle,
      precision = 6,
      interpolate;

  Circle() {
    circle.angle(90);
  }

  circle() {
    var center = origin is Function ? origin.apply(this, arguments) : origin,
        rotate = geo_rotation(-center[0] * radians, -center[1] * radians, 0).invert,
        ring = [];

    interpolate(null, null, 1, {
      'point': (x, y) {
        ring.push(x = rotate(x, y));
        x[0] *= degrees; x[1] *= degrees;
      }
    });

    return {'type': "Polygon", 'coordinates': [ring]};
  }

  origin([x=null]) {
    if (x == null) return origin;
    origin = x;
    return circle;
  }

  angle([x=null) {
    if (x==null) return angle;
    interpolate = circleInterpolate((angle = toDouble(x)) * radians, precision * radians);
    return circle;
  }

  precision([arg=null]) {
    if (arg == null) return precision;
    interpolate = circleInterpolate(angle * radians, (precision = toDouble(arg)) * radians);
    return circle;
  }
}

// Interpolates along a circle centered at [0°, 0°], with a given radius and
// precision.
circleInterpolate(radius, precision) {
  var cr = math.cos(radius),
      sr = math.sin(radius);
  return (from, to, direction, listener) {
    var step = direction * precision;
    if (from != null) {
      from = circleAngle(cr, from);
      to = circleAngle(cr, to);
      if (direction > 0 ? from < to: from > to) from += direction * tau;
    } else {
      from = radius + direction * tau;
      to = radius - .5 * step;
    }
    for (var point, t = from; direction > 0 ? t > to : t < to; t -= step) {
      listener.point((point = spherical([
        cr,
        -sr * math.cos(t),
        -sr * math.sin(t)
      ]))[0], point[1]);
    }
  };
}

// Signed angle of a cartesian point relative to [cr, 0, 0].
circleAngle(cr, point) {
  var a = cartesian(point);
  a[0] -= cr;
  cartesianNormalize(a);
  var angle = acos(-a[1]);
  return ((-a[2] < 0 ? -angle : angle) + 2 * math.PI - epsilon) % (2 * math.PI);
}
