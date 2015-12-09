library d3.src.color;

import 'dart:js';

JsObject _d3 = context['d3'];

/// Specify a color in RGB space.
Rgb rgb(int r, int g, int b) {
  return new Rgb._(_d3.callMethod('rgb', [r, g, b]));
}

class Rgb {
  final JsObject _proxy;

  Rgb._(this._proxy);

  factory Rgb(int r, int g, int b) => rgb(r, g, b);

  /// Increase RGB channels by some exponential factor (gamma).
  Rgb brighter([num k = 1]) {
    return new Rgb._(_proxy.callMethod('brighter', [k]));
  }

  /// Decrease RGB channels by some exponential factor (gamma).
  Rgb darker([num k = 1]) {
    return new Rgb._(_proxy.callMethod('darker', [k]));
  }

  /// Convert from RGB to HSL.
  Hsl hsl() => new Hsl._(_proxy.callMethod('hsl'));

  /// Convert an RGB color to a string.
  String toString() => _proxy.callMethod('toString');
}

/// Specify a color in HSL space.
Hsl hsl(num h, num s, num l) {
  return new Hsl._(_d3.callMethod('hsl', [h, s, l]));
}

class Hsl {
  final JsObject _proxy;

  Hsl._(this._proxy);

  factory Hsl(num h, num s, num l) => hsl(h, s, l);

  /// Increase lightness by some exponential factor (gamma).
  Hsl brighter([num k = 1]) {
    return new Hsl._(_proxy.callMethod('brighter', [k]));
  }

  /// Decrease lightness by some exponential factor (gamma).
  Hsl darker([num k = 1]) {
    return new Hsl._(_proxy.callMethod('darker', [k]));
  }

  /// Convert from HSL to RGB.
  Rgb rgb() => new Rgb._(_proxy.callMethod('rgb'));

  /// Convert an HSL color to a string.
  String toString() => _proxy.callMethod('toString');
}

/// Specify a color in HCL space.
Hcl hcl(num h, num c, num l) {
  return new Hcl._(_d3.callMethod('hcl', [h, c, l]));
}

class Hcl {
  final JsObject _proxy;

  Hcl._(this._proxy);

  factory Hcl(num h, num c, num l) => hcl(h, c, l);

  /// Increase lightness by some exponential factor (gamma).
  Hcl brighter([num k = 1]) {
    return new Hcl._(_proxy.callMethod('brighter', [k]));
  }

  /// Decrease lightness by some exponential factor (gamma).
  Hcl darker([num k = 1]) {
    return new Hcl._(_proxy.callMethod('darker', [k]));
  }

  /// Convert from HCL to RGB.
  Rgb rgb() => new Rgb._(_proxy.callMethod('rgb'));

  /// Convert an HCL color to a string.
  String toString() => _proxy.callMethod('toString');
}

/// Specify a color in L*a*b* space.
Lab lab(num l, num a, num b) {
  return new Lab._(_d3.callMethod('lab', [l, a, b]));
}

class Lab {
  final JsObject _proxy;

  Lab._(this._proxy);

  factory Lab(num l, num a, num b) => lab(l, a, b);

  /// Increase lightness by some exponential factor (gamma).
  Lab brighter([num k = 1]) {
    return new Lab._(_proxy.callMethod('brighter', [k]));
  }

  /// Decrease lightness by some exponential factor (gamma).
  Lab darker([num k = 1]) {
    return new Lab._(_proxy.callMethod('darker', [k]));
  }

  /// Convert from L*a*b* to RGB.
  Rgb rgb() => new Rgb._(_proxy.callMethod('rgb'));

  /// Convert a L*a*b* color to a string.
  String toString() => _proxy.callMethod('toString');
}

/// For internal use.
JsObject getProxy(arg) => arg._proxy;
