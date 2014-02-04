part of d3.svg;

class Diagonal {
  Function source = core.source,
      target = core.target,
      projection = diagonalProjection;

  diagonal(d, i) {
    var p0 = source(this, d, i),
        p3 = target(this, d, i),
        m = (p0.y + p3.y) / 2,
        p = [p0, {'x': p0.x, 'y': m}, {'x': p3.x, 'y': m}, p3];
    p = p.map(projection);
    return "M" + p[0] + "C" + p[1] + " " + p[2] + " " + p[3];
  }
}

diagonalProjection(d) {
  return [d.x, d.y];
}
