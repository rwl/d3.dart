@JS('d3')
library d3.src.color;

import 'package:js/js.dart';

/// specify a color in RGB space.
external Rgb rgb(r, [g, b]);

@JS()
class Rgb {
  /// increase RGB channels by some exponential factor (gamma).
  external Rgb brighter([k]);

  /// decrease RGB channels by some exponential factor (gamma).
  external Rgb darker([k]);

  /// convert from RGB to HSL.
  external Hsl hsl();

  /// convert an RGB color to a string.
  external String toString();
}

/// specify a color in HSL space.
external Hsl hsl(h, [s, l]);

@JS()
class Hsl {
  /// increase lightness by some exponential factor (gamma).
  external Hsl brighter([k]);

  /// decrease lightness by some exponential factor (gamma).
  external Hsl darker([k]);

  /// convert from HSL to RGB.
  external Rgb rgb();

  /// convert an HSL color to a string.
  external String toString();
}

/// specify a color in HCL space.
external Hcl hcl(h, [c, l]);

@JS()
class Hcl {
  /// increase lightness by some exponential factor (gamma).
  external Hcl brighter([k]);

  /// decrease lightness by some exponential factor (gamma).
  external Hcl darker([k]);

  /// convert from HCL to RGB.
  external Rgb rgb();

  /// convert an HCL color to a string.
  external String toString();
}

/// specify a color in L*a*b* space.
external Lab lab(l, [a, b]);

@JS()
class Lab {
  /// increase lightness by some exponential factor (gamma).
  external Lab brighter([k]);

  /// decrease lightness by some exponential factor (gamma).
  external Lab darker([k]);

  /// convert from L*a*b* to RGB.
  external Rgb rgb();

  /// convert a L*a*b* color to a string.
  external String toString();
}
