import 'package:d3/d3.dart';
import 'package:quiver/iterables.dart' show max;

main() {
  var data = [4, 8, 15, 16, 23, 42];

  var x = new LinearScale<num>()
    ..domain = [0, max(data)]
    ..range = [0, 420];

  new Selection('.chart').selectAll('div').setData(data).enter()
    ..append("div")
    ..styleFn["width"] = ((d) => "${x(d)}px")
    ..textFn = (d) => d;
}
