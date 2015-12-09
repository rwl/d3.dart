import 'package:d3/js/d3.dart';

main() {
  var margin = new Margin(top: 20, right: 20, bottom: 30, left: 40);
  var width = 960 - margin.left - margin.right;
  var height = 500 - margin.top - margin.bottom;

  var x = new Ordinal().rangeRoundBands([0, width], 0.1);

  var y = new LinearScale().range([height, 0]);

  var xAxis = new Axis().scale(x).orient("bottom");

  var yAxis = new Axis().scale(y).orient("left").ticks(10, "%");

  var svg = new Selection("body")
      .append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .append("g")
      .attr("transform", "translate(${margin.left},${margin.top})");

  new Xhr.tsv("data.tsv", type, (error, data) {
    if (error != null) throw error;

    x.domain(data.map((d) {
      return d['letter'];
    }).toList());
    y.domain([
      0,
      max(data, (d) {
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
        .attr("x", (d) => x(d['letter']))
        .attr("width", x.rangeBand())
        .attr("y", (d) => y(d['frequency']))
        .attr("height", (d) => height - y(d['frequency']));
  });
}

type(d) {
  d['frequency'] = double.parse(d['frequency']);
  return d;
}
