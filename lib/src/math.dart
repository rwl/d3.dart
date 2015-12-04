@JS('d3')
library d3.src.math;

import 'package:js/js.dart';

@JS('random.normal')
external normal([mean, deviation]);

@JS('random.logNormal')
external logNormal([mean, deviation]);

@JS('random.bates')
external bates(count);

@JS('random.irwinHall')
external irwinHall(count);

external Transform transform(string);

class Transform {
  external get rotate;
  external get translate;
  external get skew;
  external get scale;
  external toString();
}
