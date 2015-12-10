import 'dart:math' as math;
import 'package:d3/d3.dart';

main() {
  var width = 960, height = 500;

  var color = new OrdinalScale.category20();

  var force = new Force()
    ..charge = -120
    ..linkDistance = 30
    ..size = [width, height];

  var svg = new Selection("body").append("svg")
    ..attr["width"] = "$width"
    ..attr["height"] = "$height";

  json("miserables.json").then((graph) {
    force
      ..nodes = graph['nodes']
      ..links = graph['links']
      ..start();

    var link =
        svg.selectAll(".link").setData(graph['links']).enter().append("line")
          ..attr["class"] = "link"
          ..styleFn["stroke-width"] = (d) => math.sqrt(d['value']);

    var node =
        svg.selectAll(".node").setData(graph['nodes']).enter().append("circle")
          ..attr["class"] = "node"
          ..attr["r"] = 5
          ..styleFn["fill"] = ((d) => color(d['group']))
          ..call((_) => force.drag());

    node.append("title")..textFn = (d) => d['name'];

    force.onTick.listen((_) {
      link
        ..attrFn["x1"] = ((d) => d['source']['x'])
        ..attrFn["y1"] = ((d) => d['source']['y'])
        ..attrFn["x2"] = ((d) => d['target']['x'])
        ..attrFn["y2"] = ((d) => d['target']['y']);

      node
        ..attrFn["cx"] = ((d) => d['x'])
        ..attrFn["cy"] = ((d) => d['y']);
    });
  }, onError: (err) => throw err);
}
