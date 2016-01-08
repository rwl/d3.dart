import 'dart:svg' show PathElement;
import 'package:d3/d3.dart';
import 'package:d3/js/transition.dart' show interpolateString;

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

  var line = new Line()
    ..tension = 0 // Catmull–Rom
    ..interpolate = "cardinal-closed";

  var svg = new Selection("body").append("svg")
    ..datum = points
    ..attr["width"] = '960'
    ..attr["height"] = '500';

  svg.append("path")
    ..style["stroke"] = "#ddd"
    ..style["stroke-dasharray"] = "4,4"
    ..attrFn["d"] = line;

  transition(Selection path) {
    path.transition()
      ..duration = 7500
      ..attrTween("stroke-dasharray", tweenDash)
      ..each((elem, _, __) {
        transition(new Selection.elem(elem));
      }, "end");
  }
  transition(svg.append("path")..attrFn["d"] = line);
}

tweenDash(PathElement elem, _, __) {
  var l = elem.getTotalLength();
  var i = interpolateString("0,$l", "$l,$l");
  return (t) => i(t);
}
