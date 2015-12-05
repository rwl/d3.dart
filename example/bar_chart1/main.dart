import 'package:js/js.dart';
import 'package:d3/d3.dart' as d3;

main() {
  var data = [4, 8, 15, 16, 23, 42];

  var x = d3.linear().domain([0, d3.max(data)]).range([0, 420]);

  d3
      .select('.chart')
      .selectAll('div')
      .data(data)
      .enter()
      .append("div")
      .style("width", allowInterop((d, i, j) => "${x(d)}px"))
      .text(allowInterop((d, i, j) => d));
}
