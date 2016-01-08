import 'dart:svg' show PathElement;
import 'package:d3/d3.dart';

main() {
  var points = [
    [480, 200],
    [580, 400],
    [680, 100],
    [780, 300],
    [180, 300],
    [280, 100],
    [380, 400]
  ];

  var svg = new Selection("body").append("svg")
    ..attr["width"] = '960'
    ..attr["height"] = '500';

  var path = svg.append("path")
    ..data([points])
    ..attrFn["d"] = (new Line()
      ..tension = 0 // Catmull–Rom
      ..interpolate = "cardinal-closed");

  svg.selectAll(".point").data(points).enter().append("circle")
    ..attr["r"] = '4'
    ..attrFn["transform"] = (d) => "translate(${d[0]},${d[1]})";

  var circle = svg.append("circle")
    ..attr["r"] = '13'
    ..attr["transform"] = "translate(${points[0][0]},${points[0][1]})";

  transition() {
    circle.transition()
      ..duration = 7500
      ..attrTween("transform", translateAlong(path.node()))
      ..each(transition, "end");
  }
  transition();
}

/// Returns an attrTween for translating along the specified path element.
translateAlong(PathElement path) {
  var l = path.getTotalLength();
  return (d, i, a) {
    return (t) {
      var p = path.getPointAtLength(t * l);
      return "translate(${p.x},${p.y})";
    };
  };
}
