library d3.src.scale;

import 'dart:js';
import 'd3.dart';

JsObject _scale = context['d3']['scale'];

/// Construct a linear quantitative scale.
LinearScale linear() {
  return new LinearScale._(_scale.callMethod('linear', []));
}

class LinearScale {
  final JsObject _proxy;

  LinearScale._(this._proxy);

  call(x) => linear(x);

  /// Get the range value corresponding to a given domain value.
  linear(x) {
    return _proxy.callMethod('call', [_proxy, x]);
  }

  /// Get the domain value corresponding to a given range value.
  invert(y) {
    return _proxy.callMethod('invert', []);
  }

  /// Get or set the scale's input domain.
  domain([List<num> numbers = undefined]) {
    var args = [];
    if (numbers != undefined) {
      args.add(numbers);
    }
    var retval = _proxy.callMethod('domain', args);
    if (numbers == undefined) {
      return retval;
    } else {
      return new LinearScale._(retval);
    }
  }

  /// Get or set the scale's output range.
  LinearScale range([List values = undefined]) {
    var args = [];
    if (values != undefined) {
      args.add(values);
    }
    var retval = _proxy.callMethod('range', args);
    if (values == undefined) {
      return retval;
    } else {
      return new LinearScale._(retval);
    }
  }

  /// Set the scale's output range, and enable rounding.
  rangeRound(values) {
    return _proxy.callMethod('rangeRound', []);
  }

  /// Get or set the scale's output interpolator.
  interpolate([factory]) {
    return _proxy.callMethod('interpolate', []);
  }

  /// Enable or disable clamping of the output range.
  clamp([boolean]) {
    return _proxy.callMethod('clamp', []);
  }

  /// Extend the scale domain to nice round numbers.
  nice([count]) {
    return _proxy.callMethod('nice', []);
  }

  /// Get representative values from the input domain.
  ticks([count]) {
    return _proxy.callMethod('ticks', []);
  }

  /// Get a formatter for displaying tick values.
  tickFormat(count, [format]) {
    return _proxy.callMethod('tickFormat', []);
  }

  /// Create a new scale from an existing scale.
  copy() {
    return _proxy.callMethod('copy', []);
  }
}

/// Construct a linear identity scale.
IdentityScale identity() {
  return _scale.callMethod('identity', []);
}

class IdentityScale {
  final JsObject _proxy;

  IdentityScale._(this._proxy);

  call(x) => identity(x);

  /// The identity function.
  identity(x) {
    return _proxy.callMethod('identity', []);
  }

  /// Equivalent to identity; the identity function.
  invert(x) {
    return _proxy.callMethod('invert', []);
  }

  /// Get or set the scale's domain and range.
  domain([numbers]) {
    return _proxy.callMethod('domain', []);
  }

  /// Equivalent to identity.domain.
  range([numbers]) {
    return _proxy.callMethod('range', []);
  }

  /// Get representative values from the domain.
  ticks([count]) {
    return _proxy.callMethod('ticks', []);
  }

  /// Get a formatter for displaying tick values.
  tickFormat(count, [format]) {
    return _proxy.callMethod('tickFormat', []);
  }

  /// Create a new scale from an existing scale.
  copy() {
    return _proxy.callMethod('copy', []);
  }
}

/// Construct a quantitative scale with a square root transform.
Pow sqrt() {
  return _scale.callMethod('sqrt', []);
}

/// Construct a quantitative scale with an exponential transform.
Pow pow() {
  return _scale.callMethod('pow', []);
}

class Pow {
  final JsObject _proxy;

  Pow._(this._proxy);

  call(x) => pow(x);

  /// Get the range value corresponding to a given domain value.
  pow(x) {
    return _proxy.callMethod('pow', []);
  }

  /// Get the domain value corresponding to a given range value.
  invert(y) {
    return _proxy.callMethod('invert', []);
  }

  /// Get or set the scale's input domain.
  domain([numbers]) {
    return _proxy.callMethod('domain', []);
  }

  /// Get or set the scale's output range.
  range([values]) {
    return _proxy.callMethod('range', []);
  }

  /// Set the scale's output range, and enable rounding.
  rangeRound(values) {
    return _proxy.callMethod('rangeRound', []);
  }

  /// Get or set the exponent power.
  exponent([k]) {
    return _proxy.callMethod('exponent', []);
  }

  /// Get or set the scale's output interpolator.
  interpolate([factory]) {
    return _proxy.callMethod('interpolate', []);
  }

  /// Enable or disable clamping of the output range.
  clamp([boolean]) {
    return _proxy.callMethod('clamp', []);
  }

  /// Extend the scale domain to nice round numbers.
  nice([m]) {
    return _proxy.callMethod('nice', []);
  }

  /// Get representative values from the input domain.
  ticks([count]) {
    return _proxy.callMethod('ticks', []);
  }

  /// Get a formatter for displaying tick values.
  tickFormat([count, format]) {
    return _proxy.callMethod('tickFormat', []);
  }

  /// Create a new scale from an existing scale.
  copy() {
    return _proxy.callMethod('copy', []);
  }
}

/// Construct a quantitative scale with an logarithmic transform.
Log log() {
  return _scale.callMethod('log', []);
}

class Log {
  final JsObject _proxy;

  Log._(this._proxy);

  call(x) => log(x);

  /// Get the range value corresponding to a given domain value.
  log(x) {
    return _proxy.callMethod('log', []);
  }

  /// Get the domain value corresponding to a given range value.
  invert(y) {
    return _proxy.callMethod('invert', []);
  }

  /// Get or set the scale's input domain.
  domain([numbers]) {
    return _proxy.callMethod('domain', []);
  }

  /// Get or set the scale's output range.
  range([values]) {
    return _proxy.callMethod('range', []);
  }

  /// Set the scale's output range, and enable rounding.
  rangeRound(values) {
    return _proxy.callMethod('rangeRound', []);
  }

  base([base]) {
    return _proxy.callMethod('base', []);
  }

  /// Get or set the scale's output interpolator.
  interpolate([factory]) {
    return _proxy.callMethod('interpolate', []);
  }

  /// Enable or disable clamping of the output range.
  clamp([boolean]) {
    return _proxy.callMethod('clamp', []);
  }

  /// Extend the scale domain to nice powers of ten.
  nice() {
    return _proxy.callMethod('nice', []);
  }

  /// Get representative values from the input domain.
  ticks() {
    return _proxy.callMethod('ticks', []);
  }

  /// Get a formatter for displaying tick values.
  tickFormat([count, format]) {
    return _proxy.callMethod('tickFormat', []);
  }

  /// Create a new scale from an existing scale.
  copy() {
    return _proxy.callMethod('copy', []);
  }
}

/// Construct a linear quantitative scale with a discrete output range.
Quantize quantize() {
  return _scale.callMethod('quantize', []);
}

class Quantize {
  final JsObject _proxy;

  Quantize._(this._proxy);

  call(x) => quantize(x);

  /// Get the range value corresponding to a given domain value.
  quantize(x) {
    return _proxy.callMethod('quantize', []);
  }

  /// Get the domain values for the specified range value.
  invertExtent(y) {
    return _proxy.callMethod('invertExtent', []);
  }

  /// Get or set the scale's input domain.
  domain([numbers]) {
    return _proxy.callMethod('domain', []);
  }

  /// Get or set the scale's output range (as discrete values).
  range([values]) {
    return _proxy.callMethod('range', []);
  }

  /// Create a new scale from an existing scale.
  copy() {
    return _proxy.callMethod('copy', []);
  }
}

/// Construct a quantitative scale mapping to quantiles.
Quantile quantile() {
  return _scale.callMethod('quantile', []);
}

class Quantile {
  final JsObject _proxy;

  Quantile._(this._proxy);

  call(x) => quantile(x);

  /// Get the range value corresponding to a given domain value.
  quantile(x) {
    return _proxy.callMethod('quantile', []);
  }

  /// Get the domain values for the specified range value.
  invertExtent(y) {
    return _proxy.callMethod('invertExtent', []);
  }

  /// Get or set the scale's input domain (as discrete values).
  domain([numbers]) {
    return _proxy.callMethod('domain', []);
  }

  /// Get or set the scale's output range (as discrete values).
  range([values]) {
    return _proxy.callMethod('range', []);
  }

  /// Get the scale's quantile bin thresholds.
  quantiles() {
    return _proxy.callMethod('quantiles', []);
  }

  /// Create a new scale from an existing scale.
  copy() {
    return _proxy.callMethod('copy', []);
  }
}

/// Construct a threshold scale with a discrete output range.
Threshold threshold() {
  return _scale.callMethod('threshold', []);
}

class Threshold {
  final JsObject _proxy;

  Threshold._(this._proxy);

  call(x) => threshold(x);

  /// Get the range value corresponding to a given domain value.
  threshold(x) {
    return _proxy.callMethod('threshold', []);
  }

  /// Get the domain values for the specified range value.
  invertExtent(y) {
    return _proxy.callMethod('invertExtent', []);
  }

  /// Get or set the scale's input domain.
  domain([domain]) {
    return _proxy.callMethod('domain', []);
  }

  /// Get or set the scale's output range (as discrete values).
  range([values]) {
    return _proxy.callMethod('range', []);
  }

  /// Create a new scale from an existing scale.
  copy() {
    return _proxy.callMethod('copy', []);
  }
}

/// Construct an ordinal scale.
Ordinal ordinal() {
  return _scale.callMethod('ordinal', []);
}

class Ordinal {
  final JsObject _proxy;

  Ordinal._(this._proxy);

  call(x) => ordinal(x);

  /// Get the range value corresponding to a given domain value.
  ordinal(x) {
    return _proxy.callMethod('ordinal', []);
  }

  /// Get or set the scale's input domain.
  domain([values]) {
    return _proxy.callMethod('domain', []);
  }

  /// Get or set the scale's output range.
  range([values]) {
    return _proxy.callMethod('range', []);
  }

  /// Divide a continuous output range for discrete points.
  rangePoints(interval, [padding]) {
    return _proxy.callMethod('rangePoints', []);
  }

  /// Divide a continuous output range for discrete points.
  rangeRoundPoints(interval, [padding]) {
    return _proxy.callMethod('rangeRoundPoints', []);
  }

  /// Divide a continuous output range for discrete bands.
  rangeBands(interval, [padding, outerPadding]) {
    return _proxy.callMethod('rangeBands', []);
  }

  /// Divide a continuous output range for discrete bands.
  Ordinal rangeRoundBands(interval, [padding, outerPadding]) {
    return _proxy.callMethod('rangeRoundBands', []);
  }

  /// Get the discrete range band width.
  rangeBand() {
    return _proxy.callMethod('rangeBand', []);
  }

  /// Get the minimum and maximum values of the output range.
  rangeExtent() {
    return _proxy.callMethod('rangeExtent', []);
  }

  /// Create a new scale from an existing scale.
  copy() {
    return _proxy.callMethod('copy', []);
  }
}

/// Construct an ordinal scale with ten categorical colors.
category10() {
  return _scale.callMethod('category10', []);
}

/// Construct an ordinal scale with twenty categorical colors.
category20() {
  return _scale.callMethod('category20', []);
}

/// Construct an ordinal scale with twenty categorical colors.
category20b() {
  return _scale.callMethod('category20b', []);
}

/// Construct an ordinal scale with twenty categorical colors.
category20c() {
  return _scale.callMethod('category20c', []);
}
