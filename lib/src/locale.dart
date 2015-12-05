library d3.src.locale;

import 'dart:js';

JsObject _d3 = context['d3'];

/// Create a new locale using the specified strings.
Locale locale(definition) {
  return _d3.callMethod('locale', []);
}

class Locale {
  final JsObject _proxy;

  Locale._(this._proxy);

  /// Create a new number formatter.
  numberFormat(specifier) {
    return _proxy.callMethod('numberFormat', []);
  }

  /// Create a new time formatter / parser.
  timeFormat(specifier) {
    return _proxy.callMethod('timeFormat', []);
  }

  timeFormatUtc(specifier) {
    return _proxy['utc'].callMethod('timeFormat', []);
  }
}
