@JS('d3')
library d3.src.math;

import 'package:js/js.dart';

/// generate a random number with a normal distribution.
@JS('random.normal')
external normal([mean, deviation]);

/// generate a random number with a log-normal distribution.
@JS('random.logNormal')
external logNormal([mean, deviation]);

/// generate a random number with a Bates distribution.
@JS('random.bates')
external bates(count);

/// generate a random number with an Irwin–Hall distribution.
@JS('random.irwinHall')
external irwinHall(count);

/// compute the standard form of a 2D matrix transform
external Transform transform(string);

@JS()
class Transform {
  external get rotate;
  external get translate;
  external get skew;
  external get scale;
  external toString();
}
