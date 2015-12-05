library d3.src.csv;

import 'dart:js';

JsObject _d3 = context['d3'];
JsObject _csv = context['d3']['csv'];

/// Request a comma-separated values (CSV) file.
csv(url, [accessor, callback]) {
  return _d3.callMethod('csv', []);
}

/// Parse a CSV string into objects using the header row.
parse(string, [accessor]) {
  return _csv.callMethod('parse', []);
}

/// Parse a CSV string into tuples, ignoring the header row.
parseRows(string, [accessor]) {
  return _csv.callMethod('parseRows', []);
}

/// Format an array of objects into a CSV string.
format(rows) {
  return _csv.callMethod('format', []);
}

/// Format an array of tuples into a CSV string.
formatRows(rows) {
  return _csv.callMethod('formatRows', []);
}
