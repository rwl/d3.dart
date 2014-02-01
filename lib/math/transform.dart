part of d3.math;

Function transform = transformFn;

transformFn(string) {
  var g = document.createElementNS(core.nsPrefix['svg'], "g");
  transform = (string) {
    if (string != null) {
      g.setAttribute("transform", string);
      var t = g.transform.baseVal.consolidate();
    }
    return new Transform(t ? t.matrix : transformIdentity);
  };
  return transform(string);
}

class Transform {
  var rotate, translate, scale, skew;

  // Compute x-scale and normalize the first row.
  // Compute shear and make second row orthogonal to first.
  // Compute y-scale and normalize the second row.
  // Finally, compute the rotation.
  Transform(var m) {
    var r0 = [m.a, m.b],
        r1 = [m.c, m.d],
        kx = transformNormalize(r0),
        kz = transformDot(r0, r1),
        ky = transformNormalize(transformCombine(r1, r0, -kz)) || 0;
    if (r0[0] * r1[1] < r1[0] * r0[1]) {
      r0[0] *= -1;
      r0[1] *= -1;
      kx *= -1;
      kz *= -1;
    }
    this.rotate = (kx ? math.atan2(r0[1], r0[0]) : math.atan2(-r1[0], r1[1])) * degrees;
    this.translate = [m.e, m.f];
    this.scale = [kx, ky];
    this.skew = ky ? math.atan2(kz, ky) * degrees : 0;
  }

  String toString() {
    return "translate($translate)rotate($rotate)skewX($skew)scale($scale)";
  }
}

transformDot(a, b) {
  return a[0] * b[0] + a[1] * b[1];
}

transformNormalize(a) {
  var k = math.sqrt(transformDot(a, a));
  if (k) {
    a[0] /= k;
    a[1] /= k;
  }
  return k;
}

transformCombine(a, b, k) {
  a[0] += k * b[0];
  a[1] += k * b[1];
  return a;
}

var transformIdentity = {'a': 1, 'b': 0, 'c': 0, 'd': 1, 'e': 0, 'f': 0};
