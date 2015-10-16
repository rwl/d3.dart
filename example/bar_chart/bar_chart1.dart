import 'package:d3/d3.dart';

main() {
  var data = [4, 8, 15, 16, 23, 42];

  var x = linear().domain([0, max(data)]).range([0, 420]);

  select('.chart')
      .selectAll('div')
      .data(data)
      .enter()
      .append("div")
      .style("width", (d) => x(d) + "px")
      .text((d) => d);
}
