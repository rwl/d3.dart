@JS('d3.scale')
library d3.src.scale;

import 'package:js/js.dart';

external LinearScale linear();

@JS()
class LinearScale {
  external linear(x);
  external invert(y);
  external LinearScale domain([numbers]);
  external LinearScale range([values]);
  external rangeRound(values);
  external interpolate([factory]);
  external clamp([boolean]);
  external nice([count]);
  external ticks([count]);
  external tickFormat(count, [format]);
  external copy();
}

external IdentityScale identity();

@JS()
class IdentityScale {
  external identity(x);
  external invert(x);
  external domain([numbers]);
  external range([numbers]);
  external ticks([count]);
  external tickFormat(count, [format]);
  external copy();
}

external Pow sqrt();
external Pow pow();

@JS()
class Pow {
  external pow(x);
  external invert(y);
  external domain([numbers]);
  external range([values]);
  external rangeRound(values);
  external exponent([k]);
  external interpolate([factory]);
  external clamp([boolean]);
  external nice([m]);
  external ticks([count]);
  external tickFormat([count, format]);
  external copy();
}

external Log log();

@JS()
class Log {
  external log(x);
  external invert(y);
  external domain([numbers]);
  external range([values]);
  external rangeRound(values);
  external base([base]);
  external interpolate([factory]);
  external clamp([boolean]);
  external nice();
  external ticks();
  external tickFormat([count, format]);
  external copy();
}

external Quantize quantize();

@JS()
class Quantize {
  external quantize(x);
  external invertExtent(y);
  external domain([numbers]);
  external range([values]);
  external copy();
}

external Quantile quantile();

@JS()
class Quantile {
  external quantile(x);
  external invertExtent(y);
  external domain([numbers]);
  external range([values]);
  external quantiles();
  external copy();
}

external Threshold threshold();

@JS()
class Threshold {
  external threshold(x);
  external invertExtent(y);
  external domain([domain]);
  external range([values]);
  external copy();
}

external Ordinal ordinal();

@JS()
class Ordinal {
  external ordinal(x);
  external domain([values]);
  external range([values]);
  external rangePoints(interval, [padding]);
  external rangeRoundPoints(interval, [padding]);
  external rangeBands(interval, [padding, outerPadding]);
  external rangeRoundBands(interval, [padding, outerPadding]);
  external rangeBand();
  external rangeExtent();
  external copy();
}

external category10();
external category20();
external category20b();
external category20c();
