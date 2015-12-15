import 'dart:js';
import 'dart:html' show Event;
import 'package:d3/d3.dart';

main() {
  var width = 960, height = 500;
  bool shiftKey = false;

  var body = new Selection("body")
    ..attr["tabindex"] = "1"
    ..each((elem, _, __) => elem.focus());
  var svg = body.append("svg")
    ..attr["width"] = "$width"
    ..attr["height"] = "$height";

  Selection link = (svg.append("g")..attr["class"] = "link").selectAll("line");

  var brush = svg.append("g")
    ..datumFn = ((_) => {'selected': false, 'previouslySelected': false})
    ..attr["class"] = "brush";

  Selection node =
      (svg.append("g")..attr["class"] = "node").selectAll("circle");

  json("graph.json").then((graph) {
    graph['links'].forEach((d) {
      d['source'] = graph['nodes'][d['source']];
      d['target'] = graph['nodes'][d['target']];
    });

    link = link.data(graph['links']).enter().append("line")
      ..attrFn["x1"] = ((d) => d['source']['x'])
      ..attrFn["y1"] = ((d) => d['source']['y'])
      ..attrFn["x2"] = ((d) => d['target']['x'])
      ..attrFn["y2"] = ((d) => d['target']['y']);

    brush.call(new Brush()
      ..x = (new IdentityScale()..domain = [0, width])
      ..y = (new IdentityScale()..domain = [0, height])
      ..onBrushStart.listen((_) {
        node.eachFn((JsObject d) {
          d['previouslySelected'] = shiftKey && d['selected'];
        });
      })
      ..onBrush.listen((_) {
        List<List> extent = event['target'].callMethod('extent');
        node.classedFn["selected"] = (d) {
          return d['selected'] = d['previouslySelected'] !=
              (extent[0][0] <= d['x'] &&
                  d['x'] < extent[1][0] &&
                  extent[0][1] <= d['y'] &&
                  d['y'] < extent[1][1]);
        };
      })
      ..onBrushEnd.listen((s) {
        event['target'].callMethod('clear');
        new Selection.node(s.elem).call(event['target']);
      }));

    node = node.data(graph['nodes']).enter().append("circle")
      ..attr["r"] = "4"
      ..attrFn["cx"] = ((d) => d['x'])
      ..attrFn["cy"] = ((d) => d['y'])
      ..on("mousedown").listen((s) {
        if (s.data['selected'] == false) {
          // Don't deselect on shift-drag.
          if (!shiftKey) {
            node.classedFn["selected"] = (p) => p['selected'] = s.data == p;
          } else {
            new Selection.node(s.elem).classed["selected"] =
                s.data['selected'] = true;
          }
        }
      })
      ..on("mouseup").listen((s) {
        if (s.data['selected'] == true && shiftKey) {
          new Selection.node(s.elem).classed["selected"] =
              s.data['selected'] = false;
        }
      })
      ..call(new Drag()
        ..onDrag.listen((s) => nudge(node, link, event['dx'], event['dy'])));
  });

  body.on("keydown").listen((_) {
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

  body.on("keyup").listen((_) {
    shiftKey = event.shiftKey || event.metaKey;
  });
}

nudge(Selection node, Selection link, num dx, num dy) {
  node.filterFn((d) => d['selected'])
    ..attrFn["cx"] = ((d) => d['x'] += dx)
    ..attrFn["cy"] = ((d) => d['y'] += dy);

  link.filterFn((d) => d['source']['selected'])
    ..attrFn["x1"] = ((d) => d['source']['x'])
    ..attrFn["y1"] = ((d) => d['source']['y']);

  link.filterFn((d) => d['target']['selected'])
    ..attrFn["x2"] = ((d) => d['target']['x'])
    ..attrFn["y2"] = ((d) => d['target']['y']);

  if (event is Event) {
    event.preventDefault();
  }
}
