library d3.src.tsv;

import 'dart:js';

JsObject _d3 = context['d3'];
JsObject _tsv = context['d3']['tsv'];

/// Request a tab-separated values (TSV) file.
tsv(url, [accessor, callback]) {
  return _d3.callMethod('tsv', []);
}

/// Parse a TSV string into objects using the header row.
parse(string, [accessor]) {
  return _tsv.callMethod('parse', []);
}

/// Parse a TSV string into tuples, ignoring the header row.
parseRows(string, [accessor]) {
  return _tsv.callMethod('parseRows', []);
}

/// Format an array of objects into a TSV string.
format(rows) {
  return _tsv.callMethod('format', []);
}

/// Format an array of tuples into a TSV string.
formatRows(rows) {
  return _tsv.callMethod('formatRows', []);
}
