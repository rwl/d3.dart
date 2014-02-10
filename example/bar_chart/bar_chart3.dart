import 'package:d3/scale/scale.dart';
import 'package:d3/arrays/arrays.dart';
import 'package:d3/selection/selection.dart';
import 'package:d3/svg/svg.dart';
import 'package:d3/dsv/dsv.dart';
import 'package:d3/utils.dart';

main() {

final margin = new Margin(20, 20, 30, 40);
final width = 960 - margin.left - margin.right;
final height = 500 - margin.top - margin.bottom;

var x = new Ordinal()
    ..rangeRoundBands([0, width], .1);

var y = new Linear()
    ..range = [height, 0];

var xAxis = new Axis()
    ..scale = x
    ..orient("bottom");

var yAxis = new Axis()
    ..scale = y
    ..orient("left")
    ..ticks(10, "%");

var svg = new Selection.selector("body")
  .append("svg")
  ..attr("width", width + margin.left + margin.right)
  ..attr("height", height + margin.top + margin.bottom)
  .append("g")
  ..attr("transform", "translate(${margin.left},${margin.top})");

tsv("data3.tsv", row: type, callback: (final List<Map<String, Object>> data, _) {
  x.domain = data.map((final Map<String, Object> d) {
    return d['letter'];
  });
  y.domain = [0, max(data, (d) {
    return d.frequency;
  })];

  svg.append("g")
    ..attr("class", "x axis")
    ..attr("transform", "translate(0,$height)")
    ..call(xAxis);

  svg.append("g")
    ..attr("class", "y axis")
    ..call(yAxis)
    .append("text")
    ..attr("transform", "rotate(-90)")
    ..attr("y", 6)
    ..attr("dy", ".71em")
    ..style("text-anchor", "end")
    ..text("Frequency");

  svg.selectAll(".bar")
     .data(data)
    .enter()
    .append("rect")
    ..attr("class", "bar")
    ..attr("x", (n, d) { return x(d.letter); })
    ..attr("width", x.rangeBand())
    ..attr("y", (n, d) { return y(d.frequency); })
    ..attr("height", (n, d) { return height - y(d.frequency); });
});

}

Map<String, Object> type(Map<String, String> d, int i) {
  var dd = new Map.from(d);
  dd['frequency'] = double.parse(dd['frequency']); // coerce to number
  return dd;
}