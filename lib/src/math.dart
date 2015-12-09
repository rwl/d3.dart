library d3.src.math;

import 'dart:js';
import 'd3.dart';

JsObject _d3 = context['d3'];
JsObject _random = context['d3']['random'];

/// Generate a random number with a normal distribution.
Function normal([num mean = undefinedNum, num deviation = undefinedNum]) {
  var args = [];
  if (mean != undefinedNum) {
    args.add(mean);
  }
  if (deviation != undefinedNum) {
    args.add(deviation);
  }
  return _random.callMethod('normal', args);
}

/// Generate a random number with a log-normal distribution.
Function logNormal([num mean = undefinedNum, num deviation = undefinedNum]) {
  var args = [];
  if (mean != undefinedNum) {
    args.add(mean);
  }
  if (deviation != undefinedNum) {
    args.add(deviation);
  }
  return _random.callMethod('logNormal', args);
}

/// Generate a random number with a Bates distribution.
Function bates(int count) => _random.callMethod('bates', [count]);

/// Generate a random number with an Irwin–Hall distribution.
Function irwinHall(int count) => _random.callMethod('irwinHall', [count]);

/// Compute the standard form of a 2D matrix transform.
Transform transform(String string) {
  return new Transform._(_d3.callMethod('transform', [string]));
}

/// 2D matrix transform
class Transform {
  final JsObject _proxy;

  Transform._(this._proxy);

  factory Transform(String string) => transform(string);

  /// Returns the rotation angle of this transform, in degrees.
  num get rotate => _proxy['rotate'];

  /// Returns the `[dx, dy]` translation of this transform.
  List get translate => _proxy['translate'];

  /// Returns the x-skew of this transform, in degrees.
  num get skew => _proxy['skew'];

  /// Returns the `[kx, ky]` scale of this transform.
  List get scale => _proxy['scale'];

  String toString() => _proxy.callMethod('toString');
}

/// For internal use.
JsObject getProxy(arg) => arg._proxy;
