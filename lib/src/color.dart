@JS('d3')
library d3.src.color;

import 'package:js/js.dart';

/// Specify a color in RGB space.
external Rgb rgb(r, [g, b]);

@JS()
class Rgb {
  /// Increase RGB channels by some exponential factor (gamma).
  external Rgb brighter([k]);

  /// Decrease RGB channels by some exponential factor (gamma).
  external Rgb darker([k]);

  /// Convert from RGB to HSL.
  external Hsl hsl();

  /// Convert an RGB color to a string.
  external String toString();
}

/// Specify a color in HSL space.
external Hsl hsl(h, [s, l]);

@JS()
class Hsl {
  /// Increase lightness by some exponential factor (gamma).
  external Hsl brighter([k]);

  /// Decrease lightness by some exponential factor (gamma).
  external Hsl darker([k]);

  /// Convert from HSL to RGB.
  external Rgb rgb();

  /// Convert an HSL color to a string.
  external String toString();
}

/// Specify a color in HCL space.
external Hcl hcl(h, [c, l]);

@JS()
class Hcl {
  /// Increase lightness by some exponential factor (gamma).
  external Hcl brighter([k]);

  /// Decrease lightness by some exponential factor (gamma).
  external Hcl darker([k]);

  /// Convert from HCL to RGB.
  external Rgb rgb();

  /// Convert an HCL color to a string.
  external String toString();
}

/// Specify a color in L*a*b* space.
external Lab lab(l, [a, b]);

@JS()
class Lab {
  /// Increase lightness by some exponential factor (gamma).
  external Lab brighter([k]);

  /// Decrease lightness by some exponential factor (gamma).
  external Lab darker([k]);

  /// Convert from L*a*b* to RGB.
  external Rgb rgb();

  /// Convert a L*a*b* color to a string.
  external String toString();
}
