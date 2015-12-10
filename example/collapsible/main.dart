import 'package:d3/js/d3.dart';
import 'package:d3/d3.dart' show Margin;

main() {
  var margin = new Margin(top: 20, right: 120, bottom: 20, left: 120);
  var width = 960 - margin.right - margin.left,
      height = 800 - margin.top - margin.bottom;

  var i = 0, duration = 750;

  Tree tree = new Tree().size([height, width]);

  var diagonal = new Diagonal().projection((d) => [d['y'], d['x']]);

  var svg = new Selection("body")
      .append("svg")
      .attr("width", width + margin.right + margin.left)
      .attr("height", height + margin.top + margin.bottom)
      .append("g")
      .attr("transform", "translate(${margin.left},${margin.top})");

//  select(window.frameElement).style("height", "800px");

  update(root, source) {
    // Compute the new tree layout.
    var nodes = tree.nodes(root).callMethod('reverse');
    var links = tree.links(nodes);

    // Normalize for fixed-depth.
    nodes.forEach((d) {
      d['y'] = d['depth'] * 180;
    });

    // Update the nodes...
    var node = svg.selectAll("g.node").data(nodes, (d) {
      return d['id'] != null ? d['id'] : (d['id'] = ++i);
    });

    // Enter any new nodes at the parent's previous position.
    var nodeEnter = node
        .enter()
        .append("g")
        .attr("class", "node")
        .attr("transform", (d) => "translate(${source['y0']},${source['x0']})")
        .on("click", (d) {
      // Toggle children on click.
      if (d['children'] != null) {
        d['_children'] = d['children'];
        d['children'] = null;
      } else {
        d['children'] = d['_children'];
        d['_children'] = null;
      }
      update(root, d);
    });

    nodeEnter.append("circle").attr("r", 1e-6).style(
        "fill", (d) => d['_children'] != null ? "lightsteelblue" : "#fff");

    nodeEnter
        .append("text")
        .attr("x",
            (d) => d['children'] != null || d['_children'] != null ? -10 : 10)
        .attr("dy", ".35em")
        .attr(
            "text-anchor",
            (d) => d['children'] != null || d['_children'] != null
                ? "end"
                : "start")
        .text((d) => d['name'])
        .style("fill-opacity", 1e-6);

    // Transition nodes to their new position.
    var nodeUpdate = node
        .transition()
        .duration(duration)
        .attr("transform", (d) => "translate(${d['y']},${d['x']})");

    nodeUpdate.select("circle").attr("r", 4.5).style(
        "fill", (d) => d['_children'] != null ? "lightsteelblue" : "#fff");

    nodeUpdate.select("text").style("fill-opacity", 1);

    // Transition exiting nodes to the parent's new position.
    var nodeExit = node
        .exit()
        .transition()
        .duration(duration)
        .attr("transform", (d) => "translate(${source['y']},${source['x']})")
        .remove();

    nodeExit.select("circle").attr("r", 1e-6);

    nodeExit.select("text").style("fill-opacity", 1e-6);

    // Update the links...
    var link = svg.selectAll("path.link").data(links, (d) => d['target']['id']);

    // Enter any new links at the parent's previous position.
    link.enter().insert("path", "g").attr("class", "link").attr("d", (d) {
      var o = {'x': source['x0'], 'y': source['y0']};
      return diagonal({'source': o, 'target': o});
    });

    // Transition links to their new position.
    link.transition().duration(duration).attr("d", diagonal);

    // Transition exiting nodes to the parent's new position.
    link.exit().transition().duration(duration).attr("d", (d) {
      var o = {'x': source['x'], 'y': source['y']};
      return diagonal({'source': o, 'target': o});
    }).remove();

    // Stash the old positions for transition.
    nodes.forEach((d) {
      d['x0'] = d['x'];
      d['y0'] = d['y'];
    });
  }

  new Xhr.json("flare.json", (error, flare) {
    if (error != null) throw error;

    var root = flare;
    root['x0'] = height / 2;
    root['y0'] = 0;

    collapse(d) {
      if (d['children'] != null) {
        d['_children'] = d['children'];
        d['_children'].forEach(collapse);
        d['children'] = null;
      }
    }

    root['children'].forEach(collapse);
    update(root, root);
  });
}
