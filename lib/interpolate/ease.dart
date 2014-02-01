part of interpolate;

ease_default() { return core.identity; }

final easers = {
  'linear': ease_default,
  'poly': ease_poly,
  'quad': () { return ease_quad; },
  'cubic': () { return ease_cubic; },
  'sin': () { return ease_sin; },
  'exp': () { return ease_exp; },
  'circle': () { return ease_circle; },
  'elastic': ease_elastic,
  'back': ease_back,
  'bounce': () { return ease_bounce; }
};

final ease_mode = {
  "in": core.identity,
  "out": ease_reverse,
  "in-out": ease_reflect,
  "out-in": (f) { return ease_reflect(ease_reverse(f)); }
};

ease(name) {
  var i = name.indexOf("-"),
      t = i >= 0 ? name.substring(0, i) : name,
      m = i >= 0 ? name.substring(i + 1) : "in";
  t = easers['t'] || ease_default;
  m = ease_mode['m'] || core.identity;
  return ease_clamp(m(t.apply(null, d3_arraySlice.call(arguments, 1))));
}

ease_clamp(f) {
  return (t) {
    return t <= 0 ? 0 : t >= 1 ? 1 : f(t);
  };
}

ease_reverse(f) {
  return (t) {
    return 1 - f(1 - t);
  };
}

ease_reflect(f) {
  return (t) {
    return .5 * (t < .5 ? f(2 * t) : (2 - f(2 - 2 * t)));
  };
}

ease_quad(t) {
  return t * t;
}

ease_cubic(t) {
  return t * t * t;
}

// Optimized clamp(reflect(poly(3))).
ease_cubicInOut(t) {
  if (t <= 0) return 0;
  if (t >= 1) return 1;
  var t2 = t * t, t3 = t2 * t;
  return 4 * (t < .5 ? t3 : 3 * (t - t2) + t3 - .75);
}

ease_poly(e) {
  return (t) {
    return math.pow(t, e);
  };
}

ease_sin(t) {
  return 1 - math.cos(t * halfpi);
}

ease_exp(t) {
  return math.pow(2, 10 * (t - 1));
}

ease_circle(t) {
  return 1 - math.sqrt(1 - t * t);
}

ease_elastic([a=null, p=0.45]) {
  var s;
  if (a != null) {
    s = p / tau * math.asin(1 / a);
  } else {
    a = 1;
    s = p / 4;
  }
  return (t) {
    return 1 + a * math.pow(2, -10 * t) * math.sin((t - s) * tau / p);
  };
}

ease_back([s = 1.70158]) {
  return (t) {
    return t * t * ((s + 1) * t - s);
  };
}

ease_bounce(t) {
  return t < 1 / 2.75 ? 7.5625 * t * t
      : t < 2 / 2.75 ? 7.5625 * (t -= 1.5 / 2.75) * t + .75
      : t < 2.5 / 2.75 ? 7.5625 * (t -= 2.25 / 2.75) * t + .9375
      : 7.5625 * (t -= 2.625 / 2.75) * t + .984375;
}
