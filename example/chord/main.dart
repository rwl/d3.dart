import 'dart:js';
import 'dart:math' as Math;
import 'package:d3/d3.dart';

main() {
  var outerRadius = 960 / 2;
  var innerRadius = outerRadius - 130;

  var fill = new OrdinalScale.category20c();

  var chord = new ChordLayout()
    ..padding = 0.04
    ..sortSubgroups = descending
    ..sortChords = descending;

  var arc = new Arc()
    ..innerRadius = innerRadius
    ..outerRadius = innerRadius + 20;

  var svg = (new Selection("body").append("svg")
    ..attr["width"] = "${outerRadius * 2}"
    ..attr["height"] = "${outerRadius * 2}").append("g")
    ..attr["transform"] = "translate($outerRadius,$outerRadius)";

  json("readme.json").then((imports) {
    var indexByName = <String, int>{};
    var nameByIndex = <int, String>{};
    var matrix = [], n = 0;

    // Returns the Flare package name for the given class name.
    String name(String name) {
      return name.substring(0, name.lastIndexOf(".")).substring(6);
    }

    // Compute a unique index for each package name.
    (imports as List).forEach((d) {
      if (!indexByName.containsKey(d = name(d['name']))) {
        nameByIndex[n] = d;
        indexByName[d] = n++;
      }
    });

    // Construct a square matrix counting package imports.
    imports.forEach((JsObject d) {
      var source = indexByName[name(d['name'])];
      List row;
      if (source >= matrix.length) {
        matrix.add(row = new List.generate(n, (_) => 0));
      } else {
        row = matrix[source];
      }
      d['imports'].forEach((String d) {
        row[indexByName[name(d)]]++;
      });
    });

    chord.matrix = matrix;

    var g = svg.selectAll(".group").setDataFn(chord.groups).enter().append("g")
      ..attr["class"] = "group";

    g.append("path")
      ..styleFn["stroke"] = ((JsObject d) => fill(d['index']))
      ..styleFn["fill"] = ((JsObject d) => fill(d['index']))
      ..attrFn["d"] = arc;

    g.append("text")
      ..eachFn((d) {
        d['angle'] = (d['startAngle'] + d['endAngle']) / 2;
      })
      ..attr["dy"] = ".35em"
      ..attrFn["transform"] = ((d) {
        return "rotate(${d['angle'] * 180 / Math.PI - 90})"
            "translate(${innerRadius + 26})"
            "${d['angle'] > Math.PI ? "rotate(180)" : ""}";
      })
      ..styleFn["text-anchor"] = ((d) => d['angle'] > Math.PI ? "end" : null)
      ..textFn = ((d) => nameByIndex[d['index']]);

    svg.selectAll(".chord").setDataFn(chord.chords).enter().append("path")
      ..attr["class"] = "chord"
      ..styleFn["stroke"] = ((JsObject d) =>
          new Rgb.parse(fill(d['source']['index'])).darker())
      ..styleFn["fill"] = ((JsObject d) => fill(d['source']['index']))
      ..attrFn["d"] = (new Chord()..radius = innerRadius);
  }, onError: (err) => throw err);
}
