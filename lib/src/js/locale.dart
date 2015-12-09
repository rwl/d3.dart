library d3.src.js.locale;

import 'dart:js';

JsObject _d3 = context['d3'];

/// Create a new locale using the specified strings.
Locale locale(definition) {
  return new Locale._(_d3.callMethod('locale', [definition]));
}

class Locale {
  final JsObject _proxy;

  Locale._(this._proxy);

  factory Locale(definition) => locale(definition);

  /// Create a new number formatter.
  Function numberFormat(String specifier) {
    return _proxy.callMethod('numberFormat', [specifier]);
  }

  /// Create a new time formatter / parser.
  timeFormat(String specifier) {
    return _proxy.callMethod('timeFormat', [specifier]);
  }

  timeFormatUtc(String specifier) {
    return _proxy['utc'].callMethod('timeFormat', [specifier]);
  }
}
