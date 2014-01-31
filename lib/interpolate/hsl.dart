part of interpolate;

interpolateHsl(aa, bb) {
  color.Hsl a = color.hsl(aa);
  color.Hsl b = color.hsl(bb);
  var ah = a.h,
      as = a.s,
      al = a.l,
      bh = b.h - ah,
      bs = b.s - as,
      bl = b.l - al;
  if (bs.isNaN) {
    bs = 0;
    as = as.isNaN ? b.s : as;
  }
  if (bh.isNaN) {
    bh = 0;
    ah = ah.isNaN ? b.h : ah;
  } else if (bh > 180) {
    bh -= 360;
  } else if (bh < -180) {
    bh += 360; // shortest path
  }
  return (t) {
    return color.hsl_rgb(ah + bh * t, as + bs * t, al + bl * t).toString();
  };
}
