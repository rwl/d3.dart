import 'package:d3/scale/scale.dart';
import 'package:d3/arrays/arrays.dart';
import 'package:d3/selection/selection.dart';
import 'package:d3/svg/svg.dart';
import 'package:d3/dsv/dsv.dart';

main() {

var margin = {'top': 20, 'right': 20, 'bottom': 30, 'left': 40},
    width = 960 - margin['left'] - margin['right'],
    height = 500 - margin['top'] - margin['bottom'];

var x = ordinal()
    .rangeRoundBands([0, width], .1);

var y = new Linear()
    ..range = [height, 0];

var xAxis = new Axis()
    ..scale = x
    ..orient("bottom");

var yAxis = new Axis()
    ..scale = y
    ..orient("left")
    ..ticks(10, "%");

var svg = select("body").append("svg")
    .attr("width", width + margin['left'] + margin['right'])
    .attr("height", height + margin['top'] + margin['bottom'])
  .append("g")
    .attr("transform", "translate(" + margin['left'] + "," + margin['top'] + ")");

type(d) {
  d.frequency = double.parse(d.frequency);
  return d;
}

tsv("data3.tsv", type, (error, data) {
  x.domain(data.map((n, d) { return d.letter; }));
  y.domain([0, max(data, (n, d) { return d.frequency; })]);

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0,$height)")
      .call(xAxis);

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("Frequency");

  svg.selectAll(".bar")
      .data(data)
    .enter().append("rect")
      .attr("class", "bar")
      .attr("x", (n, d) { return x(d.letter); })
      .attr("width", x.rangeBand())
      .attr("y", (n, d) { return y(d.frequency); })
      .attr("height", (n, d) { return height - y(d.frequency); });
});

}