library d3.src.js.scale;

import 'dart:js';
import 'd3.dart';

JsObject _scale = context['d3']['scale'];

/// Construct a linear quantitative scale.
LinearScale linear() => new LinearScale._(_scale.callMethod('linear'));

class LinearScale {
  final JsObject _proxy;

  LinearScale._(this._proxy);

  factory LinearScale() => linear();

  /// Get the range value corresponding to a given domain value.
  call(x) => _proxy.callMethod('call', [_proxy, x]);

  /// Get the domain value corresponding to a given range value.
  invert(y) => _proxy.callMethod('invert', [y]);

  /// Get or set the scale's input domain.
  domain([/*List<num>*/ numbers = undefined]) {
    var args = [];
    if (numbers is JsObject) {
      args.add(numbers);
    } else if (numbers != undefined) {
      args.add(new JsObject.jsify(numbers));
    }
    var retval = _proxy.callMethod('domain', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new LinearScale._(retval);
    }
  }

  /// Get or set the scale's output range.
  range([/*List*/ values = undefined]) {
    var args = [];
    if (values != undefined) {
      args.add(new JsObject.jsify(values));
    }
    var retval = _proxy.callMethod('range', args);
    if (values == undefined) {
      return retval;
    } else {
      return new LinearScale._(retval);
    }
  }

  /// Set the scale's output range, and enable rounding.
  LinearScale rangeRound(List values) {
    return new LinearScale._(
        _proxy.callMethod('rangeRound', [new JsObject.jsify(values)]));
  }

  /// Get or set the scale's output interpolator.
  interpolate([/*Function*/ factory = undefined]) {
    var args = [];
    if (factory != undefined) {
      args.add(factory);
    }
    var retval = _proxy.callMethod('interpolate', args);
    if (factory == undefined) {
      return retval;
    } else {
      return new LinearScale._(retval);
    }
  }

  /// Enable or disable clamping of the output range.
  clamp([/*bool*/ boolean = undefined]) {
    var args = [];
    if (boolean != undefined) {
      args.add(boolean);
    }
    var retval = _proxy.callMethod('clamp', args);
    if (boolean == undefined) {
      return retval;
    } else {
      return new LinearScale._(retval);
    }
  }

  /// Extend the scale domain to nice round numbers.
  LinearScale nice([/*int*/ count = undefined]) {
    var args = [];
    if (count != undefined) {
      args.add(count);
    }
    return new LinearScale._(_proxy.callMethod('nice', args));
  }

  /// Get representative values from the input domain.
  LinearScale ticks([int count = 10]) {
    return new LinearScale._(_proxy.callMethod('ticks', [count]));
  }

  /// Get a formatter for displaying tick values.
  LinearScale tickFormat(int count, [/*String*/ format = undefined]) {
    var args = [count];
    if (format != undefined) {
      args.add(format);
    }
    return new LinearScale._(_proxy.callMethod('tickFormat', args));
  }

  /// Create a new scale from an existing scale.
  copy() => new LinearScale._(_proxy.callMethod('copy'));
}

/// Construct a linear identity scale.
IdentityScale identity() {
  return new IdentityScale._(_scale.callMethod('identity'));
}

class IdentityScale {
  final JsObject _proxy;

  IdentityScale._(this._proxy);

  factory IdentityScale() => identity();

  /// The identity function.
  call(x) => _proxy.callMethod('call', [_proxy, x]);

  /// Equivalent to identity; the identity function.
  invert(x) => _proxy.callMethod('invert', [x]);

  /// Get or set the scale's domain and range.
  domain([/*List<num>*/ numbers = undefined]) {
    var args = [];
    if (numbers != undefined) {
      args.add(new JsObject.jsify(numbers));
    }
    var retval = _proxy.callMethod('domain', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new IdentityScale._(retval);
    }
  }

  /// Equivalent to identity.domain.
  range([/*List<num>*/ numbers = undefined]) {
    var args = [];
    if (numbers != undefined) {
      args.add(new JsObject.jsify(numbers));
    }
    var retval = _proxy.callMethod('range', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new IdentityScale._(retval);
    }
  }

  /// Get representative values from the domain.
  ticks([int count = 10]) {
    return new IdentityScale._(_proxy.callMethod('ticks', [count]));
  }

  /// Get a formatter for displaying tick values.
  tickFormat(int count, [/*String*/ format = undefined]) {
    var args = [count];
    if (format != undefined) {
      args.add(format);
    }
    return new IdentityScale._(_proxy.callMethod('tickFormat', args));
  }

  /// Create a new scale from an existing scale.
  copy() => new IdentityScale._(_proxy.callMethod('copy'));
}

/// Construct a quantitative scale with a square root transform.
Pow sqrt() => new Pow._(_scale.callMethod('sqrt'));

/// Construct a quantitative scale with an exponential transform.
Pow pow() => new Pow._(_scale.callMethod('pow'));

class Pow {
  final JsObject _proxy;

  Pow._(this._proxy);

  factory Pow() => pow();

  factory Pow.sqrt() => sqrt();

  /// Get the range value corresponding to a given domain value.
  call(x) => _proxy.callMethod('call', [_proxy, x]);

  /// Get the domain value corresponding to a given range value.
  invert(y) => _proxy.callMethod('invert', [y]);

  /// Get or set the scale's input domain.
  domain([/*List<num>*/ numbers = undefined]) {
    var args = [];
    if (numbers != undefined) {
      args.add(new JsObject.jsify(numbers));
    }
    var retval = _proxy.callMethod('domain', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new Pow._(retval);
    }
  }

  /// Get or set the scale's output range.
  range([/*List<num>*/ numbers = undefined]) {
    var args = [];
    if (numbers != undefined) {
      args.add(new JsObject.jsify(numbers));
    }
    var retval = _proxy.callMethod('range', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new Pow._(retval);
    }
  }

  /// Set the scale's output range, and enable rounding.
  Pow rangeRound(List values) {
    return new Pow._(
        _proxy.callMethod('rangeRound', [new JsObject.jsify(values)]));
  }

  /// Get or set the exponent power.
  exponent([/*num*/ k = undefined]) {
    var args = [];
    if (k != undefined) {
      args.add(k);
    }
    var retval = _proxy.callMethod('exponent', args);
    if (k == undefined) {
      return retval;
    } else {
      return new Pow._(retval);
    }
  }

  /// Get or set the scale's output interpolator.
  interpolate([/*Function*/ factory = undefined]) {
    var args = [];
    if (factory != undefined) {
      args.add(factory);
    }
    var retval = _proxy.callMethod('interpolate', args);
    if (factory == undefined) {
      return retval;
    } else {
      return new Pow._(retval);
    }
  }

  /// Enable or disable clamping of the output range.
  clamp([/*bool*/ boolean = undefined]) {
    var args = [];
    if (boolean != undefined) {
      args.add(boolean);
    }
    var retval = _proxy.callMethod('clamp', args);
    if (boolean == undefined) {
      return retval;
    } else {
      return new Pow._(retval);
    }
  }

  /// Extend the scale domain to nice round numbers.
  Pow nice([/*int*/ m = undefined]) {
    var args = [];
    if (m != undefined) {
      args.add(m);
    }
    return new Pow._(_proxy.callMethod('nice', args));
  }

  /// Get representative values from the input domain.
  Pow ticks([int count = 10]) {
    return new Pow._(_proxy.callMethod('ticks', [count]));
  }

  /// Get a formatter for displaying tick values.
  Pow tickFormat(int count, [/*String*/ format = undefined]) {
    var args = [count];
    if (format != undefined) {
      args.add(format);
    }
    return new Pow._(_proxy.callMethod('tickFormat', args));
  }

  /// Create a new scale from an existing scale.
  Pow copy() => new Pow._(_proxy.callMethod('copy'));
}

/// Construct a quantitative scale with an logarithmic transform.
Log log() => new Log._(_scale.callMethod('log'));

class Log {
  final JsObject _proxy;

  Log._(this._proxy);

  factory Log() => log();

  /// Get the range value corresponding to a given domain value.
  call(x) => _proxy.callMethod('call', [_proxy, x]);

  /// Get the domain value corresponding to a given range value.
  invert(y) => _proxy.callMethod('invert', [y]);

  /// Get or set the scale's input domain.
  domain([/*List<num>*/ numbers = undefined]) {
    var args = [];
    if (numbers != undefined) {
      args.add(new JsObject.jsify(numbers));
    }
    var retval = _proxy.callMethod('domain', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new Log._(retval);
    }
  }

  /// Get or set the scale's output range.
  range([/*List<num>*/ numbers = undefined]) {
    var args = [];
    if (numbers != undefined) {
      args.add(new JsObject.jsify(numbers));
    }
    var retval = _proxy.callMethod('range', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new Log._(retval);
    }
  }

  /// Set the scale's output range, and enable rounding.
  Log rangeRound(List values) {
    return new Log._(
        _proxy.callMethod('rangeRound', [new JsObject.jsify(values)]));
  }

  base([/*num*/ k = undefined]) {
    var args = [];
    if (k != undefined) {
      args.add(k);
    }
    var retval = _proxy.callMethod('base', args);
    if (k == undefined) {
      return retval;
    } else {
      return new Log._(retval);
    }
  }

  /// Get or set the scale's output interpolator.
  interpolate([/*Function*/ factory = undefined]) {
    var args = [];
    if (factory != undefined) {
      args.add(factory);
    }
    var retval = _proxy.callMethod('interpolate', args);
    if (factory == undefined) {
      return retval;
    } else {
      return new Log._(retval);
    }
  }

  /// Enable or disable clamping of the output range.
  clamp([/*bool*/ boolean = undefined]) {
    var args = [];
    if (boolean != undefined) {
      args.add(boolean);
    }
    var retval = _proxy.callMethod('clamp', args);
    if (boolean == undefined) {
      return retval;
    } else {
      return new Log._(retval);
    }
  }

  /// Extend the scale domain to nice powers of ten.
  Log nice() => new Log._(_proxy.callMethod('nice'));

  /// Get representative values from the input domain.
  ticks() => _proxy.callMethod('ticks');

  /// Get a formatter for displaying tick values.
  Log tickFormat([/*int*/ count = undefined, /*String*/ format = undefined]) {
    var args = [];
    if (count != undefined) {
      args.add(count);
    }
    if (format != undefined) {
      args.add(format);
    }
    return new Log._(_proxy.callMethod('tickFormat', args));
  }

  /// Create a new scale from an existing scale.
  Log copy() => new Log._(_proxy.callMethod('copy'));
}

/// Construct a linear quantitative scale with a discrete output range.
Quantize quantize() => new Quantize._(_scale.callMethod('quantize'));

class Quantize {
  final JsObject _proxy;

  Quantize._(this._proxy);

  factory Quantize() => quantize();

  /// Get the range value corresponding to a given domain value.
  call(x) => _proxy.callMethod('call', [_proxy, x]);

  /// Get the domain values for the specified range value.
  List invertExtent(y) => _proxy.callMethod('invertExtent', [y]);

  /// Get or set the scale's input domain.
  domain([/*List<num>*/ numbers = undefined]) {
    var args = [];
    if (numbers != undefined) {
      args.add(new JsObject.jsify(numbers));
    }
    var retval = _proxy.callMethod('domain', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new Quantize._(retval);
    }
  }

  /// Get or set the scale's output range (as discrete values).
  range([/*List<num>*/ numbers = undefined]) {
    var args = [];
    if (numbers != undefined) {
      args.add(new JsObject.jsify(numbers));
    }
    var retval = _proxy.callMethod('range', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new Quantize._(retval);
    }
  }

  /// Create a new scale from an existing scale.
  Quantize copy() => new Quantize._(_proxy.callMethod('copy'));
}

/// Construct a quantitative scale mapping to quantiles.
Quantile quantile() => new Quantile._(_scale.callMethod('quantile'));

class Quantile {
  final JsObject _proxy;

  Quantile._(this._proxy);

  factory Quantile() => quantile();

  /// Get the range value corresponding to a given domain value.
  call(x) => _proxy.callMethod('call', [_proxy, x]);

  /// Get the domain values for the specified range value.
  List invertExtent(y) => _proxy.callMethod('invertExtent', [y]);

  /// Get or set the scale's input domain (as discrete values).
  domain([/*List<num>*/ numbers = undefined]) {
    var args = [];
    if (numbers != undefined) {
      args.add(new JsObject.jsify(numbers));
    }
    var retval = _proxy.callMethod('domain', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new Quantile._(retval);
    }
  }

  /// Get or set the scale's output range (as discrete values).
  range([/*List<num>*/ numbers = undefined]) {
    var args = [];
    if (numbers != undefined) {
      args.add(new JsObject.jsify(numbers));
    }
    var retval = _proxy.callMethod('range', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new Quantile._(retval);
    }
  }

  /// Get the scale's quantile bin thresholds.
  List quantiles() => _proxy.callMethod('quantiles');

  /// Create a new scale from an existing scale.
  Quantile copy() => new Quantile._(_proxy.callMethod('copy'));
}

/// Construct a threshold scale with a discrete output range.
Threshold threshold() => new Threshold._(_scale.callMethod('threshold'));

class Threshold {
  final JsObject _proxy;

  Threshold._(this._proxy);

  factory Threshold() => threshold();

  /// Get the range value corresponding to a given domain value.
  call(x) => _proxy.callMethod('threshold', [_proxy, x]);

  /// Get the domain values for the specified range value.
  List invertExtent(y) => _proxy.callMethod('invertExtent', [y]);

  /// Get or set the scale's input domain.
  domain([/*List<num>*/ numbers = undefined]) {
    var args = [];
    if (numbers != undefined) {
      args.add(new JsObject.jsify(numbers));
    }
    var retval = _proxy.callMethod('domain', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new Threshold._(retval);
    }
  }

  /// Get or set the scale's output range (as discrete values).
  range([/*List<num>*/ numbers = undefined]) {
    var args = [];
    if (numbers != undefined) {
      args.add(new JsObject.jsify(numbers));
    }
    var retval = _proxy.callMethod('range', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new Threshold._(retval);
    }
  }

  /// Create a new scale from an existing scale.
  Threshold copy() => new Threshold._(_proxy.callMethod('copy'));
}

/// Construct an ordinal scale.
Ordinal ordinal() => new Ordinal._(_scale.callMethod('ordinal'));

class Ordinal {
  final JsObject _proxy;

  Ordinal._(this._proxy);

  factory Ordinal() => ordinal();

  factory Ordinal.category10() => category10();

  factory Ordinal.category20() => category20();

  factory Ordinal.category20b() => category20b();

  factory Ordinal.category20c() => category20c();

  /// Get the range value corresponding to a given domain value.
  call(x) => _proxy.callMethod('call', [_proxy, x]);

  /// Get or set the scale's input domain.
  domain([/*List*/ values = undefined]) {
    var args = [];
    if (values != undefined) {
      args.add(new JsObject.jsify(values));
    }
    var retval = _proxy.callMethod('domain', args);
    if (values == undefined) {
      return retval;
    } else {
      return new Ordinal._(retval);
    }
  }

  /// Get or set the scale's output range.
  range([/*List*/ values = undefined]) {
    var args = [];
    if (values != undefined) {
      args.add(new JsObject.jsify(values));
    }
    var retval = _proxy.callMethod('range', args);
    if (values == undefined) {
      return retval;
    } else {
      return new Ordinal._(retval);
    }
  }

  /// Divide a continuous output range for discrete points.
  Ordinal rangePoints(List interval, [/*num*/ padding = undefined]) {
    var args = [new JsObject.jsify(interval)];
    if (padding != undefined) {
      args.add(padding);
    }
    return new Ordinal._(_proxy.callMethod('rangePoints', args));
  }

  /// Divide a continuous output range for discrete points.
  Ordinal rangeRoundPoints(List interval, [/*num*/ padding = undefined]) {
    var args = [new JsObject.jsify(interval)];
    if (padding != undefined) {
      args.add(padding);
    }
    return new Ordinal._(_proxy.callMethod('rangeRoundPoints', args));
  }

  /// Divide a continuous output range for discrete bands.
  Ordinal rangeBands(List interval,
      [/*num*/ padding = undefined, /*num*/ outerPadding = undefined]) {
    var args = [new JsObject.jsify(interval)];
    if (padding != undefined) {
      args.add(padding);
    }
    if (outerPadding != undefined) {
      args.add(outerPadding);
    }
    return new Ordinal._(_proxy.callMethod('rangeBands', args));
  }

  /// Divide a continuous output range for discrete bands.
  Ordinal rangeRoundBands(List interval,
      [/*num*/ padding = undefined, /*num*/ outerPadding = undefined]) {
    var args = [new JsObject.jsify(interval)];
    if (padding != undefined) {
      args.add(padding);
    }
    if (outerPadding != undefined) {
      args.add(outerPadding);
    }
    return new Ordinal._(_proxy.callMethod('rangeRoundBands', args));
  }

  /// Get the discrete range band width.
  rangeBand() => _proxy.callMethod('rangeBand');

  /// Get the minimum and maximum values of the output range.
  rangeExtent() => _proxy.callMethod('rangeExtent');

  /// Create a new scale from an existing scale.
  Ordinal copy() => new Ordinal._(_proxy.callMethod('copy'));
}

/// Construct an ordinal scale with ten categorical colors.
Ordinal category10() => new Ordinal._(_scale.callMethod('category10'));

/// Construct an ordinal scale with twenty categorical colors.
Ordinal category20() => new Ordinal._(_scale.callMethod('category20'));

/// Construct an ordinal scale with twenty categorical colors.
Ordinal category20b() => new Ordinal._(_scale.callMethod('category20b'));

/// Construct an ordinal scale with twenty categorical colors.
Ordinal category20c() => new Ordinal._(_scale.callMethod('category20c'));

/// For internal use.
JsObject getProxy(arg) => arg._proxy;
