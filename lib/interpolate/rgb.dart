part of interpolate;

Function interpolateRgb(a, b) {
  color.Rgb a_rgb = new color.rgb(a);
  color.Rgb b_rgb = new color.rgb(b);
  var ar = a_rgb.r,
      ag = a_rgb.g,
      ab = a_rgb.b,
      br = b_rgb.r - ar,
      bg = b_rgb.g - ag,
      bb = b_rgb.b - ab;
  return (t) {
    return "#"
        + d3_rgb_hex(Math.round(ar + br * t))
        + d3_rgb_hex(Math.round(ag + bg * t))
        + d3_rgb_hex(Math.round(ab + bb * t));
  };
}
