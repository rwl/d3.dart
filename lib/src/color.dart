library d3.src.color;

import 'dart:js';

JsObject _d3 = context['d3'];

/// Specify a color in RGB space.
Rgb rgb(r, [g, b]) {
  return _d3.callMethod('rgb', []);
}

class Rgb {
  final JsObject _proxy;

  Rgb._(this._proxy);

  /// Increase RGB channels by some exponential factor (gamma).
  Rgb brighter([k]) {
    return _proxy.callMethod('brighter', []);
  }

  /// Decrease RGB channels by some exponential factor (gamma).
  Rgb darker([k]) {
    return _proxy.callMethod('darker', []);
  }

  /// Convert from RGB to HSL.
  Hsl hsl() {
    return _proxy.callMethod('hsl', []);
  }

  /// Convert an RGB color to a string.
  String toString() {
    return _proxy.callMethod('toString', []);
  }
}

/// Specify a color in HSL space.
Hsl hsl(h, [s, l]) {
  return _d3.callMethod('hsl', []);
}

class Hsl {
  final JsObject _proxy;

  Hsl._(this._proxy);

  /// Increase lightness by some exponential factor (gamma).
  Hsl brighter([k]) {
    return _proxy.callMethod('brighter', []);
  }

  /// Decrease lightness by some exponential factor (gamma).
  Hsl darker([k]) {
    return _proxy.callMethod('darker', []);
  }

  /// Convert from HSL to RGB.
  Rgb rgb() {
    return _proxy.callMethod('rgb', []);
  }

  /// Convert an HSL color to a string.
  String toString() {
    return _proxy.callMethod('toString', []);
  }
}

/// Specify a color in HCL space.
Hcl hcl(h, [c, l]) {
  return _d3.callMethod('hcl', []);
}

class Hcl {
  final JsObject _proxy;

  Hcl._(this._proxy);

  /// Increase lightness by some exponential factor (gamma).
  Hcl brighter([k]) {
    return _proxy.callMethod('brighter', []);
  }

  /// Decrease lightness by some exponential factor (gamma).
  Hcl darker([k]) {
    return _proxy.callMethod('darker', []);
  }

  /// Convert from HCL to RGB.
  Rgb rgb() {
    return _proxy.callMethod('rgb', []);
  }

  /// Convert an HCL color to a string.
  String toString() {
    return _proxy.callMethod('toString', []);
  }
}

/// Specify a color in L*a*b* space.
Lab lab(l, [a, b]) {
  return _d3.callMethod('lab', []);
}

class Lab {
  final JsObject _proxy;

  Lab._(this._proxy);

  /// Increase lightness by some exponential factor (gamma).
  Lab brighter([k]) {
    return _proxy.callMethod('brighter', []);
  }

  /// Decrease lightness by some exponential factor (gamma).
  Lab darker([k]) {
    return _proxy.callMethod('darker', []);
  }

  /// Convert from L*a*b* to RGB.
  Rgb rgb() {
    return _proxy.callMethod('rgb', []);
  }

  /// Convert a L*a*b* color to a string.
  String toString() {
    return _proxy.callMethod('toString', []);
  }
}
