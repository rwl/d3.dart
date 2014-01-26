part of color;

hsl(h, [s = null, l = null]) {
  if (s == null && l == null) {
    if (h is Hsl) {
      return new Hsl.from(h);
    }
    return parse(h.toString(), rgb_hsl, new_hsl);
  }
  return new Hsl(h, s, l);
}

new_hsl(h, s, l) {
  return new Hsl(h, s, l);
}

class Hsl extends Color {
  double h, s, l;

  Hsl(hh, ss, ll) {
    this.h = (hh is int) ? hh.toDouble() : (hh is String) ? double.parse(hh) : hh;
    this.s = (ss is int) ? ss.toDouble() : (ss is String) ? double.parse(ss) : ss;
    this.l = (ll is int) ? ll.toDouble() : (ll is String) ? double.parse(ll) : ll;
  }

  factory Hsl.from(Hsl other) {
    return new Hsl(other.h, other.s, other.l);
  }

  Hsl brighter([num k = 1]) {
    k = math.pow(0.7, k);
    return new Hsl(this.h, this.s, this.l / k);
  }

  Hsl darker([num k = 1]) {
    k = math.pow(0.7, k);
    return new Hsl(this.h, this.s, k * this.l);
  }

  Rgb rgb() {
    return hsl_rgb(this.h, this.s, this.l);
  }

  String toString() {
    return this.rgb().toString();
  }
}

Rgb hsl_rgb(h, s, l) {
  var m1,
      m2;

  /* Some simple corrections for h, s and l. */
  h = h.isNaN ? 0 : (h %= 360) < 0 ? h + 360 : h;
  s = s.isNaN ? 0 : s < 0 ? 0 : s > 1 ? 1 : s;
  l = l < 0 ? 0 : l > 1 ? 1 : l;

  /* From FvD 13.37, CSS Color Module Level 3 */
  m2 = l <= .5 ? l * (1 + s) : l + s - l * s;
  m1 = 2 * l - m2;

  v(h) {
    if (h > 360) h -= 360;
    else if (h < 0) h += 360;
    if (h < 60) return m1 + (m2 - m1) * h / 60;
    if (h < 180) return m2;
    if (h < 240) return m1 + (m2 - m1) * (240 - h) / 60;
    return m1;
  }

  vv(h) {
    return (v(h) * 255).round();
  }

  return new Rgb(vv(h + 120), vv(h), vv(h - 120));
}
