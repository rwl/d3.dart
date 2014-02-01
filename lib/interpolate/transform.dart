part of interpolate;

interpolateTransform(a, b) {
  var s = [], // string constants and placeholders
      q = [], // number interpolators
      n,
      A = transform(a),
      B = transform(b),
      ta = A.translate,
      tb = B.translate,
      ra = A.rotate,
      rb = B.rotate,
      wa = A.skew,
      wb = B.skew,
      ka = A.scale,
      kb = B.scale;

  if (ta[0] != tb[0] || ta[1] != tb[1]) {
    s.addAll(["translate(", null, ",", null, ")"]);
    q.addAll([{'i': 1, 'x': libInterpolate.interpolateNumber(ta[0], tb[0])},
        {'i': 3, 'x': libInterpolate.interpolateNumber(ta[1], tb[1])}]);
  } else if (tb[0] || tb[1]) {
    s.add("translate(" + tb + ")");
  } else {
    s.add("");
  }

  if (ra != rb) {
    if (ra - rb > 180) rb += 360; else if (rb - ra > 180) ra += 360; // shortest path
    q.add({'i': s.addAll([s.pop() + "rotate(", null, ")"]) - 2,
      'x': libInterpolate.interpolateNumber(ra, rb)});
  } else if (rb) {
    s.add(s.pop() + "rotate(" + rb + ")");
  }

  if (wa != wb) {
    q.add({'i': s.addAll([s.pop() + "skewX(", null, ")"]) - 2,
      'x': libInterpolate.interpolateNumber(wa, wb)});
  } else if (wb) {
    s.add(s.pop() + "skewX(" + wb + ")");
  }

  if (ka[0] != kb[0] || ka[1] != kb[1]) {
    n = s.addAll([s.pop() + "scale(", null, ",", null, ")"]);
    q.addAll([{'i': n - 4, 'x': libInterpolate.interpolateNumber(ka[0], kb[0])},
        {'i': n - 2, 'x': libInterpolate.interpolateNumber(ka[1], kb[1])}]);
  } else if (kb[0] != 1 || kb[1] != 1) {
    s.add(s.pop() + "scale(" + kb + ")");
  }

  n = q.length;
  return (t) {
    var i = -1, o;
    while (++i < n) s[(o = q[i]).i] = o.x(t);
    return s.join("");
  };
}
