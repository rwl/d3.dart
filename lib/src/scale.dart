//@Js('d3.scale')
library d3.scale;

import 'package:js/js.dart';

@Js('d3.scale.linear')
external LinearScale linear();

@Js()
class LinearScale {
  external LinearScale domain([numbers]);
  external LinearScale range([values]);
}
