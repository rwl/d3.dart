import 'dart:js';
import 'dart:math' as Math;
import 'package:d3/d3.dart';
import 'package:d3/js/d3.dart' as d3;

main() {
  var diameter = 960;
  var radius = diameter / 2;
  var innerRadius = radius - 120;

  var cluster = new Cluster()
    ..size = [360, innerRadius]
    ..sort = null
    ..value = (d) => d['size'];

  var bundle = new Bundle();

  var line = new RadialLine()
    ..interpolate = "bundle"
    ..tension = .85
    ..radiusFn = ((d) => d['y'])
    ..angleFn = ((d) => d['x'] / 180 * Math.PI);

  var svg = (new Selection("body").append("svg")
    ..attr["width"] = "$diameter"
    ..attr["height"] = "$diameter").append("g")
    ..attr["transform"] = "translate($radius,$radius)";

  var link = svg.append("g").selectAll(".link");
  var node = svg.append("g").selectAll(".node");

  d3.json("readme-flare-imports.json", (error, classes) {
    if (error != null) throw error;

    var hierarchy = packageHierarchy(classes);
    var nodes = cluster.nodes(hierarchy);
    var links = packageImports(nodes);

    link = link.setData(bundle(links)).enter().append("path")
      ..eachFn((d) {
        d['source'] = d[0];
        d['target'] = d[d.length - 1];
      })
      ..attr["class"] = "link"
      ..attrFn["d"] = line;

    node = node
        .setData(nodes
            .where((n) => n['children'] == null || n['children'].length == 0)
            .toList())
        .enter()
        .append("text")
          ..attr["class"] = "node"
          ..attr["dy"] = ".31em"
          ..attrFn["transform"] = ((d) => "rotate(${d['x'] - 90})"
              "translate(${d['y'] + 8},0)"
              "${d['x'] < 180 ? "" : "rotate(180)"}")
          ..styleFn["text-anchor"] = ((d) => d['x'] < 180 ? "start" : "end")
          ..textFn = ((d) => d['key'])
          ..on("mouseover").listen((s) => mouseovered(node, link, s.data))
          ..on("mouseout").listen((s) => mouseouted(node, link, s.data));
  });
}

mouseovered(Selection node, Selection link, d) {
  node.eachFn((n) {
    n['target'] = n['source'] = false;
  });

  link
    ..classedFn["link--target"] = ((l) {
      if (l['target'] == d) return l['source']['source'] = true;
    })
    ..classedFn["link--source"] = ((l) {
      if (l['source'] == d) return l['target']['target'] = true;
    });
  link
      .filterFn((l) => l['target'] == d || l['source'] == d)
      .each((elem, _, __) => elem.parentNode.append(elem));

  node
    ..classedFn["node--target"] = ((n) => n['target'])
    ..classedFn["node--source"] = ((n) => n['source']);
}

mouseouted(Selection node, Selection link, d) {
  link
    ..classed["link--target"] = false
    ..classed["link--source"] = false;

  node
    ..classed["node--target"] = false
    ..classed["node--source"] = false;
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
