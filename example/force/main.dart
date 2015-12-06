import 'dart:math' as Math;
import 'package:d3/d3.dart' as d3;
import 'package:d3/scale.dart' as scale;
import 'package:d3/layout.dart' as layout;

main() {
  var width = 960, height = 500;

  var color = scale.category20();

  layout.Force force =
      layout.force().charge(-120).linkDistance(30).size([width, height]);

  var svg = d3
      .select("body")
      .append("svg")
      .attr("width", width)
      .attr("height", height);

  d3.json("miserables.json", (error, graph) {
    if (error != null) throw error;

    force.nodes(graph.nodes).links(graph.links).start();

    var link = svg
        .selectAll(".link")
        .data(graph.links)
        .enter()
        .append("line")
        .attr("class", "link")
        .style("stroke-width", (d, i, j) {
      return Math.sqrt(d['value']);
    });

    var node = svg
        .selectAll(".node")
        .data(graph.nodes)
        .enter()
        .append("circle")
        .attr("class", "node")
        .attr("r", 5)
        .style("fill", (d, i, j) => color(d['group']))
        .call(force.drag);

    node.append("title").text((d, i, j) => d['name']);

    force.on("tick", (d) {
      link
          .attr("x1", (d, i, j) => d.source['x'])
          .attr("y1", (d, i, j) => d.source['y'])
          .attr("x2", (d, i, j) => d.target['x'])
          .attr("y2", (d, i, j) => d.target['y']);

      node.attr("cx", (d, i, j) => d['x']).attr("cy", (d, i, j) => d['y']);
    });
  });
}