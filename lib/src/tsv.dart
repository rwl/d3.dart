library d3.src.tsv;

import 'dart:js';
import 'd3.dart';

JsObject _d3 = context['d3'];
JsObject _tsv = context['d3']['tsv'];

/// Request a tab-separated values (TSV) file.
tsv(String url, [accessor(d) = undefinedFn, callback(rows) = undefinedFn]) {
  var args = [url];
  if (accessor != undefinedFn) {
    args.add(accessor);
  }
  if (callback != undefinedFn) {
    args.add(callback);
  }
  return _d3.callMethod('tsv', args);
}

/// Parse a TSV string into objects using the header row.
List parse(String string, [accessor(d) = undefinedFn]) {
  var args = [string];
  if (accessor != undefinedFn) {
    args.add(accessor);
  }
  return _tsv.callMethod('parse', args);
}

/// Parse a TSV string into tuples, ignoring the header row.
List<List> parseRows(String string, [accessor(d) = undefinedFn]) {
  var args = [string];
  if (accessor != undefinedFn) {
    args.add(accessor);
  }
  return _tsv.callMethod('parseRows', args);
}

/// Format an array of objects into a TSV string.
String format(List rows) {
  return _tsv.callMethod('format', [rows]);
}

/// Format an array of tuples into a TSV string.
String formatRows(List<List> rows) {
  return _tsv.callMethod('formatRows', [rows]);
}
