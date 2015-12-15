import 'dart:math' as Math;
import 'package:d3/js/d3.dart';
import 'package:d3/js/d3.dart' as d3;
import 'package:d3/js/behavior.dart' as behavior;

main() {
  var width = 960, height = 960;

  var projection = d3.mercator().translate([width / 2, height / 2])
      .scale((width - 1) / 2 / Math.PI);

  var zoom = behavior.zoom().scaleExtent([1, 8]);

  var path = d3.path().projection(projection);

  var svg = d3
      .select("body")
      .append("svg")
      .attr("width", width)
      .attr("height", height)
      .append("g");

  var g = svg.append("g");

  svg
      .append("rect")
      .attr("class", "overlay")
      .attr("width", width)
      .attr("height", height);

  svg.call(zoom).call(zoom.event);

  g.append("path").datum({"type": "Sphere"})
      .attr("class", "sphere")
      .attr("d", path);

  d3.json("ne_50m_admin_0_countries_lakes.geojson", (error, world) {
    if (error != null) throw error;

    g.append("path").datum(world).attr("class", "land").attr("d", path);
  });

  d3.json("ne_50m_admin_0_boundary_lines_land.geojson", (error, world) {
    if (error != null) throw error;
    g.append("path").datum(world).attr("class", "boundary").attr("d", path);
  });

  zoom.on("zoom", () {
    var translate = d3.event['translate'];
    g.attr("transform",
        "translate(${translate[0]},${translate[1]})scale(${d3.event['scale']})");
  });
}
