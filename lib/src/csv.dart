@JS('d3')
library d3.src.csv;

import 'package:js/js.dart';

/// Request a comma-separated values (CSV) file.
external csv(url, [accessor, callback]);

/// Parse a CSV string into objects using the header row.
@JS('d3.csv.parse')
external parse(string, [accessor]);

/// Parse a CSV string into tuples, ignoring the header row.
@JS('d3.csv.parseRows')
external parseRows(string, [accessor]);

/// Format an array of objects into a CSV string.
@JS('d3.csv.format')
external format(rows);

/// Format an array of tuples into a CSV string.
@JS('d3.csv.formatRows')
external formatRows(rows);
