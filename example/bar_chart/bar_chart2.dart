import 'package:d3/scale/scale.dart';
import 'package:d3/arrays/arrays.dart';
import 'package:d3/selection/selection.dart';

main() {

var width = 420,
    barHeight = 20;

var x = new Linear()..range = [0, width];

var chart = select(".chart")
    .attr("width", width);

type(d) {
  d.value = double.parse(d.value); // coerce to number
  return d;
}

tsv("data.tsv", type, (error, data) {
  x.domain = [0, max(data, (d) { return d.value; })];

  chart.attr("height", barHeight * data.length);

  var bar = chart.selectAll("g")
      .data(data)
    .enter().append("g")
      .attr("transform", (n, d, i) { return "translate(0,${i*barHeight})"; });

  bar.append("rect")
      .attr("width", (n, d) { return x(d.value); })
      .attr("height", barHeight - 1);

  bar.append("text")
      .attr("x", (n, d) { return x(d.value) - 3; })
      .attr("y", barHeight / 2)
      .attr("dy", ".35em")
      .text((d) { return d.value; });
});

}