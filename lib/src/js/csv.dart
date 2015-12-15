library d3.src.js.csv;

import 'dart:js';
import 'd3.dart';

JsObject _d3 = context['d3'];
JsObject _csv = context['d3']['csv'];

/// Request a comma-separated values (CSV) file.
csv(String url,
    [/*Function*/ accessor = undefined, /*Function*/ callback = undefined]) {
  var args = [url];
  if (accessor != undefined) {
    args.add(accessor);
  }
  if (callback != undefined) {
    args.add(callback);
  }
  return _d3.callMethod('csv', args);
}

/// Parse a CSV string into objects using the header row.
List parse(String string, [/*Function*/ accessor = undefined]) {
  var args = [string];
  if (accessor != undefined) {
    args.add(accessor);
  }
  return _csv.callMethod('parse', args);
}

/// Parse a CSV string into tuples, ignoring the header row.
List<List> parseRows(String string, [/*Function*/ accessor = undefined]) {
  var args = [string];
  if (accessor != undefined) {
    args.add(accessor);
  }
  return _csv.callMethod('parseRows', args);
}

/// Format an array of objects into a CSV string.
String format(List rows) {
  return _csv.callMethod('format', [new JsObject.jsify(rows)]);
}

/// Format an array of tuples into a CSV string.
String formatRows(List<List> rows) {
  return _csv.callMethod('formatRows', [new JsObject.jsify(rows)]);
}
