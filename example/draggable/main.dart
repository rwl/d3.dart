import 'package:d3/js/d3.dart';

main() {
  var width = 960, height = 500;
  bool shiftKey;

  var svg = new Selection("body").attr("tabindex", 1).each((elem, d, i) {
    elem.focus();
  }).append("svg").attr("width", width).attr("height", height);

  var link = svg.append("g").attr("class", "link").selectAll("line");

  var brush = svg.append("g").datum(() {
    return {'selected': false, 'previouslySelected': false};
  }).attr("class", "brush");

  var node = svg.append("g").attr("class", "node").selectAll("circle");

  new Xhr.json("graph.json", (error, graph) {
    graph['links'].forEach((d) {
      d['source'] = graph['nodes'][d['source']];
      d['target'] = graph['nodes'][d['target']];
    });

    link = link
        .data(graph['links'])
        .enter()
        .append("line")
        .attr("x1", (d) => d['source']['x'])
        .attr("y1", (d) => d['source']['y'])
        .attr("x2", (d) => d['target']['x'])
        .attr("y2", (d) => d['target']['y']);

    brush.call(new Brush()
        .x(new IdentityScale().domain([0, width]))
        .y(new IdentityScale().domain([0, height]))
        .on("brushstart", (d) {
      node.each((d) {
        d.previouslySelected = shiftKey && d.selected;
      });
    }).on("brush", () {
      var extent = event.target.extent();
      node.classed("selected", (d) {
        return d.selected = d.previouslySelected ^
            (extent[0][0] <= d.x &&
                d.x < extent[1][0] &&
                extent[0][1] <= d.y &&
                d.y < extent[1][1]);
      });
    }).on("brushend", (elem, d, i) {
      event.target.clear();
      select(elem).call(event.target);
    }));

    node = node
        .data(graph['nodes'])
        .enter()
        .append("circle")
        .attr("r", 4)
        .attr("cx", (d) => d['x'])
        .attr("cy", (d) => d['y'])
        .on("mousedown", (elem, d, i) {
      if (!d.selected) {
        // Don't deselect on shift-drag.
        if (!shiftKey) {
          node.classed("selected", (p) => p.selected = d == p);
        } else {
          select(elem).classed("selected", d.selected = true);
        }
      }
    }).on("mouseup", (elem, d, i) {
      if (d.selected && shiftKey) {
        select(elem).classed("selected", d.selected = false);
      }
    }).call(new Drag()
            .on("drag", (d) => nudge(node, link, event.dx, event.dy)));
  });

  svg.on("keydown.brush", () {
    if (!event.metaKey) {
      switch (event.keyCode) {
        case 38:
          nudge(node, link, 0, -1);
          break; // UP
        case 40:
          nudge(node, link, 0, 1);
          break; // DOWN
        case 37:
          nudge(node, link, -1, 0);
          break; // LEFT
        case 39:
          nudge(node, link, 1, 0);
          break; // RIGHT
      }
    }
    shiftKey = event.shiftKey || event.metaKey;
  });

  svg.on("keyup.brush", () {
    shiftKey = event.shiftKey || event.metaKey;
  });
}

nudge(node, link, dx, dy) {
  node
      .filter((d) => d.selected)
      .attr("cx", (d) => d.x += dx)
      .attr("cy", (d) => d.y += dy);

  link
      .filter((d) => d.source.selected)
      .attr("x1", (d) => d.source.x)
      .attr("y1", (d) => d.source.y);

  link
      .filter((d) => d.target.selected)
      .attr("x2", (d) => d.target.x)
      .attr("y2", (d) => d.target.y);

  event.preventDefault();
}
