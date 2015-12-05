library d3.src.dsv;

import 'dart:js';

JsObject _d3 = context['d3'];

/// Create a parser/formatter for the specified delimiter and mime type.
dsv(url, [accessor, callback]) {
  return _d3.callMethod('dsv', []);
}

class Dsv {
  final JsObject _proxy;

  Dsv._(this._proxy);

  call(delimiter, mimeType) => dsv(delimiter, mimeType);

  dsv(delimiter, mimeType) {
    return _proxy.callMethod('dsv', []);
  }

  parse(string, [accessor]) {
    return _proxy.callMethod('parse', []);
  }

  parseRows(string, [accessor]) {
    return _proxy.callMethod('parseRows', []);
  }

  format(rows) {
    return _proxy.callMethod('format', []);
  }

  formatRows(rows) {
    return _proxy.callMethod('formatRows', []);
  }
}
