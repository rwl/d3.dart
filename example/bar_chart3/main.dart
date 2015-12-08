import 'package:d3/d3.dart' as d3;
import 'package:d3/scale.dart' as scale;
import 'package:d3/svg.dart' as svg_;

main() {
  var margin = new d3.Margin(top: 20, right: 20, bottom: 30, left: 40);
  var width = 960 - margin.left - margin.right;
  var height = 500 - margin.top - margin.bottom;

  var x = scale.ordinal().rangeRoundBands([0, width], 0.1);

  var y = scale.linear().range([height, 0]);

  var xAxis = svg_.axis().scale(x).orient("bottom");

  var yAxis = svg_.axis().scale(y).orient("left").ticks(10, "%");

  var svg = d3
      .select("body")
      .append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .append("g")
      .attr("transform", "translate(${margin.left},${margin.top})");

  d3.tsv("data.tsv", type, (error, data) {
    if (error != null) throw error;

    x.domain(data.map((d) {
      return d['letter'];
    }).toList());
    y.domain([
      0,
      d3.max(data, (d) {
        return d['frequency'];
      })
    ]);

    svg
        .append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0,${height})")
        .call(xAxis);

    svg
        .append("g")
        .attr("class", "y axis")
        .call(yAxis)
        .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("Frequency");

    svg
        .selectAll(".bar")
        .data(data)
        .enter()
        .append("rect")
        .attr("class", "bar")
        .attr("x", (d) {
      return x(d['letter']);
    }).attr("width", x.rangeBand()).attr("y", (d) {
      return y(d['frequency']);
    }).attr("height", (d) {
      return height - y(d['frequency']);
    });
  });
}

type(d) {
  d['frequency'] = double.parse(d['frequency']);
  return d;
}
