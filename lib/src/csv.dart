library d3.src.csv;

import 'dart:js';
import 'd3.dart';

JsObject _d3 = context['d3'];
JsObject _csv = context['d3']['csv'];

/// Request a comma-separated values (CSV) file.
csv(String url, [accessor(d) = undefinedFn, callback(rows) = undefinedFn]) {
  var args = [url];
  if (accessor != undefinedFn) {
    args.add(accessor);
  }
  if (callback != undefinedFn) {
    args.add(callback);
  }
  return _d3.callMethod('csv', args);
}

/// Parse a CSV string into objects using the header row.
List parse(String string, [accessor(d) = undefinedFn]) {
  var args = [string];
  if (accessor != undefinedFn) {
    args.add(accessor);
  }
  return _csv.callMethod('parse', args);
}

/// Parse a CSV string into tuples, ignoring the header row.
List<List> parseRows(String string, [accessor(d) = undefinedFn]) {
  var args = [string];
  if (accessor != undefinedFn) {
    args.add(accessor);
  }
  return _csv.callMethod('parseRows', args);
}

/// Format an array of objects into a CSV string.
String format(List rows) {
  return _csv.callMethod('format', [rows]);
}

/// Format an array of tuples into a CSV string.
String formatRows(List<List> rows) {
  return _csv.callMethod('formatRows', [rows]);
}
