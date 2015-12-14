import 'dart:js';
import 'dart:math' as Math;
import 'package:d3/js/d3.dart';
import 'package:d3/js/d3.dart' as d3;
import 'package:d3/js/layout.dart' as layout;

main() {
  var diameter = 960;
  var radius = diameter / 2;
  var innerRadius = radius - 120;

  Cluster cluster = layout.cluster().size([360, innerRadius])
      .sort(null)
      .value((d) => d['size']);

  var bundle = layout.bundle();

  var line = d3
      .radial()
      .interpolate("bundle")
      .tension(.85)
      .radius((d) => d['y'])
      .angle((d) => d['x'] / 180 * Math.PI);

  var svg = d3
      .select("body")
      .append("svg")
      .attr("width", diameter)
      .attr("height", diameter)
      .append("g")
      .attr("transform", "translate($radius,$radius)");

  var link = svg.append("g").selectAll(".link");
  var node = svg.append("g").selectAll(".node");

  d3.json("readme-flare-imports.json", (error, classes) {
    if (error != null) throw error;

    var hierarchy = packageHierarchy(classes);
    var nodes = cluster.nodes(hierarchy);
    var links = packageImports(nodes);

    link = link.data(bundle(links)).enter().append("path").each((d) {
      d['source'] = d[0];
      d['target'] = d[d.length - 1];
    }).attr("class", "link").attr("d", line);

    node = node
        .data(nodes
            .where((n) => n['children'] == null || n['children'].length == 0)
            .toList())
        .enter()
        .append("text")
        .attr("class", "node")
        .attr("dy", ".31em")
        .attr(
            "transform",
            (d) => "rotate(${d['x'] - 90})"
                "translate(${d['y'] + 8},0)"
                "${d['x'] < 180 ? "" : "rotate(180)"}")
        .style("text-anchor", (d) => d['x'] < 180 ? "start" : "end")
        .text((d) => d['key'])
        .on("mouseover", (d) => mouseovered(node, link, d))
        .on("mouseout", (d) => mouseouted(node, link, d));
  });
}

mouseovered(node, link, d) {
  node.each((n) {
    n['target'] = n['source'] = false;
  });

  link.classed("link--target", (l) {
    if (l['target'] == d) return l['source']['source'] = true;
  }).classed("link--source", (l) {
    if (l['source'] == d) return l['target']['target'] = true;
  }).filter((l) {
    return l['target'] == d || l['source'] == d;
  }).each((elem, _, __) {
    elem.parentNode.append(elem);
  });

  node
      .classed("node--target", (n) => n['target'])
      .classed("node--source", (n) => n['source']);
}

mouseouted(node, link, d) {
  link.classed("link--target", false).classed("link--source", false);

  node.classed("node--target", false).classed("node--source", false);
}

// Lazily construct the package hierarchy from class names.
packageHierarchy(classes) {
  var map = new JsObject.jsify({});

  find(name, data) {
    var i, node = map[name];
    if (node == null) {
      node = map[name] =
          (data ?? new JsObject.jsify({"name": name, "children": []}));
      if (name.length != 0) {
        i = name.lastIndexOf(".");
        node['parent'] = find(name.substring(0, i < 0 ? 0 : i), null);
        node['parent']['children'].add(node);
        node['key'] = name.substring(i + 1);
      }
    }
    return node;
  }

  classes.forEach((d) => find(d['name'], d));

  return map[""];
}

// Return a list of imports for the given array of nodes.
packageImports(nodes) {
  var map = new JsObject.jsify({});
  var imports = [];

  // Compute a map from name to node.
  nodes.forEach((d) {
    map[d['name']] = d;
  });

  // For each import, construct a link from the source to target node.
  nodes.forEach((d) {
    if (d['imports'] != null) {
      d['imports'].forEach((i) {
        imports.add({"source": map[d['name']], "target": map[i]});
      });
    }
  });

  return imports;
}
