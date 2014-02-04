import 'package:d3/scale/scale.dart';
import 'package:d3/arrays/arrays.dart';
import 'package:d3/selection/selection.dart';

main() {

var data = [4, 8, 15, 16, 23, 42];

var x = new Linear()
    ..domain = [0, max(data)]
    ..range = [0, 420];

select(".chart")
  .selectAll("div")
    .data(data)
  .enter().append("div")
    .style("width", (n, d) { return "${x(d)}px"; })
    .text((n, d) { return d; });

}
