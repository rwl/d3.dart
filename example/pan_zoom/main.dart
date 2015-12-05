import 'package:d3/d3.dart' as d3;
import 'package:d3/scale.dart' as scale;
import 'package:d3/behavior.dart' as behavior;
import 'package:d3/svg.dart' as svg_;

main() {
  var margin = new d3.Margin(top: 20, right: 20, bottom: 30, left: 40);
  var width = 960 - margin.left - margin.right;
  var height = 500 - margin.top - margin.bottom;

  var x = scale.linear().domain([-width / 2, width / 2]).range([0, width]);

  var y = scale.linear().domain([-height / 2, height / 2]).range([height, 0]);

  var xAxis = svg_.axis().scale(x).orient("bottom").tickSize(-height);

  var yAxis = svg_.axis().scale(y).orient("left").ticks(5).tickSize(-width);

  var svg = d3.select("body").append("svg");

  var zoom = behavior.zoom().x(x).y(y).scaleExtent([1, 10]).on("zoom",
      allowInteropCaptureThis((e, d, i, j) {
    svg.select(".x.axis").call(xAxis);
    svg.select(".y.axis").call(yAxis);
  }));

  svg
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .append("g")
      .attr("transform", "translate(${margin.left},${margin.top})")
      .call(zoom);

  svg.append("rect").attr("width", width).attr("height", height);

  svg
      .append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0,$height)")
      .call(xAxis);

  svg.append("g").attr("class", "y axis").call(yAxis);

  d3.select("button").on("click", allowInteropCaptureThis((e, d, i, j) {
    svg.call(zoom
        .x(x.domain([-width / 2, width / 2]))
        .y(y.domain([-height / 2, height / 2]))
        .event);
  }));
}
