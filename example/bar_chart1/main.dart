import 'package:d3/d3.dart';

main() {
  var data = [4, 8, 15, 16, 23, 42];

  var x = new LinearScale().domain([0, max(data)]).range([0, 420]);

  new Selection('.chart')
      .selectAll('div')
      .data(data)
      .enter()
      .append("div")
      .style("width", (d) => "${x(d)}px")
      .text((d) => d);
}
