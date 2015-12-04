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
      .style("width", (d) => x(d) + "px")
      .text((d) => d);
}
