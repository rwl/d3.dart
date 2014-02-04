part of d3.svg;

class LineRadial {
  var radius, angle;

  LineRadial() {
    var line = new Line(lineRadial);
    radius = line.x;
    angle = line.y;
  }
}

lineRadial(points) {
  var point,
      i = -1,
      n = points.length,
      r,
      a;
  while (++i < n) {
    point = points[i];
    r = point[0];
    a = point[1] + arcOffset;
    point[0] = r * math.cos(a);
    point[1] = r * math.sin(a);
  }
  return points;
}
