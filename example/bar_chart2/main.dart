import 'package:d3/d3.dart';
import 'package:quiver/iterables.dart' show max;

main() {
  var width = 420, barHeight = 20;

  var x = new LinearScale<num>()..range = [0, width];

  var chart = new Selection(".chart")..attr["width"] = "$width";

  tsv("data.tsv", type).then((List data) {
    x.domain = [0, max(data.map((d) => d['value']))];

    chart.attr["height"] = "${barHeight * data.length}";

    var bar = chart.selectAll("g").setData(data).enter().append("g")
      ..attrFn["transform"] = (_, int i) => "translate(0,${i * barHeight})";

    bar.append("rect")
      ..attrFn["width"] = ((d) => x(d['value']))
      ..attr["height"] = "${barHeight - 1}";

    bar.append("text")
      ..attrFn["x"] = ((d) => x(d['value']) - 3)
      ..attr["y"] = "${barHeight / 2}"
      ..attr["dy"] = ".35em"
      ..textFn = (d) => d['value'];
  });
}

type(d) {
  d['value'] = double.parse(d['value']);
  return d;
}
