import 'package:d3/d3.dart';
import 'package:quiver/iterables.dart' show max;

main() {
  var margin = new Margin(top: 20, right: 20, bottom: 30, left: 40);
  var width = 960 - margin.left - margin.right;
  var height = 500 - margin.top - margin.bottom;

  var x = new OrdinalScale<num>()..rangeRoundBands([0, width], 0.1);

  var y = new LinearScale<num>()..range = [height, 0];

  var xAxis = new Axis()
    ..scale = x
    ..orient = "bottom";

  var yAxis = new Axis()
    ..scale = y
    ..orient = "left"
    ..ticks(10, "%");

  var svg = new Selection("body").append("svg")
    ..attr["width"] = "${width + margin.left + margin.right}"
    ..attr["height"] = "${height + margin.top + margin.bottom}";
  svg.append("g")
    ..attr["transform"] = "translate(${margin.left},${margin.top})";

  tsv("data.tsv", type).then((List data) {
    x.domain = data.map((d) => d['letter']);
    y.domain = [0, max(data.map((d) => d['frequency']))];

    svg.append("g")
      ..attr["class"] = "x axis"
      ..attr["transform"] = "translate(0,${height})"
      ..call(xAxis);

    var g = svg.append("g")
      ..attr["class"] = "y axis"
      ..call(yAxis);
    g.append("text")
      ..attr["transform"] = "rotate(-90)"
      ..attr["y"] = "6"
      ..attr["dy"] = ".71em"
      ..style["text-anchor"] = "end"
      ..text = "Frequency";

    svg.selectAll(".bar").setData(data).enter().append("rect")
      ..attr["class"] = "bar"
      ..attrFn["x"] = ((d) => x(d['letter']))
      ..attr["width"] = x.rangeBand
      ..attrFn["y"] = ((d) => y(d['frequency']))
      ..attrFn["height"] = (d) => height - y(d['frequency']);
  }, onError: (err) => throw err);
}

type(d) {
  d['frequency'] = double.parse(d['frequency']);
  return d;
}
