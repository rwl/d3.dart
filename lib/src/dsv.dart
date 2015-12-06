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

  call(String url, [accessor(d) = undefined, callback(rows) = undefined]) =>
      dsv(url, accessor, callback);

  /// Create a parser/formatter for the specified delimiter and mime type.
  dsv(String url, [accessor(d) = undefined, callback(rows) = undefined]) {
    var args = [url];
    if (accessor != undefined) {
      args.add(accessor);
    }
    if (callback != undefined) {
      args.add(callback);
    }
    return _proxy.callMethod('dsv', args);
  }

  List parse(String string, [accessor(d) = undefined]) {
    var args = [string];
    if (accessor != undefined) {
      args.add(accessor);
    }
    return _proxy.callMethod('parse', args);
  }

  List<List> parseRows(String string, [accessor(d) = undefined]) {
    var args = [string];
    if (accessor != undefined) {
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
