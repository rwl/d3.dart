import 'dart:math' as math;
import 'package:d3/d3.dart';

main() {
  var margin = new Margin(top: 20, right: 20, bottom: 30, left: 40);
  var width = 960 - margin.left - margin.right;
  var height = 500 - margin.top - margin.bottom;

  var x = new LinearScale().domain([-width / 2, width / 2]).range([0, width]);

  var y =
      new LinearScale().domain([-height / 2, height / 2]).range([height, 0]);

  var xAxis = new Axis().scale(x).orient("bottom").tickSize(-height);

  var yAxis = new Axis().scale(y).orient("left").ticks(5).tickSize(-width);

  var zoom = new Zoom().x(x).y(y).scaleExtent([1, 10])
      .center([width / 2, height / 2]).size([width, height]);

  var svg = new Selection("body")
      .append("svg")
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

  zoomed() {
    svg.select(".x.axis").call(xAxis);
    svg.select(".y.axis").call(yAxis);
  }
  zoom.on("zoom", zoomed);

  select("#reset").on("click", () {
    transition().duration(750).tween("zoom", () {
      var ix = interpolate(x.domain(), [-width / 2, width / 2]);
      var iy = interpolate(y.domain(), [-height / 2, height / 2]);
      return (t) {
        zoom.x(x.domain(ix(t))).y(y.domain(iy(t)));
        zoomed();
      };
    });
  });

  coordinates(point) {
    var scale = zoom.scale();
    var translate = zoom.translate();
    return [
      (point[0] - translate[0]) / scale,
      (point[1] - translate[1]) / scale
    ];
  }

  point(coordinates) {
    var scale = zoom.scale(), translate = zoom.translate();
    return [
      coordinates[0] * scale + translate[0],
      coordinates[1] * scale + translate[1]
    ];
  }

  selectAll("button[data-zoom]").on("click", (elem, d, i) {
    svg.call(zoom.event); // https://github.com/mbostock/d3/issues/2387

    // Record the coordinates (in data space) of the center (in screen space).
    var center0 = zoom.center();
    var translate0 = zoom.translate();
    var coordinates0 = coordinates(center0);
    zoom.scale(
        zoom.scale() * math.pow(2, int.parse(elem.getAttribute("data-zoom"))));

    // Translate back to the center.
    var center1 = point(coordinates0);
    zoom.translate([
      translate0[0] + center0[0] - center1[0],
      translate0[1] + center0[1] - center1[1]
    ]);

    svg.transition().duration(750).call(zoom.event);
  });
}
