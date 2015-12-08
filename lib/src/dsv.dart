library d3.src.dsv;

import 'dart:js';
import 'd3.dart';

JsObject _d3 = context['d3'];

Dsv dsv(String delimiter, String mimeType) {
  return new Dsv._(_d3.callMethod('dsv', [delimiter, mimeType]));
}

class Dsv {
  final JsObject _proxy;

  Dsv._(this._proxy);

  /// Create a parser/formatter for the specified delimiter and mime type.
  call(String url, [accessor(d) = undefinedFn, callback(rows) = undefinedFn]) {
    var args = [_proxy, url];
    if (accessor != undefinedFn) {
      args.add(accessor);
    }
    if (callback != undefinedFn) {
      args.add(callback);
    }
    return _proxy.callMethod('call', args);
  }

  List parse(String string, [accessor(d) = undefinedFn]) {
    var args = [string];
    if (accessor != undefinedFn) {
      args.add(accessor);
    }
    return _proxy.callMethod('parse', args);
  }

  List<List> parseRows(String string, [accessor(d) = undefinedFn]) {
    var args = [string];
    if (accessor != undefinedFn) {
      args.add(accessor);
    }
    return _proxy.callMethod('parseRows', args);
  }

  String format(List rows) {
    return _proxy.callMethod('format', [rows]);
  }

  String formatRows(List<List> rows) {
    return _proxy.callMethod('formatRows', [rows]);
  }
}
