part of d3.svg;

class AreaRadial {
  var radius;
  var innerRadius;
  var outerRadius;
  var angle;
  var startAngle;
  var endAngle;

  AreaRadial() {
    var area = new Area(lineRadial);
    radius = area.x;
    innerRadius = area.x0;
    outerRadius = area.x1;
    angle = area.y;
    startAngle = area.y0;
    endAngle = area.y1;
  }
}
