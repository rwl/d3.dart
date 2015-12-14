library d3.src.color;

import 'js/color.dart' as color;

abstract class Color {
  dynamic get js;
}

class Rgb implements Color {
  final color.Rgb js;

  Rgb._(this.js);

  /// Specify a color in RGB space.
  Rgb(int r, int g, int b) : js = color.rgb(r, g, b);

  Rgb.parse(String rgb) : js = color.rgb(rgb);

  /// Increase RGB channels by some exponential factor (gamma).
  Rgb brighter([num k]) {
    if (k != null) {
      return new Rgb._(js.brighter(k));
    } else {
      return new Rgb._(js.brighter());
    }
  }

  /// Decrease RGB channels by some exponential factor (gamma).
  Rgb darker([num k]) {
    if (k != null) {
      return new Rgb._(js.darker(k));
    } else {
      return new Rgb._(js.darker());
    }
  }

  /// Convert an RGB color to a string.
  String toString() => js.toString();
}
