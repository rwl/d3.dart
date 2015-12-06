library d3.src.math;

import 'dart:js';

JsObject _d3 = context['d3'];
JsObject _random = context['d3']['random'];

/// Generate a random number with a normal distribution.
normal([mean, deviation]) {
  return _random.callMethod('normal', []);
}

/// Generate a random number with a log-normal distribution.
logNormal([mean, deviation]) {
  return _random.callMethod('logNormal', []);
}

/// Generate a random number with a Bates distribution.
bates(count) {
  return _random.callMethod('bates', []);
}

/// Generate a random number with an Irwin–Hall distribution.
irwinHall(count) {
  return _random.callMethod('irwinHall', []);
}

/// Compute the standard form of a 2D matrix transform
Transform transform(string) {
  return _d3.callMethod('transform', []);
}

class Transform {
  final JsObject _proxy;

  Transform._(this._proxy);

  get rotate {
    return _proxy['rotate'];
  }

  get translate {
    return _proxy['translate'];
  }

  get skew {
    return _proxy['skew'];
  }

  get scale {
    return _proxy['scale'];
  }

  toString() {
    return _proxy.callMethod('toString');
  }
}

/// For internal use.
JsObject getProxy(arg) => arg._proxy;
