import 'package:d3/scale/scale.dart';
import 'package:d3/arrays/arrays.dart';
import 'package:d3/selection/selection.dart';
import 'package:d3/dsv/dsv.dart';

main() {

var width = 420,
    barHeight = 20;

var x = new Linear()
  ..range = [0, width];

var chart = new Selection.selector(".chart")
  ..attr("width", width);

Map<String, Object> type(Map<String, String> d, int i) {
  var dd = new Map.from(d);
  dd['value'] = double.parse(dd['value']); // coerce to number
  return dd;
}

tsv("data.tsv", row:type, callback: (final List<Map<String, Object>> data) {
  x.domain = [0, max(data, (d) { return d['value']; })];

  chart.attr("height", barHeight * data.length);

  var bar = chart.selectAll("g")
    .data(data)
    .enter()
    .append("g")
    ..attrFunc("transform", (n, d, i, j) {
      return "translate(0,${i*barHeight})";
    });

  bar.append("rect")
      ..attrFunc("width", (n, d, i, j) {
        return x(d['value']);
      })
      ..attr("height", barHeight - 1);

  bar.append("text")
      ..attrFunc("x", (n, d, i, j) { return x(d['value']) - 3; })
      ..attr("y", barHeight / 2)
      ..attr("dy", ".35em")
      ..textFunc((n, d, i, j) { return d['value']; });
});

}
