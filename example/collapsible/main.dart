import 'dart:js';
import 'package:d3/d3.dart';

main() {
  var margin = new Margin(top: 20, right: 120, bottom: 20, left: 120);
  var width = 960 - margin.right - margin.left,
      height = 800 - margin.top - margin.bottom;

  var i = 0, duration = 750;

  Tree tree = new Tree()..size = [height, width];

  var diagonal = new Diagonal()
    ..projectionFn = (JsObject d) => [d['y'], d['x']];

  var svg = (new Selection("body").append("svg")
    ..attr["width"] = "${width + margin.right + margin.left}"
    ..attr["height"] = "${height + margin.top + margin.bottom}").append("g")
    ..attr["transform"] = "translate(${margin.left},${margin.top})";

  update(JsObject root, JsObject source) {
    // Compute the new tree layout.
    JsObject nodes = tree.nodes(root).callMethod('reverse');
    var links = tree.links(nodes);

    // Normalize for fixed-depth.
    (nodes as List).forEach((d) => d['y'] = d['depth'] * 180);

    // Update the nodes...
    var node = svg.selectAll("g.node").setData(nodes as List, (JsObject d) {
      return d.hasProperty('id') ? d['id'] : (d['id'] = ++i);
    });

    // Enter any new nodes at the parent's previous position.
    var nodeEnter = node.enter().append("g")
      ..attr["class"] = "node"
      ..attrFn["transform"] = ((d) =>
          "translate(${source['y0']},${source['x0']})")
      ..on("click").listen((s) {
        JsObject d = s.data;
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

    nodeEnter.append("circle")
      ..attr["r"] = "1e-6"
      ..styleFn["fill"] = (JsObject d) =>
          d.hasProperty('_children') ? "lightsteelblue" : "#fff";

    nodeEnter.append("text")
      ..attrFn["x"] = ((JsObject d) =>
          d.hasProperty('children') || d.hasProperty('_children') ? -10 : 10)
      ..attr["dy"] = ".35em"
      ..attrFn["text-anchor"] = ((JsObject d) => d.hasProperty('children') ||
          d.hasProperty('_children') ? "end" : "start")
      ..textFn = ((d) => d['name'])
      ..style["fill-opacity"] = "1e-6";

    // Transition nodes to their new position.
    var nodeUpdate = node.transition()
      ..duration = duration
      ..attrFn["transform"] = (d) => "translate(${d['y']},${d['x']})";

    nodeUpdate.select("circle")
      ..attr["r"] = "4.5"
      ..styleFn["fill"] = (JsObject d) =>
          d.hasProperty('_children') ? "lightsteelblue" : "#fff";

    nodeUpdate.select("text")..style["fill-opacity"] = "1";

    // Transition exiting nodes to the parent's new position.
    var nodeExit = node.exit().transition()
      ..duration = duration
      ..attrFn["transform"] = ((d) =>
          "translate(${source['y']},${source['x']})")
      ..remove();

    nodeExit.select("circle")..attr["r"] = "1e-6";

    nodeExit.select("text")..style["fill-opacity"] = "1e-6";

    // Update the links...
    var link = svg
        .selectAll("path.link")
        .setData(links as List, (d) => d['target']['id']);

    // Enter any new links at the parent's previous position.
    link.enter().insert("path", "g")
      ..attr["class"] = "link"
      ..attrFn["d"] = (_) {
        var o = {'x': source['x0'], 'y': source['y0']};
        return diagonal({'source': o, 'target': o});
      };

    // Transition links to their new position.
    link.transition()
      ..duration = duration
      ..attr["d"] = diagonal;

    // Transition exiting nodes to the parent's new position.
    link.exit().transition()
      ..duration = duration
      ..attrFn["d"] = ((d) {
        var o = {'x': source['x'], 'y': source['y']};
        return diagonal({'source': o, 'target': o});
      })
      ..remove();

    // Stash the old positions for transition.
    (nodes as List).forEach((JsObject d) {
      d['x0'] = d['x'];
      d['y0'] = d['y'];
    });
  }

  json("flare.json").then((flare) {
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
  }, onError: (err) => throw err);
}
