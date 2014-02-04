part of d3.svg;

class Chord {
  Function source = core.source,
      target = core.target,
      radius = chordRadius,
      startAngle = arcStartAngle,
      endAngle = arcEndAngle;

  chord(d, i) {
    var s = subgroup(this, source, d, i),
        t = subgroup(this, target, d, i);
    return "M" + s.p0
      + arc(s.r, s.p1, s.a1 - s.a0) + (equals(s, t)
      ? curve(s.r, s.p1, s.r, s.p0)
      : curve(s.r, s.p1, t.r, t.p0)
      + arc(t.r, t.p1, t.a1 - t.a0)
      + curve(t.r, t.p1, s.r, s.p0))
      + "Z";
  }

  subgroup(self, f, d, i) {
    var subgroup = f.call(self, d, i),
        r = radius.call(self, subgroup, i),
        a0 = startAngle.call(self, subgroup, i) + arcOffset,
        a1 = endAngle.call(self, subgroup, i) + arcOffset;
    return {
      'r': r,
      'a0': a0,
      'a1': a1,
      'p0': [r * math.cos(a0), r * math.sin(a0)],
      'p1': [r * math.cos(a1), r * math.sin(a1)]
    };
  }

  bool equals(a, b) {
    return a.a0 == b.a0 && a.a1 == b.a1;
  }

  String arc(r, p, a) {
    return "A" + r + "," + r + " 0 " + toDouble(a > pi) + ",1 " + p;
  }

  String curve(r0, p0, r1, p1) {
    return "Q 0,0 " + p1;
  }
}

chordRadius(d) {
  return d.radius;
}
