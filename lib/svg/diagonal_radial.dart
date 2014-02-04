part of d3.svg;

class DiagonalRadial {
  var diagonal = new Diagonal(),
      projection = diagonalProjection,
      projection_;

  DiagonalRadial() {
    projection_ = diagonal.projection;
  }

  void set projection(x) {
    projection = x;
    projection_(diagonalRadialProjection(x);
  }
}

diagonalRadialProjection(projection) {
  return () {
    var d = projection.apply(this, arguments),
        r = d[0],
        a = d[1] + arcOffset;
    return [r * math.cos(a), r * math.sin(a)];
  };
}
