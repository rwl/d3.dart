part of interpolate;

Function interpolateRgb(a, b) {
  color.Rgb a_rgb = color.rgb(a);
  color.Rgb b_rgb = color.rgb(b);
  var ar = a_rgb.r,
      ag = a_rgb.g,
      ab = a_rgb.b,
      br = b_rgb.r - ar,
      bg = b_rgb.g - ag,
      bb = b_rgb.b - ab;
  return (t) {
    return "#"
        + color.rgb_hex((ar + br * t).round())
        + color.rgb_hex((ag + bg * t).round())
        + color.rgb_hex((ab + bb * t).round());
  };
}
