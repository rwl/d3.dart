
rgbEquals(actual, r, g, b, message) {
  /*var ar = Math.round(actual.r),
      ag = Math.round(actual.g),
      ab = Math.round(actual.b),
      er = Math.round(r),
      eg = Math.round(g),
      eb = Math.round(b);
  if (ar != er || ag != eg || ab != eb) {
    assert.fail(
      "rgb(" + ar + "," + ag + "," + ab + ")",
      "rgb(" + er + ", " + eg + ", " + eb + ")",
      message || "expected {expected}, got {actual}", "===", assert.rgbEqual);
  }*/
}

hslEquals(actual, h, s, l, message) {
  /*var ah = _.round(actual.h, 2),
      as = _.round(actual.s, 2),
      al = _.round(actual.l, 2),
      eh = _.round(h, 2),
      es = _.round(s, 2),
      el = _.round(l, 2);
  if ((!(isNaN(ah) && isNaN(eh)) && ah !== eh) || (!(isNaN(as) && isNaN(es)) && as !== es) || al !== el) {
    assert.fail(
      "hsl(" + ah + "," + as + "," + al + ")",
      "hsl(" + eh + "," + es + "," + el + ")",
      message || "expected {expected}, got {actual}", null, assert.hslEqual);
  }*/
}

hclEquals(actual, h, c, l, message) {
  /*var ah = _.round(actual.h, 2),
      ac = _.round(actual.c, 2),
      al = _.round(actual.l, 2),
      eh = _.round(h, 2),
      ec = _.round(c, 2),
      el = _.round(l, 2);
  if ((!(isNaN(ah) && isNaN(eh)) && ah !== eh) || ac !== ec || al !== el) {
    assert.fail(
      "hcl(" + ah + "," + ac + "," + al + ")",
      "hcl(" + eh + "," + ec + "," + el + ")",
      message || "expected {expected}, got {actual}", null, assert.hclEqual);
  }*/
}

labEquals(actual, l, a, b, message) {
  /*var al = _.round(actual.l, 2),
      aa = _.round(actual.a, 2),
      ab = _.round(actual.b, 2),
      el = _.round(l, 2),
      ea = _.round(a, 2),
      eb = _.round(b, 2);
  if (al !== el || aa !== ea || ab !== eb) {
    assert.fail(
      "lab(" + al + ", " + aa + ", " + ab + ")",
      "lab(" + el + ", " + ea + ", " + eb + ")",
      message || "expected {expected}, got {actual}", null, assert.labEqual);
  }*/
}
