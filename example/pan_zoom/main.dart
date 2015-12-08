import 'dart:math' as Math;
import 'package:d3/d3.dart' as d3;
import 'package:d3/scale.dart' as scale;
import 'package:d3/behavior.dart' as behavior;
import 'package:d3/svg.dart' as svg_;

main() {
  var margin = new d3.Margin(top: 20, right: 20, bottom: 30, left: 40);
  var width = 960 - margin.left - margin.right;
  var height = 500 - margin.top - margin.bottom;

  d3.LinearScale x =
      scale.linear().domain([-width / 2, width / 2]).range([0, width]);

  d3.LinearScale y =
      scale.linear().domain([-height / 2, height / 2]).range([height, 0]);

  d3.Axis xAxis = svg_.axis().scale(x).orient("bottom").tickSize(-height);

  d3.Axis yAxis = svg_.axis().scale(y).orient("left").ticks(5).tickSize(-width);

  d3.Zoom zoom = behavior.zoom().x(x).y(y).scaleExtent([1, 10])
      .center([width / 2, height / 2]).size([width, height]);

  d3.Selection svg = d3
      .select("body")
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

  d3.select("#reset").on("click", () {
    d3.transition().duration(750).tween("zoom", () {
      var ix = d3.interpolate(x.domain(), [-width / 2, width / 2]);
      var iy = d3.interpolate(y.domain(), [-height / 2, height / 2]);
      return (t) {
        zoom.x(x.domain(ix(t))).y(y.domain(iy(t)));
        zoomed();
      };
    });
  });

  coordinates(point) {
    var scale = zoom.scale(), translate = zoom.translate();
    return [
//      (point != null ? point[0] : 0 - translate[0]) / scale,
//      (point != null ? point[1] : 0 - translate[1]) / scale
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

  d3.selectAll("button[data-zoom]").on("click", (elem, d, i) {
    svg.call(zoom.event); // https://github.com/mbostock/d3/issues/2387

    // Record the coordinates (in data space) of the center (in screen space).
    var center0 = zoom.center();
    var translate0 = zoom.translate();
    var coordinates0 = coordinates(center0);
    zoom.scale(
        zoom.scale() * Math.pow(2, int.parse(elem.getAttribute("data-zoom"))));

    // Translate back to the center.
    var center1 = point(coordinates0);
    zoom.translate([
//      translate0[0] + (center0 != null ? center0[0] : 0) - center1[0],
//      translate0[1] + (center0 != null ? center0[1] : 0) - center1[1]
      translate0[0] + center0[0] - center1[0],
      translate0[1] + center0[1] - center1[1]
    ]);

    svg.transition().duration(750).call(zoom.event);
  });
}
