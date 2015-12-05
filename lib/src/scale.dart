@JS('d3.scale')
library d3.src.scale;

import 'package:js/js.dart';

/// Construct a linear quantitative scale.
external LinearScale linear();

@JS()
abstract class LinearScale implements Function {
  call(x) => linear(x);

  /// Get the range value corresponding to a given domain value.
  external linear(x);

  /// Get the domain value corresponding to a given range value.
  external invert(y);

  /// Get or set the scale's input domain.
  external LinearScale domain([numbers]);

  /// Get or set the scale's output range.
  external LinearScale range([values]);

  /// Set the scale's output range, and enable rounding.
  external rangeRound(values);

  /// Get or set the scale's output interpolator.
  external interpolate([factory]);

  /// Enable or disable clamping of the output range.
  external clamp([boolean]);

  /// Extend the scale domain to nice round numbers.
  external nice([count]);

  /// Get representative values from the input domain.
  external ticks([count]);

  /// Get a formatter for displaying tick values.
  external tickFormat(count, [format]);

  /// Create a new scale from an existing scale.
  external copy();
}

/// Construct a linear identity scale.
external IdentityScale identity();

@JS()
abstract class IdentityScale implements Function {
  call(x) => identity(x);

  /// The identity function.
  external identity(x);

  /// Equivalent to identity; the identity function.
  external invert(x);

  /// Get or set the scale's domain and range.
  external domain([numbers]);

  /// Equivalent to identity.domain.
  external range([numbers]);

  /// Get representative values from the domain.
  external ticks([count]);

  /// Get a formatter for displaying tick values.
  external tickFormat(count, [format]);

  /// Create a new scale from an existing scale.
  external copy();
}

/// Construct a quantitative scale with a square root transform.
external Pow sqrt();

/// Construct a quantitative scale with an exponential transform.
external Pow pow();

@JS()
abstract class Pow implements Function {
  call(x) => pow(x);

  /// Get the range value corresponding to a given domain value.
  external pow(x);

  /// Get the domain value corresponding to a given range value.
  external invert(y);

  /// Get or set the scale's input domain.
  external domain([numbers]);

  /// Get or set the scale's output range.
  external range([values]);

  /// Set the scale's output range, and enable rounding.
  external rangeRound(values);

  /// Get or set the exponent power.
  external exponent([k]);

  /// Get or set the scale's output interpolator.
  external interpolate([factory]);

  /// Enable or disable clamping of the output range.
  external clamp([boolean]);

  /// Extend the scale domain to nice round numbers.
  external nice([m]);

  /// Get representative values from the input domain.
  external ticks([count]);

  /// Get a formatter for displaying tick values.
  external tickFormat([count, format]);

  /// Create a new scale from an existing scale.
  external copy();
}

/// Construct a quantitative scale with an logarithmic transform.
external Log log();

@JS()
abstract class Log implements Function {
  call(x) => log(x);

  /// Get the range value corresponding to a given domain value.
  external log(x);

  /// Get the domain value corresponding to a given range value.
  external invert(y);

  /// Get or set the scale's input domain.
  external domain([numbers]);

  /// Get or set the scale's output range.
  external range([values]);

  /// Set the scale's output range, and enable rounding.
  external rangeRound(values);
  external base([base]);

  /// Get or set the scale's output interpolator.
  external interpolate([factory]);

  /// Enable or disable clamping of the output range.
  external clamp([boolean]);

  /// Extend the scale domain to nice powers of ten.
  external nice();

  /// Get representative values from the input domain.
  external ticks();

  /// Get a formatter for displaying tick values.
  external tickFormat([count, format]);

  /// Create a new scale from an existing scale.
  external copy();
}

/// Construct a linear quantitative scale with a discrete output range.
external Quantize quantize();

@JS()
abstract class Quantize implements Function {
  call(x) => quantize(x);

  /// Get the range value corresponding to a given domain value.
  external quantize(x);

  /// Get the domain values for the specified range value.
  external invertExtent(y);

  /// Get or set the scale's input domain.
  external domain([numbers]);

  /// Get or set the scale's output range (as discrete values).
  external range([values]);

  /// Create a new scale from an existing scale.
  external copy();
}

/// Construct a quantitative scale mapping to quantiles.
external Quantile quantile();

@JS()
abstract class Quantile implements Function {
  call(x) => quantile(x);

  /// Get the range value corresponding to a given domain value.
  external quantile(x);

  /// Get the domain values for the specified range value.
  external invertExtent(y);

  /// Get or set the scale's input domain (as discrete values).
  external domain([numbers]);

  /// Get or set the scale's output range (as discrete values).
  external range([values]);

  /// Get the scale's quantile bin thresholds.
  external quantiles();

  /// Create a new scale from an existing scale.
  external copy();
}

/// Construct a threshold scale with a discrete output range.
external Threshold threshold();

@JS()
abstract class Threshold implements Function {
  call(x) => threshold(x);

  /// Get the range value corresponding to a given domain value.
  external threshold(x);

  /// Get the domain values for the specified range value.
  external invertExtent(y);

  /// Get or set the scale's input domain.
  external domain([domain]);

  /// Get or set the scale's output range (as discrete values).
  external range([values]);

  /// Create a new scale from an existing scale.
  external copy();
}

/// Construct an ordinal scale.
external Ordinal ordinal();

@JS()
abstract class Ordinal implements Function {
  call(x) => ordinal(x);

  /// Get the range value corresponding to a given domain value.
  external ordinal(x);

  /// Get or set the scale's input domain.
  external domain([values]);

  /// Get or set the scale's output range.
  external range([values]);

  /// Divide a continuous output range for discrete points.
  external rangePoints(interval, [padding]);

  /// Divide a continuous output range for discrete points.
  external rangeRoundPoints(interval, [padding]);

  /// Divide a continuous output range for discrete bands.
  external rangeBands(interval, [padding, outerPadding]);

  /// Divide a continuous output range for discrete bands.
  external Ordinal rangeRoundBands(interval, [padding, outerPadding]);

  /// Get the discrete range band width.
  external rangeBand();

  /// Get the minimum and maximum values of the output range.
  external rangeExtent();

  /// Create a new scale from an existing scale.
  external copy();
}

/// Construct an ordinal scale with ten categorical colors.
external category10();

/// Construct an ordinal scale with twenty categorical colors.
external category20();

/// Construct an ordinal scale with twenty categorical colors.
external category20b();

/// Construct an ordinal scale with twenty categorical colors.
external category20c();
