part of d3.svg;

class Area {
  var x0 = geom.pointX,
      x1 = geom.pointX,
      y0 = 0,
      y1 = geom.pointY,
      defined = core.d3_true,
      interpolate = lineLinear,
//      interpolateKey = interpolate.key,
      interpolateReverse,
      L = "L",
      tension = .7;

  Function projection;

  Area(this.projection=identity) {
    interpolateReverse = interpolate;
  }

  area(data) {
    var segments = [],
        points0 = [],
        points1 = [],
        i = -1,
        n = data.length,
        d,
        fx0 = core.functor(x0),
        fy0 = core.functor(y0),
        x,
        y;

    var fx1 = x0 == x1 ? () { return x; } : core.functor(x1);
    var fy1 = y0 == y1 ? () { return y; } : core.functor(y1);

    segment() {
      segments.addAll(["M", interpolate(projection(points1), tension),
          L, interpolateReverse(projection(points0.reverse()), tension),
          "Z"]);
    }

    while (++i < n) {
      if (defined.call(this, d = data[i], i)) {
        points0.add([x = toDouble(fx0.call(this, d, i)), y = toDouble(fy0.call(this, d, i))]);
        points1.add([toDouble(fx1.call(this, d, i)), toDouble(fy1.call(this, d, i))]);
      } else if (points0.length) {
        segment();
        points0 = [];
        points1 = [];
      }
    }

    if (points0.length) segment();

    return segments.length ? segments.join("") : null;
  }

  Function get x => x1;

  void set x(var xx) {
    x0 = x1 = xx;
  }

  Function get y => y1;

  void set y(var yy) {
    y0 = y1 = yy;
  }

  interpolate([arg = null]) {
    if (arg == null) return interpolateKey;
    if (arg is Function) {
      interpolateKey = interpolate = arg;
    } else {
      interpolateKey = (interpolate = lineInterpolators.get(_) || lineLinear).key;
    }
    interpolateReverse = interpolate.reverse || interpolate;
    L = interpolate.closed ? "M" : "L";
    return area;
  }
}

//lineStepBefore.reverse = lineStepAfter;
//lineStepAfter.reverse = lineStepBefore;
