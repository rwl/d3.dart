import 'dart:math' as Math;
import 'package:d3/js/d3.dart';
import 'package:d3/js/d3.dart' as d3;
import 'package:d3/js/layout.dart' as layout;

main() {
  var outerRadius = 960 / 2;
  var innerRadius = outerRadius - 130;

  var fill = category20c();

  var chord = layout
      .chord()
      .padding(0.04)
      .sortSubgroups(descending)
      .sortChords(descending);

  var arc = d3.arc().innerRadius(innerRadius).outerRadius(innerRadius + 20);

  var svg = select("body")
      .append("svg")
      .attr("width", outerRadius * 2)
      .attr("height", outerRadius * 2)
      .append("g")
      .attr("transform", "translate($outerRadius,$outerRadius)");

  d3.json("readme.json", (error, imports) {
    if (error != null) throw error;

    var indexByName = d3.map();
    var nameByIndex = d3.map();
    var matrix = [], n = 0;

    // Returns the Flare package name for the given class name.
    name(name) {
      return name.substring(0, name.lastIndexOf(".")).substring(6);
    }

    // Compute a unique index for each package name.
    imports.forEach((d) {
      if (!indexByName.has(d = name(d['name']))) {
        nameByIndex.set(n, d);
        indexByName.set(d, n++);
      }
    });

    // Construct a square matrix counting package imports.
    imports.forEach((d) {
      var source = indexByName.get(name(d['name']));
      var row;
      if (source >= matrix.length) {
        row = [];
        matrix.add(row);
        for (var i = -1; ++i < n;) row.add(0);
      } else {
        row = matrix[source];
      }
      d['imports'].forEach((d) {
        row[indexByName.get(name(d))]++;
      });
    });

    chord.matrix(matrix);

    var g = svg
        .selectAll(".group")
        .data(chord.groups)
        .enter()
        .append("g")
        .attr("class", "group");

    g
        .append("path")
        .style("stroke", (d) => fill(d['index']))
        .style("fill", (d) => fill(d['index']))
        .attr("d", arc);

    g.append("text").each((d) {
      d['angle'] = (d['startAngle'] + d['endAngle']) / 2;
    }).attr("dy", ".35em").attr("transform", (d) {
      return "rotate(${d['angle'] * 180 / Math.PI - 90})"
          "translate(${innerRadius + 26})"
          "${d['angle'] > Math.PI ? "rotate(180)" : ""}";
    })
        .style("text-anchor", (d) => d['angle'] > Math.PI ? "end" : null)
        .text((d) => nameByIndex.get(d['index']));

    svg
        .selectAll(".chord")
        .data(chord.chords)
        .enter()
        .append("path")
        .attr("class", "chord")
        .style("stroke", (d) => d3.rgb(fill(d['source']['index'])).darker())
        .style("fill", (d) => fill(d['source']['index']))
        .attr("d", d3.chord().radius(innerRadius));
  });
}
