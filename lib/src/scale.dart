@JS('d3.scale')
library d3.src.scale;

import 'package:js/js.dart';

/// construct a linear quantitative scale.
external LinearScale linear();

@JS()
class LinearScale {
  /// get the range value corresponding to a given domain value.
  external linear(x);

  /// get the domain value corresponding to a given range value.
  external invert(y);

  /// get or set the scale's input domain.
  external LinearScale domain([numbers]);

  /// get or set the scale's output range.
  external LinearScale range([values]);

  /// set the scale's output range, and enable rounding.
  external rangeRound(values);

  /// get or set the scale's output interpolator.
  external interpolate([factory]);

  /// enable or disable clamping of the output range.
  external clamp([boolean]);

  /// extend the scale domain to nice round numbers.
  external nice([count]);

  /// get representative values from the input domain.
  external ticks([count]);

  /// get a formatter for displaying tick values.
  external tickFormat(count, [format]);

  /// create a new scale from an existing scale.
  external copy();
}

/// construct a linear identity scale.
external IdentityScale identity();

@JS()
class IdentityScale {
  /// the identity function.
  external identity(x);

  /// equivalent to identity; the identity function.
  external invert(x);

  /// get or set the scale's domain and range.
  external domain([numbers]);

  /// equivalent to identity.domain.
  external range([numbers]);

  /// get representative values from the domain.
  external ticks([count]);

  /// get a formatter for displaying tick values.
  external tickFormat(count, [format]);

  /// create a new scale from an existing scale.
  external copy();
}

/// construct a quantitative scale with a square root transform.
external Pow sqrt();

/// construct a quantitative scale with an exponential transform.
external Pow pow();

@JS()
class Pow {
  /// get the range value corresponding to a given domain value.
  external pow(x);

  /// get the domain value corresponding to a given range value.
  external invert(y);

  /// get or set the scale's input domain.
  external domain([numbers]);

  /// get or set the scale's output range.
  external range([values]);

  /// set the scale's output range, and enable rounding.
  external rangeRound(values);

  /// get or set the exponent power.
  external exponent([k]);

  /// get or set the scale's output interpolator.
  external interpolate([factory]);

  /// enable or disable clamping of the output range.
  external clamp([boolean]);

  /// extend the scale domain to nice round numbers.
  external nice([m]);

  /// get representative values from the input domain.
  external ticks([count]);

  /// get a formatter for displaying tick values.
  external tickFormat([count, format]);

  /// create a new scale from an existing scale.
  external copy();
}

/// construct a quantitative scale with an logarithmic transform.
external Log log();

@JS()
class Log {
  /// get the range value corresponding to a given domain value.
  external log(x);

  /// get the domain value corresponding to a given range value.
  external invert(y);

  /// get or set the scale's input domain.
  external domain([numbers]);

  /// get or set the scale's output range.
  external range([values]);

  /// set the scale's output range, and enable rounding.
  external rangeRound(values);
  external base([base]);

  /// get or set the scale's output interpolator.
  external interpolate([factory]);

  /// enable or disable clamping of the output range.
  external clamp([boolean]);

  /// extend the scale domain to nice powers of ten.
  external nice();

  /// get representative values from the input domain.
  external ticks();

  /// get a formatter for displaying tick values.
  external tickFormat([count, format]);

  /// create a new scale from an existing scale.
  external copy();
}

/// construct a linear quantitative scale with a discrete output range.
external Quantize quantize();

@JS()
class Quantize {
  /// get the range value corresponding to a given domain value.
  external quantize(x);

  /// get the domain values for the specified range value.
  external invertExtent(y);

  /// get or set the scale's input domain.
  external domain([numbers]);

  /// get or set the scale's output range (as discrete values).
  external range([values]);

  /// create a new scale from an existing scale.
  external copy();
}

/// construct a quantitative scale mapping to quantiles.
external Quantile quantile();

@JS()
class Quantile {
  /// get the range value corresponding to a given domain value.
  external quantile(x);

  /// get the domain values for the specified range value.
  external invertExtent(y);

  /// get or set the scale's input domain (as discrete values).
  external domain([numbers]);

  /// get or set the scale's output range (as discrete values).
  external range([values]);

  /// get the scale's quantile bin thresholds.
  external quantiles();

  /// create a new scale from an existing scale.
  external copy();
}

/// construct a threshold scale with a discrete output range.
external Threshold threshold();

@JS()
class Threshold {
  /// get the range value corresponding to a given domain value.
  external threshold(x);

  /// get the domain values for the specified range value.
  external invertExtent(y);

  /// get or set the scale's input domain.
  external domain([domain]);

  /// get or set the scale's output range (as discrete values).
  external range([values]);

  /// create a new scale from an existing scale.
  external copy();
}

/// construct an ordinal scale.
external Ordinal ordinal();

@JS()
class Ordinal {
  /// get the range value corresponding to a given domain value.
  external ordinal(x);

  /// get or set the scale's input domain.
  external domain([values]);

  /// get or set the scale's output range.
  external range([values]);

  /// divide a continuous output range for discrete points.
  external rangePoints(interval, [padding]);

  /// divide a continuous output range for discrete points.
  external rangeRoundPoints(interval, [padding]);

  /// divide a continuous output range for discrete bands.
  external rangeBands(interval, [padding, outerPadding]);

  /// divide a continuous output range for discrete bands.
  external rangeRoundBands(interval, [padding, outerPadding]);

  /// get the discrete range band width.
  external rangeBand();

  /// get the minimum and maximum values of the output range.
  external rangeExtent();

  /// create a new scale from an existing scale.
  external copy();
}

/// construct an ordinal scale with ten categorical colors.
external category10();

/// construct an ordinal scale with twenty categorical colors.
external category20();

/// construct an ordinal scale with twenty categorical colors.
external category20b();

/// construct an ordinal scale with twenty categorical colors.
external category20c();
